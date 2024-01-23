Return-Path: <linux-kernel+bounces-35122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D85838C6D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8151F291FF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B2B5D8E3;
	Tue, 23 Jan 2024 10:46:30 +0000 (UTC)
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D9F5C8EC;
	Tue, 23 Jan 2024 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006788; cv=none; b=nNmI77vfOA+K6xloxPjB1aYA9FTL5d4e879swS3vOyfT8Ry/Kn4UmSIl94McPYD4G8QgwgwSCflOa2e6EZyH/5R0XMeu+NT8HvmDnWGmVz45OaRPfAMILacigp+I/f0eT2sCxldVY6k0/TCCoE8UJDVQ1OkBLPKYUH5/BALhsSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006788; c=relaxed/simple;
	bh=lmYHIaxNwCPd+pIUNkDLtJSattBNMxoQ64v62B9hCiI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgdUK9C/Yv5oCptfqSIrSIrmtzc4NusbawuR/vXH2SYpOBRlXQv+VZDiIiPHlrydStawV2yLuoB7HTD6MamXony2fE5qVisJiJFgMSU43sSKe+Mnaci09iJfiS9hWPYs/gQDtYgPHVn2JSXu0NoCpofl6RBUmcPg6PlX5pc78Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N61dYn011754;
	Tue, 23 Jan 2024 05:46:24 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3vr8w7mabr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 05:46:23 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 40NAkMXq028839
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 05:46:22 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 23 Jan
 2024 05:46:21 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 23 Jan 2024 05:46:21 -0500
Received: from rbolboac.ad.analog.com ([10.48.65.122])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 40NAk5Cs010733;
	Tue, 23 Jan 2024 05:46:11 -0500
From: Ramona Gradinariu <ramona.gradinariu@analog.com>
To: <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>
CC: Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH 1/1] docs: iio: add documentation for adis16475 driver
Date: Tue, 23 Jan 2024 12:45:48 +0200
Message-ID: <20240123104548.136201-2-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123104548.136201-1-ramona.gradinariu@analog.com>
References: <20240123104548.136201-1-ramona.gradinariu@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: i1VTDW2xvR9bIqdU0PvK-pZ2I1VDe06d
X-Proofpoint-ORIG-GUID: i1VTDW2xvR9bIqdU0PvK-pZ2I1VDe06d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_05,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401230078

Add documentation for adis16475 driver which describes
the driver device files and shows how the user may use the
ABI for various scenarios (configuration, measurement, etc.).

Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
---
 Documentation/iio/adis16475.rst | 327 ++++++++++++++++++++++++++++++++
 1 file changed, 327 insertions(+)
 create mode 100644 Documentation/iio/adis16475.rst

diff --git a/Documentation/iio/adis16475.rst b/Documentation/iio/adis16475.rst
new file mode 100644
index 000000000000..9af054f4af79
--- /dev/null
+++ b/Documentation/iio/adis16475.rst
@@ -0,0 +1,327 @@
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
+The signal chain of each inertial sensor (accelerometers and
+gyroscopes) includes the application of unique correction
+formulas, which are derived from extensive characterization
+of bias, sensitivity, alignment, response to linear acceleration
+(gyroscopes), and point of percussion (accelerometer location)
+over a temperature range of −40°C to +85°C, for each ADIS device.
+These correction formulas are not accessible, but users do have
+the opportunity to adjust the bias for each sensor individually
+through the calibbias attribute.
+
++-------------------------------------------+----------------------------------------------------------+
+| 3-Axis Accelerometer related device files | Description                                              |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_scale                            | Scale for the accelerometer channels.                    |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_x_calibbias                      | Calibration offset for the X-axis accelerometer channel. |
++-------------------------------------------+----------------------------------------------------------+
+| accel_calibbias_x                         | x-axis acceleration offset correction                    |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_x_raw                            | Raw X-axis accelerometer channel value.                  |
++-------------------------------------------+----------------------------------------------------------+
+| accel_calibbias_y                         | y-axis acceleration offset correction                    |
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
+| anglvel_calibbias_x                   | x-axis gyroscope offset correction                   |
++---------------------------------------+------------------------------------------------------+
+| in_anglvel_x_raw                      | Raw X-axis gyroscope channel value.                  |
++---------------------------------------+------------------------------------------------------+
+| anglvel_calibbias_y                   | y-axis gyroscope offset correction                   |
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
+
+Device buffers
+==============
+
+This driver supports IIO buffers.
+
+All devices support retrieving the raw acceleration, gyroscope and temperature measurements using buffers.
+
+The following device families also support retrieving the delta velocity, delta angle and temperature measurements using buffers:
+ - ADIS16477
+ - ADIS16500
+ - ADIS16505
+ - ADIS16507
+
+However, when retrieving acceleration or gyroscope data using buffers, delta readings will not be available and vice versa.
+
+Usage examples
+--------------
+
+Set trigger if not available:
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
+        root:/sys/bus/iio/devices/iio:device0> hexdump /dev/iio\:device0
+        ...
+        0044760 3901 0000 ffff f9fe ffff 29ee 0100 f79b
+        0044770 3901 0000 ffff 98fe ffff 1aef 0100 439a
+        0044780 3901 0000 ffff b4fe ffff 32ef 0100 c199
+        0044790 3901 0000 ffff bdfe ffff 20ef 0100 5f9a
+        00447a0 3901 0000 ffff 37ff ffff 1eef 0100 389b
+        00447b0 3901 0000 ffff 7dff ffff 96ee 0100 5a9c
+        ...
-- 
2.34.1


