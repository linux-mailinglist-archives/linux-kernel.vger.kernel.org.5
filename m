Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659607CD7EE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjJRJ05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjJRJ0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:26:54 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D26C114;
        Wed, 18 Oct 2023 02:26:51 -0700 (PDT)
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39I1U9kl025950;
        Wed, 18 Oct 2023 02:26:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        proofpoint20171006; bh=gK2JOwyR2SZnY2ERpaZhaT//2ejNTS+IVKWO/HOCv
        Og=; b=Pi3pXoWpoz8K7vbDFyToZtQC4+KJ4WC1pgV+fdpdw+SoKyIoQTITfjalH
        z99JdSVm8FXzmMKEcZYR/bArSJBx/xXHGnYdptIARQt0wrbXqRgIdX7R9+qRHqcu
        7TmOqgXQxWUwIzmxF/Q+hN/ptrEz02FtK6RB1HU+ft1N8JfbtH/GN8MUPm8SQR7G
        apjT8/hhK91iMZINeIbuqBMtwcmti41tiYKa6TXnM0Bt80cGx/tsVmEV6C0Uj3d0
        rCaNhOBif8xvvaYN1yl6wFPTv7hjon42hiZfBxNCUj7c8DsgVFCWyXydthDi6AK4
        +xTbnrt1wTc42Ch/ar696ktErVVYQ==
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3ts6hwnd5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 02:26:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JByQxl0XcRJstpxmwT6wIdQZSBp48bSKIrh/NcHtREksZ7Do86KWr1GlTaOCF2eifK4JI1xgjnA4B2i6j8klzJxuMQFi0v/+739wpZU1fuPjxFgCZAZv5O5FBwGuHxsX49OT1qAXyTXl5FBCmIWp+/bZ4IaL828HLKQisJ3oMf03DKO0/XiZizHZQnUtah1qryEkycZEzy1lOLr9qerlkoukg89M1ewHPRmQp5qj56FLlkX1YlAxubxLtf9lVq74IMEQYOBU8+2Q75aUJunMAOLAxMUYIimHZMTC8NZM2tq0iy60WLfNFDg+fwj/Ywz5FmeWel65Q6qc0ZfL3q5LXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gK2JOwyR2SZnY2ERpaZhaT//2ejNTS+IVKWO/HOCvOg=;
 b=CYTPxhXm8Kcq17gIuyjzgx2F1DFoBTatv2aRmowsiVpaFpUmU9ounBmf20lkrWxOTNrk8nlh3Be4go6Gmznx+Orxygp4GBLE5WSBp+zH2A1Qgkp3iVR1G9piTUZa5o51HsA4ltzu0XfvmznijXjwEJNYHLxD/PXldYo0SxvESKhM9/CXjupnFXm8MsiU1M4A+GQ/0t3JsiNmD4sBBiw+XVOFGmFKdiqzv+xvcCoHKXhGmOYBVtZqyYGT3YoJDTrR3YWrbtHoAMGfHJtLELzVFsq8A3FjdHZ8IsdM0038n8en8Nn5W+WyVbR/avmJCSH2qse+XnuL5a2RDNYAj3DWyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gK2JOwyR2SZnY2ERpaZhaT//2ejNTS+IVKWO/HOCvOg=;
 b=MUpU7IbOvLv9HGXyy+l+OpCwcBRFXM3qtcEvgmf6I5n5rkostOKcptuRtgrDDrKrySffn4a1Q/cbFk1VWL1ayVi2UVm6W4RJTfgfDiizDPCdCfrK2FoQTMJuQwo6WkfQH2Qaar1d8EC/J+rwjSPZzw53yP6mqlxZ5WNqM15B5vKRznu6NH3DCTKmCgg2d4F/H94PCVDPq1uxUM1CyXW+an20EFKPWMk+NsXgUSAY/YGnZNBOoHvcDs/r8Ys3ykIbat9wSo1vjbXaPS8VcXT43UV6NCJ1R2+9xB22Csq/oNf1xnvMDxeUWEFqzyMmWwWTup0h+ErF+HNlyT23psZf7A==
Received: from DM5PR02MB3830.namprd02.prod.outlook.com (2603:10b6:4:b0::29) by
 MW4PR02MB7299.namprd02.prod.outlook.com (2603:10b6:303:67::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.46; Wed, 18 Oct 2023 09:26:46 +0000
Received: from DM5PR02MB3830.namprd02.prod.outlook.com
 ([fe80::26ba:be45:ee4b:e1ae]) by DM5PR02MB3830.namprd02.prod.outlook.com
 ([fe80::26ba:be45:ee4b:e1ae%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 09:26:45 +0000
From:   Chris Riches <chris.riches@nutanix.com>
To:     audit@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>
Cc:     chris.riches@nutanix.com, jonathan.davies@nutanix.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] audit: Send netlink ACK before setting connection in auditd_set
Date:   Wed, 18 Oct 2023 09:23:51 +0000
Message-Id: <20231018092351.195715-1-chris.riches@nutanix.com>
X-Mailer: git-send-email 2.36.6
In-Reply-To: <CAHC9VhQBV1mcFUmXQs1-VKpAVdaAQ3EiGk-G3ybxfcBkoKGwcw@mail.gmail.com>
References: <CAHC9VhQBV1mcFUmXQs1-VKpAVdaAQ3EiGk-G3ybxfcBkoKGwcw@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::9) To DM5PR02MB3830.namprd02.prod.outlook.com
 (2603:10b6:4:b0::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3830:EE_|MW4PR02MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f458b0a-6294-4546-81b0-08dbcfbc57e9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: brRbnill0C4lm0P+c8tOiNFceYMDzMvx/YSKUTOCoso9zx+G+piNpGeQFgowFFTnHBMcJpKvwgL3VTQybzWuOSh9aJcKfuutMNkaTRZvjyWj3Hx09RqaWQMbQbpYDp9JldBREoViMYhuU2nI/0gaD1xq6V7U6xDNQz1wGqdQWzL45gdxrBErXEJJq8AbViPJ+OAHYtmpz7KQa7TOp2G5eUZe/xV8lsdVtep+WsyhHSu3Qz9wT+0Jj7Qlwntvj6xWNdvZn/MbYnQb75Bml3gy6xDVkCHWnArAUfreOwMG5NwaK7HANiRfpwbjtH2/Vj0UlSvRMmKnsAfhBoJ7X1zKEuSc9IziOLLHRWaHb/0Z81Gn8Dd/+KVa1B/mVDSP9xsTt6YTJE1xRFbtdelA2cbsvng5OkS/7o5IBsrhzzC9gmphLb5f7vruRnYnXVuon+5nLCePAa9Wgv5KCMPE61l9QnjXT3vfIlNfEHtEaXRJXCQKdrW9wK5zlsynCTkxKFXtxgKSs7oeEJ2mHifCc8lF/Ha0ePUAcopKY4slWcACPhs6DnVnIrpLRZPR17VC88DCDP3mHzq/A8DJiBiQ9O/YgnFLX32WLWbSosQPwhnaPg/DQAu/5w4LR9u7aRRMmirI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR02MB3830.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(376002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(83380400001)(316002)(66899024)(8936002)(8676002)(110136005)(86362001)(36756003)(4326008)(66946007)(66556008)(44832011)(66476007)(38100700002)(38350700005)(2616005)(6506007)(2906002)(6666004)(41300700001)(52116002)(6486002)(6512007)(5660300002)(508600001)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cbl1UoGZOogaeIrR71lMDnjv5GrSzeWPHzpXAOP/GvF24fZFVPheSUUmTNMq?=
 =?us-ascii?Q?gtMBWUernFlWwFVF62nWZrUC8RE84JObDZVh5l8ZK5g1kP0VhY9IGbg1g8y9?=
 =?us-ascii?Q?jiANiNqO1YH2W22wG7rekqrKa/p3oY5c3sQr2X6VJAy3UEWqey9+bZrU79lh?=
 =?us-ascii?Q?KrYIbrrZQ0xETvl9bVRhzp1f64UQRj3MJSHmlVHXlhZhgOaxkDbiVlb20q8B?=
 =?us-ascii?Q?NhPc3bdhYMo67/2NbgAstT1sAnLPz66a/WxVghPsNeRWi7eIFJQL8tFS9siA?=
 =?us-ascii?Q?DRlvp8evTZm61dnUVCmBFsPkGFTfMXtcCe8+UcXnBig6LHDTzDjoyOuHn7rR?=
 =?us-ascii?Q?CeZ3ZbLNVQn1KoWL2uh6lqBFAMF//uwKBstlJp5YstcC9XqjyI1wrlRq2jOX?=
 =?us-ascii?Q?ZHdg/9E3mj1XNAM3BbKF2RfNFA2n2C61+nEedFwqI1+9BNrhQSw2iOO7EM1S?=
 =?us-ascii?Q?qSEV5yRDzmEUja8rHr4kAx0FSoB9RlAjxxwbyClAU+rZlYlYFc/bX0oONpet?=
 =?us-ascii?Q?nmo9xNwiy9Zgj5bfOOJmOVElZw/ITlW9cUZ856u1kGSu1sQXT9xSu+b1Arn3?=
 =?us-ascii?Q?Pa6wZDIPT67JzAsjx4Vq2oqm7HazJaEPeh66DTD+T+BuQVbJdeAYiTOwCmYd?=
 =?us-ascii?Q?BYndYOrHUjGXIIVQiD77O9Sx21oAYFV+vRMa7tj52eZz+TuXRkRdmNo5jEhJ?=
 =?us-ascii?Q?TvLsUJb055zf7XUi29Y7ScaO/J5XYbn/RafF/gdodOmRRgMyg5iZy1qiChp7?=
 =?us-ascii?Q?DODNv6v5MjZdDulAl9BFBFJbRqbbS5EvLnZlmHJsuWH/YdJbJNH4i8Em3YAe?=
 =?us-ascii?Q?0qcsj4c+uU1A3BBAJvAjNEbPukdtFeiYFG5IIIXoUofcaDIS03sIIX7F3MpX?=
 =?us-ascii?Q?okBYz5wSRRr8twy2io5qKUOo2na/X+ltrFS0WrRjjNYdyD2OoycnYng7DePj?=
 =?us-ascii?Q?cQp9t8yxU02HldMKMQge7CKxMYs6mxYj92Ku30p2LL3NmJbd9jMoE1MTC9rZ?=
 =?us-ascii?Q?1ffu6G0qzH32wqa6UsaF0VYU/dv04Cuf90OnqMErjv5JN5FHELtis1ESIk6h?=
 =?us-ascii?Q?YuuH7vfiMvKTQAbQ8q+0NPBZHM9gjGlI/ZM0lhlJ6u4LgDz6mHKAXEUQfvVS?=
 =?us-ascii?Q?RmJM8DrnkZo2lL5tAj3nR1AtCHpkLzI3OvMHTtdp9uvsqubp5IB7bfJhLtW9?=
 =?us-ascii?Q?nBYQJPBqKg78m7m1F5NRUPgznmrnrODsvr1A0OM7lPrX8uxg8fQHjA4h8KrL?=
 =?us-ascii?Q?gXjr4kfyGFBm2kZkHj+S5OMPSL1sP7CVLau/nn9qKqk+gunlqCvDjsbKphHY?=
 =?us-ascii?Q?BGCmrfaLuhMJP6BS+DxEg+J/+tZnnHAbbqZfdO0jNSEQ40Mu4b/r0MMH4AtF?=
 =?us-ascii?Q?6R4VEPjyAf8yFo5wv5nMSns2XpysF0Ms5X2HRuxpaYDAoh+nZY8ivm0Vu3rh?=
 =?us-ascii?Q?PQiiT8J9+5/m2FO/+4NjolXTmLosQ9Z80umEKSvPMXpbUNk068iBZI9mNKb4?=
 =?us-ascii?Q?q6EQ3dV+T+fQ5v9TD/JFVhTEmIA9w4PxtFojpsBCgKGuqSt5HIf91j8+BaNN?=
 =?us-ascii?Q?SyzByRpJE6cqEoz8YMCqZ2WhCO8CuTYk7Aw8qeeRXmtl0OWjXnJk8KZqGZ7t?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f458b0a-6294-4546-81b0-08dbcfbc57e9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3830.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 09:26:44.3881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7auLomd9TnZa7OxGfxaWNXad0Hm9/5sc0LX0KYL0EpZisr17zLkdlix4q3mx6d3qW9dWpxbgMtrhOacBvdcfRiAqqwqwfQ0ApoTXrcEA+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7299
X-Proofpoint-GUID: 6F4K9dOFsspRuRGKHi6PGFsaYyKxc8jq
X-Proofpoint-ORIG-GUID: 6F4K9dOFsspRuRGKHi6PGFsaYyKxc8jq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_07,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When auditd_set sets the auditd_conn pointer, audit messages can
immediately be put on the socket by other kernel threads. If the backlog
is large or the rate is high, this can immediately fill the socket
buffer. If the audit daemon requested an ACK for this operation, a full
socket buffer causes the ACK to get dropped, also setting ENOBUFS on the
socket.

To avoid this race and ensure ACKs get through, fast-track the ACK in
this specific case to ensure it is sent before auditd_conn is set.

Signed-off-by: Chris Riches <chris.riches@nutanix.com>

---

> I'm happier with the bool over the integer type for the @ack variable.
> I'd suggest updating the patch and posting it again so we can review
> it in full, but we weren't very far off last time so I think it should
> be close, if not acceptable on the next revision.

Here's the latest iteration of the suggested patch. I've done it via git
send-email so it should apply cleanly.



 kernel/audit.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 9bc0b0301198..20c6981490ad 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -488,15 +488,19 @@ static void auditd_conn_free(struct rcu_head *rcu)
  * @pid: auditd PID
  * @portid: auditd netlink portid
  * @net: auditd network namespace pointer
+ * @skb: the netlink command from the audit daemon
+ * @ack: netlink ack flag, cleared if ack'd here
  *
  * Description:
  * This function will obtain and drop network namespace references as
  * necessary.  Returns zero on success, negative values on failure.
  */
-static int auditd_set(struct pid *pid, u32 portid, struct net *net)
+static int auditd_set(struct pid *pid, u32 portid, struct net *net,
+                      struct sk_buff *skb, bool *ack)
 {
 	unsigned long flags;
 	struct auditd_connection *ac_old, *ac_new;
+	struct nlmsghdr *nlh;
 
 	if (!pid || !net)
 		return -EINVAL;
@@ -508,6 +512,13 @@ static int auditd_set(struct pid *pid, u32 portid, struct net *net)
 	ac_new->portid = portid;
 	ac_new->net = get_net(net);
 
+	/* send the ack now to avoid a race with the queue backlog */
+	if (*ack) {
+		nlh = nlmsg_hdr(skb);
+		netlink_ack(skb, nlh, 0, NULL);
+		*ack = false;
+	}
+
 	spin_lock_irqsave(&auditd_conn_lock, flags);
 	ac_old = rcu_dereference_protected(auditd_conn,
 					   lockdep_is_held(&auditd_conn_lock));
@@ -1201,7 +1212,8 @@ static int audit_replace(struct pid *pid)
 	return auditd_send_unicast_skb(skb);
 }
 
-static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
+static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
+			     bool *ack)
 {
 	u32			seq;
 	void			*data;
@@ -1294,7 +1306,8 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 				/* register a new auditd connection */
 				err = auditd_set(req_pid,
 						 NETLINK_CB(skb).portid,
-						 sock_net(NETLINK_CB(skb).sk));
+						 sock_net(NETLINK_CB(skb).sk),
+						 skb, ack);
 				if (audit_enabled != AUDIT_OFF)
 					audit_log_config_change("audit_pid",
 								new_pid,
@@ -1539,9 +1552,10 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
  * Parse the provided skb and deal with any messages that may be present,
  * malformed skbs are discarded.
  */
-static void audit_receive(struct sk_buff  *skb)
+static void audit_receive(struct sk_buff *skb)
 {
 	struct nlmsghdr *nlh;
+	bool ack;
 	/*
 	 * len MUST be signed for nlmsg_next to be able to dec it below 0
 	 * if the nlmsg_len was not aligned
@@ -1554,9 +1568,12 @@ static void audit_receive(struct sk_buff  *skb)
 
 	audit_ctl_lock();
 	while (nlmsg_ok(nlh, len)) {
-		err = audit_receive_msg(skb, nlh);
-		/* if err or if this message says it wants a response */
-		if (err || (nlh->nlmsg_flags & NLM_F_ACK))
+		ack = nlh->nlmsg_flags & NLM_F_ACK;
+		err = audit_receive_msg(skb, nlh, &ack);
+
+		/* send an ack if the user asked for one and audit_receive_msg
+		 * didn't already do it, or if there was an error. */
+		if (ack || err)
 			netlink_ack(skb, nlh, err, NULL);
 
 		nlh = nlmsg_next(nlh, &len);
-- 
2.36.6

