Return-Path: <linux-kernel+bounces-68472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D6C857AB1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601232861C1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E80053E0C;
	Fri, 16 Feb 2024 10:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4zqxnqK"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1304753E15;
	Fri, 16 Feb 2024 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708080751; cv=none; b=AEp0QL9QqqBdFIqgComh79iKTQCf78ANkFTaVHy18WeBLLqBixt02wy/1COSwJtexXdl7Nsl0FCpqVt7Nwor89qtV+HeXSKpKnbxpPEYLYjWWoLC06OOivCZuGL9jrBAB903/g4/grQdpAro1hh7aWcoc+RR5L1tr9L//nADRRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708080751; c=relaxed/simple;
	bh=SxPNvP02QRgALKhVAF8XtYXCiuzYHgGs0GtYnOmTTHQ=;
	h=Content-Type:Mime-Version:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Eqz+raflOMGcgiWmR5JaApfG+m1iqqCS1BtyQjeJDB+LC6FJLcww3eB5YbbqSmw5KxaBv0F7wjPQwOE/thXGNf3U9fjd5hgWgjLOz+jgyyANWG+DCxPi4pGgAJxrBrmZ9t756H9oaspAqluVoFDRjca8WhTh7vIZXJiDTsQEE2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4zqxnqK; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3d5e77cfbeso334776666b.0;
        Fri, 16 Feb 2024 02:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708080748; x=1708685548; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8BlcWNd72NqF1gKnOhmnwk5ASoyTAqAbMm6IbUppSeg=;
        b=F4zqxnqKBmLVNq2Dg11VeR3OZspe5Vc63Ej4VUE2/yAAxfVwByStCMM/eLZ+hgmvl0
         nWJt1CL+iOo6uuKolllo0xTpZHK5AtNQSKSoUiu4t6XD9cdL/NE6cvlUf3r4HWwrDIjJ
         P9TZAXdrMCeuw75ur2vWvc10VeXduxCeU8LMus32JfzPcL/NcvLljikwE59TVfTQ1CJy
         oFJYcNJShoRG0bNO3xDbwYZ//SqnktVY/MkNqYDbr186JfHeKpWgnMy0kaQq18l71f30
         MTbEjnAYjHbrztFjjz1cAlBjXqzNrJ0mSdty7iSQEJyc6yGBR1XXfyumK9i/H+rY1e5m
         sWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708080748; x=1708685548;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BlcWNd72NqF1gKnOhmnwk5ASoyTAqAbMm6IbUppSeg=;
        b=P1bkA2bJrraKkQoBaFygCdzMLqaa/ZlY8ddK8siqmB9vTFnSKmVC4359zsWrew9qTn
         h/y1sfv8Xtq9VRN4kFkIieXNSE5QC4dp7qzWu9Ii7U14NSBzzDBgg5Gn//1NA560pZfc
         6qdQst9NX6WrXi2G8HKboCGUPnd/hfRxolt2GD3/M+B3i66DltWUWuD8aJPfky7HP/NM
         OnwKzvyhF9kRLdqKgfq4+LYiXZ9VR0EeAnXP4eLA0dEul/EstUxrH2CTvag+hsqi3piS
         o7Wkf63GeJ0FPhBETR/E9HN/WcG1nyd133hUk0A1ybUXY4Y3dVIDmsTLkrOVTqJRy7B6
         WUWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOfN8afqG+ElEKTa7uzVA+IDWmOuvyuWReAtWEF6bGsqyXcTyzcr7gM3NPLf/oPZ6wR5X8EEJ1oCPi9yLdSiKIxYPC1KIsrVmw3uh8PtElRfMiGLxe6bjxD/AByyp8NkJbVFndZupUj0s=
X-Gm-Message-State: AOJu0Yw8xLKW9ANlTKLvnKhM/ukEwhSzgi0Tys6Aat9h69za6obho6Db
	ApxBGlstLPybIhhAXPNBNuCuqnIMt1FDSlrbqe2l6o3lhM1dHfK3Xsq5WzJT
X-Google-Smtp-Source: AGHT+IH0mDcRw34Wq9ydUOENLdvJRoSG5jkuL9c84tNSGhp68b/i9ae6/cVjEJgI+Bo3dCS82Bq4Lg==
X-Received: by 2002:a17:906:f156:b0:a3c:7e4b:e7e7 with SMTP id gw22-20020a170906f15600b00a3c7e4be7e7mr3679222ejb.10.1708080748056;
        Fri, 16 Feb 2024 02:52:28 -0800 (PST)
Received: from localhost (p200300e41f147f00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f14:7f00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id o4-20020a1709061b0400b00a3d80d7f986sm1422202ejg.82.2024.02.16.02.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 02:52:27 -0800 (PST)
Content-Type: multipart/signed;
 boundary=8eadebd4d5fd4d6fa88e29463ae8e3e13d60ee0673e0e78c74e9107668be;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 16 Feb 2024 11:52:27 +0100
Message-Id: <CZ6G3AJZTG6X.1P6P64B0Y3Q8W@gmail.com>
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Colin Ian King" <colin.i.king@gmail.com>, "Mikko Perttunen"
 <mperttunen@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Daniel
 Vetter" <daniel@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
 <linux-tegra@vger.kernel.org>
Cc: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] gpu: host1x: remove redundant assignment to
 variable space
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240215224301.2073845-1-colin.i.king@gmail.com>
In-Reply-To: <20240215224301.2073845-1-colin.i.king@gmail.com>

--8eadebd4d5fd4d6fa88e29463ae8e3e13d60ee0673e0e78c74e9107668be
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Feb 15, 2024 at 11:43 PM CET, Colin Ian King wrote:
> The variable space is being initialized with a value that is never read,
> it is being re-assigned later on. The initialization is redundant and
> can be removed. Also merge two declaration lines together.
>
> Cleans up clang scan build warning:
> drivers/gpu/host1x/cdma.c:628:15: warning: Value stored to 'space'
> during its initialization is never read [deadcode.DeadStores]
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/host1x/cdma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to drm-misc-next, thanks.

Thierry

--8eadebd4d5fd4d6fa88e29463ae8e3e13d60ee0673e0e78c74e9107668be
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmXPPmsACgkQ3SOs138+
s6G7ww/8Ccf1z5cqdmYk/z19Ra4Oq/gXZFdq23lYsXMk8Wan8JQcyrQGHpZPzqCl
tWXsnMCLeJk+ef3DNJRsU1/gIFbiAJlWz4c/1q01Htw5wwJ6S2RMBEyLJUJiQ3jC
TjG+qF62jUQJed/lVA/EXKTx5Vxi9cbaZ4o0cckioVRtxP6aj3dWV/0ySc+nx1uU
o9h8gwgyMafcLn5cVtKzf4aYLq32mDgLSY/UHhG3L6uXSLijxnPixdZyAYIq1gDH
MVeRDtFkX/xplkI1SEFTUQ27U6qGgPszGbZSa+bqSfaoDP6fbuq2UmVaJ8jB+gr1
f+7uxUu3lQ8vCw+NWYY0cfYPV3GajHwzeXmy2Jm0v1/XUr5cB8fU/tPFuikr8as7
Lrweh3ZS8FbWO4WwKRvK1EdsT+RmGyQ5QVbbquU43lPvZav4CKBiZorrXdQca1gN
yMIZQ1xJssRUWQ2fMrxq0Ze1SEiAms4SnnV6TEMxn8dE4gmaorRVLXDksVGA7mFa
ig/P+bW/37UMQubPlhG4HmZ0G1BZrvbVoFW9cOlG3CI5+De+9RiCRMMpwfP7MXEZ
S3x4HeyYvhFJGqk1t7EFrBZYra8UPCITSei3+Zb4symbsxmHoavbjMUwM21IS+Lg
Rxdn8C1BMz1qj0xHP/xHtCEvgKo32hO41Sj9WL5O+3ZhXwzknzE=
=LKQT
-----END PGP SIGNATURE-----

--8eadebd4d5fd4d6fa88e29463ae8e3e13d60ee0673e0e78c74e9107668be--

