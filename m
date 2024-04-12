Return-Path: <linux-kernel+bounces-141857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A3A8A244E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11131C2170C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0983F19477;
	Fri, 12 Apr 2024 03:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="lExjkPms"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D116218628;
	Fri, 12 Apr 2024 03:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712892111; cv=none; b=mww6MAE2Sdt++vtimkp5F6laG00IfznRQCPT1+neRuQWiztVg+pPhtmk9KWUZsSGNc9CdNkiDvgGhc98HseqfRLfBTRNR7clIZdANCLZTe1up5Yr8zLFJDHQCy0POxcBcD1gnHzJrT8IysRwGDHx/5Ji9+/t1voG6JQgxoWe6i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712892111; c=relaxed/simple;
	bh=+g8IIY5AHDgps6cDvY60z9DR4SBKIKd7nLXQX9Pq9FQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GI02+o4l7RH0uh2dVuaAkq7GBT6HagTJSf38l4H7SuMLMyMA2dhrDYQxks4p5N2bYhHqPkFGlVAbZ2xXIkqnDHhHOA383FNLAw5j63VPjPrHOgGozax74fxqwM6tVRZrB2R+LU/Qv288EGMnKr9hbXsYLogm1X9ZmhyMmAPkpn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=lExjkPms; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C32K93017823;
	Thu, 11 Apr 2024 23:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=DKIM;
	 bh=HlFct+d0fLtrb7oDg7XDUOZwnnpyGtY1TPgAuLTT/yg=; b=lExjkPmsWDzo
	Eg+M7muqIAtqO0Sp1jFwyvk1XizdH6CaAQPJ5hxHggQHU41FQbwjp5ICIpwJRdIE
	6bhXHeTeQeAG6LCs2/ojo9Sv9aGo5scXFBgMOdh8BvvWXsCjYu3ptSfpKi7E8VUQ
	2fg8tTqCSgjo3W9kOg3b+L60sJI6nHNsyYN4s9kXO6wlhLTPUWCRIgBqba5LGPlA
	CrLHKYxUD3vewmZuv8+s629HC78R/lp4Dc/pQDsUMU/jmjuhRziEw5Sxlbzz+qqC
	2+XwvWD/3kTrUd+gayrfbQhpSDBWyXPlWwvubkOThgp61tBep9GqPANSu8Z2tbvJ
	14tfi8NZyw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3xek1fa87j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 23:21:34 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 43C3LXPk021576
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Apr 2024 23:21:33 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 11 Apr 2024 23:21:32 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 11 Apr 2024 23:21:32 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 11 Apr 2024 23:21:32 -0400
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.117.220.36])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 43C3L8pg021230;
	Thu, 11 Apr 2024 23:21:24 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Liam Girdwood" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "David Lechner" <dlechner@baylibre.com>,
        Michael Hennerich
	<michael.hennerich@analog.com>
Subject: [PATCH 2/4] iio: ABI: add ABI file for the LTC2664 DAC
Date: Fri, 12 Apr 2024 11:21:00 +0800
Message-ID: <20240412032102.136071-3-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412032102.136071-1-kimseer.paller@analog.com>
References: <20240412032102.136071-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: TCUPznz4WRZzmKsO1puaT2PI3mczYDHO
X-Proofpoint-ORIG-GUID: TCUPznz4WRZzmKsO1puaT2PI3mczYDHO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_14,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120023

Define the sysfs interface for toggle capable channels.

Toggle enabled channels will have:

 * out_voltageY_toggle_en
 * out_voltageY_raw0
 * out_voltageY_raw1
 * out_voltageY_symbol

The common interface present in all channels is:

 * out_voltageY_raw (not present in toggle enabled channels)
 * out_voltageY_raw_available
 * out_voltageY_powerdown
 * out_voltageY_scale
 * out_voltageY_offset

Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 .../ABI/testing/sysfs-bus-iio-dac-ltc2664     | 30 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 31 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2664

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2664 b/Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2664
new file mode 100644
index 000000000..4b656b7af
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2664
@@ -0,0 +1,30 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_toggle_en
+KernelVersion:	5.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Toggle enable. Write 1 to enable toggle or 0 to disable it. This is
+		useful when one wants to change the DAC output codes. The way it should
+		be done is:
+
+		- disable toggle operation;
+		- change out_voltageY_raw0 and out_voltageY_raw1;
+		- enable toggle operation.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_raw0
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_raw1
+KernelVersion:	5.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		It has the same meaning as out_voltageY_raw. This attribute is
+		specific to toggle enabled channels and refers to the DAC output
+		code in INPUT_A (_raw0) and INPUT_B (_raw1). The same scale and offset
+		as in out_voltageY_raw applies.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_symbol
+KernelVersion:	5.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Performs a SW toggle. This attribute is specific to toggle
+		enabled channels and allows to toggle between out_voltageY_raw0
+		and out_voltageY_raw1 through software. Writing 0 will select
+		out_voltageY_raw0 while 1 selects out_voltageY_raw1.
diff --git a/MAINTAINERS b/MAINTAINERS
index bd8645f6e..9ed00b364 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12842,6 +12842,7 @@ M:	Kim Seer Paller <kimseer.paller@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2664
 F:	Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
 
 LTC2688 IIO DAC DRIVER
-- 
2.34.1


