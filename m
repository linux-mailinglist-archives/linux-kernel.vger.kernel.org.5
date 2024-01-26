Return-Path: <linux-kernel+bounces-40057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F137083D982
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED9F6B277A4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE52817565;
	Fri, 26 Jan 2024 11:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=unist.ac.kr header.i=@unist.ac.kr header.b="SHADBHSG"
Received: from KOR01-SL2-obe.outbound.protection.outlook.com (mail-sl2kor01on2090.outbound.protection.outlook.com [40.107.129.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810B31427F;
	Fri, 26 Jan 2024 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.129.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706269328; cv=fail; b=OzVS0aXdYWzczA65i9wEooyuUK+iS7GvTvo5ICUf81aDiA+DiQD8riNX6u4Aiak531Y9YG38vBGdTP+DL2gDtlUkjVyKsaVRK/MCC4u73n8qGr/7BMDCtBV5+NEZXRWqVjINPmpTDqeekBZaxwJx9/NeiVYrImoibcnsqFBGwek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706269328; c=relaxed/simple;
	bh=WzQvUPQwrS5BbrwoJaSdzHIesomd9dTnfcHSkUrAqps=;
	h=From:Date:Subject:Message-Id:To:Cc:MIME-Version:Content-Type; b=Xy56Oo/3yNpOBkq4ilXjqLMUs3PY8mW427qQNNrLOr06pR8w8y9Jafbw6GmKhePs9XSB1A85k22VocMHf2QUouEJmcS//zFkEemba3iDtCRLc94HUApvhsUJnIuPJXA2RBbRZLlmrGh2gsfFW5Sjdz0XuEUTGQ0it1UG1deB4Uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unist.ac.kr; spf=pass smtp.mailfrom=unist.ac.kr; dkim=pass (1024-bit key) header.d=unist.ac.kr header.i=@unist.ac.kr header.b=SHADBHSG; arc=fail smtp.client-ip=40.107.129.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unist.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unist.ac.kr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YD5PPD/cGFQrmLaolGJAWy9HsqYZe74Y023tjhpDGlY+PqYnk3WLcTo7AGXVhXw99+/gxa1NB12Q0VefoG57rR6z5GkuqOYPYv7j/yssJJti1mvR5niP9lLTIsnP3qR2HMa7HpYUKZnac4EFArp6a9m/BXs/GgWsSbT42dFrdVzfEydkuz5zPrOyMjF2hC+UmY6R6cHiv7UUbLaUClggq2rFvZRw4KV2Mt8K9rt4nlxNfV7zSVWZpdMF1hTBd4h/1W8/lcoM4orYZBPucsRE3UFfBp0xcfCOMPmPBwPFEUfPo9jTvMNxGP8CXzZIWenvl0fHwdnZf5MOrdJpOpdyEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzQvUPQwrS5BbrwoJaSdzHIesomd9dTnfcHSkUrAqps=;
 b=URdrc7+U1hCzhLYRq02O0iWOtRIfSTxar7+QK/jW1bbLgAn6pl53J2rrBwEI0VAEQsMX9MlVs+ZWw3eATQt82+hlKdYKCsKJrmC7qSqgSVVSAqOWrqhIKYj/ZSyar1DQH3NLmUe0EWCPif2OmJJFyOkn+BConqEA67uTK40NJiSIvJITMgqjqw0Erid2p27o8w7wyHQfxI9+P3Qdo3VDEVYM38k0Qc33pH+0TRHrgUCljrAObBb8koa+Mrv5OLKK/KE2RQdxpyDOS6HBJ1eGT4umf69RPqzaV+vIzwmlroqxuiWFpQYrbbYtW3QjRHS3j/eWYIjiOwG3Hs3hphvoeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unist.ac.kr;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzQvUPQwrS5BbrwoJaSdzHIesomd9dTnfcHSkUrAqps=;
 b=SHADBHSG1gn5seyMu0BkNEfIMdZRjrhM7svpBH6t9h5r3y4FgFagpcYbKatpwiGach02GMxLFiT9CCiwzaeiL7JlaYZp0+qAl4oh94m6NuhX79f1uAeTiVsofbKc92WmSVKlk3IlJFkdMTZjvDqYr+ZtqtW0BW9M/b70YKDWARg=
Received: from substrate.office.com (2603:1096:301:108::7) by
 PU4P216MB1879.KORP216.PROD.OUTLOOK.COM with HTTP via
 SL2P216CA0086.KORP216.PROD.OUTLOOK.COM; Fri, 26 Jan 2024 11:42:01 +0000
From: =?utf-8?b?KO2VmeyDnSkg7J6l7J246recICjsu7Ttk6jthLDqs7XtlZnqs7wp?=
	<ingyujang25@unist.ac.kr>
Date: Fri, 26 Jan 2024 11:42:01 +0000
Subject: Recall: [PATCH 2/2] Add error checking and returning for
 transport_register_device() in scsi_sysfs_add_host()
Message-Id: <QHRV040J4MU4.4FDM66EZ3EW73@se2p216mb1989>
To: jejb@linux.ibm.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 ysjeon@unist.ac.kr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-MS-PublicTrafficType: Email
client-request-id: 54bae73f-3780-7f6c-1b96-ace545ff0986
request-id: 54bae73f-3780-7f6c-1b96-ace545ff0986
X-MS-TrafficTypeDiagnostic: PU4P216MB1879:EE_MessageRecallEmail
X-MS-Exchange-RecallReportGenerated: true
X-LD-Processed: e8715ec0-6179-432a-a864-54ea4008adc2,ExtAddr
X-MS-Exchange-RecallReportCfmGenerated: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m8vBm4ljo0OJf/1CIPOYkylpit528TF6keUttq4tB/MTZnJgT2tTf0XzjjB38+au2HnXUDzFcN+lLUYowiNVF4vuPpYT+quwGctn/VGs4Cz4AoRHMLF3GGdR0Bi8qw56qjPddEJx9jh3noSCckYlcL/O/PnBTAUVZmI8iPebOrtZnWj5RY31K6Mt9aLI25HAmzljvDfs19DPz6+n2oIScNJ4TG3xXXFBo85ygmdvVmGg/ITwGowHcV0CXY4jrHbCeej5Hq/ctZ11smL5BXaZQL5p49rtUkEvEOdcI1cRqouXy37dXXde+O11A7myP03TrYaYRqadVu8Jv+yj8qsgOr2mUk+ukEo8atjtEFTlAzjdZ8PDARi5FOPO5z7bTIGO+M1xvMCSUGw/edfSX3Rsv9hmBElMEyTyQdLIsq+A991/GkIB9ML0Nmutw78/BswYNq3vgxOmnUQDkPwcJphpl2VuADVYpKi7ZWqlvT99ht9Bi20ktBQUwkVSELgrb1zC+Tl5k0wVR0yJOagCOcKSeaWyOuu+1HnBhr/SY3MPMSnh0SZYHcvVZz523DzZWikgoG2GhCKXC57V/Pqll1fL84WXT7vMTuh86fewCsAIyBDC9v1G59J8ozaFw/Kc5S42
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(4326008)(8676002)(2906002)(9686003)(6512007)(6506007)(316002)(5660300002)(83380400001)(786003)(6916009)(86362001)(33716001)(85182001)(107886003)(6486002)(478600001)(558084003)(33656002)(9316004)(47440500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4YJjfRcDjgFEspigBGQXCvuKQfqAaxbruptXo4H1QMHCj4Yad4BcVcAWVg0E+PDnJS8jHbRF8VRKkz7btzuvKk1IToNUXbZonWxJ/47hpVG9nGPapo61KF4ZYMfMhDmgZh5yMq1mboTvnIR8wIuDBjumTWOWCHw/+TmtVi5ydnztxFMINllMBBbrxdbsK/E64N9Ep5LtreaPj9XTcF34z6ThNB4PYm8EeB1GnEU3vViH6egy8hBZJcoWU+J6SXEJGULZZ9SDgogbmbzZhUlxMwPNtt1XgRg/Y+5VpMy/JrbZeOiyCvxLB6Q5XcY5kXDwyH9/Gt7Hr1YWbZfInOvg8P5hWoy9pXJ5vseVVdY5v8zoLU9VzoGa1mY0+U4NU96ADa+ClGwkJZRh5aIiXUrgmFRDLKXyz9LEB6Au3LzSDEo=
X-OriginatorOrg: unist.ac.kr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HttpSubmission-PU4P216MB1879
X-MS-Exchange-CrossTenant-Id: e8715ec0-6179-432a-a864-54ea4008adc2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 11:42:01.9690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id:
	20ed12ef-59e0-474e-0e43-08dc1e63d002
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB1879

ingyujang25@unist.ac.kr would like to recall the message, "[PATCH 2/2] Add error checking and returning for transport_register_device() in scsi_sysfs_add_host()".

