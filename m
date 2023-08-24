Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFEB786EE0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbjHXMSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241376AbjHXMR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:17:59 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BEF10C3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 05:17:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58fc7afa4beso58629437b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 05:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692879477; x=1693484277;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KP7y6xS6EFHEJD5ANOsIHEjcqhTfR7Dpy+3v2gjFgyY=;
        b=UMtHQkS/ey4DpMdWtgP5LwllfbAVxuMAoWhQZHsaXaSYMLix3t9gZvpG/W21f6mEps
         TNW7+egSQbh+0zzlYZltZOBB0mu8X6Gj9S7WtVu2v7lCvVHqWFwfajx74vfLLU/I2vnV
         /7s6svNL59xMHt0d8X+TLXdXnhtxfrHV0+9kJSaMtfnwAY54ParHC9+Hr9fwYD5u20ZM
         UurbI9wKIUOGimBupFc2CGmNz5V1mgXzH52UrCQfIQqWuLewG6Q74WjHZgvhA1UDBxPy
         DxwIQPHO6zPcY6rY9jcTI3SDXm4ka+xNHUweW90/8/RIGUNVxtKCp+KQVJ5hzDuy1c1Y
         eAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692879477; x=1693484277;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KP7y6xS6EFHEJD5ANOsIHEjcqhTfR7Dpy+3v2gjFgyY=;
        b=OSF4xt/QtWcxjWz5SAIP7RYdHo3nQ4jP+d3IaaM0XzD6T423BNtGdLxTzPgDA0ufqZ
         F73tpQ6Hcb8hBCV6jow81En17LeZZExUF8g7Ckl+rGE2uTMUece8bWIvCPzYf4nlGpU8
         fYVKbw2+xPG9+mD5wKxZdnywNLzPx+s5qt2W4m6HUT1XEVpszqNYvvWQ04hBHukZU+Kx
         eyk+K+qrYQsJS5Lf4saDeC7hS6gbehuqm78lxTxl2fbk2kqM7ghthsKj++NDPaZdZjW6
         UuHcIKLSQj+kkrXgJubc3OtFhPatHALwhBLAPaEeMzJ1HCi0HcTgugF2mCOtuuCpG9Q/
         hoHA==
X-Gm-Message-State: AOJu0YzAUF91kixUriZof3QuzN9Io6pRgGbzbXYfdxfFGp6ef/2XCgi8
        2T5ADGtSXDu01IMs/cEIhnS65bVCzG0uioTurIo=
X-Google-Smtp-Source: AGHT+IF3z2wEeCYH+Om8XvhbYFhK4S57qe5S2yEIbQwOdxhgmClFm+0mVk9nJOwv0d4aDC6xSPifkwgP6ttLcgKi+m8=
X-Received: from anikett.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:2551])
 (user=aniketmaurya job=sendgmr) by 2002:a05:690c:710:b0:592:7bfe:d479 with
 SMTP id bs16-20020a05690c071000b005927bfed479mr42254ywb.5.1692879477085; Thu,
 24 Aug 2023 05:17:57 -0700 (PDT)
Date:   Thu, 24 Aug 2023 12:17:48 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230824121750.1673566-1-aniketmaurya@google.com>
Subject: [PATCH v1 0/2] Add support for array and optional APIs
From:   Aniket <aniketmaurya@google.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org, joychakr@google.com,
        Aniket <aniketmaurya@google.com>
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

These patches introduces APIs for managing multiple mux-states
using an array. Since for mux-control the state is not defined
in DT and needs to passed when selecting in driver, array like
wrapper is not possible.
Also provide optional APIs which returns NULL instead of error
when DT property is not present in client drivers. Ensure that
select/deselect operations pass for such cases.

Aniket (2):
  mux: Add support for handling array of mux-state
  mux: Introduce optional variant of consumer APIs

 drivers/mux/core.c           | 185 +++++++++++++++++++++++++++++++++--
 include/linux/mux/consumer.h |  29 ++++++
 2 files changed, 208 insertions(+), 6 deletions(-)

-- 
2.42.0.rc1.204.g551eb34607-goog

