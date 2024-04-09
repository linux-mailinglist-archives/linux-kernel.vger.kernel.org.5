Return-Path: <linux-kernel+bounces-137182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FE989DE3B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34BCF294DA1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B98913793D;
	Tue,  9 Apr 2024 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XOGtt7dw"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB2A131197;
	Tue,  9 Apr 2024 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675227; cv=none; b=TeidTuggwBQPfusXCx6iWLiWTIrpsY5FdPE2mlK/P/ysHb27FPvwSup9nDeLkeKkUjaUyd3AwWPtBlrvyuX7ERs806i/G4Adu4KKLM3OBo3gvA9bKH8u4zLulNuJ+ixb9+mL1ifvIGUrFW4wN4minCZuaUkEMkycG691vmS1ZjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675227; c=relaxed/simple;
	bh=Q4qYVPeSi3pPhjTgLSE8HZmmihR2GDi75RvWnTDH1vc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ghOfeFq1NegcpJNhgZJkwnZE173J0GV6OwALq+NxcYeoID0iD4SDc8yooAULIYJraxLhXqFFwcUyhzcbHsdMllJyn4hdtluLcKXGYbOjHbwYQv7MccS5tdldUXcFUsegbvSBpYGWtbCMsmqxbDZXCJe21psNkbFZupNFvCZm6R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XOGtt7dw; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 439BXoUc032410;
	Tue, 9 Apr 2024 15:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : reply-to : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=DUkPQJEtbC1MfYFjL31WeFSt8keXRxSCErE3HPeG8Bg=;
 b=XOGtt7dwrIvLI+wZaxdQfSAKL0iqswH/KsBFqeJdCvdtQZudkvEgNhFbpyewKMhIyPIY
 xUek0Etu3AFGhDpVADCI3BTusUDnNU/uZltFIGqdciPhNDYcdnYqHQxAKnEqlgYq4gMI
 vFFzWebRvcSdB6UVLLELD6z5ih4NUvQe753rRJBhS8U1P972KAdjstwZ5jlMLdkowYq7
 eBiXr8g9NtoKEVUjJp4VFVjlEMvjc2WQKKYPK+hM+istPGUo2BsWAV6UosgfmZI2jWU2
 1XPNW3sJPlFabfX7ZIGQmb8rsWc+RtIeOqo7uSpbGzFLJBzkcRq/R9fq/ofwosa9vhWL yA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xax0un6yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 15:06:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 439DsilR040075;
	Tue, 9 Apr 2024 15:06:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavud47f7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 15:06:48 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 439F1w6i031745;
	Tue, 9 Apr 2024 15:06:47 GMT
Received: from mlluis-mac.nl.oracle.com (dhcp-10-175-24-232.vpn.oracle.com [10.175.24.232])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xavud47d2-1;
	Tue, 09 Apr 2024 15:06:47 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Jonathan.Cameron@Huawei.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: rmk+kernel@armlinux.org.uk, miguel.luis@oracle.com
Subject: [RFC PATCH 0/4] ACPI: processor: refactor acpi_processor_{get_info|remove}
Date: Tue,  9 Apr 2024 15:05:29 +0000
Message-ID: <20240409150536.9933-1-miguel.luis@oracle.com>
X-Mailer: git-send-email 2.43.0
Reply-To: miguel.luis@oracle.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=873
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404090099
X-Proofpoint-GUID: xyldpsM4RgOe0ZsXUP53XEI911orYMx3
X-Proofpoint-ORIG-GUID: xyldpsM4RgOe0ZsXUP53XEI911orYMx3

Both acpi_processor_get_info and acpi_processor_remove functions have
architecture dependent functionality enabled via CONFIG_ACPI_HOTPLUG_CPU.

Current pre-processor guards are restricting too much of functionality which
makes it dificult to integrate other features such as Virtual CPU
hotplug/unplug for arm64.

This series, applied on top of v6.9-rc3, suggests a refactoring on these two
functions with the intent to understand them better and hopefully ease
integration of more functionality.

Apart from patches 2/4 and 3/4, which could be squashed but left them separated
intentionally so it would ease reviewing, changes are self-contained.

So far I've boot tested it successfully alone and as a prefix for vCPU hotplug/unplug
patches [1], on arm64.

[1]: https://lore.kernel.org/linux-arm-kernel/Zbp5xzmFhKDAgHws@shell.armlinux.org.uk/

Miguel Luis (4):
  ACPI: processor: refactor acpi_processor_get_info: evaluation of
    processor declaration
  ACPI: processor: refactor acpi_processor_get_info: isolate cpu hotpug
    init delay
  ACPI: processor: refactor acpi_processor_get_info: isolate
    acpi_{map|unmap}_cpu under CONFIG_ACPI_HOTPLUG_CPU
  ACPI: processor: refactor acpi_processor_remove: isolate
    acpi_unmap_cpu under CONFIG_ACPI_HOTPLUG_CPU

 drivers/acpi/acpi_processor.c | 138 ++++++++++++++++++++++------------
 1 file changed, 91 insertions(+), 47 deletions(-)

--
2.43.0


