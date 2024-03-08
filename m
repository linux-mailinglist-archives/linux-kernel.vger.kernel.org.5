Return-Path: <linux-kernel+bounces-97183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C21068766A4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3BC01C20A1A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD24A1DDD1;
	Fri,  8 Mar 2024 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="6VEXHwlf"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17DB2114;
	Fri,  8 Mar 2024 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709909320; cv=none; b=PiBPNXLBdjigJzy1vgAAHkDAvTANlceA4BxXlAQ0uqi9gV5xlKMMJIL2jrOzT1s6swo9Z25qcf+lwR1lmyCN3/f5y4LdZfn+8ZLpbhia3EHpFEh5ZuXp62LNRXrqUkwQuOm/TQTnG0i1RjaY9Z7hCv/td5pXgUY9W+TTaDfwTPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709909320; c=relaxed/simple;
	bh=+6XAER/7E8C4DDje4PcoT8ffJWFq9hufEMuPy14CSOc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dZqUb7iH7P/dyqLMyTqGV+nJlZq50Nm+wcUnUBcoD89IJAYoBukFYFg0trX+yJzE9GCgs+JkVvJ4Am+RR8J1YF7zNJnL2AUPNXx6ukTwd0HM2+yClNKuKw8mTpBbr5vswLvU8XF8J683g0gqRE+kyQBDtIZT96ZrGNs80TyhfhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=6VEXHwlf; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 428AXT3M029588;
	Fri, 8 Mar 2024 15:48:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=vA/lQ0A
	Yw3FJ3ttodnbsTOZ1WxKOYVchoRG7IlhS6i4=; b=6VEXHwlffy6+qRiodhtD9zp
	9akve1hlsO/x1/fl8IZW0fO8mRKx2qOWyjBPle1ut0G4s9KYTOuvSEMmKGGXWATM
	sQgRTbtv+rOtWLEjxC4YBRsvHnH9SRA81TV+N5/SGZj8+DYVNi7CTlKFiq+Lq5cy
	8wJsuSRInXVa4sudc0r5OfGd99gbbRPyyijAWxvQllovdZ25zWhPs+I090AGVEBV
	HGwZQVYD/MxOka1Lxm0orKdcploZHeWaxIbN+tUqNvB0F0G9gPqYHFdGMUJl62kX
	0WLDEyCY3Z0HQotxIXY+Y3Rj6HhNBhcNzv7O9NFNo9BdDKurJvRXt9VWEIxIjng=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wn87tygsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 15:48:10 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0AD3C40044;
	Fri,  8 Mar 2024 15:48:06 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4FAD927D538;
	Fri,  8 Mar 2024 15:47:17 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Mar
 2024 15:47:17 +0100
Received: from localhost (10.201.21.20) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Mar
 2024 15:47:16 +0100
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>, <devicetree@vger.kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v4 0/4] Introduction of a remoteproc tee to load signed firmware
Date: Fri, 8 Mar 2024 15:47:04 +0100
Message-ID: <20240308144708.62362-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SAFCAS1NODE1.st.com (10.75.90.11) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02

Main updates from the previous version [1]:

- Remove the alternate boot sequence: rproc_alt_fw_boot()
- Introduce tee_rproc_parse_fw function
	- create a cached table as done inrproc_elf_load_rsc_table[2],
	- PR sent to OP-TEE to allow TA_RPROC_FW_CMD_LOAD_FW service 
	  re-entrance[3].
- Rework TEE_REMOTEPROC description in Kconfig
- Introduce proc::tee_interface

Patch commit messages list updates with more details

base-commit: 62210f7509e13a2caa7b080722a45229b8f17a0a

[1] https://lore.kernel.org/linux-arm-kernel/Zdjl6Z2ktTwi+oWp@p14s/T/#m53f994237dc984c5dbbe3c75d2c30fcfff8548a0
[2] https://elixir.bootlin.com/linux/latest/source/drivers/remoteproc/remoteproc_elf_loader.c#L326
[3] https://github.com/OP-TEE/optee_os/pull/6743


Description of the feature:

This series proposes the implementation of a remoteproc tee driver to
communicate with a TEE trusted application responsible for authenticating and
loading the remoteproc firmware image in an Arm secure context.

1) Principle:

The remoteproc tee driver provides services to communicate with the OP-TEE
trusted application running on the Trusted Execution Context (TEE).
The trusted application in TEE manages the remote processor lifecycle:

- authenticating and loading firmware images,
- isolating and securing the remote processor memories,
- supporting multi-firmware (e.g., TF-M + Zephyr on a Cortex-M33),
- managing the start and stop of the firmware by the TEE.

2) Format of the signed image:

Refer to:
https://github.com/OP-TEE/optee_os/blob/master/ta/remoteproc/src/remoteproc_core.c#L18-L57

3) OP-TEE trusted application API:

Refer to:
https://github.com/OP-TEE/optee_os/blob/master/ta/remoteproc/include/ta_remoteproc.h

4) OP-TEE signature script

Refer to:
https://github.com/OP-TEE/optee_os/blob/master/scripts/sign_rproc_fw.py

Example of usage:
sign_rproc_fw.py --in <fw1.elf> --in <fw2.elf> --out <signed_fw.sign> --key ${OP-TEE_PATH}/keys/default.pem


5) Impact on User space Application

No sysfs impact.the user only needs to provide the signed firmware image
instead of the ELF image.


For more information about the implementation, a presentation is available here
(note that the format of the signed image has evolved between the presentation
and the integration in OP-TEE).

https://resources.linaro.org/en/resource/6c5bGvZwUAjX56fvxthxds

Arnaud Pouliquen (4):
  remoteproc: Add TEE support
  dt-bindings: remoteproc: Add compatibility for TEE support
  remoteproc: stm32: Create sub-functions to request shutdown and
    release
  remoteproc: stm32: Add support of an OP-TEE TA to load the firmware

 .../bindings/remoteproc/st,stm32-rproc.yaml   |  51 +-
 drivers/remoteproc/Kconfig                    |  10 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/stm32_rproc.c              | 144 ++++--
 drivers/remoteproc/tee_remoteproc.c           | 434 ++++++++++++++++++
 include/linux/remoteproc.h                    |   4 +
 include/linux/tee_remoteproc.h                | 112 +++++
 7 files changed, 711 insertions(+), 45 deletions(-)
 create mode 100644 drivers/remoteproc/tee_remoteproc.c
 create mode 100644 include/linux/tee_remoteproc.h


base-commit: 62210f7509e13a2caa7b080722a45229b8f17a0a
-- 
2.25.1


