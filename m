Return-Path: <linux-kernel+bounces-166260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFA58B982B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809001C21DF9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29C656770;
	Thu,  2 May 2024 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTFBEIwb"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F775644E;
	Thu,  2 May 2024 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643737; cv=none; b=IojNS2bnqJbiGhMNNbt8+U6X99rGw+PaqLn3OTcjIPeVJ4znjCje9nEvHXWTkZe+z1kuS6ID1BAC5y1/HplEs8OcuDBjyZ5laaH5aVNFVchclOuZpi/Z8oXnJRdOmRWLnyvoVMapXF/B/+Mx3/08M08LgHGwJD8oASYFUGJer04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643737; c=relaxed/simple;
	bh=3xZ9AUAXso351g/A/VEX0ATJZhtk3T9iQTV2wk2nD8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=id9qSLvBGngMd0NVOTHQ0FMU6qGGnzNd8gobK/npmJ9sg9qRTtZ4Nb70B3T6+2PkMWpUUbirgejQMxafYqrPKKGzxNk1xV1N4Ud61k4uQh1bRm/kQwIsy2UkGP1F+2I7aY8VJ7bP4IFlLf0B18lgzgZcGLFLNe3RL5OpdAI2Ny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTFBEIwb; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5dca1efad59so5586042a12.2;
        Thu, 02 May 2024 02:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714643735; x=1715248535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3xZ9AUAXso351g/A/VEX0ATJZhtk3T9iQTV2wk2nD8Y=;
        b=ZTFBEIwbg1jvCJV67OMhmU0g0ZIifIC55uoZiIQr7c1fHU7I3NbhlKIjjSHnKhr6d5
         txy23Tt3RcdphyymZWpMoJuT/Up334bof3di1vIr6OAzjNo6GFgT/4BUrroZ89DnX5PJ
         6+rOIpybAkGWVMPvBw2uvZPYI//d1x2lhgI7VnPF0uglQFN/Ugv2MMAWNX22SevgJ7Wm
         z2E8Ds5qbevC2zQZAJ6V1Y63TtWXIJvIzxsfXasxLNrAMIqbkf6FYQN47GGLWOLr/IHR
         zzuZea2FPdgFOtF7PmZkjsn0O5ugioegX+h0I8hWP8WHNVna5ewUpkffkuMNv4pI6feZ
         9LNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714643735; x=1715248535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xZ9AUAXso351g/A/VEX0ATJZhtk3T9iQTV2wk2nD8Y=;
        b=vVvYef49YTcl9XXdI7ewiJ3HkNyJunIi+1f1nWa4+rfgIRm4KMuq3hNIvcpEBHedsv
         QgpbPGfd14nVS952XQqnIsxhugZgO0HJUTbnVLNbokAbPhD3FwCLQD8LR3NTOsXwhKEc
         ov7ajwy4QSLLA5l5l4KYT1SYp3oVdDjxeREd9IcWKmoGsHs+tOXsLOKge77iBUCsvGZn
         gHg3C5OSYRgSSvikG8q2PrbxJWsfCmHxCu+IS7ETSblan6TW6XPaYI2CdGRg/OoqPn7R
         Z1RIdsYiy07ZjEXuIJ9WNDGHX0YaApIo/QB5JsqdNilGsiqtJeV9sx5VsC2zFSzfy8OM
         cg/g==
X-Forwarded-Encrypted: i=1; AJvYcCVMruvDhUJoWVe01vArvciQGi1eF/QbFe39BqSjkg67RNw3GdEfUCKaYuqgKusHjP7MkqK0QkhabU8uJq1yxdpxSkH6q+DM6i8ZpXwhwOo3ejB9poRJA+ilfyNc0eBpsDBC62iTx7VL
X-Gm-Message-State: AOJu0Yyj/oUEfvsNeb33W6vHGJnvtpSFe3ZQiPGip6gRIGV7fjsCPMql
	FqUXYJgAql8BvL21j2GcLIZ3+3wezCrWkO7gZFJdnMmY9TWP/3XGgri+lg==
X-Google-Smtp-Source: AGHT+IHA3Z6wyvmpDJBDXxRhP5maQQO/EsarH2FyfV8voZAC5wf9u0fdCpOFhlH3D2Vt1JwqF6sQ5Q==
X-Received: by 2002:a17:90a:a683:b0:2a0:3dc3:8a8b with SMTP id d3-20020a17090aa68300b002a03dc38a8bmr4583459pjq.47.1714643735019;
        Thu, 02 May 2024 02:55:35 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id c8-20020a170903234800b001e2b4f513e1sm868379plh.106.2024.05.02.02.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 02:55:34 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id CCEED18462B24; Thu, 02 May 2024 16:55:31 +0700 (WIB)
Date: Thu, 2 May 2024 16:55:31 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Christoph Hellwig <hch@lst.de>, mhklinux@outlook.com
Cc: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
	m.szyprowski@samsung.com, corbet@lwn.net, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	petr@tesarici.cz, roberto.sassu@huaweicloud.com
Subject: Re: [PATCH v4 1/1] Documentation/core-api: Add swiotlb documentation
Message-ID: <ZjNjE2KyLxdT0HSR@archie.me>
References: <20240501151651.2912-1-mhklinux@outlook.com>
 <20240502055205.GA28436@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="50akDxSaI0gtHRzG"
Content-Disposition: inline
In-Reply-To: <20240502055205.GA28436@lst.de>


--50akDxSaI0gtHRzG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2024 at 07:52:05AM +0200, Christoph Hellwig wrote:
> Thanks,
>=20
> applied to the dma-mapping tree for 6.10.
>=20

Hi Christoph,

I see the applied commit [1] and it seems like my Reviewed-by: trailer only
have my identity without 'Reviewed-by:' prefix. Care to fix it up?

Thanks.

[1]: https://git.infradead.org/?p=3Dusers/hch/dma-mapping.git;a=3Dcommit;h=
=3D5a1d9682fa4e43c1083f3aaf00bc0cea03c997f6

--=20
An old man doll... just what I always wanted! - Clara

--50akDxSaI0gtHRzG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZjNjDwAKCRD2uYlJVVFO
o296AQDKPO2TVa1/51CPheUeFYeLk8t6YY4YHh0LF8RG/z6/WAD/bpgdfLQ3vnvi
f59evQ1ImDqni9lU4vS5Is2zT1YDggI=
=460q
-----END PGP SIGNATURE-----

--50akDxSaI0gtHRzG--

