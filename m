Return-Path: <linux-kernel+bounces-28824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F51830372
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76C741C23934
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0A014A8C;
	Wed, 17 Jan 2024 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="mIPqLgtV"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2100.outbound.protection.outlook.com [40.107.101.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E3114270;
	Wed, 17 Jan 2024 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705486908; cv=fail; b=DMXusaqTBq6lttXnBGVfAd9E1XF++5WN7xiP4b6NSt26GfDeg4R6pZVEWgwXQnpLZHqQotChA8CYhBhXfgHnF+idw7t7RzvYE48lXxxz67sQdqtbs8RRm/VVfdv4HOwvDN13p08TWLg1iaQhW9qotC9eTd8yQ4AhRzv2bCr6n8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705486908; c=relaxed/simple;
	bh=Ip745+jKQOduPpa1h3pQUG6ekwSEArSKen2XXkiJWdQ=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=ToBewa8OWWXfhyqq41jvgZgiOjuVV4RpJfa/iOo1Lp6pk9RUK7hg6aMY1MXXRGdPwxCRub+Z6WxtidZXvmxR/dbM/5B1jIS0TdlHA0mSGrYR7MDZiIrfXukCZQB7NY78m1YhfdFCYvMfz1hknpbQ8aW4GOQxU0a//2drusI4NKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=Sony.onmicrosoft.com; dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b=mIPqLgtV; arc=fail smtp.client-ip=40.107.101.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Sony.onmicrosoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bty2fmnZ/IlItp40ApG1JdP92abIXeGaGTviZRRrz7AySCzRDRoGmRfIK3gRZLDZHPKk+FaIJauLyoXVkjtpfZ5p9PmKXQ2a7ViBQ3XcmWRVVjPW26t9Xjv3JI5uzy3lt3T3bv3W6OYRXuEa5ayWTZadj6ZpmkYKp6hsK91chVpaF5AZroeQfvMDVAiIA+1Xf7i2VnUvuSTWLDJUupFJhnzA7dRBW6TYx3kP8ygshcwiBO0NW9m3UWfxYZ/i431beZfNAlhdGwn+iIZkQxSbho95GHqEbIvE+POBcxm46hjis7LT2j6B1xh2BHYvzriVJcQcxyJ2CE9sa4i1JCDpRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlcEPjK8Ca5MkZR390lVLeD6cQTAH0CTXgHAYgBtID0=;
 b=R49fZ12K7qJNq1OPmTMsNp3yV7DeevNXYYxhPVm7zoSZJzghQHCrWbbySujLfEuPSMpTOscpObW1t/EnBtrqYkVpncbuljC3j+ve51isfOIDJwBsmnc9AhHC6W5WLqTqdXBn0pWJgQDIV43Zm+it07R9YR1P5sJCtPBXst2ChJYdLF4/df2oBWDWBw4fOQIXP1MmVskm9hCwR0UvvDFEeJaZTJ2WW9wqMYwCZjrwVCiyd2A2fcFoYacir/LckehwczDEQvVDKKLKrgtZjRMa0Wq6ZsbPdukwMGHr5s7wQWustcFZw/yYaXyvVGQ65bJHOl/Zb411GDvpOKf+Kbzgbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.196) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=mail.sony.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=sony.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlcEPjK8Ca5MkZR390lVLeD6cQTAH0CTXgHAYgBtID0=;
 b=mIPqLgtVXfj/EZ48tkOsUrrqi0frgGV43j2jm4izR34oVIAn7QXKVSemcJAoGYESvfOqC5S6j1rbM32qX7VC4haekAv+OqF4Mikj+Jbyu6racKHC6kydiCphXaI2MeMuRfbR+PpCRS9GE9mnHRzOVWdETiC1OkalA83yXtN7+Cc=
Received: from DM6PR01CA0003.prod.exchangelabs.com (2603:10b6:5:296::8) by
 PH0PR13MB5568.namprd13.prod.outlook.com (2603:10b6:510:12b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Wed, 17 Jan
 2024 10:21:44 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::61) by DM6PR01CA0003.outlook.office365.com
 (2603:10b6:5:296::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Wed, 17 Jan 2024 10:21:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.196)
 smtp.mailfrom=mail.sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of mail.sony.com does not
 designate 121.100.38.196 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.196;
 helo=gepdcl07.sg.gdce.sony.com.sg;
Received: from gepdcl07.sg.gdce.sony.com.sg (121.100.38.196) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 10:21:42 +0000
Received: from gepdcl04.s.gdce.sony.com.sg (SGGDCSE1NS08.sony.com.sg [146.215.123.198])
	by gepdcl07.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 40HALPWP007416
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 17 Jan 2024 18:21:25 +0800
Received: from mail.sony.com ([43.88.80.246])
	by gepdcl04.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 40HAF09m007720;
	Wed, 17 Jan 2024 18:15:00 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id CE1DF20C0302; Wed, 17 Jan 2024 15:43:19 +0530 (IST)
From: Sreenath Vijayan <sreenath.vijayan@sony.com>
To: john.ogness@linutronix.de, corbet@lwn.net, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, rdunlap@infradead.org, pmladek@suse.com
Cc: rostedt@goodmis.org, senozhatsky@chromium.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        taichi.shimoyashiki@sony.com, daniel.palmer@sony.com,
        anandakumar.balasubramaniam@sony.com, sreenath.vijayan@sony.com
Subject: [PATCH v3 1/2] printk: Add function to dump printk buffer directly to consoles
Date: Wed, 17 Jan 2024 15:42:19 +0530
Message-ID: <402f0cbc3a573503c7cc794113aa5137ed7f276c.1705331453.git.sreenath.vijayan@sony.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705331453.git.sreenath.vijayan@sony.com>
References: <cover.1705331453.git.sreenath.vijayan@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|PH0PR13MB5568:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d998aa4a-c815-44dc-5434-08dc17461a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XicujhM4rs68CqLh6NTLjYjD5LqjspE3Geeou+n56Ejw7GSNBPKt1y0nefnsDEjKlqlqQIzQZot1bHwme2Nl/PNfoQm9lH7APY+9PZhiq1clo1VEH3OAJd0UYZ17ax78i6eu24Le1W5PrSBQyZCvW2RuT7HhiW/md7Xbw/b6ryzH5xiWpeCt86BYFpIMsQVqP/V5S5BDGGXBhLdahsRx6q60JhP3S2ANqF3pI6G5OPAtJSfipfb2ylqideeg3XzGVFEALVWk/0byOJHeS3O/XNJrlpvLwqppfRLNSHIRlBBHpzXvMTlKKJjjSobIYPKqAua2SrCbtRASogEiPabMGvZien75Upkod1UqIoKGmQ6GXAEpr9H70jKP+R6KatfNdMyE8aFhjMv1+tknItr3NOb27H34im9y/Y6wpNiPnfa8KUKwZGyM2/Xgje9KIEx7DkpRr9U67lHG/flekyRdYZbGVVmvxj7bcY0YqLWMaswgJmyzK88UiE3lfVP4WkwDGMEkfCf3aWSmtJC7wi5BLzXwg7+JKQ6G9aQBK5k2CNIs4H/lQhA+AVKC4EkEPLy+OxItdN64zvoMx1eHKqFaLE89BPDbKBU14NPYdN6hOFNlRkAdiO1ZOUwh3oCTvNp974LPoo4pkRXCKAi/UD1mqtYWZD1tsRJbMC9LQql4GSBH5KYuqt03s+at/435+zmtFpwVHPPO4/LVAQUEH90RCYSD2LlqFdFBhQhM/pv3tEfaAulY02bH4Jfd4LHM4Jxw
X-Forefront-Antispam-Report:
	CIP:121.100.38.196;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl07.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(46966006)(40470700004)(82960400001)(40460700003)(40480700001)(35950700001)(82740400003)(81166007)(83170400001)(356005)(70206006)(70586007)(450100002)(316002)(42186006)(41300700001)(4326008)(8676002)(8936002)(44832011)(6266002)(426003)(336012)(5660300002)(498600001)(2616005)(26005)(107886003)(2906002)(83380400001)(36756003)(47076005);DIR:OUT;SFP:1102;
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 10:21:42.7655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d998aa4a-c815-44dc-5434-08dc17461a74
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.196];Helo=[gepdcl07.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5568

It is useful to be able to dump the printk buffer directly to
consoles in some situations so as to not flood the buffer.
This needs access to private items of printk like PRINTK_MESSAGE_MAX.
Add function in printk.c to accomplish this.

Suggested-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>
Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
---
 include/linux/printk.h |  4 ++++
 kernel/printk/printk.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 8ef499ab3c1e..0896745f31e2 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -192,6 +192,7 @@ void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
+void dump_printk_buffer(void);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -271,6 +272,9 @@ static inline void dump_stack(void)
 static inline void printk_trigger_flush(void)
 {
 }
+static inline void dump_printk_buffer(void)
+{
+}
 #endif
 
 #ifdef CONFIG_SMP
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f2444b581e16..5b11fb377f8f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -4259,6 +4259,39 @@ void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
 }
 EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
 
+/**
+ * Dump the printk ring buffer directly to consoles
+ */
+void dump_printk_buffer(void)
+{
+	struct kmsg_dump_iter iter;
+	struct console *con;
+	char *buf;
+	size_t len;
+	int cookie;
+
+	buf = kmalloc(PRINTK_MESSAGE_MAX, GFP_KERNEL);
+	if (!buf)
+		return;
+
+	kmsg_dump_rewind(&iter);
+	while (kmsg_dump_get_line(&iter, 1, buf, PRINTK_MESSAGE_MAX, &len)) {
+		/*
+		 * Since using printk() or pr_*() will append the message to the
+		 * printk ring buffer, they cannot be used to display the retrieved
+		 * message. Hence console_write() of serial drivers is used.
+		 */
+		console_lock();
+		cookie = console_srcu_read_lock();
+		for_each_console_srcu(con) {
+			if ((console_srcu_read_flags(con) & CON_ENABLED) && con->write)
+				con->write(con, buf, len);
+		}
+		console_srcu_read_unlock(cookie);
+		console_unlock();
+	}
+	kfree(buf);
+}
 #endif
 
 #ifdef CONFIG_SMP
-- 
2.43.0


