Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DEF7B2038
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjI1OyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjI1OyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:54:18 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37211180;
        Thu, 28 Sep 2023 07:54:17 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690d8fb3b7eso11747996b3a.1;
        Thu, 28 Sep 2023 07:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695912856; x=1696517656; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkWxYDd3S5D6wQFdmPFmF36P9AFy13Nc4la9Zv9FLvQ=;
        b=TdUGxaELeqNr2hfrvvWqGwupPErkAVMQRCS8PfbuSCqA4xg3/apSSG32UsUx/saT7N
         9B+GTE9Lttul5hGbQViyT/iiJ7nZPjVN+3+TwnlRI4RbPUauS6KAfXotky8S0t82e+Dq
         2pX2XWQjndpRtCZ9VSictr++472K1NIxoUWNaeXbM09rioP92uPIe59X77pR98FrPOwq
         VXvRiAUyAFx4a/KYvVAVUh9SoXFDXGCfQ1uYNZbMiDj2X3EOGEdon+of8Iaenil2UJb1
         NB29wzetq+0ICvcDGks37/XoWK5/FC5+x91bpJ6HV1Cjb9HP+RSoAqXjVQAQtHVBg5fV
         dDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695912856; x=1696517656;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkWxYDd3S5D6wQFdmPFmF36P9AFy13Nc4la9Zv9FLvQ=;
        b=GqA+9fNnDvvO7dm1PM53ZYWTJe7RxPdM6HV4MYAueYTCnLLb4QP5dsPWPZQBwhFyk7
         4qkkErJb3+sVHPIw4j9WEuJMzuhMgrhofnsLsYWi/eE/wgSWoCZzo38OXu954IaOztp6
         4WQDmDzTbHJgQxcIYd7OZoUVLiqmlpqjOqnQEULgHCHESDIZuuqtZeE9pyZIHjkmxeBp
         TooCpWq+T4lrNJP9xKABzdyaKcKwMg5JkdZvYo0bvTO+R7iPxu0pmhb2MHsLA4v/zbGO
         MmgxRsiVvNUTBoKhUvpgMphPZ/F054ECXuvWWnoPN3AOaexUPtKpINZZR9FT4+UIstE5
         mQhQ==
X-Gm-Message-State: AOJu0YwnRBB+MtSC+rcNxRrmcbg05irjswv9Df6b3Cu+zDpWPPFzDXDz
        I3d3Gg7ZVYU0S0HiKLp0lYZhDaXLR748MA==
X-Google-Smtp-Source: AGHT+IGJORolZKwgk2hGuKJ8rqV7+FP9Ss/peFl2G6BnkK4li8z738A/NKKXjR5hjdLcSusDzSEq5w==
X-Received: by 2002:a05:6a00:b81:b0:691:fd26:f54a with SMTP id g1-20020a056a000b8100b00691fd26f54amr1552608pfj.20.1695912856538;
        Thu, 28 Sep 2023 07:54:16 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b00672ea40b8a9sm13828554pfe.170.2023.09.28.07.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 07:54:15 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     njavali@marvell.com, mrangankar@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, lduncan@suse.com, cleech@redhat.com,
        michael.christie@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] scsi: qla4xxx: fix potential deadlock on frwd/back lock
Date:   Thu, 28 Sep 2023 14:54:01 +0000
Message-Id: <20230928145401.32918-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iscsi_complete_pdu() is called by several rx callback, under
softirq context. Thus the callsite of it inside qla4xxx_task_work()
should better disable bottom half, as work queue is executed under
process context, it needs to protect race with softirq context
locking to avoid deadlock.

<potential deadlock #1>
qla4xxx_task_work()
--> iscsi_complete_pdu()
--> spin_lock(&conn->session->back_lock);
<interrupt>
   --> iscsi_tcp_data_recv_done()
   --> iscsi_complete_pdu()
   --> spin_lock(&conn->session->back_lock) (deadlock)

<potential deadlock #2>
qla4xxx_task_work()
--> iscsi_complete_pdu()
--> __iscsi_complete_pdu()
--> spin_lock(&conn->session->frwd_lock)
<interrupt>
   --> iscsi_tcp_data_recv_done()
   --> iscsi_complete_pdu()
   --> __iscsi_complete_pdu()
   --> spin_lock(&conn->session->frwd_lock) (deadlock)

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock.

To avoid the problem, disable bh inside qla4xxx_task_work() before
calling iscsi_complete_pdu().

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/scsi/qla4xxx/ql4_os.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 675332e49a7b..c60781148e6c 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -3382,7 +3382,9 @@ static void qla4xxx_task_work(struct work_struct *wdata)
 		hdr->itt = itt;
 		data = task_data->resp_buffer + hdr_len;
 		data_len = task_data->resp_len - hdr_len;
+		local_bh_disable();
 		iscsi_complete_pdu(conn, hdr, data, data_len);
+		local_bh_enable();
 		break;
 	default:
 		ql4_printk(KERN_ERR, ha, "Passthru failed status = 0x%x\n",
-- 
2.17.1

