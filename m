Return-Path: <linux-kernel+bounces-74334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDC885D2EC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C118E1C22A14
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717423D393;
	Wed, 21 Feb 2024 08:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FP/oP+Aj"
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D019A3D0AA;
	Wed, 21 Feb 2024 08:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708505955; cv=none; b=hEgfxKWOrl7KN9kPUnwBVxZfW6sEYJagMLSqD88Wo5yyCCazyauZ01s/hrQlG0ixi54aTzi8WMNZrHwpU5rbdt3ITojlg9ipxQvykFRfjrrLC3fNZlkxmtEVB/O5aUSyB648DGoTap23O1WGfx6B6IIEII54/phfhR9IGCQY0Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708505955; c=relaxed/simple;
	bh=sXhetmScTYgA8FwdoPQukDS0DHmH8WSMnWWO3A4OVPQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LvhfpyC0YsdA4dbqXWYepIUtMiNrj/6CFWMy0HSysggqkbRMpTA7Pu0WgfODl7jYxKKRAms7iEzeFzi+wrMZyr+wAiX8jgB6cckcZpgKfQPZ/l2fJJlbzeVqectjH8BEILniJOdbvJyiecNKSFf01gn47asISyVdGeYY3qUnQuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FP/oP+Aj; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L7JjPB008794;
	Wed, 21 Feb 2024 03:59:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=DKIM;
	 bh=cMbT+EtV34CQGArLuMzQyvyIDMrWHsfRWgfa6Lr4qmk=; b=FP/oP+Ajh2B/
	Rif9HxkxIHIpUaZcGolUH5M2HPkrw9JlLJRoJgX0mbYZH/iUoUQYHpzSFdfo2spY
	s+NjNcMs3Poap6hKAjOkIh35P2K4Jf1DCQJOQ8NuSmF1Ia4WKJaZ9HA4VnkINLsS
	BsV99X8KW50zVJFOmOYe/GDtvf8CYO/xQ+k8AWCgzypVUjvZqyDWPt/UKLvw/dnS
	2FJl/RuXyCW1GpZQc46GHhQRFPdTfQ20c78L89UBKMoFNhwEY68b3+wxjB035mlW
	nMC8XopYG5UNjmbOgNC0dzQcQlCtdNaUBMY9nmAX8nGT6UI8MkHUP/caPaz47PGA
	SDltj50fOg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3wdcpd0bfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 03:59:09 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 41L8x8MH032451
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 21 Feb 2024 03:59:08 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 21 Feb
 2024 03:59:07 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 21 Feb 2024 03:59:07 -0500
Received: from rbolboac.ad.analog.com ([10.48.65.135])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41L8wqJB004732;
	Wed, 21 Feb 2024 03:58:59 -0500
From: Ramona Gradinariu <ramona.gradinariu@analog.com>
To: <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>
CC: Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH v5 2/3] docs: iio: add documentation for device buffers
Date: Wed, 21 Feb 2024 10:58:47 +0200
Message-ID: <20240221085848.991413-3-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221085848.991413-1-ramona.gradinariu@analog.com>
References: <20240221085848.991413-1-ramona.gradinariu@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 8bLMIMVpFHbYdaDgt_eWua4EeUUP5n6L
X-Proofpoint-GUID: 8bLMIMVpFHbYdaDgt_eWua4EeUUP5n6L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210069

Add documentation for IIO device buffers describing buffer
attributes and how data is structured in buffers using
scan elements.

Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
---
changes in v5:
 - fixed various typos and inconsistencies
 - used inline code format style where applicable
 - added data padding example
 Documentation/iio/iio_devbuf.rst | 152 +++++++++++++++++++++++++++++++
 Documentation/iio/index.rst      |   1 +
 2 files changed, 153 insertions(+)
 create mode 100644 Documentation/iio/iio_devbuf.rst

diff --git a/Documentation/iio/iio_devbuf.rst b/Documentation/iio/iio_devbuf.rst
new file mode 100644
index 000000000000..9919e4792d0e
--- /dev/null
+++ b/Documentation/iio/iio_devbuf.rst
@@ -0,0 +1,152 @@
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
+``/dev/iio:deviceX`` character device node, thus reducing the CPU load.
+
+Devices with buffer support feature an additional sub-directory in the
+``/sys/bus/iio/devices/iio:deviceX/`` directory hierarchy, called bufferY, where
+Y defaults to 0, for devices with a single buffer.
+
+2. Buffer attributes
+====================
+
+An IIO buffer has an associated attributes directory under
+``/sys/bus/iio/iio:deviceX/bufferY/``. The attributes are described below.
+
+``length``
+----------
+
+Read / Write attribute which states the total number of data samples (capacity)
+that can be stored by the buffer.
+
+``enable``
+----------
+
+Read / Write attribute which starts / stops the buffer capture. This file should
+be written last, after length and selection of scan elements. Writing a non-zero
+value may result in an error, such as EINVAL, if, for example, an unsupported
+combination of channels is given.
+
+``watermark``
+-------------
+
+Read / Write positive integer attribute specifying the maximum number of scan
+elements to wait for.
+
+Poll will block until the watermark is reached.
+
+Blocking read will wait until the minimum between the requested read amount or
+the low watermark is available.
+
+Non-blocking read will retrieve the available samples from the buffer even if
+there are less samples than the watermark level. This allows the application to
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
+The meta information associated with a channel data placed in a buffer is called
+a scan element. The scan elements attributes are presented below.
+
+**_en**
+
+Read / Write attribute used for enabling a channel. If and only if its value
+is non-zero, then a triggered capture will contain data samples for this
+channel.
+
+**_index**
+
+Read-only unsigned integer attribute specifying the position of the channel in
+the buffer. Note these are not dependent on what is enabled and may not be
+contiguous. Thus for userspace to establish the full layout these must be used
+in conjunction with all _en attributes to establish which channels are present,
+and the relevant _type attributes to establish the data storage format.
+
+**_type**
+
+Read-only attribute containing the description of the scan element data storage
+within the buffer and hence the form in which it is read from userspace. Format
+is [be|le]:[s|u]bits/storagebits[Xrepeat][>>shift], where:
+
+- **be** or **le** specifies big or little-endian.
+- **s** or **u** specifies if signed (2's complement) or unsigned.
+- **bits** is the number of valid data bits.
+- **storagebits** is the number of bits (after padding) that it occupies in the
+  buffer.
+- **repeat** specifies the number of bits/storagebits repetitions. When the
+  repeat element is 0 or 1, then the repeat value is omitted.
+- **shift** if specified, is the shift that needs to be applied prior to
+  masking out unused bits.
+
+For example, a driver for a 3-axis accelerometer with 12-bit resolution where
+data is stored in two 8-bit registers is as follows::
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
+A userspace application will interpret data samples read from the buffer as
+two-byte little-endian signed data, that needs a 4 bits right shift before
+masking out the 12 valid bits of data.
+
+It is also worth mentioning that the data in the buffer will be naturally
+aligned, so the userspace application has to handle the buffers accordingly.
+
+Take for example, a driver with four channels with the following description:
+- channel0: index: 0, type: be:u16/16>>0
+- channel1: index: 1, type: be:u32/32>>0
+- channel2: index: 2, type: be:u32/32>>0
+- channel3: index: 3, type: be:u64/64>>0
+
+If all channels are enabled, the data will be aligned in the buffer as follows::
+
+          0-1   2   3   4-7  8-11  12  13  14  15  16-23   -> buffer byte number
+        +-----+---+---+-----+-----+---+---+---+---+-----+
+        |CHN_0|PAD|PAD|CHN_1|CHN_2|PAD|PAD|PAD|PAD|CHN_3|  -> buffer content
+        +-----+---+---+-----+-----+---+---+---+---+-----+
+
+If only channel0 and channel3 are enabled, the data will be aligned in the
+buffer as follows::
+
+          0-1   2   3   4   5   6   7  8-15    -> buffer byte number
+        +-----+---+---+---+---+---+---+-----+
+        |CHN_0|PAD|PAD|PAD|PAD|PAD|PAD|CHN_3|  -> buffer content
+        +-----+---+---+---+---+---+---+-----+
+
+Typically the buffered data is found in raw format (unscaled with no offset
+applied), however there are corner cases in which the buffered data may be found
+in a processed form. Please note that these corner cases are not addressed by
+this documentation.
+
+Please see ``Documentation/ABI/testing/sysfs-bus-iio`` for a complete
+description of the attributes.
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


