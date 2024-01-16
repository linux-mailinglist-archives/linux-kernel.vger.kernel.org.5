Return-Path: <linux-kernel+bounces-27703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AC482F472
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E7E1F24B62
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F6E1CFAF;
	Tue, 16 Jan 2024 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fXO+/Gq1"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360801CD35;
	Tue, 16 Jan 2024 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705430321; cv=none; b=btLx5bT3IYY89DbhuDMNZhmyAejNzvFEZypu6qSRBTI1dkMy0ROIXwjk08lOM0bWTg+1BvVhAub0PhQUe9PqS/XxcQALiN//M+npV6P9kkJoeUKo3DGunJhEsbhWwDCVQY3oVIuYK37b8JznkUwjXmWhXjmwO2XB1WFkbAmYUvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705430321; c=relaxed/simple;
	bh=3b3B4K+23t21N5gq7HNhS1LbsXZP7ejBZ5RGkxQiu+4=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Received:Received:Received:Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=lKVMOcyHMYPYSu3xJEtMiV94pogWbPJWM3FVdSuZ2Fh9y/UXQdHqsRn+D12QlBSNjVsJi+Z3ZDdNJFZyte/ZpH2iAgM87l/gXAo+n3nEWBcKnxFnqe698NbaTJQFTzsYImNHTOBOnXZuu2Mn/aHo11TadKqEFiFXm7is6UYqJ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fXO+/Gq1; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40GISHht008541;
	Tue, 16 Jan 2024 18:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=bCTQheI7sPgCMa1U5GtlG4vJSlKRjYaGw09yKOAWZjk=;
 b=fXO+/Gq1RLzDA3+bKr+wkYzoBkU5PukbZX/pOUF3xyNOuQ7qjYCt9pfqz6IPgN91Re9l
 ZQWtxTe5IRI/8JLE4cI0su+1/AlbrvAloIkfP6BjZOPxJhV3NcIszpCi97HAm1kpzH8G
 DVCxqsot/ylBqMMyw/Z23P7NXJTDEmelYv4fJK7zU0tLh3BRaclUSebPNQNP6CnGH+/i
 O35KbOmHy9MAVIsQmPBXh+QZfFD/oQ1ydRfpWP3SGnruOc+VnWZ5tsmFy+FF4akMblTX
 QCp2qucLdXks2HmJ7u6a73CYJogaiosvxxwPN8BkUeiys3ok9Ptngc5cmtXB6RWTpTA+ 5g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vnxbrhyrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 18:37:41 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40GIBEXW006520;
	Tue, 16 Jan 2024 18:37:40 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vnxbrhypf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 18:37:40 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40GGRoUV019557;
	Tue, 16 Jan 2024 18:37:38 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm72k02re-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 18:37:38 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40GIbbZM10682882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 18:37:37 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C0E85805C;
	Tue, 16 Jan 2024 18:37:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96A5C5805A;
	Tue, 16 Jan 2024 18:37:36 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jan 2024 18:37:36 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com, ninad@linux.ibm.com,
        johannes.holland@infineon.com, linux@roeck-us.net, broonie@kernel.org,
        andre.werner@systec-electronic.com
Cc: patrick.rudolph@9elements.com, vincent@vtremblay.dev,
        peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com, bhelgaas@google.com,
        naresh.solanki@9elements.com, alexander.stein@ew.tq-group.com,
        festevam@denx.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-hardening@vger.kernel.org, geissonator@yahoo.com,
        geert+renesas@glider.be, luca.ceresoli@bootlin.com
Subject: [PATCH v4 0/3] Add device tree for IBM system1 BMC
Date: Tue, 16 Jan 2024 12:37:31 -0600
Message-Id: <20240116183734.3944028-1-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ggk-eNreeh0ff1KMsY4sRK8AOMVSuKXy
X-Proofpoint-ORIG-GUID: t3joqvYsLCg1U1gKUgLjom73Vj2FFPGz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_10,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401160147

This patchset adds device tree for IBM system1 bmc board.

Change log:
v1:
 - Added device binding for IBM system1-bmc
 - Added device binding for TIS I2C devices
 - Added device tree for IBM system1 BMC board
 - Added i2c and muxes
 - Added voltage regulators
 - Added GPIO, Fan ctrl, Led
 - Added more compatible strings for tpm_tis_i2c
 - Added power supplies, sensors, EEPROMS, TPM and more

v2:
 - Incorporated review comments from Conor Dooley, Jarkko Sakkinen,
   Guenter Roeck, Rob Herring, Krzysztof Kozlowski
 - Merge all patches into single patch.
 - Split the trivial device patch.
 - Cleanup commit messages.
 - Fixed bootargs string.
 - Fixed node names.
 - Dropped tpm schema patch as it is covered by Lukas's patch.
 - Dropped "tpm: tis-i2c: Add more compatible strings" patch and
   send it as a separate patch.

v3:
 - Fixed voltage-regulators names.
 - Updated commit message about TPM compatibility string.

v4:
 - Removed compatibility string "nuvoton,npct75x" from TPM

Andrew Geissler (1):
  ARM: dts: aspeed: System1: IBM system1 BMC board

Ninad Palsule (2):
  dt-bindings: arm: aspeed: add IBM system1-bmc
  dt-bindings: Add DPS310 as trivial device

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 .../devicetree/bindings/trivial-devices.yaml  |    2 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 1623 +++++++++++++++++
 4 files changed, 1627 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts

-- 
2.39.2


