Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1740801D37
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 15:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjLBOHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 09:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbjLBOHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 09:07:19 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48DB11A;
        Sat,  2 Dec 2023 06:07:25 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77896da2118so200052885a.1;
        Sat, 02 Dec 2023 06:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701526045; x=1702130845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44TZ5lUUBe5HgsNEpboGG9J+wNR8fakmEx7zau6A1ho=;
        b=O7JMo7QbC8aun3qw9Q5Lce3NovMk5idVcBrAYsACTC8e56G40ksqCAm22idcEFm44S
         5FBZw6aLPdfzUpieliMpGDSynNkGUqEYouYPYhVtaMQPTrSbBD/oTWRWh0zl3CwlYsbz
         puWHDzjMRQVrMha2ay5bNuQSWyioa2c2MnvQZgMrnfw+xDC0s/VJ5t16oWVY/crf+O/J
         dOlpf8aEaB5/mzky2zFR3380PTU5V8w5l+DP4j6LWu1liVutjPP1zjFYNo27jwEJlRhO
         odOibGm8725+Ldxir4+Yd1apIQ4KHsSB1rHt4Q9PSlbc0etiHa3dOkjKbu8owcULkvq2
         dXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701526045; x=1702130845;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=44TZ5lUUBe5HgsNEpboGG9J+wNR8fakmEx7zau6A1ho=;
        b=dFwURV5FuQCfUjoYm3dNk9HEP421mjxaaAr2WRYC/JKOUqOkx7FxAGrxxg9Htrw2IK
         L9Qu75Ac0zNpnJ2fjagQj4MCeJ5+bsTVyuDL/g2+qj58B3cFeIoIWWvcNGglDPraXWwg
         bfMgEvAoM5/naLMws6EQxRuJeP+vp10zhVYR4cAN7CVWlBTOUM4Uh82VwN90O8UYL6l4
         Xjm0Hm9ljY2Lf6zilmsSNAeSO6LHeyfgZKZm9ocIvOzuDl+2uFLkAltJxy7Gm8Bz+PeB
         mx9orJdubutBfmTI0EQG0Z611VdEuKI401BzWkmbbnZn8si85kAYUkJkW1J2UI492pIw
         ei0w==
X-Gm-Message-State: AOJu0Yxv2wsK2XYokW3qmK6VgaDM/AJ36rN4vfyj2l8/iGLUqW6TClOn
        fHlTRXIugO0Q1aRFe1S6gnw=
X-Google-Smtp-Source: AGHT+IHOis1oB8wA+cZjSItfdkBH6Krq3yUI0y+HQHd6UxV2/LdQSYh8eD8JSsnX4zKRAvvqUTSWpg==
X-Received: by 2002:a05:620a:f8c:b0:775:6726:7e77 with SMTP id b12-20020a05620a0f8c00b0077567267e77mr1066344qkn.10.1701526044751;
        Sat, 02 Dec 2023 06:07:24 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id l1-20020a05620a28c100b0077d85b1d45dsm2440852qkp.72.2023.12.02.06.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 06:07:24 -0800 (PST)
Date:   Sat, 02 Dec 2023 09:07:23 -0500
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Weongyo Jeong <weongyo.linux@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Jesper Brouer <jesper@cloudflare.com>
Message-ID: <656b3a1bcd212_1a6a2c294db@willemb.c.googlers.com.notmuch>
In-Reply-To: <ZWomqO8m4vVcW+ro@debian.debian>
References: <ZWomqO8m4vVcW+ro@debian.debian>
Subject: Re: [PATCH v3 net-next] packet: add a generic drop reason for receive
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yan Zhai wrote:
> Commit da37845fdce2 ("packet: uses kfree_skb() for errors.") switches
> from consume_skb to kfree_skb to improve error handling. However, this
> could bring a lot of noises when we monitor real packet drops in
> kfree_skb[1], because in tpacket_rcv or packet_rcv only packet clones
> can be freed, not actual packets.
> 
> Adding a generic drop reason to allow distinguish these "clone drops".
> 
> [1]: https://lore.kernel.org/netdev/CABWYdi00L+O30Q=Zah28QwZ_5RU-xcxLFUK2Zj08A8MrLk9jzg@mail.gmail.com/
> Fixes: da37845fdce2 ("packet: uses kfree_skb() for errors.")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---
> v2->v3: removed an unused variable
> v1->v2: fixups suggested by Eric Dumazet
> v2: https://lore.kernel.org/netdev/ZWobMUp22oTpP3FW@debian.debian/
> v1: https://lore.kernel.org/netdev/ZU3EZKQ3dyLE6T8z@debian.debian/
> ---
>  include/net/dropreason-core.h |  6 ++++++
>  net/packet/af_packet.c        | 26 +++++++++++++-------------
>  2 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> index 3c70ad53a49c..278e4c7d465c 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -86,6 +86,7 @@
>  	FN(IPV6_NDISC_NS_OTHERHOST)	\
>  	FN(QUEUE_PURGE)			\
>  	FN(TC_ERROR)			\
> +	FN(PACKET_SOCK_ERROR)		\
>  	FNe(MAX)
>  
>  /**
> @@ -378,6 +379,11 @@ enum skb_drop_reason {
>  	SKB_DROP_REASON_QUEUE_PURGE,
>  	/** @SKB_DROP_REASON_TC_ERROR: generic internal tc error. */
>  	SKB_DROP_REASON_TC_ERROR,
> +	/**
> +	 * @SKB_DROP_REASON_PACKET_SOCK_ERROR: generic packet socket errors
> +	 * after its filter matches an incoming packet.
> +	 */
> +	SKB_DROP_REASON_PACKET_SOCK_ERROR,
>  	/**
>  	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
>  	 * shouldn't be used as a real 'reason' - only for tracing code gen
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index a84e00b5904b..933fdfaacc44 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2127,7 +2127,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
>  	u8 *skb_head = skb->data;
>  	int skb_len = skb->len;
>  	unsigned int snaplen, res;
> -	bool is_drop_n_account = false;
> +	enum skb_drop_reason drop_reason = SKB_CONSUMED;

Reverse xmas tree

>  
>  	if (skb->pkt_type == PACKET_LOOPBACK)
>  		goto drop;
> @@ -2161,6 +2161,10 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
>  	res = run_filter(skb, sk, snaplen);
>  	if (!res)
>  		goto drop_n_restore;
> +
> +	/* skb will only be "consumed" not "dropped" before this */
> +	drop_reason = SKB_DROP_REASON_PACKET_SOCK_ERROR;
> +

This can be set in drop_n_account, rather than the common path.

Same in tpacket_rcv.
