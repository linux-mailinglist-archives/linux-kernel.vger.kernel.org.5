Return-Path: <linux-kernel+bounces-57818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9531E84DDC0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBEB0B26FD9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFA86F527;
	Thu,  8 Feb 2024 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="HNEusqfJ"
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B770D6EB6D;
	Thu,  8 Feb 2024 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386537; cv=none; b=NRC6ekBHdyDjyq5GOkXzHNT7My/0z48X6ZUu3lk+Y9owofwj8dkuVDahVzheZyh1RIs0FSHjnUjgdaLezJFBLSk1D0DXq1sOtB/IdkWQjETowHr7Pm90gbz6VkC6ytKDENGyzo7tAerSpvvW058O5uu5V4u3oIyz/Sl8SQwp1cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386537; c=relaxed/simple;
	bh=0PMCCV5oxr328VLVSFyPIqEvIRppT6sRoYT0wHRHraM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8A1gVA+ykBdNzxzbRtZds4MECiC8Lte53JgII1ISWU3+1UNeToxSS7P9E2tEE9p3gnwWJ5qr3ubbHiG7Tt9CfvlCLQ+IbzKiYWe2hPuFQkI0I3LPadc5H5aWeWTqDcdn0bjMFpmTbJMB1crJZ9XeMrvGDKWYwajnfvcSTU8TrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=HNEusqfJ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4187NSZ1001534;
	Thu, 8 Feb 2024 05:02:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=DKIM;
	 bh=JcIOnqV+xnvEiy7Tt/3i5INlsQIUUxMJjPkdq0ILnBk=; b=HNEusqfJA6WE
	izihZ4e4gu5yu9eU1BNi19jZp7wDUSs+g5IRJeYFtGODC9vPRSpXt8e8xmotL7hn
	ff6EKN8L9295QPyx/njS+++aMiI0/OEV6qV417H1TTXS4uFycUY5ipbHiuzf8x1S
	DFRrsJXTp91ttxvK9/xwqkJfgwqiw1+Ylm9YGMscpEWrEoLAaK/bqQqPHuWpS1jM
	h2LJrpBIm2x4CwMh0Eb7kTJjx57/bkQHvTrdvfWt+ZN3UmnRKOGSRD9AFjMZ50k2
	POCrTRK3I9tU1OgrmPOBEbcYTcKUXR1PSwTUmONPCSeHxXo7FNX0vJE3IBGwV6TX
	TflYe2gNiQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3w4thargq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 05:02:11 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 418A2ASC053254
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 05:02:10 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 8 Feb 2024 05:02:09 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 8 Feb 2024 05:01:46 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 8 Feb 2024 05:01:46 -0500
Received: from rbolboac.ad.analog.com ([10.48.65.135])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 418A1UNq027963;
	Thu, 8 Feb 2024 05:01:37 -0500
From: Ramona Gradinariu <ramona.gradinariu@analog.com>
To: <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>
CC: Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH v3 2/3] docs: iio: add documentation for device buffers
Date: Thu, 8 Feb 2024 12:01:25 +0200
Message-ID: <20240208100126.183697-3-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208100126.183697-1-ramona.gradinariu@analog.com>
References: <20240208100126.183697-1-ramona.gradinariu@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: R-nWklM-ppIE-Yd6zW9gl-fA00Wl2Lzp
X-Proofpoint-ORIG-GUID: R-nWklM-ppIE-Yd6zW9gl-fA00Wl2Lzp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402080052

Add documentation for IIO device buffers describing buffer
attributes and how data is structured in buffers using
scan elements.

Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
---
changes in v3:
 - new patch
 Documentation/iio/iio_devbuf.rst | 121 +++++++++++++++++++++++++++++++
 Documentation/iio/index.rst      |   1 +
 2 files changed, 122 insertions(+)
 create mode 100644 Documentation/iio/iio_devbuf.rst

diff --git a/Documentation/iio/iio_devbuf.rst b/Documentation/iio/iio_devbuf.rst
new file mode 100644
index 000000000000..0563b65316cb
--- /dev/null
+++ b/Documentation/iio/iio_devbuf.rst
@@ -0,0 +1,121 @@
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
+2. Buffer attributes
+====================
+
+An IIO buffer has an associated attributes directory under
+/sys/bus/iio/iio:deviceX/buffer/. Here are some of the existing attributes:
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
+3. Scan elements
+================
+
+The meta information associated with a channel reading placed in a buffer is
+called a scan element. The important bits configuring scan elements are exposed
+to userspace applications via the /sys/bus/iio/iio:deviceX/scan_elements/
+directory. This directory contains attributes of the following form:
+
+Enable
+------
+
+Read/ Write attribute used for enabling a channel. If and only if its value
+is non zero, then a triggered capture will contain data samples for this
+channel.
+
+Index
+-----
+
+Read-only positive integer attribute specifying the position of the channel in
+the buffer. Note these are not dependent on what is enabled and may not be
+contiguous. Thus for user-space to establish the full layout these must be used
+in conjunction with all _en attributes to establish which channels are present,
+and the relevant _type attributes to establish the data storage format.
+
+Type
+----
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
+        $ cat /sys/bus/iio/devices/iio:device0/scan_elements/in_accel_y_type
+        le:s12/16>>4
+
+A user space application will interpret data samples read from the buffer as two
+byte little endian signed data, that needs a 4 bits right shift before masking
+out the 12 valid bits of data.
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


