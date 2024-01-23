Return-Path: <linux-kernel+bounces-35121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8332C838C6A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2C41F2920A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99F45D737;
	Tue, 23 Jan 2024 10:46:24 +0000 (UTC)
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304315C911;
	Tue, 23 Jan 2024 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006784; cv=none; b=ECG5KlswjIet37+4QZ8jLomDVd67T+JfJYIKHMBRNMR3a0ChlPKhNyEVq716YMpPcMk0yxmb6U4dfhx/RRAomJX99iYygDpFWdareHH8YzZQixTbPesZ8CZ33du3H0CJM3bSAAwpfjpVrJYKIKi6IMCkkqbOQgfPITIJ7N7bxZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006784; c=relaxed/simple;
	bh=wDiCdiEujrqbXRZI6ITSqBBhYmmbrbqtg+ju5UBdYDI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tcbaIQibleBM+7y26Mrje2kKL5fe6AYI8tPjWbwTcm1BGZT/12OZ/K/RU1ZBtsDyo10VjiWdlvjSoNqPLyLcV1TlZzvqRwi7I9dYZwb2VsD2S8qWFsl4U0IW7sV6R3FQUq43IYlRwGTKrQvqKlYcZpYYO75ZhWMVa8sbu/X6LPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N65aKV028484;
	Tue, 23 Jan 2024 05:46:20 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3vt7vtrxgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 05:46:20 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 40NAkJdr028833
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 05:46:19 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 23 Jan
 2024 05:46:18 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 23 Jan 2024 05:46:17 -0500
Received: from rbolboac.ad.analog.com ([10.48.65.122])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 40NAk5Cr010733;
	Tue, 23 Jan 2024 05:46:07 -0500
From: Ramona Gradinariu <ramona.gradinariu@analog.com>
To: <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>
CC: Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH 0/1] adis16475 driver documentation
Date: Tue, 23 Jan 2024 12:45:47 +0200
Message-ID: <20240123104548.136201-1-ramona.gradinariu@analog.com>
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
X-Proofpoint-GUID: 7LALsCwZIDFhzEhgj0rkg5XRYczpj6dM
X-Proofpoint-ORIG-GUID: 7LALsCwZIDFhzEhgj0rkg5XRYczpj6dM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_05,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 mlxlogscore=741
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401230076

Add documentation for adis16475 driver which describes
the driver device files and shows how the user may use the
ABI for various scenarios (configuration, measurement, etc.).

Ramona Gradinariu (1):
  docs: iio: add documentation for adis16475 driver

 Documentation/iio/adis16475.rst | 327 ++++++++++++++++++++++++++++++++
 1 file changed, 327 insertions(+)
 create mode 100644 Documentation/iio/adis16475.rst

--
2.34.1


