Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC375793C6B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbjIFMNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjIFMNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:13:51 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92E6E71;
        Wed,  6 Sep 2023 05:13:46 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6EC6C5C015B;
        Wed,  6 Sep 2023 08:13:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 06 Sep 2023 08:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1694002423; x=
        1694088823; bh=N3cJeLQw7pQnAUTk89rBSbRHo9lma2D5APRvEFvVHfI=; b=X
        3tYVRJ3FVyh9BLL09Utl4X7UiwS9lrjBJkUqsVHp3AN9A7QZNlgxWLqQCeYX2Dqt
        JhSFz9h3b3PIXrn/W+5wSwOXUIZ26DEhGg1Q10JBVs6w4g+F08kcK3XpSgVtyu87
        UcPavAp/q8+sD+d1CYPQw5/Zo9J3j4UmZhn0y2uzdW8Yeb3I5IlQKRt0rBfQ+KXO
        yasMJQkcSabJ/IJu1qnurkvCpa8U5SUyR5jqjIV8+/N7kNM0j1+eNQ0A8OoT6nMv
        DpJlRU3k9FjWQuyItJiSKG53DDGjX3S/M6OGwskc/xv3U92I6Bnehb+cxfgCNekC
        HVf7gaxMlKq0IiURmyEWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1694002423; x=
        1694088823; bh=N3cJeLQw7pQnAUTk89rBSbRHo9lma2D5APRvEFvVHfI=; b=q
        K6SrT7qXRY1W94S+zPZ9W53PHPG6hU/cg4Bi3ys4u7GngKoEtK4Akvcx73/faL8j
        J4w+M3/JwVXoSD9lH2S6L2JsrPf1fQuPg3d0CxQJSeOMvymnQ/z9KnXL0Tg2CgHf
        YJEgEipAWfqKw3VUi3usm0IbUsfTThmeJ/0fYoe4XF5hJhG+aX5M8wkv2M5iW+K/
        oC14cEuBHe6UX8lEdpDRxViZ8wbfyyExJ0mcE4RfOYlFq3B9AsWEMuojKDP4vr9o
        L1cVtiY51m+2pSzwQt+Cu8ytQ/lKvOwfxPfbZR0QYvdyUtxHla/75tabqSwgOdO/
        omgkCzjb0t+cXcvbMsRfA==
X-ME-Sender: <xms:92z4ZEE_9P6Ftnt2TEYXuhTIL8Gl0kIjqwdV8XzkrqUIcHkzK8NY2A>
    <xme:92z4ZNVwtfRhstGhXpDD3exnZyyCF0r5CdyS8WqVJ3hHyThCQ5g-ln8Xqr-AZP-yr
    uVqt3rqN_XTTtsZr9U>
X-ME-Received: <xmr:92z4ZOLAXOaXRovV6e4-ghAUHLK1IsG0tPCaQe9DDcmjTFtrEQU3kTBMuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehfedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrrhhkucfrvggrrhhs
    ohhnuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgeqnecuggftrf
    grthhtvghrnhepfedtvdejfeelffevhffgjeejheduteetieeguefgkefhhfegjeduueet
    hefgvdffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:92z4ZGGYBHzw-Ib2Z5DovWbvfBs6LGiCqoQVOJpGnfTM9BUi5Ow5AA>
    <xmx:92z4ZKXLi8I7MygCUE_d9EnJ5j2TyOfH-eJU8DPHPy7UN4mpT6u3Gw>
    <xmx:92z4ZJOPfsHVf9MY51HFsYwkgz-21xzBvqgUJcO9Oz3GiuSkPr2e9w>
    <xmx:92z4ZJQ0ZH8wiX5_CusaZ6-X4Mt-t_RgE0TYbUOpUPAgDy4457uKDw>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Sep 2023 08:13:42 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform/x86: think-lmi: Add bulk save feature
Date:   Wed,  6 Sep 2023 08:13:14 -0400
Message-ID: <20230906121328.50437-1-mpearson-lenovo@squebb.ca>
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
Changes in v2: Improve string handling in store and show functions. Use
sysfs_match_string for cleaner implementation.

 .../testing/sysfs-class-firmware-attributes   |  30 ++++
 drivers/platform/x86/think-lmi.c              | 152 ++++++++++++++++--
 drivers/platform/x86/think-lmi.h              |  15 ++
 3 files changed, 182 insertions(+), 15 deletions(-)

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
index 52d1ce8dfe44..a319a358ddcf 100644
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
@@ -1152,6 +1167,107 @@ static ssize_t pending_reboot_show(struct kobject *kobj, struct kobj_attribute *
 
 static struct kobj_attribute pending_reboot = __ATTR_RO(pending_reboot);
 
+static const char * const save_mode_strings[] = {
+	[TLMI_SAVE_SINGLE] = "single",
+	[TLMI_SAVE_BULK] = "bulk",
+	[TLMI_SAVE_SAVE] = "save"
+};
+
+static ssize_t save_settings_show(struct kobject *kobj, struct kobj_attribute *attr,
+				  char *buf)
+{
+	/* Check that setting is valid */
+	if (WARN_ON((tlmi_priv.save_mode < TLMI_SAVE_SINGLE) ||
+		    (tlmi_priv.save_mode > TLMI_SAVE_BULK)))
+		return -EIO;
+	return sprintf(buf, "%s\n", save_mode_strings[tlmi_priv.save_mode]);
+}
+
+static ssize_t save_settings_store(struct kobject *kobj, struct kobj_attribute *attr,
+				   const char *buf, size_t count)
+{
+	char *auth_str = NULL;
+	int ret = 0;
+	int cmd;
+
+	cmd = sysfs_match_string(save_mode_strings, buf);
+
+	/* Use lock in case multiple WMI operations needed */
+	mutex_lock(&tlmi_mutex);
+
+	switch (cmd) {
+	case TLMI_SAVE_SINGLE:
+	case TLMI_SAVE_BULK:
+		tlmi_priv.save_mode = cmd;
+		goto out;
+	case TLMI_SAVE_SAVE:
+		/* Check if supported*/
+		if ((!tlmi_priv.can_set_bios_settings) ||
+		    (tlmi_priv.save_mode == TLMI_SAVE_SINGLE)) {
+			ret = -EOPNOTSUPP;
+			goto out;
+		}
+		/* Check there is actually something to save */
+		if (!tlmi_priv.save_required) {
+			ret = -ENOENT;
+			goto out;
+		}
+		/* Check if certificate authentication is enabled and active */
+		if (tlmi_priv.certificate_support && tlmi_priv.pwd_admin->cert_installed) {
+			if (!tlmi_priv.pwd_admin->signature ||
+			    !tlmi_priv.pwd_admin->save_signature) {
+				ret = -EINVAL;
+				goto out;
+			}
+			ret = tlmi_simple_call(LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
+					       tlmi_priv.pwd_admin->save_signature);
+			if (ret)
+				goto out;
+		} else if (tlmi_priv.opcode_support) {
+			if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
+				ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
+							  tlmi_priv.pwd_admin->password);
+				if (ret)
+					goto out;
+			}
+			ret = tlmi_save_bios_settings("");
+		} else { /* old non-opcode based authentication method (deprecated) */
+			if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
+				auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
+						     tlmi_priv.pwd_admin->password,
+						     encoding_options[tlmi_priv.pwd_admin->encoding],
+						     tlmi_priv.pwd_admin->kbdlang);
+				if (!auth_str) {
+					ret = -ENOMEM;
+					goto out;
+				}
+			}
+
+			if (auth_str)
+				ret = tlmi_save_bios_settings(auth_str);
+			else
+				ret = tlmi_save_bios_settings("");
+		}
+		tlmi_priv.save_required = false;
+		tlmi_priv.reboot_required = true;
+
+		if (!ret && !tlmi_priv.pending_changes) {
+			tlmi_priv.pending_changes = true;
+			/* let userland know it may need to check reboot pending again */
+			kobject_uevent(&tlmi_priv.class_dev->kobj, KOBJ_CHANGE);
+		}
+		break;
+	default:
+		ret = -EINVAL;
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
@@ -1221,6 +1337,8 @@ static void tlmi_release_attr(void)
 		}
 	}
 	sysfs_remove_file(&tlmi_priv.attribute_kset->kobj, &pending_reboot.attr);
+	sysfs_remove_file(&tlmi_priv.attribute_kset->kobj, &save_settings.attr);
+
 	if (tlmi_priv.can_debug_cmd && debug_support)
 		sysfs_remove_file(&tlmi_priv.attribute_kset->kobj, &debug_cmd.attr);
 
@@ -1302,6 +1420,10 @@ static int tlmi_sysfs_init(void)
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
index 4daba6151cd6..b2e654bd8316 100644
--- a/drivers/platform/x86/think-lmi.h
+++ b/drivers/platform/x86/think-lmi.h
@@ -27,6 +27,18 @@ enum level_option {
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
+	TLMI_SAVE_SAVE,
+};
+
 /* password configuration details */
 struct tlmi_pwdcfg_core {
 	uint32_t password_mode;
@@ -86,6 +98,9 @@ struct think_lmi {
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

