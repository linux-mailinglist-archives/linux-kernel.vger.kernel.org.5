Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8C67B5E43
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 02:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjJCAef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 20:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjJCAee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 20:34:34 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47D4A9
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 17:34:31 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-58907163519so199654a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 17:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696293271; x=1696898071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CLzLe9FrFcSRLQYLz3TN9yC6YJWYh7HG+BIh8jZ2l60=;
        b=HnQh4T3p/vE5WqynEIcE7TWODe1xkpGqe/qomHTMdx4eSkMxvnT7LFMkXxV1CGozny
         uah4wIcdCOz7ihnNwi7MXRLCgidIJpDJbciasla6ZASRW9E4eskC0s9CmKIVOftsbgWn
         VgDucmK1T1FQ0EauoBXMC5fyQu0evPj5eWmZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696293271; x=1696898071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CLzLe9FrFcSRLQYLz3TN9yC6YJWYh7HG+BIh8jZ2l60=;
        b=gSI9KC8F+G8x3+A7Cs6C/hhELO1yuSNgykVWsKOnaMs/ZJ2h/4RQnMnFxL+2WCjjfa
         yIp9eQXkwD4C0T9W4RnEQ3uwbw6PrODz6+dYSeZwa0SdVkl3ZwYHLCdXL/FfdLb0zUeO
         njhdhCHVvLv0eHi7pKY2NApty+ko9jECrppBU/fckgX4Ow5FCVBgyK8SJw3IgmVI6uG+
         vUdbUJnm/i9IHSLqgOEd6U4K5PBDmAzQJ7O4jlDsObhGw0HcX0dmQQP/WfgtLVJWGKJJ
         p4JZgcR7fCKGbmPy9bFpP86pOgfQpViH7GdV5kom0W14GoavktleH0OXAvbslQ81VrCN
         nUeQ==
X-Gm-Message-State: AOJu0YzhfVqVk5JuupPlndP5oivTZEs5iB6aXXkcxglkIS0OVwUKadXM
        VWCxMV89j4/+RYIQ7m5T6wSukQ==
X-Google-Smtp-Source: AGHT+IH9X2WMxnOuNE9ItsTdLVOGQrsDzZs7Y+RgdoCxMjPQ14Zoimq0BAGrTodLKwpbqhDegXssXQ==
X-Received: by 2002:a05:6a21:1f20:b0:15d:6ea0:82da with SMTP id ry32-20020a056a211f2000b0015d6ea082damr11124826pzb.33.1696293271241;
        Mon, 02 Oct 2023 17:34:31 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:f676:8db:8677:aefe])
        by smtp.gmail.com with ESMTPSA id bm2-20020a056a00320200b0068a13b0b300sm101368pfb.11.2023.10.02.17.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 17:34:30 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev
Subject: [PATCH 0/4] platform/chrome: Random driver cleanups
Date:   Mon,  2 Oct 2023 17:34:24 -0700
Message-ID: <20231003003429.1378109-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's some random chromeos driver cleanups that have been sitting in my
tree. I've noticed them while browsing the code for something I'm
working on.

Stephen Boyd (4):
  platform/chrome: cros_ec_typec: Use semi-colons instead of commas
  platform/chrome: cros_ec_typec: Use dev_err_probe() more
  platform/chrome: cros_typec_vdm: Mark port_amode_ops const
  platform/chrome: cros_ec_proto: Mark outdata as const

 drivers/platform/chrome/cros_ec_proto.c     |  2 +-
 drivers/platform/chrome/cros_ec_typec.c     | 18 +++++++++---------
 drivers/platform/chrome/cros_typec_vdm.c    |  2 +-
 drivers/platform/chrome/cros_typec_vdm.h    |  2 +-
 include/linux/platform_data/cros_ec_proto.h |  2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
https://chromeos.dev

