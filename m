Return-Path: <linux-kernel+bounces-56799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEACE84CF58
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915D62874F1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C39823BD;
	Wed,  7 Feb 2024 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dACm1iHS"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350611E532;
	Wed,  7 Feb 2024 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707325480; cv=none; b=mgcfcC5sYlKrs4nQ5+YUkG+DrMnP84mby62HCfbSE7HGv681F/K1cT31ihr1e5AfkdP6w5EKa24w+yJ8iLCl1/lKD2VhA9up3BNHI77xMCM3N4dfe40G5s0RSNKBgOxwhUiyXpOh7nNfPW4VrRCcz++tM+ZiTeAxgHOu7MCTh20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707325480; c=relaxed/simple;
	bh=7E2tN5vNsRQcYCZDoKyseWRCgmaTVw2l7a9vlKrj/Xs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gMFqef+kEz3Vnm+EdFt40l4F3gv2+tMxayzmus93YVoYZ0tLfPoaQ6a9Eh/muctVi10FRiwzgNg6m6qV/IYDI/ykzFeJkk3dfyPnucHThpYMR6Qo1VW5x7RjmqdSdN5rhoLzPSaZC2uIIXqfSwoWRdr7ZDzvTbr0TpG5xO1JguU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=none smtp.helo=mx0b-0016f401.pphosted.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dACm1iHS; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 417BpkUp032015;
	Wed, 7 Feb 2024 09:04:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=ciZwADXn
	NmNJYiBeTNeY+fNdnoE/X0K8nMca2ob/mgM=; b=dACm1iHS0rXLEsJ03P+nYEHv
	zkE8g0BXTe83spRqshCMWKUyj9FJXjfqcS4lKgb958IfI2hKIaUM85DOXVI6+JVT
	bE7sk2CwHNygWKJLzlh3rrU/CoVcwfmPpt/aESTd1IpZ8F87g41utx+69y4/g/20
	3pwekRVvKVNzhO6KyLMvpMVNb496K41pK0ns4aiYDZdF8AMb28+aAnCxW2fwQCDM
	g9BHQpQIzO5WQ9BWLyDYd/7nEhFkieFRPBk3Z/d01iGglSviwR0YwHtrJabXuil7
	RQ8d4POs9WvRmGppeTQq5r6CWQj/JcjMQ3oWceDd836CQqYet9PT9R8oFZnjCw==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3w46k7tkpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 09:04:36 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 7 Feb
 2024 09:04:35 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 7 Feb 2024 09:04:35 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id 687F55E6870;
	Wed,  7 Feb 2024 09:04:33 -0800 (PST)
From: Elad Nachman <enachman@marvell.com>
To: <huziji@marvell.com>, <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>
Subject: [PATCH 0/2] Fix PHY init timeout issues
Date: Wed, 7 Feb 2024 19:04:23 +0200
Message-ID: <20240207170425.478558-1-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0tKNMpxriajs4j1b8qwrFpbJZ6Sq9Tq2
X-Proofpoint-GUID: 0tKNMpxriajs4j1b8qwrFpbJZ6Sq9Tq2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_08,2024-02-07_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

Fix PHY init timeout issues:

1. Clock Stability issue causing PHY timeout

2. Timeout taking longer than needed on AC5X.
   Solve by constantly testing the PHY init bit
   until it toggles, but up to 100X timeout factor.

Elad Nachman (2):
  mmc: xenon: fix PHY init clock stability
  mmc: xenon: add timeout for PHY init complete

 drivers/mmc/host/sdhci-xenon-phy.c | 54 ++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 6 deletions(-)

-- 
2.25.1


