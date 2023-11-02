Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DD17DFA4E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377344AbjKBSuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347225AbjKBSuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:50:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A3012D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698950967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zTCYpUoyUiZfvmP7n/GuVDO1ZvVkwEjjVEdFxne33GQ=;
        b=MZmcU51q3V9tNNga4BTZQYaYyiX3Hu0bRbS2vLhHt8F/j1ywrSKhPBcxB7mQ4fwgcEZT7f
        RG1b5otFT60a5V218U76vBfoJbyJYq7Sxi6y4vUevgBy12bE/vbJgfMIr2Za+CjO9x9Sr6
        1pDySdN/vYXIT0ZDjixSDcPk+S867xM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-F--I4uSvOiGpHQ6SSZ4OUQ-1; Thu, 02 Nov 2023 14:49:25 -0400
X-MC-Unique: F--I4uSvOiGpHQ6SSZ4OUQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2c509a6223eso2744971fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 11:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698950962; x=1699555762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTCYpUoyUiZfvmP7n/GuVDO1ZvVkwEjjVEdFxne33GQ=;
        b=ZQrduz69uOjm2Q7d4Wrw1HL8iqfJojiUtsmQJgYtaTfyoZQzDFPhGIz2bVg+p1m1oN
         mupuF18th8QXv4T92anhc9+PGSC8GrM2loI7BVQMJe/Uy5IZLY46V6/hNNg7Ue37NJSV
         tOenNtAmYHRR5u5unBN5rEjiX3vspMMWwOfcm/XMIGjXArH0Om8w2HNGeU8850Mg9u2l
         vk6IShGSoxsXPLc64y4KGrmwW4PpeaFPTW3+yajSER1gz+QniXr/TbIkCQyrWcWqXGfZ
         DU0c49kjxTyxo78y+k+r1pWEHz0fXpGsTFUVQ++QL1isAcL3J4D1++TMUsNfve+K8gLF
         6Y4Q==
X-Gm-Message-State: AOJu0YyKMKf4kqRUSxhGQKo77ncM31ASz8Wak/uoiAiEVBgk38am7DaC
        Xxcl3Kw8U70nwZBYKruHzWE7UMF3cuktjYCAeF+Z2Aj3u7qxJAXzSAQ18hs1703cWo92y0U7iK5
        i9qzWzTaOxBhVB+Kqu4uZ1tOz
X-Received: by 2002:a2e:9893:0:b0:2c6:f97c:cf21 with SMTP id b19-20020a2e9893000000b002c6f97ccf21mr1274669ljj.2.1698950962790;
        Thu, 02 Nov 2023 11:49:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoFprnF+/BByoSWTQdelKTziVFx85ttF1hGiOOyGf7JRkDYy2a1qf1bNxfyj7crnK9lAhfTg==
X-Received: by 2002:a2e:9893:0:b0:2c6:f97c:cf21 with SMTP id b19-20020a2e9893000000b002c6f97ccf21mr1274657ljj.2.1698950962485;
        Thu, 02 Nov 2023 11:49:22 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c5:d600:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c3b8500b004064e3b94afsm27059wms.4.2023.11.02.11.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 11:49:22 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH] drivers/fpga: copy userspace array safely
Date:   Thu,  2 Nov 2023 19:49:09 +0100
Message-ID: <20231102184908.49558-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dfl.c utilizes memdup_user() and array_size() to copy a userspace array.
Currently, this does not check for an overflow.

Use the new wrapper memdup_array_user() to copy the array more safely.

Suggested-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Linus recently merged this new wrapper for Kernel v6.7
---
 drivers/fpga/dfl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index dd7a783d53b5..e69b9f1f2a50 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -2008,8 +2008,8 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
 	    (hdr.start + hdr.count < hdr.start))
 		return -EINVAL;
 
-	fds = memdup_user((void __user *)(arg + sizeof(hdr)),
-			  array_size(hdr.count, sizeof(s32)));
+	fds = memdup_array_user((void __user *)(arg + sizeof(hdr)),
+				hdr.count, sizeof(s32));
 	if (IS_ERR(fds))
 		return PTR_ERR(fds);
 
-- 
2.41.0

