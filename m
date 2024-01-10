Return-Path: <linux-kernel+bounces-22069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA958298BB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D772A1F2998B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0634D47A72;
	Wed, 10 Jan 2024 11:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zOL0+dXM"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E6E46BA6;
	Wed, 10 Jan 2024 11:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDbyLqhfeRlUe6XVMn/NkOR6gBX0701nVfEP2gCrD+PEJWFAwICwJ4UOzofOY8hLthSfbjwZovDmz4olk3sTtNKXE4VG0sG1WofYaRPr3dyrtLN5xKi1AKTdC7/Toioo4cYSLYJq8Q7S6aj0lIlY4NahQ4O/h1Z5pwOypgAfHKExGMXGYmdWMc7Si8JSSn8IkGgxNPqZYLTcoccHAJgIv96BJqU8XZIvJZgw8v1r9ZJdXEGURsbydcVb3j8jpI5Rjc9BfN1tV07xT2Eyjs0JBxk5kbZO5zI/OEhDtoaL67CrSJ7V/HFZHc/xFGEK144QRhm0qV1Vvin3UaWWr7jmxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7YHBUwUNfex96uK8+Htccp+8JTFV7ES+6ywHgrEbLU=;
 b=XNyTdpZNBWNEP6ntWudjMq3A/5Ua9gJEWF65dn9FJccj59YmpEiSefgIo4WT3lM9aM31C13cGYXHpLYk2Zh0xyY/txz46Td/TMpb5RLUByGozXesBTlpqnS7bx2BKs6EXZqcEsIfZS8srGG7q9WVXsKhwKb6locW0BSCP0C5ss65EI9g1qnxBqElVkKa+dZSkUf644M1QCF5kWDRBXSjwOUYSGBluNH/kqBWLkgbpYxI1jqG+jwO82T0TkW9Vsuu2IHVrFMMivTzRgnWEUg7NGaDXeSELt5mxNMGDGhlzNEpTVMGW3WWIuBXzlLX/PPwnRxRUUv6d+Z97fuCYAKdzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=canonical.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7YHBUwUNfex96uK8+Htccp+8JTFV7ES+6ywHgrEbLU=;
 b=zOL0+dXMa9JQOTo89SOHJUGMg8qETbaMIxkIVsv8H5B2NgjkN/jbbly9Ae6KKlWJ5x3ErZeWOWYldlJKtkqCEIATvOZUTEZFg2xoZuLGQ3FByzUHTbdJbipVOlcPAQMyaf73q/9uG2V+rUuQwUjgGPToaFoMYcnZm/4LEn8BWwA=
Received: from CH0P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::24)
 by SJ0PR12MB6879.namprd12.prod.outlook.com (2603:10b6:a03:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 11:18:59 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::9b) by CH0P223CA0006.outlook.office365.com
 (2603:10b6:610:116::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 11:18:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 11:18:58 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 05:18:53 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <john.johansen@canonical.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>
CC: <linux-security-module@vger.kernel.org>, <apparmor@lists.ubuntu.com>,
	<linux-kernel@vger.kernel.org>, <gautham.shenoy@amd.com>,
	<Santosh.Shukla@amd.com>, <Ananth.Narayan@amd.com>,
	<raghavendra.kodsarathimmappa@amd.com>, <paulmck@kernel.org>,
	<boqun.feng@gmail.com>, <vinicius.gomes@intel.com>, <mjguzik@gmail.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [RFC 1/9] doc: Add document for apparmor refcount management
Date: Wed, 10 Jan 2024 16:48:48 +0530
Message-ID: <20240110111856.87370-1-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|SJ0PR12MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c29807f-f19b-45f3-2362-08dc11cdf0e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Pt9XogawPvuDSR1f8royO+72RqIzILzn6oll2yXTs7GukYn6PNH4NW9x9DlzjRC8i8UJQBWQpdUTe+TfJEhfsJIRAmEmMwfiLBSTOhw+giR4h6VMGMUO0KgRyqFBR/09XiyUnsKeGejWdcsfFBldzMhjuVYL872HXhA+DvSGvDfJTywguxEchemd6sTKvucVTYk1T+H57Sr/cO7xuWtdmPtWXiLcNVVOaAOiqNGYU8HvI3WPmlaLnpqkOsAy0ovmluvb9H9ae3NvRRtyfpFCBb/zRpOzoMoEMe26zrmktgUn2xiYWfRdXNnfYWGczJmJZP4k2arYQA42GsnKBWYj+wnaznvBPpLajVNY3gsQBsKVlL2ysO3r9Q238VcnKtRW7QHOhremE1AiOvFJlY8EVPP59PIDj3KLixepqEaleszeJ+NpGB9wJhq7IQHBfaNXWOHgP/rR/CvhK/IYVHcKzs6TF30CBtwLz0osZvoi6D41wPdfkGl7aCYS/ohgzo5f5ItIN7kpOyjRPXIkZmb46Uxzj8J/awKhcNNskFVME4q3c9rf3WcG8lQ+8j1SwPBPtTd4bNzpHVTJ7pkyDpeE2YUjhtBXmFVf/KnuGXA0daRStKkoFAa65MNZxg5uvYEa2NU3FloaFHpmlcRYWwOHzSrHlqsfVQFOpDdsJlvFhafHI+a1x2z7F5J6Ti4pJvPSjRDDSEw+5M2rfsDZ6b99MrrqNrjDoI6ni7D6Yz8HV3we0uGaG+jQuQwWB3tPqA1UnO5P5Mjf7+2bcKvozk+XtQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(64100799003)(82310400011)(451199024)(1800799012)(186009)(36840700001)(40470700004)(46966006)(30864003)(7416002)(2906002)(5660300002)(41300700001)(83380400001)(40480700001)(2616005)(40460700003)(26005)(1076003)(426003)(336012)(16526019)(47076005)(478600001)(966005)(7696005)(6666004)(81166007)(356005)(86362001)(36860700001)(82740400003)(36756003)(70206006)(110136005)(8936002)(8676002)(70586007)(54906003)(316002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 11:18:58.6855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c29807f-f19b-45f3-2362-08dc11cdf0e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6879

Add a document to describe refcount management of AppArmor
kernel objects.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 .../admin-guide/LSM/ApparmorRefcount.rst      | 351 ++++++++++++++++++
 Documentation/admin-guide/LSM/index.rst       |   1 +
 2 files changed, 352 insertions(+)
 create mode 100644 Documentation/admin-guide/LSM/ApparmorRefcount.rst

diff --git a/Documentation/admin-guide/LSM/ApparmorRefcount.rst b/Documentation/admin-guide/LSM/ApparmorRefcount.rst
new file mode 100644
index 000000000000..8132f1b661bb
--- /dev/null
+++ b/Documentation/admin-guide/LSM/ApparmorRefcount.rst
@@ -0,0 +1,351 @@
+============================
+AppArmor Refcount Management
+============================
+
+Introduction
+============
+
+AppArmor task confinement is based on task profiles. Task profiles
+specify the access rules - list of files which the task is allowed
+to open/read/write, socket bind, mount, signal, ptrace and other
+capabilities of the task.
+
+A sample raw task profile (typically present in /etc/apparmor.d/)
+would look like this:
+
+::
+
+    1. profile test_app /usr/bin/test_app {
+    2.    @{sys}/devices/**                 r,
+    3.    /var/log/testapp/access.log       w,
+    4.    /var/log/testapp/error.log        w,
+    5.
+    6.    /lib/ld-*.so*                     mrix,
+    7.
+    8.    ^hat {
+    9.        /dev/pts/*     rw,
+    10.    }
+    11.
+    12.    change_profile -> restricted_access_profile,
+    13.
+    14.    /usr/*bash cx -> local_profile,
+    15.
+    16.    profile local_profile {
+    17.        ...
+    18.    }
+    19. }
+
+
+Above example shows a sample profile. A quick description of
+each line is given below:
+
+1  Defines a profile with name ``test_app`` and attachment specification
+   ``/usr/bin/test_app``. The attachment specification is used for
+   associating the application with a profile, during launch.
+
+2,3, 4
+   Specifies read and write access to various paths.
+
+6  Read access for the so and inherit profile transition specification.
+
+8  Hat profile. Used for running a portion of the program with different
+   permissions, compared to the other portions of the program. For example,
+   to run unauthenticated traffic and authenticated traffic in separate
+   profiles in OpenSSH; running user supplied CGI scripts in separate
+   profile in Apache.
+
+12 Change profile rules, to switch child process to a profile, different
+   from the parent process, on exec.
+
+14 Profile transition for processes started from the current procees. For
+   example, transition to a different profile for ``ls``, which is invoked
+   from a shell program.
+
+
+Objects and their Refcount Management
+=====================================
+
+There are various object resources within AppArmor
+
+- Namespaces
+
+  There is a root namespace associated for apparmorfs. This is the default
+  namespace, to which all profiles are associated with.
+
+  Profiles can be associated with a different namespaces (for chroot,
+  containers env).
+
+  Namespaces are represented using ``struct aa_ns``. Some of the relevant
+  fields are::
+
+      struct aa_policy base
+      struct aa_profile *unconfined
+      struct list_head sub_ns
+      struct aa_ns *parent
+
+  ``struct aa_policy`` contains a list of profiles associated with this ns.
+
+  ``unconfined`` profile manages refcount for this namespace. It is also
+  used as the default profile for tasks in this namespace and a proxy label,
+  when profiles are removed.
+
+  ``sub_ns`` is the list of child namespaces.
+
+  ``parent`` Parent namespace, for this namespace.
+
+  A parent and its child sub namespaces keep reference to each other::
+
+    +---------------------+
+    |                     |
+    |      root_ns        |
+    |                     |
+    +---------------------+
+            ^  /  \    ^
+           /  /    \    \
+   parent /  /      \    \ parent
+         /  / sub_ns \    \
+        /  /          \    \
+       /  /            \    \
+      /  v              v    \
+   +-----------+    +-----------+
+   |           |    |           |
+   |    ns1    |    |    ns2    |
+   |           |    |           |
+   +-----------+    +-----------+
+
+  Here, ``root_ns`` is the root apparmor namespace. It maintains a
+  reference to all child namespace which are present in ``->sub_ns``.
+  The child namespaces ``ns1``, ``ns2`` keep a reference to their
+  ``parent``, which is the ``root_ns``.
+
+
+- Profiles
+
+  Profiles are represented as ``struct aa_profile``
+
+  Some of the fields of interest are::
+
+      struct aa_policy base
+      struct aa_profile __rcu *parent
+      struct aa_ns *ns
+      struct aa_loaddata *rawdata
+      struct aa_label label
+
+   ``base`` - Maintains the list of child subprofiles - hats
+
+   ``parent`` - If subprofile, pointer to the parent profile
+
+   ``ns`` - Parent namespace
+
+   ``rawdata`` - Used for matching profile data, for profile updates
+
+   ``label`` - Refcount object
+
+  A profile keeps a reference to the namespace it is associated with.
+  In addition, there is a reference kept for all profiles in
+  ``base.profiles`` of a namespace::
+
+      +-----------------------------+
+      |                             |
+      |      root_ns                |
+      |                             |
+      +-----------------------------+
+                ^  /       ^   |
+               /  /     ns |   |
+       parent /  /         |   |
+             /  / sub_ns   |   |base.profiles
+            /  /           |   |
+           /  /            |   |
+          /  v             |   v
+       +-----------+    +-----------+
+       |           |    |           |
+       |    ns1    |    |     A     |
+       |           |    |           |
+       +-----------+    +-----------+
+      base     |    ^
+      .profiles|    | parent
+               v    |
+       +-----------+
+       |           |
+       |    P      |
+       |           |
+       +-----------+
+
+  For subprofiles, a refcount is kept for the ``->parent`` profile.
+  For each child in ``->base.profiles``, a refcount is kept::
+
+            +--------------+
+            |              |
+            |    root_ns   |
+            |              |
+            +-------^------+
+       base.    |   |
+       profiles v   |ns
+             +---------------+
+             |               |
+            ^|      A        |^
+   parent  / |               | \parent
+          /  +---------------+  \
+         /    /  base.profiles\  \
+        /    /                 v  \
+     +------v-+               +----\---+
+     |        |               |        |
+     |  B     |               |    C   |
+     |        |               |        |
+     +--------+               +--------+
+
+
+- Labels
+
+  Label manages refcount for the ``aa_profile`` objects. It is
+  represented as ``struct aa_label``. Some of the fields are::
+
+      struct kref count
+      struct aa_proxy *proxy
+      long flags
+      int size
+      struct aa_profile *vec[]
+
+  ``count`` - Refcounting for the enclosing object.
+  ``proxy`` - Redirection of stale profiles
+  ``flags`` - state (STALE), type (NS, PROFILE)
+  ``vec``   - if ``size`` > 1, for compound labels (for stacked profiles)
+
+
+  For compound/stack labels, there is a reference kept, for all
+  the stack profiles::
+
+   +--------+     +---------+      +-------+
+   |   A    |     |   B     |      |  C    |
+   |        |     |         |      |       |
+   +-----^--+     +---------+      +-------+
+      ^  \            ^           ^
+       \  \           |           |
+        \  \  +---------------+   |
+         \  \ |    A//&:ns1:B |   |
+          \  \|               |   |
+           \  +---------------+   |
+            \                     |
+             \                    |
+              \ +-------------------+
+               \|A//&:ns1:B//&:ns2:C|
+                |                   |
+                +-------------------+
+
+- Proxy
+
+  A proxy is associated with a label, and is used for redirecting
+  running tasks to new profile on profile change. Proxies are
+  represented as ``struct aa_proxy``::
+
+    struct aa_label __rcu *label
+
+  ``label`` - Redirect to the latest profile label.
+
+  While a label is not stale, its proxy points to the same label.
+  On profile updates, the proxy, the label is marked as stale,
+  and label is redirected to the new profile label::
+
+   +------------+          +-----------+
+   |            |          |           |
+   |   old      | -------->|    P1     |
+   |            | <--------|           |
+   +------------+          +-----------+
+
+
+   +------------+         +------------+
+   |            |         |            |
+   |    old     |-------->|    P1      |
+   |            |         |            |
+   +------------+         +--^---------+
+                             |  |
+   +------------+            |  |
+   |            |-----------/   |
+   |    new     |<-------------/
+   |            |
+   +------------+
+
+Lifecycle of the Apparmor Kernel Objects
+========================================
+
+#. Init
+
+  #. During AppArmor init, root ns (RNS:1) and its unconfined
+     profile are created (RNS:1). If initialization completes
+     successfully, the ``root_ns`` initial ref is never destroyed
+     (?).
+
+  #. Usespace init scripts load the current set of defined profiles
+     into kernel, typically through ``apparmor_parser`` command.
+
+     The loaded profiles have an initial refcount (P1:1 , P2:1).
+     A profile P1, which is in default namespace keeps a reference
+     to root ns (RNS:2). If a profile P2 is in a different namespace,
+     NS1, that namespace object is allocated (NS1:1) and the namespace
+     is added to ``sub_ns`` of ``root_ns`` (NS1:2). The child namespace
+     NS1 keeps a reference to parent ``root_ns`` (RNS:3). P2 keeps a
+     reference to NS1 (NS1:2). The root ns keeps a reference to P1 in
+     ``->profiles`` list (P1:2). NS1 keeps a reference to P2 in its
+     ``->profiles`` list (P2:2). In addition, label proxies keep
+     reference to P1 and P2 (P1:3, P2:3).
+
+#. Runtime
+
+  #. As part of the bprm cred updates (``apparmor_bprm_creds_for_exec()``),
+     the current task T1 is attached to a profile (P1), based on the best
+     attachment match rule. T1 keeps a refcount for P1, while the current
+     ``cred`` is active (P1:4).
+
+  #. If P1 is replaced with a new profile P3, P1 is removed from the root
+     ns profiles list (P1:3), proxy is redirected to P3 (P1:2), and the
+     initial label is released (P1:1) and P1's label is marked stale.
+
+  #. Any T1 accesses, which have a apparmor hook, would reference the
+     current task's cred label::
+
+         __begin_current_label_crit_section()
+             struct aa_label *label = cred_label(cred);
+
+             if (label_is_stale(label))
+                 label = aa_get_newest_label(label);
+
+             return label;
+
+         aa_get_newest_label(struct aa_label __rcu **l)
+             return aa_get_label_rcu(&l->proxy->label);
+
+         aa_get_label_rcu(struct aa_label __rcu **l)
+             rcu_read_lock();
+             do {
+                c = rcu_dereference(*l);
+             } while (c && !kref_get_unless_zero(&c->count));
+             rcu_read_unlock();
+
+  #. On task exit and cref freeing, the last reference for P1 is
+     released (P1:0).
+
+#. Release
+
+  Below is the set of release operations, based on the label's
+  parent object type.
+
+  #. If ns is not assigned (early init error exit), do not wait for
+     RCU grace period. Otherwise use ``call_rcu()``
+
+  #. If label is associated with a namespace (unconfined label)
+      #. Drop Parent ns reference.
+
+  #. If label is associated with a profile
+      #. Drop parent profile reference.
+      #. Drop ns reference.
+
+  #. Drop all vector profile references for stacked profiles.
+
+
+Links
+=====
+
+Userspace tool - https://gitlab.com/apparmor/apparmor
+    Profile syntax      - parser/apparmor.d.pod
+    Sample change hats  - changehat/
+    Other documentation - libraries/libapparmor/doc
diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admin-guide/LSM/index.rst
index a6ba95fbaa9f..c608db9e7107 100644
--- a/Documentation/admin-guide/LSM/index.rst
+++ b/Documentation/admin-guide/LSM/index.rst
@@ -41,6 +41,7 @@ subdirectories.
    :maxdepth: 1
 
    apparmor
+   ApparmorRefcount
    LoadPin
    SELinux
    Smack
-- 
2.34.1


