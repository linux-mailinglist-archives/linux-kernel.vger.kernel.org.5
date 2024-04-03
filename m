Return-Path: <linux-kernel+bounces-129413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8900896A6D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746FC289E7B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3F4745D9;
	Wed,  3 Apr 2024 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ks6bfl1S"
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FDF5D731;
	Wed,  3 Apr 2024 09:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712136264; cv=none; b=Hwm8cI1KvzxGsTCIEwr+m2hJfiqrGc3V3BuT2KpYdf6qwkDKbnFx/phAEwkWzUtvS0N/0AM57PL6W0n/C0CdF7vTlswFXrhW1de/lWmpy38jzR5cY9OxxbPxz7gsKKgXkvs+TnL6xG/mbDceHxNpPA56hRccdlu7wIz2Mw5SrLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712136264; c=relaxed/simple;
	bh=0cDN5paAb9txvyHF2D6Fb3OsMALbEquEDwtlMVuufaw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iSt1dh3LkXW17yc0DXxl8tdYni45i1z96uTEL8EInVgpd/OGBEy/+KSP+ydh5Dfk6DVdw+PixYgZK54xk92LP+HvyrwYf+vEdyuB70h4Hnm8JlIYfrzp74AEsBiiylU/M2fWAqscA0RZlk5PCmX8Kok3h5kwc57SFbK4geWoNCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ks6bfl1S; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=QW5ivH3/dmP4FXPLr8uU5HynTRDSV6aSkAQOv6EMSuM=; b=ks6bfl1SB3SaYK7dT92dY4wcbE
	PxzFIM7ZOVGy5WW0+rnesRw/P2mODbnWhM69A4MDCGzcokplJ7AJa/TUZduzpN/SZAShCMWPjZeUx
	mOlUx+d+q50Mbo69qRmZ3V21qtq6yT3SzCUNn+4NzykGLoXqHHO/IhnjfBkeJ8McPLZeJrNixF6NH
	FReb3xdoMcQMGMGYtbA/Fn8u7mOLy3p2VTuy1+fg0S/Qg4+wTfbgjwwI1Yb8RnFuKSo/ab6L8pkbP
	q72ER+1bHVDAZQKopKUTO+NcrTTNxmA7QzR/Q2mQErbX2rkXvtArV3tM8o2UFPig9MT7kPb5ewDh+
	AFqQsEdQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rrw9S-0006HI-Tv; Wed, 03 Apr 2024 10:39:22 +0200
Received: from [178.197.248.12] (helo=linux.home)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rrw9R-000PYM-2O;
	Wed, 03 Apr 2024 10:39:21 +0200
Subject: Re: [PATCH v2 bpf-next] bpf: Fix latent unsoundness in and/or/xor
 value tracking
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
 ast@kernel.org
Cc: harishankar.vishwanathan@rutgers.edu, paul@isovalent.com,
 Matan Shachnai <m.shachnai@rutgers.edu>,
 Srinivas Narayana <srinivas.narayana@rutgers.edu>,
 Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Edward Cree <ecree@solarflare.com>, "David S. Miller" <davem@davemloft.net>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240402212039.51815-1-harishankar.vishwanathan@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <82892691-a48f-ad06-7005-5bbd7d0757eb@iogearbox.net>
Date: Wed, 3 Apr 2024 10:39:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240402212039.51815-1-harishankar.vishwanathan@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27233/Tue Apr  2 10:26:21 2024)

On 4/2/24 11:20 PM, Harishankar Vishwanathan wrote:
[...]
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fcb62300f407..a7404a7d690f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13326,23 +13326,21 @@ static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
>   		return;
>   	}
>   
> -	/* We get our minimum from the var_off, since that's inherently
> +	/* We get our minimum from the var32_off, since that's inherently
>   	 * bitwise.  Our maximum is the minimum of the operands' maxima.
>   	 */
>   	dst_reg->u32_min_value = var32_off.value;
>   	dst_reg->u32_max_value = min(dst_reg->u32_max_value, umax_val);
> -	if (dst_reg->s32_min_value < 0 || smin_val < 0) {

The smin_val is now unused, triggering the following warnings :

./kernel/bpf/verifier.c:13321:6: warning: unused variable 'smin_val' [-Wunused-variable]
  13321 |         s32 smin_val = src_reg->s32_min_value;
        |             ^~~~~~~~
./kernel/bpf/verifier.c:13352:6: warning: unused variable 'smin_val' [-Wunused-variable]
  13352 |         s64 smin_val = src_reg->smin_value;
        |             ^~~~~~~~
./kernel/bpf/verifier.c:13386:6: warning: unused variable 'smin_val' [-Wunused-variable]
  13386 |         s32 smin_val = src_reg->s32_min_value;
        |             ^~~~~~~~
./kernel/bpf/verifier.c:13417:6: warning: unused variable 'smin_val' [-Wunused-variable]
  13417 |         s64 smin_val = src_reg->smin_value;
        |             ^~~~~~~~
./kernel/bpf/verifier.c:13451:6: warning: unused variable 'smin_val' [-Wunused-variable]
  13451 |         s32 smin_val = src_reg->s32_min_value;
        |             ^~~~~~~~
./kernel/bpf/verifier.c:13479:6: warning: unused variable 'smin_val' [-Wunused-variable]
  13479 |         s64 smin_val = src_reg->smin_value;
        |             ^~~~~~~~

Removing these builds fine then, please follow-up with a v3.

Thanks,
Daniel

