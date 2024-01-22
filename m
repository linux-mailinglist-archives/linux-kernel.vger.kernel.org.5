Return-Path: <linux-kernel+bounces-34234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AB883760E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0DBB28454D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F6148CCE;
	Mon, 22 Jan 2024 22:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="oDBZ8SaT"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE9448CC0;
	Mon, 22 Jan 2024 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961964; cv=none; b=n8djckjB6o8nGQs8/F/9hhWvNShgffsJikkHiKLwS7tueR+e/yHU22zZtNwH66vcyAuAUvPSvxqa7F3R02xaqI5CeLjX2Bdt0wYJVNU5WOVC6QNmvS/jy4B5kvNNd28qrxImD/oaRNiEpbeY8Sj4fBLLq3FVA2VcdcnlG6zy16E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961964; c=relaxed/simple;
	bh=6QqaJa+R0eSslqaIYUHG9G5MoLVCrBrGnAwX9i1pi1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p0twrqWf2sAjrFiqixNexrqA522AdbbHiwfJAUV6hdvoQozfUKLJllKT4g59DIrEmMs77WiSzddYVXi89suwrqUbLb9vPAKl9gA7MwQ+aBku+eK/QQ2hEieGeAfvjnsoOD0zSVkJVqrl52qxsdy17ueEUJx2bBPSmJVwUNXE/Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=oDBZ8SaT; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (c-98-53-138-11.hsd1.co.comcast.net [98.53.138.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A02407AE7;
	Mon, 22 Jan 2024 22:19:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A02407AE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1705961959; bh=UCaHks5kiefiwx5cbHtEd3yYdX3zSyQmcLrd8ZN1uXw=;
	h=From:To:Cc:Subject:Date:From;
	b=oDBZ8SaTHJstT/aJhJbbXDVz4nSDbt4ocPtKBvsfYCGl3tq0q4zQcyVyoZV/8skAI
	 +cfRiN+nDAcqgDsk1v12o6l2ocFB6SUUjQvYDyWUBLc5pwVED4tSDk79VeMXitUsey
	 r5mbeHXGAK6ArhfiC8KKfZOWr0fIp59B5FoA8At2UVb2OHF4rDubk85yQvSpelELOp
	 /xARVKqnwLA1PPBoSO6L9FrTMh0NkuUl+6DmNIe8973uI1YnCUUyAWmhW/Ycg8cOw7
	 0cClROXo8iF13udpdWAA0Szw//hRtRQjuvW3Jdz8BsPyxO6zXrwnjwCOfnmI3TqDPF
	 5KaW+mBw0xpGw==
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] docs: rework the driver-api top-level page
Date: Mon, 22 Jan 2024 15:19:19 -0700
Message-ID: <87plxtm2oo.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add subsections in an attempt to bring a bit order to this page; also sort
most subsections into alphabetical order.  With luck all this will help to
prevent merge conflicts on this page due to everybody adding entries at the
end.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/driver-api/index.rst | 169 +++++++++++++++++------------
 1 file changed, 100 insertions(+), 69 deletions(-)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/=
index.rst
index eba851605388..f10decc2c14b 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -9,110 +9,141 @@ of device drivers.  This document is an only somewhat o=
rganized collection
 of some of those interfaces =E2=80=94 it will hopefully get better over ti=
me!  The
 available subsections can be seen below.
=20
+
+General information for driver authors
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+This section contains documentation that should, at some point or other, be
+of interest to most developers working on device drivers.
+
 .. toctree::
-   :caption: Table of contents
-   :maxdepth: 2
+   :maxdepth: 1
=20
-   driver-model/index
    basics
+   driver-model/index
+   device_link
    infrastructure
    ioctl
-   early-userspace/index
    pm/index
-   clk
+
+Useful support libraries
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+This section contains documentation that should, at some point or other, be
+of interest to most developers working on device drivers.
+
+.. toctree::
+   :maxdepth: 1
+
+   early-userspace/index
+   connector
    device-io
+   devfreq
    dma-buf
-   device_link
    component
-   message-based
-   infiniband
-   aperture
-   frame-buffer
-   regulator
-   reset
-   iio/index
-   input
-   usb/index
-   firewire
-   pci/index
+   io-mapping
+   io_ordering
+   uio-howto
+   vfio-mediated-device
+   vfio
+   vfio-pci-device-specific-driver-acceptance
+
+Bus-level documentation
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+.. toctree::
+   :maxdepth: 1
+
+   auxiliary_bus
    cxl/index
-   spi
-   i2c
-   ipmb
-   ipmi
+   eisa
+   firewire
    i3c/index
-   interconnect
-   devfreq
-   hsi
-   edac
-   scsi
-   libata
-   target
-   mailbox
-   mtdnand
-   miscellaneous
-   mei/index
-   mtd/index
-   mmc/index
-   nvdimm/index
-   w1
+   isa
+   men-chameleon-bus
+   pci/index
    rapidio/index
-   s390-drivers
+   slimbus
+   usb/index
+   virtio/index
    vme
+   w1
+   xillybus
+
+
+Subsystem-specific APIs
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+.. toctree::
+   :maxdepth: 1
+
    80211/index
-   uio-howto
+   acpi/index
+   backlight/lp855x-driver.rst
+   clk
+   console
+   crypto/index
+   dmaengine/index
+   dpll
+   edac
    firmware/index
-   pin-control
+   fpga/index
+   frame-buffer
+   aperture
+   generic-counter
    gpio/index
+   hsi
+   hte/index
+   i2c
+   iio/index
+   infiniband
+   input
+   interconnect
+   ipmb
+   ipmi
+   libata
+   mailbox
    md/index
    media/index
+   mei/index
+   memory-devices/index
+   message-based
    misc_devices
+   miscellaneous
+   mmc/index
+   mtd/index
+   mtdnand
    nfc/index
-   dmaengine/index
-   slimbus
-   soundwire/index
-   thermal/index
-   fpga/index
-   acpi/index
-   auxiliary_bus
-   backlight/lp855x-driver.rst
-   connector
-   console
-   eisa
-   isa
-   io-mapping
-   io_ordering
-   generic-counter
-   memory-devices/index
-   men-chameleon-bus
    ntb
+   nvdimm/index
    nvmem
    parport-lowlevel
+   phy/index
+   pin-control
+   pldmfw/index
    pps
    ptp
-   phy/index
    pwm
-   pldmfw/index
+   regulator
+   reset
    rfkill
+   s390-drivers
+   scsi
    serial/index
    sm501
+   soundwire/index
+   spi
    surface_aggregator/index
    switchtec
    sync_file
+   target
+   tee
+   thermal/index
    tty/index
-   vfio-mediated-device
-   vfio
-   vfio-pci-device-specific-driver-acceptance
-   virtio/index
+   wbrf
+   wmi
    xilinx/index
-   xillybus
    zorro
-   hte/index
-   wmi
-   dpll
-   wbrf
-   crypto/index
-   tee
=20
 .. only::  subproject and html
=20
--=20
2.43.0


