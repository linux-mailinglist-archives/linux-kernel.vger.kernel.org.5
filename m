Return-Path: <linux-kernel+bounces-80726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC321866BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8C02865D7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80851C6A6;
	Mon, 26 Feb 2024 08:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="oq1OJ9Uj"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC0A1C686;
	Mon, 26 Feb 2024 08:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708934930; cv=fail; b=XN/7iuNbReUDjDyzjhOx0OElfORklxSixrqCnL28TRik2so6824817FybAFxqgdmYffh9Pe5NT9k8/Lasnzu877eoY16RcngXEhRW3g6/RoD3x74gNx78oO00TTg3G6h9oO4WOIE1B57N7C3HB4CWGri9fzRSmumcrlrPcdnTF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708934930; c=relaxed/simple;
	bh=C7wAhACUnvWi8puGFH8YeJb5cnbccB4tL2R0TCt7+xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AL8tl8Aa/4OCjri0HPK2cp3N+xdw1fju6/2RrT8/SZBW/EgoPk54heYgh82psEhMMoZOsZAbM2wPlwCq7bFnt8K8oBHVpGwNfXeAMh1wugQoA8ZN+SAL8ZB0if2VB1nqmVh0z00+KV1bHb2o2xPoUi8SQGRRVDaCM3DsZV/p+ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b=oq1OJ9Uj; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTSK862b0gQHcHShpS8oXIL1qc1AMoMSxaorpoAz2kF+k5UmWkU1oKtb1KJwJaTR+3pAuRua0d3Lxo2yKOkf8QZGBLoWCU6eYoN7faKBhMXrf3DHaquTBRvK8I7wkEXT45CeoE+xfVuXOMFEYlwM3OpSb9VXzW59HPjFTkjmQQDnjqVRrIUWigLvChvfsFXl522U6swYr3nCxYLYtTvlNPV9onwVHRownuvUgQAdM/r9hqOjVbTnJ5vqPfaszTC8rJmELvqFaB8dxd0HPYMd/9yGsWdNqJGgKwHjEoza0J99S5SmIf/VFZBpqkcN7ixajnkMz3fpr+JJjJIIXRIDMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5YthapaJVivoTL7rraD8ulIiopaAJYPMokIAO4+ZC4=;
 b=digEv1N1Iv7BXXTX4g95kKjRAMwjJ/ayGXKnpmMrNT4xm+6PC6sSoamBljQVSLITUGjni6VUvhzK9Vr4BMjAf3jqBgH54MBchqvoHzmn64t1xWuaMdYns8z0k4Posi07Dup00qaZvTtM2Mzv8Uhe+el/r7GHpsNUbYdcHA/dRLaKatOLXuP/xNq+0ccabeiJKOvanXwKYRzIzU7+QsRyFKkKGhyOpQSZtucfIk8VkP5oFzF1vkFLRg/TwFmuFbHJcS0wKRuTrkAKh4t506obM4NU2pG86MlWvB+X4YZGIrZ9n5p2hDRJ/qBJOz0mkGvu9fNyNU74YfZMzRfB08esXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.196) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5YthapaJVivoTL7rraD8ulIiopaAJYPMokIAO4+ZC4=;
 b=oq1OJ9UjWhMC/Y7HsLZkqf0GjETE7X7uJyYRNH/Q2rS4CxlIphBrGOwjBXQ0LwfLgpg5awRHJxxTDYk26mJUmpCp3+eiNmW1fsYvM35Mda3CGYyRRPHgomzuSChz8J1IxwlNv6mSqSWUpKUdalbFex+eSksVW5vIKrIlAxispZU=
Received: from BN9PR03CA0174.namprd03.prod.outlook.com (2603:10b6:408:f4::29)
 by SN4PR13MB5741.namprd13.prod.outlook.com (2603:10b6:806:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 08:08:45 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::7a) by BN9PR03CA0174.outlook.office365.com
 (2603:10b6:408:f4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Mon, 26 Feb 2024 08:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.196)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.196 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.196;
 helo=gepdcl07.sg.gdce.sony.com.sg;
Received: from gepdcl07.sg.gdce.sony.com.sg (121.100.38.196) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Mon, 26 Feb 2024 08:08:44 +0000
Received: from gepdcl02.s.gdce.sony.com.sg (SGGDCSE1NS07.sony.com.sg [146.215.123.196])
	by gepdcl07.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 41Q87Gc4015027
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 26 Feb 2024 16:08:26 +0800
Received: from mail.sony.com ([43.88.80.246])
	by gepdcl02.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 41Q87FxV020269;
	Mon, 26 Feb 2024 16:07:15 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id 8392920C06C3; Mon, 26 Feb 2024 13:31:52 +0530 (IST)
Date: Mon, 26 Feb 2024 13:31:52 +0530
From: Sreenath Vijayan <sreenath.vijayan@sony.com>
To: Petr Mladek <pmladek@suse.com>
Cc: john.ogness@linutronix.de, corbet@lwn.net, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, rdunlap@infradead.org, rostedt@goodmis.org,
        senozhatsky@chromium.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        taichi.shimoyashiki@sony.com, daniel.palmer@sony.com,
        anandakumar.balasubramaniam@sony.com
Subject: Re: [PATCH v4 2/2] tty/sysrq: Dump printk ring buffer messages via
 sysrq
Message-ID: <ZdxFcP2UkocRXbm_@sony.com>
References: <cover.1706772349.git.sreenath.vijayan@sony.com>
 <ca8dd18e434f309612c907d90e9f77c09e045b37.1706772349.git.sreenath.vijayan@sony.com>
 <ZcOdLrOPiPJmCec5@alley>
 <ZcygJOj9TaHZUKd-@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcygJOj9TaHZUKd-@sony.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|SN4PR13MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: e4be861c-68c4-4e7e-7b3d-08dc36a22773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6I8JhV55wso8bR3/SaG86BosJmCLxIk6/J5nd74DkxEkph/5kFAzwEkaWnO4LWT2fnb7iUwphuMdmYImrlBRytjixx/pzA2jv+NOVcIxLST0xCitTqSQ3BDSRBlPI9I965ESruH2dgcr9pzyGOsw9pl/Y9+oEprn1Ec7hFJJUI8K1MP3LFBI+uW6OAaXUPOYBhGMSvEcpa0Eq4rUwnaO+BBKodf6CNyDqPDv8LvNH58Pw12pPQHIpxUWfCy2WZDRyeKCSeoFkOanFx5HHL1bumxBX0kapvwx9dBAPPpx7YExFzFKVUw54r3keEPnRVLLQsThBbAmDoXTaTX0y+uwgjtlC0n3XmI08P561wjkajoEfUkztlVkxGFqDdxq2jNNoFE5Ttdg/Gb1BYBc9yZZp+PI2eMD/483BXVcAxiUqcwW4juKwhLKrB5zImN1iKUqFSZlZSSPuJ57LjtQSIS5XV2nktNJevshIUOVz/cHHyFRrfHgysVXfBLkTvY4ASAOSQzKANXnilDBSRRFBfkzQJCIuc4qVzJlZE5DYgNMMVgvqSo8bPnI/9x9YLHRBGplwcO3nVr8gFEhdWsbZSJb/H0i8+7ub4e7gda4RGpkOkU4QlGvTnFEyETqZf2LZBZX3d7jljwT2CNirMu0wrUlepQj7zugbx+p7Isuwh6RnDg2iJ/GgGC0GTJqWDwqok25NJCYLR6p3E7pixIC+GpRj8R3PZsvAQEssJqy0zSFdWzHlYrtGwnac3N7aOBQy//H
X-Forefront-Antispam-Report:
	CIP:121.100.38.196;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl07.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 08:08:44.6749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4be861c-68c4-4e7e-7b3d-08dc36a22773
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.196];Helo=[gepdcl07.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5741

On Wed, Feb 14, 2024 at 04:42:36PM +0530, Sreenath Vijayan wrote:
> On Wed, Feb 07, 2024 at 04:09:34PM +0100, Petr Mladek wrote:
> > Idea:
> > 
> > Using console_trylock() actually might be more reliable than
> > workqueues. console_trylock() might fail repeatably when:
> > 
> >     + the console_lock() owner is stuck. But workqueues would fail
> >       in this case as well.
> > 
> >     + there is a flood of messages. In this case, replaying
> >       the log would not help much.
> > 
> > Another advantage is that the consoles would be flushed
> > in sysrq context with the manipulated console_loglevel.
> > 
> > Best Regards,
> > Petr
> 
> Yes, this seems to work well from interrupt context when the
> console lock owner is not stuck. We can also manipulate
> the console_loglevel. Something like this:
> 
> //in printk.c
> void console_replay_all(void)
> {
>        if (console_trylock()) {
>                __console_rewind_all();
>                console_unlock();
>        }
> }
> 
> //in sysrq.c
> static void sysrq_handle_dmesg_dump(u8 key)
> {
>        int orig_log_level = console_loglevel;
>        console_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
>        console_replay_all();
>        console_loglevel = orig_log_level;
> }
> 
> 
> The downside I see is that the user may have to hit the
> key multiple times or give up trying if the console lock
> owner is busy at the time of key press. This information
> should probably be updated in the documentation.
> 
> Please let me know your opinion.
> 
> Regards,
> Sreenath

Hi,

Kindly let me know your opinion on the suggested changes.

Regards,
Sreenath

