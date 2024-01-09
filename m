Return-Path: <linux-kernel+bounces-21083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04600828981
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059A91C2454F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1843A1A4;
	Tue,  9 Jan 2024 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yNeN0MjP"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9D938DC1;
	Tue,  9 Jan 2024 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/WOMWZsT54zcqNLDefDku+tk38ByP2zKWnOd0q4yRIX8mLet/pYXMw78X2J8sY4XU/CyEYTNJGWiIX+QGspWHYjW/cDMz/520YY+0xMMBvilYkIM2AdGM2Yz0PJeEysNi2Ml09GjJo4e5JbuW3Y/Rf8g0ctz5uYuYvEoiXa5CBMyhEikvI2yz4q8sF3B0EV0JpYnwZsZHKhSSQuu6zMDuyVAfRVMHWa8EtyURSK75CZ7nFtmlVRTTc9meYiJTeOTJ6oXbxrJv6RUwXHIhm2bXrVSLNfUAxce2vZbt9VUNbD5sAgQ83FVkR3khs0OqQpUrujbS6uWfPY0lbLfa3cKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bEOW2eYVCs06Ew/v0DfxoWVsZHrbZ7fY1D5fCUe0g0=;
 b=iSlZMh7MTy03Awdc8Vuvj0AzbvCw5hbNGyHwuO0GdlA12IWqQpKgctYvHMgsb+5zccK5pyekQHHhhsq9xmk2vqxPozTXHEvxZvyFirQ/lpfPvL3XaNq/4NHAxXaXnJrqJ1suSA4tD9HqeS4zdxLcdIEAQI54MTugu8laS6lQdOOVTHzUNBPh/v9onzXKmJxP3huUYZAzyBVS26aFR8n9Kuwi78qo42IRjs83k4FDyc7PGcqpIkjX3ndX7Y3O61OgN/Hxc0OiXQfaFi2TyNoh53I4lQBsoVfg0Py9Nnx0E6GFYcASGXAkysPSj+DCyeeFaIjjfWP8lz5v+8AC/cFdEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bEOW2eYVCs06Ew/v0DfxoWVsZHrbZ7fY1D5fCUe0g0=;
 b=yNeN0MjPmOGiRTw2htDOLrDSLio9wWcJEB5ha19zX1XfFwFOh67qjWjKWZC/Ci52a1A1q89uXRi/htgHeS+nKEEsqmrKJUnmko9w3UngBPG5qfKJv4loqVeILumGldXcTLUHnqYMhrb/DEhMjWo4r3LQ8B5KfmWcwsf273i2HD4=
Received: from SJ0PR05CA0088.namprd05.prod.outlook.com (2603:10b6:a03:332::33)
 by SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 15:56:45 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:a03:332:cafe::92) by SJ0PR05CA0088.outlook.office365.com
 (2603:10b6:a03:332::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.14 via Frontend
 Transport; Tue, 9 Jan 2024 15:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.4 via Frontend Transport; Tue, 9 Jan 2024 15:56:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 9 Jan
 2024 09:56:44 -0600
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 9 Jan 2024 09:56:43 -0600
From: Carlos Bilbao <carlos.bilbao@amd.com>
To: <corbet@lwn.net>, <rdunlap@infradead.org>, <vegard.nossum@oracle.com>
CC: <bilbao@vt.edu>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH v2 0/2] docs: Include simplified link titles in main index
Date: Tue, 9 Jan 2024 09:56:41 -0600
Message-ID: <20240109155643.3489369-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|SJ1PR12MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: bf5ad3dc-33b1-40c9-8ce2-08dc112b9468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Lk7he11pglC/pDUUolYmZjhIYI0aSZO7JjWk6dClGmXbitvXU5tCWsVIlwtKTymleCz0G3qBIE59UxKYc1UO4fogWV+typ+IHvNxJIkaduIUchzhMbbAKMz4cbQtykOnGfpcfi2GnbbvheRZL+cXCQ8O38PVAbdV7kWn/o74oX8EjAPq5BdVjmpf3MBUImsMiOn+BagG0ypWx5B68YSWket4+UzXLExe4nOIrCfoIOieqwoAkuTtxSE57z9SgOz90ypJExH24AMwzvyG8LzrLnZKUVnun+3t4oIqCDwqSROLAXPXQzk/cxOi5WXPr9sv73jnbErXwOuhirY8ExDMHeORjT7GVOvz3zlLLu46Uu4nlDzc2+5WfqG3uAOXk7k42gnNToL3wApZznVpWZBqHT7gdFnuarnrJg80Orq+0+4wItHFY6mbso39hVBdPUTRgoPOfl3VoBg2Ti8iEhpBgYrCf6n8AtrhcBg9WpzroXLvE8719DLzfJalpkDK3KiNtzMVXmjlHluyVmpEmRuMkEwiqfDG8ZocirD95aPIhyUkQxXZcNv/1ry7Jryt0yM4lbnaAe1jpdyup/WDtQ3+tRvh9N2Q2Mb9qLlPLinZ5GDhmAV7b6qKpOMlsHDRmSVXHHX32Qf7ZYrd0SbmLY36ezhXtMBHSRFQA8W9GH0IvBts7dr8GGpZrj+7KL7dvOIzgarYmfq89Rvi4KcUOjBFZc6B8jEi9dYJdfMzDKKvT+Y=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(426003)(336012)(83380400001)(110136005)(356005)(36860700001)(82740400003)(2906002)(47076005)(86362001)(41300700001)(36756003)(54906003)(81166007)(7696005)(316002)(70586007)(2616005)(966005)(478600001)(8936002)(5660300002)(70206006)(4326008)(26005)(1076003)(44832011)(8676002)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 15:56:44.9507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5ad3dc-33b1-40c9-8ce2-08dc112b9468
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169

The general consensus is that the documentation's website main entry point
and its sidebar leave room for improvement. Something we can easily fix is
that there's too much duplicated text.

To that point, consider the titles "The Linux kernel user's and
administrator's guide" and "The Linux kernel user-space API guide." We get
it, it's the Linux kernel. It's assumed that everything listed pertains to
the Linux kernel, given the overarching title, "The Linux Kernel
documentation." Constant repetition of "Linux" and "kernel" (45 times
each), "documentation" (21 times), and "guide" (18 times) are excessive and
affect UX.

I propose simplifying without altering actual document titles, the text
linking to these documents on the main page ("link titles"). For example,
"The Linux kernel user's and administrator's guide" could become "User's
and Administrator's Guide," and "A guide to the Kernel Development Process"
could be "Development Process". This is what my patch does.

Also, I send a patch fixing the formatting of the title of
admin-guide/index.rst (The Linux kernel user's and administrator's guide);
a detail I noticed because the link title would not work otherwise.

Thanks,
Carlos

Carlos Bilbao (2):
    docs: Correct formatting of title in admin-guide/index.rst
    docs: Include simplified link titles in main index

---

v1 Link: https://lore.kernel.org/lkml/58e78693-82d1-451d-a546-51fb64ef6eb5@vt.edu/T/

Changes since v1:

- Apply feedback:
  Driver implementation API -> Driver APIs
  Testing -> Testing guide
  Hacking -> Hacking guides
  User-space tools -> Userspace tools
  User-space API -> Userspace APIs
  CPU Architectures -> CPU architectures

- Include patch fixing the title of The Linux kernel user's and
  administrator's guide.

- Minor changes: Change "main page's index" for "main index" in commit
  subject. Also use my work email to sign the commits.

---
Documentation/admin-guide/index.rst |  1 +
Documentation/index.rst             | 52 ++++++++++++++---------------
2 files changed, 27 insertions(+), 26 deletions(-)


