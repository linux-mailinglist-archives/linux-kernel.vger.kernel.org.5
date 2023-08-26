Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E56F7897AF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 17:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjHZPQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 11:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjHZPQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 11:16:22 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884C9171A
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 08:16:20 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-573675e6b43so289537eaf.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 08:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693062980; x=1693667780;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SfmfX8y4suuxxYB42Bu/PClc6bkVL6Z00B4RiTnt8xI=;
        b=L7LnsOgwWbNlgsGKgh1RQjFFH4TkfEIgREvE+uQ+9fpjbxljh2PaFgQYCbzTXFr7Fs
         e8PFAuz+LpjHsQ0F+IfUyGCTtgO6pLKLmJmvopyBZe259yBxZOSFYTLpP6opR+xV1KTY
         UIRu/nj0e+3rBuxPWk9vuvwQ+jeXANcdATyh6mCqoY0BX/ll+B1G6idTmxUSSYex3396
         PeAAPyLz/KIWLZcfkTLjZO6/YxnXFDaDpcOYFgPA7hc90W25Z/2JVQaEX3Fg2VB2Hth3
         ZDEGskg8GiruTcPm2uXSEnfqMiazVq9/ygZFK8q8NqNFkRxjFDkG/mw+ShghoVJFgmCy
         AvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693062980; x=1693667780;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SfmfX8y4suuxxYB42Bu/PClc6bkVL6Z00B4RiTnt8xI=;
        b=BtrgW9vDqBp8eA3L1VTWKBU9k1rQOsDxuVIT5HjoRAZon+F90xSZw4FlwAaCvIl4W/
         Op6dskrXVLyMCxHnGVlZqSdsEckTgvOq8RUzuhWDhYwPEu225uDVn678/9qhIKlDyhfs
         MzSeja7ixfYbb0bolvCWbhRPHtN4LHMv5pU5VewAHPnuPHX4q1tww2KaenmSv1hF9tFM
         5ogZSpKolY+2GX3eOIelg3AtD/nAJzSYRuBXYSIX4jsqkyywiv4HSTZXfVtFy+VEaOQf
         CrLhOcWmfr2N96g9DRIZ1Q+49CheT0KDXlpox55wr00YgF9CfbAsTmRoIqW7qLfQPkBk
         r1Wg==
X-Gm-Message-State: AOJu0Yx+0Tu0zO4Gv6hiw5uSPLqpxwQg9El6AujazO341Tze8y38KeNO
        Dv04mDWv+xAGxekwnWWR4jM=
X-Google-Smtp-Source: AGHT+IHnoQkuq2Dxh/yd+t9QK4MX/uUIiw8dD8tvrP054uia23peRbBDWmfv9Wu08d298DuPJZQz2A==
X-Received: by 2002:a05:6820:41:b0:56e:5a8e:654f with SMTP id v1-20020a056820004100b0056e5a8e654fmr7898675oob.8.1693062979763;
        Sat, 26 Aug 2023 08:16:19 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:82ea:8c7c:b784:3f92:988a])
        by smtp.gmail.com with ESMTPSA id c206-20020a4a4fd7000000b0056e9ffefee9sm2103688oob.3.2023.08.26.08.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 08:16:19 -0700 (PDT)
Date:   Sat, 26 Aug 2023 12:16:13 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v2 2/4] staging: vme_user: fix check lines not ending with
 '(' in vme_fake.c
Message-ID: <ZOoXPVHQInOz4gfh@alolivei-thinkpadt480s.gru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed all CHECK: Lines should not end with a '('
as reported by checkpatch to adhere to the Linux kernel
coding-style guidelines.

Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
---

Changes in v2:
- Fixed summary phrase with tags to indicate commit order
in the patch series, noted by Greg KH

 drivers/staging/vme_user/vme_fake.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index a88d2c8a785b..dbaf050f88e5 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -403,8 +403,7 @@ static void fake_lm_check(struct fake_driver *bridge, unsigned long long addr,
 				if (((lm_base + (8 * i)) <= addr) &&
 				    ((lm_base + (8 * i) + 8) > addr)) {
 					if (bridge->lm_callback[i])
-						bridge->lm_callback[i](
-							bridge->lm_data[i]);
+						bridge->lm_callback[i](bridge->lm_data[i]);
 				}
 			}
 		}
-- 
2.41.0

