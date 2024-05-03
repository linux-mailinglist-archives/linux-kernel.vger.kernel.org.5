Return-Path: <linux-kernel+bounces-167538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBA88BAB0B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F538B22C2C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527F5152183;
	Fri,  3 May 2024 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="UUg9zGqV"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B88152182
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714733568; cv=none; b=gP1BRJTi65Xl92QzUIGYACRICxB75O+zSQKSz1xepnF/Jf83jwZ9LzI0lD4T0C8uuDv3ixHXrBJhTs3AehO3YSERmfIbT9mFWgblfXhKXGTb5xpPy3mUK6yj3F32HeI+JsqQLVUsfJ2dv5cFVi3HFJVhK0GGfXKat+Vnb+m66rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714733568; c=relaxed/simple;
	bh=rQZxfPb2JvxUkeWxTZNN47NK7WjEzCfRAr/is13VCYQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XYMFRc6ETPxjRwPjH6oBRRLSMdTwqvUGLPWnaHTonpRK+my+qgykDWlinOwKizy4Ojbii7nGlWF+WQlJYjx+J5zuyvr6PitkKT8NsJHofbhp8WumlFKXoPmAYHVb38eO41OvKJTwmDAkpNQLToojCJPDVx/H2nmbfpdRIjbTlVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=UUg9zGqV; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1714733563;
	bh=ZfARJMAeGDHwnZr6jfrWnf7G0nl1Vx+4p8TBupYAP6o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UUg9zGqV+ytbffMvCVS4hkNJIluh/NOrs7h6CuV+eD39RrpcbOvTBd0cEIn5iCcDX
	 WIqe/qqYuTfVkwcNpQXWCBMIJAUePcYyav0Rr33fookbEY5QGOldaDvU/XsE8OdLEr
	 rOzEQAjbsSqvBdNalODkfDIRLukSNmUA3ghhqyYLzVnU6FnSEiCO08246ZFLvAB02H
	 J0eLhXUIl9rC+IftNynU9RufML6sGvzAAdZoXE0muQy5xQwkS9APiIu1UkymfIqmfN
	 96kt6hHTHGD98QtQbu+4GfAhJDWKOds0QU9OLwE5UVrNjqaCcduZPoZFx+XwhmZoLe
	 KBuxApvwjnGJA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VW71R4qZBz4x0C;
	Fri,  3 May 2024 20:52:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>, Linux
 kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix the address of the linuxppc-dev mailing list
In-Reply-To: <20240503121012.3ba5000b@canb.auug.org.au>
References: <20240503121012.3ba5000b@canb.auug.org.au>
Date: Fri, 03 May 2024 20:52:43 +1000
Message-ID: <87ikzvupz8.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> This list was moved many years ago.
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  Documentation/ABI/testing/sysfs-devices-system-cpu | 14 +++++++-------
>  .../ABI/testing/sysfs-firmware-opal-powercap       |  4 ++--
>  Documentation/ABI/testing/sysfs-firmware-opal-psr  |  4 ++--
>  .../ABI/testing/sysfs-firmware-opal-sensor-groups  |  4 ++--
>  .../testing/sysfs-firmware-papr-energy-scale-info  | 10 +++++-----
>  5 files changed, 18 insertions(+), 18 deletions(-)

These are mostly powerpc specific files so I can take this.

cheers

> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 710d47be11e0..e7e160954e79 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -423,7 +423,7 @@ What:		/sys/devices/system/cpu/cpuX/cpufreq/throttle_stats
>  		/sys/devices/system/cpu/cpuX/cpufreq/throttle_stats/occ_reset
>  Date:		March 2016
>  Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> -		Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> +		Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
>  Description:	POWERNV CPUFreq driver's frequency throttle stats directory and
>  		attributes
>  
> @@ -473,7 +473,7 @@ What:		/sys/devices/system/cpu/cpufreq/policyX/throttle_stats
>  		/sys/devices/system/cpu/cpufreq/policyX/throttle_stats/occ_reset
>  Date:		March 2016
>  Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> -		Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> +		Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
>  Description:	POWERNV CPUFreq driver's frequency throttle stats directory and
>  		attributes
>  
> @@ -608,7 +608,7 @@ Description:	Umwait control
>  What:		/sys/devices/system/cpu/svm
>  Date:		August 2019
>  Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> -		Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> +		Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
>  Description:	Secure Virtual Machine
>  
>  		If 1, it means the system is using the Protected Execution
> @@ -617,7 +617,7 @@ Description:	Secure Virtual Machine
>  
>  What:		/sys/devices/system/cpu/cpuX/purr
>  Date:		Apr 2005
> -Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> +Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
>  Description:	PURR ticks for this CPU since the system boot.
>  
>  		The Processor Utilization Resources Register (PURR) is
> @@ -628,7 +628,7 @@ Description:	PURR ticks for this CPU since the system boot.
>  
>  What: 		/sys/devices/system/cpu/cpuX/spurr
>  Date:		Dec 2006
> -Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> +Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
>  Description:	SPURR ticks for this CPU since the system boot.
>  
>  		The Scaled Processor Utilization Resources Register
> @@ -640,7 +640,7 @@ Description:	SPURR ticks for this CPU since the system boot.
>  
>  What: 		/sys/devices/system/cpu/cpuX/idle_purr
>  Date:		Apr 2020
> -Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> +Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
>  Description:	PURR ticks for cpuX when it was idle.
>  
>  		This sysfs interface exposes the number of PURR ticks
> @@ -648,7 +648,7 @@ Description:	PURR ticks for cpuX when it was idle.
>  
>  What: 		/sys/devices/system/cpu/cpuX/idle_spurr
>  Date:		Apr 2020
> -Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> +Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
>  Description:	SPURR ticks for cpuX when it was idle.
>  
>  		This sysfs interface exposes the number of SPURR ticks
> diff --git a/Documentation/ABI/testing/sysfs-firmware-opal-powercap b/Documentation/ABI/testing/sysfs-firmware-opal-powercap
> index c9b66ec4f165..d2d12ee89288 100644
> --- a/Documentation/ABI/testing/sysfs-firmware-opal-powercap
> +++ b/Documentation/ABI/testing/sysfs-firmware-opal-powercap
> @@ -1,6 +1,6 @@
>  What:		/sys/firmware/opal/powercap
>  Date:		August 2017
> -Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> +Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
>  Description:	Powercap directory for Powernv (P8, P9) servers
>  
>  		Each folder in this directory contains a
> @@ -11,7 +11,7 @@ What:		/sys/firmware/opal/powercap/system-powercap
>  		/sys/firmware/opal/powercap/system-powercap/powercap-max
>  		/sys/firmware/opal/powercap/system-powercap/powercap-current
>  Date:		August 2017
> -Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> +Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
>  Description:	System powercap directory and attributes applicable for
>  		Powernv (P8, P9) servers
>  
> diff --git a/Documentation/ABI/testing/sysfs-firmware-opal-psr b/Documentation/ABI/testing/sysfs-firmware-opal-psr
> index cc2ece70e365..1e55b56a0f89 100644
> --- a/Documentation/ABI/testing/sysfs-firmware-opal-psr
> +++ b/Documentation/ABI/testing/sysfs-firmware-opal-psr
> @@ -1,6 +1,6 @@
>  What:		/sys/firmware/opal/psr
>  Date:		August 2017
> -Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> +Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
>  Description:	Power-Shift-Ratio directory for Powernv P9 servers
>  
>  		Power-Shift-Ratio allows to provide hints the firmware
> @@ -10,7 +10,7 @@ Description:	Power-Shift-Ratio directory for Powernv P9 servers
>  
>  What:		/sys/firmware/opal/psr/cpu_to_gpu_X
>  Date:		August 2017
> -Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> +Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
>  Description:	PSR sysfs attributes for Powernv P9 servers
>  
>  		Power-Shift-Ratio between CPU and GPU for a given chip
> diff --git a/Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups b/Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups
> index 3a2dfe542e8c..fcb1fb4795b6 100644
> --- a/Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups
> +++ b/Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups
> @@ -1,6 +1,6 @@
>  What:		/sys/firmware/opal/sensor_groups
>  Date:		August 2017
> -Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> +Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
>  Description:	Sensor groups directory for POWER9 powernv servers
>  
>  		Each folder in this directory contains a sensor group
> @@ -11,7 +11,7 @@ Description:	Sensor groups directory for POWER9 powernv servers
>  
>  What:		/sys/firmware/opal/sensor_groups/<sensor_group_name>/clear
>  Date:		August 2017
> -Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> +Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
>  Description:	Sysfs file to clear the min-max of all the sensors
>  		belonging to the group.
>  
> diff --git a/Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info b/Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info
> index 141a6b371469..f5cefb81ac9d 100644
> --- a/Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info
> +++ b/Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info
> @@ -1,6 +1,6 @@
>  What:		/sys/firmware/papr/energy_scale_info
>  Date:		February 2022
> -Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> +Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
>  Description:	Directory hosting a set of platform attributes like
>  		energy/frequency on Linux running as a PAPR guest.
>  
> @@ -10,20 +10,20 @@ Description:	Directory hosting a set of platform attributes like
>  
>  What:		/sys/firmware/papr/energy_scale_info/<id>
>  Date:		February 2022
> -Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> +Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
>  Description:	Energy, frequency attributes directory for POWERVM servers
>  
>  What:		/sys/firmware/papr/energy_scale_info/<id>/desc
>  Date:		February 2022
> -Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> +Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
>  Description:	String description of the energy attribute of <id>
>  
>  What:		/sys/firmware/papr/energy_scale_info/<id>/value
>  Date:		February 2022
> -Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> +Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
>  Description:	Numeric value of the energy attribute of <id>
>  
>  What:		/sys/firmware/papr/energy_scale_info/<id>/value_desc
>  Date:		February 2022
> -Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> +Contact:	Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>
>  Description:	String value of the energy attribute of <id>
> -- 
> 2.43.0
>
> -- 
> Cheers,
> Stephen Rothwell

