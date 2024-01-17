Return-Path: <linux-kernel+bounces-28822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 316B783036C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494451C23E62
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFDF14A87;
	Wed, 17 Jan 2024 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="sUvW3FQy"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2109.outbound.protection.outlook.com [40.107.95.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A811514277;
	Wed, 17 Jan 2024 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705486839; cv=fail; b=eA76yoTNOES89jpQcc6joodfqjll0qchcxSHyhH5EKaVJOCoYW3qXm/Rsv+GcxRwt5PVswE5aiOvLwugHIZFMLrL0ZTqbKwypFp0glt9r5rwbptC2NuGMulXh4z7q9mxowFGIeqyP4UHv7qYJFNAexKUzhNe2FtGY72nfxqaQX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705486839; c=relaxed/simple;
	bh=ZO1FTeXElU2ol5fqIdN4uJZMgdCT61GvVkPrvOcqnU4=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=SVtFSPhoL+Sx32EcRCBZaCVL2tKxI9AkqSfm9SFBYxuf4l0ZLhm4kuvrVxww0EZzd+Nbom88eKlCXwcpN5bPY950/HvjVprjyqR09+uwzFHBwaCfGtCrcdorcIVoBhcbWFAna2TdlmRAiUor65gi22weA7yKbVhkufxRFxtksB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=Sony.onmicrosoft.com; dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b=sUvW3FQy; arc=fail smtp.client-ip=40.107.95.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Sony.onmicrosoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XS0KCMZJZKeQXDNac2ICTq1mjN3Ntdrn0KbMQI30fRjx5Gd4oWwjbuChE3dvNj3d2fjUxarMXzaMEbajWNNGt9j5rLQ9m4Zrqdz7QALnKTefaaV09+UejLZuTCrqHCARje/difd8iwP5WweSz6zXusdYUqVyMVH7TWEdvXIJNqv8Z9zbAIiL0ABZM3vSkjXemC0KEsY/MIYSNyxdcgtwYjNljU8SE2FEdoGTPKUsIUfCfr/K4PobMEjaRnUvdpORwiY/RF84SPTG7dmbk2uYok4oBgARM7UELTdjXDDU+lYReJtdXmDdowQuLs6fkFsGgNLjkFnTxO5lB7MxeH6/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NZPgxJJ0zMuZrzMyjoQsDTd66g9dkfB8y8E7ne2rXk=;
 b=MlRXzhthHavD7HRzZbq3o899TDIsAVp12izAm2vjNp5hkhJ2UL9B5SO7FlW4JeH1KhezrfGzFKIOthGpYy7s0bsWKXuNyBIyjddPo3txnzT931EHbDYvOlYCjrSRHRJy9wRjmSmLq+W79Syb3QuB1g+bX3tJq9Q5pMD/Qs7YbiwgXT2DlHABChqNdeH55C1KI1D4cPKlCZWqany4qOe3CWmwCN2oVPCytMkEyvkKsZsjFisYikDgdey1Rcrl052NA3xi+gkyYIaT4cuMMnvTp2BtP6JE+ZJWxKjVoHw4AbAoidTvPUY2AnuB8wX8brZHrPWaq2sSjbNzCo/RwaeGOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.196) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=mail.sony.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=sony.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NZPgxJJ0zMuZrzMyjoQsDTd66g9dkfB8y8E7ne2rXk=;
 b=sUvW3FQyV4QLJZiM8QvuhO98qWQMeURnFpRSAMHcn3IYZmMkZSV7oaLf3yk1Y0ulrrdsgan6OfGfTE1aLkfC5GWpZyois16rRjvRXyl2o22D/bT3cZHPWa+gob+U1nO8LYf1AkLh7xqNQ+qVTwNO80jEw7PiW6L+YZ0FMHim5yo=
Received: from SA0PR12CA0001.namprd12.prod.outlook.com (2603:10b6:806:6f::6)
 by CH2PR13MB4458.namprd13.prod.outlook.com (2603:10b6:610:6c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 10:20:34 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:6f:cafe::d1) by SA0PR12CA0001.outlook.office365.com
 (2603:10b6:806:6f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Wed, 17 Jan 2024 10:20:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.196)
 smtp.mailfrom=mail.sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of mail.sony.com does not
 designate 121.100.38.196 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.196;
 helo=gepdcl07.sg.gdce.sony.com.sg;
Received: from gepdcl07.sg.gdce.sony.com.sg (121.100.38.196) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 10:20:33 +0000
Received: from gepdcl02.s.gdce.sony.com.sg (SGGDCSE1NS07.sony.com.sg [146.215.123.196])
	by gepdcl07.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 40HAKFSa007071
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 17 Jan 2024 18:20:15 +0800
Received: from mail.sony.com ([43.88.80.246])
	by gepdcl02.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 40HAEv8O028952;
	Wed, 17 Jan 2024 18:14:57 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id 9768920C0300; Wed, 17 Jan 2024 15:43:16 +0530 (IST)
From: Sreenath Vijayan <sreenath.vijayan@sony.com>
To: john.ogness@linutronix.de, corbet@lwn.net, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, rdunlap@infradead.org, pmladek@suse.com
Cc: rostedt@goodmis.org, senozhatsky@chromium.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        taichi.shimoyashiki@sony.com, daniel.palmer@sony.com,
        anandakumar.balasubramaniam@sony.com, sreenath.vijayan@sony.com
Subject: [PATCH v3 0/2] Add support to dump printk buffer to console via sysrq
Date: Wed, 17 Jan 2024 15:42:18 +0530
Message-ID: <cover.1705331453.git.sreenath.vijayan@sony.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|CH2PR13MB4458:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 215908f2-2468-4479-7eb6-08dc1745f10c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LHKX8ce1yPfvGhnLQtTH1ptrj+z1EU3P4yjt5eg+zyfdtaRXEbZHzDoellX2XiJP6N4FGL5NpzVpwZMxa0NZ/Z8rjUzwF5T3OEofzw2u2+SbcI+2ziWvIW0aqEANXeGdwzcyG6Tt1aTyQiIOe8VsV17oELTQTPTM+1DtlF4Ogxy0BhTTeEUF+GbqdOsxMw6hnyuKyNbTJ0j+FOkvAOtW3ghx+XSF3Y2v0pTpTk/q0m8bF5Qd1pIOr7Ha305gmBOP2lvssuZ4Z0C9Yp7SyciHMbYCTxD+klVkIMrotkeZPstZlaCPEdi2FQZhD4rLVCA9Y9tbqaU2OjwJiVD+Q6Xby1CWeb+oZjWptDwg0J0g2anyCJv8OgV1d451TPLNX3FDqhv2mWDD52nn42vAOUVlyJj2rfQbZgs8VLnXqrZDhkvHraUoJA0gadih941DFChlLTaRbwRNARmoVQkrbXMlSp84zcZcqj5c4jroEMKaycCn5zNIrvHZL3Xb/v8WMHbKowQmHPPQNgTNQqF9+r2ngUncu7/VAtGZ52JEwJ4wcNHUPqmW8hvXxMJjJH9yMru5fyqMJLop2sE2JlncCqbOYRjHqjfAefWxxzvH3zzBYQsfi0VrsO9sC1X70yLHv8h/P/cLNTaZXSRiD5lRZd5mSY9nwGmjgzg0eJcbjK0GqwTJj09zheanvTGLMwpnDRddzYAtxdi757eGpVO533mYIRH8i3RisfyAb2qXt3RK3hfJqODqYK76lgKal0rFPw2L3EfYWVMooN4pmmBvHvb9zA==
X-Forefront-Antispam-Report:
	CIP:121.100.38.196;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl07.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230173577357003)(230922051799003)(230273577357003)(1800799012)(64100799003)(451199024)(82310400011)(40470700004)(46966006)(35950700001)(81166007)(82960400001)(356005)(41300700001)(47076005)(40480700001)(40460700003)(36756003)(8676002)(450100002)(316002)(42186006)(8936002)(70206006)(70586007)(26005)(107886003)(4326008)(82740400003)(83170400001)(498600001)(966005)(5660300002)(44832011)(2616005)(336012)(6266002)(426003)(83380400001)(2906002);DIR:OUT;SFP:1102;
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 10:20:33.3296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 215908f2-2468-4479-7eb6-08dc1745f10c
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.196];Helo=[gepdcl07.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4458

Hi,

This patch series does two things:

1) Add function to dump the printk buffer messages directly to
consoles. To do this properly, access to printk private items
like PRINTK_MESSAGE_MAX is required. So, the function is
implemented in printk.c as suggested by John Ogness. This
function may sleep as it needs console related locks.

2) Add code in sysrq.c to call the above mentioned function
when sysrq+D is pressed. As the above function may sleep,
it cannot be called from interrupt context. A work is queued
in the system unbound workqueue to call the function when
the key is pressed.

Link to previous discussion:
- https://lore.kernel.org/linux-serial/20231221133953.1507021-1-sreenath.vijayan@sony.com/

Changelog:
V2 -> V3:
- split the implementation into two commits
- added function in printk.c to dump printk buffer to consoles
- added Suggested-by tag
- removed code to dump printk buffer from sysrq.c and called
  new function

V1 -> V2:
- modified kernel ring buffer to printk ring buffer
- allocated buf dynamically to prevent stack frame size warnings
- used buf of size 2048 to match PRINTK_MESSAGE_MAX and added comment

-- Sreenath

Sreenath Vijayan (2):
  printk: Add function to dump printk buffer directly to consoles
  tty/sysrq: Dump printk ring buffer messages via sysrq

 Documentation/admin-guide/sysrq.rst |  2 ++
 drivers/tty/sysrq.c                 | 20 ++++++++++++++++-
 include/linux/printk.h              |  4 ++++
 kernel/printk/printk.c              | 33 +++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+), 1 deletion(-)

-- 
2.43.0


