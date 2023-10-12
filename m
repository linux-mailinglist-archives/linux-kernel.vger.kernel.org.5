Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612E97C6231
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 03:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbjJLBWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 21:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbjJLBWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 21:22:49 -0400
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE32A9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 18:22:48 -0700 (PDT)
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
        by cmsmtp with ESMTP
        id qcDFqQT41ytxcqkPYqQm9y; Thu, 12 Oct 2023 01:22:48 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id qkPWqfbtLYzUPqkPXqEbdF; Thu, 12 Oct 2023 01:22:47 +0000
X-Authority-Analysis: v=2.4 cv=St2DVdC0 c=1 sm=1 tr=0 ts=65274a67
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=cm27Pg_UAAAA:8 a=mGr3e_0Gbe7lDU3fz68A:9 a=QEXdDO2ut3YA:10 a=jV56Vji_GFUA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=d6OvVPeBTsOJjUr7F9qF5Dit3itsHTv3Ro6bkvwY6sY=; b=voqti2phSibUEn844PvdHGZaMt
        E5P1aCedm15ujhCxFowQJ3tgX3+DzMHmzzX/DASaFVg0bh15/DIRtGvLRflAiDBGGMUvelJx81HWe
        rMl5jWW8jlW6aINDg4kDPfJzesF0QVkeArRcEnc7ZLdhLHIbgvyCHcLIinzSFieMve6CcOmOLaxvA
        mK6HGwjACunlB7X2qmAF9RfsUBomiW/Tjmn5/Az0nf1gn75IZj1gWQaFqWa4eyInRsUjxIJvi8ldS
        1AcqAKmeY3wY6JuuqXlfYHz57nMpjQhK4yGiywPvMmLikIw84dJ5nrfGX6uivEnAnhPeXfQNPEsEr
        lih393rw==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:37884 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.1)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qqkPW-003PfN-18;
        Wed, 11 Oct 2023 20:22:46 -0500
Message-ID: <4eae9ce0-177b-4c47-8116-fe1fcf3d9d0f@embeddedor.com>
Date:   Wed, 11 Oct 2023 19:22:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2][next] clk: socfpga: Fix undefined behavior bug in
 struct stratix10_clock_data
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <cover.1697059539.git.gustavoars@kernel.org>
 <5dd8483177dc8cd91d021170b6717f2e570bab03.1697059539.git.gustavoars@kernel.org>
 <202310111438.2D0168C@keescook>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202310111438.2D0168C@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qqkPW-003PfN-18
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.7]) [187.162.21.192]:37884
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBncu8Gfea9rZbSAI1mYOdrS79IAKOZnWOJToTrpVoNBBDrLaNyrngUGpQgGtWy0CN3EBkrPWqpLNpJkCUHMHuObOWtGllb9m4PiLjbHvHHUvzwg+QIF
 pTCzojVswYy6Pktbp+sNfaaFr9P9fcki1UNLyDI2sfb2Uc8fWgYYNv+HvkdJWOk7lDOdxCvMcRuXyBFwjJe3B11vxhrt9n6CyQLeTxPkumfS+oWGp3ZbN5ta
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Fixes: ba7e258425ac ("clk: socfpga: Convert to s10/agilex/n5x to use clk_hw")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Nice find!

:D

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

Thanks!
--
Gustavo
