Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEE07DD37C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376266AbjJaQxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346925AbjJaQwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:52:19 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2090.outbound.protection.outlook.com [40.107.21.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BB3D51;
        Tue, 31 Oct 2023 09:49:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+u3BRrCf8XM0tL/DSELf5pTMJwL7GJ4/4yXipQrC9yb+6jtQO0HPRvA17ZlDjnTGM61PY0TTA6N6V/BvOViwKAqP8mnNZmwVsBj4HGptIhofBCEkH/FubGY+z4F/cFTdcb+LtDNGOFNJcxUQ2Abpnvi8JLBIaiTXR3osys7Wo6yAqCwqNDMVQ0Vcx4jRlDbVJy2uAtTT9k3CCfoCsS6NfOMy3QHh434TQ3HUVrT8IkNDj0zAXcxuAWmBPzwi5UcH1SYVHGmS9Eqt18S82gDF3Hr3epdh4DvS7Z+kb/5bpKYWzAmHe3P+qJBOH3U2DceiR9bz/OeL2kTLsNQ3+aElA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUH/PV7lf2dA/eXCHHs/LTQ+8FVXpAU8YrKqDiAofvo=;
 b=nt3ZRDTT1MOik916FkmG5BSnTyXDQ3EqMzGDNoz+BIgc2oe/xo4SvtOfJfimz+yVdgR5s3tVzYGMhZVz18ee2BOFccCIml+xphM7tvRlWJke5VK/7whh9qYhoLddfs31l38G82iXGSSxuddy5Bddz/1aZxSGbxagmYUe3t5F0Tn8TrFYS3v2gA1rxjSVLKnRQftIHh6nDIbDqzOUmKPEc+0bFnxezwfzYqXhE+LYom455N4ouz/+jaFkzEcKsle2WhCeX7ms0CWq9dBnpf48uy1YPMEgl+3J92ztBRxTWNTUOtHr1p/8lUHe8UnLMRHghYgvuSEZ0gjxjFFoylCoJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUH/PV7lf2dA/eXCHHs/LTQ+8FVXpAU8YrKqDiAofvo=;
 b=0ZMcffUnkM82D2Lh4EFCG85oJ975NQfUdMmaCpUkJQhSJ+IfInswDVO3/7jgFQJB6pfzf1U0VXr0tg8kd//L/C6r5Wh6hUNyhdLhyg+754UJXTx3dczIQsKLkrJ37e3mBq5vIF4OshKaHQoeTznftMHJBA+UOvyHQXBH+28z3Xo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR0302MB3486.eurprd03.prod.outlook.com
 (2603:10a6:803:1e::32) by AM9PR03MB7187.eurprd03.prod.outlook.com
 (2603:10a6:20b:26f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Tue, 31 Oct
 2023 16:49:47 +0000
Received: from VI1PR0302MB3486.eurprd03.prod.outlook.com
 ([fe80::59be:1f7c:f22b:baaa]) by VI1PR0302MB3486.eurprd03.prod.outlook.com
 ([fe80::59be:1f7c:f22b:baaa%4]) with mapi id 15.20.6907.032; Tue, 31 Oct 2023
 16:49:47 +0000
From:   Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Aleksandar Rikalo <arikalo@gmail.com>,
        Chao-ying Fu <cfu@wavecomp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH v3 06/11] irqchip: mips-gic: Multi-cluster support
Date:   Tue, 31 Oct 2023 17:49:22 +0100
Message-Id: <20231031164927.371663-7-aleksandar.rikalo@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231031164927.371663-1-aleksandar.rikalo@syrmia.com>
References: <20231031164927.371663-1-aleksandar.rikalo@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0065.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::18) To VI1PR0302MB3486.eurprd03.prod.outlook.com
 (2603:10a6:803:1e::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0302MB3486:EE_|AM9PR03MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: b830f2ca-5b7d-49b2-c235-08dbda31644d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sh0ZRkpuXadeDuaObdP2nJk76jOUHXI/gqF6auBuXdjfWxDIBthCOcwpJQIdYbxpvZZBvoJexJBAiX1hsD/U0LN/X8Gj/A5r9mDgEQp5+dxbU2pC52ACdORstJvnHTpcF1ER0tC2UXPkxYvyaAx39/woJxg6/WUbmZP74BA8iJVeSG7siRroReJrRyBVMvcsj6ulLriXHghVAnlp9RNcQOGYbj250L+JPz+mf6Fese7pvP8Cplxp4Nt7AAeNHdX7UiPimgN761zYPY2BTwV0H3DHgGad9RnZRuEPUN+gtRRoX3aw/OLSwyT9FMFvLAZUXZVtgghcR14GcZqyhhKRQ96CDV+GAz9lTfIcnEQh+yw/1cgX/l2jXoGvJsnEP0s8t/G55Yf0m9uWom38z2GaNCreZfrCeLTQATixIPMeVlyRaC566SQRiymLKWu4tqDbbBO0FUHvgypy5ySTttfZPAugrVsMuw840MvhMwJZpP8Ca8C5QMSS4IV9sBtWXr2fPSRbJ/YBDzA4goAz5ZYioWskeBea/QUMk7Qa5SUjiErwbp/2xBGYc0e4VqeuIi8GmKWMil+VUDvjzcVXOlARRuG6iy3yZO1TR3lg2khLea1HT1kN+FOd/doSszFK8QFsBR38WE5EkqgO6thhmr1w+VT0Do1LxCfDly9cj++DN2o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0302MB3486.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39840400004)(230273577357003)(230173577357003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(41300700001)(44832011)(316002)(54906003)(6916009)(66946007)(66556008)(66476007)(8936002)(30864003)(7416002)(478600001)(2906002)(4326008)(5660300002)(8676002)(6486002)(26005)(52116002)(6512007)(6506007)(2616005)(83380400001)(36756003)(1076003)(38350700005)(38100700002)(6666004)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1/qmUVBxeH5MvjgJJm2hv16h+RrHeVYYifCGe55M0GOlvhzQst7WYuXDcE3f?=
 =?us-ascii?Q?WiC19NFNP7K/jk7xPdtuUsS7ttQYtQZxQDjJny57voQtutmHGTVhgVkWYz0c?=
 =?us-ascii?Q?xRMEbgYWIrBtRL/4m8jQP6QLYRIs/AEgPFNoXlRz2UrV0F2AIYxmbjsEe/6T?=
 =?us-ascii?Q?xcHo0GZzGvnkwbahedFI28OtbW3mdk73zcuVFpasDeoP44N4RMAY8fpkzr48?=
 =?us-ascii?Q?Yd6vU9ReJF67ecaFyZWfI7IPMZAFB5kLdMvtfQzZzDoTrGWUaBITtznGKLpo?=
 =?us-ascii?Q?J/NKiXwOlKpgL0BgrqEnVXL1rcFSfvq1NSp6MRwtgOZg7DdbU19CJRjqxuRr?=
 =?us-ascii?Q?4qCaxSuDItHMsZamzPGQDuhP/SaOmc/i+GWrPeVfMKVDmNIo9BB/HxoQ8Iuu?=
 =?us-ascii?Q?h8O+ZeR/YLIvq6DuRsaimdkeLfBIGz06tvyJrh32u/9dhvDoSp/vzErQ7VfK?=
 =?us-ascii?Q?GFVcp+issePNe0zXrq2Z7OyXzWFANYN8uVcdHcwNUnlNXtZKrtzNo3mTeYeC?=
 =?us-ascii?Q?ibVwu0UwBUY7kqZTejOhwi2nbl8qwIvfqquxKyk6RwCBGZY+vthPmPBybitf?=
 =?us-ascii?Q?XjBy/s5Kfr42n0yDnJoD4VmGckSWckqyIeruhQKvB50pv/BYD7ryXMnU6XiY?=
 =?us-ascii?Q?7ybuPefomWLs1B+6aDcwp6ywehYZpzvm4FtjeBi2+L3bA/7fH7gDoOZsNdfB?=
 =?us-ascii?Q?IQo97Qr20gYHxdG3WnQwe03MVEqxGPL5PuMqPHnYSPHSaQIzgjwYwJQRva62?=
 =?us-ascii?Q?iyw7ljIP1RjCAo0lUG67UIgy6IJpLt0qka/YngZzEj+VqkHFN8DcHi6WVjTb?=
 =?us-ascii?Q?cVBODeyg4kIF0iTSPXd+QIGnxsWwYDNKmhFBvgYD1hmVSNeYka2uUddXdQRw?=
 =?us-ascii?Q?yx2JdQvUkq5tKqzJiQ1ghYK+rkMx/CGneZM7+F2XsT+KIl8n67DpOEWBhYzs?=
 =?us-ascii?Q?SN4AtVSiWIGgEjRQvcGbkrgrFEknhhL2mJjKTTLXPV2eKF8wNB7/cUFlBB3f?=
 =?us-ascii?Q?ZbTgxpJM8j7UzDOzq+84LpPm2pwD1krlF+xN1sYmPUIXQ2Guz6gB7hpRLAI1?=
 =?us-ascii?Q?ZfXWtQNK7EnbAy0nXfhoT+eFA9IumstHHV+zOsgbWy9AY3vAR4sDZPT2VqLo?=
 =?us-ascii?Q?2yaPDUsPMarYKl3smZTC6ngI8S0LOCS2aJxd804IgHdsO0gJw1VuLXdYrHAw?=
 =?us-ascii?Q?PI0bNQr6Jzrng3v+YqEteRn0f6NSzuXkrwt0uX+XiLJaJIHFrkLme5eSCXHO?=
 =?us-ascii?Q?H/VgZwmz+X4GkSk5KL8fu6pFmZyaCVWYTqxjdgG3qX3yByKEdRVEsfB2iyyI?=
 =?us-ascii?Q?USrZkMNQU218OSpmGJDuQHpojJFdhZGB/irw9+ybT/aBEpjW3IDzX/kkneuq?=
 =?us-ascii?Q?2luuCdXcJ3TjW2LkWg2BDpfNr+nbQZwva4Z42ksuYobDaky5lbO5nCfPKU0m?=
 =?us-ascii?Q?SYd7DFz11eYSFR4naheVhE2aeX6XXa3hjMpL5sPUVjCDTwAa1629VWrWf1ci?=
 =?us-ascii?Q?tAtFpm5RvrIUfEcp8prhTjmGGo79DRxAZT9ag5ztr6CAqLVpTwW9dCWFoUhP?=
 =?us-ascii?Q?vjBabP+7H37TuUk2irzfYRKgovNfLg8Q965aztXfrWGUszvo0l2tOYOgGyoa?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b830f2ca-5b7d-49b2-c235-08dbda31644d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0302MB3486.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 16:49:47.6473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3q2jhfBmP+hYdaVJynZM8G/yxNvQJfGqqOwsITTqIx3ZRtODS2y3mukbxpr5oTBdWdvtifGi9kUQf3vU9+Gy7DW1M/xYwWpIgZrLtF580Pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton <paulburton@kernel.org>

The MIPS I6500 CPU & CM (Coherence Manager) 3.5 introduce the concept of
multiple clusters to the system. In these systems each cluster contains
its own GIC, so the GIC isn't truly global any longer. We do have the
ability to access registers in the GICs of remote clusters using a
redirect register block much like the redirect register blocks provided
by the CM & CPC, and configured through the same GCR_REDIRECT register
that we our mips_cm_lock_other() abstraction builds upon.

It is expected that external interrupts are connected identically to all
clusters. That is, if we have a device providing an interrupt connected
to GIC interrupt pin 0 then it should be connected to pin 0 of every GIC
in the system. This simplifies things somewhat by allowing us for the
most part to treat the GIC as though it is still truly global, so long
as we take care to configure interrupts in the cluster that we want them
affine to.

This patch introduces support for such multi-cluster systems in the MIPS
GIC irqchip driver. We introduce a new gic_irq_lock_cluster() function
which allows us to either:

  1) Configure access to a GIC in a remote cluster via the redirect
     register block, using mips_cm_lock_other().

Or:

  2) Detect that the interrupt in question is affine to the local
     cluster and we should use plain old GIC register access to the GIC
     in the local cluster.

It is possible to access the local cluster's GIC registers via the
redirect block, but keeping the special case for them is both good for
performance (because we avoid the locking & indirection overhead of
using the redirect block) and necessary to maintain compatibility with
systems using CM revisions prior to 3.5 which don't support the redirect
block.

The gic_irq_lock_cluster() function relies upon an IRQs effective
affinity in order to discover which cluster the IRQ is affine to. In
order to track this & allow it to be updated at an appropriate point
during gic_set_affinity() we select the generic support for effective
affinity using CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK.

gic_set_affinity() is the one function which gains much complexity. It
now deconfigures routing to any VP(E), ie. CPU, on the old cluster when
moving affinity to a new cluster. Because we only configure an
interrupts trigger type in the cluster which it is affine to we call
gic_set_type() to configure that in the new cluster, after having
updated the effective affinity mask such that gic_irq_lock_cluster()
begins operating on the new cluster. Finally we map the interrupt to the
appropriate pin & VP(E) in the new cluster.

gic_shared_irq_domain_map() moves its update of the IRQs effective
affinity to before its use of gic_irq_lock_cluster(), in order to ensure
we operate on the cluster the IRQ is affine to.

The remaining changes are straightforward use of the
gic_irq_lock_cluster() function to select between local cluster & remote
cluster code-paths when configuring interrupts.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
Signed-off-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
---
 drivers/irqchip/Kconfig        |   1 +
 drivers/irqchip/irq-mips-gic.c | 161 +++++++++++++++++++++++++++++----
 2 files changed, 143 insertions(+), 19 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index f7149d0f3d45..be9f0797c4ed 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -328,6 +328,7 @@ config KEYSTONE_IRQ
 
 config MIPS_GIC
 	bool
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
 	select GENERIC_IRQ_IPI if SMP
 	select IRQ_DOMAIN_HIERARCHY
 	select MIPS_CM
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index cdd8973912a9..8e9046516e63 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -135,6 +135,41 @@ static inline void __lockdep_assert_held(raw_spinlock_t *gic_lock)
 	     (cpu) = __gic_with_next_online_cpu(cpu),	\
 	     (cpu) < nr_cpu_ids;)
 
+/**
+ * gic_irq_lock_cluster() - Lock redirect block access to IRQ's cluster
+ * @d: struct irq_data corresponding to the interrupt we're interested in
+ *
+ * Locks redirect register block access to the global register block of the GIC
+ * within the remote cluster that the IRQ corresponding to @d is affine to,
+ * returning true when this redirect block setup & locking has been performed.
+ *
+ * If @d is affine to the local cluster then no locking is performed and this
+ * function will return false, indicating to the caller that it should access
+ * the local clusters registers without the overhead of indirection through the
+ * redirect block.
+ *
+ * In summary, if this function returns true then the caller should access GIC
+ * registers using redirect register block accessors & then call
+ * mips_cm_unlock_other() when done. If this function returns false then the
+ * caller should trivially access GIC registers in the local cluster.
+ *
+ * Returns true if locking performed, else false.
+ */
+static bool gic_irq_lock_cluster(struct irq_data *d)
+{
+	unsigned int cpu, cl;
+
+	cpu = cpumask_first(irq_data_get_effective_affinity_mask(d));
+	BUG_ON(cpu >= NR_CPUS);
+
+	cl = cpu_cluster(&cpu_data[cpu]);
+	if (cl == cpu_cluster(&current_cpu_data))
+		return false;
+
+	mips_cm_lock_other(cl, 0, 0, CM_GCR_Cx_OTHER_BLOCK_GLOBAL);
+	return true;
+}
+
 static void gic_clear_pcpu_masks(unsigned int intr)
 {
 	unsigned int i;
@@ -181,7 +216,12 @@ static void gic_send_ipi(struct irq_data *d, unsigned int cpu)
 {
 	irq_hw_number_t hwirq = GIC_HWIRQ_TO_SHARED(irqd_to_hwirq(d));
 
-	write_gic_wedge(GIC_WEDGE_RW | hwirq);
+	if (gic_irq_lock_cluster(d)) {
+		write_gic_redir_wedge(GIC_WEDGE_RW | hwirq);
+		mips_cm_unlock_other();
+	} else {
+		write_gic_wedge(GIC_WEDGE_RW | hwirq);
+	}
 }
 
 int gic_get_c0_compare_int(void)
@@ -249,7 +289,13 @@ static void gic_mask_irq(struct irq_data *d)
 {
 	unsigned int intr = GIC_HWIRQ_TO_SHARED(d->hwirq);
 
-	write_gic_rmask(intr);
+	if (gic_irq_lock_cluster(d)) {
+		write_gic_redir_rmask(intr);
+		mips_cm_unlock_other();
+	} else {
+		write_gic_rmask(intr);
+	}
+
 	gic_clear_pcpu_masks(intr);
 }
 
@@ -258,7 +304,12 @@ static void gic_unmask_irq(struct irq_data *d)
 	unsigned int intr = GIC_HWIRQ_TO_SHARED(d->hwirq);
 	unsigned int cpu;
 
-	write_gic_smask(intr);
+	if (gic_irq_lock_cluster(d)) {
+		write_gic_redir_smask(intr);
+		mips_cm_unlock_other();
+	} else {
+		write_gic_smask(intr);
+	}
 
 	gic_clear_pcpu_masks(intr);
 	cpu = cpumask_first(irq_data_get_effective_affinity_mask(d));
@@ -269,7 +320,12 @@ static void gic_ack_irq(struct irq_data *d)
 {
 	unsigned int irq = GIC_HWIRQ_TO_SHARED(d->hwirq);
 
-	write_gic_wedge(irq);
+	if (gic_irq_lock_cluster(d)) {
+		write_gic_redir_wedge(irq);
+		mips_cm_unlock_other();
+	} else {
+		write_gic_wedge(irq);
+	}
 }
 
 static int gic_set_type(struct irq_data *d, unsigned int type)
@@ -309,9 +365,16 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 		break;
 	}
 
-	change_gic_pol(irq, pol);
-	change_gic_trig(irq, trig);
-	change_gic_dual(irq, dual);
+	if (gic_irq_lock_cluster(d)) {
+		change_gic_redir_pol(irq, pol);
+		change_gic_redir_trig(irq, trig);
+		change_gic_redir_dual(irq, dual);
+		mips_cm_unlock_other();
+	} else {
+		change_gic_pol(irq, pol);
+		change_gic_trig(irq, trig);
+		change_gic_dual(irq, dual);
+	}
 
 	if (trig == GIC_TRIG_EDGE)
 		irq_set_chip_handler_name_locked(d, &gic_edge_irq_controller,
@@ -329,25 +392,72 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 			    bool force)
 {
 	unsigned int irq = GIC_HWIRQ_TO_SHARED(d->hwirq);
+	unsigned int cpu, cl, old_cpu, old_cl;
 	unsigned long flags;
-	unsigned int cpu;
 
+	/*
+	 * The GIC specifies that we can only route an interrupt to one VP(E),
+	 * ie. CPU in Linux parlance, at a time. Therefore we always route to
+	 * the first online CPU in the mask.
+	 */
 	cpu = cpumask_first_and(cpumask, cpu_online_mask);
 	if (cpu >= NR_CPUS)
 		return -EINVAL;
 
-	/* Assumption : cpumask refers to a single CPU */
-	raw_spin_lock_irqsave(&gic_lock, flags);
+	old_cpu = cpumask_first(irq_data_get_effective_affinity_mask(d));
+	old_cl = cpu_cluster(&cpu_data[old_cpu]);
+	cl = cpu_cluster(&cpu_data[cpu]);
 
-	/* Re-route this IRQ */
-	write_gic_map_vp(irq, BIT(mips_cm_vp_id(cpu)));
+	raw_spin_lock_irqsave(&gic_lock, flags);
 
-	/* Update the pcpu_masks */
-	gic_clear_pcpu_masks(irq);
-	if (read_gic_mask(irq))
-		set_bit(irq, per_cpu_ptr(pcpu_masks, cpu));
+	/*
+	 * If we're moving affinity between clusters, stop routing the
+	 * interrupt to any VP(E) in the old cluster.
+	 */
+	if (cl != old_cl) {
+		if (gic_irq_lock_cluster(d)) {
+			write_gic_redir_map_vp(irq, 0);
+			mips_cm_unlock_other();
+		} else {
+			write_gic_map_vp(irq, 0);
+		}
+	}
 
+	/*
+	 * Update effective affinity - after this gic_irq_lock_cluster() will
+	 * begin operating on the new cluster.
+	 */
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
+
+	/*
+	 * If we're moving affinity between clusters, configure the interrupt
+	 * trigger type in the new cluster.
+	 */
+	if (cl != old_cl)
+		gic_set_type(d, irqd_get_trigger_type(d));
+
+	/* Route the interrupt to its new VP(E) */
+	if (gic_irq_lock_cluster(d)) {
+		write_gic_redir_map_pin(irq,
+					GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
+		write_gic_redir_map_vp(irq, BIT(mips_cm_vp_id(cpu)));
+
+		/* Update the pcpu_masks */
+		gic_clear_pcpu_masks(irq);
+		if (read_gic_redir_mask(irq))
+			set_bit(irq, per_cpu_ptr(pcpu_masks, cpu));
+
+		mips_cm_unlock_other();
+	} else {
+		write_gic_map_pin(irq, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
+		write_gic_map_vp(irq, BIT(mips_cm_vp_id(cpu)));
+
+		/* Update the pcpu_masks */
+		gic_clear_pcpu_masks(irq);
+		if (read_gic_mask(irq))
+			set_bit(irq, per_cpu_ptr(pcpu_masks, cpu));
+	}
+
 	raw_spin_unlock_irqrestore(&gic_lock, flags);
 
 	return IRQ_SET_MASK_OK;
@@ -503,11 +613,21 @@ static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	unsigned long flags;
 
 	data = irq_get_irq_data(virq);
+	irq_data_update_effective_affinity(data, cpumask_of(cpu));
 
 	raw_spin_lock_irqsave(&gic_lock, flags);
-	write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
-	write_gic_map_vp(intr, BIT(mips_cm_vp_id(cpu)));
-	irq_data_update_effective_affinity(data, cpumask_of(cpu));
+
+	/* Route the interrupt to its VP(E) */
+	if (gic_irq_lock_cluster(data)) {
+		write_gic_redir_map_pin(intr,
+					GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
+		write_gic_redir_map_vp(intr, BIT(mips_cm_vp_id(cpu)));
+		mips_cm_unlock_other();
+	} else {
+		write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
+		write_gic_map_vp(intr, BIT(mips_cm_vp_id(cpu)));
+	}
+
 	raw_spin_unlock_irqrestore(&gic_lock, flags);
 
 	return 0;
@@ -687,6 +807,9 @@ static int gic_ipi_domain_alloc(struct irq_domain *d, unsigned int virq,
 		if (ret)
 			goto error;
 
+		/* Set affinity to cpu.  */
+		irq_data_update_effective_affinity(irq_get_irq_data(virq + i),
+						   cpumask_of(cpu));
 		ret = irq_set_irq_type(virq + i, IRQ_TYPE_EDGE_RISING);
 		if (ret)
 			goto error;
-- 
2.25.1

