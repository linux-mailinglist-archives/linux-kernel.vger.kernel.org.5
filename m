Return-Path: <linux-kernel+bounces-93747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBC3873417
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A163F1F2B21E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8965FDA6;
	Wed,  6 Mar 2024 10:25:04 +0000 (UTC)
Received: from out0-201.mail.aliyun.com (out0-201.mail.aliyun.com [140.205.0.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AE85F869
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720703; cv=none; b=LifL11mIb+EAN0wil2QfnZsPOT4Eyb78cyExCOo8WVGqaFkgsjEHPBlhXIbnMc1i0m/GXlZftE3Osi+9lXoiSuZenZg2xc4glpEG02dwAUnteP+DBhIBLjaEQgppTaxC8jowHXrfifzYDC3SfFBL+iVnaWKU0+q7jOhvly5sg54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720703; c=relaxed/simple;
	bh=AXpywqvycgeH2lxm2ANI1OyzNC9k0kJVnejMe1p/+ZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y7cr2pH1IcgetUBO4ea8S1FUVl4+qESK7bme9OtbQviq9vA8OkW6hxo0E0yt7HU1il1wJroBdeOMZcKtn5ooiKQUS/RoqNII6Zd7jjnddqD463X5MF85RVR70itf/9wQkOUTaLt0wbKNsATITTksPs5xGltVaANOyZPH9pBM8jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; arc=none smtp.client-ip=140.205.0.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047187;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---.Wgbn-JT_1709720381;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Wgbn-JT_1709720381)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 18:19:41 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <jani.nikula@intel.com>,
   <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
   <intel-xe@lists.freedesktop.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v3 1/9] um: Make local functions and variables static
Date: Wed, 06 Mar 2024 18:19:17 +0800
Message-Id: <20240306101925.1088870-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
References: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This will also fix the warnings like:

warning: no previous prototype for ‘fork_handler’ [-Wmissing-prototypes]
  140 | void fork_handler(void)
      |      ^~~~~~~~~~~~

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/pcap_kern.c              | 4 ++--
 arch/um/drivers/ubd_user.c               | 2 +-
 arch/um/kernel/kmsg_dump.c               | 2 +-
 arch/um/kernel/process.c                 | 8 ++++----
 arch/um/kernel/time.c                    | 6 +++---
 arch/um/os-Linux/drivers/ethertap_kern.c | 2 +-
 arch/um/os-Linux/drivers/tuntap_kern.c   | 2 +-
 arch/um/os-Linux/signal.c                | 4 ++--
 arch/x86/um/os-Linux/registers.c         | 2 +-
 arch/x86/um/tls_32.c                     | 2 +-
 10 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/um/drivers/pcap_kern.c b/arch/um/drivers/pcap_kern.c
index 25ee2c97ca21..d9bf95d7867b 100644
--- a/arch/um/drivers/pcap_kern.c
+++ b/arch/um/drivers/pcap_kern.c
@@ -15,7 +15,7 @@ struct pcap_init {
 	char *filter;
 };
 
-void pcap_init_kern(struct net_device *dev, void *data)
+static void pcap_init_kern(struct net_device *dev, void *data)
 {
 	struct uml_net_private *pri;
 	struct pcap_data *ppri;
@@ -50,7 +50,7 @@ static const struct net_kern_info pcap_kern_info = {
 	.write			= pcap_write,
 };
 
-int pcap_setup(char *str, char **mac_out, void *data)
+static int pcap_setup(char *str, char **mac_out, void *data)
 {
 	struct pcap_init *init = data;
 	char *remain, *host_if = NULL, *options[2] = { NULL, NULL };
diff --git a/arch/um/drivers/ubd_user.c b/arch/um/drivers/ubd_user.c
index a1afe414ce48..b4f8b8e60564 100644
--- a/arch/um/drivers/ubd_user.c
+++ b/arch/um/drivers/ubd_user.c
@@ -23,7 +23,7 @@
 #include <os.h>
 #include <poll.h>
 
-struct pollfd kernel_pollfd;
+static struct pollfd kernel_pollfd;
 
 int start_io_thread(unsigned long sp, int *fd_out)
 {
diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index 427dd5a61a38..4382cf02a6d1 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -57,7 +57,7 @@ static struct kmsg_dumper kmsg_dumper = {
 	.dump = kmsg_dumper_stdout
 };
 
-int __init kmsg_dumper_stdout_init(void)
+static int __init kmsg_dumper_stdout_init(void)
 {
 	return kmsg_dump_register(&kmsg_dumper);
 }
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index ab95648e93e1..20f3813143d8 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -137,7 +137,7 @@ void new_thread_handler(void)
 }
 
 /* Called magically, see new_thread_handler above */
-void fork_handler(void)
+static void fork_handler(void)
 {
 	force_flush_all();
 
@@ -268,14 +268,14 @@ int clear_user_proc(void __user *buf, int size)
 static atomic_t using_sysemu = ATOMIC_INIT(0);
 int sysemu_supported;
 
-void set_using_sysemu(int value)
+static void set_using_sysemu(int value)
 {
 	if (value > sysemu_supported)
 		return;
 	atomic_set(&using_sysemu, value);
 }
 
-int get_using_sysemu(void)
+static int get_using_sysemu(void)
 {
 	return atomic_read(&using_sysemu);
 }
@@ -313,7 +313,7 @@ static const struct proc_ops sysemu_proc_ops = {
 	.proc_write	= sysemu_proc_write,
 };
 
-int __init make_proc_sysemu(void)
+static int __init make_proc_sysemu(void)
 {
 	struct proc_dir_entry *ent;
 	if (!sysemu_supported)
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 3e270da6b6f6..efa5b9c97992 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -319,7 +319,7 @@ void time_travel_add_event_rel(struct time_travel_event *e,
 	time_travel_add_event(e, time_travel_time + delay_ns);
 }
 
-void time_travel_periodic_timer(struct time_travel_event *e)
+static void time_travel_periodic_timer(struct time_travel_event *e)
 {
 	time_travel_add_event(&time_travel_timer_event,
 			      time_travel_time + time_travel_timer_interval);
@@ -812,7 +812,7 @@ unsigned long calibrate_delay_is_known(void)
 	return 0;
 }
 
-int setup_time_travel(char *str)
+static int setup_time_travel(char *str)
 {
 	if (strcmp(str, "=inf-cpu") == 0) {
 		time_travel_mode = TT_MODE_INFCPU;
@@ -862,7 +862,7 @@ __uml_help(setup_time_travel,
 "devices using it, assuming the device has the right capabilities.\n"
 "The optional ID is a 64-bit integer that's sent to the central scheduler.\n");
 
-int setup_time_travel_start(char *str)
+static int setup_time_travel_start(char *str)
 {
 	int err;
 
diff --git a/arch/um/os-Linux/drivers/ethertap_kern.c b/arch/um/os-Linux/drivers/ethertap_kern.c
index 3182e759d8de..5e5ee40680ce 100644
--- a/arch/um/os-Linux/drivers/ethertap_kern.c
+++ b/arch/um/os-Linux/drivers/ethertap_kern.c
@@ -63,7 +63,7 @@ const struct net_kern_info ethertap_kern_info = {
 	.write 			= etap_write,
 };
 
-int ethertap_setup(char *str, char **mac_out, void *data)
+static int ethertap_setup(char *str, char **mac_out, void *data)
 {
 	struct ethertap_init *init = data;
 
diff --git a/arch/um/os-Linux/drivers/tuntap_kern.c b/arch/um/os-Linux/drivers/tuntap_kern.c
index adcb6717be6f..ff022d9cf0dd 100644
--- a/arch/um/os-Linux/drivers/tuntap_kern.c
+++ b/arch/um/os-Linux/drivers/tuntap_kern.c
@@ -53,7 +53,7 @@ const struct net_kern_info tuntap_kern_info = {
 	.write 			= tuntap_write,
 };
 
-int tuntap_setup(char *str, char **mac_out, void *data)
+static int tuntap_setup(char *str, char **mac_out, void *data)
 {
 	struct tuntap_init *init = data;
 
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 24a403a70a02..787cfb9a0308 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -72,7 +72,7 @@ static int signals_blocked;
 static unsigned int signals_pending;
 static unsigned int signals_active = 0;
 
-void sig_handler(int sig, struct siginfo *si, mcontext_t *mc)
+static void sig_handler(int sig, struct siginfo *si, mcontext_t *mc)
 {
 	int enabled = signals_enabled;
 
@@ -108,7 +108,7 @@ static void timer_real_alarm_handler(mcontext_t *mc)
 	timer_handler(SIGALRM, NULL, &regs);
 }
 
-void timer_alarm_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
+static void timer_alarm_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
 {
 	int enabled;
 
diff --git a/arch/x86/um/os-Linux/registers.c b/arch/x86/um/os-Linux/registers.c
index df8f4b4bf98b..f3638dd09cec 100644
--- a/arch/x86/um/os-Linux/registers.c
+++ b/arch/x86/um/os-Linux/registers.c
@@ -17,7 +17,7 @@
 #include <linux/elf.h>
 #include <registers.h>
 
-int have_xstate_support;
+static int have_xstate_support;
 
 int save_i387_registers(int pid, unsigned long *fp_regs)
 {
diff --git a/arch/x86/um/tls_32.c b/arch/x86/um/tls_32.c
index 66162eafd8e8..ba40b1b8e179 100644
--- a/arch/x86/um/tls_32.c
+++ b/arch/x86/um/tls_32.c
@@ -20,7 +20,7 @@
 static int host_supports_tls = -1;
 int host_gdt_entry_tls_min;
 
-int do_set_thread_area(struct user_desc *info)
+static int do_set_thread_area(struct user_desc *info)
 {
 	int ret;
 	u32 cpu;
-- 
2.34.1


