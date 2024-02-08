Return-Path: <linux-kernel+bounces-57819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE07784DDC3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6365A1F2793D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601E771B37;
	Thu,  8 Feb 2024 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="r3NepsB4"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CF76F52C;
	Thu,  8 Feb 2024 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386539; cv=none; b=joxRCCvjxUiW3Z6zXZozblfzforQl/xoqz5c9eth/Vxa12QoN3KloHeRxaJEwTsSyQdOvLF41IL6+obuKhBR9jR1KNhCxr64RhdIr0mEch6UxEkKHS25wnCZ2DivA5l11cneGEytGRDHhht4iWZ0bQxRNrCpg4MHqFFqPYlZt5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386539; c=relaxed/simple;
	bh=wUU8oXmdiWmXJLlUmgxStWBf9+aonx9F1Wn9AEb7Hjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lf3R4hlx9a7NBAGTpXF+5rQjD7fMCz7MHyyUqko0uzWV+rovSok+f3V2Sfixiwpb0IIkLW64JDRdsPtswF3qHDiYJJNFtlXYHboXSSgLI5fUOEz3BRo1PvPWVQH1ircDcdhj2StZpHLLe7sCpIAAB1W6QW9FR6HWRg2pPPDasfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=r3NepsB4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41890KCS016257;
	Thu, 8 Feb 2024 05:02:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=DKIM;
	 bh=OODgPUbIiiX/r5s0AOv2sTN9wJH2slykPTsA27jtMoY=; b=r3NepsB4015m
	c1m7RYA3goj0JfaQb8Fa/EaBOBmwFgAPMGSy4mVBkge4Zh2hFnEpQ4nFEbwAFtRq
	Fk45M1IjFBTlMZLzMuYKznd50YqNC4aNHhUe4AsyACSZFM8JOCUC4XhRDbxHmYp3
	9Mj6/zeQoL5Ui9crl37ELUjJKqV045zx7DLJbvHVJ7cyeuiQaUAgmgeh8iwprntz
	fIWkS3kwCCZPJ3eFxdJjsKmhfxdTkRPQd6VH940W9DBMag//n6sqnj0dQyBi9U+N
	U8yfV9BL6xnx8saKh1KYC3xiPRoLIGfEs1huEAB2Qih4QR5KtxyNDUOfSk0kgxPO
	8CfBMPEjhA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3w4uxnr703-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 05:02:13 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 418A2Crc053260
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 05:02:12 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 8 Feb 2024 05:02:11 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 8 Feb 2024 05:01:47 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 8 Feb 2024 05:01:47 -0500
Received: from rbolboac.ad.analog.com ([10.48.65.135])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 418A1UNr027963;
	Thu, 8 Feb 2024 05:01:38 -0500
From: Ramona Gradinariu <ramona.gradinariu@analog.com>
To: <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>
CC: Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH v3 3/3] docs: iio: add documentation for adis16475 driver
Date: Thu, 8 Feb 2024 12:01:26 +0200
Message-ID: <20240208100126.183697-4-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208100126.183697-1-ramona.gradinariu@analog.com>
References: <20240208100126.183697-1-ramona.gradinariu@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 6Puik1dAj2zr2zFicsJRNQfruXdmb7JD
X-Proofpoint-GUID: 6Puik1dAj2zr2zFicsJRNQfruXdmb7JD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402080052

Add documentation for adis16475 driver which describes
the driver device files and shows how the user may use the
ABI for various scenarios (configuration, measurement, etc.).

Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
---
changes in v3:
 - fixed wrapping
 - added sentence showing device files location
 - fixed typo in device file names by adding the in_ prefix
 - added new section for channels processed values
 - rephrased the trigger setting section
 - gave reference to iio_devbuf documentation for raw data
 Documentation/iio/adis16475.rst | 381 ++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst     |   1 +
 2 files changed, 382 insertions(+)
 create mode 100644 Documentation/iio/adis16475.rst

diff --git a/Documentation/iio/adis16475.rst b/Documentation/iio/adis16475.rst
new file mode 100644
index 000000000000..192ec1225de5
--- /dev/null
+++ b/Documentation/iio/adis16475.rst
@@ -0,0 +1,381 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+ADIS16475 driver
+================
+
+This driver supports Analog Device's IMUs on SPI bus.
+
+1. Supported devices
+====================
+
+* `ADIS16465 <https://www.analog.com/ADIS16465>`_
+* `ADIS16467 <https://www.analog.com/ADIS16467>`_
+* `ADIS16470 <https://www.analog.com/ADIS16470>`_
+* `ADIS16475 <https://www.analog.com/ADIS16475>`_
+* `ADIS16477 <https://www.analog.com/ADIS16477>`_
+* `ADIS16500 <https://www.analog.com/ADIS16500>`_
+* `ADIS16505 <https://www.analog.com/ADIS16505>`_
+* `ADIS16507 <https://www.analog.com/ADIS16507>`_
+
+Each supported device is a precision, miniature microelectromechanical system
+(MEMS) inertial measurement unit (IMU) that includes a triaxial gyroscope and a
+triaxial accelerometer. Each inertial sensor in the IMU device combines with
+signal conditioning that optimizes dynamic performance. The factory calibration
+characterizes each sensor for sensitivity, bias, alignment, linear acceleration
+(gyroscope bias), and point of percussion (accelerometer location). As a result,
+each sensor has dynamic compensation formulas that provide accurate sensor
+measurements over a broad set of conditions.
+
+2. Device attributes
+====================
+
+Accelerometer, gyroscope measures are always provided. Furthermore, the driver
+offers the capability to retrieve the delta angle and the delta velocity
+measurements computed by the device.
+
+The delta angle measurements represent a calculation of angular displacement
+between each sample update, while  the delta velocity measurements represent a
+calculation of linear velocity change between each sample update.
+
+Finally, temperature data are provided which show a coarse measurement of
+the temperature inside of the IMU device. This data is most useful for
+monitoring relative changes in the thermal environment.
+
+The signal chain of each inertial sensor (accelerometers and gyroscopes)
+includes the application of unique correction formulas, which are derived from
+extensive characterization of bias, sensitivity, alignment, response to linear
+acceleration (gyroscopes), and point of percussion (accelerometer location)
+over a temperature range of −40°C to +85°C, for each ADIS device. These
+correction formulas are not accessible, but users do have the opportunity to
+adjust the bias for each sensor individually through the calibbias attribute.
+
+Each IIO device, has a device folder under /sys/bus/iio/devices/iio:deviceX,
+where X is the IIO index of the device. Under these folders reside a set of
+device files, depending on the characteristics and features of the hardware
+device in questions. These files are consistently generalized and documented in
+the IIO ABI documentation.
+
+The following tables show the adis16475 related device files, found in the
+specific device folder path /sys/bus/iio/devices/iio:deviceX.
+
++-------------------------------------------+----------------------------------------------------------+
+| 3-Axis Accelerometer related device files | Description                                              |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_scale                            | Scale for the accelerometer channels.                    |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_x_calibbias                      | Calibration offset for the X-axis accelerometer channel. |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_calibbias_x                      | x-axis acceleration offset correction                    |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_x_raw                            | Raw X-axis accelerometer channel value.                  |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_calibbias_y                      | y-axis acceleration offset correction                    |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_y_raw                            | Raw Y-axis accelerometer channel value.                  |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_z_calibbias                      | Calibration offset for the Z-axis accelerometer channel. |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_z_raw                            | Raw Z-axis accelerometer channel value.                  |
++-------------------------------------------+----------------------------------------------------------+
+| in_deltavelocity_scale                    | Scale for delta velocity channels.                       |
++-------------------------------------------+----------------------------------------------------------+
+| in_deltavelocity_x_raw                    | Raw X-axis delta velocity channel value.                 |
++-------------------------------------------+----------------------------------------------------------+
+| in_deltavelocity_y_raw                    | Raw Y-axis delta velocity channel value.                 |
++-------------------------------------------+----------------------------------------------------------+
+| in_deltavelocity_z_raw                    | Raw Z-axis delta velocity channel value.                 |
++-------------------------------------------+----------------------------------------------------------+
+
++---------------------------------------+------------------------------------------------------+
+| 3-Axis Gyroscope related device files | Description                                          |
++---------------------------------------+------------------------------------------------------+
+| in_anglvel_scale                      | Scale for the gyroscope channels.                    |
++---------------------------------------+------------------------------------------------------+
+| in_anglvel_x_calibbias                | Calibration offset for the X-axis gyroscope channel. |
++---------------------------------------+------------------------------------------------------+
+| in_anglvel_calibbias_x                | x-axis gyroscope offset correction                   |
++---------------------------------------+------------------------------------------------------+
+| in_anglvel_x_raw                      | Raw X-axis gyroscope channel value.                  |
++---------------------------------------+------------------------------------------------------+
+| in_anglvel_calibbias_y                | y-axis gyroscope offset correction                   |
++---------------------------------------+------------------------------------------------------+
+| in_anglvel_y_raw                      | Raw Y-axis gyroscope channel value.                  |
++---------------------------------------+------------------------------------------------------+
+| in_anglvel_z_calibbias                | Calibration offset for the Z-axis gyroscope channel. |
++---------------------------------------+------------------------------------------------------+
+| in_anglvel_z_raw                      | Raw Z-axis gyroscope channel value.                  |
++---------------------------------------+------------------------------------------------------+
+| in_deltaangl_scale                    | Scale for delta angle channels.                      |
++---------------------------------------+------------------------------------------------------+
+| in_deltaangl_x_raw                    | Raw X-axis delta angle channel value.                |
++---------------------------------------+------------------------------------------------------+
+| in_deltaangl_y_raw                    | Raw Y-axis delta angle channel value.                |
++---------------------------------------+------------------------------------------------------+
+| in_deltaangl_z_raw                    | Raw Z-axis delta angle channel value.                |
++---------------------------------------+------------------------------------------------------+
+
++----------------------------------+-------------------------------------------+
+| Temperature sensor related files | Description                               |
++----------------------------------+-------------------------------------------+
+| in_temp0_raw                     | Raw temperature channel value.            |
++----------------------------------+-------------------------------------------+
+| in_temp0_scale                   | Scale for the temperature sensor channel. |
++----------------------------------+-------------------------------------------+
+
++-------------------------------+---------------------------------------------------------+
+| Miscellaneous device files    | Description                                             |
++-------------------------------+---------------------------------------------------------+
+| name                          | Name of the IIO device.                                 |
++-------------------------------+---------------------------------------------------------+
+| sampling_frequency            | Currently selected sample rate.                         |
++-------------------------------+---------------------------------------------------------+
+| filter_low_pass_3db_frequency | Bandwidth for the accelerometer and gyroscope channels. |
++-------------------------------+---------------------------------------------------------+
+
+The following table shows the adis16475 related device debug files, found in the
+specific device debug folder path /sys/kernel/debug/iio/iio:deviceX.
+
++----------------------+-------------------------------------------------------------------------+
+| Debugfs device files | Description                                                             |
++----------------------+-------------------------------------------------------------------------+
+| serial_number        | The serial number of the chip in hexadecimal format.                    |
++----------------------+-------------------------------------------------------------------------+
+| product_id           | Chip specific product id (e.g. 16475, 16500, 16505, etc.).              |
++----------------------+-------------------------------------------------------------------------+
+| flash_count          | The number of flash writes performed on the device.                     |
++----------------------+-------------------------------------------------------------------------+
+| firmware_revision    | String containing the firmware revision in the following format ##.##.  |
++----------------------+-------------------------------------------------------------------------+
+| firmware_date        | String containing the firmware date in the following format mm-dd-yyyy. |
++----------------------+-------------------------------------------------------------------------+
+
+Channels processed values
+-------------------------
+
+A channel value can be read from its _raw attribute. The value returned is the
+raw value as reported by the devices. To get the processed value of the channel,
+apply the following formula:
+
+.. code-block:: bash
+
+        processed value = (_raw + _offset) * _scale
+
+Where _offset and _scale are device attributes. If no _offset attribute is
+present, simply assume its value is 0.
+
+The adis16475 driver offers data for 5 types of channels, the table below shows
+the measurement units for the processed value, which are defined by the IIO
+framework:
+
++-------------------------------------+---------------------------+
+| Channel type                        | Measurement unit          |
++-------------------------------------+---------------------------+
+| Acceleration on X, Y, and Z axis    | Meters per Second squared |
++-------------------------------------+---------------------------+
+| Angular velocity on X, Y and Z axis | Radians per second        |
++-------------------------------------+---------------------------+
+| Delta velocity on X. Y, and Z axis  | Meters per Second         |
++-------------------------------------+---------------------------+
+| Delta angle on X, Y, and Z axis     | Radians                   |
++-------------------------------------+---------------------------+
+| Temperature                         | Millidegrees Celsius      |
++-------------------------------------+---------------------------+
+
+Usage examples
+--------------
+
+Show device name:
+
+.. code-block:: bash
+
+	root:/sys/bus/iio/devices/iio:device0> cat name
+        adis16505-2
+
+Show accelerometer channels value:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_x_raw
+        -275924
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_y_raw
+        -30142222
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_z_raw
+        261265769
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_scale
+        0.000000037
+
+- X-axis acceleration = in_accel_x_raw * in_accel_scale = −0.010209188 m/s^2
+- Y-axis acceleration = in_accel_y_raw * in_accel_scale = −1.115262214 m/s^2
+- Z-axis acceleration = in_accel_z_raw * in_accel_scale = 9.666833453 m/s^2
+
+Show gyroscope channels value:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> cat in_anglvel_x_raw
+        -3324626
+        root:/sys/bus/iio/devices/iio:device0> cat in_anglvel_y_raw
+        1336980
+        root:/sys/bus/iio/devices/iio:device0> cat in_anglvel_z_raw
+        -602983
+        root:/sys/bus/iio/devices/iio:device0> cat in_anglvel_scale
+        0.000000006
+
+- X-axis angular velocity = in_anglvel_x_raw * in_anglvel_scale = −0.019947756 rad/s
+- Y-axis angular velocity = in_anglvel_y_raw * in_anglvel_scale = 0.00802188 rad/s
+- Z-axis angular velocity = in_anglvel_z_raw * in_anglvel_scale = −0.003617898 rad/s
+
+Set calibration offset for accelerometer channels:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_x_calibbias
+        0
+
+        root:/sys/bus/iio/devices/iio:device0> echo 5000 > in_accel_x_calibbias
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_x_calibbias
+        5000
+
+Set calibration offset for gyroscope channels:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> cat in_anglvel_y_calibbias
+        0
+
+        root:/sys/bus/iio/devices/iio:device0> echo -5000 > in_anglvel_y_calibbias
+        root:/sys/bus/iio/devices/iio:device0> cat in_anglvel_y_calibbias
+        -5000
+
+Set sampling frequency:
+
+.. code-block:: bash
+
+	root:/sys/bus/iio/devices/iio:device0> cat sampling_frequency
+        2000.000000
+
+        root:/sys/bus/iio/devices/iio:device0> echo 1000 > sampling_frequency
+        1000.000000
+
+Set bandwidth for accelerometer and gyroscope:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> cat filter_low_pass_3db_frequency
+        720
+
+        root:/sys/bus/iio/devices/iio:device0> echo 360 > filter_low_pass_3db_frequency
+        root:/sys/bus/iio/devices/iio:device0> cat filter_low_pass_3db_frequency
+        360
+
+Show serial number:
+
+.. code-block:: bash
+
+        root:/sys/kernel/debug/iio/iio:device0> cat serial_number
+        0x04f9
+
+Show product id:
+
+.. code-block:: bash
+
+        root:/sys/kernel/debug/iio/iio:device0> cat product_id
+        16505
+
+Show flash count:
+
+.. code-block:: bash
+
+        root:/sys/kernel/debug/iio/iio:device0> cat flash_count
+        150
+
+Show firmware revision:
+
+.. code-block:: bash
+
+        root:/sys/kernel/debug/iio/iio:device0> cat firmware_revision
+        1.6
+
+Show firmware date:
+
+.. code-block:: bash
+
+        root:/sys/kernel/debug/iio/iio:device0> cat firmware_date
+        06-27-2019
+
+3. Device buffers
+=================
+
+This driver supports IIO buffers.
+
+All devices support retrieving the raw acceleration, gyroscope and temperature
+measurements using buffers.
+
+The following device families also support retrieving the delta velocity, delta
+angle and temperature measurements using buffers:
+ - ADIS16477
+ - ADIS16500
+ - ADIS16505
+ - ADIS16507
+
+However, when retrieving acceleration or gyroscope data using buffers, delta
+readings will not be available and vice versa.
+
+Usage examples
+--------------
+
+Set device trigger in current_trigger, if not already set:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> cat trigger/current_trigger
+
+        root:/sys/bus/iio/devices/iio:device0> echo adis16505-2-dev0 > trigger/current_trigger
+        root:/sys/bus/iio/devices/iio:device0> cat trigger/current_trigger
+        adis16505-2-dev0
+
+Select channels for buffer read:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > scan_elements/in_deltavelocity_x_en
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > scan_elements/in_deltavelocity_y_en
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > scan_elements/in_deltavelocity_z_en
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > scan_elements/in_temp0_en
+
+Set the number of samples to be stored in the buffer:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> echo 10 > buffer/length
+
+Enable buffer readings:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > buffer/enable
+
+Obtain buffered data:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> hexdump -C /dev/iio\:device0
+        ...
+        00001680  01 1f 00 00 ff ff fe ef  00 00 47 bf 00 03 35 55  |..........G...5U|
+        00001690  01 1f 00 00 ff ff ff d9  00 00 46 f1 00 03 35 35  |..........F...55|
+        000016a0  01 1f 00 00 ff ff fe fc  00 00 46 cb 00 03 35 7b  |..........F...5{|
+        000016b0  01 1f 00 00 ff ff fe 41  00 00 47 0d 00 03 35 8b  |.......A..G...5.|
+        000016c0  01 1f 00 00 ff ff fe 37  00 00 46 b4 00 03 35 90  |.......7..F...5.|
+        000016d0  01 1d 00 00 ff ff fe 5a  00 00 45 d7 00 03 36 08  |.......Z..E...6.|
+        000016e0  01 1b 00 00 ff ff fe fb  00 00 45 e7 00 03 36 60  |..........E...6`|
+        000016f0  01 1a 00 00 ff ff ff 17  00 00 46 bc 00 03 36 de  |..........F...6.|
+        00001700  01 1a 00 00 ff ff fe 59  00 00 46 d7 00 03 37 b8  |.......Y..F...7.|
+        00001710  01 1a 00 00 ff ff fe ae  00 00 46 95 00 03 37 ba  |..........F...7.|
+        00001720  01 1a 00 00 ff ff fe c5  00 00 46 63 00 03 37 9f  |..........Fc..7.|
+        00001730  01 1a 00 00 ff ff fe 55  00 00 46 89 00 03 37 c1  |.......U..F...7.|
+        00001740  01 1a 00 00 ff ff fe 31  00 00 46 aa 00 03 37 f7  |.......1..F...7.|
+        ...
+
+See Documentation/iio/iio_devbuf.rst for more information about how buffered
+data is structured.
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 206a0aff5ca1..30b09eefe75e 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -16,5 +16,6 @@ Industrial I/O Kernel Drivers
 .. toctree::
    :maxdepth: 1

+   adis16475
    bno055
    ep93xx_adc
--
2.34.1


