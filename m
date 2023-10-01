Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EF77B45AA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 08:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbjJAGhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 02:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbjJAGhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 02:37:17 -0400
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60401D9
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 23:37:15 -0700 (PDT)
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
        by cmsmtp with ESMTP
        id mm5gqFeDEIBlVmq4Pqir71; Sun, 01 Oct 2023 06:36:49 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id mq4oqAEU7Poqfmq4oqulxY; Sun, 01 Oct 2023 06:37:14 +0000
X-Authority-Analysis: v=2.4 cv=BbLLb5h2 c=1 sm=1 tr=0 ts=6519139a
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=AGRr4plBAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=cm27Pg_UAAAA:8 a=mPYTGMt3QxH6nEoWC7IA:9 a=QEXdDO2ut3YA:10
 a=bOnWt3ThIoLzEnqt84vq:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=AjGcO6oz07-iQ99wixmX:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=g5MdlvfGn5PBnddiBG+HppV2yyn6X8aIPOkd1eWAi/E=; b=gc/CvdPXluVMA4b22ec4rdThNR
        kTNLg06RI1qYPqDnrh1UtGQElDVx45pBTFIZ3n5GRQln0A5xPVLExDC59KLfFdAqWia5GxXjpv9t/
        BUK7YuNgUOUEKL4e+cY03oYk6B8FpuCe+7kWqxDbXfqTXDk55+H0BaPUGSuv+Knt9EzsZeOIWYEDF
        m0DZdP4yBTpCkuEwKa1mCMdEw0g5kLpKYQJ36y0qK18g3gaZGcyrNEyAdzQjZLmMmxQc68wu0QBT/
        kiUt0BjaNO8zrfJZX2tj4KbueCc54t6KjmvSo9tJPg2KRViirUK7lx8VxfAFT5f1HRXv5jwyPzJjs
        ftXbe+zw==;
Received: from [94.239.20.48] (port=37250 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qmq4m-001KXe-27;
        Sun, 01 Oct 2023 01:37:12 -0500
Message-ID: <0e75f94b-0322-cca4-d720-efc784b385e8@embeddedor.com>
Date:   Sun, 1 Oct 2023 08:37:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5/5] cxgb4: Annotate struct smt_data with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Raju Rangoju <rajur@chelsio.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
References: <20230929181042.work.990-kees@kernel.org>
 <20230929181149.3006432-5-keescook@chromium.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230929181149.3006432-5-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.239.20.48
X-Source-L: No
X-Exim-ID: 1qmq4m-001KXe-27
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:37250
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 59
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfC/JYUuoFlIkHi3pbrOpHLaOn0WTu9EAvz8/Gx4wCqzeFDyp3GgdYGG0OyCxd09iB++vvZeJJY/KBYftnQoI7ZVqidqPSm+Xyx+IsZ86vDfD8Mp/UdBv
 d7qxyHXWYklLGrO2tHWwjoSKCfW1nVoT+17P8zxPXfd+EJ5DBv7GBAkMibFbGNmAjSBx31fKZlP37ikMrsEXSeMyy3Q/vIRynlNkhfYhgbmYZgXc1MgbzM3K
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/23 20:11, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct smt_data.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Raju Rangoju <rajur@chelsio.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   drivers/net/ethernet/chelsio/cxgb4/smt.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/smt.h b/drivers/net/ethernet/chelsio/cxgb4/smt.h
> index 541249d78914..109c1dff563a 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/smt.h
> +++ b/drivers/net/ethernet/chelsio/cxgb4/smt.h
> @@ -66,7 +66,7 @@ struct smt_entry {
>   struct smt_data {
>   	unsigned int smt_size;
>   	rwlock_t lock;
> -	struct smt_entry smtab[];
> +	struct smt_entry smtab[] __counted_by(smt_size);
>   };
>   
>   struct smt_data *t4_init_smt(void);
