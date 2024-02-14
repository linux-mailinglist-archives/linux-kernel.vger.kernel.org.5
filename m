Return-Path: <linux-kernel+bounces-65051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8C385472D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92491F29F2C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CE9125BB;
	Wed, 14 Feb 2024 10:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="rWYMzkxs"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E0B17C9E;
	Wed, 14 Feb 2024 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707906768; cv=fail; b=hP8Xv8jtxRchRmUGXakJrWFOjUSXfbimEFKxkwxGr8BMLR//qzCTw0+4H6myo49XGy5c5vVl49bjARMp+DWTthKHHndui/EPurk6ByeYLzNkA64kcFosYwFhO5H4L9jWubDoOKuelTC6ibN+00DPZ2ZD2MZ6Ps+nuCSntvQH2Rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707906768; c=relaxed/simple;
	bh=VcQn8O4rtuFVIho40NUyIxmJgWAX1jdIQJMlEidwmcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poAqU58Zf7KsEXZaYsHTaqcv76vR4El0KOXa84bG77/eytvo9EJHDXc0dIpad/Fwxu76PQ9FReymwtwIHGV4HQ08mixipkgXpY+ktWvva90vNawTc8mXSb7N4W8ZDeTH5tVGlnAK4+pZ8eN2Gs1EP72AjTf6QyM2rwRSewGHK4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b=rWYMzkxs; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZoghpelQfopwViDq1iea5fBpfpoDRfdOmON15Q9cJir+bUzp33H6jRPKzpHgVyEG4Vt1BWQugqrsPhIvmN9ufeRPTHEKBTlgtemmMXVe17RyINKexXudYXRTwUqU5rLVwpTLwPc5fhLW5XDHh+4oPWwMrx2VRXvt7nCIJA5rFPKqXGc9iNv0uW9NU1T1D4jRT8ei5i3HWXcum9TWa/RJhTK+/qEjlG46TtTUQhVJNSB4Z3Nj+2FLNqGW5x1I5h1VkjKSc6N6rcn6UCgzOQlNML882jWFyBSIovEaB7vPv6IbCdhPvJ1OlJGQk5IEZVgSb8qJS9ohE7rSaEPFH2BcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5QexMQpwoTc+UvS2dcpUFqd9yMkc45mj/b/4NMz25Y=;
 b=nI8riGCZj732AY9esacRHxIH3KzD7QzeCfngqaa9SxLqaFaBrShuQ5tgL0u0RmPNUp61XKSbG2fmfgJWemkdNJ3pvAprxQHykv2i+3ba7a4tMrCCN0WdH8m0LUqcuW4CHnn6dzAChcd28mbRPxxFkqMZxWj7Ft2pXlf17fG6wRvst1fMXz0yoGvfzkGkeCRiiW40UghU4CXF/FMhTTjrxZPYkRl5iizJnutcG9fxFf1AgfMmbP0VmaFGag353fEx4uMv5mbfBDL8/VPD733JLMdmS1GuWgPUPkOyxSOEc+ZBQADK8ay2IhZOh/qOBHQF1X3vFVi3OFl0p7tlt8dbDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.196) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5QexMQpwoTc+UvS2dcpUFqd9yMkc45mj/b/4NMz25Y=;
 b=rWYMzkxsA91Af8l9RHmktHYaHVW486rQnuWTmCZc1Tda/tlQYLEdKN/dB6KU72j0+8S5Yy15gTcKvi809KVbGoCrtXwuzi587ePJn9rwYmG3cAgyL3LY2mbV3FurdgZQcBsUBCT1S8NZKTWml6BzidxDEAZz1jn0D1ZnrpN+rwA=
Received: from SA1P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::15)
 by PH0PR13MB4809.namprd13.prod.outlook.com (2603:10b6:510:95::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 10:32:43 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:22c:cafe::89) by SA1P222CA0023.outlook.office365.com
 (2603:10b6:806:22c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Wed, 14 Feb 2024 10:32:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.196)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.196 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.196;
 helo=gepdcl07.sg.gdce.sony.com.sg;
Received: from gepdcl07.sg.gdce.sony.com.sg (121.100.38.196) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 10:32:42 +0000
Received: from gepdcl02.s.gdce.sony.com.sg (SGGDCSE1NS07.sony.com.sg [146.215.123.196])
	by gepdcl07.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 41EAWBQB006067
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 14 Feb 2024 18:32:24 +0800
Received: from mail.sony.com ([43.88.80.246])
	by gepdcl02.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 41EAWAh9001927;
	Wed, 14 Feb 2024 18:32:10 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id 888AF20C089B; Wed, 14 Feb 2024 16:00:43 +0530 (IST)
Date: Wed, 14 Feb 2024 16:00:43 +0530
From: Sreenath Vijayan <sreenath.vijayan@sony.com>
To: Petr Mladek <pmladek@suse.com>
Cc: john.ogness@linutronix.de, corbet@lwn.net, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, rdunlap@infradead.org, rostedt@goodmis.org,
        senozhatsky@chromium.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        taichi.shimoyashiki@sony.com, daniel.palmer@sony.com,
        anandakumar.balasubramaniam@sony.com
Subject: Re: [PATCH v4 0/2] Add support to dump printk buffer to console via
 sysrq
Message-ID: <ZcyWU0V6Kmq0Txqr@sony.com>
References: <cover.1706772349.git.sreenath.vijayan@sony.com>
 <ZcOPuTK4gPsDJjg8@alley>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcOPuTK4gPsDJjg8@alley>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|PH0PR13MB4809:EE_
X-MS-Office365-Filtering-Correlation-Id: b1910106-0b9e-4dd7-a9bb-08dc2d4846f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O3AdOLlaUpMn4wnf5557ZjK76unG3AdGze4qqeiWTmLgCP4vOwOz8ZWmDqiV2uu1fZOJwc+G6ebGoREa2y0Z97ETejEabBm3ryWyy84JWShfq7f0iYjpfyhFOjxqGeRqeowZCCtOOLOLBKoPhzYKBSyID+u1RjKdz2v+/6ClpzKOi5e7kSGKjuj3qJNebW6d+JA7//aP7qHemyHVZXY0rbR+wJi2r8urjNJlis0Ce33xb9BHyHGMSWwjiKlxrYmyuX4K4WX7ygdurQtlYmguq+iCLrzvZDfJWFdWwLTUh27z+3L/28pYJrGJRBEFdnR2cQ4jHZmtyQQZDnKnViVMlR6vhIx3InoAFxC26IJqG5nveAIGtuAt5u8WHUohquDD9EEte+/wIvFBl7+SzLMPf7qJYL+FPNFUIUkuLco6NOpZUeaTyYvvgGcqOL9pjcpOaZeYycwFgdt8vsho17ntMgxSVO8gYTN2q06Uqf9p2qPCn6YftKNGqlwRfDwLPOoKL7vdf46yir0LFoJZMBdamzqzh7blO9RJ+6BLTKr7rbHQMqnto5DTMpN0nJtx6mTV8HX3z50FNPiZAsxg0BMk+Wmj9pMrtJ2F98P7aOcHsZ0=
X-Forefront-Antispam-Report:
	CIP:121.100.38.196;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl07.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(82310400011)(64100799003)(186009)(1800799012)(451199024)(36840700001)(46966006)(40470700004)(2906002)(5660300002)(41300700001)(44832011)(42186006)(316002)(6862004)(450100002)(478600001)(4326008)(70206006)(8936002)(8676002)(107886003)(26005)(83380400001)(426003)(86362001)(82740400003)(81166007)(356005)(36756003)(82960400001)(336012)(2616005)(6266002);DIR:OUT;SFP:1101;
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 10:32:42.4605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1910106-0b9e-4dd7-a9bb-08dc2d4846f5
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.196];Helo=[gepdcl07.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB4809

On Wed, Feb 07, 2024 at 03:12:09PM +0100, Petr Mladek wrote:
> Hi,
> 
> first, I am sorry for joining the game so late. I was sick
> and have had a lot of pending tasks after Christmas's holidays
> and the sickness.
> 
> On Thu 2024-02-01 13:12:39, Sreenath Vijayan wrote:
> > Hi,
> > 
> > This patch series enables one to dump the messages in printk ring
> > buffer unless all CPUs are locked up. This is useful to view the
> > kernel messages when terminal is unresponsive to enter commands
> > like dmesg and syslog services are also disabled, especially on
> > embedded targets.
> 
> What is the exact scenario for this feature, please?
> 

Sometimes, we do some testing without connecting display or consoles
and when we connect back to console, we find the system in a hung
state and unable to enter any commands. The system maynot be
completely locked up. In this scenario, we use this feature to view
the printk buffer to get some idea about why the system is hung.

Basically, this can be used in any scenario where you are unable
to enter commands due to some reason, but atleast one cpu is in
a condition to process the unbound workqueue. We have found this
useful during nfs hangs also.

> IMHO, rewinding the entire log on an unresponsive terminal
> has a questionable value. Most messages would scroll down
> quickly and only the last messages would stay visible.
> 
> Also this code would rewind all consoles, including
> (slow) serial ones. I wonder if rewind on these consoles
> would be useful as well.
> 
> That said, I am not completely against this feature.
> I just want to be sure that it does what you expect.
> 
> Best Regards,
> Petr

We mostly use this to display the kernel messages on serial
consoles and have found it to be working fine. In this case,
we use some terminal emulator and can scroll through the output.

Regards,
Sreenath

