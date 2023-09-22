Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6200C7AB54E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjIVPx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjIVPxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:53:54 -0400
X-Greylist: delayed 1527 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Sep 2023 08:53:48 PDT
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076EB122;
        Fri, 22 Sep 2023 08:53:47 -0700 (PDT)
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38MD5BDs012781;
        Fri, 22 Sep 2023 08:28:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
        from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=proofpoint20171006; bh=G12shCmEn/Z
        gr9QqW6ASOo2uh4C0UXuz05W/vv/CsAE=; b=EmtwfsjwcktfU9A5HNIrANilQiW
        PUFEBWnER+s/leRSMpmD7YKoIt7Y68RBnsr+n41A3borXeu53Qv9gybrMXZtivxJ
        GSS0lqNyMye/FtGA8dklL+Rf+a+IaMKrnMF4qUsbjW0IszuYTvdqI3vIpvQNfmsP
        Brut0uPMdgPXEoFqqgID6lkMV4T3wNb/ZV2n6RpiMiKltVSmhHKBJeceBzokD7KU
        r6rhZRMyAWIGUMmfgM2NrHdERb74n1nj3RNs9IpmqTYD+7MX+vWujCLKV7D4K4xN
        Ysalj3w1NsFVSWLVILCY9oYd8MCti1NgsJBC3BQ/Uyun9eCuRL4MThYx1Pg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3t8tsbt86h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 08:28:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDb3fCWBSJsIU2zCYtnXmrPaMcZoMH8iXyIQ1KOrm3fnX4vGdDPMsH0CWu71QyIw6IPiyKinKaWm4E4Le2KsQ/e7IWFNa7mueIpeNNDSvQI43+H0sYyuPbnau/EhUycJo/t3LgocQ4DBRtS2Fw5InokaTvbsbqK3npwKwm3CinF5wdqoggZlu2SXY9IbBQ7hncLn076ndu5OkvwSPACO5O34pGIfswKIfvC7rSzJffh4KpvCScty3lAjzKEMh1P319E4+Fn0X9FL7mq5CD2P1KMdXagqwA1pdtAGBohEz0VTKvRbXpMx2tnHGlbaiFzvPEqViGKGAqdOtgoWPyzzBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G12shCmEn/Zgr9QqW6ASOo2uh4C0UXuz05W/vv/CsAE=;
 b=n4+sh81EAA41gdJFRmjWPxX6joijJUV3dXSJb65CJAmJaunE27CWqJf3PQJIByu77VgMB4Xu/nT/mBqodTYh3RAauysOHTjnA49m57dc/nd+rvLnfH+LWODBG68d5QDGVnQqA3wAFPzljTxsVGKO5zDUNkMHwcodOMySwnqrwNsYaHBIb4MUvftn1cuaAtmXzBSrNZvQfWhrEZTjICzuQvFtH4fCq2DCMsLTLLSerT7EdZhu+qmx3hIy31oYWD/Jesp1fxFzAoSj2QMi7Go8F82HaIYeuP8iR2bV4t9RT4O59ccQ4yrtq7p5ZQvdmmVHLTYr9sRLm+T0IDNwXLSAGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G12shCmEn/Zgr9QqW6ASOo2uh4C0UXuz05W/vv/CsAE=;
 b=UWXMxEZosoHEnjWYSqnrbbdijIak8ruU9EDGLQmVgRiSElJchyWLebt4x58+F7HLB5mLWhxWDoo4AG8jUL12QH1hOEOa6Mi/k3TVBkTv2FsTvE/LCd+mUJ9ropkfR3xIpfVRJids2NMYmIZOUKn89P8yQ4UIKW5NbYXbsn0gFum/V/r5+T2xtJJWVhFOf62wCCMTOmK5imwtq/zCsr+lXjEZct/ue3V0GB1eBPGbN9tEqkfGKGdozzfCI5M3SgAYgQEfNWS/h2BK0d15nT21hK7EDWZzLYqRwuOFIrMQjdMLlL9UroC2QyaPe1cUbzoTAbOdBk+O4pOb30aT9OYVfQ==
Received: from DM5PR02MB3830.namprd02.prod.outlook.com (2603:10b6:4:b0::29) by
 CO1PR02MB8620.namprd02.prod.outlook.com (2603:10b6:303:15f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.20; Fri, 22 Sep 2023 15:28:14 +0000
Received: from DM5PR02MB3830.namprd02.prod.outlook.com
 ([fe80::26ba:be45:ee4b:e1ae]) by DM5PR02MB3830.namprd02.prod.outlook.com
 ([fe80::26ba:be45:ee4b:e1ae%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 15:28:14 +0000
From:   Chris Riches <chris.riches@nutanix.com>
To:     audit@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>
Cc:     chris.riches@nutanix.com, jonathan.davies@nutanix.com,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] audit: Send netlink ACK before setting connection in auditd_set
Date:   Fri, 22 Sep 2023 15:27:49 +0000
Message-Id: <20230922152749.244197-1-chris.riches@nutanix.com>
X-Mailer: git-send-email 2.36.6
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::17) To DM5PR02MB3830.namprd02.prod.outlook.com
 (2603:10b6:4:b0::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3830:EE_|CO1PR02MB8620:EE_
X-MS-Office365-Filtering-Correlation-Id: 46cb099b-6836-4d10-9568-08dbbb8089df
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZDCdCJ2f/sXw3spKtT998WjFCU6tce/WYbNEbuf9hMnzBAYgv/PkGVCPsfmRkkoZaI7cKOD/1WmMCYGsfZ+X4rXVZols2+Eggndtrdc1p2Bp8hwefkI35Mqt+CayP27ZZ4h1sct0s2gfSrk70yVpe8xv6ISDCFwuacKfG/vQIqP4ypTaSh6cOA8/96YA0b33JEgB66wjimql+pgVISHlRVL9O+WhZDv9n0ZgHbsDhR2xlcUZgGyEN/hJJ5zyFsZeQfBwMsKrgSdMxpj9L+u+af2hnelZGdROYlAlLYZDqX7sUupwpfche/evRJuPWPcKcmmWZ1YUG98gI2NcZ0i7Zi9AmhemAkvo+LWhBx3X2rOifbS8HnIJMattMk/zBh95D8c4j7AZie+j6icE3TqCB/8L+SmDr5dtt4Hu2TSzteTKDc8bxXtcK3CRoStA6liGr+/hdg4qhqqb77xk9iLEGVKyUd55lCFkDEcCHR4uNr1wIS+qvOmF8qYcyuW4eoBerQ8suPi6GxF3NJxPZmilW3rRryLKzcnwICbCqomSa9OdMoDFxNRiLs172LVT9DdzoI9wk6EwbVUsNlRYfkC6O/qF1Z0eBy7R4VP9dkoZNSEFedWf3qib9pVfxW4/rLC8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR02MB3830.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(186009)(1800799009)(451199024)(52116002)(83380400001)(44832011)(478600001)(66946007)(66476007)(66556008)(110136005)(8936002)(6666004)(6512007)(6506007)(6486002)(8676002)(316002)(38350700002)(5660300002)(38100700002)(36756003)(4326008)(86362001)(2906002)(2616005)(41300700001)(26005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?05v0hb9Tsbvj9ZJUsVdLxKmf0UoQjywTZWuAnPXp/whkqI1h3I/Ohsgt1imb?=
 =?us-ascii?Q?TbkvQ/hudU3hpcK0p4PPrwcW9R2OSqBEd0VMDyxqIm3seMcuNRZCf3LSlKWE?=
 =?us-ascii?Q?ut7jhJ7pibQRGny6ijCzdkDuJyZ5xGJ5ybvPPpOQ09rcbA/+j2myNwAeoaxq?=
 =?us-ascii?Q?WBdRXwTF0HZ+hmlb0QTgpkFw9Peyd6xO5UcUzeWm1+U1uITB+ADTkHcq5gxr?=
 =?us-ascii?Q?IW/OiOv0wJoLdPm5qlO08KQnHYSCI91BBBS1x0pjyIfQGqdXpmlwl8fF6Zwm?=
 =?us-ascii?Q?E/z/iHhcp4CfBqyjuCwDfjTc3DEXU+SMc3T1B5EokOYSnPL18g/FhoYgkWjC?=
 =?us-ascii?Q?if02kmxMBYMrNxiDBENgvjp00a+hv60g8eJH6kKldJK/y5VUIzSH7s4zuCGc?=
 =?us-ascii?Q?CnxvO+b8fB4uMkSYzufor3LRU8urvULLnHg0728DvmbqaN0FgGQ8nZ/04Isv?=
 =?us-ascii?Q?fYlma1tYpiYClfsGK10Iq7RokmBwTn7f8NybidkpPquQPrbltG4tJWmpcLhD?=
 =?us-ascii?Q?+B4Mq7bR2FOEK2yuQ69P5MN2YM+mAkJXXtwTsCmg8PhLyUPbUXKRrJewakIb?=
 =?us-ascii?Q?vW8TI2WrPdbH5E5cErYsnenO4CDdg5longvlpPJ7ZDB6mjAkzK0AzTA2Zu+Z?=
 =?us-ascii?Q?s5usxHqJun+Hbt3xU1FXt05wGVJLbF907tnEXW4+FQGkR0aB1xkU++ENslmO?=
 =?us-ascii?Q?mrXrmEVD0GwHH5xvTkmqqWnuFwai91JEYrFLLo7qPjrJ0K68PZ9elbBFmLu2?=
 =?us-ascii?Q?ifrzAWj1Ap11VZ5SKk+kRkWueAd8u3ajoFDAyLejJ0lGbbMRDBQhWC9lGnuY?=
 =?us-ascii?Q?1sagdZm8NOaZewKgeZG28/ZjwsHYrfvStc2/WgP6mzZ3x3tktchgABa291ZO?=
 =?us-ascii?Q?zJuW/P4kR+LUWsObtnO66I7Z9DjWXkW5KxQ5fkVy6XHLvbtwBDYwKr569LPk?=
 =?us-ascii?Q?MWI8AN4yXstCUQgWGMrWD7MDIGZVmROnfC6CLuQcSu+2WhOR8ljvL0RhOjAw?=
 =?us-ascii?Q?S/iZbwTH+yO2kEaun4CkwLMcoraMpYIjZ8lr/ZuZL5PXo0U7oeEMm0UtGfSu?=
 =?us-ascii?Q?CnfzxiUl+YvGVA2wPtYrm3TLRmhtKgw54cHBr508rLxxmnMDXr/rYg/VY8e9?=
 =?us-ascii?Q?pJndB3UofcqcV3Thz8ZO0EGvKpl6Uij0vQjIsXTNEWkHEKw+NP2/1Y3fb1XR?=
 =?us-ascii?Q?HN/tbyp0jFHR4TX43OmI6kDQhr7ov35KyYw2GjKPGnw9WBm0PVhIzwOtYBB5?=
 =?us-ascii?Q?oQ11u+03iSTSZ9WBkmROedeLEQPqEtn2u+ZUytb2FqKKj1HuJ9BdZBVpelIA?=
 =?us-ascii?Q?jTcQGLhPeb9wFwIk3Lb5/8beJhGRuTCyZvmwe6zrER+ZdnlvbVISfkgA7Xxg?=
 =?us-ascii?Q?CQIKdctgKQVKFosyFG3SMyn2pYCTWpsr8h1Z64VFwqagXDfNdwJbwtet/1dJ?=
 =?us-ascii?Q?uWtlDNgz21xwggYQ0VOl7qHRU1AamdI+E8HsaUrZU6eDD2iCD7F5+i2NhV5/?=
 =?us-ascii?Q?OCeq1zgTZVXFOz0GdWWaPatJw/+UusVQbiAoDoLY9xzEL9vt1ijyZWXd7Ud1?=
 =?us-ascii?Q?RyWg1Do7cK6CwP+fh3/7OLqtignuYQcHijXPQq8OTwTQIwZi/qDWgelrHXTm?=
 =?us-ascii?Q?8g=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46cb099b-6836-4d10-9568-08dbbb8089df
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3830.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 15:28:14.7504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BVm7siBOZI9bEFFe13G7DaANVNSKTx3tinoEqaPy37zwbyxTSlOCGQfz+cY6N9uD+13zg112u4XBEP7ov+SEKYkuddnvZO2ccRNfQwFUoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8620
X-Proofpoint-ORIG-GUID: AoVDFH4kkqAM3bKZKavM-no96iKXqIzK
X-Proofpoint-GUID: AoVDFH4kkqAM3bKZKavM-no96iKXqIzK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_13,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

This mail is more of an RFC than a patch, though the included patch is a
useful illustation and might even be suitable for inclusion.

We are experiencing strange failures where the audit daemon fails to
start, hitting an ENOBUFS error on its audit_set_pid() call. This can be
reproduced by repeatedly restarting the audit daemon (or just doing a
tight loop of audit_open(), audit_set_pid(pid), audit_set_pid(0),
audit_close()) while the system is under heavy audit load. This also
seems to be dependent on the number of CPUs - we can reproduce this with
2 CPUs but not with 48.

Tracing showed a race between the kernel setting auditd_conn and sending
the ACK, as described in the commit message. The included patch attempts
to fix this by ensuring the ACK is sent before any audit messages can be
put on the socket. This seems to fix the problem for auditd starting,
but strangely I still hit it when running my minimal repro (the tight
loop mentioned above), albeit less frequently. I'm not sure if the patch
or the repro is at fault.

We may also want to look at this from the userspace side in the audit
daemon itself (or more specifically, libaudit). The ACK handling is a
little odd - check_ack() will happily return success without seeing an
ACK if a non-ACK message is top of the socket queue, but will fail if no
message arrives within the timeout. It also of course fails if ENOBUFS
is set on the socket, but this failure only seems to matter when doing
audit_set_pid() - similar failures during main-loop message processing
are logged but otherwise ignored, as far as I can tell.

I'm not sure I quite understand the intentions of the code, but it seems
odd to let ENOBUFS be a fatal error here, given that it likely means the
socket buffer got flooded with audit messages, and thus audit_set_pid()
succeeded. Perhaps we should just ignore ENOBUFS (instead of or as well
as patching the kernel).

Finally, there is another oddity in audit_set_pid() that is tangential
to this discussion but worth highlighting: if the wmode parameter is
WAIT_YES (which it is for the audit daemon), then there is some
additional ACK-handling which waits for 100 milliseconds and eats the
top message of the socket queue if one arrives, without inspecting it.
This seems completely wrong as the ACK will have already been consumed
by check_ack() if there was one, and so the best this code can do is
nothing, and at worst it will swallow a genuine audit message without
ever recording it. If you agree with my assessment of this code, I'm
happy to submit a separate patch to fix this.

Thanks,
Chris

 kernel/audit.c | 30 ++++++++++++++++++++++++------
 kernel/audit.h |  5 +++++
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 9bc0b0301198..c48c778b6f89 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -488,12 +488,16 @@ static void auditd_conn_free(struct rcu_head *rcu)
  * @pid: auditd PID
  * @portid: auditd netlink portid
  * @net: auditd network namespace pointer
+ * @ack_status: if AUDIT_ACK_ALWAYS, send ACK before setting connection and
+ *              set to AUDIT_ACK_DONE
+ * @skb: socket buffer for sending ACK
  *
  * Description:
  * This function will obtain and drop network namespace references as
  * necessary.  Returns zero on success, negative values on failure.
  */
-static int auditd_set(struct pid *pid, u32 portid, struct net *net)
+static int auditd_set(struct pid *pid, u32 portid, struct net *net,
+                      int *ack_status, struct sk_buff *skb)
 {
 	unsigned long flags;
 	struct auditd_connection *ac_old, *ac_new;
@@ -508,6 +512,13 @@ static int auditd_set(struct pid *pid, u32 portid, struct net *net)
 	ac_new->portid = portid;
 	ac_new->net = get_net(net);
 
+	if (*ack_status == AUDIT_ACK_ALWAYS) {
+		// Send ACK before we set auditd_conn. Otherwise, the socket buffer may
+		// get filled with backlogged audit messages causing the ACK to be dropped.
+		netlink_ack(skb, nlmsg_hdr(skb), 0, NULL);
+		*ack_status = AUDIT_ACK_DONE;
+	}
+
 	spin_lock_irqsave(&auditd_conn_lock, flags);
 	ac_old = rcu_dereference_protected(auditd_conn,
 					   lockdep_is_held(&auditd_conn_lock));
@@ -1201,7 +1212,7 @@ static int audit_replace(struct pid *pid)
 	return auditd_send_unicast_skb(skb);
 }
 
-static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
+static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh, int *ack_status)
 {
 	u32			seq;
 	void			*data;
@@ -1294,7 +1305,9 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 				/* register a new auditd connection */
 				err = auditd_set(req_pid,
 						 NETLINK_CB(skb).portid,
-						 sock_net(NETLINK_CB(skb).sk));
+						 sock_net(NETLINK_CB(skb).sk),
+						 ack_status,
+						 skb);
 				if (audit_enabled != AUDIT_OFF)
 					audit_log_config_change("audit_pid",
 								new_pid,
@@ -1548,15 +1561,20 @@ static void audit_receive(struct sk_buff  *skb)
 	 */
 	int len;
 	int err;
+	int ack_status = AUDIT_ACK_ON_ERR;
 
 	nlh = nlmsg_hdr(skb);
 	len = skb->len;
 
 	audit_ctl_lock();
 	while (nlmsg_ok(nlh, len)) {
-		err = audit_receive_msg(skb, nlh);
-		/* if err or if this message says it wants a response */
-		if (err || (nlh->nlmsg_flags & NLM_F_ACK))
+		if (nlh->nlmsg_flags & NLM_F_ACK)
+			ack_status = AUDIT_ACK_ALWAYS;
+
+		err = audit_receive_msg(skb, nlh, &ack_status);
+
+		/* send ACK if err or the message asked for one (and not already sent) */
+		if (ack_status == AUDIT_ACK_ALWAYS || (ack_status == AUDIT_ACK_ON_ERR && err))
 			netlink_ack(skb, nlh, err, NULL);
 
 		nlh = nlmsg_next(nlh, &len);
diff --git a/kernel/audit.h b/kernel/audit.h
index 94738bce40b2..bc692f60567a 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -344,4 +344,9 @@ extern int audit_filter(int msgtype, unsigned int listtype);
 extern void audit_ctl_lock(void);
 extern void audit_ctl_unlock(void);
 
+/* Control netlink ACK behaviour in audit_receive. */
+#define AUDIT_ACK_ON_ERR 1
+#define AUDIT_ACK_ALWAYS 2
+#define AUDIT_ACK_DONE 3
+
 #endif
-- 
2.36.6

