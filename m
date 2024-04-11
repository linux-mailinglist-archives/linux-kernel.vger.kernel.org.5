Return-Path: <linux-kernel+bounces-140283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF318A1211
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9458828701F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3CD146D75;
	Thu, 11 Apr 2024 10:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/gF3M1M"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670841E48E;
	Thu, 11 Apr 2024 10:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832615; cv=none; b=rrfz0jqpIP0BhJKWvaFYu12kcAfnAiT4ZfcHkEGH4rv2lDa+AlIppd1pU9Gu9CGM2PqLdxuLVxSRS0QFsS6q5MkLmGFvjz84shXKwm/aRBbSIxf3FccwHHcvIH3/q0s8IrClPA9l2YPdw5HPL5KQRCtuTQj2xTDREsv9SjroCfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832615; c=relaxed/simple;
	bh=40G/2iJhs7b/9hSb3u6zcH2MWcwO6qO4lwKmJTuf4Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Msn660BqckxQO9m0grJ049l6oZVktQ6Yj7mGzrp9gyek7xCS8ms5dX3S5g3sv0Jz0a/oe3KqDYOx0ia4sjpjNifcmqd4YihZyjcgUH/V5gAe/W1nLOf/oR/roBTR8uBUE3rJ8z+lcKSaMELpbAV95LonU91h0oJSANYRgjgRIF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/gF3M1M; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e3c9300c65so48958875ad.0;
        Thu, 11 Apr 2024 03:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712832614; x=1713437414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0V8AVI188fF5AbLDUaefOD559npRcC/Ay2FvGZtxQ64=;
        b=c/gF3M1Mx8qsK02izeo+dBs3ax9p/1XTB/386WOg7gEipYGvlAqoV8oEk9RLPbILuY
         HPwz++6ftm+qM2UPAxJoB3wnV3Ex7pfxM3HDmIYP+9m6NKaHCyXxMu2XDyhMGn/R6mM+
         hgjhu1cGczlNdveKsQvMdvVEmgPfx4yXxPFaNi1u4tUzEZLWJTuwEk/31a3bDox+zpqf
         V90fHoQTKI260UZZDbEmtXFmYqmT+N/4K0qUhB2WNXlSDeWNGuWSfh/M8yjt7ydzmNlP
         GSup/s0qRSo9U/gNNES5KPqIRpyovvUqLNJVO+Bjf8uisYKo09XQm0kuPx9yuOpOk7q0
         9hzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712832614; x=1713437414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0V8AVI188fF5AbLDUaefOD559npRcC/Ay2FvGZtxQ64=;
        b=jdCKBvIbKfnn+mfFtRCgKCjMWtmPlQ5djPVtYHct7QoiOnmV5TRGgX5LUlcKsNlsXo
         W7SE48LTaXEcXuiOUwcPHJTPBieeDcIDne+jnhSc1VetQ0nEO7oniw6DVRjT7iWHCdIb
         xqwPulO9wyXr06kRSgdaXH45wh3yBCgmHuCl/JTqbiHKnA8N5pTIfAIMhfVzaLgwGu86
         iwuMt0oDUSe9GNmkZwiqDv4cxlNQ8uWNkg3U8b2K0u0pUcmbRO0WBBABba5UH6/h3C1Z
         rNaaIqNXEMM0uhnXZ8Da1D6UZiY1zV37Zo0wlyS+9H2pVr7uhveGbEo/ITVFyjgzuHD1
         g9rg==
X-Forwarded-Encrypted: i=1; AJvYcCXpe7R9OYJamZrl6RrSVa3iP066RvJTRtZzFJGOR9rId4wKlcDJiecU2GEflKGOkgYVyPf/LEHrobhGEi1zSN6foR+zV0rTbJMSJBJK55n2iYWIF79oMAsAVvRw4xf59H2OuStSjsdjbrLx8x5+bq+9neaShT9DaEdIQVgXKlsOYT2tU/ZV1AjS
X-Gm-Message-State: AOJu0YwsQ6Lv5/zL8ZU+mcANX5zrsXfHdokNKeFkpnQiqPu5GrscHZ3I
	OzkWDYhq15YtdH3/cUvS7/dpp5w4srvRA1MDZlQAjG40GvvdpASGyadVmg==
X-Google-Smtp-Source: AGHT+IEtQzHYcZhHF+ujcl2W4gfyTb2Kq41fyleepPcTD77/19WDgStiPTVulVfZQkv3bnNhXD/5EQ==
X-Received: by 2002:a17:903:18d:b0:1e5:62:7ac0 with SMTP id z13-20020a170903018d00b001e500627ac0mr4509674plg.14.1712832613536;
        Thu, 11 Apr 2024 03:50:13 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b001def175bbbfsm912997plk.251.2024.04.11.03.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 03:50:12 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 106E3184799FF; Thu, 11 Apr 2024 17:50:09 +0700 (WIB)
Date: Thu, 11 Apr 2024 17:50:09 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: Alexander Steffen <Alexander.Steffen@infineon.com>,
	"Daniel P . Smith" <dpsmith@apertussolutions.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Mimi Zohar <zohar@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>,
	Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation: tpm_tis
Message-ID: <ZhfAYVLwoYAPnYbI@archie.me>
References: <20240409190847.10869-1-jarkko@kernel.org>
 <20240409190847.10869-3-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QQMkQKtETCXLqH/I"
Content-Disposition: inline
In-Reply-To: <20240409190847.10869-3-jarkko@kernel.org>


--QQMkQKtETCXLqH/I
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2024 at 10:08:47PM +0300, Jarkko Sakkinen wrote:
> diff --git a/Documentation/security/tpm/tpm_tis.rst b/Documentation/secur=
ity/tpm/tpm_tis.rst
> new file mode 100644
> index 000000000000..b448ea3db71d
> --- /dev/null
> +++ b/Documentation/security/tpm/tpm_tis.rst
> @@ -0,0 +1,46 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +TPM FIFO interface driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +TCG PTP Specification defines two interface types: FIFO and CRB. The for=
mer is
> +based on sequenced read and write operations,  and the latter is based o=
n a
> +buffer containing the full command or response.
> +
> +FIFO (First-In-First-Out) interface is used by the tpm_tis_core dependent
> +drivers. Originally Linux had only a driver called tpm_tis, which covered
> +memory mapped (aka MMIO) interface but it was later on extended to cover=
 other
> +physical interfaces supported by the TCG standard.
> +
> +For legacy compliance the original MMIO driver is called tpm_tis and the
Did you mean "For historical reasons above ..."?
> +framework for FIFO drivers is named as tpm_tis_core. The postfix "tis" in
> +tpm_tis comes from the TPM Interface Specification, which is the hardware
> +interface specification for TPM 1.x chips.
> +
> +Communication is based on a 20 KiB buffer shared by the TPM chip through=
 a
> +hardware bus or memory map, depending on the physical wiring. The buffer=
 is
> +further split into five equal-size 4 KiB buffers, which provide equivale=
nt
> +sets of registers for communication between the CPU and TPM. These
> +communication endpoints are called localities in the TCG terminology.
> +
> +When the kernel wants to send commands to the TPM chip, it first reserves
> +locality 0 by setting the requestUse bit in the TPM_ACCESS register. The=
 bit is
> +cleared by the chip when the access is granted. Once it completes its
> +communication, the kernel writes the TPM_ACCESS.activeLocality bit. This
> +informs the chip that the locality has been relinquished.
> +
> +Pending localities are served in order by the chip in descending order, =
one at
> +a time:
> +
> +- Locality 0 has the lowest priority.
> +- Locality 5 has the highest priority.
> +
> +Further information on the purpose and meaning of the localities can be =
found
> +in section 3.2 of the TCG PC Client Platform TPM Profile Specification.
> +
> +References
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +TCG PC Client Platform TPM Profile (PTP) Specification
> +https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profil=
e-ptp-specification/

Other than that,

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--QQMkQKtETCXLqH/I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZhfAXQAKCRD2uYlJVVFO
oyTWAQDDh/ybYEQfUhhhVix+XJRKnyJS+qX3oVhOtCnaV4rdbwD/T7FQM2fd19g6
yntkKwA+0kOawAxi5rYvOITeNGaiTwo=
=eLHn
-----END PGP SIGNATURE-----

--QQMkQKtETCXLqH/I--

