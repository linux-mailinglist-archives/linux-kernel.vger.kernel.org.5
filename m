Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5421807A49
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379749AbjLFVXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379747AbjLFVXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:23:31 -0500
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADF2D69
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 13:23:35 -0800 (PST)
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
        by cmsmtp with ESMTPS
        id AwVGr9wTjWcCIAzMlrxgoX; Wed, 06 Dec 2023 21:23:35 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id AzMkrVCh81b9NAzMkr4xE5; Wed, 06 Dec 2023 21:23:34 +0000
X-Authority-Analysis: v=2.4 cv=FLYIesks c=1 sm=1 tr=0 ts=6570e656
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=c601a17RXwP2wWhsnozrzA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=e2cXIFwxEfEA:10 a=wYkD_t78qR0A:10 a=COk6AnOGAAAA:8
 a=VwQbUJbxAAAA:8 a=_Wotqz80AAAA:8 a=cm27Pg_UAAAA:8 a=jzDRcfw_wAzovSFxW3EA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22 a=AjGcO6oz07-iQ99wixmX:22
 a=buJP51TR1BpY-zbLSsyS:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Z89JbXvFtxvpHgG4/D9TvUPfBOX7E1w1eYXh8GBdDDg=; b=wK+2HNzmisO4AOviFMz6pFLxZv
        x5za6lFwlYdRe0LTXGbkDAoy3uHP03x6WQMPjzUArkHQFU0vlSa6f/cgkDrqkorNWDTOpgZxxd+MO
        aUwSlLvSKv0H1BHTwaeTW1BK5/af50yVTOUPQDZasXrXtsFAG4ayPBekTLlXaNli0XkKUpza0ds06
        WxHbLiW5h7IWvo/jp4EZtKYuz3ms8ahCOG1qbgcxMw9qJNJFw1UjIGgFs/DqHUtanU/5NSiBPVc5z
        bv4cLz47JSY4+1cxw4iAmoyny7Ppr5MGLGoP2cfmQsOAccFpbBJAL4369hZ5kQZ7kperBj30ANg9n
        nIfaBQQw==;
Received: from 187.184.159.186.cable.dyn.cableonline.com.mx ([187.184.159.186]:15648 helo=[192.168.0.10])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1rAzMj-002Gl6-1K;
        Wed, 06 Dec 2023 15:23:33 -0600
Message-ID: <69be3198-16f1-45ec-8262-1ed269f1f6ea@embeddedor.com>
Date:   Wed, 6 Dec 2023 15:23:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: Fix ath11k_htc_record flexible record
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231205-flexarray-htc_record-v2-1-fbb56d436951@quicinc.com>
 <202312061254.085B4755@keescook>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202312061254.085B4755@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.159.186
X-Source-L: No
X-Exim-ID: 1rAzMj-002Gl6-1K
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.159.186.cable.dyn.cableonline.com.mx ([192.168.0.10]) [187.184.159.186]:15648
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfC2h6vt5FaslSdRvBtZFd9lpCf1EoYWg4IkpRrnTilLVgyxCq03tjshF0bGakb3CwsbHORMvkQ63d20OO7rqOrcn5YJLVTUdfQjudIE66Oc5aDi/eImE
 4di2e5bzM+zwa0v3QMM0h9wAsVUWHxg6JlFIvZuitUCXZWen7CY3eTAtdQ/feYovDx9v6O4YOoEPWjAL/IHD44X6eJkZhDmqZzZpkgYRD4Gfgf0oXzJ2Rv0k
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/23 14:55, Kees Cook wrote:
> On Tue, Dec 05, 2023 at 01:00:17PM -0800, Jeff Johnson wrote:
>> Transform the zero-length ath11k_htc_record::credit_report array into
>> a proper flexible array. Since this is the only array in
>> ath11k_htc_record, remove the unnecessary union.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> Heh, looks good. I wonder why this was a union to begin with?

It used to contain a couple of members:

https://lore.kernel.org/linux-wireless/20231127-flexarray-htc_record-v1-3-6be1f36126fd@quicinc.com/
https://lore.kernel.org/linux-wireless/4f2a486c-c6de-43e4-8bb6-bdd3f819b0a9@embeddedor.com/

--
Gustavo

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
