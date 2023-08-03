Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA7476F7B3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjHDCTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbjHDCTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:19:20 -0400
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Aug 2023 19:19:01 PDT
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27954693;
        Thu,  3 Aug 2023 19:19:00 -0700 (PDT)
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
        by cmsmtp with ESMTP
        id RZovqpde2ez0CRkNNqLvSx; Fri, 04 Aug 2023 02:17:13 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id RkNWqtNX3oJVZRkNWqhgI7; Fri, 04 Aug 2023 02:17:23 +0000
X-Authority-Analysis: v=2.4 cv=NYv1akP4 c=1 sm=1 tr=0 ts=64cc5fb3
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10
 a=tol29vsN1OLT31ZSaBYA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=F9nOKX0hEGWHj8UA4io7ZlSw81iWLwNsWXyvBzUZN04=; b=ltEXshd0mddUmFJZ390jyei7o5
        h8etGpxRmAAl89Itm6pxwAv7QUYdiBDoI7GjeP1d41MttYgojd+ui54M3hJ2t1tdaijDJD3N9q9WZ
        8KH9vp4xVtg4LYVKldvgrtPX71cTJXbwBVzPYVTG4k/xL92MwEOHCyZqW0351/Js6K1ItnS4LjsJd
        f1xQ2MOU7e7cgjd41r9OSn0Tx6ySTkfFGIceV3zakxGT3SqGDaw126QCoLRPwzbToCfKtRBzMg+ms
        +cRtw6ClXkcA7iFhVfUB1JeMVrn/2+Y29oOuyEXkVORkg4tx+yY1DCFTpd2m+hPA+mER0lhlPNcEM
        lk4AeUtg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:49328 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qReV7-001ypG-0M;
        Thu, 03 Aug 2023 15:00:49 -0500
Message-ID: <841d4728-d62d-7767-1484-5a85f0776215@embeddedor.com>
Date:   Thu, 3 Aug 2023 14:01:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] cpufreq: brcmstb-avs-cpufreq: Fix -Warray-bounds bug
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <ZMh45KH2iPIpNktr@work>
 <66e19ae3-253d-5377-5cc2-566ec3cfed49@broadcom.com>
 <20230803055607.ueliy6eofvhoy4gw@vireshk-i7>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230803055607.ueliy6eofvhoy4gw@vireshk-i7>
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
X-Exim-ID: 1qReV7-001ypG-0M
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:49328
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAi4zevk/uxQeOxyNRwcLAtfdT43/qBKFkmxlHSDPY5SW1qtvuOZoEYrYzV5zzzRCmz1z7A6i5DThnluLkCMcliWALVkPHZanIxGHMOoLkI1nmy1JA5H
 LkjH1PhAv3ZLp1wsDIMl2wVBzzaElshErW6SOK2ZCIqz/QE3ys38rgdsBPKm7lGpoVZBg7+S+pe8ELgf0kv3hGMK5gNC6VMiYu6FXCKtrrkRpaE3OdvJZOpj
 y/q/jRmXvKGk3OOZ8qu8QMj82/TfRvaq8Pn+2g6Re+YHXqTCpUz93TRVWgpVmekL44a2d37j9UMBatr6N0FeSg==
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/23 23:56, Viresh Kumar wrote:

> 
> Applied. Thanks.
> 

Great. :)

Thank you
--
Gustavo
