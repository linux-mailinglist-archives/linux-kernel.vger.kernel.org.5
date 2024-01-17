Return-Path: <linux-kernel+bounces-29015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5778306E2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712331C215DA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9849C20322;
	Wed, 17 Jan 2024 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ZciiCWCV"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96439200D9;
	Wed, 17 Jan 2024 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705497518; cv=none; b=t/Rcf6kEW/X7uF6Hw3TEKFXNmpW9aQckbZ/E5PQSS5x1OSmYDXlDe50x3XdIQ8gkZai2LYK6zs4CVrTYTFIMlv6tab5ya/TDc83vk/08CS+qau8NeVN716wvjjrBXy3PAUmyEr62+g0EDkw+wYjiGtDKc4mVez91Kms/a5elRTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705497518; c=relaxed/simple;
	bh=cwpAB4v8MAeBSFfk751SQoNIeFgQACr+c8jRPotmZ/Q=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Proofpoint-Virus-Version; b=ZzzLvtVFB0DgXjClCvf6WQaMIi8YYgiV5RRTJJBAAO7H+KaecErYmMgdftvPKh98sAurFQ7k/y/u8YCR5dm0NIPXohONucjUqaxZGSpB66BrBEO6+oyiH+b4vhufBBexMmMPWMpbxiS1ha5C4tQKCfeMgVc5TFqEqGHSUN5tVpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ZciiCWCV; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H8PCbO007691;
	Wed, 17 Jan 2024 14:18:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=1qNhrPs
	JgbVSkEdgh8//+X6VT70i4GD3Lsqz0cPBVKE=; b=ZciiCWCV1+3X5S/xCXwHWKh
	iwqWvSj/bpvuAzFXfoL9VM4GuTeB4vujgtj2cBnzD7KGTUEHkqPgd08nYEhLsDpN
	YmQe7WMN82/mIF7jhS4YEHRWOCuC7Eas5yApOpbtmm7VK+j20w20ekUo55Pvi5yB
	RJbwRFwzFN2B305Ip+TCq2gH8Ol58NsTtKX6mwEMJ3qL2hFcbTGlRzYxOqSZFG7Z
	xwFjUcNOHsXSlNA5jt0k4PSmuJPyNzrvzCT2p6nX1M3Syo+UApvpG+Jc2m9J0oNZ
	SO6ISVxhUzq2Ljc6+bdySf38/FZJ9X0xkDfwApFo+ooeyqZbBDdk2wZX3ER/65w=
	=
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vkmfym2gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 14:18:28 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CF998100079;
	Wed, 17 Jan 2024 14:18:27 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6EACB2085C4;
	Wed, 17 Jan 2024 14:18:27 +0100 (CET)
Received: from localhost (10.252.22.63) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 17 Jan
 2024 14:18:27 +0100
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [PATCH 0/2] remoteproc: stm32: Fix sparse warnings
Date: Wed, 17 Jan 2024 14:18:15 +0100
Message-ID: <20240117131817.3338146-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02

Fix warnings reported by sparse using make option "C=1"

Arnaud Pouliquen (2):
  remoteproc: stm32: Fix incorrect type in assignment for va
  remoteproc: stm32: Fix incorrect type assignment returned by
    stm32_rproc_get_loaded_rsc_tablef

 drivers/remoteproc/stm32_rproc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
-- 
2.25.1


