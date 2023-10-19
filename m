Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F2A7D0410
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346562AbjJSVem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjJSVek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:34:40 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D94498
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:34:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9cb4de3bf0so243452276.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697751278; x=1698356078; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lqEsMCD2petOW7LvFR3PY5d0rpovBBpxs1upvL07Joc=;
        b=x3KwTcGuXf3Wzm2xjlzyeR81q3rusVWLr41CBNirUTnQPEvyM14j7mfEqTpcpxxa6k
         dJAX2Je3jYCtjmFLzhY9KCLRdmGQRlskksmVSjSMNRn1FjxB4kOQb0mG/hWeKtMWqiz3
         8TawVPeQpOGakMJ3OaZM0bAvheUPfZCd6xzoNMut5yjqFcoVV7Ijtt3Mb5aSZaCqqxZM
         gn37/DtZeQPHZ0DuV8YvtCWfruEbBgmZC76dG/zsjXYRA+6Y80LXVJR4ds1e2FGflFQC
         dpFB6q6tt/NzVFeDTUsMd3w3idJK5F/75BwiZBuuLxUrJs/VXr6BYpKvvEaCipL12peH
         ygTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697751278; x=1698356078;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lqEsMCD2petOW7LvFR3PY5d0rpovBBpxs1upvL07Joc=;
        b=YfNRUpXv2JJSbUZtihHoP6QU+cSIS4F4rKa+GOOEI/NorJLHxs8i44DE5Ux61SnDy1
         F6cAoGj8M9wYztpKqK5mnqe+dDWTyrt2flWS6dQs0+C5DeI4bmWMoAvSX0HCwjtYZZ6m
         nTGs67BprA6ztWjIlmxwcW+i2G57J66H0vaZiiipX+cTlcKDXtV9K2x93BoLyWX7O6dk
         IFSjY9TI2X0nYHfY8NLCTqvekKzWgPl2AuXv6MHMWk3KJ89enOh70I06THxBy0wXNlw4
         IGU90i0mEifMbD36SjWRSuq9lcSL8Hwqm8o9TvVnUJoSFyy00xOeY+7D/SyqQ7hRYMok
         p8TQ==
X-Gm-Message-State: AOJu0YycN1iNscUn7or3tcSRmLTo9tvWsSnalBYQiqU6TcYy6uzO2ojy
        6zl8cvFTBjvCIMYqNHnElPfbzVsqAcZ7x0yUzg==
X-Google-Smtp-Source: AGHT+IEZOXJDte5mBKiSHod7tas1fWLJQLJRbTT4Mnc/qvcrMQZrSCM/hxqM5exEVwxnsM4TsX/4sGX1DymVjhGKgg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:d110:0:b0:d9c:c9a8:8c27 with SMTP
 id i16-20020a25d110000000b00d9cc9a88c27mr446ybg.13.1697751278223; Thu, 19 Oct
 2023 14:34:38 -0700 (PDT)
Date:   Thu, 19 Oct 2023 21:34:35 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOqgMWUC/x3NQQqEMAxA0atI1gbaqjh6FXGhNWoWUyUpxUG8+
 xSXb/P/DUrCpNAXNwglVj5Chi0L8PsUNkJessEZV1ljO9QowZ8/XIQTiWJIX8L90IirR49TU7u 5qudPaw3kyCm08vUOhvF5/p5i6cRwAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697751277; l=2895;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=E7cZpx/98qOWGlojxJVSbMIF5mbCSTqGliFRklJggj8=; b=r5nMNcuHW5ecWZu9xGiqdmwQIceKXPadUITLieWfMFjmPqvtIMR7d5OaDyBK0FmycCu8pXiod
 LiUxzFjDcRrDIgL6K4o0W5CUFygua5UAEfx8VqQx05b4PaeO3KaJgSh
X-Mailer: b4 0.12.3
Message-ID: <20231019-strncpy-drivers-nvme-host-fc-c-v1-1-5805c15e4b49@google.com>
Subject: [PATCH] nvme-fc: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

Let's instead use strscpy() [2] as it guarantees NUL-termination on the
destination buffer.

Moreover, there is no need to use:

|       min(FCNVME_ASSOC_HOSTNQN_LEN, NVMF_NQN_SIZE));

I imagine this was originally done to make sure the destination buffer
is NUL-terminated by ensuring we copy a number of bytes less than the
size of our destination, thus leaving some NUL-bytes at the end.

However, with strscpy(), we no longer need to do this and we can instead
opt for the more idiomatic strscpy() usage of:

| strscpy(dest, src, sizeof(dest))

Also, no NUL-padding is required as lsop is zero-allocated:

|       lsop = kzalloc((sizeof(*lsop) +
|                        sizeof(*assoc_rqst) + sizeof(*assoc_acc) +
|                        ctrl->lport->ops->lsrqst_priv_sz), GFP_KERNEL);

... and assoc_rqst points to a field in lsop:

|       assoc_rqst = (struct fcnvme_ls_cr_assoc_rqst *)&lsop[1];

Therefore, any additional NUL-byte assignments (like the ones that
strncpy() makes) are redundant.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
Similar-to: https://lore.kernel.org/all/20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com/
---
Note: build-tested only.
---
 drivers/nvme/host/fc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a15b37750d6e..680585253f7c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1218,10 +1218,10 @@ nvme_fc_connect_admin_queue(struct nvme_fc_ctrl *ctrl,
 	/* Linux supports only Dynamic controllers */
 	assoc_rqst->assoc_cmd.cntlid = cpu_to_be16(0xffff);
 	uuid_copy(&assoc_rqst->assoc_cmd.hostid, &ctrl->ctrl.opts->host->id);
-	strncpy(assoc_rqst->assoc_cmd.hostnqn, ctrl->ctrl.opts->host->nqn,
-		min(FCNVME_ASSOC_HOSTNQN_LEN, NVMF_NQN_SIZE));
-	strncpy(assoc_rqst->assoc_cmd.subnqn, ctrl->ctrl.opts->subsysnqn,
-		min(FCNVME_ASSOC_SUBNQN_LEN, NVMF_NQN_SIZE));
+	strscpy(assoc_rqst->assoc_cmd.hostnqn, ctrl->ctrl.opts->host->nqn,
+		sizeof(assoc_rqst->assoc_cmd.hostnqn));
+	strscpy(assoc_rqst->assoc_cmd.subnqn, ctrl->ctrl.opts->subsysnqn,
+		sizeof(assoc_rqst->assoc_cmd.subnqn));
 
 	lsop->queue = queue;
 	lsreq->rqstaddr = assoc_rqst;

---
base-commit: dab3e01664eaddae965699f1fec776609db0ea9d
change-id: 20231019-strncpy-drivers-nvme-host-fc-c-a542b34b8710

Best regards,
--
Justin Stitt <justinstitt@google.com>

