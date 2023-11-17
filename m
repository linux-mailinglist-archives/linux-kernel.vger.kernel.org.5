Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91507EF7D8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 20:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346154AbjKQT3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 14:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjKQT3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 14:29:50 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25599D52
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:29:47 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-28016806be2so3665651a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700249386; x=1700854186; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7BLtURhc1ohq6G7Ehb9fNj26PZtAiF6i6XyPfX0SmPQ=;
        b=v40S9pXSOHQ6tKdCq7miQ1egRBEA72FQZnxTRJ1jtcOTjnOyKgTQUuN75Qzh3DF+eG
         yzCBflI1AcAVzOtYcnUEsbScZTQo5cOiqUMT1rZWraE+jO9FepwduneKooLVF0mKAcdg
         5M/57Lx99Ld34M8EY0cj7arxbbWOcX+ZCR2ZvO+k6LWAbcnyd5BVLSxptDV7De5YBD1x
         U48B6iQx3bNyG1wOOOlHQghZCQPR1o7slfP++mBGM1HdfZJxL5qWPILPa+ly2+LoJUi0
         3J9xTiyyM3jt/C89EPqqk4ahh64qa/wsSDXgUloi0AUu4ooingvJY5TbzjgukvFI08Od
         Pq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700249386; x=1700854186;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BLtURhc1ohq6G7Ehb9fNj26PZtAiF6i6XyPfX0SmPQ=;
        b=pcq6Q2jP9zSSeJC9MDMAUBASpSJfCqPvuxSBRcXgxJy1Tg4Nbu7DArVxmrnvwEQ6HL
         waxfvVEPMBGBC12T+79sX6CldxWoSX19u1IqKpCI9lKLSLOxjH/oySnLzWiFMrkTNO6w
         qv1OUydWrOhaMxjZ33coPSr+orK5gUyv47KqeJxO+gqj+idn82LUedHqrq0VjR64RNuq
         eT4BmcxLA1l+mVOiW8CilgVMyp9UgbqmZbvu7bfCFSQxuplKDFJRpiVKR0Ea0vwzZxAy
         qL3m7/xhnFpYxOm2zoUoovoZeemD7ZR+fFY7ndfkHmz80nB1Q4LKwUJFOVqhw3h4Xftb
         jq6w==
X-Gm-Message-State: AOJu0YxmKTwxzY3xErbTtY83MydO7mg7NQl1u1Al2s7FazmWA8vH8d+O
        wQlcQ8ITnkRDKCkAleVClHZmzWH4I4nafA==
X-Google-Smtp-Source: AGHT+IHPOmLYguT+8vb5GwUDrc+ZP4ecu7SsbJuI3BcLECKsyV3gfi+SPO2WAh3jllf3e2TWKANI9fc+O0t1hA==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a17:90a:bd97:b0:280:c3df:e29f with SMTP
 id z23-20020a17090abd9700b00280c3dfe29fmr2081pjr.3.1700249386621; Fri, 17 Nov
 2023 11:29:46 -0800 (PST)
Date:   Fri, 17 Nov 2023 11:28:34 -0800
In-Reply-To: <20231117112833.v2.1.I4c7ab22148e168e3cde00f27b89748ff4bc651c2@changeid>
Mime-Version: 1.0
References: <20231117112833.v2.1.I4c7ab22148e168e3cde00f27b89748ff4bc651c2@changeid>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231117112833.v2.2.I5f8211e201324f6d9f699e995fc59dda1e51f0ce@changeid>
Subject: [PATCH v2 2/2] Bluetooth: btusb: Fix double free in handle_dump_pkt_qca()
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Tim Jiang <quic_tjiang@quicinc.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hci_devcd_init() returns 0 on success. Do not use this return value
when eturning from handle_dump_pkt_qca() as it incorrectly indicates
that it's not a dump packet.

This causes the first dump skb to be processed by both hci_devcd_rx()
and hci_recv_frame() leading to double free.

Fixes: 20981ce2d5a5 ("Bluetooth: btusb: Add WCN6855 devcoredump support")

Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

(no changes since v1)

 drivers/bluetooth/btusb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 35a26440cabd..d23c992502c5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3531,10 +3531,11 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 			goto out;
 		}
 
-		ret = hci_devcd_init(hdev, dump_size);
-		if (ret < 0) {
-			bt_dev_err(hdev, "memdump init error(%d)", ret);
-			goto out;
+		if (hci_devcd_init(hdev, dump_size) < 0) {
+			bt_dev_err(hdev, "memdump init error");
+			clear_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
+			kfree_skb(skb);
+			return ret;
 		}
 
 		btdata->qca_dump.ram_dump_size = dump_size;
-- 
2.43.0.rc0.421.g78406f8d94-goog

