Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BEA773CAE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjHHQIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjHHQG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:06:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9001B7294
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691509516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ovtijMkVZJcNyWwGdwYpTKXzS+g6b+kiQjjytk2RPVY=;
        b=ag27Iot782JzPsDN/1528jL/7UowJMJkyckBSrt9PQpHQayjBQ3FjsC81TW6mAFwI21/j8
        a2Et2xjMlfHivrILGktXBJQuohVZtWFE1og1n2RIwOZWoTKsbtelLj2mMWatrSRJb9jlkE
        PElCWBnh/TvdIT8DrWmdb1bPLZewOg8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-tAbgtqP0OVieX9BuODYuOQ-1; Tue, 08 Aug 2023 11:28:25 -0400
X-MC-Unique: tAbgtqP0OVieX9BuODYuOQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fe603e8054so10761285e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691508504; x=1692113304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovtijMkVZJcNyWwGdwYpTKXzS+g6b+kiQjjytk2RPVY=;
        b=NVbwxZ9Gim7C4CKtzwnJ4bK+8FELj6Ub+lmgIuaIyOGxAHklCt2bYrbq9aVsKE2Uad
         heLgJXfACplNbvh/snFkUPEHbSf9cd90e8teEI1iXgzNaqWDQsmPp6A/lRSQoMjn0kC4
         Ql2wEloVv9I6clZEE1gYbHo9TD5sfF8unUU75sgBVv3VeM3vDMFySo4y9gYtTyUKalrr
         /hRRj1ufUkbGHa3V8TWbyciuz4QSD3QhEyTLFbh6+ZhmyoDOLgE4puh/HbSP4eyQ0/F8
         0+OPFkKQLL7W4g1WTsvkwZNoFmwO9Jl2JTHKx17fTpGsHQuIux1lGbxpD6AXJ1fOhrHW
         CjtA==
X-Gm-Message-State: AOJu0Yy8+2Xy8TCTVEuGdJ1GktiRbJQpJAwaPhOL7IsNpOcqj7tmMtzU
        mFYAKbu+tv1F7wYP0y+TZpbqu0+NVUanNf9qqwU3Augb7xQ+hyiZMq1x8HqZ2kGRKgf6veHFXBc
        M6zibrMSzRPVsD3FbDW4Gkl9OHqYScv9gF30=
X-Received: by 2002:a1c:7709:0:b0:3fd:2d35:b96a with SMTP id t9-20020a1c7709000000b003fd2d35b96amr102420wmi.39.1691508504445;
        Tue, 08 Aug 2023 08:28:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpjCsZBjfXVVTdr/mD2H5KTLL1a+85ecgKiTnGDZwLvm+HvJjLR1xXBAXKwqaq7o3OdaJVVg==
X-Received: by 2002:a1c:7709:0:b0:3fd:2d35:b96a with SMTP id t9-20020a1c7709000000b003fd2d35b96amr102406wmi.39.1691508504123;
        Tue, 08 Aug 2023 08:28:24 -0700 (PDT)
Received: from toolbox.fritz.box ([2001:9e8:8994:f500:1291:b1be:fd68:2988])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c220a00b003fba6a0c881sm18602959wml.43.2023.08.08.08.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 08:28:23 -0700 (PDT)
From:   Sebastian Wick <sebastian.wick@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Aman Dhoot <amandhoot12@gmail.com>,
        Sebastian Wick <sebastian.wick@redhat.com>,
        Mark Pearson <markpearson@lenovo.com>,
        Raul Rangel <rrangel@chromium.org>,
        Lyude Paul <lyude@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "Input: synaptics - enable InterTouch for the ThinkPad P1 G3"
Date:   Tue,  8 Aug 2023 17:28:15 +0200
Message-ID: <20230808152817.304836-1-sebastian.wick@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 7984b43542070f5888546d95b48003c4a8af7c0f to make the
touchpad usable again.

Tapping does not generate any events for user space and moving the
cursor is janky. Disabling InterTouch fixes those issues.

Signed-off-by: Sebastian Wick <sebastian.wick@redhat.com>
---
 drivers/input/mouse/synaptics.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index ada299ec5bba..0e01df88cf69 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -182,7 +182,6 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN0099", /* X1 Extreme Gen 1 / P1 Gen 1 */
 	"LEN009b", /* T580 */
 	"LEN0402", /* X1 Extreme Gen 2 / P1 Gen 2 */
-	"LEN040f", /* P1 Gen 3 */
 	"LEN200f", /* T450s */
 	"LEN2044", /* L470  */
 	"LEN2054", /* E480 */
-- 
2.41.0

