Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534D37C622F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 03:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376715AbjJLBWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 21:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376685AbjJLBWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 21:22:16 -0400
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9051FA9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 18:22:11 -0700 (PDT)
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
        by cmsmtp with ESMTP
        id qiZ4qgKU6aLCxqkOwqT3uM; Thu, 12 Oct 2023 01:22:10 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id qkOvqt42tivKvqkOvq2ixQ; Thu, 12 Oct 2023 01:22:09 +0000
X-Authority-Analysis: v=2.4 cv=R8oQpPdX c=1 sm=1 tr=0 ts=65274a41
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=cm27Pg_UAAAA:8 a=WnryGa_Bw3uqbxbGEfEA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=b/Ri9TTVOB6UxuqCr+Rmo7sughv+F4Vm5vVN8huJWtE=; b=DXD98zbMQV5VtpbBxTMbCf0RZ+
        pD4R2exVPH+BIP8JGnv899PEL8XG9Z1/13vhNjuee7lMz5KComzw51imPhdw4U5rfP6csEHrGj78U
        21KcXdQABkb13aDXe1ffkgSn5HD491hmCtwexGG1U0qMs84Xbs97sLIeTeslUa17ydfTIht6bnT3i
        Go92GgZsxC2qQ/6WKTwgY0fOcB21a9mJx9BN+GsHu+lYaJ/B574o1ERnmsqGFNai9ZfZAWQhghpsj
        DSyzowkOOW0yWWC8ps0LLRTdzN6Q+8AHiKUTN7WDujTLS+v4WVYX+iVI94Sm1Ftzt12dHjb5xCmbK
        HDAnIckA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:37884 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.1)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qqkOu-003PfN-2b;
        Wed, 11 Oct 2023 20:22:08 -0500
Message-ID: <6779218a-3084-49fb-9f19-1c8d611c235c@embeddedor.com>
Date:   Wed, 11 Oct 2023 19:22:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2][next] clk: socfpga: agilex: Add bounds-checking
 coverage for struct stratix10_clock_data
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <cover.1697059539.git.gustavoars@kernel.org>
 <fd4cd8503316d536e1a84fa2ae5bdefdd4b24afe.1697059539.git.gustavoars@kernel.org>
 <202310111439.35CB04432F@keescook>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202310111439.35CB04432F@keescook>
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
X-Exim-ID: 1qqkOu-003PfN-2b
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.7]) [187.162.21.192]:37884
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHjMlgFhi7N+a21IGpNlXnsalYa3Kpn+CMzWwTXQ0mx42W3HUJa+CooF0hxOvGkxHppFsjfQ/nE1udAmD2Ggp71hJdOooW5LuVQ6tz3B0rsWn/zseGOV
 MSa1OQcsdcWYsKYXF3EXlGpb0yP9Xwt/rE5BHYc4IvKNmMAFY46VlXDTvPqIjcCzvL1UfJUlLpXNL0ao4yNW/ViEOKapfWnZnipJis3VaG0fwleuXIJgLfJU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




>> Hence, we need to move the assignments to `clk_data->clk_data.num` after
>> allocations for `struct stratix10_clock_data` and before accessing the
>> flexible array `clk_data->clk_data.hws`. And, as assignments for both
>> `clk_data->clk_data.num` and `clk_data->base` are originally adjacent to
>> each other, relocate both assignments together.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Yeah, ew. That's super tricky. Nice find.

Indeed. D:

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>


Thanks!
--
Gustavo

