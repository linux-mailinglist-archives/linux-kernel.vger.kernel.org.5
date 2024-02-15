Return-Path: <linux-kernel+bounces-67660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78701856EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1961C20A3F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB5813B29F;
	Thu, 15 Feb 2024 20:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VxgP7QgG"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97AE132469;
	Thu, 15 Feb 2024 20:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708029597; cv=none; b=TVjprB2ptQ87ehtrZnpJ/rZiENDQwg155y+rHLlPTuEr1t5/IhW+6G148fzqEczgrZToi4th6u9lOUHAYPN06Lm7cgGqpblqq0LhbH+oJ/8NPBSt1SysIdT/fw2DhLvEoxBiz/NL5G8jD1oGKT9svsxXyOfmETBP0qOrlB97iig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708029597; c=relaxed/simple;
	bh=biYF8TzBmTBfUehzYOJvS+68v778LfcH2oFqG0FepeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IC4eg4FhMSeriOJ09LvnhOUyZ6L8Kh9tpYVSB0ljKCeVoEgj1w4aAsk0wO5EpUWtUryukkugaNMyEbp8yZX4OhB/wRL+GnJD700T3YqD4ayg+d9x40m5qpLbpyE1BdKRRM7l3kBLQ5CqAJZ26LVA/fYXQU5eKznaLEJOTwLdFrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VxgP7QgG; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FFSxL3031050;
	Thu, 15 Feb 2024 20:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=dZqIRhOjiKqSt7dvw8csIF1s9y8sRAbgBVziurwX4LM=;
 b=VxgP7QgG2FkmX/tsRB/ecCvmacRm/aPTCuPrkF6MwxMbrF2Wvn4eLZXkhHNKtREBx7O1
 4nDmxzMdHE9WBnA8VTmAnS89KrFEHxS8zmbyL53mL8oU0mvqZiEO6Vr8Oj502sEvS85c
 C4daiTgKsnNI7ifYVaZ34iQj+plXsJxTEdQ3715apjWjrRud8rX/4OQp+snG0qRlO5/j
 OZpJyrJ28slecTC60huO7wD4jhKgDbEnR0cKz8J7kKwDsXMELyRZ813Dki9A076Db2f7
 ZM7IqeCdgEoEBTMOPs2g4V2eaqywHphtby3PtEx1acP27x8QZs0YyeBqD20XDujnvOBe lg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w9301k7rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 20:39:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FJ8Y38015017;
	Thu, 15 Feb 2024 20:39:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykats5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 20:39:34 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41FKdVPP012444;
	Thu, 15 Feb 2024 20:39:34 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3w5ykats32-3;
	Thu, 15 Feb 2024 20:39:34 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        kernel test robot <lkp@intel.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] scsi: jazz_esp: only build if SCSI core is builtin
Date: Thu, 15 Feb 2024 15:39:24 -0500
Message-ID: <170802930866.3317154.3155585946655239383.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240214055953.9612-1-rdunlap@infradead.org>
References: <20240214055953.9612-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_19,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150166
X-Proofpoint-GUID: SXDJDdr1S211bZff-c_hDDqI3aYVnPb1
X-Proofpoint-ORIG-GUID: SXDJDdr1S211bZff-c_hDDqI3aYVnPb1

On Tue, 13 Feb 2024 21:59:53 -0800, Randy Dunlap wrote:

> JAZZ_ESP is a bool kconfig symbol that selects SCSI_SPI_ATTRS.
> When CONFIG_SCSI=m, this results in SCSI_SPI_ATTRS=m while
> JAZZ_ESP=y, which causes many undefined symbol linker errors.
> 
> Fix this by only offering to build this driver when CONFIG_SCSI=y.
> 
> 
> [...]

Applied to 6.8/scsi-fixes, thanks!

[1/1] scsi: jazz_esp: only build if SCSI core is builtin
      https://git.kernel.org/mkp/scsi/c/9ddf190a7df7

-- 
Martin K. Petersen	Oracle Linux Engineering

