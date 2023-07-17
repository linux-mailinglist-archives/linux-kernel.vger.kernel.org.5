Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B268A7559BA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 04:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjGQCng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 22:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjGQCnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 22:43:33 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617DA1AA
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 19:43:32 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R45xF3bP8zBHXhP
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:43:29 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689561809; x=1692153810; bh=8oMZ+otZGtpxPoGmYftdv6tFkbY
        KdXGCIpVvN7dDlI0=; b=CjXLTRK3Co5+ym6E6DAcAT/X3Kv945I3xO5gCSWhRmn
        YC1VVy8EPUICvjh7AhQQpbrmovjnu2cfGaof6dIDDCieY0VLSfGOU83vbdvEDuoZ
        bHOa4yRIckF93zEvLKRQpXqNxydX7HHGY7v4vOD9pTmF6iRlDZ5d586sZFJHscoR
        9hKVzScVoYbs6gLpw7+sEbWBqCuaLwydH2kFjYP/jjCgSKxV1ln7oWbs0ZdhECDC
        rIdULuaOW0kOWwdpWyRKaSuHv8HuwvpJ/XWyk8Z4ZUW1ojQISGUQrp++IFQzJd8T
        fKI0kk7aoJIaJGF2pjNQA7eQY3DLO5QWFZ98pYMEQ5A==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9WPAw_rhmP41 for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 10:43:29 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R45xF1yypzBHXR9;
        Mon, 17 Jul 2023 10:43:29 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 10:43:29 +0800
From:   hanyu001@208suo.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH] scsi: Convert snprintf to scnprintf
In-Reply-To: <tencent_D9472259DA98DAF6732781816A8DCAACF107@qq.com>
References: <tencent_D9472259DA98DAF6732781816A8DCAACF107@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <ea61679e4269f6f063e3969a1fac3ba6@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the coccicheck warnings:

./drivers/scsi/scsi_transport_fc.c:1967:9-17: WARNING: use scnprintf or 
sprintf
./drivers/scsi/scsi_transport_fc.c:1891:9-17: WARNING: use scnprintf or 
sprintf
./drivers/scsi/scsi_transport_fc.c:1915:9-17: WARNING: use scnprintf or 
sprintf
./drivers/scsi/scsi_transport_fc.c:2000:8-16: WARNING: use scnprintf or 
sprintf
./drivers/scsi/scsi_transport_fc.c:1304:9-17: WARNING: use scnprintf or 
sprintf
./drivers/scsi/scsi_transport_fc.c:1286:8-16: WARNING: use scnprintf or 
sprintf
./drivers/scsi/scsi_transport_fc.c:1218:10-18: WARNING: use scnprintf or 
sprintf
./drivers/scsi/scsi_transport_fc.c:1123:9-17: WARNING: use scnprintf or 
sprintf
./drivers/scsi/scsi_transport_fc.c:1665:9-17: WARNING: use scnprintf or 
sprintf

Signed-off-by: ztt <1549089851@qq.com>
---
  drivers/scsi/scsi_transport_fc.c | 18 +++++++++---------
  1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/scsi_transport_fc.c 
b/drivers/scsi/scsi_transport_fc.c
index 64ff2629eaf9..493bcfd0b5e1 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -1120,7 +1120,7 @@ show_fc_rport_supported_classes (struct device 
*dev,
  {
      struct fc_rport *rport = transport_class_to_rport(dev);
      if (rport->supported_classes == FC_COS_UNSPECIFIED)
-        return snprintf(buf, 20, "unspecified\n");
+        return scnprintf(buf, 20, "unspecified\n");
      return get_fc_cos_names(rport->supported_classes, buf);
  }
  static FC_DEVICE_ATTR(rport, supported_classes, S_IRUGO,
@@ -1215,7 +1215,7 @@ show_fc_rport_roles (struct device *dev, struct 
device_attribute *attr,
                      FC_WELLKNOWN_PORTID_MASK) {
          switch (rport->port_id & FC_WELLKNOWN_ROLE_MASK) {
          case FC_FPORT_PORTID:
-            return snprintf(buf, 30, "Fabric Port\n");
+            return scnprintf(buf, 30, "Fabric Port\n");
          case FC_FABCTLR_PORTID:
              return snprintf(buf, 30, "Fabric Controller\n");
          case FC_DIRSRVR_PORTID:
@@ -1283,7 +1283,7 @@ show_fc_rport_port_state(struct device *dev,
      if (!name)
          return -EINVAL;

-    return snprintf(buf, 20, "%s\n", name);
+    return scnprintf(buf, 20, "%s\n", name);
  }

  static FC_DEVICE_ATTR(rport, port_state, 0444 | 0200,
@@ -1301,7 +1301,7 @@ show_fc_rport_fast_io_fail_tmo (struct device 
*dev,
      struct fc_rport *rport = transport_class_to_rport(dev);

      if (rport->fast_io_fail_tmo == -1)
-        return snprintf(buf, 5, "off\n");
+        return scnprintf(buf, 5, "off\n");
      return snprintf(buf, 20, "%d\n", rport->fast_io_fail_tmo);
  }

@@ -1662,7 +1662,7 @@ show_fc_vport_roles (struct device *dev, struct 
device_attribute *attr,
      struct fc_vport *vport = transport_class_to_vport(dev);

      if (vport->roles == FC_PORT_ROLE_UNKNOWN)
-        return snprintf(buf, 20, "unknown\n");
+        return scnprintf(buf, 20, "unknown\n");
      return get_fc_port_roles_names(vport->roles, buf);
  }
  static FC_DEVICE_ATTR(vport, roles, S_IRUGO, show_fc_vport_roles, 
NULL);
@@ -1888,7 +1888,7 @@ show_fc_host_supported_classes (struct device 
*dev,
      struct Scsi_Host *shost = transport_class_to_shost(dev);

      if (fc_host_supported_classes(shost) == FC_COS_UNSPECIFIED)
-        return snprintf(buf, 20, "unspecified\n");
+        return scnprintf(buf, 20, "unspecified\n");

      return get_fc_cos_names(fc_host_supported_classes(shost), buf);
  }
@@ -1912,7 +1912,7 @@ show_fc_host_supported_speeds (struct device *dev,
      struct Scsi_Host *shost = transport_class_to_shost(dev);

      if (fc_host_supported_speeds(shost) == FC_PORTSPEED_UNKNOWN)
-        return snprintf(buf, 20, "unknown\n");
+        return scnprintf(buf, 20, "unknown\n");

      return get_fc_port_speed_names(fc_host_supported_speeds(shost), 
buf);
  }
@@ -1964,7 +1964,7 @@ show_fc_host_speed (struct device *dev,
          i->f->get_host_speed(shost);

      if (fc_host_speed(shost) == FC_PORTSPEED_UNKNOWN)
-        return snprintf(buf, 20, "unknown\n");
+        return scnprintf(buf, 20, "unknown\n");

      return get_fc_port_speed_names(fc_host_speed(shost), buf);
  }
@@ -1997,7 +1997,7 @@ show_fc_private_host_tgtid_bind_type(struct device 
*dev,
      name = get_fc_tgtid_bind_type_name(fc_host_tgtid_bind_type(shost));
      if (!name)
          return -EINVAL;
-    return snprintf(buf, FC_BINDTYPE_MAX_NAMELEN, "%s\n", name);
+    return scnprintf(buf, FC_BINDTYPE_MAX_NAMELEN, "%s\n", name);
  }

  #define get_list_head_entry(pos, head, member)         \
