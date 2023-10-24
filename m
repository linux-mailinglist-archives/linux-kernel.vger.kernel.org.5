Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C23B7D45B0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbjJXCsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjJXCsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:48:10 -0400
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A384110C0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 19:48:04 -0700 (PDT)
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
        by cmsmtp with ESMTPS
        id v0QHqOm7L8Htev7SeqTcJ6; Tue, 24 Oct 2023 02:48:04 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id v7SdqGI41Zs8Wv7Sdqp7xm; Tue, 24 Oct 2023 02:48:03 +0000
X-Authority-Analysis: v=2.4 cv=YKGMdDKx c=1 sm=1 tr=0 ts=65373063
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=cm27Pg_UAAAA:8 a=bPvv9e5oV8VUxCXHTe8A:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=t7CKU1w7OpaYK3Ge0/xhJSHPnQiYEEShMZbsXXGJ+VQ=; b=giuEr0GKXviQ84F1K4DT8KjCBk
        JOLBlGXvyuL2n8jvzvfiG6WWNoiT3uOavQzkTuyrE02belY2H1q1dBfQQy8goumLbGznCRUWWmx54
        3rTEeTFDuuWjFvQ1VBbbmsvprjYT9YoR6VBXCCgTLiGx5IuYW3Gd6Er/pd/tfYwzLA2jOg8dMB0uA
        RwNkAgoc0HMyGKfMUUrHjNjpoc5rDggD9GAVaH2UfsRXvSaJtfw0CRo2iCWpPN8IaNarmwRTp1kf7
        i45MHoio39R7hqLmRJ8C/6gZwldh9ofq2dtBVewixPZFxEMhh1UQ3R1E4YhRa0Ic0PeJ25L8s9kwP
        7KrqgGeA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:43030 helo=[192.168.15.10])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qv7Sc-002x6h-0e;
        Mon, 23 Oct 2023 21:48:02 -0500
Message-ID: <21b1ebbe-2bef-4f56-a4d6-3ed898a1e953@embeddedor.com>
Date:   Mon, 23 Oct 2023 20:48:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2][next] clk: visconti: Fix undefined behavior bug in
 struct visconti_pll_provider
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Kees Cook <keescook@chromium.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <cover.1697492890.git.gustavoars@kernel.org>
 <57a831d94ee2b3889b11525d4ad500356f89576f.1697492890.git.gustavoars@kernel.org>
 <9ebe2372491a76253e5597086d059b1d.sboyd@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <9ebe2372491a76253e5597086d059b1d.sboyd@kernel.org>
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
X-Exim-ID: 1qv7Sc-002x6h-0e
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:43030
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDU8crjYM2vX4Q1QW4n3eIRTmIz1F6lXh0E34D8jjjvg+KdqUA9G6w9ukBbuKcJKEhc5iQFyoWp1s53s4Crnbma73rxT9bBcGIgy5XBo1HTFvBtxuf0w
 ypP93/CQMJYl4DO1NdwSXGYdpQLb4qDd1Od4zT5I778/oedB3CkoNVNKj656amPISgChhFjYkzHVkSnmqCXe/Jbpyl0VOWE1vRA5y6lUydVQWGInejafgH3F
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Fixes: b4cbe606dc36 ("clk: visconti: Add support common clock driver and reset driver")
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Acked-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
> 
> Applied to clk-next

Hi!

Here is another similar small series, in case you missed it:

https://lore.kernel.org/linux-hardening/cover.1697493574.git.gustavoars@kernel.org/

Thanks
--
Gustavo
