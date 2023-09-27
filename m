Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3C37B02D9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjI0L0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjI0L0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:26:19 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8445FFC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:26:04 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-3217fdf913dso8219068f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695813962; x=1696418762; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dqe/ezm7v7eNq2euMQ5a609PLiY6TU1HkFiIjMU1CM4=;
        b=KkB4ZFEheuhGY2DHzNuQc0kEk8mD8RxGAjNExd8epS2wc0Lq/nI1h84MjdzURP/zri
         FlbrcRN9BjbU14sidG8Di1TblvEIDNVSFWs/5k9bzwYf0//eL6Xf8nMPVGoMI5xHOtmA
         FNxl2iXd808FQ6Voj9RPlJT+6ZvgTwsi1XA9Q8My22gGNLxLWpF7hWiDW23NB2GsCmMo
         Fax8BIo2r8iTVGp1vTgXCGc/SByl11yWg/niy0HkGJYveM/TV208+D/BFisszpDtk4Az
         S04xvlbaJV8fm2dgYAN2ZuetdjG9zXv8CVY04yXLI2g01lZkerwcRmM/jF9n6WrGGnUi
         A92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695813962; x=1696418762;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dqe/ezm7v7eNq2euMQ5a609PLiY6TU1HkFiIjMU1CM4=;
        b=uH2WnPJVYGZflHS8lcecTakcSJ1eYIkXBl0IeMvA33oUoLd8Y2A72tHvBeLPjusItG
         Ir/FdNF2ScYdZb0mx6PHmUCwNaRo+uKot9Jcf9l0NNqpxV/7n8DH5N/t2JENfkHUoqKB
         gTA/ub83JqlpjX99L3iZAShvqLi93ZDlRJI84PGtW/8PXSlV5wiFB632m+IPJtpfhzEl
         YP29HDD6PTigJoE1Szjesi0taCRctssgjVjFb7OvJ2gE8fZDMTV48QeieCL/BRra15l9
         jQbt6XDMnRQwE+E1PNDWgw3jyso7czcNTHQ7BmO+yPLRby7IS5H3WvgEDmB9YdLBwTby
         oYsQ==
X-Gm-Message-State: AOJu0Yx55LOveDESdlkr7ux6E6/HHXQzT24S2NrJ/XOlvZiXk20K8Ytv
        E/MqvXnW00nVHfXKVlGoBbiwAtFqBRUs+VDIexvFHTU83//70lwj4TLAh3BtaDn1RYFD4Ysae0r
        7Gfh073U0HoGAX2XDS4SCOWVIxDzUGlOviGhOU0TcHu3C/ANWUVXfP7wuy40xNJs3lSAHszNNMZ
        mPF2pgWG/A0Q==
X-Google-Smtp-Source: AGHT+IHGhnCz3cXEbmsg3de87oj092Lki6UnOvVDUVWsRwuRGI6N/r5ZtqP9i2rHrOmvcuN9khGZOUYPcb4E8TMGvYg=
X-Received: from seb.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:31bd])
 (user=sebastianene job=sendgmr) by 2002:adf:ed84:0:b0:317:6e79:423c with SMTP
 id c4-20020adfed84000000b003176e79423cmr7349wro.3.1695813962239; Wed, 27 Sep
 2023 04:26:02 -0700 (PDT)
Date:   Wed, 27 Sep 2023 11:25:17 +0000
In-Reply-To: <20230927112517.2631674-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20230927112517.2631674-1-sebastianene@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230927112517.2631674-12-sebastianene@google.com>
Subject: [PATCH 11/11] arm64: ptdump: Fix format output during stage-2
 pagetable dumping
From:   Sebastian Ene <sebastianene@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, will@kernel.org, ryan.roberts@arm.com,
        mark.rutland@arm.com, maz@kernel.org, vdonnefort@google.com,
        Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two issues where the printed address range from debugfs was not showing
out correctly when trying to read from
/sys/kernel/debug/host_stage2_kernel_page_tables entry.

The first issue was printing to debugfs the following:
0x0000010000000000-0x0000000000000000    16777215T PGD

If the st->start_address was larger than the current addr the delta
variable used to display the size of the address range was overflowing.
The second issue was printing the following wrong IPA range:
0x0000000000000000-0x0000000000000000           0E PGD

Validate the current address range before printing it from the debugfs
entry.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/mm/ptdump.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 45ff4ebae01a..2c21ba9b47d1 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -430,6 +430,9 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 		const char *unit = units;
 		unsigned long delta;
 
+		if (st->start_address >= addr)
+			goto update_state;
+
 		if (st->current_prot) {
 			note_prot_uxn(st, addr);
 			note_prot_wx(st, addr);
@@ -455,6 +458,7 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 			pt_dump_seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
 		}
 
+update_state:
 		st->start_address = addr;
 		st->current_prot = prot;
 		st->level = level;
-- 
2.42.0.515.g380fc7ccd1-goog

