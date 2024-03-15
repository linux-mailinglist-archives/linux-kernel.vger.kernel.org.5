Return-Path: <linux-kernel+bounces-104125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2311587C96E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4543C1F2265F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C0914A85;
	Fri, 15 Mar 2024 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8V6EKs6"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C5C8BEE;
	Fri, 15 Mar 2024 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710488604; cv=none; b=a3gm1vAQP5BdN742WFBXZUgwlE76pxRrsTbG+5Z1Y+Q1c3NjCsy8HXbLyvdSnAywihHYdEc4JTXyYQFi2QKh9I0RPVkKOqKdr+4RVAKvw4jHJQmUx4vptuT9knQOSMDM90p/XtT03sDEvQFE25SbNeA4xf4SAouzhNySRgA2xMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710488604; c=relaxed/simple;
	bh=Zw9S6hRNBlDHNXOavKPS6AU9Ku+D+1bxIk/tgYyDWOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTEW7ksPyAF4BvmQmc0yCb5wlaLkK179LzbFt/ZHbhG1PfFSohKs6jSwccyXeCbHtmKx+Rv2DiW191ebb6ZQ8fVbRkYq+IXDS2NRxLkR0GKkO4qWhLBKAURqN51SG+QQa39ugIkyKzmHUUXybbZbEcIu0FLhW9slE5m7ioQrzLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8V6EKs6; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a14d7f0e66so780482eaf.1;
        Fri, 15 Mar 2024 00:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710488601; x=1711093401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y+sKbEMgE5r6A8AgrakXmyb0PKCVFac2dOoteAq7k8o=;
        b=a8V6EKs6lFykvoYwT2bHwa6SDxwUQ031xBOd9vrfwrbqtiXtEH3e9ZaY7sVgsOWe0E
         0Y8LACcy0VHCArr2pnqZlCTJn0iAcLqEK4QWP3z1NzQ0ACP7kegCfZ8n4NBX25FpUgmQ
         w1F70hh10s7J2uWDyTnlb2WBybJCUI1W9OQ56KTAQFy+6E3Ufnk8B1/Wj6ELjeYtgByZ
         78PBgTZYS+l8IlmNfTTxJSzNoNa5pRFQPO+URsCso3EEe4JPpk0laGrc8bnp/u6giIbz
         6RHzIGVeVYn5AKbWDo8dORbNfJtyn8Ex1nNUq+2Kgx4FsDbEgZ8EiB5FamkkZkpsEylu
         bJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710488601; x=1711093401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+sKbEMgE5r6A8AgrakXmyb0PKCVFac2dOoteAq7k8o=;
        b=ldJM2bMZlzH7evl2k3O8NaVwOkn3+I/nvQ8gy2PkWZQIoZKIFtflb8sPTJo+xgnsck
         uLrOl3LKYwzHpCFUoAZ7/poN3uBecyvywn4h4ZghTBNzcWxK0F8WYa/82AcaYgtbEWXD
         jsp6m0QRCQ5knTaipNWZ6XTimcV25SiZJBOjH2bdCQbJE2vVkdpjz781mHwVTB4gnc96
         hkbDCN5hJvhJPKZAEasjnCHpIi+0xT3cKK8TBFUHsJ7ZBCfPGNzoQGRlQWpTMQ6dyeEq
         RhFpfjMiApSEHTokgFIiqdVw4RjEXWuoRDb/S3FxiSJMo/LHVILCbiyjRlU1H2rPYErg
         KSqg==
X-Forwarded-Encrypted: i=1; AJvYcCV1RzT84Vx3QnbmE8qVPihwC52dGUfMB4HQWRcvoN+HhDnuX9RIfPxf7urWH3DH8WS8oT0KvArhZ2VdbfQ745jy3p+ji2n9
X-Gm-Message-State: AOJu0YwVN/1d+NJ1iLPdJynESlltQbtfSU9R9o61EWCcmgK6dPEYP6oS
	ijVUCbbzg1nJqAUPQi2jEEtBUHWXwn5lCb8JBf9Wr7evfgoqaYxZ
X-Google-Smtp-Source: AGHT+IGLOQadiQa1j4OnHkg6nggd2mD2/umSTkBhGKXKQ/0a+Rz3wiHLhaz65dtf7FsJ2mLWjao4Tw==
X-Received: by 2002:a05:6870:f707:b0:221:ab60:da45 with SMTP id ej7-20020a056870f70700b00221ab60da45mr4510391oab.11.1710488601652;
        Fri, 15 Mar 2024 00:43:21 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id h4-20020aa786c4000000b006e6a3f52ee5sm2740197pfo.69.2024.03.15.00.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 00:43:20 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id B1BF0181043B9; Fri, 15 Mar 2024 14:43:18 +0700 (WIB)
Date: Fri, 15 Mar 2024 14:43:18 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2] lib/bitmap: Fix bitmap_scatter() and bitmap_gather()
 kernel doc
Message-ID: <ZfP8FowhZ3ZtSq2T@archie.me>
References: <20240314120006.458580-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Vkpw4sfr+qcOP7vO"
Content-Disposition: inline
In-Reply-To: <20240314120006.458580-1-herve.codina@bootlin.com>


--Vkpw4sfr+qcOP7vO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 01:00:06PM +0100, Herve Codina wrote:
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index fb3a9c93ac86..aa4096126553 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -522,17 +522,18 @@ static inline void bitmap_replace(unsigned long *ds=
t,
>   *
>   * (Bits 0, 1, 2, 3, 4, 5 are copied to the bits 0, 1, 4, 8, 9, 12)
>   *
> - * A more 'visual' description of the operation:
> - * src:  0000000001011010
> - *                 ||||||
> - *          +------+|||||
> - *          |  +----+||||
> - *          |  |+----+|||
> - *          |  ||   +-+||
> - *          |  ||   |  ||
> - * mask: ...v..vv...v..vv
> - *       ...0..11...0..10
> - * dst:  0000001100000010
> + * A more 'visual' description of the operation::
> + *
> + *	src:  0000000001011010
> + *	                ||||||
> + *	         +------+|||||
> + *	         |  +----+||||
> + *	         |  |+----+|||
> + *	         |  ||   +-+||
> + *	         |  ||   |  ||
> + *	mask: ...v..vv...v..vv
> + *	      ...0..11...0..10
> + *	dst:  0000001100000010
>   *
>   * A relationship exists between bitmap_scatter() and bitmap_gather().
>   * bitmap_gather() can be seen as the 'reverse' bitmap_scatter() operati=
on.
> @@ -568,16 +569,17 @@ static inline void bitmap_scatter(unsigned long *ds=
t, const unsigned long *src,
>   *
>   * (Bits 0, 1, 4, 8, 9, 12 are copied to the bits 0, 1, 2, 3, 4, 5)
>   *
> - * A more 'visual' description of the operation:
> - * mask: ...v..vv...v..vv
> - * src:  0000001100000010
> - *          ^  ^^   ^   0
> - *          |  ||   |  10
> - *          |  ||   > 010
> - *          |  |+--> 1010
> - *          |  +--> 11010
> - *          +----> 011010
> - * dst:  0000000000011010
> + * A more 'visual' description of the operation::
> + *
> + *	mask: ...v..vv...v..vv
> + *	src:  0000001100000010
> + *	         ^  ^^   ^   0
> + *	         |  ||   |  10
> + *	         |  ||   > 010
> + *	         |  |+--> 1010
> + *	         |  +--> 11010
> + *	         +----> 011010
> + *	dst:  0000000000011010
>   *
>   * A relationship exists between bitmap_gather() and bitmap_scatter(). S=
ee
>   * bitmap_scatter() for the bitmap scatter detailed operations.

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--Vkpw4sfr+qcOP7vO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZfP8EwAKCRD2uYlJVVFO
owRnAP9+A9A7YmJqbQ2uV2vnT+S7PoxF2bX1VkyDqbjfObqyFAEA2VkJEBlkBFez
dVNRdRo6w3txtpn1mAv+fYEFEEItYgY=
=2+Hm
-----END PGP SIGNATURE-----

--Vkpw4sfr+qcOP7vO--

