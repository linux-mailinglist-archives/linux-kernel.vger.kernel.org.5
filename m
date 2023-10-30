Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69C97DC284
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 23:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjJ3WhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 18:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjJ3WhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 18:37:01 -0400
Received: from mail-ot1-x349.google.com (mail-ot1-x349.google.com [IPv6:2607:f8b0:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93591E8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 15:36:58 -0700 (PDT)
Received: by mail-ot1-x349.google.com with SMTP id 46e09a7af769-6ce2cce763eso7358670a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 15:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698705418; x=1699310218; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lq5TwK+3n6zGzzimtcAIoXXorjYRH73jd8dtvn3Ft6I=;
        b=RdGbf/NoSiOuyh5onpF3BZoHSI1vl0NLpmmOHSolZPmMOyhBJMYsa/7V1/FJsFBM6a
         lql4DnFNZwfUde9/4v3VWLSNAD3XIoUGjibURqVKFM2u+EKn2t4ZvISAK6ZZ1r4gHP10
         3ICQNxrFUryjHIRXZGo3qDdGf8cMXl3nPlp7uHtf4UUebbtkb+b+DWHaE47lPKJ+Tzlf
         5RK//2wmpeoRc27RQI/9CWni5Z6P7dB5DZc+GKN3kTlenRIujv+AVn6SqZPwYAsZ1mZj
         ZlivGFvUawiPOr/J1EYYTNrXJaH/cirIkhLvS1HynALB3m8Qt2Y5cIYA8UnMhJYdYafK
         q8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698705418; x=1699310218;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lq5TwK+3n6zGzzimtcAIoXXorjYRH73jd8dtvn3Ft6I=;
        b=U8z02NqQ8g6JP3rYBK1SwXzE45LqtSN3/WGq6x+uFDgmuazFx/tB+yLJhUEShoVsbc
         uVRb/fCb7jGvdwfiSNrMoaJI7xB+9hucMDMaQkjyrlqOEvUrgSnEDgrni1kWkZZfCxOV
         muPKmoKUKmhums0Pixqn+Qxe7Tsln38Vd06FNmg7T9O0qijKcoqimvs2Q0OXKZSXmxKX
         KGGUDeOWDeB679Ad5LC6vSTeoTKiozZu+t8iHSaUgqWz/igeWZrq4TN5qO+307P522ML
         oxA2HyHoKDw+gAYz1hHskgaUR28/rEWWxR1HEsCLN1o2XMh5QCv6Rw0cUjPiHn0XSvmi
         yA/Q==
X-Gm-Message-State: AOJu0YzuEdu3ifF7x4VM3T2MW1G5Vpl0Qa/+jU9hSmI+w2QZleS4kPQX
        P1aJDzZwczsN+zyCFHbsQk9es+iHklbkaHQE8A==
X-Google-Smtp-Source: AGHT+IH0vqfhJIEFVH7u9qgat5Uv0tRMPr607yPkkrPPdp+PXylCMaIkv+dU9D55BKCkNOTHg1rl2OPhrOkPq1RLGA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6830:4502:b0:6c4:58bd:290d with
 SMTP id i2-20020a056830450200b006c458bd290dmr222233otv.3.1698705417918; Mon,
 30 Oct 2023 15:36:57 -0700 (PDT)
Date:   Mon, 30 Oct 2023 22:36:57 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAgwQGUC/x3NQQqDQAxA0atI1g2MIxX0KiLFJhkNyCiJSIt49
 w5dvs3/F7iYikNfXWByquuWC+pHBbRMeRZULoYYYlOHJqAflmn/IpueYo5OrrjqOxEmekmmjQU XfE7cxi61LB1Bie0mST//0TDe9w/THRIxeAAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698705417; l=3578;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=ZF9U9vNqxuweLPAWDBaMtDMKK84GlPUqwF7Byf2+S7s=; b=F1b2huUJ/pDsyqCT80uhn3Zf7p1L3WobUXybolIxFi5AJ2jvthi3HulpjB6iOjb1ZfU9kv111
 QIVZJMEINgNAVdeMOm48S4aw+a0kgwvm8A0d34cYpiKqJhOyUf5Kp3i
X-Mailer: b4 0.12.3
Message-ID: <20231030-strncpy-drivers-scsi-libfc-fc_encode-h-v1-1-c08c2be6befa@google.com>
Subject: [PATCH] scsi: libfc: replace deprecated strncpy with memcpy
From:   Justin Stitt <justinstitt@google.com>
To:     Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated [1] and as such we should use different apis to
copy string data.

We can see that ct is NUL-initialized with fc_ct_hdr_fill:
|       ct = fc_ct_hdr_fill(fp, op, sizeof(struct fc_ns_rspn) + len,
...

In fc_ct_hdr_fill():
|       memset(ct, 0, ct_plen);

We also calculate the length of the source string:
|       len = strnlen(fc_host_symbolic_name(lport->host), 255);

then this argument is used in strncpy(), which is bad because the
pattern of (dest, src, strlen(src)) usually leaves the destination
buffer without NUL-termination. However, this seems to be correct in
this instance since fr_name is part of a seq_buf-like structure
monitoring the length:
|       struct fc_ns_rspn {
|       	struct fc_ns_fid fr_fid;	/* port ID object */
|       	__u8		fr_name_len;
|       	char		fr_name[];
|       } __attribute__((__packed__));

So, this is really just a byte copy into a length-bounded string. Let's
use memcpy() and mark the buffers as __nonstring.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/scsi/libfc/fc_encode.h | 8 ++++----
 include/uapi/scsi/fc/fc_ns.h   | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/libfc/fc_encode.h b/drivers/scsi/libfc/fc_encode.h
index 7dcac3b6baa7..ba8cc4ee650c 100644
--- a/drivers/scsi/libfc/fc_encode.h
+++ b/drivers/scsi/libfc/fc_encode.h
@@ -140,8 +140,8 @@ static inline int fc_ct_ns_fill(struct fc_lport *lport,
 		ct = fc_ct_hdr_fill(fp, op, sizeof(struct fc_ns_rspn) + len,
 				    FC_FST_DIR, FC_NS_SUBTYPE);
 		hton24(ct->payload.spn.fr_fid.fp_fid, lport->port_id);
-		strncpy(ct->payload.spn.fr_name,
-			fc_host_symbolic_name(lport->host), len);
+		memcpy(ct->payload.spn.fr_name,
+		       fc_host_symbolic_name(lport->host), len);
 		ct->payload.spn.fr_name_len = len;
 		break;
 
@@ -150,8 +150,8 @@ static inline int fc_ct_ns_fill(struct fc_lport *lport,
 		ct = fc_ct_hdr_fill(fp, op, sizeof(struct fc_ns_rsnn) + len,
 				    FC_FST_DIR, FC_NS_SUBTYPE);
 		put_unaligned_be64(lport->wwnn, &ct->payload.snn.fr_wwn);
-		strncpy(ct->payload.snn.fr_name,
-			fc_host_symbolic_name(lport->host), len);
+		memcpy(ct->payload.snn.fr_name,
+		       fc_host_symbolic_name(lport->host), len);
 		ct->payload.snn.fr_name_len = len;
 		break;
 
diff --git a/include/uapi/scsi/fc/fc_ns.h b/include/uapi/scsi/fc/fc_ns.h
index 4cf0a40a099a..8a6f6c6b5213 100644
--- a/include/uapi/scsi/fc/fc_ns.h
+++ b/include/uapi/scsi/fc/fc_ns.h
@@ -145,7 +145,7 @@ struct fc_gid_pn_resp {
  */
 struct fc_gspn_resp {
 	__u8	fp_name_len;
-	char	fp_name[];
+	char	fp_name[] __nonstring;
 };
 
 /*
@@ -171,7 +171,7 @@ struct fc_ns_rn_id {
 struct fc_ns_rsnn {
 	__be64		fr_wwn;		/* node name */
 	__u8		fr_name_len;
-	char		fr_name[];
+	char		fr_name[] __nonstring;
 } __attribute__((__packed__));
 
 /*
@@ -180,7 +180,7 @@ struct fc_ns_rsnn {
 struct fc_ns_rspn {
 	struct fc_ns_fid fr_fid;	/* port ID object */
 	__u8		fr_name_len;
-	char		fr_name[];
+	char		fr_name[] __nonstring;
 } __attribute__((__packed__));
 
 /*

---
base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
change-id: 20231030-strncpy-drivers-scsi-libfc-fc_encode-h-5ad629f6de9c

Best regards,
--
Justin Stitt <justinstitt@google.com>

