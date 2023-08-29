Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F3E78C4F5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbjH2NPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbjH2NPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:15:50 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF45090;
        Tue, 29 Aug 2023 06:15:47 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 845D33200960;
        Tue, 29 Aug 2023 09:15:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 29 Aug 2023 09:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1693314946; x=
        1693401346; bh=7eE8kIWPw+PT41ZWWcbQ49teQsvDbEroy4Q2kUgeN18=; b=I
        Z0xBNJEDmRbsEkQ9dv8XIeJltm8/mdy8QoY9/iEx9VzlhJfkPd+AFqUaJWOz7Zgx
        BSQG9ounuyZO6ol+nHU2GZXmtagwBUDM9RarmkuESDKUV8A8Z4RWTT1VY2pSWnix
        F4Lu9qRCL6w52xJ/lJWnnbFoHaJmeu/+fV+8IMDLNlkTRXvzDw0d6ZspPR+Kpu83
        ALHoyf3EjgSWvxlMVH0Ro2AB9asksDEiNkgHM4+jHYXBHwdO/4aNasRqP/lll4l7
        TsRD5shR0H14xGvs1iVi6nBe4lVC3kl9iWCPfMotl9eXS6MvROa4dzdCtwrwXvc1
        BYPR3W9d0dp4boU+LBhVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1693314946; x=
        1693401346; bh=7eE8kIWPw+PT41ZWWcbQ49teQsvDbEroy4Q2kUgeN18=; b=J
        5z0iZs/dh94MrYFPI8B8y88qtZ8RmLGq6YtlDpvBN7MDCLdFySJgj3GKO0KVwcVX
        b+RQxLH0cRR1+OUJG7flrI3gH5Hh1Od2bTIuHE8D2enQ//unwnX7uxL4xvvmre/L
        CmyZ6pJKoRrMZqeoGfXNKVrWjaKgKVAsNpKRESjsgGqWRynOCAO9zWq5T9KkElv5
        Ieiod5CAhk237gp+3i+DmX3fEZOLH5Rv1BA/GSEi6gVUP11wkVx1WCsgoZO0Kmaj
        +Jxlmlsd1zPn6LNHY+L5mQyLvRVT7XiLAltf7Eoewn2OXubG3McCqh99w2uOxm/H
        XG6Jw9joq6OnT1gdU9p/w==
X-ME-Sender: <xms:ge_tZJ5fZYs18ZqhnMtIgXprOnYG9pvqKJbGizJO9FIIA9jncCNlzg>
    <xme:ge_tZG7Gr9_m4GT1doAiroA2bdICyo_MOKGkrUvWuP3mvq1XOghTO9S7Fy0QYeUgr
    3pi590R0YP14qRQrdU>
X-ME-Received: <xmr:ge_tZAep5nIR59bc3IW6pkUihx7gxDdZuv2AMC1ppk5B4-krCqCNUnISuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefiedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrrhhkucfrvggrrhhs
    ohhnuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgeqnecuggftrf
    grthhtvghrnhepfedtvdejfeelffevhffgjeejheduteetieeguefgkefhhfegjeduueet
    hefgvdffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:ge_tZCKuaVHHw6l8VQ69q1Nnz9ZwJVsUYYzjgVhFMjgQ4Dt5JATxrA>
    <xmx:ge_tZNJ0Ddz8Fv33dob6Xa4pv_zRL5O9KwqYQOfgSALaaxUKjnkZWQ>
    <xmx:ge_tZLwFLhdy3jTNn4_mS3tNUt706eqrWhftXuv04VrMMJys-JuboQ>
    <xmx:gu_tZN3mUhAv_SGYa0NxNqJFWnRJcKBaYIf4XTA2lDnfZyWLlXY6yg>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Aug 2023 09:15:45 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: think-lmi: Add bulk save feature
Date:   Tue, 29 Aug 2023 09:15:08 -0400
Message-ID: <20230829131523.17369-1-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Lenovo platforms there is a limitation in the number of times an
attribute can be saved. This is an architectural limitation and it limits
the number of attributes that can be modified to 48.
A solution for this is instead of the attribute being saved after every
modification allow a user to bulk set the attributes and then trigger a
final save. This allows unlimited attributes.

This patch introduces a save_settings attribute that can be configured to
either single or bulk mode by the user.
Single mode is the default but customers who want to avoid the 48
attribute limit can enable bulk mode.

Displaying the save_settings attribute will display the enabled mode.

When in bulk mode writing 'save' to the save_settings attribute will
trigger a save. Once this has been done a reboot is required before more
attributes can be modified.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
 .../testing/sysfs-class-firmware-attributes   |  30 ++++
 drivers/platform/x86/think-lmi.c              | 134 ++++++++++++++++--
 drivers/platform/x86/think-lmi.h              |  14 ++
 3 files changed, 163 insertions(+), 15 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
index f205d39409a3..c2f1a044475e 100644
--- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
+++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
@@ -383,6 +383,36 @@ Description:
 		Note that any changes to this attribute requires a reboot
 		for changes to take effect.
 
+What:		/sys/class/firmware-attributes/*/attributes/save_settings
+Date:		August 2023
+KernelVersion:	6.5
+Contact:	Mark Pearson <mpearson-lenovo@squebb.ca>
+Description:
+		On Lenovo platforms there is a limitation in the number of times an attribute can be
+		saved. This is an architectural limitation and it limits the number of attributes
+		that can be modified to 48.
+		A solution for this is instead of the attribute being saved after every modification,
+		to allow a user to bulk set the attributes, and then trigger a final save. This allows
+		unlimited attributes.
+
+		Read the attribute to check what save mode is enabled (single or bulk).
+		E.g:
+		# cat /sys/class/firmware-attributes/thinklmi/attributes/save_settings
+		single
+
+		Write the attribute with 'bulk' to enable bulk save mode.
+		Write the attribute with 'single' to enable saving, after every attribute set.
+		The default setting is single mode.
+		E.g:
+		# echo bulk > /sys/class/firmware-attributes/thinklmi/attributes/save_settings
+
+		When in bulk mode write 'save' to trigger a save of all currently modified attributes.
+		Note, once a save has been triggered, in bulk mode, attributes can no longer be set and
+		will return a permissions error. This is to prevent users hitting the 48+ save limitation
+		(which requires entering the BIOS to clear the error condition)
+		E.g:
+		# echo save > /sys/class/firmware-attributes/thinklmi/attributes/save_settings
+
 What:		/sys/class/firmware-attributes/*/attributes/debug_cmd
 Date:		July 2021
 KernelVersion:	5.14
diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 52d1ce8dfe44..87e8f06ee7c8 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -985,6 +985,13 @@ static ssize_t current_value_store(struct kobject *kobj,
 	if (!tlmi_priv.can_set_bios_settings)
 		return -EOPNOTSUPP;
 
+	/*
+	 * If we are using bulk saves a reboot should be done once save has
+	 * been called
+	 */
+	if (tlmi_priv.save_mode == TLMI_SAVE_BULK && tlmi_priv.reboot_required)
+		return -EPERM;
+
 	new_setting = kstrdup(buf, GFP_KERNEL);
 	if (!new_setting)
 		return -ENOMEM;
@@ -1011,10 +1018,11 @@ static ssize_t current_value_store(struct kobject *kobj,
 		ret = tlmi_simple_call(LENOVO_SET_BIOS_SETTING_CERT_GUID, set_str);
 		if (ret)
 			goto out;
-		ret = tlmi_simple_call(LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
-				tlmi_priv.pwd_admin->save_signature);
-		if (ret)
-			goto out;
+		if (tlmi_priv.save_mode == TLMI_SAVE_BULK)
+			tlmi_priv.save_required = true;
+		else
+			ret = tlmi_simple_call(LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
+					       tlmi_priv.pwd_admin->save_signature);
 	} else if (tlmi_priv.opcode_support) {
 		/*
 		 * If opcode support is present use that interface.
@@ -1033,14 +1041,17 @@ static ssize_t current_value_store(struct kobject *kobj,
 		if (ret)
 			goto out;
 
-		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
-			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
-						  tlmi_priv.pwd_admin->password);
-			if (ret)
-				goto out;
+		if (tlmi_priv.save_mode == TLMI_SAVE_BULK) {
+			tlmi_priv.save_required = true;
+		} else {
+			if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
+				ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
+							  tlmi_priv.pwd_admin->password);
+				if (ret)
+					goto out;
+			}
+			ret = tlmi_save_bios_settings("");
 		}
-
-		ret = tlmi_save_bios_settings("");
 	} else { /* old non-opcode based authentication method (deprecated) */
 		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
 			auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
@@ -1068,10 +1079,14 @@ static ssize_t current_value_store(struct kobject *kobj,
 		if (ret)
 			goto out;
 
-		if (auth_str)
-			ret = tlmi_save_bios_settings(auth_str);
-		else
-			ret = tlmi_save_bios_settings("");
+		if (tlmi_priv.save_mode == TLMI_SAVE_BULK) {
+			tlmi_priv.save_required = true;
+		} else {
+			if (auth_str)
+				ret = tlmi_save_bios_settings(auth_str);
+			else
+				ret = tlmi_save_bios_settings("");
+		}
 	}
 	if (!ret && !tlmi_priv.pending_changes) {
 		tlmi_priv.pending_changes = true;
@@ -1152,6 +1167,89 @@ static ssize_t pending_reboot_show(struct kobject *kobj, struct kobj_attribute *
 
 static struct kobj_attribute pending_reboot = __ATTR_RO(pending_reboot);
 
+static ssize_t save_settings_show(struct kobject *kobj, struct kobj_attribute *attr,
+				  char *buf)
+{
+	return sprintf(buf, "%s\n", tlmi_priv.save_mode == TLMI_SAVE_SINGLE ? "single" : "bulk");
+}
+
+static ssize_t save_settings_store(struct kobject *kobj, struct kobj_attribute *attr,
+				   const char *buf, size_t count)
+{
+	char *auth_str = NULL;
+	int ret;
+
+	/* Check if user is trying to change the save mode */
+	if (!strncmp(buf, "bulk", 4) || !strncmp(buf, "single", 6)) {
+		tlmi_priv.save_mode = strncmp(buf, "bulk", 4) ? TLMI_SAVE_SINGLE : TLMI_SAVE_BULK;
+		return count;
+	}
+	if (strncmp(buf, "save", 4))
+		return -EINVAL;
+
+	/* Otherwise assume the user is triggering a save - if supported*/
+	if (!tlmi_priv.can_set_bios_settings ||
+	    tlmi_priv.save_mode == TLMI_SAVE_SINGLE)
+		return -EOPNOTSUPP;
+
+	/* Check there is actually something to save */
+	if (!tlmi_priv.save_required)
+		return -ENOENT;
+
+	/* Use lock in case multiple WMI operations needed */
+	mutex_lock(&tlmi_mutex);
+
+	/* Check if certificate authentication is enabled and active */
+	if (tlmi_priv.certificate_support && tlmi_priv.pwd_admin->cert_installed) {
+		if (!tlmi_priv.pwd_admin->signature || !tlmi_priv.pwd_admin->save_signature) {
+			ret = -EINVAL;
+			goto out;
+		}
+		ret = tlmi_simple_call(LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
+				       tlmi_priv.pwd_admin->save_signature);
+		if (ret)
+			goto out;
+	} else if (tlmi_priv.opcode_support) {
+		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
+			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
+						  tlmi_priv.pwd_admin->password);
+			if (ret)
+				goto out;
+		}
+		ret = tlmi_save_bios_settings("");
+	} else { /* old non-opcode based authentication method (deprecated) */
+		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
+			auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
+					     tlmi_priv.pwd_admin->password,
+					     encoding_options[tlmi_priv.pwd_admin->encoding],
+					     tlmi_priv.pwd_admin->kbdlang);
+			if (!auth_str) {
+				ret = -ENOMEM;
+				goto out;
+			}
+		}
+
+		if (auth_str)
+			ret = tlmi_save_bios_settings(auth_str);
+		else
+			ret = tlmi_save_bios_settings("");
+	}
+	tlmi_priv.save_required = false;
+	tlmi_priv.reboot_required = true;
+
+	if (!ret && !tlmi_priv.pending_changes) {
+		tlmi_priv.pending_changes = true;
+		/* let userland know it may need to check reboot pending again */
+		kobject_uevent(&tlmi_priv.class_dev->kobj, KOBJ_CHANGE);
+	}
+out:
+	mutex_unlock(&tlmi_mutex);
+	kfree(auth_str);
+	return ret ?: count;
+}
+
+static struct kobj_attribute save_settings = __ATTR_RW(save_settings);
+
 /* ---- Debug interface--------------------------------------------------------- */
 static ssize_t debug_cmd_store(struct kobject *kobj, struct kobj_attribute *attr,
 				const char *buf, size_t count)
@@ -1221,6 +1319,8 @@ static void tlmi_release_attr(void)
 		}
 	}
 	sysfs_remove_file(&tlmi_priv.attribute_kset->kobj, &pending_reboot.attr);
+	sysfs_remove_file(&tlmi_priv.attribute_kset->kobj, &save_settings.attr);
+
 	if (tlmi_priv.can_debug_cmd && debug_support)
 		sysfs_remove_file(&tlmi_priv.attribute_kset->kobj, &debug_cmd.attr);
 
@@ -1302,6 +1402,10 @@ static int tlmi_sysfs_init(void)
 	if (ret)
 		goto fail_create_attr;
 
+	ret = sysfs_create_file(&tlmi_priv.attribute_kset->kobj, &save_settings.attr);
+	if (ret)
+		goto fail_create_attr;
+
 	if (tlmi_priv.can_debug_cmd && debug_support) {
 		ret = sysfs_create_file(&tlmi_priv.attribute_kset->kobj, &debug_cmd.attr);
 		if (ret)
diff --git a/drivers/platform/x86/think-lmi.h b/drivers/platform/x86/think-lmi.h
index 4daba6151cd6..0c6304f323ed 100644
--- a/drivers/platform/x86/think-lmi.h
+++ b/drivers/platform/x86/think-lmi.h
@@ -27,6 +27,17 @@ enum level_option {
 	TLMI_LEVEL_MASTER,
 };
 
+/* There are a limit on the number of WMI operations you can do if you use
+ * the default implementation of saving on every set. This is due to a
+ * limitation in EFI variable space used.
+ * Have a 'bulk save' mode where you can manually trigger the save, and can
+ * therefore set unlimited variables - for users that need it.
+ */
+enum save_mode {
+	TLMI_SAVE_SINGLE,
+	TLMI_SAVE_BULK,
+};
+
 /* password configuration details */
 struct tlmi_pwdcfg_core {
 	uint32_t password_mode;
@@ -86,6 +97,9 @@ struct think_lmi {
 	bool can_debug_cmd;
 	bool opcode_support;
 	bool certificate_support;
+	enum save_mode save_mode;
+	bool save_required;
+	bool reboot_required;
 
 	struct tlmi_attr_setting *setting[TLMI_SETTINGS_COUNT];
 	struct device *class_dev;
-- 
2.41.0

