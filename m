Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B998477D47F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbjHOUnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239367AbjHOUnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:43:22 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6B82122;
        Tue, 15 Aug 2023 13:42:57 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bc5acc627dso39139805ad.1;
        Tue, 15 Aug 2023 13:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692132118; x=1692736918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ms56+rtGHwamjVIGstl+g8Vj5xVHVUjVCDtUfMMf7DE=;
        b=q0Y5YZPD7aEtkZvI0br1qHsrcrt8f+4p7qV2Bh04MSA8mU5C4V8x6SU3JmsE/i/KrR
         irF7auvlvpCQm13IZggfWOjlQe2cUrp0fgtaq7eC6oBobKTkDt3JOYOD2yffPcWNno1S
         UCfHLbFsit9djHzq5wjVnHbDtMuotlQbNXViNPM67N67mbpOpBDxEFlSHr2hU9mMvUs6
         nv2tLyNIYOuwn/EhveAw3zoiZKoZRVR5m4Fp9rpdcqAGJzaGJx9OuUvDFspTYja1/qFm
         ORgKxFDBFosY7VKpqzAuaKorpfKny/1Pd76CUmPLjXYuCnuTp318lYVQ4EFxiSfRL+LG
         NLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692132118; x=1692736918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ms56+rtGHwamjVIGstl+g8Vj5xVHVUjVCDtUfMMf7DE=;
        b=BOLu1ZNn6BR6T36GzYwqhJadUYl+uTKgid0Og19ngU/BTpgu7duY8sIkdzvG6BmOSY
         OTrTTUlAPkAs4vBY4eo65QCZfmV1K8ry3NwcI+0nju4TTv8jwCADIu9LmxbMe64zgGd/
         ItSyk2PP2N9u5GfyVej1IEy2pSgAquZnUWeGnxuoz/U+3N87/Y4Zr+PKWFbtEve/0zbE
         wqWM0VI9OIJL7RpROT9myLwMLug33V48sXglsdYbXXP2wBHJLpBDbpHRopZwbMt60Tnw
         ftDASCdWvKpe5kbZOnunYSsCC4omtZvRi9aWeS6ASLvlShuei1EH++inSRLkkh08WqZh
         RbPA==
X-Gm-Message-State: AOJu0YwP0DYYjSGA2pdjLNUSOvAFeddwB6UyDwagUMupZITU8FVjxoGS
        dYzHkoB0brd2+tFtlon1Fdo=
X-Google-Smtp-Source: AGHT+IHT92NSDYa2LHvygWB/xTZh0bqlLDsQDBeXAjiDOHXd2ML6xLxeLmAOX/aAkxOEUPbYjb631A==
X-Received: by 2002:a17:903:2789:b0:1bd:f1a7:8293 with SMTP id jw9-20020a170903278900b001bdf1a78293mr3764483plb.69.1692132117989;
        Tue, 15 Aug 2023 13:41:57 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c009:58e9:db85:3caf:1429:e455])
        by smtp.gmail.com with ESMTPSA id ij13-20020a170902ab4d00b001bb04755212sm11635606plb.228.2023.08.15.13.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 13:41:57 -0700 (PDT)
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     gregkh@linuxfoundation.org, richard.leitner@linux.dev,
        wsa+renesas@sang-engineering.com, mhocko@suse.com,
        surenb@google.com
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org
Subject: [PATCH v1] drivers: usb: Removes use of assignment in if condition
Date:   Wed, 16 Aug 2023 02:11:41 +0530
Message-Id: <20230815204141.51972-1-atulpant.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes following checkpatch.pl issue:
ERROR: do not use assignment in if condition

Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
---
 drivers/usb/core/devio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index e501a03d6c70..56899fed6bd4 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -2333,9 +2333,10 @@ static int proc_ioctl(struct usb_dev_state *ps, struct usbdevfs_ioctl *ctl)
 		}
 	}
 
+	intf = usb_ifnum_to_if(ps->dev, ctl->ifno);
 	if (ps->dev->state != USB_STATE_CONFIGURED)
 		retval = -EHOSTUNREACH;
-	else if (!(intf = usb_ifnum_to_if(ps->dev, ctl->ifno)))
+	else if (!intf)
 		retval = -EINVAL;
 	else switch (ctl->ioctl_code) {
 
-- 
2.25.1

