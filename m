Return-Path: <linux-kernel+bounces-44005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B56FD841C17
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A2428A3C2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050343C689;
	Tue, 30 Jan 2024 06:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyT2fA2A"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AF438FA3;
	Tue, 30 Jan 2024 06:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706597131; cv=none; b=qL58sB9CDSq05HHtF4fMbz23v+ovGFPHaz5NU40ohRlpnpvNV+HTG+krv4iuqUKqlZZ4uEHYgfum864xjc104GxMsyR3nhXv1dt7abdRDOdeNArWDusX4L0YxprAnmO4NCowgUMHr7MMp/NsFNCd+CHkzu3ysHxlFwUUP9v1jzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706597131; c=relaxed/simple;
	bh=RUVhUB6vWpn6J7iBH9wHMArisF6jGJ3ANfbKe/M0vAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUJ/LKrfuz0t6klAlpqRJUTosfCa2Sxzz0OHKZlZ1dX4BJ7DgYCFbgVTTTmgFVlVO/VPioWtYtsD48pCklyOTX9q3M8+zTMlcp5Eur0MeSgnCRS4Mu2D2VjMCF+mCXNN4WTYtzbqn1q1VpSqooTfNPo1vd88CeaqPxH8ASpNxAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyT2fA2A; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6da202aa138so2196286b3a.2;
        Mon, 29 Jan 2024 22:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706597129; x=1707201929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jG8Pdn1FHmkpqrT0d8YZDwmhNF09U0vd9Cbri7aDn5U=;
        b=DyT2fA2AJyDH7t3Qux0TZcIRhx+GOUPPriiLpdI7c0jMpY55g5hLHQft4BvELohiZ8
         nG/g8qdhy3WcDgTEbvqI0E0oFDa+yCVZ5FLUmYEDAmo7wPKtNkOg1mtvYAAvp6UkfGEG
         fo5azmPNzKr3hLNe2/25bbbWwBhCOYadXZ/t4UR0t6OimM58ipiaODH6dIIhlFxcNQig
         IcyLUkP9zlU5Wds2FNDeF/noU0olTYFfbBS8oRLyVDMqQ5FRqkPjm9+KCuSktaVUdWHq
         0FGF0yPiXh2srMH1z5nnzmzcSmRzSzNrnvkSbanc6z8I9oCsI/ODECwZvOXOyww+lQ1O
         gTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706597129; x=1707201929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jG8Pdn1FHmkpqrT0d8YZDwmhNF09U0vd9Cbri7aDn5U=;
        b=R69weSl0E7BY9h7aI/cKRcNW75/5CaywEHsfUEtODuF6YcmEeFlY0IsZt/kRyI4wDB
         Tl6tEv6MKGBCx8EvrhnrVmmIkhZPweSuJxK8rRNYks5OI5m21AixqCOi7woMOyq+uJkM
         muzTXFk8Mumj1T9EhOSF0MKGGnKOuZeMtSKhe/0BREmam/wS5D1q/Zxe3zroA8GPFbjK
         WAHvp3KFQpc2Tl99QXItAeM2draGHhIo96tvFgXtBBvTWznq2662H4ZGesE/y4/S1nVe
         XeTridq9E4MsJYZcJcJzJZvHHLdAaByiJ40deHO2uSwZXxmPHNCF0k375jtOeieHLysY
         In5Q==
X-Gm-Message-State: AOJu0YxJo+H9POCBoxsWK4B9IjTU459iEOaRBvXcHZ1im59n9jKOMxnB
	APfG2tqW4iXqg+kZw2t/fra2grFu87CalSc4f7/EAu40ChSLZvbz
X-Google-Smtp-Source: AGHT+IGeGDTHLEO2DU2kIR7EfvF+upqRHyio1QTFSmhRLPbcZWOZy4I2mjf+4B18iDRCqehDZrGWPg==
X-Received: by 2002:a05:6a00:230b:b0:6db:bd8f:bf90 with SMTP id h11-20020a056a00230b00b006dbbd8fbf90mr7517980pfh.13.1706597129226;
        Mon, 29 Jan 2024 22:45:29 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id fm27-20020a056a002f9b00b006dd8a07696csm6867260pfb.106.2024.01.29.22.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 22:45:28 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 9E22B1862FCDF; Tue, 30 Jan 2024 13:45:25 +0700 (WIB)
Date: Tue, 30 Jan 2024 13:45:25 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 000/346] 6.7.3-rc1 review
Message-ID: <ZbibBb92RFcvw7l0@archie.me>
References: <20240129170016.356158639@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ev9pclu/mPcHacYi"
Content-Disposition: inline
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>


--ev9pclu/mPcHacYi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 09:00:31AM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.3 release.
> There are 346 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--ev9pclu/mPcHacYi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZbibAAAKCRD2uYlJVVFO
o04ZAP4ncDeyZeMnHwu8TYV0W9sRtIkOTwea48RNMsB9VpTf3AEAxIQOgeKk3gzB
8P4A88jtE/dkF2yFG9kDniuea2bNbQ4=
=pKG+
-----END PGP SIGNATURE-----

--ev9pclu/mPcHacYi--

