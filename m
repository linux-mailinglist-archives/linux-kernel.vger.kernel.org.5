Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB80A7E73E1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 22:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjKIVvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 16:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjKIVvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 16:51:06 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27714211;
        Thu,  9 Nov 2023 13:51:04 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6bf20d466cdso302825b3a.1;
        Thu, 09 Nov 2023 13:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699566664; x=1700171464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L3szXkniAOBIgjKGY87jgy200/6D2pD1Gf60eUObSNU=;
        b=R/1x9TKREASXWBrZ0+4yiOltp39bQrPiW/U6kloZSu7EXAz/0CQe+W6G2jUyQhwRcw
         iMGurfBiF0SE1nOjZ1YobbeMX+r4qxHVTXMFFA5GWXlfGRUm0fuiY94hSaE6DirgcphN
         qY04nv1f81l7cXE/rpijAGg+nepi4h+Dc/yrbQhysSl74Lr7yMT+CtDRqAowO2bMbRQU
         YOXncvf4KQdOfX0FpcqGB4Ox4QKKAHaDiVdrc8aaiTAe88uRTOaz4SSKbPltqjLW03td
         WXmbmxOPZ6/1KHCLlEUaOVFRIeUvOvmABVOvB/ZdE3sSXABCDbEEIS3yiAyO7Mhlk2m2
         c6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699566664; x=1700171464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3szXkniAOBIgjKGY87jgy200/6D2pD1Gf60eUObSNU=;
        b=C2ea5tYzoZAqGm6su2ckNxFhBqrQNIfFjODQbmFLpGnxHE5t3ncQ1SewlSF4Q3Ir6w
         M6fHYjCGm9KRaGHTFXNrmfMsPqhafsnWczchA9deVxipHCz9SvKfIkDNgMeqI/JVEd1l
         Celw6OgHGTq8e7s/NkQMVjvDFirl30zMlL89fbx1ItRrfrH4DJ/a2NKdsK/b5bud/Tsh
         E0W/osoUbUq9JAbhIeCgacuzB6C0DEl6O8M/4udYcy1vYpVz++6R+1hmHFQOovc3K06f
         rUe4wP917YjWWKQuMmT65AAlluyhoty3Pvf28b0XbCGI82ZtD4F+DvibLvo46wqvnNWu
         wtIg==
X-Gm-Message-State: AOJu0YylyIAOELUAmayOVjutAWhIWn9Kb63nxXPjwdpVmjHXSikXQE7d
        l3NZm6mX8LCxO152UHzi/3Y=
X-Google-Smtp-Source: AGHT+IEd0buHmeHhN+KsS1tLtsAX++VUah6xMKe0RHbXybUhB6qDxOkFThOVGQgMY3hx2V0ze4Bgpw==
X-Received: by 2002:a05:6a21:7892:b0:163:57ba:2ad4 with SMTP id bf18-20020a056a21789200b0016357ba2ad4mr7216517pzc.2.1699566664076;
        Thu, 09 Nov 2023 13:51:04 -0800 (PST)
Received: from abhinav.. ([2402:3a80:196c:ea3:dae1:648f:ab89:4dd0])
        by smtp.gmail.com with ESMTPSA id x20-20020aa784d4000000b006bb5ff51177sm11214827pfn.194.2023.11.09.13.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 13:51:03 -0800 (PST)
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
To:     oliver@neukum.org, aliakc@web.de, lenehan@twibble.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Abhinav Singh <singhabhinav9051571833@gmail.com>
Subject: [PATCH] driver: scsi: Fix warning using plain integer as NULL
Date:   Fri, 10 Nov 2023 03:20:49 +0530
Message-Id: <20231109215049.1466431-1-singhabhinav9051571833@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse static analysis tools generate a warning with this message
"Using plain integer as NULL pointer". In this case this warning is
being shown because we are trying to initialize  pointer to NULL using
integer value 0.

Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
---
 drivers/scsi/dc395x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index c8e86f8a631e..d108a86e196e 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -1366,7 +1366,7 @@ static u8 start_scsi(struct AdapterCtlBlk* acb, struct DeviceCtlBlk* dcb,
 			"command while another command (0x%p) is active.",
 			srb->cmd,
 			acb->active_dcb->active_srb ?
-			    acb->active_dcb->active_srb->cmd : 0);
+			    acb->active_dcb->active_srb->cmd : NULL);
 		return 1;
 	}
 	if (DC395x_read16(acb, TRM_S1040_SCSI_STATUS) & SCSIINTERRUPT) {
-- 
2.39.2

