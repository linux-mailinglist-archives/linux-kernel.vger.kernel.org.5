Return-Path: <linux-kernel+bounces-11836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9469781EC57
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBCB5B21BEC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 05:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB4C46B8;
	Wed, 27 Dec 2023 05:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXxYV0A/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075814405
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 05:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28c17b6f91bso767361a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 21:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703656349; x=1704261149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xsm5Ju4rKSSyd/yy5bB4YOrfNpuRcRC6WiB2aAOy3+k=;
        b=gXxYV0A/PU+KP1pca6RwUJGKyXD0qSBXJRPwyQWipjSJ0cvTJlb5UkjknHdtUeNY7Q
         jnd1B9tuIdX/HvDM2hEPWE3hg3LsF4sWJLupb+VSxGvUWLZP5etfH9iHyXjNKoCPf6or
         fJPaUoDtRWDtr7xwGTC3TQFfx4X8kKHBt8RhuYXoq15NjQpFRRL50SIm+lVaByHvPLzh
         2VanEePu6uLmV3dfgGCBXMzAA03VAAwDO60fr+CKLBRp+INWB1acDb2hKTqDCG56p2qx
         ggDrhR63ZlXKo+DvqBZxCJDrYeWCjwQ1BK2h2RorQxVmPpvSyG6RnMAOBJMW9XB1BCbz
         +6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703656349; x=1704261149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xsm5Ju4rKSSyd/yy5bB4YOrfNpuRcRC6WiB2aAOy3+k=;
        b=vbMHR5OaRsWSYb1KE3cJLtXRBH+DiZ0wTejlrjfPKedqCwuQZuoP2iOp7ZDLnyXIwC
         YuMxW6/qXR/CeG+6yH5vn8hMfUnKwQAzFvR5sYDYvtjI5NBIC8h/FONzUUAe+H+Miq/7
         xMKwhWYqg2SKnX+6Ea3BotDBbp8l8baSjm84nfWQ9vJriyhmKaIWJiWGCBV5VJFahiF4
         /mDXZtqsf9oxxREL9n94YQvg9M0HO/L3+PN3IKDtr2MS5ODpatDZHIY+TIkFtFqSnHIO
         xP+rH93y1i+8Lut9FDnZ6r5lSv8NFUVQWKKMpl82QMqoKoss7PNWnOY20P4UzDA0NOXi
         vRBw==
X-Gm-Message-State: AOJu0YwFwIrXkmazXjAUb9quxBdeg2b8dmMJK9+kIWySybJByN6eMlT2
	gZrs8dWT35AIKZRRegIIOoM=
X-Google-Smtp-Source: AGHT+IExDYQd4jUOqkatAsAW34ElSyA+4kT9esf58JKswXuRFYVF514ypvVLQK7Ao04wa/jziw4ymg==
X-Received: by 2002:a17:90b:3c2:b0:28c:374f:8028 with SMTP id go2-20020a17090b03c200b0028c374f8028mr1108023pjb.27.1703656349153;
        Tue, 26 Dec 2023 21:52:29 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id e15-20020a170902ed8f00b001cfed5524easm11020411plj.288.2023.12.26.21.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 21:52:28 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id D253811564AAC; Wed, 27 Dec 2023 12:52:23 +0700 (WIB)
Date: Wed, 27 Dec 2023 12:52:23 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Marcelo Mendes <marcelomspessoto@gmail.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
	Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Removing duplicate copyright text
Message-ID: <ZYu7l9LiCJWdw0CB@archie.me>
References: <20231226235741.4376-1-marcelomspessoto@gmail.com>
 <ZYuMRZU85plJiVWO@archie.me>
 <CAB4W1t5GsDUEUT6m_qHeEBC=gnQxyebY8W0n5uF1GGAh5yLgtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7Tqr7xErRV4RDN7U"
Content-Disposition: inline
In-Reply-To: <CAB4W1t5GsDUEUT6m_qHeEBC=gnQxyebY8W0n5uF1GGAh5yLgtw@mail.gmail.com>


--7Tqr7xErRV4RDN7U
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 11:49:09PM -0300, Marcelo Mendes wrote:
> Hello Bagas,
>=20
> I'm sorry for that. I will send another mail of this patch with your
> recommendations.
>=20

Please don't top-post; reply inline with appropriate context instead.
And don't send HTML emails as mailing lists don't like such.

When sending v2 (aka rerolling), mark it as such when generating patches
by passing `-v 2` to git-format-patch(1). And don't be rushed to send
the reroll; wait at least a day to allow reviewers to review before
reroll. If there are any comments from them, you should address them too.

See you in v2!

--=20
An old man doll... just what I always wanted! - Clara

--7Tqr7xErRV4RDN7U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZYu7kwAKCRD2uYlJVVFO
o1UCAP9TiBj/fIiGJmgCvf+j92xuF8SnsZYURkswkTmiEAwilwEAkWigOnNnWcZC
aI05d64L0t/EMQKRKyZBMxZeDa5aRAU=
=OzmJ
-----END PGP SIGNATURE-----

--7Tqr7xErRV4RDN7U--

