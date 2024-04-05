Return-Path: <linux-kernel+bounces-132726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55337899953
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B97A283E6A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E4115FD05;
	Fri,  5 Apr 2024 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Sa9ZNWh/";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="kz9OOXXd"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C0B15FD01;
	Fri,  5 Apr 2024 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308800; cv=fail; b=hwN+XRDTgL5g5cGSzbcqfv3RixY0J6Aalvj4e17Xw6+D0/poJRnIZDdZB4IX87P7fZ3Dz2oL+pisrXMvt0ZP6zCWcvSmq8iiHKG5M5qdDmSiAadnh35XDekZtw91bN1ppNxzjE+exDqIUSljVtu6O1k1wX9a7tglapEeeGrD2gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308800; c=relaxed/simple;
	bh=hTf0upw0HQjpnQ6UQarFtMoCKi8zE4LKkr6HqiuKwo8=;
	h=From:Date:Subject:Message-Id:To:CC:MIME-Version:Content-Type; b=raTVY3Q861oecYsC/IJuAC6CBxM5OF+1uECBAzlCmGAAGy/s2Xy3jFMSRHtKhb+s0lWQK5G3WcaheZzdFOSsPXlIfyaSHf0m/pOqYDoxBXIcDwin6UrJQxiPLFsUHihoGOX93cnln5KZgjzxcG5m1Ru0MVCl2yAfS5K87G4zFbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Sa9ZNWh/; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=kz9OOXXd; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: aa539bdcf32d11ee935d6952f98a51a9-20240405
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:CC:To:Message-Id:Subject:Date:From; bh=hTf0upw0HQjpnQ6UQarFtMoCKi8zE4LKkr6HqiuKwo8=;
	b=Sa9ZNWh/rx970elANfro1D7OGj7XHXNSjc73a8fAlWIlAl9fQMIigOESggg7FbO1EswhCusOMgX++5xwigdr54McDQ0AOlM9ddx/+WFD+AVrN91UjRj1Hy4ThTB87O1n7vK+n+6oVrV42/wd/lcgdGsDnnTTi3vmRPZvT0JyOks=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:312ab479-4314-4c9f-a24f-6e581d820b97,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:7227b900-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: aa539bdcf32d11ee935d6952f98a51a9-20240405
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <deren.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 214234302; Fri, 05 Apr 2024 17:19:55 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 5 Apr 2024 17:19:53 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 5 Apr 2024 17:19:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQrZouLhwXwTOGUqiNnePlyb5Uyf13bHh55/u1qLCu8PuVl36uF+iVf5QA8Pc8wVXJ2q7heXPtKboUaTfYSZhfrzwwKgqWetpllOtLR9HZ4BlC7kSInGMLiRmJWZz1rYwLmEydbDs4wUKTet0n7PTHNJ8M1bTGvaty99YcLuwFb+IWYpsKdAzzOLnZCUp65SNKYrY7FxZvHu/6jnt6ucR1v6QjlExGL2dDQ4bicIqoauZpPUTgPmK8j8W6Nf5Se0GLvkBQzPadS3WN+F7b7SMh10hK2Z4GaUAmvoYuAVGm8wl20c/Xq34Vppb87k5Z70FsmeaTUzjZiHC/4UI1L3Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTf0upw0HQjpnQ6UQarFtMoCKi8zE4LKkr6HqiuKwo8=;
 b=VTLEUoOVxQ5FtXeaOrOAHuTrp5RzSXS9J9x22fGwVP+eaAHir8T4twqTj18I3/z0S8DGRVuzlULFZeaiSUF7Fgujr3jv3RXeqD1Mi4IAKCsI/uLd/TIq0UKEXXqAXD+PSYUvHWjohTIpvNnFzOqPdJZ9SEIuO8k5gAlooC92ue9YDOe0BKDKdKcUkduZcY06j+RjrsRgK3urTuDtWPp0nt6EWziSpwn/Yzv5H/UH/C/hVfA5AfP14bh0UqxMBkVvz9w5CAF1cPofIUvFqQIda+ImEPTIDfAl8KCavQdF+9exX+VGhMD4OrAMfVU/Ltu49auJM7SRjT152VImDuTmgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTf0upw0HQjpnQ6UQarFtMoCKi8zE4LKkr6HqiuKwo8=;
 b=kz9OOXXdjVNz9kByk0+HdFulsgjkfEw9b2e/tKSeLe4wwN1H6gAtgcSUB6BVemou3XMzmmr+wYYDNt9h0P1pCms34c4v/u7IYX4ArbR0M0hn6RYaDslivMvXG5CqAa1Foc76xUOsVE4ArMllyN6nnnDfE650koV/KBe8zbJdUVU=
Received: from substrate.office.com (2603:1096:101:183::7) by
 SEZPR03MB8122.apcprd03.prod.outlook.com with HTTP via
 PU1PR06CA0020.APCPRD06.PROD.OUTLOOK.COM; Fri, 5 Apr 2024 09:19:51 +0000
From: Deren Wu =?utf-8?b?KOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
Date: Fri, 05 Apr 2024 09:19:51 +0000
Subject: Recall: Re: [SPAM]Re: [PATCH] [PATCH] Bluetooth: btusb: Add support
 Mediatek MT7920
Message-Id: <A28MT1PXPMU4.9N1TSV0GJ9WQ2@si2pr03mb5515>
To: <regressions@lists.linux.dev>, <mike@fireburn.co.uk>,
	<Peter.Tsao@mediatek.com>
CC: <Aaron.Hou@mediatek.com>, <Chris.Lu@mediatek.com>,
	<johan.hedberg@gmail.com>, <linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<luiz.dentz@gmail.com>, <marcel@holtmann.org>, <Sean.Wang@mediatek.com>,
	<steve.lee@mediatek.com>, <regressions@lists.linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-MS-PublicTrafficType: Email
client-request-id: 8cb3ab86-11f1-4966-5fac-605dad4d4705
request-id: 8cb3ab86-11f1-4966-5fac-605dad4d4705
X-MS-TrafficTypeDiagnostic: SEZPR03MB8122:EE_MessageRecallEmail
X-MS-Exchange-RecallReportGenerated: true
X-MS-Exchange-RecallReportCfmGenerated: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FEt121WSqyxpOEpGptroDvbYRl0/56Z5TbFaHu3RzYHfWNnbJUXK7oYwZ4F0y9EhrZgd9hUe4N+ZNM8PuqBg90rhM9CNoqixcrECAG+7Wh/IJGOLPN64rMg3F7OuwEtVDSLXNfOx5fcsGM3tdzo4HBKq3k4Of++jhX/+vSnO5y2Be2i5YaqokSViuAhewNIWEWATHCrWH/DYoyadf+mcD9C3PpeyeQHNjeNbx6ECsO+J6WVtUPy6Wd/pfed5mp5IMSE6OxJRXf67+kXO0+zc3az1EklXf6K82BECYorifMiC7/DffnWerh5YKM2Y7dgW3vwkdIqtkj+Cvqdqyc4gXprsAGXIVU9hdPTjhaB1Z3TfqZpo4WURtKewYUbntJgk+vo85NsJplUdGkJ7Hqx2ivKNKd3roFprF8K1vSLHLOr3cEZ2NpApEEqGtn61z0uhb+IFf64YGTg04+YdgC7pkP4af9138t/urMtN6GEHT1OlHkEutqEa4Bt7MSX8MgsXwvfExgyZzqltrDhz0YlIzgKu8ExeSwVKdldduPSFSd5XTL7sng6Fj65gfHf5qL5ETEdn2/bIfctK2lXWuYc58mc26nYpK+TvCLdTs/qLGIW4Noo1eOwsPyMBamDJgl2iSlERmYCUuO53Jc57CVS3yKRf5m9jDqL+ufDl0HsuXPHyH9RbcuwSf3syY1jUyIxT/7mzLkoTU534vO/YVP3fNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(217643003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 085e89RHFP+FdVSOzhCzCtF8QsYJSaEnXsLR1Jw0M9qwXOroNpLUCvUvdyln/3z11HCqOVGqDnGsVZDWFXPQyWFRYbLd9foY6YzgWwDJOTHP4yFHuze1G2t9qBPjk2t3TVEswJwJoBgknFtSTLT/znLd+YxqnYcFn9wt7btMVIUV1wPkDM/GYEUDjzT9wDEtgzRGhAgYoFMYc0k/WAhHy4sdmL0q3FqVLi4H2Z3B1z50Yerr6ofmJbZQQ0JAzld6UpqovpNEzpmh8jsGgkbXBR0UO6GT1mwuLnCH4lXoTX9oahedttJM2j36KhLBFCBaKXjvDh6kp4sJlBsAP6+WzYzoVfzIDbwwJnh8Gz3VCq9KkgEsf7lHTAVuDDAyrxrNSIFJQX6aLHaZrGavY2b97Yf+boIoeFA4ayiEdMKuo/o=
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HttpSubmission-SEZPR03MB8122
X-MS-Exchange-CrossTenant-Id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 09:19:51.2982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: addf9e4c-0fac-4335-990f-08dc55518c45
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8122
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.375800-8.000000
X-TMASE-MatchedRID: uX0qRX/JYJSALnLwcLJ8c0+4wmL9kCTxjzwigoyOACTd1Nq3SV2z16PF
	jJEFr+olmP38c3DNiySKpAefy6FsjO2eKH3LGf9LanE1Ybb9x4X3FLeZXNZS4CiM3WUt6LtFJ4R
	unYQZH/UPM0KP7wGGBtF9xxnqBdR/Z+5pUUnZoXcJW8x7nv6dHg4SVUX42+9WP5uMSYbkz+bZZr
	s9ioNnot+cnxLKcBb8lExlQIQeRG0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.375800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	87B3475F4BF228255B343FD9A117781AD4643BFAF4B31CB4E05559A659DD8B602000:8

Deren.Wu@mediatek.com would like to recall the message, "Re: [SPAM]Re: [PATCH] [PATCH] Bluetooth: btusb: Add support Mediatek MT7920".

