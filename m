Return-Path: <linux-kernel+bounces-51115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB8D8486B0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8BC285EF8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0CD5D8F8;
	Sat,  3 Feb 2024 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdM4/+k4"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CD755E70;
	Sat,  3 Feb 2024 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706970120; cv=none; b=PRmb/Y34vBMUTNzqD+6Mx6y7wWCo1rrgiAhkDNfQYLJjuHlkGbVGes/zCpGI6LcuMBRQO2epi7mZjcdA9NJncu1CQG9zT5JhhPkM2X3fHs0h+Vi0vv+IVigxV172TbIngR3fip2+m8rMZn9IWOzCMOmxrKpma1wfQzzDm2r7uVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706970120; c=relaxed/simple;
	bh=zYrf0P/Z30JJi7prvKKRaAdhW6IPCVPSFetbZi93Bt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hET0LXyyfWzcYWWNX0t28qAf/swb0cu4VW6P5F7sZbvFEbmROUaZtgnza42mejP3ygSkK7nJyoRxhn4JGgoFHth8r3TYbg1UGnPCdpwLRfDNMS9xYr18mBgivUEx8AlIX6/ukISWOica0JNW2/AkxDjdmdjyx/NrxnCzkE88SiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdM4/+k4; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29631796acdso1327949a91.3;
        Sat, 03 Feb 2024 06:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706970118; x=1707574918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ToEVaWIZ0fuUtYtDuSCMzcdantFPoh+MRoifqahhM0A=;
        b=mdM4/+k4aIBdegQ1Rigz3vbhjgH82MkxL1YVIKhf4VhWmEUaMb5qj8pzW7RsnYveYZ
         pxHRT07kGaETnX9aJoIaEz+1zZKFHRj9QQi2Z0/dObskFtZMpeGMgX02sGQQRtUiosu+
         TSYDT/nSzhq5GQehIYePmwddDDugDNNlgjwptz8DJDDfKBT3Bg0uaFR0kqiBHfVCSNzF
         90pzWMjDv4CSHH5CsqNsY8XoH1gWZUIg97cT5mqWWOJ581eh3dZPi7UQk8mhPIMTuw42
         T9By5yGNlV3EqIZA+A5R2jfhYOXwupullNfRyRagjEaXl7+LmPLnJmwJf03gNEfF9vxq
         XqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706970118; x=1707574918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToEVaWIZ0fuUtYtDuSCMzcdantFPoh+MRoifqahhM0A=;
        b=wCHXQSuSUGbaJucA34GT2AE6MU6jLKx7mevidDenZMA6a0R7o1PWtjC/JT6j7+PvP+
         VDzST3sEiQvjsJe6NqbRiXYgDfgV1rq3jrAwTcDlbeu5rBlrLEz/TBQlX+FfeoIOrPLI
         DXYIxR5e0tRVYMPwkt1dddudP65823Te93iPgPySJ1HOq7s4QVar5+XRkhLM/dhNE9N+
         ZsCXh3+yEGbnqrCclXylEXtySqs3r0GxBSv/07PPcqvax6hFrGF+miaDBhISfU42LYUW
         TofQvUM0a9GnbT4TY3oJWojY9WM85znQyhkTeRDFoTOifFQxf8wQO7EDLdnLKwLb0xup
         HUtQ==
X-Gm-Message-State: AOJu0YwhalOWL81fCv8+93OUzC+U+renVQdbORxXuG6drq92LpIklhhv
	CmyLZch1Xp2vFI3kiMc6G/62z1vQG9kSe2c/0KjvY+LkV6LyHhQE
X-Google-Smtp-Source: AGHT+IH50Mulf3HD1zogOIaD4lEQL8c0b5BOoc10ZI605VLBz8YU65Vl1bg+qoF4yaKAtuIHIgYs3A==
X-Received: by 2002:a17:90a:43a3:b0:296:42ef:b3ce with SMTP id r32-20020a17090a43a300b0029642efb3cemr4449584pjg.28.1706970117959;
        Sat, 03 Feb 2024 06:21:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVpaILoBXRe6n7KCMUKDi5wsE0061FmwuOKEl8f0m4PFkkASp+8IAn4QcDehTnaYDfSvK9U0/Nr3cWoqLOaIOKxog/ZYNHoR249Y7XPrrB+GhfZPoZ97ZQEp73eKs/qdACjNCaaBsffOX9R9E4zJR9hlPmURm05MqQH90FTKMJTsnlR1BxVySBOzZ9Yuu1sjVhu6ar/Va3/xzq8d7E8XweZkqVV3IPoaFCNVG3NDEPtEkY30Hk2XctNfiTjr8APzpV0LS8QJ11EJxYFiJPO7qtZn+2c7C4H1pOiv9QMwJtAhBZ/eK/k3cWLP4G3nXDJex7/nMRhEPTrW5p6avAKfimXQWHp7hIA9007jrSNKyVYlemClkr9QFeH0NAnm53SaOyETX/NSEerURmce1ChPW0ZAwkBJ/QYNDVg2Ur/P2c7sj+p8eYKRBsKQsittfnYmX6oc1j+TyDaUBfOwJ5c+jxvvJBTx043Wqr7WUOunVfhlDBQ9JEmnx/hXMlofYehnW75JRwo4sn4faylL7/2
Received: from dragon (45.78.63.125.16clouds.com. [45.78.63.125])
        by smtp.gmail.com with ESMTPSA id lh4-20020a170903290400b001d8ecf5ff6csm3340292plb.147.2024.02.03.06.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 06:21:57 -0800 (PST)
Date: Sat, 3 Feb 2024 22:21:49 +0800
From: Shawn Guo <shawn.gsc@gmail.com>
To: Kshitiz Varshney <kshitiz.varshney@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Varun Sethi <V.Sethi@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Sahil Malhotra <sahil.malhotra@nxp.com>,
	Vabhav Sharma <vabhav.sharma@nxp.com>,
	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
	Rahul Kumar Yadav <rahulkumar.yadav@nxp.com>,
	Nikhil Singla <nikhil.singla@nxp.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] imx_v6_v7_defconfig: Enable sm3, sm4, polyval, xctr
 cipher test support
Message-ID: <20240203142149.GI463595@dragon>
References: <20231220113857.1127598-1-kshitiz.varshney@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220113857.1127598-1-kshitiz.varshney@nxp.com>

On Wed, Dec 20, 2023 at 12:38:57PM +0100, Kshitiz Varshney wrote:
>     Enable config for sm3, sm4, polyval, xctr cipher test as built in module.
> 
>     Issue:-
>     Multiple crypto tests like sm3, sm4 xctr and polyval failing.
> 
>     skcipher: failed to allocate transform for xctr(aes): -2
>     alg: self-tests for xctr(aes) using xctr(aes) failed (rc=-2)
>     alg: self-tests for sm3 using sm3 failed (rc=-2)
>     tcrypt: failed to load transform for sm3: -2
>     alg: hash: failed to allocate transform for polyval: -2
>     alg: self-tests for polyval using polyval failed (rc=-2)
> 
>     Resolution:-
>     Enabling CONFIG_CRYPTO_SM3_GENERIC, CONFIG_CRYPTO_SM4_GENERIC,
>     CONFIG_CRYPTO_HCTR2, CONFIG_CRYPTO_ARIA as module enables support of
>     sm3, sm4, aria, polyval & xctr.
> 
>     Signed-off-by: Kshitiz Varshney <kshitiz.varshney@nxp.com>

The commit log and Signed-off-by lines shouldn't have leading
spaces/indent.

> ---
>  arch/arm/configs/imx_v6_v7_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 0a90583f9f01..627f57da9d5b 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -484,3 +484,7 @@ CONFIG_DEBUG_FS=y
>  # CONFIG_SLUB_DEBUG is not set
>  # CONFIG_SCHED_DEBUG is not set
>  # CONFIG_FTRACE is not set
> +CONFIG_CRYPTO_HCTR2=m
> +CONFIG_CRYPTO_SM3_GENERIC=m
> +CONFIG_CRYPTO_SM4_GENERIC=m
> +CONFIG_CRYPTO_ARIA=m

Instead of adding lines at the end of file, please use help from
'make savedefconfig' to get them appear at the correct places.

Shawn

