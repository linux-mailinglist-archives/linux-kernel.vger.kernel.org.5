Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C1F7DFACF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345424AbjKBTUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbjKBTUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:20:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BC3184
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698952769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VH/N2+u/BX61pZEFnFU4abdjTRFxE7atZBHYbezDKHQ=;
        b=Vhva4KTkpA0DZA+QYn4Huiv8TbDsZRogH7ulMW9S5BCIFkDFUAo9eBON/hrSj2HvikXXU2
        Gs+mooYwendhU0CvCO+jhe9l75f9Dk0p1ABcZFpnJvMfbSchd5dMSCbKa1rOi9aNp1dxlS
        gWHZhsn1unrtBssJOMtstUjy4RYGZVg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-zdbuHNtHMOSt-W6XXiHcgg-1; Thu, 02 Nov 2023 15:19:27 -0400
X-MC-Unique: zdbuHNtHMOSt-W6XXiHcgg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-32dfbc50f1dso172025f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698952766; x=1699557566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VH/N2+u/BX61pZEFnFU4abdjTRFxE7atZBHYbezDKHQ=;
        b=TB7uKQehhvTtNM3RKe1hhUorkZsENsjEVwn62QolLSMwpB8mcKMadBm4BLunp8Ad8v
         Sl96QcV6k36HVTFLuvZTD2KDaxKkYAgOCnVXg/mXIfbpJzUqGdKGDqOt9Ddw0ZC2w0Xt
         142dwOUVdeJ1c4d2TdLNsXXB6Rj1BW7ekikCpuMsWNEMDpoDNuSvZCD4cyoux5WnwcX1
         WCj5R6ehpLh72kkfGrRrET9DMHST32ugBR88o8Dk1LtPMQwLKT2bK4i7OhViz4IWZPig
         Mm35bKvb6pBV1xWANOW5Et9AVCm0IqbCPE3HBYo0n1o8l5DdtzlCraW4GAvpz1P8mT3m
         ZkXQ==
X-Gm-Message-State: AOJu0YwRkYjeerFKLoC4F6nDrEQe1PliXUwc8Z+BRc03A82zmmFKw9a4
        hcukHmSYf9XgMnZfjcb/CVcB+84v6XL21vM70kcfRzAdy0VmOA45yA9tTqJ2A44pcf5m/Qi6ZX3
        4VRZ+4XBtz4b6TOzl/QC3wH5B
X-Received: by 2002:a05:600c:510a:b0:405:1ba2:4fcf with SMTP id o10-20020a05600c510a00b004051ba24fcfmr15748999wms.4.1698952766729;
        Thu, 02 Nov 2023 12:19:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7wSu4OKWotI05EoNGVSlLHC3iEji5MIz+S+leIFdg+jMKK6E/oGxssjELhigZ3tCQW+7N6g==
X-Received: by 2002:a05:600c:510a:b0:405:1ba2:4fcf with SMTP id o10-20020a05600c510a00b004051ba24fcfmr15748984wms.4.1698952766361;
        Thu, 02 Nov 2023 12:19:26 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c5:d600:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d4a43000000b003232380ffd7sm86618wrs.102.2023.11.02.12.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 12:19:25 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Stanislav Fomichev <sdf@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH] drivers/net/ppp: copy userspace array safely
Date:   Thu,  2 Nov 2023 20:19:15 +0100
Message-ID: <20231102191914.52957-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ppp_generic.c memdup_user() is utilized to copy a userspace array.
This is done without an overflow check.

Use the new wrapper memdup_array_user() to copy the array more safely.

Suggested-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/net/ppp/ppp_generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index a9beacd552cf..0193af2d31c9 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -570,8 +570,8 @@ static struct bpf_prog *get_filter(struct sock_fprog *uprog)
 
 	/* uprog->len is unsigned short, so no overflow here */
 	fprog.len = uprog->len;
-	fprog.filter = memdup_user(uprog->filter,
-				   uprog->len * sizeof(struct sock_filter));
+	fprog.filter = memdup_array_user(uprog->filter,
+					 uprog->len, sizeof(struct sock_filter));
 	if (IS_ERR(fprog.filter))
 		return ERR_CAST(fprog.filter);
 
-- 
2.41.0

