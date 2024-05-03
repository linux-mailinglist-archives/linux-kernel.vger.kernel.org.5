Return-Path: <linux-kernel+bounces-167172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1B28BA531
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52B97B22A34
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F31134A9;
	Fri,  3 May 2024 02:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ckB/vBx1"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3758C15EA6
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 02:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714702221; cv=none; b=pUyV+KCZjZnLzJsUC4cdlPWIUppXbnr5Pa37dLPoRWaJ5WCegzEKWcECO1jX+XBeSfS8Fm6idILL63qBGuGuQ7diUrRbETJcFif1fef7xxAgZZMdeewEuiW/JlOQiYa3IrXdGNiVypZkd97eWopsToOQCzY9DCQFR+J/0rS4Ztw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714702221; c=relaxed/simple;
	bh=ieLBr6/IYFcn6t7k6XuoPCRq8o4KqB6aE6sXX22Nd5I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=SIIX8tG67jvqDdqZMHzLyF3BriMkkgbYiIzBgs4AYdlN23bGE/7ZXkVB7ELQYjvgdl6nign/xyWBmxHSFyG4BwUfGhTFKaFTM+FIZ2F6EtPPMbBKeaVXvjFeSlxRy4rtqNpHvR+/620c3DyPz5fT/4IfDiiQ+9FyyN526bp23RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ckB/vBx1; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714702216;
	bh=n68WkGVbpGy+aHNVtuIjgeXFbeAyPm747S0XI3zZ+5k=;
	h=Date:From:To:Cc:Subject:From;
	b=ckB/vBx1ryKsNzJIo1psFKy8vhJn1HhbcYertQU9MuT+CahMaqOO/UtWwsLamPkNg
	 5NxJhDrFIkEBSYbCivs5hQ3LTPoFVtF3oXvcSmds9T1NSz112bJ1Wqjpds3g6labpE
	 P2nHefvnM2RJ6ddn3B2tASXz9K/yFfOEMTjjwxtPGKrfkJimvhY24gSTkvURFzya95
	 mI569ngs0IhaiQIeeNEoRLmzeprBca8YYzdwSExfjgzAWVitU9Vtisl9LtZs4PukxP
	 JfcrJWXDnwyGDhSBpc05gFtLN7VqEHLDtNzK3jr3CdqmiDmdR+mtPfAf3IqnVKfkfp
	 N7/QkhezOp9WQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VVvQc0kV0z4wd3;
	Fri,  3 May 2024 12:10:16 +1000 (AEST)
Date: Fri, 3 May 2024 12:10:12 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>, Linux
 kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix the address of the linuxppc-dev mailing list
Message-ID: <20240503121012.3ba5000b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lzX__LisPjheF3F.3a+quwQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/lzX__LisPjheF3F.3a+quwQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

This list was moved many years ago.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 14 +++++++-------
 .../ABI/testing/sysfs-firmware-opal-powercap       |  4 ++--
 Documentation/ABI/testing/sysfs-firmware-opal-psr  |  4 ++--
 .../ABI/testing/sysfs-firmware-opal-sensor-groups  |  4 ++--
 .../testing/sysfs-firmware-papr-energy-scale-info  | 10 +++++-----
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documenta=
tion/ABI/testing/sysfs-devices-system-cpu
index 710d47be11e0..e7e160954e79 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -423,7 +423,7 @@ What:		/sys/devices/system/cpu/cpuX/cpufreq/throttle_st=
ats
 		/sys/devices/system/cpu/cpuX/cpufreq/throttle_stats/occ_reset
 Date:		March 2016
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
-		Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+		Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
 Description:	POWERNV CPUFreq driver's frequency throttle stats directory a=
nd
 		attributes
=20
@@ -473,7 +473,7 @@ What:		/sys/devices/system/cpu/cpufreq/policyX/throttle=
_stats
 		/sys/devices/system/cpu/cpufreq/policyX/throttle_stats/occ_reset
 Date:		March 2016
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
-		Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+		Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
 Description:	POWERNV CPUFreq driver's frequency throttle stats directory a=
nd
 		attributes
=20
@@ -608,7 +608,7 @@ Description:	Umwait control
 What:		/sys/devices/system/cpu/svm
 Date:		August 2019
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
-		Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+		Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
 Description:	Secure Virtual Machine
=20
 		If 1, it means the system is using the Protected Execution
@@ -617,7 +617,7 @@ Description:	Secure Virtual Machine
=20
 What:		/sys/devices/system/cpu/cpuX/purr
 Date:		Apr 2005
-Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
 Description:	PURR ticks for this CPU since the system boot.
=20
 		The Processor Utilization Resources Register (PURR) is
@@ -628,7 +628,7 @@ Description:	PURR ticks for this CPU since the system b=
oot.
=20
 What: 		/sys/devices/system/cpu/cpuX/spurr
 Date:		Dec 2006
-Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
 Description:	SPURR ticks for this CPU since the system boot.
=20
 		The Scaled Processor Utilization Resources Register
@@ -640,7 +640,7 @@ Description:	SPURR ticks for this CPU since the system =
boot.
=20
 What: 		/sys/devices/system/cpu/cpuX/idle_purr
 Date:		Apr 2020
-Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
 Description:	PURR ticks for cpuX when it was idle.
=20
 		This sysfs interface exposes the number of PURR ticks
@@ -648,7 +648,7 @@ Description:	PURR ticks for cpuX when it was idle.
=20
 What: 		/sys/devices/system/cpu/cpuX/idle_spurr
 Date:		Apr 2020
-Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
 Description:	SPURR ticks for cpuX when it was idle.
=20
 		This sysfs interface exposes the number of SPURR ticks
diff --git a/Documentation/ABI/testing/sysfs-firmware-opal-powercap b/Docum=
entation/ABI/testing/sysfs-firmware-opal-powercap
index c9b66ec4f165..d2d12ee89288 100644
--- a/Documentation/ABI/testing/sysfs-firmware-opal-powercap
+++ b/Documentation/ABI/testing/sysfs-firmware-opal-powercap
@@ -1,6 +1,6 @@
 What:		/sys/firmware/opal/powercap
 Date:		August 2017
-Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
 Description:	Powercap directory for Powernv (P8, P9) servers
=20
 		Each folder in this directory contains a
@@ -11,7 +11,7 @@ What:		/sys/firmware/opal/powercap/system-powercap
 		/sys/firmware/opal/powercap/system-powercap/powercap-max
 		/sys/firmware/opal/powercap/system-powercap/powercap-current
 Date:		August 2017
-Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
 Description:	System powercap directory and attributes applicable for
 		Powernv (P8, P9) servers
=20
diff --git a/Documentation/ABI/testing/sysfs-firmware-opal-psr b/Documentat=
ion/ABI/testing/sysfs-firmware-opal-psr
index cc2ece70e365..1e55b56a0f89 100644
--- a/Documentation/ABI/testing/sysfs-firmware-opal-psr
+++ b/Documentation/ABI/testing/sysfs-firmware-opal-psr
@@ -1,6 +1,6 @@
 What:		/sys/firmware/opal/psr
 Date:		August 2017
-Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
 Description:	Power-Shift-Ratio directory for Powernv P9 servers
=20
 		Power-Shift-Ratio allows to provide hints the firmware
@@ -10,7 +10,7 @@ Description:	Power-Shift-Ratio directory for Powernv P9 s=
ervers
=20
 What:		/sys/firmware/opal/psr/cpu_to_gpu_X
 Date:		August 2017
-Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
 Description:	PSR sysfs attributes for Powernv P9 servers
=20
 		Power-Shift-Ratio between CPU and GPU for a given chip
diff --git a/Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups b/=
Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups
index 3a2dfe542e8c..fcb1fb4795b6 100644
--- a/Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups
+++ b/Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups
@@ -1,6 +1,6 @@
 What:		/sys/firmware/opal/sensor_groups
 Date:		August 2017
-Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
 Description:	Sensor groups directory for POWER9 powernv servers
=20
 		Each folder in this directory contains a sensor group
@@ -11,7 +11,7 @@ Description:	Sensor groups directory for POWER9 powernv s=
ervers
=20
 What:		/sys/firmware/opal/sensor_groups/<sensor_group_name>/clear
 Date:		August 2017
-Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
 Description:	Sysfs file to clear the min-max of all the sensors
 		belonging to the group.
=20
diff --git a/Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-inf=
o b/Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info
index 141a6b371469..f5cefb81ac9d 100644
--- a/Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info
+++ b/Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info
@@ -1,6 +1,6 @@
 What:		/sys/firmware/papr/energy_scale_info
 Date:		February 2022
-Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
 Description:	Directory hosting a set of platform attributes like
 		energy/frequency on Linux running as a PAPR guest.
=20
@@ -10,20 +10,20 @@ Description:	Directory hosting a set of platform attrib=
utes like
=20
 What:		/sys/firmware/papr/energy_scale_info/<id>
 Date:		February 2022
-Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
 Description:	Energy, frequency attributes directory for POWERVM servers
=20
 What:		/sys/firmware/papr/energy_scale_info/<id>/desc
 Date:		February 2022
-Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
 Description:	String description of the energy attribute of <id>
=20
 What:		/sys/firmware/papr/energy_scale_info/<id>/value
 Date:		February 2022
-Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
 Description:	Numeric value of the energy attribute of <id>
=20
 What:		/sys/firmware/papr/energy_scale_info/<id>/value_desc
 Date:		February 2022
-Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
 Description:	String value of the energy attribute of <id>
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/lzX__LisPjheF3F.3a+quwQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmY0R4QACgkQAVBC80lX
0Gy+gAgAhsTT7c+xBCswmFvn0UzyW93DLamr9jsckEWtL+GmqWyopiLEHe8QtjHL
rSv5jHYE1/x9u72Z0VVEaT07PiN+1N4tqX1r6unGL44ZTyxnzjwVN1FUY2WEdVYE
WSHLZCfNdXC7BklCzg4zKrfz8NYQCJ7GLIUAR0LzE6xhEnhqN39U1dMjMF+wd/fS
DtewZ/kHcTx5Va7wbkAXCGZPnFClJOyZKteRko5c8C38wL2ZOc1WinvN2Vw4cXPy
5dqgNXmS4W+nw/5vMwFCNdJCglDRShePGBWVZZm9kQ0FHL4yQQEqmbn8D2FOHDI6
7h6XzKYZoyPK7NpfsmmOAjMxsj12yA==
=myDB
-----END PGP SIGNATURE-----

--Sig_/lzX__LisPjheF3F.3a+quwQ--

