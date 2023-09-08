Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A15799226
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 00:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245534AbjIHWWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 18:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245716AbjIHWWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 18:22:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D7D1FDA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 15:22:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7ea08906b3so2641782276.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 15:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694211765; x=1694816565; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v5Cp90T0HlHlM0qC1hGQ5/U223gFFo3yll8YGs+M5Ps=;
        b=wTH73xfC5sR0hHLUTvDc2/m2mxqoHxkQey+iy4hqKadwoQ8TxF+KO054e3OWfypwky
         ruG2ueEh4Kg654e5MUSHGtaeaYZbKmW2rT20+yF8tUjSI+9zIZd9l7j7yIP47T9AlI/W
         lCWikjAu1OI3jkedQTfyNrEvRXN+pvHxAg1JLPhswppt5maG8gOjDyo31Nh2RZ8u3KED
         KpWtKXPcDuNBZAJVH5F9FTQo3KriqTwndFBHkOsAbxKjhX9yrvLCr7s37r7CYKPEL0Pz
         mgEDxyeD9vdFltGdIUN5qwBy5WJmXmF05ya6K4Xtc0LUOIcPkBE7zRLKLolOyIPJSk0n
         7Ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694211765; x=1694816565;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5Cp90T0HlHlM0qC1hGQ5/U223gFFo3yll8YGs+M5Ps=;
        b=JWgVdIhBuv0qJ2ei1UT/vjKO8ybIyPb+DIqQyjXQPLwT3aho6DJxpxpeY71LZikZ56
         VAHxccXo7QkE0zoSobbB9M26RGe8faPYO8BNAFrw5ArQCQWWGoKcqR7HhQg0Fi1erZ4V
         JXsq4Quy43eujjwRC+Z7ZGebZhRDSEBMXLceyLMBRj7EMG4XKguKHHOZOfyKYD16gE0G
         IYS/wXhRfNgeUtDutQF5hekn/BCoVMHiwhtBH7ecmdEYd+kxxzAxWyg9ONc01YImoQFc
         x0a4y+2JNI3GACWaN5dpXSaEqd3S2Rrrlmc8FnkvPwmnv24792OzxtyfirbSQEMwWgT/
         wLtg==
X-Gm-Message-State: AOJu0YymfZEqTzVp98ZM4dsjYsY6PYR8X1T1GL3wl11v10AhXzZJQY0r
        TtZPTu6YUy4fjB4hxJlzdWpbDIvNJKrL1FESag==
X-Google-Smtp-Source: AGHT+IFPFnTyGsFoc2ZSx47UoKkXlKTd1lUGjg7l0A9M/UItmxbV7iwmacXunuMpKmXV7s1YWdzHQiesT5QQCTmmtQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:b29a:0:b0:d7e:91ce:4619 with SMTP
 id k26-20020a25b29a000000b00d7e91ce4619mr72493ybj.2.1694211764994; Fri, 08
 Sep 2023 15:22:44 -0700 (PDT)
Date:   Fri, 08 Sep 2023 22:22:40 +0000
In-Reply-To: <20230908-kselftest-09-08-v2-0-0def978a4c1b@google.com>
Mime-Version: 1.0
References: <20230908-kselftest-09-08-v2-0-0def978a4c1b@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694211760; l=819;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=Fpue+BQes/IsmvChTzta8giCoFG0nhFAwjMFha0XbBk=; b=FPcBxS7/Tinifrs92XiVf0HUjlKN++LkVXDHzYy0yvRwYAtxE2iVOoZp9QZgBtlGeGYK7eftL
 gV450GrArSzCjcFyglvip5hagZgozWtKZAOu4zZvAOoQH8odEMQi2tg
X-Mailer: b4 0.12.3
Message-ID: <20230908-kselftest-09-08-v2-3-0def978a4c1b@google.com>
Subject: [PATCH v2 3/3] selftests/hid: force using our compiled libbpf headers
From:   Justin Stitt <justinstitt@google.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Eduard Zingerman <eddyz87@gmail.com>, linux-input@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Tissoires <bentiss@kernel.org>

Turns out that we were relying on the globally installed headers, not
the ones we freshly compiled.
Add a manual include in CFLAGS to sort this out.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index c5522088ece4..b01c14077c5d 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -22,6 +22,8 @@ CXX ?= $(CROSS_COMPILE)g++
 HOSTPKG_CONFIG := pkg-config
 
 CFLAGS += -g -O0 -rdynamic -Wall -Werror -I$(OUTPUT)
+CFLAGS += -I$(OUTPUT)/tools/include
+
 LDLIBS += -lelf -lz -lrt -lpthread
 
 # Silence some warnings when compiled with clang

-- 
2.42.0.283.g2d96d420d3-goog

