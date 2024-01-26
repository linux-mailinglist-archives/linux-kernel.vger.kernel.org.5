Return-Path: <linux-kernel+bounces-40058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BEF83D984
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86FDD1C235F0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5799F17730;
	Fri, 26 Jan 2024 11:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=unist.ac.kr header.i=@unist.ac.kr header.b="D5lmveq1"
Received: from KOR01-PS2-obe.outbound.protection.outlook.com (mail-ps2kor01on2139.outbound.protection.outlook.com [40.107.128.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A1014275;
	Fri, 26 Jan 2024 11:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.128.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706269340; cv=fail; b=FIgIVsawOeiBrxZ4iuW9ZusvbGdNmxbzo0pfzZmTWOBraTY8d38tLd/0NB+wU4YiNDr4VOHkpPJNm2gCF1ygxqVgsG5tZJfIOew0XKq40mltUJKRCPMYojYta4yZYK4lwpau4K4MnjSEyD5eEfkrQ9vUNgOBzjljfIRJxRvU/4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706269340; c=relaxed/simple;
	bh=yOzQUDbGftkWuJnn62lKJLKh5tS3MyKFBBEZrBwS7io=;
	h=From:Date:Subject:Message-Id:To:Cc:MIME-Version:Content-Type; b=hIS/a+sHbNDdURykQ3ltIwBpM1+78R0xhMGzsnyt0mnv0GAOPjwIVyfzmr8Rkc/f6XiojI8FmGBMLR4D7AYyGMUVKcKdft2A5mNNGCIciOzkoWM3aVrT3f/i7VHkyeqrIzTK4lePVub4T6voyk+6DHrB/xTCeXf2IcL81uF+bdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unist.ac.kr; spf=pass smtp.mailfrom=unist.ac.kr; dkim=pass (1024-bit key) header.d=unist.ac.kr header.i=@unist.ac.kr header.b=D5lmveq1; arc=fail smtp.client-ip=40.107.128.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unist.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unist.ac.kr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJotMXqo5jPC8XYSSF+a6/lf9lsGchfrG6awgHNoxBlhfvqpGPXZZ7Rbepr0l75LoJamR9EQRfsHVOYwDmUSZsXd4aW7V6VIP5ALfQw1KgQ/XZyaIzp58dIud5DbYSkZJtSvEsEzyl8erdiCCG8fGYZBVFltWOLpbk734YJUkHRpwMufGY4xw38vP1yjUNvyHjDY1orOk2Is4gdU0r8X/273vp/qjrKgFxKftxQv4RGnUb8ty2pDEGASFEG6mThJ4mzOjL3mh5olZ2wPuGHkAa03kQMDf0QI3xLqHanou9bN2HzP2iYrRD/ce3DFEm7jwjx9s8BaVN5DX8wAyvOBYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOzQUDbGftkWuJnn62lKJLKh5tS3MyKFBBEZrBwS7io=;
 b=ez+yf3X1B5mYNjQYnzywPY41lEKt6PkaiQdWbsnWPBYN60M0znNxMi8wiyVOv+h/ViydCv9sTb3QwBgQeWZR7WuImDWekwpQ21ueovJQXcJNV3fxtKAouz62GfUUlQNT9cxkk38w7zGqW3+Bn73cqbf8XDUGQdmA6DbSmccLQsbPOCu/EFoqHZnySjSGpODYbjAAeagPXiizODIITY3B7vUtAJZsdvv2+XNyoycIkZSVrqW+lYFEgu+yDiUkTmXmgEgW7EVte5VdD68sf9ysTLsqdHsd1rraLOV8BoHhYJplTydPE68MGnfYK7KvVy87mXF1WUmGweEJXbLS9ajqnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unist.ac.kr;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOzQUDbGftkWuJnn62lKJLKh5tS3MyKFBBEZrBwS7io=;
 b=D5lmveq11D/nQJvY2qhDKAKlFq1R4FgYYUiodLF1MGXmCffRFRCmHYoEqK5V4j/KOlo6TbaIneZFjMlbf6DdLET+yDaDFhJlyDWEUrBS9lDVGihwfRzAgOKtb7lD0ljm92C/lFaK/zz5awpvzCQOLWVCAVDwr9xyyrNAIaSDytA=
Received: from substrate.office.com (2603:1096:101:1b6::9) by
 SL2P216MB2532.KORP216.PROD.OUTLOOK.COM with HTTP via
 SE2P216CA0048.KORP216.PROD.OUTLOOK.COM; Fri, 26 Jan 2024 11:42:15 +0000
From: =?utf-8?b?KO2VmeyDnSkg7J6l7J246recICjsu7Ttk6jthLDqs7XtlZnqs7wp?=
	<ingyujang25@unist.ac.kr>
Date: Fri, 26 Jan 2024 11:42:15 +0000
Subject: Recall: [PATCH] Remove redundant check for usb_generic_driver_probe
Message-Id: <3RI8B60J4MU4.B8HML3SKIYJ31@se1p216mb1336>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 ysjeon@unist.ac.kr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-MS-PublicTrafficType: Email
client-request-id: f9fdda10-0a13-a1f2-1339-c36e1cba72f0
request-id: f9fdda10-0a13-a1f2-1339-c36e1cba72f0
X-MS-TrafficTypeDiagnostic: SL2P216MB2532:EE_MessageRecallEmail
X-MS-Exchange-RecallReportGenerated: true
X-LD-Processed: e8715ec0-6179-432a-a864-54ea4008adc2,ExtAddr
X-MS-Exchange-RecallReportCfmGenerated: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZJu+9rbKdiX7n0a27u9s700bKshKoAddBrPnVRsWNOKaCLNmdXLoPFv8pZIkaUrNE2nowD599Edvete4VozF3/dK+LUDdKHSQ00Cn7VvLPnC1BQw2k8U/QKyRIlJCqXQ5QG23Fe+Ka64WuPPocNE3oI8b4btsUJ/ROjK4UBNXusGrq+4ddzb9cSIDEavL+RJx4a6hW51JytrvX88v1hXLl+lHEfdU4HhTtj0dyJra97KZnPx998Bg3H95sRXQna9VTfoOr1WuxpsPv7OkFVMm/rriRJRQ6msL50E5B1bRE6LBVtHIDxzts97gqUO1tR9MGcoKi/DQQIGb0GFPnqgj+mG+kwWLepMmgR/NqDonE5mfRRhyNiUT9/QwUgZ95YCovNYIw8JAuBXyICw8jPKZdLO0h38orJiyGOcZKsRZgr0hS/iWq8rbV2FaR1ubal2z7z7VwRk0Zd4J5fMiomZv4em4HD+btjbkJIE9JRxawX8qJ/g246Ob7ISE2gcPVFknqEbYdP7gYz/sWXw4MfMCBae3vt+nOQL55zdNien/+TokBQIJ8wPHt97XFpIZqoR/YLuPo1TWlP39ReoiD+MkXTvt21Ig89jEFmvrfnDcextbkvo+E/ddHbBYRfQZDdsxjN2p6sFX9ncYNxy2+bVnQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(8676002)(9686003)(4326008)(2906002)(6512007)(6506007)(316002)(5660300002)(83380400001)(786003)(6916009)(86362001)(33716001)(85182001)(107886003)(6486002)(478600001)(558084003)(33656002)(9316004)(47440500001)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nzquc8LD//1afFfVcqjHe8tSWTivoX4S/2UdsOYuFAW1cF0Ixkn+POHdEC+bzszBt/6BINVtfZourg1pr7T1+/a4zqbMam9r61DfWqg9cZvcLtLA7gY1kQUGh3RCFlKe/DVqmINytPgdGYClCly1AXOK15pP9VjzZ1kY51BwHyYXWQ/z1zi2rT/kzuOYA7DikbB8HX4FBOEEe7wx1kaWztm/wQsC498kp1azqJ3Uglu4odmrDsOTc3XIH9sRCQ0uIhxmP3cWP6kcmo1e5SlJGsmqgpnZx5Rqn28tZoZLC4ElmHiIpCsXP89OoxvnQ7WCO1q+hiHm/rkEvPhZ1vsT8n+687ogoWZUp2HBnJovYa5RitXxQntdLFR2jPPfQCxVeyNrnO07oNqbA7U+jqhYi20ATDdcldlP7q1f9jLOri4=
X-OriginatorOrg: unist.ac.kr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HttpSubmission-SL2P216MB2532
X-MS-Exchange-CrossTenant-Id: e8715ec0-6179-432a-a864-54ea4008adc2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 11:42:15.8098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id:
	eedaa011-28a2-4ac6-5d6f-08dc1e63d840
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2P216MB2532

ingyujang25@unist.ac.kr would like to recall the message, "[PATCH] Remove redundant check for usb_generic_driver_probe".

