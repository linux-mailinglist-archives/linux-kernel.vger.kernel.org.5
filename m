Return-Path: <linux-kernel+bounces-9686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE5581C99C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38D21C22893
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766C619443;
	Fri, 22 Dec 2023 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="DV6eg6SP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2129.outbound.protection.outlook.com [40.107.244.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F471863A;
	Fri, 22 Dec 2023 12:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Sony.onmicrosoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N58OQdVfXmAS0E27HlNJXScoIWusuG59w3tLToEw4Xu1Xl8QjS2tpl/oOwSp+xQoulRuw6tDtXM1zd3b6YoET6sj04NLPIQNVOey2STAxhNWclqNMfCzf4zdyMGGHbcpIZhtnT41k7yBtyDxEVRgJ4bT5VcVoLc0xxD6hVqkpc0Vh4cA0aST1/tJx9YQk7UBYlrZTnWYFKvNW9UU9ku/K2kPYPZQp9OCtFqoexTsaCWj/V42T1sAFGivFU27TosBdYtEXBmx5xFZ3DC4uz2l+ByrtMlBNXzRVlJMXx4HX8iXJwv4sWtm4Bs0EZIUfG23UAQkGr31nSimM4E9c50FAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/ki2aFKnJoA3EeEbB6TQy5cdkX87h7ZEEg80/CFRbc=;
 b=D+a7tVM9zcBRvYf4OZkQo1qNvGhgf6yAI6wNbCsrLE16+xPpCz+HlLIwSX3ZdhxGLOK6CihrPcxzwtiXIuY1Am41z8qj+3lnyLNilX0O08x6cbKLkTriCPVuhRjEoEee7u3bqAYNVx4hWhVwfF8pADzv0rP6lLhwGnxBfM50xjfkGY0xeSALByFs2vgOguaWGUbRZSFncuJHrvgeb9RIJ+RZUQYkTkt/+xvFbjRjTLh/sjY1VaqHXn+6SlSQxiMmECn7KFPi52rX1s3fCkkvtglHr6kRaYHjemQVrvySYZj+kOe1XXDv8hIEhFC5jc75+8wZrRKkb54B3rNdfKQQ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.198) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=mail.sony.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=sony.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/ki2aFKnJoA3EeEbB6TQy5cdkX87h7ZEEg80/CFRbc=;
 b=DV6eg6SPqwcoZdpauHtC+2GOTkVZhrhzV2cwDdjdOJNG1igjdwmEFaGaYnuH0ObUPNgTLVNnipBUvU4e4+NDCMIeh6u5orQ1kfeoWukqeXmaE7ZdgFQUgVX24uoOHOkwMMwjIQbFvFiPKS4dxNhdoLd+aIGsNdCdXP/aFjc5Grc=
Received: from BLAPR03CA0052.namprd03.prod.outlook.com (2603:10b6:208:32d::27)
 by SJ0PR13MB5690.namprd13.prod.outlook.com (2603:10b6:a03:405::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 12:01:01 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::a8) by BLAPR03CA0052.outlook.office365.com
 (2603:10b6:208:32d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21 via Frontend
 Transport; Fri, 22 Dec 2023 12:01:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.198)
 smtp.mailfrom=mail.sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of mail.sony.com does not
 designate 121.100.38.198 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.198;
 helo=gepdcl09.sg.gdce.sony.com.sg;
Received: from gepdcl09.sg.gdce.sony.com.sg (121.100.38.198) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Fri, 22 Dec 2023 12:01:00 +0000
Received: from gepdcl02.s.gdce.sony.com.sg (SGGDCSE1NS07.sony.com.sg [146.215.123.196])
	by gepdcl09.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 3BMC0u1S007778;
	Fri, 22 Dec 2023 20:00:57 +0800
Received: from mail.sony.com ([43.88.80.246])
	by gepdcl02.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 3BMC0tLH023097;
	Fri, 22 Dec 2023 20:00:55 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id 2863A20C1E09; Fri, 22 Dec 2023 17:30:44 +0530 (IST)
From: Sreenath Vijayan <sreenath.vijayan@sony.com>
To: rdunlap@infradead.org
Cc: anandakumar.balasubramaniam@sony.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, sreenath.vijayan@sony.com,
        taichi.shimoyashiki@sony.com
Subject: Re: [PATCH] tty/sysrq: Dump kernel ring buffer messages via sysrq
Date: Fri, 22 Dec 2023 17:14:51 +0530
Message-ID: <20231222115732.1683728-3-sreenath.vijayan@sony.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cc5c5ceb-cb07-4fb3-95f0-c114dd12a755@infradead.org>
References: <cc5c5ceb-cb07-4fb3-95f0-c114dd12a755@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|SJ0PR13MB5690:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1fe7bab6-be71-4edb-123f-08dc02e5aa92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TkBeVmcuk5475lWnrUI9ePsoZyLTsTg6dR1hfadDShk19KCCTpFB+o34MHm+2766f2oCCJZDoFI7V3dH5L6V9Aaa+7Anceqf2UQlLBCpOxrUfcQhh6cnstkeDFxikL9/7mD1iMWCpXjs49Dt71AD6c3xP+p7Kw9EV16l1pgXUqf1av9sX1zTwFzxs5ovZIemKB8m0lQeLnAmOKcw2DNUPXS3H4Czzjyek9OIXcC5+xNKFneUMSDWQriRAA9d7V3e5jC0IXiYKwaLM0WKdChaJnD4hAzFF5+0nReivsyUmV9G2FcWE3jn/VPF3gzsQjGyXT6YCUwXREApVEJQwmXqckSkl5Mlp0k7NYmyAxE5ogb/HmhIn8X0x/bEake29RzF4TKlI58NPqJPA7LM/KfG5lXJgMrhzwEZx+HnblYli7GsLd/CG+Jm71vs96YCVc0h6OjJOEjxHJN5unysL5ztSJINAVmSZcjdvGgP+TJnODkxAmvT6gM0p0gTYXyQrqy7PevGMjFWzGHk45ebWO5ifYI8sSX3ARNPsPJmvxz0iQ7rFCC55gs5IVjL/DQ9oBGlWCBbdu9PZZwn4gcCHIzGQevCT/HPGlyfmJ0VfP6OjIIRvMb/lnr1XXE0nJGVKlCqAIqRxx8lYzSPfAKaLd4B6kNEBlv6+d0e3I1CKz7BR5OOW74AslA9UWKvqxBq+1KKV9z5rESjC9qp1urjX7O1DMYCKx8cmhTh9ZNrplrBzGzImUuEouYFhFAUqKgqOr0G+FSppJQwdgArFrR74aT4TcBiAnLN1acQjE8pUAcxNtSz8UP/0GDR0ItaAsq26cKvgUSL7Db3YasODyg7E2TVXw==
X-Forefront-Antispam-Report:
	CIP:121.100.38.198;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl09.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230173577357003)(230922051799003)(230273577357003)(1800799012)(64100799003)(451199024)(82310400011)(46966006)(40470700004)(4326008)(34206002)(450100002)(8936002)(8676002)(70206006)(316002)(42186006)(70586007)(82960400001)(356005)(82740400003)(2906002)(41300700001)(36756003)(81166007)(44832011)(83170400001)(5660300002)(15650500001)(40480700001)(53546011)(6666004)(498600001)(47076005)(426003)(6266002)(26005)(336012)(83380400001)(2616005)(1076003)(107886003)(40460700003)(35950700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 12:01:00.3483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe7bab6-be71-4edb-123f-08dc02e5aa92
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.198];Helo=[gepdcl09.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5690

On Thu, Dec 21, 2023 at 03:12:46PM -0800, Randy Dunlap wrote:
> 
> 
> On 12/21/23 08:52, Greg KH wrote:
> > On Thu, Dec 21, 2023 at 07:09:53PM +0530, Sreenath Vijayan wrote:
> >> When terminal is unresponsive, one cannot use dmesg to view kernel
> >> ring buffer messages. Also, syslog services may be disabled,
> >> to check them after a reboot, especially on embedded systems.
> >> In this scenario, dump the kernel ring buffer messages via sysrq
> >> by pressing sysrq+D.
> >>
> >> Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>
> >> Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
> >> ---
> >>  Documentation/admin-guide/sysrq.rst |  2 ++
> >>  drivers/tty/sysrq.c                 | 43 ++++++++++++++++++++++++++++-
> >>  2 files changed, 44 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
> >> index 2f2e5bd440f9..464c4e138b9d 100644
> >> --- a/Documentation/admin-guide/sysrq.rst
> >> +++ b/Documentation/admin-guide/sysrq.rst
> >> @@ -161,6 +161,8 @@ Command	    Function
> >>              will be printed to your console. (``0``, for example would make
> >>              it so that only emergency messages like PANICs or OOPSes would
> >>              make it to your console.)
> >> +
> >> +``D``	    Dump the kernel ring buffer
> >>  =========== ===================================================================
> > 
> > Nit, this doesn't line up anymore :(
> 
> Yes, that will cause a docs build warning.

Thank you for the review comments. When I apply the patch, I don't
notice any alignment issues in the document. I tried with multiple
editors(vim,emacs) and the combination of tabs and spaces looks to
be the same as in the existing lines above the newly added line.
Tried "make htmldocs" and no warnings were observed and the html
page looks ok. Please suggest the modifications to be done.

> 
> Also, can you be more explicit about which ring buffer this patch
> is referring to, please.
> 

We see the term "kernel ring buffer" used throughout the documents
and commit messages, and thought it is the right term. Even dmesg
manual page uses it. Would "kernel log buffer" be a more appropriate
term? Please share your suggestion.

Thanks,
Sreenath

