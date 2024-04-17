Return-Path: <linux-kernel+bounces-147919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCFF8A7B4C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3F121F22FF5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D714D41C9D;
	Wed, 17 Apr 2024 04:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ks2kd1TT"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13B11E4B2;
	Wed, 17 Apr 2024 04:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713327396; cv=none; b=Y6g/JqgqH/GPFUhJR9aUSXlm1xRbXWxELZP1NZyfB86A9hM5/e/IIp0JB9LsLCTQ/7pVrH3d3DG6Fu8XtEQNOsyBpM3dy3ZyXQUrdwzhtTOzkYL3lgOmfR3hWLII1pyn5EZOWLnKEOz6FI4MDLEYIhgAeCorNjjKaournh+ouvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713327396; c=relaxed/simple;
	bh=Q0IDLctt9mdtaRzAaprRjC7sjPFhguJi5pSrmw1xXTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTJQuPGiREy8fZB+1tlI+EoK5E7WI6hK5ARKQkn1EOb0pLTmY/fwGem7litqne16LfNU0LqOmu4RoxiIQgt3ufhWdtzMu189XovMjQAaCwDKnqjT9o9x6LEXu/4ytW7alcqLmTFN6h3m5BaRCq6FsZGa1fdpAKTOc7K2N7FeU5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ks2kd1TT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e411e339b8so40464585ad.3;
        Tue, 16 Apr 2024 21:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713327394; x=1713932194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0IDLctt9mdtaRzAaprRjC7sjPFhguJi5pSrmw1xXTA=;
        b=ks2kd1TTfg1+SOet0xYP7i9T9dCr87AxG/q7ADkU1CZQ/kmbfBkbA/e6Kcux7OHtf5
         3Xz3b0e1FiiYt6ewDnNFou+HqQ6MHUpnZI2z/4RgA7AWHMkgL29wSax2tcG2Dtlksnj0
         uIz4FmZPwuQxwvrFMSPYyn3QgqZKbzyrD0md1G+FVw1SrqlF/KAtdmgli2tfJUrvNbRO
         akfWPsNakNFybRNPTKqFxxy99KTToS+hfJunHcSUNm36CKuuaToAAQW5dpn51DLGBfPM
         oNiDoyq1LT6rJhCg6+wRu1Ntex5sjBkCDF2N8yHmmxktTdPm/m4rv4uoY2NrOP4jHfyM
         CUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713327394; x=1713932194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0IDLctt9mdtaRzAaprRjC7sjPFhguJi5pSrmw1xXTA=;
        b=v5F2g4xR8mKe4WBBAGNuqmxsgtXnyQN6bLOGqdTcAaTMUq71O2r1btHpwky6xP2fRG
         kJ9ngE/xG3jkOEJgCa1o9j4snhwo7H/ZBSQaLD9Pg3+HBuK2mZjLOLcfGOCe9Fgsi3nK
         gchXTsrQWOeXrOPn46KJWG1kKeqG47cEEPk91fNNusZ4VR3JLmsar42vAZIUe35J600W
         eZLXzxUXEkKo+M5oBrY8oFM15jMB9wto5xwB42Ap6qUqkO7Tzdx1ThOeHRqz4IG8d8Hb
         xyxu+sCZ2FfzpGOJ8D9XekMzlentd2EDBZ5E6ucJrqw5Gb589DNvuWSyhQ1GARNhioCR
         z6sw==
X-Forwarded-Encrypted: i=1; AJvYcCWPrIvCvHRk32hHyGBDZua/genSBap2Drng3TRs4J56hUzh6ZPqJAJlJhOaWOcDbr94CM/xmThYiuHrAmDIvxu5Ju++tpa1QgKGMzM0M/p17VaC7Nlf86Up69zXgSjy/DrgirvvofzG2d4cFGngpUTcvizI1Cr968lB2wZ+arU30Nj37sI=
X-Gm-Message-State: AOJu0Yy7Rph5azs8Oz0QseAmnKwAVYUlTRHCRnhSlsuEayL++zhvW8Cm
	ms0i32XOgTfuJXgmaNFWIZBtmuDAp3dFqCJWIQfB4mkMTV5mnlQP
X-Google-Smtp-Source: AGHT+IGeb16AtJ71Bhsl0zCV0EKaDfcSIcheJp7AS7bFElUP5zY0KbZUIko4k8jpOrvXw/4C9oo2mA==
X-Received: by 2002:a17:903:41c6:b0:1e5:86ca:2712 with SMTP id u6-20020a17090341c600b001e586ca2712mr21880806ple.2.1713327393809;
        Tue, 16 Apr 2024 21:16:33 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090341c300b001e28aa6ab54sm10554266ple.301.2024.04.16.21.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 21:16:33 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id BAA0E1822A0C1; Wed, 17 Apr 2024 11:16:29 +0700 (WIB)
Date: Wed, 17 Apr 2024 11:16:29 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Mao Zhu <zhumao001@208suo.com>, Ran Sun <sunran001@208suo.com>,
	Xiang wangx <wangxiang@cdjrlc.com>,
	Shaomin Deng <dengshaomin@cdjrlc.com>,
	Charles Han <hanchunchao@inspur.com>,
	Attreyee M <tintinm2017@gmail.com>,
	Linux Sound System <linux-sound@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/12] ASoC: doc: dapm: fix and improve section
 "Registering DAPM controls"
Message-ID: <Zh9NHbMyrpjDgezn@archie.me>
References: <20240416-dapm-docs-v1-0-a818d2819bf6@bootlin.com>
 <20240416-dapm-docs-v1-9-a818d2819bf6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="28IlfbjGMhxeTpAE"
Content-Disposition: inline
In-Reply-To: <20240416-dapm-docs-v1-9-a818d2819bf6@bootlin.com>


--28IlfbjGMhxeTpAE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 07:56:15AM +0200, Luca Ceresoli wrote:
> Extend the first paragraph to mention the {,num_}dapm_routes fields just
> like the widget conterparts. Mention the route fields also in the code
> example. Fix "at build time", this really means "at probe time".
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--28IlfbjGMhxeTpAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZh9NHQAKCRD2uYlJVVFO
owOIAQCIwAtT/TiNwiP5wbeAAS4jYQMtYYZ4y8oq5qMaj+HCHwD/bt2BKn3pG9XD
aWqq6gnJZG2l/2JxeE4WJVH30gPuiQU=
=8dwg
-----END PGP SIGNATURE-----

--28IlfbjGMhxeTpAE--

