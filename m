Return-Path: <linux-kernel+bounces-22089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A21B8298FC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE8628782A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B19487BF;
	Wed, 10 Jan 2024 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jPcYROyM"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19AF48799;
	Wed, 10 Jan 2024 11:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfnBEcCW0cE2Lr/3NdRIu/jHTnxB9iGT+CJTu9iiUIT4QP7fiQmiV3E6XhhBoeIJQcjb9rNQlhVTmS5yi9iePam1al9px91cap9ma5Hyq42QeguFJHJ56Uk7YyrVxwNDIe3MLdtPgPLX6kt71hSa78GqFhQLv6u7fBx3PRYqA0m1aiMpktd9MseYEpVgymvs8sa2kZDvZ9WIrBfZtXJW3t9IHLskXBqnzkd5jqTEE8q7LrbbcHKP0gYa0oJWpQVi3uZ2yabE2q6VZXEBOBE4h/8jUZFY6/+im3Eo4q1lJxjZWnfOYEKOmrhrSeIHlco7l/WGbxuDEF8LK4d9vAKYLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iG00rFkrp4XVcLDSfHHaNLmmoNhFzMJPg4tqE6Nr/SY=;
 b=hTCV3aLzh+U64ZwkXQcGNA/UiLGYIkv8HW0rsMTobD8vmDOK34VzEr6Vr+Pne7mHG/xNDVh/1uZraRY3fuc4NAX6XTatbmPcyailxsQnBK9Fdo/7t4At0TYkR6x/6Vj7evA+lkPFmMfAsnzV73e9Q63Lw+DsVznLsyaMwXu0vDRWSz8m7n/samsei9XuMjJ4mm4HIEsvi+3+kYRk4Aujx26uXo8lY7d1HuEg3MAP5X/mK/JP3LhKuNC+xsgA5u/URHgR0LGBUd/XLyw87g7UxWklRNsUX/vWcLKBE2gqB1epd/ZQuFs3U3ttvI7H6cFYWhUQynJLviw3+m7/jo0c/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=canonical.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iG00rFkrp4XVcLDSfHHaNLmmoNhFzMJPg4tqE6Nr/SY=;
 b=jPcYROyM5jTE0Ev2/0Py96L2Zh/r3EGZ8DF3REsAZEDwB87I8amJylLo/dO10oKIdBEIpM++9zUiT0DHGV9TobdCkY0obkVwI4eVHGzS1uVGbXHSn+za73ikmQEn/VTwxLi7KTMgb2DnIu7EM8bovvxF6pEZvmMyu8sK8Xk0m2k=
Received: from CYXPR03CA0041.namprd03.prod.outlook.com (2603:10b6:930:d2::12)
 by CO6PR12MB5491.namprd12.prod.outlook.com (2603:10b6:303:13b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Wed, 10 Jan
 2024 11:24:49 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:d2:cafe::2) by CYXPR03CA0041.outlook.office365.com
 (2603:10b6:930:d2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 11:24:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Wed, 10 Jan 2024 11:24:48 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 05:24:43 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <john.johansen@canonical.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>
CC: <linux-security-module@vger.kernel.org>, <apparmor@lists.ubuntu.com>,
	<linux-kernel@vger.kernel.org>, <gautham.shenoy@amd.com>,
	<Santosh.Shukla@amd.com>, <Ananth.Narayan@amd.com>,
	<raghavendra.kodsarathimmappa@amd.com>, <paulmck@kernel.org>,
	<boqun.feng@gmail.com>, <vinicius.gomes@intel.com>, <mjguzik@gmail.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [RFC 9/9] apparmor: Switch unconfined and in tree labels to managed ref mode
Date: Wed, 10 Jan 2024 16:48:56 +0530
Message-ID: <20240110111856.87370-9-Neeraj.Upadhyay@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f184a2d6-7892-4e43-a0cd-cab638c3d5c2@amd.com>
References: <f184a2d6-7892-4e43-a0cd-cab638c3d5c2@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|CO6PR12MB5491:EE_
X-MS-Office365-Filtering-Correlation-Id: fecc1373-b57e-461b-f40c-08dc11cec1ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5zbHXc+tv80xpbAOC64vONBJ710EUW5JEZAjpDTqsbtvuiJKvJNgoU/6N6JPKdoAOC5l6ZdsgiB8jZ/obK/dnPFjN+1+tslz1RK2nFKOO6cS3X7fZGNZkY9hmmPkX8/w80xEXXilhG36njcngsnNQDK35Bk3AnMFj84/BvCK8kL7JRpoSOxQPhHSQSjgCfkOIuIVRMzlfOOO7N7dOExEmA+2VyEtaHPlpF4XOpsM0of+fhoGQN/UtnKob3TudpKehFUKc2E/FjVPr+7wyAwCrfphu4LDWG7c8S4U7xSGIBsT+izBUl3GdHB9KA8E8YEgsx49XL+xp6j5TNd0JXdQ1SveJJIGuQjVlQhidst8u0gQJdL0+NXngyXg14pHdz/4WhtMsjW7KO9SK50zX0c9w1m0kkaQxebROVZ/+YwezTW68rWqfw/s2Qt4PAhxiH8xVOTZfbxk+J+S5UqXOb+rkmocqZbYAIxxEJo+t0CC/ggOPSEo6XACeUN/6DvrNdwKzfPcY1It8psYWMKNbaYfh46SRIAXxSi8/YBWJyKg1dqElAZNZi3BEaezhxkEtX5pxFl8/pmA2w96+mlfT9KIw1bT1Zm/kXr8JfxXyN2Ua9cBfAgUx4qrjV4Mt5Yk8wvJaEQXi0z4XoD/44TPn0mz+sHQf8k0mTUm5AqLgAIJyiATAltO7AK2r4giCz3UVDUtzmuGxCKlYyzKGIiUhnGFIuXIxeMzqQ5730ZBMQPQbvyllgjYt/o8jJagLaiJcjtPM/sJfAqOyV/K4OS2WNeTvA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(64100799003)(1800799012)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(2616005)(1076003)(26005)(336012)(7696005)(478600001)(16526019)(426003)(6666004)(36860700001)(83380400001)(47076005)(5660300002)(2906002)(7416002)(41300700001)(4326008)(70586007)(70206006)(110136005)(8676002)(8936002)(54906003)(316002)(81166007)(356005)(86362001)(82740400003)(36756003)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 11:24:48.9037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fecc1373-b57e-461b-f40c-08dc11cec1ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5491

Switch unconfined and in-tree labels to percpu managed
mode of percpu rcuref. This helps avoid memory contention
in ref get and put operations.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 security/apparmor/label.c     | 1 +
 security/apparmor/policy_ns.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index f28dec1c3e70..57fcd5b3e48a 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -710,6 +710,7 @@ static struct aa_label *__label_insert(struct aa_labelset *ls,
 	rb_link_node(&label->node, parent, new);
 	rb_insert_color(&label->node, &ls->root);
 	label->flags |= FLAG_IN_TREE;
+	percpu_rcuref_manage(&label->count);
 
 	return aa_get_label(label);
 }
diff --git a/security/apparmor/policy_ns.c b/security/apparmor/policy_ns.c
index 1f02cfe1d974..ff261b119c53 100644
--- a/security/apparmor/policy_ns.c
+++ b/security/apparmor/policy_ns.c
@@ -124,6 +124,7 @@ static struct aa_ns *alloc_ns(const char *prefix, const char *name)
 		goto fail_unconfined;
 	/* ns and ns->unconfined share ns->unconfined refcount */
 	ns->unconfined->ns = ns;
+	percpu_rcuref_manage(&ns->unconfined->label.count);
 
 	atomic_set(&ns->uniq_null, 0);
 
@@ -377,6 +378,7 @@ int __init aa_alloc_root_ns(void)
 	}
 	kernel_t = &kernel_p->label;
 	root_ns->unconfined->ns = aa_get_ns(root_ns);
+	percpu_rcuref_manage(&root_ns->unconfined->label.count);
 
 	return 0;
 }
-- 
2.34.1


