Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D265753485
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbjGNIDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjGNIC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:02:58 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8826146A1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:00:18 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2P6769RnzBR9sk
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 16:00:15 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689321615; x=1691913616; bh=cIypV3ylaOkFudI2ROs/gFUJ2Df
        bavphbp8apKPlbjI=; b=cAif3cvL90jRDkWqGRkM37JvGoI3OuGoBbLGZ9q+MH8
        R7yzTwhhlFup2wiwXko5vEV9+pY7U9YFwCm5fi4RInYeHKotM6ThGKwqk/U8TPvf
        iHwvPCVpb/OTCGk88u/6zRQThdXZNCTM2C4vdPoS4VJs+c5TGpVE6hCQvhE2OktR
        UqzleW0LPfHaf5mKaa7baqbt/6lgX3vma6hQy1v0DsuuZvhdN2XQdH0233sgHdbs
        iD4ycKqJL0yboqJaR2cm9yafZfQ/RVfPrtKAYYHwRqa5DaM8FDFwdJRlSj+qma58
        3yxvFghlSVr4Rz+AGTbvWLaQmT1LyJA46ID9EWEIJ8Q==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qYXL1LVgl8Bn for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 16:00:15 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2P6745H9zBR9sg;
        Fri, 14 Jul 2023 16:00:15 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 16:00:15 +0800
From:   hanyu001@208suo.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH] scsi: fcoe: convert snprintf to sysfs_emit
In-Reply-To: <tencent_B92BA21DDAA55A94730701A8EAB44A877107@qq.com>
References: <tencent_B92BA21DDAA55A94730701A8EAB44A877107@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <38822ed80288fd808c17dc5a962895b1@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
drivers/gpu/drm/i915//i915_sysfs.c:266:8-16:
WARNING: use scnprintf or sprintf
drivers/gpu/drm/i915//i915_sysfs.c:285:8-16:
WARNING: use scnprintf or sprintf
drivers/gpu/drm/i915//i915_sysfs.c:276:8-16:
WARNING: use scnprintf or sprintf
drivers/gpu/drm/i915//i915_sysfs.c:335:8-16:
WARNING: use scnprintf or sprintf
drivers/gpu/drm/i915//i915_sysfs.c:390:8-16:
WARNING: use scnprintf or sprintf
drivers/gpu/drm/i915//i915_sysfs.c:465:8-16:
WARNING: use scnprintf or sprintf
drivers/gpu/drm/i915//i915_sysfs.c:107:8-16:
WARNING: use scnprintf or sprintf
drivers/gpu/drm/i915//i915_sysfs.c:75:8-16:
WARNING: use scnprintf or sprintf
drivers/gpu/drm/i915//i915_sysfs.c:83:8-16:
WARNING: use scnprintf or sprintf
drivers/gpu/drm/i915//i915_sysfs.c:91:8-16:
WARNING: use scnprintf or sprintf
drivers/gpu/drm/i915//i915_sysfs.c:99:8-16:
WARNING: use scnprintf or sprintf
drivers/gpu/drm/i915//i915_sysfs.c:326:8-16:
WARNING: use scnprintf or sprintf

./drivers/scsi/fcoe/fcoe_sysfs.c:376:8-16: WARNING: use scnprintf or 
sprintf
./drivers/scsi/fcoe/fcoe_sysfs.c:268:8-16: WARNING: use scnprintf or 
sprintf
./drivers/scsi/fcoe/fcoe_sysfs.c:253:8-16: WARNING: use scnprintf or 
sprintf

Signed-off-by: ztt <1549089851@qq.com>
---
  drivers/scsi/fcoe/fcoe_sysfs.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_sysfs.c 
b/drivers/scsi/fcoe/fcoe_sysfs.c
index e17957f8085c..434ef662cfd4 100644
--- a/drivers/scsi/fcoe/fcoe_sysfs.c
+++ b/drivers/scsi/fcoe/fcoe_sysfs.c
@@ -250,7 +250,7 @@ static ssize_t show_fcf_state(struct device *dev,
      name = get_fcoe_fcf_state_name(fcf->state);
      if (!name)
          return -EINVAL;
-    return snprintf(buf, FCOE_FCF_STATE_MAX_NAMELEN, "%s\n", name);
+    return scnprintf(buf, FCOE_FCF_STATE_MAX_NAMELEN, "%s\n", name);
  }
  static FCOE_DEVICE_ATTR(fcf, state, S_IRUGO, show_fcf_state, NULL);

@@ -265,7 +265,7 @@ static ssize_t show_ctlr_mode(struct device *dev,
      name = get_fcoe_ctlr_mode_name(ctlr->mode);
      if (!name)
          return -EINVAL;
-    return snprintf(buf, FCOE_MAX_MODENAME_LEN,
+    return scnprintf(buf, FCOE_MAX_MODENAME_LEN,
              "%s\n", name);
  }

@@ -373,7 +373,7 @@ static ssize_t show_ctlr_enabled_state(struct device 
*dev,
      name = get_fcoe_ctlr_enabled_state_name(ctlr->enabled);
      if (!name)
          return -EINVAL;
-    return snprintf(buf, FCOE_CTLR_ENABLED_MAX_NAMELEN,
+    return scnprintf(buf, FCOE_CTLR_ENABLED_MAX_NAMELEN,
              "%s\n", name);
  }
