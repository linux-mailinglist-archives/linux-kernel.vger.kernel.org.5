Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCF1753F90
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 18:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbjGNQLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 12:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236016AbjGNQLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 12:11:01 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D329B35A2;
        Fri, 14 Jul 2023 09:10:58 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-668709767b1so1556729b3a.2;
        Fri, 14 Jul 2023 09:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689351058; x=1691943058;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJT4JvcoBJI1s+TLldc7ex2Zu19/5zU0zWJ4jSuF7fQ=;
        b=CtXXldw+iZHVpX6qIr9p4KT37Kx7qBmRnpnq+S3lRaLk5dlTZ9RHGMt9UfPqB1dfEy
         e7Pn1VYiykKBznEhBrSEDwFC466zDTJgOeYNcLthON3YP7It/50qqhCczUfwZzWGquq0
         bYCkmdo1NsVyX/q/7a2PxHxJx73MhScc19QsQpSlK7+dbfsffeA1yJ+3B7fD0Tae0m12
         V6haBs8KDTlG35Hy2gYqyjurxzyfukTCi9FY8tht9CzBbmTfydy0RBC2CpkYusld/06m
         OxGR+GH4YeG1xEc+6HdjU2QgsODBNnkMT94yrqtpjDUoRneboKqhAfbSdV8p0cHBHS8k
         qE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689351058; x=1691943058;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJT4JvcoBJI1s+TLldc7ex2Zu19/5zU0zWJ4jSuF7fQ=;
        b=Ty4PZKUKF/DE+EVcVy2ZYy8fGcsamiY/qlaUKg7n3DDn9K9nWAl6xdMGkKw9uOCzWC
         SoI83E4FBsyZRKbPIxwmile88Y9d8Ex6iWrL/GG82+DiMSs8zPx6iGr19tqacuTOiiph
         Tw0SipwNSLpF1QmA1UhmvhMM88X0nY8JS5dG+mrkVRN+9CsJA9F4A2/sPNqU+G/eLdep
         3c6jnADQl+788HNKPg3+BBTXxxJQUTtl/L+BISHTDG3g3H2yPLeWJ28HHEw0rNl0s8lK
         oVs14n1NiFc6XJ9C1bZrl7+QfyydWwjisUlkV4okWSlBE8kAfLSeFaNM1bhDMQodoXIK
         iWnA==
X-Gm-Message-State: ABy/qLZhTQw+Tk3w8pP8FsdBv99Y1mWDtFt6AzvVJbMYhnLq2R1c8SA3
        p4+2EgRkmDlBjr3sAlU0LbE29KV8xG4=
X-Google-Smtp-Source: APBJJlFZoztqjGGEvX5dj7b03i4Z8unODw3IQSxPkgJjXaAt3iwb1U1omDrUXzc3dlyNX+gL8T9Cvw==
X-Received: by 2002:a05:6a00:2386:b0:682:b6c8:2eb with SMTP id f6-20020a056a00238600b00682b6c802ebmr4754758pfc.1.1689351058162;
        Fri, 14 Jul 2023 09:10:58 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id b30-20020a63931e000000b0055bbc746272sm7544607pge.17.2023.07.14.09.10.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jul 2023 09:10:57 -0700 (PDT)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>
Subject: [PATCH] Bluetooth: hci_ldisc: check HCI_UART_PROTO_READY flag in HCIUARTGETPROTO
Date:   Sat, 15 Jul 2023 00:08:54 +0800
Message-Id: <20230714160854.20562-1-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds code to check HCI_UART_PROTO_READY flag before
accessing hci_uart->proto. It fixs the race condition in
hci_uart_tty_ioctl() between HCIUARTSETPROTO and HCIUARTGETPROTO.
This issue bug found by Yu Hao and Weiteng Chen:

BUG: general protection fault in hci_uart_tty_ioctl [1]

The information of C reproducer can also reference the link [2]

Reported-by: Yu Hao <yhao016@ucr.edu>
Closes: https://lore.kernel.org/all/CA+UBctC3p49aTgzbVgkSZ2+TQcqq4fPDO7yZitFT5uBPDeCO2g@mail.gmail.com/ [1]
Reported-by: Weiteng Chen <wchen130@ucr.edu>
Closes: https://lore.kernel.org/lkml/CA+UBctDPEvHdkHMwD340=n02rh+jNRJNNQ5LBZNA+Wm4Keh2ow@mail.gmail.com/T/ [2]
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 drivers/bluetooth/hci_ldisc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index efdda2c3fce8..a76eb98c0047 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -770,7 +770,8 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
 		break;
 
 	case HCIUARTGETPROTO:
-		if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
+		if (test_bit(HCI_UART_PROTO_SET, &hu->flags) &&
+		    test_bit(HCI_UART_PROTO_READY, &hu->flags))
 			err = hu->proto->id;
 		else
 			err = -EUNATCH;
-- 
2.35.3

