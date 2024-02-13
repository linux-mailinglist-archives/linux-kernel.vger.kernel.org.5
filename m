Return-Path: <linux-kernel+bounces-63090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FCC852ACE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17F661C218D5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCEF1CABF;
	Tue, 13 Feb 2024 08:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hUqdw0ZV"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8656218021;
	Tue, 13 Feb 2024 08:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812277; cv=none; b=P8o4rMLbtgCDX9Hx5NVP3e1514NlWe+oGEXTUw+QhsL0ulfW/rpc6cbrtLz5jCdz9Lnd8s8NJ6QkMaEnYoLwLQa9cHY6xLQdykXoXvBjlNlPhwdKi1KGNA2pCOH0wyWLKfsZPtC1GIwU5qujHLMXLO0CHpGntkTRpxqQ6C6EJkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812277; c=relaxed/simple;
	bh=qz1KjHhNg6NGtRHQ3eDGvhUY5yJSnHhvVMJmlHHPcPI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RJku8zgC9wqgzcxOw4Du+3GtLQZRKozQTaPWIjsaZzjIgue3jesT9ePlIcnLak7L3noaYu0QFjjY/pbkUeiJ4SChYSEfVRW2Wcxw/+ts+VlnAQbRmc3U1YKhlWFzSAu/xY4ecJcrSAha+i4R+H6yxPjBvZyIPF1AAYWlYrW2rdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hUqdw0ZV; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D502ds030222;
	Tue, 13 Feb 2024 03:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=DKIM;
	 bh=DnAfRvcipg12KYQjy36NDZKbfT9A/4H/WBdI7PSYYKM=; b=hUqdw0ZVh7nr
	x6VwTd5kbV+dx51TuQcAUUDst1Hvhl/e8UdPhaca+/NxyzKm9Ny+ujng8VLCXTbX
	NuiuAaLWIqNH5zXBlQvt9+VTCuh8aEXb+eGJK6RWUF0DmhNxu69aLZlNCv5adriA
	V2FtNPppJnj4158+mCJB+fp7IGkNLa7yx1a8/WQ4q/CQ8bZKSkblS9NMjORQF1Lx
	E7sHr1TaTsGXISMzt2yfBXGuFg79Bq0N/jQ6irRDn09CwuHMtjBgEdcqxvbsEwUf
	Sgzi02cY1kbwWeypbbnxK40RD5ejb/HpibTEAg0XBhmAnD6xWbHNPOnArmhsVJPk
	uRagz3JW5g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3w6pur7w0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 03:17:41 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 41D8HeqK056227
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Feb 2024 03:17:40 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 13 Feb
 2024 03:17:38 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 13 Feb 2024 03:17:38 -0500
Received: from rbolboac.ad.analog.com ([10.48.65.135])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41D8HPZD025896;
	Tue, 13 Feb 2024 03:17:32 -0500
From: Ramona Gradinariu <ramona.gradinariu@analog.com>
To: <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>
CC: Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH v4 2/3] docs: iio: add documentation for device buffers
Date: Tue, 13 Feb 2024 10:17:19 +0200
Message-ID: <20240213081720.17549-3-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213081720.17549-1-ramona.gradinariu@analog.com>
References: <20240213081720.17549-1-ramona.gradinariu@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: N3xqqzablP9scW1B7oe3OQ1FmiteJyxq
X-Proofpoint-ORIG-GUID: N3xqqzablP9scW1B7oe3OQ1FmiteJyxq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_04,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130064

Add documentation for IIO device buffers describing buffer
attributes and how data is structured in buffers using
scan elements.

Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
---
changes in v4:
 - documented multiple buffer support
 - reworked scan elements section
 - added reference to ABI docs
 Documentation/iio/iio_devbuf.rst | 125 +++++++++++++++++++++++++++++++
 Documentation/iio/index.rst      |   1 +
 2 files changed, 126 insertions(+)
 create mode 100644 Documentation/iio/iio_devbuf.rst

diff --git a/Documentation/iio/iio_devbuf.rst b/Documentation/iio/iio_devbuf.rst
new file mode 100644
index 000000000000..e99143efb4d7
--- /dev/null
+++ b/Documentation/iio/iio_devbuf.rst
@@ -0,0 +1,125 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============================
+Industrial IIO device buffers
+=============================
+
+1. Overview
+===========
+
+The Industrial I/O core offers a way for continuous data capture based on a
+trigger source. Multiple data channels can be read at once from
+/dev/iio:deviceX character device node, thus reducing the CPU load.
+
+Devices with buffer support feature an additional sub-folder in the
+/sys/bus/iio/devices/deviceX/ folder hierarchy, called bufferY, where Y defaults
+to 0, for devices with a single buffer.
+
+2. Buffer attributes
+====================
+
+An IIO buffer has an associated attributes directory under
+/sys/bus/iio/iio:deviceX/bufferY/. The attributes are described below.
+
+Length
+------
+
+Read / Write attribute which states the total number of data samples (capacity)
+that can be stored by the buffer.
+
+Enable
+------
+
+Read / Write attribute which starts / stops the buffer capture. This file should
+be written last, after length and selection of scan elements.
+
+Watermark
+---------
+
+Read / Write positive integer attribute specifying the maximum number of scan
+elements to wait for.
+
+Poll will block until the watermark is reached.
+
+Blocking read will wait until the minimum between the requested read amount or
+the low water mark is available.
+
+Non-blocking read will retrieve the available samples from the buffer even if
+there are less samples then watermark level. This allows the application to
+block on poll with a timeout and read the available samples after the timeout
+expires and thus have a maximum delay guarantee.
+
+Data available
+--------------
+
+Read-only attribute indicating the bytes of data available in the buffer. In the
+case of an output buffer, this indicates the amount of empty space available to
+write data to. In the case of an input buffer, this indicates the amount of data
+available for reading.
+
+Scan elements
+-------------
+
+The meta information associated with a channel reading placed in a buffer is
+called a scan element. The scan elements are configurable per buffer, thus they
+are exposed to userspace applications via the /sys/bus/iio/iio:deviceX/bufferY/
+directory. The scan elements attributes are presented below.
+
+**_en**
+
+Read/ Write attribute used for enabling a channel. If and only if its value
+is non zero, then a triggered capture will contain data samples for this
+channel.
+
+**_index**
+
+Read-only positive integer attribute specifying the position of the channel in
+the buffer. Note these are not dependent on what is enabled and may not be
+contiguous. Thus for user-space to establish the full layout these must be used
+in conjunction with all _en attributes to establish which channels are present,
+and the relevant _type attributes to establish the data storage format.
+
+**_type**
+
+Read-only attribute containing the description of the scan element data storage
+within the buffer and hence the form in which it is read from user space. Format
+is [be|le]:[s|u]bits/storagebits[Xrepeat][>>shift], where:
+
+- **be** or **le** specifies big or little endian.
+- **s** or **u**, specifies if signed (2's complement) or unsigned.
+- **bits**, is the number of valid data bits.
+- **storagebits**, is the number of bits (after padding) that it occupies in the
+  buffer.
+- **repeat**, specifies the number of bits/storagebits repetitions. When the
+  repeat element is 0 or 1, then the repeat value is omitted.
+- **shift**, if specified, is the shift that needs to be applied prior to
+  masking out unused bits.
+
+For example, a driver for a 3-axis accelerometer with 12 bit resolution where
+data is stored in two 8-bits registers as follows:
+
+.. code-block:: bash
+
+          7   6   5   4   3   2   1   0
+        +---+---+---+---+---+---+---+---+
+        |D3 |D2 |D1 |D0 | X | X | X | X | (LOW byte, address 0x06)
+        +---+---+---+---+---+---+---+---+
+
+          7   6   5   4   3   2   1   0
+        +---+---+---+---+---+---+---+---+
+        |D11|D10|D9 |D8 |D7 |D6 |D5 |D4 | (HIGH byte, address 0x07)
+        +---+---+---+---+---+---+---+---+
+
+will have the following scan element type for each axis:
+
+.. code-block:: bash
+
+        $ cat /sys/bus/iio/devices/iio:device0/buffer0/in_accel_y_type
+        le:s12/16>>4
+
+A user space application will interpret data samples read from the buffer as two
+byte little endian signed data, that needs a 4 bits right shift before masking
+out the 12 valid bits of data.
+
+Please see Documentation/ABI/testing/sysfs-bus-iio for a complete description of
+the attributes.
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index db341b45397f..206a0aff5ca1 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -8,6 +8,7 @@ Industrial I/O
    :maxdepth: 1

    iio_configfs
+   iio_devbuf

 Industrial I/O Kernel Drivers
 =============================
--
2.34.1


