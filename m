Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946EE7A02A1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbjINL2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238131AbjINL22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:28:28 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF70A26AF;
        Thu, 14 Sep 2023 04:28:19 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-401d10e3e54so8657895e9.2;
        Thu, 14 Sep 2023 04:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694690898; x=1695295698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fx1ykSpFu9dIp7uctLJ2W7kC537C+btiEUCxrJig4jM=;
        b=pRJwmaOHuwIXstszv8wBWr+I6WAVgtJnB08mlk6gmR74nz7QB00TsFZRdsFR8wRpye
         c6x62+SjTsmHHo0NsWU44d+LvF8s1rDvwiYNSDYOXNkwHfDG1FBEpJcEOOjz2PmVmHgl
         kZJhpbejCh/e9Ey2yFt2RSlgDvKsJROqcTVLgAZtd2DqJl63M79vY1R3QtGtZ2c7qg6P
         ToBFFpEXvpg7bNalpYikgibZnE6tx6bh0hpiIZWl3/CM31KStiJngd+y44xC/XW9g8ZZ
         R+EwG6TXUXMannYiww5XkjnCeZzzPJaqL+OPj8Cq3f4njrKrMY8qEAmnvT0Ug+9WNlTp
         +hIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694690898; x=1695295698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fx1ykSpFu9dIp7uctLJ2W7kC537C+btiEUCxrJig4jM=;
        b=Y6E2d6/OhgjvSeFKAknuEsGqHAIzTyhElL5xghJFke4VI1Ofk4baXVhqHc6N7paSdL
         3uOGsFuqOF1GpbxnwjFOLfcRSNuZTeZS/OP9gmsRRe8bS7KayaKC09BsJIfavonsefn1
         0VzCiuVKFi+e1IB32e6hZ8jAUpeI+zXqz0bmYYBVy0Vbh+NXoN2VUnUd50atNAhs35rK
         C7EHWRwzW0USvSouUm2wVEVgG0w6Y1I6ls+D7MWWGoCcKebUKWS8QdeW2MXMTlymWe5o
         3AYRPwDdptyPYrz9Ux2OpoTyCiy6XOZWadd2bzJjGsGF7JfhmCD0grlgQg0HuNwzZlJ1
         XOQw==
X-Gm-Message-State: AOJu0Yx4OHyKaM16kpW5y1dZCkP1KAnz3l3DTvnkf4hZy2YvdSRb9Wi7
        IwgI0YUjy2ACRZcrmd9eqi3ppP+YDcm8qg==
X-Google-Smtp-Source: AGHT+IEQOh5lxmGp4pXHlr8v0GkkAMiW6/zGENsZhUTnNY8ccZaz8Vdvmli7NmrTpSQ5k3qDiOhnjg==
X-Received: by 2002:a7b:c3cc:0:b0:3fe:1232:93fa with SMTP id t12-20020a7bc3cc000000b003fe123293famr4516324wmj.22.1694690897825;
        Thu, 14 Sep 2023 04:28:17 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
        by smtp.googlemail.com with ESMTPSA id l36-20020a05600c1d2400b003fef5402d2dsm4786764wms.8.2023.09.14.04.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:28:17 -0700 (PDT)
From:   "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Alessandro Carminati <alessandro.carminati@gmail.com>
Subject: [RFC PATCH 1/2] Modules: Introduce boot-time module signature flexibility
Date:   Thu, 14 Sep 2023 11:27:38 +0000
Message-Id: <20230914112739.112729-2-alessandro.carminati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914112739.112729-1-alessandro.carminati@gmail.com>
References: <20230914112739.112729-1-alessandro.carminati@gmail.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces a novel boot argument parameter that provides an
advanced level of control over the verification of module signatures
during the initial stages of booting. With this enhancement, we gain the
capability to postpone the verification of module signatures to after
intrd stage is finished.

Given that bootloader-provided artifacts are commonly employed
post-verification, we can effectively capitalize on this verification
process and exempt the verification of modules within the initrd.
This strategic adjustment reduces the time needed in this stage to load
modules by temporarily enabling unsigned modules.
Before terminating the stage modules signature check can be re-enabled
keeping the system security level.

To activate this functionality, a fresh boot argument parameter has
been incorporated to disable verification during early boot.
Furthermore, a supplementary method is necessary to reactivate
verification subsequently.

This is executed by leveraging a switch within a /proc file, inspired
by the foundational principles of the Lockdown LSM levels. While this
mechanism permits the activation of the functionaliity, and it ensures
that the switch remains unalterable once engaged.

example usage:
```
$ qemu-system-aarch64 -M virt -cpu cortex-a53 -machine gic-version=3 \
               -m 512 -nographic -smp 2 -kernel arch/arm64/boot/Image \
               -initrd aarch64br.initrd \
               -append "rootwait init=/sbin/init module_sig_check_wait=1"

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[...]
[    0.689441] Freeing unused kernel memory: 8576K
[    0.690536] Run /init as init process
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Saving 256 bits of non-creditable seed for next boot
Starting network: OK

Welcome to Buildroot
buildroot login: root
~ # cat /sys/module/module/parameters/sig_enforce
Y
~ # mount -t securityfs none  /sys/kernel/security
~ # cat /sys/kernel/security/module_sig_check_wait
1
~ # insmod usbserial.ko
~ # lsmod
Module                  Size  Used by    Not tainted
usbserial              36864  0
~ # rmmod usbserial
~ # echo 0 >/sys/kernel/security/module_sig_check_wait
[  226.114569] module_sig_check_wait disabled!
~ # insmod usbserial.ko
[  230.646980] Loading of unsigned module is rejected
[  230.648608] Loading of unsigned module is rejected
insmod: can't insert 'usbserial.ko': Key was rejected by service
~ # echo 1 > /sys/kernel/security/module_sig_check_wait
[  248.036518] module_sig_check_wait can be only disabled!
~ #
```

Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
---
 include/linux/module.h  |  4 +++
 kernel/module/main.c    | 14 ++++++-----
 kernel/module/signing.c | 56 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index a98e188cf37b..9899aeac43b0 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -34,6 +34,10 @@
 
 #define MODULE_NAME_LEN MAX_PARAM_PREFIX_LEN
 
+#ifdef CONFIG_MODULE_SIG
+extern int module_sig_check_wait;
+#endif
+
 struct modversion_info {
 	unsigned long crc;
 	char name[MODULE_NAME_LEN];
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 59b1d067e528..d24dd1f728f2 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2033,12 +2033,14 @@ static void module_augment_kernel_taints(struct module *mod, struct load_info *i
 		add_taint_module(mod, TAINT_TEST, LOCKDEP_STILL_OK);
 	}
 #ifdef CONFIG_MODULE_SIG
-	mod->sig_ok = info->sig_ok;
-	if (!mod->sig_ok) {
-		pr_notice_once("%s: module verification failed: signature "
-			       "and/or required key missing - tainting "
-			       "kernel\n", mod->name);
-		add_taint_module(mod, TAINT_UNSIGNED_MODULE, LOCKDEP_STILL_OK);
+	if (!module_sig_check_wait) {
+		mod->sig_ok = info->sig_ok;
+		if (!mod->sig_ok) {
+			pr_notice_once("%s: module verification failed: signature "
+				       "and/or required key missing - tainting "
+				       "kernel\n", mod->name);
+			add_taint_module(mod, TAINT_UNSIGNED_MODULE, LOCKDEP_STILL_OK);
+		}
 	}
 #endif
 
diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index a2ff4242e623..2580ceed3cdb 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -19,6 +19,8 @@
 #undef MODULE_PARAM_PREFIX
 #define MODULE_PARAM_PREFIX "module."
 
+int module_sig_check_wait;
+
 static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
 module_param(sig_enforce, bool_enable_only, 0644);
 
@@ -37,6 +39,58 @@ void set_module_sig_enforced(void)
 	sig_enforce = true;
 }
 
+/*
+ * test thing to enable sig enforcing later in boot sequence
+ */
+static int __init module_sig_check_wait_arg(char *str)
+{
+	return kstrtoint(str, 0, &module_sig_check_wait);
+}
+__setup("module_sig_check_wait=", module_sig_check_wait_arg);
+
+/*
+ * securityfs entry to disable module_sig_check_wait, and start enforcing modules signature check
+ */
+static ssize_t module_sig_check_wait_read(struct file *file, char __user *buf, size_t count,
+					  loff_t *ppos)
+{
+	return simple_read_from_buffer(buf, count, ppos,
+				       module_sig_check_wait == 1 ? "1\n" : "0\n", 2);
+}
+
+static ssize_t module_sig_check_wait_write(struct file *file, const char __user *buf,
+					   size_t n, loff_t *ppos)
+{
+	int tmp;
+
+	if (kstrtoint_from_user(buf, n, 10, &tmp))
+		return -EINVAL;
+	if (tmp != 0) {
+		pr_info("module_sig_check_wait can be only disabled!\n");
+		return -EINVAL;
+	}
+	pr_info("module_sig_check_wait disabled!\n");
+	module_sig_check_wait = tmp;
+
+	return n;
+}
+
+static const struct file_operations module_sig_check_wait_ops = {
+	.read  = module_sig_check_wait_read,
+	.write = module_sig_check_wait_write,
+};
+
+static int __init module_sig_check_wait_secfs_init(void)
+{
+	struct dentry *dentry;
+
+	dentry = securityfs_create_file("module_sig_check_wait", 0644, NULL, NULL,
+					&module_sig_check_wait_ops);
+	return PTR_ERR_OR_ZERO(dentry);
+}
+
+core_initcall(module_sig_check_wait_secfs_init);
+
 /*
  * Verify the signature on a module.
  */
@@ -69,6 +123,8 @@ int mod_verify_sig(const void *mod, struct load_info *info)
 
 int module_sig_check(struct load_info *info, int flags)
 {
+	if (module_sig_check_wait)
+		return 0;
 	int err = -ENODATA;
 	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
 	const char *reason;
-- 
2.34.1

