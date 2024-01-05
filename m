Return-Path: <linux-kernel+bounces-17518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2582824EC5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C8A1F22FA9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 06:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E177D1D685;
	Fri,  5 Jan 2024 06:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="i84fdpBQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A254B134A2;
	Fri,  5 Jan 2024 06:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704437266;
	bh=QuD06miG5znzX30LcOa9pZChwLNyidD3r2vpNG4arBI=;
	h=Date:From:To:Cc:Subject:From;
	b=i84fdpBQZQRuEGchW9ukoqdzoetB31eLTMIqOfR7QiDMaUdBy9MWLYIuYoAw7nyan
	 03QGxCWeSG6XEnD7UknwiD5GiwnpY+fs+T7FGEivpr2BdXeKcuZf5nVhQkLseGszcx
	 6l6/RTe2PHmxTuqjy1TyPMbsYu+RCXsiD3tKG1hA2lNw+PyqJpVXQehJNaQRolIjMP
	 FZmHNPfY/p9c4r9orpt0O9A7nWJiTgeoG9I222of1xBGnNy07k2U5wMSJxl505IEkj
	 qJF+UwzhadhZjr7Zh9XWEOVg7CoCvzbP5ObtJfcF0RvXVDLUzbht6d3QuBwN89HyE+
	 KUYqBxrdxA+SQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T5vCk1l2nz4wc3;
	Fri,  5 Jan 2024 17:47:46 +1100 (AEDT)
Date: Fri, 5 Jan 2024 17:47:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Airlie <airlied@redhat.com>
Cc: DRI <dri-devel@lists.freedesktop.org>, Badal Nilawar
 <badal.nilawar@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the drm tree
Message-ID: <20240105174745.78b94cb5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rkRETbW9831YEoYRya/g0r1";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/rkRETbW9831YEoYRya/g0r1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm tree, today's linux-next build (htmldocs) produced
this warning:

Warning: /sys/devices/.../hwmon/hwmon<i>/curr1_crit is defined 2 times:  /h=
ome/s
fr/next/next/Documentation/ABI/testing/sysfs-driver-intel-xe-hwmon:35  /hom=
e/sfr
/next/next/Documentation/ABI/testing/sysfs-driver-intel-i915-hwmon:52
Warning: /sys/devices/.../hwmon/hwmon<i>/energy1_input is defined 2 times: =
 /hom
e/sfr/next/next/Documentation/ABI/testing/sysfs-driver-intel-xe-hwmon:54  /=
home/
sfr/next/next/Documentation/ABI/testing/sysfs-driver-intel-i915-hwmon:65
Warning: /sys/devices/.../hwmon/hwmon<i>/in0_input is defined 2 times:  Doc=
umentation/ABI/testing/sysfs-driver-intel-xe-hwmon:46  Documentation/ABI/te=
sting/sysfs-driver-intel-i915-hwmon:0
Warning: /sys/devices/.../hwmon/hwmon<i>/power1_crit is defined 2 times:  D=
ocumentation/ABI/testing/sysfs-driver-intel-xe-hwmon:22  Documentation/ABI/=
testing/sysfs-driver-intel-i915-hwmon:39
Warning: /sys/devices/.../hwmon/hwmon<i>/power1_max is defined 2 times:  Do=
cumentation/ABI/testing/sysfs-driver-intel-xe-hwmon:0  Documentation/ABI/te=
sting/sysfs-driver-intel-i915-hwmon:8
Warning: /sys/devices/.../hwmon/hwmon<i>/power1_max_interval is defined 2 t=
imes:  Documentation/ABI/testing/sysfs-driver-intel-xe-hwmon:62  Documentat=
ion/ABI/testing/sysfs-driver-intel-i915-hwmon:30
Warning: /sys/devices/.../hwmon/hwmon<i>/power1_rated_max is defined 2 time=
s:  Documentation/ABI/testing/sysfs-driver-intel-xe-hwmon:14  Documentation=
/ABI/testing/sysfs-driver-intel-i915-hwmon:22

Introduced by commits

  fb1b70607f73 ("drm/xe/hwmon: Expose power attributes")
  92d44a422d0d ("drm/xe/hwmon: Expose card reactive critical power")
  fbcdc9d3bf58 ("drm/xe/hwmon: Expose input voltage attribute")
  71d0a32524f9 ("drm/xe/hwmon: Expose hwmon energy attribute")
  4446fcf220ce ("drm/xe/hwmon: Expose power1_max_interval")

--=20
Cheers,
Stephen Rothwell

--Sig_/rkRETbW9831YEoYRya/g0r1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWXphEACgkQAVBC80lX
0GwDDAf/QdADyYbs+140wMJtVkmhoQPgkhOHtW1xoAcLSnkkm5WdPowFB6ahUWrm
Ckcnra2MKY9FXmERQ08PgWRbUT/M1am7JKzUdkOseO3a3+F4md8zEwhAKP2NvDZp
1IFL328TJzXYSIPxkokLjMAEDwz7Rfv+myQ5b8x8mQgmrxa+2VLFfYCRdoaTTpIC
1W2A3EU2gZ6/+xFJHrnv0YsYX78w3N9CdfIoMVGtnqc2pnyo2tspjIdK1ro8/8Hb
SYop9p8wGbKM42/lA39kS0L4v6v/CcAHeyHN2nkNazD1hNvFj3+AjbD18gygYi8/
MYOOkujfj74YXppqxrZbGnfnL41RQw==
=1/CL
-----END PGP SIGNATURE-----

--Sig_/rkRETbW9831YEoYRya/g0r1--

