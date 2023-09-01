Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4DA78F7C3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 07:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbjIAFAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 01:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243705AbjIAFAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 01:00:03 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FF1E7C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 21:59:59 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id bwGBqGDKD7HAObwGBqnc61; Fri, 01 Sep 2023 06:59:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693544397;
        bh=tv6B7Fos2siGTtUU4mG/KuNAe/GWDCgVkJ/VsTHCG7M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=HmBpTMjKbHox0amol/pxmlk8yX8lwqZPFvDcxNt9aA1ulkmt4fsL788UCbxgxwa5r
         UbVitixu7ZMfs8WwkFY+Som0NqzBU3DNdthWNkGG7M6ZUxzePYV3n/qOZ/D3ccNYop
         YUJhUbhM4zz2A97BmZhQQ1KDatoiETeIDYTlAsv8nApTBvJAPmr3TFf2P65mHQGUC0
         wu0bQL2Cll1o9luByjPLxvFTpM47CstgJCZwkHKlTTyDMbcDh+leV731TIbjEmiRTk
         TAW5msQdQWjxTy5jsiuwY4Lh9/jZHNNCrln95KbpB9YatqY0Si78bKUwIZCO3+L1GB
         iAOpuhfmjoSrw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 01 Sep 2023 06:59:57 +0200
X-ME-IP: 86.243.2.178
Message-ID: <58b1e635-f31a-8c76-b704-a707bd11d460@wanadoo.fr>
Date:   Fri, 1 Sep 2023 06:59:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_ceph/decode=3a_Remove_unnecessary_?=
 =?UTF-8?B?4oCYMOKAmSB2YWx1ZXMgZnJvbSByZXQ=?=
To:     Li kunyu <kunyu@nfschina.com>, idryomov@gmail.com,
        xiubli@redhat.com, jlayton@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     ceph-devel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230902201112.4401-1-kunyu__5722.10796396888$1693539625$gmane$org@nfschina.com>
Content-Language: fr, en-GB
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230902201112.4401-1-kunyu__5722.10796396888$1693539625$gmane$org@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 01/09/2023 à 05:40, Li kunyu a écrit :
> ret is assigned first, so it does not need to initialize the
> assignment.
> Bad is not used and can be removed.
> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>   net/ceph/decode.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ceph/decode.c b/net/ceph/decode.c
> index bc109a1a4616..9f5f095d8235 100644
> --- a/net/ceph/decode.c
> +++ b/net/ceph/decode.c
> @@ -50,7 +50,7 @@ static int
>   ceph_decode_entity_addr_legacy(void **p, void *end,
>   			       struct ceph_entity_addr *addr)
>   {
> -	int ret = -EINVAL;
> +	int ret = 0;
>   
>   	/* Skip rest of type field */
>   	ceph_decode_skip_n(p, end, 3, bad);
> @@ -66,8 +66,7 @@ ceph_decode_entity_addr_legacy(void **p, void *end,
>   			      sizeof(addr->in_addr), bad);
>   	addr->in_addr.ss_family =
>   			be16_to_cpu((__force __be16)addr->in_addr.ss_family);
> -	ret = 0;
> -bad:
> +
>   	return ret;
>   }
>   

This patch is wrong.
Look how the ceph_decode_skip_n() macro, for example, is expended.
You'll see that 'bad' is needed.

I think that your patch was not compile tested.

Please do not send patch that are not at least compile tested. Even when 
it looks obvious.

CJ
