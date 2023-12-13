Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4262F810BA7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 08:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378672AbjLMHkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 02:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbjLMHkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 02:40:14 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312F39B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 23:40:20 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c1e3ea2f2so65455515e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 23:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702453218; x=1703058018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ohbTv7N8IBgSQDfoA8zt810Sv8vFOgNDA66r3vbXTsA=;
        b=gBwfHdv6UwP/qMnO6ZJOhqFgZC6vTlKJPPH2AKwmlWeci0cg+uI+1qQd4bRrv6VdHX
         IpsL3QcALdxovXiH/Tt/1eqDzbGlbrk5A+5noGFsm+P8wtHWsRQX0FBiaqKHoB5JgqcM
         d8zRXZynriswl9GNc2at+KyAmtPm6WiMtyQlFSaq4h7oxspVXUj8oe8NFkKojP4Euzd+
         B8Fjs3/4Pgfqahp0+d5vWvZ0aVGjda9E29I6KkvRkEHqe8RbPmhr3xWoRBTd+xDS0jys
         2cAhyiZw60mfEDaz1A3Wm85SNziLog2rjOOirznrUzNxIYa4q/NgTEXrCn5oP2vXrY5L
         +L3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702453218; x=1703058018;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ohbTv7N8IBgSQDfoA8zt810Sv8vFOgNDA66r3vbXTsA=;
        b=uVleWsI7zqdmTIxmHU04aVXzAEndi+PXHKOq9AK/Rg6w5Sb+SyV7wirzWypanVnX70
         J/aFu6WsNFzd65U/fJhQ2EelCtJ0ZEcj5dIAqws0jQYsyYG4T9IrsrZ8rOwDB31E7s/+
         5itqU//aCvHh3XfRTypvbvIvjxyrlztGQnynUgdM0UEpeWzLFVLdtKdVkVLhHGSEtjuJ
         QKi+BcxWrBTtInfgndDMAg57AWBwZybk2HSSObwewO63MvlHy00q/NuiU24lj75IFUUh
         xvQ1zKIg5KkLMC+rUUGhuM/Uxc0R9fvygiI0DYeGJFbFChNfSawNImhKQ6E4LjcNGo7B
         VKdA==
X-Gm-Message-State: AOJu0YwKfeBJzlyFfOqh+2RYmb16r3gZeOR+DEyzMJSd/9SQOCEipx33
        6OiZxI6tDDbmssSN0thWkWJXpg==
X-Google-Smtp-Source: AGHT+IF6s2cTa+Lk2GrNTmyRn0J97TvRbNsB4rmkb50ZEF24BoMWh/6sbS+i/n0xIyucUslys9ED3w==
X-Received: by 2002:a05:600c:6020:b0:40c:1e00:cfcc with SMTP id az32-20020a05600c602000b0040c1e00cfccmr4187542wmb.97.1702453218575;
        Tue, 12 Dec 2023 23:40:18 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id l12-20020a05600c4f0c00b0040b4b2a15ebsm19317297wmq.28.2023.12.12.23.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 23:40:18 -0800 (PST)
Message-ID: <1813902b-6afc-4539-96b2-050df6fc75c1@linaro.org>
Date:   Wed, 13 Dec 2023 08:40:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/2] nfc: llcp_core: Hold a ref to
 llcp_local->dev when holding a ref to llcp_local
Content-Language: en-US
To:     Siddh Raman Pant <code@siddh.me>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Suman Ghosh <sumang@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
References: <cover.1702404519.git.code@siddh.me>
 <6a26e3b65817bb31cb11c8dde5b1b420071d944e.1702404519.git.code@siddh.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <6a26e3b65817bb31cb11c8dde5b1b420071d944e.1702404519.git.code@siddh.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2023 19:49, Siddh Raman Pant wrote:
> llcp_sock_sendmsg() calls nfc_llcp_send_ui_frame() which in turn calls
> nfc_alloc_send_skb(), which accesses the nfc_dev from the llcp_sock for
> getting the headroom and tailroom needed for skb allocation.
> 
> Parallelly the nfc_dev can be freed, as the refcount is decreased via
> nfc_free_device(), leading to a UAF reported by Syzkaller, which can
> be summarized as follows:
> 
> (1) llcp_sock_sendmsg() -> nfc_llcp_send_ui_frame()
> 	-> nfc_alloc_send_skb() -> Dereference *nfc_dev
> (2) virtual_ncidev_close() -> nci_free_device() -> nfc_free_device()
> 	-> put_device() -> nfc_release() -> Free *nfc_dev
> 
> When a reference to llcp_local is acquired, we do not acquire the same
> for the nfc_dev. This leads to freeing even when the llcp_local is in
> use, and this is the case with the UAF described above too.
> 
> Thus, when we acquire a reference to llcp_local, we should acquire a
> reference to nfc_dev, and release the references appropriately later.
> 
> References for llcp_local is initialized in nfc_llcp_register_device()
> (which is called by nfc_register_device()). Thus, we should acquire a
> reference to nfc_dev there.
> 
> nfc_unregister_device() calls nfc_llcp_unregister_device() which in
> turn calls nfc_llcp_local_put(). Thus, the reference to nfc_dev is
> appropriately released later.
> 
> Reported-and-tested-by: syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
> Fixes: c7aa12252f51 ("NFC: Take a reference on the LLCP local pointer when creating a socket")
> Reviewed-by: Suman Ghosh <sumang@marvell.com>
> Signed-off-by: Siddh Raman Pant <code@siddh.me>
> ---
>  net/nfc/llcp_core.c | 72 +++++++++++++++++++++++++++++----------------
>  1 file changed, 47 insertions(+), 25 deletions(-)
> 
> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index 1dac28136e6a..2f77200a3720 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -145,6 +145,13 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
>  
>  static struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local)
>  {
> +	/* Since using nfc_llcp_local may result in usage of nfc_dev, whenever
> +	 * we hold a reference to local, we also need to hold a reference to
> +	 * the device to avoid UAF.
> +	 */
> +	if (!nfc_get_device(local->dev->idx))
> +		return NULL;
> +
>  	kref_get(&local->ref);
>  
>  	return local;
> @@ -177,10 +184,18 @@ static void local_release(struct kref *ref)
>  
>  int nfc_llcp_local_put(struct nfc_llcp_local *local)
>  {
> +	struct nfc_dev *dev;
> +	int ret;
> +
>  	if (local == NULL)
>  		return 0;
>  
> -	return kref_put(&local->ref, local_release);
> +	dev = local->dev;
> +
> +	ret = kref_put(&local->ref, local_release);
> +	nfc_put_device(dev);
> +
> +	return ret;
>  }
>  
>  static struct nfc_llcp_sock *nfc_llcp_sock_get(struct nfc_llcp_local *local,
> @@ -901,7 +916,7 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
>  
>  	if (dsap != LLCP_SAP_SDP) {
>  		sock = nfc_llcp_sock_get(local, dsap, LLCP_SAP_SDP);
> -		if (sock == NULL || sock->sk.sk_state != LLCP_LISTEN) {
> +		if (!sock || sock->sk.sk_state != LLCP_LISTEN) {

This is unrelated change. Please keep all cleanups separate from fixes.

>  			reason = LLCP_DM_NOBOUND;
>  			goto fail;
>  		}
> @@ -910,7 +925,7 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
>  		size_t sn_len;
>  
>  		sn = nfc_llcp_connect_sn(skb, &sn_len);
> -		if (sn == NULL) {
> +		if (!sn) {

Not related.

>  			reason = LLCP_DM_NOBOUND;
>  			goto fail;
>  		}
> @@ -918,7 +933,7 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
>  		pr_debug("Service name length %zu\n", sn_len);
>  
>  		sock = nfc_llcp_sock_get_sn(local, sn, sn_len);
> -		if (sock == NULL) {
> +		if (!sock) {

Not related.

>  			reason = LLCP_DM_NOBOUND;
>  			goto fail;
>  		}
> @@ -928,39 +943,31 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
>  
>  	parent = &sock->sk;
>  
> -	if (sk_acceptq_is_full(parent)) {
> -		reason = LLCP_DM_REJ;
> -		release_sock(&sock->sk);
> -		sock_put(&sock->sk);
> -		goto fail;
> -	}
> +	if (sk_acceptq_is_full(parent))
> +		goto fail_put_sock;

I would argue that you reshuffle here more code than needed for the fix.

This should fix only missing dev reference, not reshuffle code. It's a
bugfix, not cleanup.

>  
>  	if (sock->ssap == LLCP_SDP_UNBOUND) {
>  		u8 ssap = nfc_llcp_reserve_sdp_ssap(local);
>  
>  		pr_debug("First client, reserving %d\n", ssap);
>  
> -		if (ssap == LLCP_SAP_MAX) {
> -			reason = LLCP_DM_REJ;
> -			release_sock(&sock->sk);
> -			sock_put(&sock->sk);
> -			goto fail;
> -		}
> +		if (ssap == LLCP_SAP_MAX)
> +			goto fail_put_sock;
>  
>  		sock->ssap = ssap;
>  	}
>  


Best regards,
Krzysztof

