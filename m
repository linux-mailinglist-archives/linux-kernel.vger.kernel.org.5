Return-Path: <linux-kernel+bounces-29924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D238831540
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 602431C248E5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891AB134BC;
	Thu, 18 Jan 2024 08:59:41 +0000 (UTC)
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F91B65B;
	Thu, 18 Jan 2024 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568381; cv=none; b=bprWKvzMN9YkufhJfjboOUXbVD4QoLwAYbw3ShERWlR53UpW5NEWt6Xy+//R2JzyD0qnJZmttEmgwynnNUED96KUTD5f+l3oLPQhjWwey3QNK+JEP1LA+TQtW3jWq+4tuZTSfbMWw/jmib3YsVGj5l5CYIMDvW7hN73TRPdTNog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568381; c=relaxed/simple;
	bh=Z+ME5VN8rrkjD60UPCiD8moWnYbIJ6eP398m8HGXerw=;
	h=Received:Received:Received:Received:Received:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=LfqlfrYGnA26QnhmFD2wSKHOM7SwHPoTj3GkBqmjiQarZ2fd+OnsC74drmooTiHqHRMfxzkSpSfE6DxCa23HoOuQ8rqm6B3zaO36ZvLwapwvxKQ7m0MvGYVQmVnMd0ISMjvmFFUXVelDhNHlX8yyGeqSLofs197eaw9tKlRPW3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40I6geAh016278;
	Thu, 18 Jan 2024 03:59:24 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3vnm16b3bs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 03:59:23 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 40I8xMXv001124
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Jan 2024 03:59:22 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 18 Jan 2024 03:59:21 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 18 Jan 2024 03:59:19 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 18 Jan 2024 03:59:19 -0500
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.116.242.67])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 40I8x0RB005188;
	Thu, 18 Jan 2024 03:59:03 -0500
From: Kim Seer Paller <kimseer.paller@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, "Crt
 Mori" <cmo@melexis.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Bartosz
 Golaszewski" <brgl@bgdev.pl>,
        Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v6 0/2] Changes to admfm2000 driver
Date: Thu, 18 Jan 2024 16:58:54 +0800
Message-ID: <20240118085856.70758-1-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: C2pnlf4GNyYDzD2eZppyi8hDQ9Hvl6wQ
X-Proofpoint-ORIG-GUID: C2pnlf4GNyYDzD2eZppyi8hDQ9Hvl6wQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_04,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 clxscore=1011 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401180063

Hi all,

Apologies for taking a long time to follow up on this series. I took some time to
test and try out the suggested changes. As for the major change in the bindings
and driver, the array of switch and attenuation GPIOs were moved under child nodes
utilizing the devm_fwnode_gpiod_get_index() for GPIO parsing.

I have just an inquiry regarding the difficulty of implementing the use of
guard(mutex)(&st->lock) for my current controller. Is it okay to simply use the
mutex_lock function instead?

Best regards,
Kim Seer Paller

Kim Seer Paller (2):
  dt-bindings: iio: frequency: add admfm2000
  iio: frequency: admfm2000: New driver

 .../bindings/iio/frequency/adi,admfm2000.yaml | 129 ++++++++
 MAINTAINERS                                   |   8 +
 drivers/iio/frequency/Kconfig                 |  10 +
 drivers/iio/frequency/Makefile                |   1 +
 drivers/iio/frequency/admfm2000.c             | 307 ++++++++++++++++++
 5 files changed, 455 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
 create mode 100644 drivers/iio/frequency/admfm2000.c


base-commit: 296455ade1fdcf5f8f8c033201633b60946c589a
-- 
2.34.1


