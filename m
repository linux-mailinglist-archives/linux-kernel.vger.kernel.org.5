Return-Path: <linux-kernel+bounces-129414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 381FC896A71
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E7B1F25BE9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089C873526;
	Wed,  3 Apr 2024 09:24:39 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631FB71733;
	Wed,  3 Apr 2024 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712136278; cv=none; b=Y6hNBPK2PB6nstY+ghQNh+bOhMvA6tQU2w0w5G8+J01kLEjlmshTZ+xaoeH6JS12QHS7zAc7iD+bSJuuspAty3uRFGYs72iWAnRXmkNVfPeb8sy069XTomP3U7UiFK26aU0XuK4OszN+Avz4mifOXViIQRT4M16lItJ5Pllnlmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712136278; c=relaxed/simple;
	bh=pm7dIFQwXucYzqD33rAnVqVYJE21H5+Id7HA8+ZLncw=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=XrUSM6xrYu6O3bUnMqWpZyVX7fpb/DEkt0Ct5vcSJ5lCimM/KpAxSvf9AJzMrmv+dKzXt7VHLXsE6YAdl6n1wX/YbrtVTr4Cqh/QQMR1PUT8IG0QJ22f0JGJTgZ3ZH39RBoFVjzRinL/PY+0djgCNxdoGW9W3rn63+Lj4knLkFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 0BDBA3782089;
	Wed,  3 Apr 2024 09:24:31 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240327225057.672304-1-shreeya.patel@collabora.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240327225057.672304-1-shreeya.patel@collabora.com>
Date: Wed, 03 Apr 2024 10:24:31 +0100
Cc: heiko@sntech.de, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de, shawn.wen@rock-chips.com, kernel@collabora.com, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org, linux-arm@lists.infradead.org
To: mchehab@kernel.org, hverkuil@xs4all.nl, hverkuil-cisco@xs4all.nl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <35e566-660d2080-1-7eb9eb00@16488675>
Subject: =?utf-8?q?Re=3A?= [PATCH v3 0/6] Add Synopsys DesignWare HDMI RX Controller
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Thursday, March 28, 2024 04:20 IST, Shreeya Patel <shreeya.patel@col=
labora.com> wrote:

> This series implements support for the Synopsys DesignWare
> HDMI RX Controller, being compliant with standard HDMI 1.4b
> and HDMI 2.0.
>=20

Hi Mauro and Hans,

I haven't received any reviews so far. Hence, this is just a gentle rem=
inder to review this patch series.


Thanks,
Shreeya Patel

> Features that are currently supported by the HDMI RX driver
> have been tested on rock5b board using a HDMI to micro-HDMI cable.
> It is recommended to use a good quality cable as there were
> multiple issues seen during testing the driver.
>=20
> Please note the below information :-
> * While testing the driver on rock5b we noticed that the binary BL31
> from Rockchip contains some unknown code to get the HDMI-RX PHY
> access working. With TF-A BL31, the HDMI-RX PHY doesn't work as
> expected since there are no interrupts seen for rk=5Fhdmirx-hdmi
> leading to some failures in the driver [0].
> * We have tested the working of OBS studio with HDMIRX driver and
> there were no issues seen.
> * We also tested and verified the support for interlaced video.
>=20
> [0] https://gitlab.collabora.com/hardware-enablement/rockchip-3588/tr=
usted-firmware-a/-/issues/1
>=20
> To test the HDMI RX Controller driver, following example commands can=
 be used :-
>=20
> root@debian-rockchip-rock5b-rk3588:~# v4l2-ctl --verbose -d /dev/vide=
o0 \
> --set-fmt-video=3Dwidth=3D1920,height=3D1080,pixelformat=3D'BGR3' --s=
tream-mmap=3D4 \
> --stream-skip=3D3 --stream-count=3D100 --stream-to=3D/home/hdmiin4k.r=
aw --stream-poll
>=20
> root@debian-rockchip-rock5b-rk3588:~# ffmpeg -f rawvideo -vcodec rawv=
ideo \
> -s 1920x1080 -r 60 -pix=5Ffmt bgr24 -i /home/hdmiin4k.raw output.mkv
>=20
>=20
> Following is the v4l2-compliance test result :-
>=20
> root@debian-rockchip-rock5b-rk3588:~# v4l2-compliance -d /dev/video0
> v4l2-compliance 1.27.0-5174, 64 bits, 64-bit time=5Ft
> v4l2-compliance SHA: d700deb14368 2024-01-18 12:19:05
>=20
> Compliance test for snps=5Fhdmirx device /dev/video0:
>=20
> Driver Info:
>         Driver name      : snps=5Fhdmirx
>         Card type        : snps=5Fhdmirx
>         Bus info         : platform: snps=5Fhdmirx
>         Driver version   : 6.8.0
>         Capabilities     : 0x84201000
>                 Video Capture Multiplanar
>                 Streaming
>                 Extended Pix Format
>                 Device Capabilities
>         Device Caps      : 0x04201000
>                 Video Capture Multiplanar
>                 Streaming
>                 Extended Pix Format
>=20
> Required ioctls:
>         test VIDIOC=5FQUERYCAP: OK
>         test invalid ioctls: OK
>=20
> Allow for multiple opens:
>         test second /dev/video0 open: OK
>         test VIDIOC=5FQUERYCAP: OK
>         test VIDIOC=5FG/S=5FPRIORITY: OK
>         test for unlimited opens: OK
>=20
> Debug ioctls:
>         test VIDIOC=5FDBG=5FG/S=5FREGISTER: OK (Not Supported)
>         test VIDIOC=5FLOG=5FSTATUS: OK
>=20
> Input ioctls:
>         test VIDIOC=5FG/S=5FTUNER/ENUM=5FFREQ=5FBANDS: OK (Not Suppor=
ted)
>         test VIDIOC=5FG/S=5FFREQUENCY: OK (Not Supported)
>         test VIDIOC=5FS=5FHW=5FFREQ=5FSEEK: OK (Not Supported)
>         test VIDIOC=5FENUMAUDIO: OK (Not Supported)
>         test VIDIOC=5FG/S/ENUMINPUT: OK
>         test VIDIOC=5FG/S=5FAUDIO: OK (Not Supported)
>         Inputs: 1 Audio Inputs: 0 Tuners: 0
>=20
> Output ioctls:
>         test VIDIOC=5FG/S=5FMODULATOR: OK (Not Supported)
>         test VIDIOC=5FG/S=5FFREQUENCY: OK (Not Supported)
>         test VIDIOC=5FENUMAUDOUT: OK (Not Supported)
>         test VIDIOC=5FG/S/ENUMOUTPUT: OK (Not Supported)
>         test VIDIOC=5FG/S=5FAUDOUT: OK (Not Supported)
>         Outputs: 0 Audio Outputs: 0 Modulators: 0
>=20
> Input/Output configuration ioctls:
>         test VIDIOC=5FENUM/G/S/QUERY=5FSTD: OK (Not Supported)
>         test VIDIOC=5FENUM/G/S/QUERY=5FDV=5FTIMINGS: OK
>         test VIDIOC=5FDV=5FTIMINGS=5FCAP: OK
>         test VIDIOC=5FG/S=5FEDID: OK
>=20
> Control ioctls (Input 0):
>         test VIDIOC=5FQUERY=5FEXT=5FCTRL/QUERYMENU: OK
>         test VIDIOC=5FQUERYCTRL: OK
>         test VIDIOC=5FG/S=5FCTRL: OK
>         test VIDIOC=5FG/S/TRY=5FEXT=5FCTRLS: OK
>         test VIDIOC=5F(UN)SUBSCRIBE=5FEVENT/DQEVENT: OK
>         test VIDIOC=5FG/S=5FJPEGCOMP: OK (Not Supported)
>         Standard Controls: 2 Private Controls: 0
>=20
> Format ioctls (Input 0):
>         test VIDIOC=5FENUM=5FFMT/FRAMESIZES/FRAMEINTERVALS: OK
>         test VIDIOC=5FG/S=5FPARM: OK
>         test VIDIOC=5FG=5FFBUF: OK (Not Supported)
>         test VIDIOC=5FG=5FFMT: OK
>         test VIDIOC=5FTRY=5FFMT: OK
>         test VIDIOC=5FS=5FFMT: OK
>         test VIDIOC=5FG=5FSLICED=5FVBI=5FCAP: OK (Not Supported)
>         test Cropping: OK (Not Supported)
>         test Composing: OK (Not Supported)
>         test Scaling: OK (Not Supported)
>=20
> Codec ioctls (Input 0):
>         test VIDIOC=5F(TRY=5F)ENCODER=5FCMD: OK (Not Supported)
>         test VIDIOC=5FG=5FENC=5FINDEX: OK (Not Supported)
>         test VIDIOC=5F(TRY=5F)DECODER=5FCMD: OK (Not Supported)
>=20
> Buffer ioctls (Input 0):
>         test VIDIOC=5FREQBUFS/CREATE=5FBUFS/QUERYBUF: OK
>         test CREATE=5FBUFS maximum buffers: OK
>         test VIDIOC=5FEXPBUF: OK
>         test Requests: OK (Not Supported)
>=20
> Total for snps=5Fhdmirx device /dev/video0: 46, Succeeded: 46, Failed=
: 0, Warnings: 0
>=20
> Changes in v3 :-
>   - Use v4l2-common helpers in the HDMIRX driver
>   - Rename cma node and phandle names
>   - Elaborate the comment to explain 160MiB calculation
>   - Move &hdmi=5Freceiver=5Fcma to the rock5b dts file
>   - Add information about interlaced video testing in the
>     cover-letter
>=20
> Changes in v2 :-
>   - Fix checkpatch --strict warnings
>   - Move the dt-binding include file changes in a separate patch
>   - Add a description for the hardware in the dt-bindings file
>   - Rename resets, vo1 grf and HPD properties
>   - Add a proper description for grf and vo1-grf phandles in the
>     bindings
>   - Rename the HDMI RX node name to hdmi-receiver
>   - Include gpio header file in binding example to fix the
>     dt=5Fbinding=5Fcheck failure
>   - Move hdmirx=5Fcma node to the rk3588.dtsi file
>   - Add an entry to MAINTAINERS file for the HDMIRX driver
>=20
> Shreeya Patel (6):
>   dt-bindings: reset: Define reset id used for HDMI Receiver
>   clk: rockchip: rst-rk3588: Add reset line for HDMI Receiver
>   dt-bindings: media: Document HDMI RX Controller
>   arm64: dts: rockchip: Add device tree support for HDMI RX Controlle=
r
>   media: platform: synopsys: Add support for hdmi input driver
>   MAINTAINERS: Add entry for Synopsys DesignWare HDMI RX Driver
>=20
>  .../bindings/media/snps,dw-hdmi-rx.yaml       |  132 +
>  MAINTAINERS                                   |    8 +
>  .../boot/dts/rockchip/rk3588-pinctrl.dtsi     |   41 +
>  .../boot/dts/rockchip/rk3588-rock-5b.dts      |   19 +
>  arch/arm64/boot/dts/rockchip/rk3588.dtsi      |   56 +
>  drivers/clk/rockchip/rst-rk3588.c             |    1 +
>  drivers/media/platform/Kconfig                |    1 +
>  drivers/media/platform/Makefile               |    1 +
>  drivers/media/platform/synopsys/Kconfig       |    3 +
>  drivers/media/platform/synopsys/Makefile      |    2 +
>  .../media/platform/synopsys/hdmirx/Kconfig    |   18 +
>  .../media/platform/synopsys/hdmirx/Makefile   |    4 +
>  .../platform/synopsys/hdmirx/snps=5Fhdmirx.c    | 2726 +++++++++++++=
++++
>  .../platform/synopsys/hdmirx/snps=5Fhdmirx.h    |  394 +++
>  .../synopsys/hdmirx/snps=5Fhdmirx=5Fcec.c         |  289 ++
>  .../synopsys/hdmirx/snps=5Fhdmirx=5Fcec.h         |   46 +
>  .../dt-bindings/reset/rockchip,rk3588-cru.h   |    2 +
>  17 files changed, 3743 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/snps,dw-h=
dmi-rx.yaml
>  create mode 100644 drivers/media/platform/synopsys/Kconfig
>  create mode 100644 drivers/media/platform/synopsys/Makefile
>  create mode 100644 drivers/media/platform/synopsys/hdmirx/Kconfig
>  create mode 100644 drivers/media/platform/synopsys/hdmirx/Makefile
>  create mode 100644 drivers/media/platform/synopsys/hdmirx/snps=5Fhdm=
irx.c
>  create mode 100644 drivers/media/platform/synopsys/hdmirx/snps=5Fhdm=
irx.h
>  create mode 100644 drivers/media/platform/synopsys/hdmirx/snps=5Fhdm=
irx=5Fcec.c
>  create mode 100644 drivers/media/platform/synopsys/hdmirx/snps=5Fhdm=
irx=5Fcec.h
>=20
> --=20
> 2.39.2
>=20
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> Kernel mailing list -- kernel@mailman.collabora.com
> To unsubscribe send an email to kernel-leave@mailman.collabora.com
> This list is managed by https://mailman.collabora.com


