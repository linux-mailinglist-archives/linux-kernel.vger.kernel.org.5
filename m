Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBEF751B98
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbjGMIcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbjGMIcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:32:23 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC456583
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:23:28 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1ngC5vnjzBJ7cn
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 16:23:19 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689236599; x=1691828600; bh=uN12RyxaD7WWwtjImqkjLYApFxa
        8ZNufYct7a3Q6rfM=; b=IdWWZ0tw4PBVMKLy8ZVff2ePG/HqMA6ppf3Un1qcdi9
        ZENSmnkzLsEAxYC+qk3y2Qh9/+Z+ZcuXjo76Q4fIRVAMRHutFM1KfDQHwA+IU6WJ
        3N904Ml/PBhqRWpnh8Xgw9jPE8sFikcd0sUixj6tHSuvgb3hF7izwdqaHYsAPBZ3
        GWG24oSotImiCLvISwajgevDGsl8raYl3UqjVc0mSIHrv7jW+YK9LkMPGvq4/W+d
        dcYH8e9aOve1s0n/57+3hSP1XgZwdpgLNycFllp5btSC4bUpwiSxVkBSWZ35jpAh
        t/Tj3/FseIQAz5WWrPyMJAB2KcRjVOFrBWzgdam8IgQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zk83XqG37r7e for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jul 2023 16:23:19 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1ngC3fhXzBHXgp;
        Thu, 13 Jul 2023 16:23:19 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 13 Jul 2023 16:23:19 +0800
From:   hanyu001@208suo.com
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH] hid:  replace snprintf in show functions with sysfs_emit
In-Reply-To: <tencent_97B2F127A27CDAB5DAB0733C81936AC6CA07@qq.com>
References: <tencent_97B2F127A27CDAB5DAB0733C81936AC6CA07@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <77492ea91d843d729a0e9194f01ad367@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the coccicheck warning:
WARNING: use scnprintf or sprintf.

./drivers/hid/hid-lenovo.c:786:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-lenovo.c:540:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-lenovo.c:905:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-lenovo.c:756:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-lenovo.c:816:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-lenovo.c:846:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-lenovo.c:584:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-lenovo.c:876:8-16: WARNING: use scnprintf or sprintf

Signed-off-by: ztt <1549089851@qq.com>
---
  drivers/hid/hid-lenovo.c | 16 ++++++++--------
  1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 44763c0da444..147fcf69d235 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -537,7 +537,7 @@ static ssize_t attr_fn_lock_show(struct device *dev,
      struct hid_device *hdev = to_hid_device(dev);
      struct lenovo_drvdata *data = hid_get_drvdata(hdev);

-    return snprintf(buf, PAGE_SIZE, "%u\n", data->fn_lock);
+    return scnprintf(buf, PAGE_SIZE, "%u\n", data->fn_lock);
  }

  static ssize_t attr_fn_lock_store(struct device *dev,
@@ -581,7 +581,7 @@ static ssize_t attr_sensitivity_show_cptkbd(struct 
device *dev,
      struct hid_device *hdev = to_hid_device(dev);
      struct lenovo_drvdata *cptkbd_data = hid_get_drvdata(hdev);

-    return snprintf(buf, PAGE_SIZE, "%u\n",
+    return scnprintf(buf, PAGE_SIZE, "%u\n",
          cptkbd_data->sensitivity);
  }

@@ -753,7 +753,7 @@ static ssize_t 
attr_press_to_select_show_tpkbd(struct device *dev,
      struct hid_device *hdev = to_hid_device(dev);
      struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);

-    return snprintf(buf, PAGE_SIZE, "%u\n", 
data_pointer->press_to_select);
+    return scnprintf(buf, PAGE_SIZE, "%u\n", 
data_pointer->press_to_select);
  }

  static ssize_t attr_press_to_select_store_tpkbd(struct device *dev,
@@ -783,7 +783,7 @@ static ssize_t attr_dragging_show_tpkbd(struct 
device *dev,
      struct hid_device *hdev = to_hid_device(dev);
      struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);

-    return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->dragging);
+    return scnprintf(buf, PAGE_SIZE, "%u\n", data_pointer->dragging);
  }

  static ssize_t attr_dragging_store_tpkbd(struct device *dev,
@@ -813,7 +813,7 @@ static ssize_t 
attr_release_to_select_show_tpkbd(struct device *dev,
      struct hid_device *hdev = to_hid_device(dev);
      struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);

-    return snprintf(buf, PAGE_SIZE, "%u\n", 
data_pointer->release_to_select);
+    return scnprintf(buf, PAGE_SIZE, "%u\n", 
data_pointer->release_to_select);
  }

  static ssize_t attr_release_to_select_store_tpkbd(struct device *dev,
@@ -843,7 +843,7 @@ static ssize_t attr_select_right_show_tpkbd(struct 
device *dev,
      struct hid_device *hdev = to_hid_device(dev);
      struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);

-    return snprintf(buf, PAGE_SIZE, "%u\n", 
data_pointer->select_right);
+    return scnprintf(buf, PAGE_SIZE, "%u\n", 
data_pointer->select_right);
  }

  static ssize_t attr_select_right_store_tpkbd(struct device *dev,
@@ -873,7 +873,7 @@ static ssize_t attr_sensitivity_show_tpkbd(struct 
device *dev,
      struct hid_device *hdev = to_hid_device(dev);
      struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);

-    return snprintf(buf, PAGE_SIZE, "%u\n",
+    return scnprintf(buf, PAGE_SIZE, "%u\n",
          data_pointer->sensitivity);
  }

@@ -902,7 +902,7 @@ static ssize_t attr_press_speed_show_tpkbd(struct 
device *dev,
      struct hid_device *hdev = to_hid_device(dev);
      struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);

-    return snprintf(buf, PAGE_SIZE, "%u\n",
+    return scnprintf(buf, PAGE_SIZE, "%u\n",
          data_pointer->press_speed);
  }
