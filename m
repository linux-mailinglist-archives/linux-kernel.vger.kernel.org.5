Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980007D3EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjJWSMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjJWSMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:12:34 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6E3D6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 11:12:32 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7b10c488cso45051307b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 11:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698084752; x=1698689552; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qwS6ouQjPXWDmE5P6viXZdCgm6mkNLj5gTUqMttI1Y4=;
        b=Adi5lAvZAE7ig7zrujT3lNJOLIpxchQed7flxGpk+0/WVoGDHf0yC12EvT8iGmgMUq
         uAPjh0tkS1sZA3u9/5XCB1co1Sdn8cclvrm9AE3PFMXUWwvicCk26/xzF7HXCGcvsW9X
         OGG71Ns2x/uYDjtth4zHgAoFdfTBz04m3m7qMuJxywx7wi9aP+m+rfxq1ry0f8gs14SP
         L/EMp6MKJUqVo5bomDlQmh5NR0rMlubznixkakAbIPb+zl6OU8ke9gf+LHTvSpdAVRcu
         qUJ7j4de68h7MaKqz+RHldFEPPZZEQGVFtMiqEIIydjgRrfMh7mN1qChA/ixENv9dbpw
         CHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698084752; x=1698689552;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qwS6ouQjPXWDmE5P6viXZdCgm6mkNLj5gTUqMttI1Y4=;
        b=BSwIbkW3nwMLPrHmOMD+Yx8U/sYy9euVTfRRduXVfLmdLT7yTtw8LJBq7rQIRpqQ1v
         Fb3KgMpOLBAY8aT4jSOtKNZOrHUSc/lMjnF8CfCrFqUWBMEHju1x6ZoW/It3p05jMT5M
         wQHDGhOzi5UhQzbDGPIRRcC+NMQ0Kaqs/Uv4pXfMzUH9E+yIHVNtfMpAE7RclmghgXiB
         Q/gqcAB+FovixvT75E77cpG+BQYGJ51lNn3ldB6ghDbhxzcOR4jXgmV4OUPMeyxpYL3e
         6/DWvOJBgoJeDcyyPksGezVzY+7WbjSZs72Vc28ePWmVF8zqkutrTkeDKsPdLO2O379s
         s/EQ==
X-Gm-Message-State: AOJu0YwHVMdYQImbFnlDyUHKkelMhH3zaPh6rdA2eZQNGukTUfDDu9NU
        Wwt4IhCANrf8hQHbK3jtnPpCMCKE6TqIIyVerQ==
X-Google-Smtp-Source: AGHT+IH9j1Cv+kwDdU7FgeZN5Wos1b3Cm2atxCSiXLG/t3KumY5JzFlOjMOH2W6Ivr4HTyriL/EA2H0K2FFTy0PU/g==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:4ecf:0:b0:5a8:28be:bf86 with SMTP
 id c198-20020a814ecf000000b005a828bebf86mr208457ywb.5.1698084752050; Mon, 23
 Oct 2023 11:12:32 -0700 (PDT)
Date:   Mon, 23 Oct 2023 18:12:28 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIu3NmUC/43NQQ6CMBCF4auQrh3TVkzAlfcwhNB2hEmUkhlsJ
 IS7W0ncu/zf4n2rEmRCUZdiVYyJhOKYwx4K5Ydu7BEo5FZW25PRVoPMPPppgcCUkAV4ekoPiXi
 m2O7RupeAh+A6cw6uxKrWKt9NjHd679StyT2QzJGXXU7mu/4Q8z+SDBioOudqU3uHtrz2MfYPP Pr4VM22bR+LaEc44QAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698084751; l=4380;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=uxFJFrgndnGhuJLwG5frR0Qr2jirCUbgI5LoxWmqOws=; b=jNFOf966tCsvUuHyU/MIBTXbl3z+Kcy+EGf0QsL9k/KBIYEub7+MVP4EUasN0VTkfXcYjmx5b
 pzGUMZGKY5vAkF48W7C5+fenvpx/deT714CI3sUvJvdtuWIwrLJZ+fn
X-Mailer: b4 0.12.3
Message-ID: <20231023-strncpy-drivers-rpmsg-virtio_rpmsg_bus-c-v2-1-dc591c36f5ed@google.com>
Subject: [PATCH v2] rpmsg: virtio: replace deprecated strncpy with strscpy/_pad
From:   Justin Stitt <justinstitt@google.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
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

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

This patch replaces 3 callsites of strncpy().

The first two populate the destination buffer `nsm.name` -- which we
expect to be NUL-terminated based on their use with format strings.

Firstly, as I understand it, virtio_rpmsg_announce_create() creates an
rpmsg_ns_msg and sends via:

virtio_rpmsg_bus.c:
336: err = rpmsg_sendto(rpdev->ept, &nsm, sizeof(nsm), RPMSG_NS_ADDR);

... which uses:
virtio_rpmsg_sendto() -> rpmsg_send_offchannel_raw()

... which copies its data into an rpmsg_hdr `msg` in virtio_rpmsg_bus.c
618: memcpy(msg->data, data, len);

This callback is invoked when a message is received from the remote
processor:

rpmsg_ns.c:
30: /* invoked when a name service announcement arrives */
31: static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
32: 		       void *priv, u32 src)
33: {
34:         struct rpmsg_ns_msg *msg = data;
...
50:         /* don't trust the remote processor for null terminating the name */
51:         msg->name[RPMSG_NAME_SIZE - 1] = '\0';

... which leads into the use of `name` within a format string:
rpmsg_ns.c:
57: dev_info(dev, "%sing channel %s addr 0x%x\n",
58:          rpmsg32_to_cpu(rpdev, msg->flags) & RPMSG_NS_DESTROY ?
59:          "destroy" : "creat", msg->name, chinfo.dst);

We can also observe that `nsm` is not zero-initialized and as such we
should maintain the NUL-padding behavior that strncpy() provides:

virtio_rpmsg_bus.c:
330: struct rpmsg_ns_msg nsm;

Considering the above, a suitable replacement is `strscpy_pad` due to
the fact that it guarantees both NUL-termination and NUL-padding on the
destination buffer.

Now, for the third and final destination buffer rpdev->id.name we can
just go for strscpy() (not _pad()) as rpdev points to &vch->rpdev:
|       rpdev = &vch->rpdev;

... and vch is zero-allocated:
|       vch = kzalloc(sizeof(*vch), GFP_KERNEL);

... this renders any additional NUL-byte assignments (like the ones
strncpy() or strscpy_pad() does) redundant.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- update commit msg (thanks Mathieu)
- Link to v1: https://lore.kernel.org/r/20231021-strncpy-drivers-rpmsg-virtio_rpmsg_bus-c-v1-1-8abb919cbe24@google.com
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 905ac7910c98..dc87965f8164 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -329,7 +329,7 @@ static int virtio_rpmsg_announce_create(struct rpmsg_device *rpdev)
 	    virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
 		struct rpmsg_ns_msg nsm;
 
-		strncpy(nsm.name, rpdev->id.name, RPMSG_NAME_SIZE);
+		strscpy_pad(nsm.name, rpdev->id.name, sizeof(nsm.name));
 		nsm.addr = cpu_to_rpmsg32(rpdev, rpdev->ept->addr);
 		nsm.flags = cpu_to_rpmsg32(rpdev, RPMSG_NS_CREATE);
 
@@ -353,7 +353,7 @@ static int virtio_rpmsg_announce_destroy(struct rpmsg_device *rpdev)
 	    virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
 		struct rpmsg_ns_msg nsm;
 
-		strncpy(nsm.name, rpdev->id.name, RPMSG_NAME_SIZE);
+		strscpy_pad(nsm.name, rpdev->id.name, sizeof(nsm.name));
 		nsm.addr = cpu_to_rpmsg32(rpdev, rpdev->ept->addr);
 		nsm.flags = cpu_to_rpmsg32(rpdev, RPMSG_NS_DESTROY);
 
@@ -424,7 +424,7 @@ static struct rpmsg_device *__rpmsg_create_channel(struct virtproc_info *vrp,
 	 */
 	rpdev->announce = rpdev->src != RPMSG_ADDR_ANY;
 
-	strncpy(rpdev->id.name, chinfo->name, RPMSG_NAME_SIZE);
+	strscpy(rpdev->id.name, chinfo->name, sizeof(rpdev->id.name));
 
 	rpdev->dev.parent = &vrp->vdev->dev;
 	rpdev->dev.release = virtio_rpmsg_release_device;

---
base-commit: 9c5d00cb7b6bbc5a7965d9ab7d223b5402d1f02c
change-id: 20231020-strncpy-drivers-rpmsg-virtio_rpmsg_bus-c-dba15db4e890

Best regards,
--
Justin Stitt <justinstitt@google.com>

