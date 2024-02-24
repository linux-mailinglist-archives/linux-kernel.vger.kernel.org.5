Return-Path: <linux-kernel+bounces-79780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02AF862694
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E4B1C20DE3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346DC487A9;
	Sat, 24 Feb 2024 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+9Ut7+r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6898BEA;
	Sat, 24 Feb 2024 18:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708798053; cv=none; b=ftfD/N4MdItbNQgGvtYRrkSG+fZ5yamjKVfP/xtVeoPu7iKnDxzbliymNMR7S0wPXHoiUZKW+BhQ8SHEs9UnryvlngecZuIWM0RLdZoFRNpBPmlIkXzzS5aHmT+15iw7MsAmBnQqFN5g2SwiSqomutV0gKPolu+kS7+OuMZfwOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708798053; c=relaxed/simple;
	bh=j4CWQvwXoXLrP75LrS9LUMLrpDMHuboafc52jXR154s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nSns/4JP6Cpy997+SNJTNK4WMsyU/3bAyRmboeVupkIQ3tFtfkhqCdhejmjwOhucHQQEZ5G7D2Zu027AD+4ZAPTB6Rbk/f5rQZ4dLgntoei4o1zhW17JzOJ4zUmOXoB3LUBpcM85/RFLW/j8Pa7OL1QxSkLR78NYSBCxER0LueY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+9Ut7+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E20C433F1;
	Sat, 24 Feb 2024 18:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708798053;
	bh=j4CWQvwXoXLrP75LrS9LUMLrpDMHuboafc52jXR154s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C+9Ut7+rXrlVjx1F0C6IoF6Jsai/Bkg6ByNtRXtw0kTO9tSqSxaBoDqbcSpbbgKQB
	 HlnErQ9mTtiNqfJIISBcn9pOdlB71vvE3OmtBUFv39dXIv0CFJ1FP0udwhex1WJ0Fz
	 TLTEFw4Lw7d/SyIdaPQWJYALU4YolLSlOHUaX6FAft1TvRP2Rci4JWdhFiATqW0fnO
	 t2TFEB5DmDwuzg9LmawQzIyXbBFOUIvctR3fsUYTc4GGETIpIvTfNcbw/TYQGocsjD
	 YaaPDSKJrvrv8isCCU1M2H7nX9Vj/LQbqyYHiWgeCE/DudvXJG/V9D01RPeeJvLuQB
	 aTyr9WGaTnrlA==
Date: Sat, 24 Feb 2024 18:07:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Gradinariu <ramona.gradinariu@analog.com>
Cc: <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nuno.sa@analog.com>,
 <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] docs: iio: add documentation for adis16475
 driver
Message-ID: <20240224180720.2a0076a9@jic23-huawei>
In-Reply-To: <20240221085848.991413-4-ramona.gradinariu@analog.com>
References: <20240221085848.991413-1-ramona.gradinariu@analog.com>
	<20240221085848.991413-4-ramona.gradinariu@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Feb 2024 10:58:48 +0200
Ramona Gradinariu <ramona.gradinariu@analog.com> wrote:

> Add documentation for adis16475 driver which describes
> the driver device files and shows how the user may use the
> ABI for various scenarios (configuration, measurement, etc.).
>=20
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>

Thanks for your work on this. Always good to see some attention paid to doc=
s!

Applied to the togreg branch of iio.git and pushed out initially as
testing.  I've no idea if 0-day does docs builds but maybe we will
find out if it finds any issues!

Thanks

Jonathan

> ---
> changes in v5:
>  - fixed various typos and inconsistencies
>  - used inline code format style where applicable
>  Documentation/iio/adis16475.rst | 406 ++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst     |   1 +
>  2 files changed, 407 insertions(+)
>  create mode 100644 Documentation/iio/adis16475.rst
>=20
> diff --git a/Documentation/iio/adis16475.rst b/Documentation/iio/adis1647=
5.rst
> new file mode 100644
> index 000000000000..b4c0917eabc4
> --- /dev/null
> +++ b/Documentation/iio/adis16475.rst
> @@ -0,0 +1,406 @@
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
> +Accelerometer, gyroscope measurements are always provided. Furthermore, =
the
> +driver offers the capability to retrieve the delta angle and the delta v=
elocity
> +measurements computed by the device.
> +
> +The delta angle measurements represent a calculation of angular displace=
ment
> +between each sample update, while the delta velocity measurements repres=
ent a
> +calculation of linear velocity change between each sample update.
> +
> +Finally, temperature data are provided which show a coarse measurement of
> +the temperature inside of the IMU device. This data is most useful for
> +monitoring relative changes in the thermal environment.
> +
> +The signal chain of each inertial sensor (accelerometers and gyroscopes)
> +includes the application of unique correction formulas, which are derive=
d from
> +extensive characterization of bias, sensitivity, alignment, response to =
linear
> +acceleration (gyroscopes), and point of percussion (accelerometer locati=
on)
> +over a temperature range of =E2=88=9240=C2=B0C to +85=C2=B0C, for each A=
DIS device. These
> +correction formulas are not accessible, but users do have the opportunit=
y to
> +adjust the bias for each sensor individually through the calibbias attri=
bute.
> +
> +Each IIO device, has a device folder under ``/sys/bus/iio/devices/iio:de=
viceX``,
> +where X is the IIO index of the device. Under these folders reside a set=
 of
> +device files, depending on the characteristics and features of the hardw=
are
> +device in questions. These files are consistently generalized and docume=
nted in
> +the IIO ABI documentation.
> +
> +The following tables show the adis16475 related device files, found in t=
he
> +specific device folder path ``/sys/bus/iio/devices/iio:deviceX``.
> +
> ++-------------------------------------------+---------------------------=
-------------------------------+
> +| 3-Axis Accelerometer related device files | Description               =
                               |
> ++-------------------------------------------+---------------------------=
-------------------------------+
> +| in_accel_scale                            | Scale for the acceleromete=
r channels.                    |
> ++-------------------------------------------+---------------------------=
-------------------------------+
> +| in_accel_x_calibbias                      | Calibration offset for the=
 X-axis accelerometer channel. |
> ++-------------------------------------------+---------------------------=
-------------------------------+
> +| in_accel_calibbias_x                      | x-axis acceleration offset=
 correction                    |
> ++-------------------------------------------+---------------------------=
-------------------------------+
> +| in_accel_x_raw                            | Raw X-axis accelerometer c=
hannel value.                  |
> ++-------------------------------------------+---------------------------=
-------------------------------+
> +| in_accel_calibbias_y                      | y-axis acceleration offset=
 correction                    |
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
> +| in_anglvel_calibbias_x                | x-axis gyroscope offset correc=
tion                   |
> ++---------------------------------------+-------------------------------=
-----------------------+
> +| in_anglvel_x_raw                      | Raw X-axis gyroscope channel v=
alue.                  |
> ++---------------------------------------+-------------------------------=
-----------------------+
> +| in_anglvel_calibbias_y                | y-axis gyroscope offset correc=
tion                   |
> ++---------------------------------------+-------------------------------=
-----------------------+
> +| in_anglvel_y_raw                      | Raw Y-axis gyroscope channel v=
alue.                  |
> ++---------------------------------------+-------------------------------=
-----------------------+
> +| in_anglvel_z_calibbias                | Calibration offset for the Z-a=
xis gyroscope channel. |
> ++---------------------------------------+-------------------------------=
-----------------------+
> +| in_anglvel_z_raw                      | Raw Z-axis gyroscope channel v=
alue.                  |
> ++---------------------------------------+-------------------------------=
-----------------------+
> +| in_deltaangl_scale                    | Scale for delta angle channels=
                      |
> ++---------------------------------------+-------------------------------=
-----------------------+
> +| in_deltaangl_x_raw                    | Raw X-axis delta angle channel=
 value.                |
> ++---------------------------------------+-------------------------------=
-----------------------+
> +| in_deltaangl_y_raw                    | Raw Y-axis delta angle channel=
 value.                |
> ++---------------------------------------+-------------------------------=
-----------------------+
> +| in_deltaangl_z_raw                    | Raw Z-axis delta angle channel=
 value.                |
> ++---------------------------------------+-------------------------------=
-----------------------+
> +
> ++----------------------------------+------------------------------------=
-------+
> +| Temperature sensor related files | Description                        =
       |
> ++----------------------------------+------------------------------------=
-------+
> +| in_temp0_raw                     | Raw temperature channel value.     =
       |
> ++----------------------------------+------------------------------------=
-------+
> +| in_temp0_scale                   | Scale for the temperature sensor ch=
annel. |
> ++----------------------------------+------------------------------------=
-------+
> +
> ++-------------------------------+---------------------------------------=
------------------+
> +| Miscellaneous device files    | Description                           =
                  |
> ++-------------------------------+---------------------------------------=
------------------+
> +| name                          | Name of the IIO device.               =
                  |
> ++-------------------------------+---------------------------------------=
------------------+
> +| sampling_frequency            | Currently selected sample rate.       =
                  |
> ++-------------------------------+---------------------------------------=
------------------+
> +| filter_low_pass_3db_frequency | Bandwidth for the accelerometer and gy=
roscope channels. |
> ++-------------------------------+---------------------------------------=
------------------+
> +
> +The following table shows the adis16475 related device debug files, foun=
d in the
> +specific device debug folder path ``/sys/kernel/debug/iio/iio:deviceX``.
> +
> ++----------------------+------------------------------------------------=
-------------------------+
> +| Debugfs device files | Description                                    =
                         |
> ++----------------------+------------------------------------------------=
-------------------------+
> +| serial_number        | The serial number of the chip in hexadecimal fo=
rmat.                    |
> ++----------------------+------------------------------------------------=
-------------------------+
> +| product_id           | Chip specific product id (e.g. 16475, 16500, 16=
505, etc.).              |
> ++----------------------+------------------------------------------------=
-------------------------+
> +| flash_count          | The number of flash writes performed on the dev=
ice.                     |
> ++----------------------+------------------------------------------------=
-------------------------+
> +| firmware_revision    | String containing the firmware revision in the =
following format ##.##.  |
> ++----------------------+------------------------------------------------=
-------------------------+
> +| firmware_date        | String containing the firmware date in the foll=
owing format mm-dd-yyyy. |
> ++----------------------+------------------------------------------------=
-------------------------+
> +
> +Channels processed values
> +-------------------------
> +
> +A channel value can be read from its _raw attribute. The value returned =
is the
> +raw value as reported by the devices. To get the processed value of the =
channel,
> +apply the following formula:
> +
> +.. code-block:: bash
> +
> +        processed value =3D (_raw + _offset) * _scale
> +
> +Where _offset and _scale are device attributes. If no _offset attribute =
is
> +present, simply assume its value is 0.
> +
> +The adis16475 driver offers data for 5 types of channels, the table belo=
w shows
> +the measurement units for the processed value, which are defined by the =
IIO
> +framework:
> +
> ++-------------------------------------+---------------------------+
> +| Channel type                        | Measurement unit          |
> ++-------------------------------------+---------------------------+
> +| Acceleration on X, Y, and Z axis    | Meters per Second squared |
> ++-------------------------------------+---------------------------+
> +| Angular velocity on X, Y and Z axis | Radians per second        |
> ++-------------------------------------+---------------------------+
> +| Delta velocity on X. Y, and Z axis  | Meters per Second         |
> ++-------------------------------------+---------------------------+
> +| Delta angle on X, Y, and Z axis     | Radians                   |
> ++-------------------------------------+---------------------------+
> +| Temperature                         | Millidegrees Celsius      |
> ++-------------------------------------+---------------------------+
> +
> +Usage examples
> +--------------
> +
> +Show device name:
> +
> +.. code-block:: bash
> +
> +	root:/sys/bus/iio/devices/iio:device0> cat name
> +        adis16505-2
> +
> +Show accelerometer channels value:
> +
> +.. code-block:: bash
> +
> +        root:/sys/bus/iio/devices/iio:device0> cat in_accel_x_raw
> +        -275924
> +        root:/sys/bus/iio/devices/iio:device0> cat in_accel_y_raw
> +        -30142222
> +        root:/sys/bus/iio/devices/iio:device0> cat in_accel_z_raw
> +        261265769
> +        root:/sys/bus/iio/devices/iio:device0> cat in_accel_scale
> +        0.000000037
> +
> +- X-axis acceleration =3D in_accel_x_raw * in_accel_scale =3D =E2=88=920=
010209188 m/s^2
> +- Y-axis acceleration =3D in_accel_y_raw * in_accel_scale =3D =E2=88=921=
115262214 m/s^2
> +- Z-axis acceleration =3D in_accel_z_raw * in_accel_scale =3D 9.66683345=
3 m/s^2
> +
> +Show gyroscope channels value:
> +
> +.. code-block:: bash
> +
> +        root:/sys/bus/iio/devices/iio:device0> cat in_anglvel_x_raw
> +        -3324626
> +        root:/sys/bus/iio/devices/iio:device0> cat in_anglvel_y_raw
> +        1336980
> +        root:/sys/bus/iio/devices/iio:device0> cat in_anglvel_z_raw
> +        -602983
> +        root:/sys/bus/iio/devices/iio:device0> cat in_anglvel_scale
> +        0.000000006
> +
> +- X-axis angular velocity =3D in_anglvel_x_raw * in_anglvel_scale =3D =
=E2=88=920.019947756 rad/s
> +- Y-axis angular velocity =3D in_anglvel_y_raw * in_anglvel_scale =3D 0.=
00802188 rad/s
> +- Z-axis angular velocity =3D in_anglvel_z_raw * in_anglvel_scale =3D =
=E2=88=920.003617898 rad/s
> +
> +Set calibration offset for accelerometer channels:
> +
> +.. code-block:: bash
> +
> +        root:/sys/bus/iio/devices/iio:device0> cat in_accel_x_calibbias
> +        0
> +
> +        root:/sys/bus/iio/devices/iio:device0> echo 5000 > in_accel_x_ca=
libbias
> +        root:/sys/bus/iio/devices/iio:device0> cat in_accel_x_calibbias
> +        5000
> +
> +Set calibration offset for gyroscope channels:
> +
> +.. code-block:: bash
> +
> +        root:/sys/bus/iio/devices/iio:device0> cat in_anglvel_y_calibbias
> +        0
> +
> +        root:/sys/bus/iio/devices/iio:device0> echo -5000 > in_anglvel_y=
_calibbias
> +        root:/sys/bus/iio/devices/iio:device0> cat in_anglvel_y_calibbias
> +        -5000
> +
> +Set sampling frequency:
> +
> +.. code-block:: bash
> +
> +	root:/sys/bus/iio/devices/iio:device0> cat sampling_frequency
> +        2000.000000
> +
> +        root:/sys/bus/iio/devices/iio:device0> echo 1000 > sampling_freq=
uency
> +        1000.000000
> +
> +Set bandwidth for accelerometer and gyroscope:
> +
> +.. code-block:: bash
> +
> +        root:/sys/bus/iio/devices/iio:device0> cat filter_low_pass_3db_f=
requency
> +        720
> +
> +        root:/sys/bus/iio/devices/iio:device0> echo 360 > filter_low_pas=
s_3db_frequency
> +        root:/sys/bus/iio/devices/iio:device0> cat filter_low_pass_3db_f=
requency
> +        360
> +
> +Show serial number:
> +
> +.. code-block:: bash
> +
> +        root:/sys/kernel/debug/iio/iio:device0> cat serial_number
> +        0x04f9
> +
> +Show product id:
> +
> +.. code-block:: bash
> +
> +        root:/sys/kernel/debug/iio/iio:device0> cat product_id
> +        16505
> +
> +Show flash count:
> +
> +.. code-block:: bash
> +
> +        root:/sys/kernel/debug/iio/iio:device0> cat flash_count
> +        150
> +
> +Show firmware revision:
> +
> +.. code-block:: bash
> +
> +        root:/sys/kernel/debug/iio/iio:device0> cat firmware_revision
> +        1.6
> +
> +Show firmware date:
> +
> +.. code-block:: bash
> +
> +        root:/sys/kernel/debug/iio/iio:device0> cat firmware_date
> +        06-27-2019
> +
> +3. Device buffers
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This driver supports IIO buffers.
> +
> +All devices support retrieving the raw acceleration, gyroscope and tempe=
rature
> +measurements using buffers.
> +
> +The following device families also support retrieving the delta velocity=
, delta
> +angle and temperature measurements using buffers:
> + - ADIS16477
> + - ADIS16500
> + - ADIS16505
> + - ADIS16507
> +
> +However, when retrieving acceleration or gyroscope data using buffers, d=
elta
> +readings will not be available and vice versa.
> +
> +Usage examples
> +--------------
> +
> +Set device trigger in current_trigger, if not already set:
> +
> +.. code-block:: bash
> +
> +        root:/sys/bus/iio/devices/iio:device0> cat trigger/current_trigg=
er
> +
> +        root:/sys/bus/iio/devices/iio:device0> echo adis16505-2-dev0 > t=
rigger/current_trigger
> +        root:/sys/bus/iio/devices/iio:device0> cat trigger/current_trigg=
er
> +        adis16505-2-dev0
> +
> +Select channels for buffer read:
> +
> +.. code-block:: bash
> +
> +        root:/sys/bus/iio/devices/iio:device0> echo 1 > scan_elements/in=
_deltavelocity_x_en
> +        root:/sys/bus/iio/devices/iio:device0> echo 1 > scan_elements/in=
_deltavelocity_y_en
> +        root:/sys/bus/iio/devices/iio:device0> echo 1 > scan_elements/in=
_deltavelocity_z_en
> +        root:/sys/bus/iio/devices/iio:device0> echo 1 > scan_elements/in=
_temp0_en
> +
> +Set the number of samples to be stored in the buffer:
> +
> +.. code-block:: bash
> +
> +        root:/sys/bus/iio/devices/iio:device0> echo 10 > buffer/length
> +
> +Enable buffer readings:
> +
> +.. code-block:: bash
> +
> +        root:/sys/bus/iio/devices/iio:device0> echo 1 > buffer/enable
> +
> +Obtain buffered data:
> +
> +.. code-block:: bash
> +
> +        root:/sys/bus/iio/devices/iio:device0> hexdump -C /dev/iio\:devi=
ce0
> +        ...
> +        00001680  01 1f 00 00 ff ff fe ef  00 00 47 bf 00 03 35 55  |...=
......G...5U|
> +        00001690  01 1f 00 00 ff ff ff d9  00 00 46 f1 00 03 35 35  |...=
......F...55|
> +        000016a0  01 1f 00 00 ff ff fe fc  00 00 46 cb 00 03 35 7b  |...=
......F...5{|
> +        000016b0  01 1f 00 00 ff ff fe 41  00 00 47 0d 00 03 35 8b  |...=
...A..G...5.|
> +        000016c0  01 1f 00 00 ff ff fe 37  00 00 46 b4 00 03 35 90  |...=
...7..F...5.|
> +        000016d0  01 1d 00 00 ff ff fe 5a  00 00 45 d7 00 03 36 08  |...=
...Z..E...6.|
> +        000016e0  01 1b 00 00 ff ff fe fb  00 00 45 e7 00 03 36 60  |...=
......E...6`|
> +        000016f0  01 1a 00 00 ff ff ff 17  00 00 46 bc 00 03 36 de  |...=
......F...6.|
> +        00001700  01 1a 00 00 ff ff fe 59  00 00 46 d7 00 03 37 b8  |...=
...Y..F...7.|
> +        00001710  01 1a 00 00 ff ff fe ae  00 00 46 95 00 03 37 ba  |...=
......F...7.|
> +        00001720  01 1a 00 00 ff ff fe c5  00 00 46 63 00 03 37 9f  |...=
......Fc..7.|
> +        00001730  01 1a 00 00 ff ff fe 55  00 00 46 89 00 03 37 c1  |...=
...U..F...7.|
> +        00001740  01 1a 00 00 ff ff fe 31  00 00 46 aa 00 03 37 f7  |...=
...1..F...7.|
> +        ...
> +
> +See ``Documentation/iio/iio_devbuf.rst`` for more information about how =
buffered
> +data is structured.
> +
> +4. IIO Interfacing Tools
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Linux Kernel Tools
> +------------------
> +
> +Linux Kernel provides some userspace tools that can be used to retrieve =
data
> +from IIO sysfs:
> +
> +* lsiio: example application that provides a list of IIO devices and tri=
ggers
> +* iio_event_monitor: example application that reads events from an IIO d=
evice
> +  and prints them
> +* iio_generic_buffer: example application that reads data from buffer
> +* iio_utils: set of APIs, typically used to access sysfs files.
> +
> +LibIIO
> +------
> +
> +LibIIO is a C/C++ library that provides generic access to IIO devices. T=
he
> +library abstracts the low-level details of the hardware, and provides a =
simple
> +yet complete programming interface that can be used for advanced project=
s.
> +
> +For more information about LibIIO, please see:
> +https://github.com/analogdevicesinc/libiio
> diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
> index 206a0aff5ca1..30b09eefe75e 100644
> --- a/Documentation/iio/index.rst
> +++ b/Documentation/iio/index.rst
> @@ -16,5 +16,6 @@ Industrial I/O Kernel Drivers
>  .. toctree::
>     :maxdepth: 1
>=20
> +   adis16475
>     bno055
>     ep93xx_adc
> --
> 2.34.1
>=20


