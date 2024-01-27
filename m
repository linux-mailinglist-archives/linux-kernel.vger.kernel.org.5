Return-Path: <linux-kernel+bounces-41251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF3783EE01
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA4AF2830BB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314C42940B;
	Sat, 27 Jan 2024 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1qFzL5u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245F328DAB;
	Sat, 27 Jan 2024 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706369947; cv=none; b=l7Q5UQdkHieWO4IJzABhlH9IR7f58Ah+eY2ERLFdSTYCaEMrmz60DISai5AJndjfDRphco3k4E0Zws1Bc9jDtiZGo5CvzUy/BbCEELxXnQD8dI+vFepclOMH5hboJU6Rs3IJdkKbGK3HH8HG5WYt+/OIIOHwwV1SOm+WdfcziRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706369947; c=relaxed/simple;
	bh=lb9Uaffl5vXy1p3Zzot+RjOxBbBWyqOBeptq65PZiNA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ACLHfkhyTIRJRVBBlCBq5mMORl20vLqMeg3JKfLV0MSKNVGiaaIZdgwMAqTv3SzbYJBrEtSUmYqHL/54cobHA5L4XY2SrXaJ90LIcpAY2bv9OxsEWiCY+0PRbBZpArKvKHWRUafXNpLPlsDa9bpuPuB40Nn4z+MeZVndyRrnmQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1qFzL5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C60C433C7;
	Sat, 27 Jan 2024 15:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706369946;
	bh=lb9Uaffl5vXy1p3Zzot+RjOxBbBWyqOBeptq65PZiNA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E1qFzL5utrew6nOuVychcFUAQGBdldyVcGQWW+eD75whSHhJFL8YucUYSB4SOEmjs
	 Fa+wgP5OgCVF9SRmmzOwsR60qAnVQNNkPzXuilXRWuBsQVM7oIjrHV2/WI/KwGSbD6
	 fSiLPHU5lAx4uF1EZSKtsnXX8gNZTHLHg6wzfFkPQ5UW3rutxH1PzgbPnOumryGd67
	 ZPsThJLsnQZxp/SJxa+LBnQBjR0NEoILeq4bJEnWeN02qTBx7QUimijzVfHaAhrgb8
	 /kc/09hsjyV0eFeRLHD8eSE1YMv2vOhVjebkeKgpJzLgorMPFc/FXDqpnGylLS75i6
	 KH0LFpIyFxTDg==
Date: Sat, 27 Jan 2024 15:38:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Gradinariu <ramona.gradinariu@analog.com>
Cc: <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nuno.sa@analog.com>,
 <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] docs: iio: add documentation for adis16475
 driver
Message-ID: <20240127153853.02d4f0d2@jic23-huawei>
In-Reply-To: <20240123150029.465443-2-ramona.gradinariu@analog.com>
References: <20240123150029.465443-1-ramona.gradinariu@analog.com>
	<20240123150029.465443-2-ramona.gradinariu@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jan 2024 17:00:29 +0200
Ramona Gradinariu <ramona.gradinariu@analog.com> wrote:

> Add documentation for adis16475 driver which describes
> the driver device files and shows how the user may use the
> ABI for various scenarios (configuration, measurement, etc.).

hi Ramona,

I'm not against more documentation in the tree, but I'd like
a little info in this patch description for why you feel this
particular driver needs it?  Fine to argue they all do if that's
the reasoning!

To be useful I think we need some more detail on the raw data
from the chardev readout and that perhaps belongs in some generic
docs (fine to use this driver as an example).

Thanks,

Jonathan

>=20
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> ---
> changes in v2:
>  - added adis16475 documentation file to iio index.rst file
>  Documentation/iio/adis16475.rst | 327 ++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst     |   2 +
>  2 files changed, 329 insertions(+)
>  create mode 100644 Documentation/iio/adis16475.rst
>=20
> diff --git a/Documentation/iio/adis16475.rst b/Documentation/iio/adis1647=
5.rst
> new file mode 100644
> index 000000000000..9af054f4af79
> --- /dev/null
> +++ b/Documentation/iio/adis16475.rst
> @@ -0,0 +1,327 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +ADIS16475 driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This driver supports Analog Device's IMUs on SPI bus.
> +
> +1. Supported devices
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +* `ADIS16465 <https://www.analog.com/ADIS16465>`_
> +* `ADIS16467 <https://www.analog.com/ADIS16467>`_
> +* `ADIS16470 <https://www.analog.com/ADIS16470>`_
> +* `ADIS16475 <https://www.analog.com/ADIS16475>`_
> +* `ADIS16477 <https://www.analog.com/ADIS16477>`_
> +* `ADIS16500 <https://www.analog.com/ADIS16500>`_
> +* `ADIS16505 <https://www.analog.com/ADIS16505>`_
> +* `ADIS16507 <https://www.analog.com/ADIS16507>`_
> +
> +Each supported device is a precision, miniature microelectromechanical s=
ystem
> +(MEMS) inertial measurement unit (IMU) that includes a triaxial gyroscop=
e and a
> +triaxial accelerometer. Each inertial sensor in the IMU device combines =
with
> +signal conditioning that optimizes dynamic performance. The factory cali=
bration
> +characterizes each sensor for sensitivity, bias, alignment, linear accel=
eration
> +(gyroscope bias), and point of percussion (accelerometer location). As a=
 result,
> +each sensor has dynamic compensation formulas that provide accurate sens=
or
> +measurements over a broad set of conditions.
> +
> +2. Device attributes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Accelerometer, gyroscope measures are always provided. Furthermore, the =
driver
> +offers the capability to retrieve the delta angle and the delta velocity
> +measurements computed by the device.
> +
> +The delta angle measurements represent a calculation of angular displace=
ment
> +between each sample update, while  the delta velocity measurements repre=
sent a
> +calculation of linear velocity change between each sample update.
> +
> +Finally, temperature data are provided which show a coarse measurement of
> +the temperature inside of the IMU device. This data is most useful for
> +monitoring relative changes in the thermal environment.
> +
> +The signal chain of each inertial sensor (accelerometers and

Wrapping is inconsistent. Please tidy that up so that for all the normal te=
xt you
wrap at same line length - this paragraph seems 10 chars shorter than the p=
revious
one.

> +gyroscopes) includes the application of unique correction
> +formulas, which are derived from extensive characterization
> +of bias, sensitivity, alignment, response to linear acceleration
> +(gyroscopes), and point of percussion (accelerometer location)
> +over a temperature range of =E2=88=9240=C2=B0C to +85=C2=B0C, for each A=
DIS device.
> +These correction formulas are not accessible, but users do have
> +the opportunity to adjust the bias for each sensor individually
> +through the calibbias attribute.
> +
> ++-------------------------------------------+---------------------------=
-------------------------------+
> +| 3-Axis Accelerometer related device files | Description               =
                               |
> ++-------------------------------------------+---------------------------=
-------------------------------+
> +| in_accel_scale                            | Scale for the acceleromete=
r channels.                    |

Probably good to add a sentence explaining where these files are - I'm gues=
sing they are just the ones in the
iio\:deviceX directory and not the sub-directories below that.

> ++-------------------------------------------+---------------------------=
-------------------------------+
> +| in_accel_x_calibbias                      | Calibration offset for the=
 X-axis accelerometer channel. |
> ++-------------------------------------------+---------------------------=
-------------------------------+
> +| accel_calibbias_x                         | x-axis acceleration offset=
 correction                    |
> ++-------------------------------------------+---------------------------=
-------------------------------+
> +| in_accel_x_raw                            | Raw X-axis accelerometer c=
hannel value.                  |
> ++-------------------------------------------+---------------------------=
-------------------------------+
> +| accel_calibbias_y                         | y-axis acceleration offset=
 correction                    |

no in_ prefix?

> ++-------------------------------------------+---------------------------=
-------------------------------+
> +| in_accel_y_raw                            | Raw Y-axis accelerometer c=
hannel value.                  |
> ++-------------------------------------------+---------------------------=
-------------------------------+
> +| in_accel_z_calibbias                      | Calibration offset for the=
 Z-axis accelerometer channel. |
> ++-------------------------------------------+---------------------------=
-------------------------------+
> +| in_accel_z_raw                            | Raw Z-axis accelerometer c=
hannel value.                  |
> ++-------------------------------------------+---------------------------=
-------------------------------+
> +| in_deltavelocity_scale                    | Scale for delta velocity c=
hannels.                       |
> ++-------------------------------------------+---------------------------=
-------------------------------+
> +| in_deltavelocity_x_raw                    | Raw X-axis delta velocity =
channel value.                 |
> ++-------------------------------------------+---------------------------=
-------------------------------+
> +| in_deltavelocity_y_raw                    | Raw Y-axis delta velocity =
channel value.                 |
> ++-------------------------------------------+---------------------------=
-------------------------------+
> +| in_deltavelocity_z_raw                    | Raw Z-axis delta velocity =
channel value.                 |
> ++-------------------------------------------+---------------------------=
-------------------------------+
> +
> ++---------------------------------------+-------------------------------=
-----------------------+
> +| 3-Axis Gyroscope related device files | Description                   =
                       |
> ++---------------------------------------+-------------------------------=
-----------------------+
> +| in_anglvel_scale                      | Scale for the gyroscope channe=
ls.                    |
> ++---------------------------------------+-------------------------------=
-----------------------+
> +| in_anglvel_x_calibbias                | Calibration offset for the X-a=
xis gyroscope channel. |
> ++---------------------------------------+-------------------------------=
-----------------------+
> +| anglvel_calibbias_x                   | x-axis gyroscope offset correc=
tion                   |

A before, I think there is a in_ prefix on all these.

> ++---------------------------------------+-------------------------------=
-----------------------+
> +| in_anglvel_x_raw                      | Raw X-axis gyroscope channel v=
alue.                  |
> ++---------------------------------------+-------------------------------=
-----------------------+
..


> +Usage examples
> +--------------
> +
> +Set trigger if not available:

What do you mean by not available?


> +Obtain buffered data:
> +
> +.. code-block:: bash
> +
> +        root:/sys/bus/iio/devices/iio:device0> hexdump /dev/iio\:device0
> +        ...
> +        0044760 3901 0000 ffff f9fe ffff 29ee 0100 f79b
> +        0044770 3901 0000 ffff 98fe ffff 1aef 0100 439a
> +        0044780 3901 0000 ffff b4fe ffff 32ef 0100 c199
> +        0044790 3901 0000 ffff bdfe ffff 20ef 0100 5f9a
> +        00447a0 3901 0000 ffff 37ff ffff 1eef 0100 389b
> +        00447b0 3901 0000 ffff 7dff ffff 96ee 0100 5a9c
> +        ...
I'd use hexdump -C to list them byte wise - otherwise endian effects make
this rather incomprehensible.

Also if you want to list the raw data, good to explain what the various par=
ts are
and how that is derived from the info in scan_elements.
That might be best done in a separate document though that is then referred=
 to from
here. I don't think we have such a userspace document, having long relied on
people figuring it out from the example tools or using google to find talks=
 various
folk have given (or the ADI wiki which might have stuff on this?)


> diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
> index 1b7292c58cd0..0087c0dafe59 100644
> --- a/Documentation/iio/index.rst
> +++ b/Documentation/iio/index.rst
> @@ -12,3 +12,5 @@ Industrial I/O
>     ep93xx_adc
>=20
>     bno055
> +
> +   adis16475

Hmm. It's already in a random order but let's not make it worse to fix that=
 up.
Put this before the bno055.

If you want to add some more formatting to this, say to add some section ti=
tles and
that would be great as a separate patch.

> --
> 2.34.1
>=20


