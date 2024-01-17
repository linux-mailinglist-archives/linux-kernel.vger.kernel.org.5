Return-Path: <linux-kernel+bounces-29167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B21ED8309F3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42DBEB249C3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED8521A17;
	Wed, 17 Jan 2024 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3PtSLT0"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB9B1E4AD;
	Wed, 17 Jan 2024 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705506148; cv=none; b=d5ygwe65OPnUPswLGSXAlhoSd+OcMuj8GhSs79LRbcU6AxFZVtIFQvFCCG0FF+loiEOy4F8sVrdmeqvqkeQ4/Aaue8/ykMWCPnPSuJp6Iqy4Gx9CgaAJY2uMirhHk2kMqVE2y8V0aEYzi9HDzfY9FEexunPK9kra6GkqQdwRcOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705506148; c=relaxed/simple;
	bh=8fQeU8TYFSJw7awIkhqhG7RDXu0aB29v8S4ylrMBLl8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Message-ID:In-Reply-To:References:Subject:Mime-Version:
	 Content-Type:Content-Transfer-Encoding; b=nYKkNoXiKup7o6p4WqRtyi+ijmQkQRuqA6qO8YRwwFC5GmecSHju+h940G83hCmMTQGcbILlt8sqmQuB99r05pbb9+3/LXFFjFfETjQKteGdROhRFXFg/T8zJfYrrZMIRbUUIXL1iPPTQqmpEq5BEbetPsheLt/qguRM2UiAHBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3PtSLT0; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bd67e9d6ceso2572624b6e.3;
        Wed, 17 Jan 2024 07:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705506145; x=1706110945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=El1BDwfiWcFMUGQAzNWSJwRyEYHbk8qY8kyNpNgdxyg=;
        b=f3PtSLT0qaHHKZUS+kiNZO3JW2Y4yDRbxj1Ax342Wo3vsU0Dr3LmjME3qBOTxQaRL0
         cyghvZkYqNoeDkQapR3vvuP5Gmj2gycVM/pMjMPPp92slGUMNT86dUn3TOluG9CUo1Qi
         y2bc2SwU0xrTzGU/xz4EdyqioxEjuI6zgC2RZW1SrkoDO8eLRGhhFrl82GPcc8CshpCP
         ELdYihrOMgOjjeHrYc4iyuKj3Ap8LdeQan3thxSKKrS2+9ip7efCj36IylS1vMciSaLF
         l/3aU4Is1YjaqUd/dysfx4/BjE0u4pRJ8q/sbukHIjJ+2qbgjQ/fey2Ctos0kpL8YcZl
         WCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705506145; x=1706110945;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=El1BDwfiWcFMUGQAzNWSJwRyEYHbk8qY8kyNpNgdxyg=;
        b=qOqzqsZYDDSViqbIE8QmjeZMGhEPwd7RfX2P+kR6VzgD6TVmNZK/d08g0q5aFnjdSr
         a0mKcL2qYCYzUZO4LAHYuPUc8aDdcOzL0WNlS7Fc75UAWJN78owyPkwlcrm3dfmk/Y3s
         wldW/RxpG8wmoh2lMhNE7vqOEuiHWZ7lcrE9Rj1xBc/mZfiXSTct7xpIuIALmj54uWUj
         Y4vS68S1PNfldOsuDVWd/j0FXbdQ/cp3eknCjZwHBv0crOgBuCI2AT3igsUgCVmqdGAD
         1XBhe/cBDYT3lhK2el99AEauQqw07aAu6jtOAtONfNNE7GL8ZErzgTLWaXjNVt4wbJHQ
         XCYw==
X-Gm-Message-State: AOJu0YySZMb2HEGc8eCiY1Wrr3aK4iSMLu7YO7NmH7MhEMJlpzD3LGOa
	xUIkulYTR3K1aWPb+ojHx3w=
X-Google-Smtp-Source: AGHT+IGiflY8EUhqDr4/S/PRNAtoNuL8EqMHs+iyT+69aVTPvk+ZTwzppK6c8OFLRCknXYNdDKHp2A==
X-Received: by 2002:a05:6808:1808:b0:3bd:995e:c7b6 with SMTP id bh8-20020a056808180800b003bd995ec7b6mr270999oib.16.1705506145309;
        Wed, 17 Jan 2024 07:42:25 -0800 (PST)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id d4-20020a05620a136400b007832bb4dbcdsm4595706qkl.72.2024.01.17.07.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 07:42:24 -0800 (PST)
Date: Wed, 17 Jan 2024 10:42:24 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yunjian Wang <wangyunjian@huawei.com>, 
 willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 kuba@kernel.org, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 xudingke@huawei.com, 
 Yunjian Wang <wangyunjian@huawei.com>
Message-ID: <65a7f560a4643_6ba59294a7@willemb.c.googlers.com.notmuch>
In-Reply-To: <1705490503-28844-1-git-send-email-wangyunjian@huawei.com>
References: <1705490503-28844-1-git-send-email-wangyunjian@huawei.com>
Subject: Re: [PATCH net v3] tun: add missing rx stats accounting in
 tun_xdp_act
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yunjian Wang wrote:
> The TUN can be used as vhost-net backend, and it is necessary to count
> the packets transmitted from TUN to vhost-net/virtio-net. However, there
> are some places in the receive path that were not taken into account
> when using XDP. The commit 8ae1aff0b331 ("tuntap: split out XDP logic")
> only includes dropped counter for XDP_DROP, XDP_ABORTED, and invalid
> XDP actions. It would be beneficial to also include new accounting for
> successfully received bytes using dev_sw_netstats_rx_add and introduce
> new dropped counter for XDP errors on XDP_TX and XDP_REDIRECT.

From the description it is clear that these are two separate changes
wrapped into one patch. I should have flagged this previously.

Ack on returning the error counter that was previously present and
matches the Fixes tag.

For the second change, I had to check a few other XDP capable drivers
to verify that it is indeed common to count such packets.

> Fixes: 8ae1aff0b331 ("tuntap: split out XDP logic")
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---
> v3: update commit log and code
> v2: add Fixes tag
> ---
>  drivers/net/tun.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index afa5497f7c35..0704a17e74e1 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1625,18 +1625,15 @@ static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
>  static int tun_xdp_act(struct tun_struct *tun, struct bpf_prog *xdp_prog,
>  		       struct xdp_buff *xdp, u32 act)
>  {
> -	int err;
> +	unsigned int datasize = xdp->data_end - xdp->data;
> +	int err = 0;
>  
>  	switch (act) {
>  	case XDP_REDIRECT:
>  		err = xdp_do_redirect(tun->dev, xdp, xdp_prog);
> -		if (err)
> -			return err;
>  		break;
>  	case XDP_TX:
>  		err = tun_xdp_tx(tun->dev, xdp);
> -		if (err < 0)
> -			return err;
>  		break;
>  	case XDP_PASS:
>  		break;
> @@ -1651,6 +1648,13 @@ static int tun_xdp_act(struct tun_struct *tun, struct bpf_prog *xdp_prog,
>  		break;
>  	}
>  
> +	if (err < 0) {
> +		act = err;
> +		dev_core_stats_rx_dropped_inc(tun->dev);
> +	} else if (act == XDP_REDIRECT || act == XDP_TX) {
> +		dev_sw_netstats_rx_add(tun->dev, datasize);
> +	}
> +

Let's avoid adding yet another branch and just do these operations in
the case statements, like XDP_DROP.

>  	return act;
>  }
>  
> -- 
> 2.41.0
> 



