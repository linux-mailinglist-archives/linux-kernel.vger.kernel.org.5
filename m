Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593AB7E816E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346045AbjKJS2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345962AbjKJSZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:25:53 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DBD3289E;
        Fri, 10 Nov 2023 04:07:26 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507975d34e8so2758778e87.1;
        Fri, 10 Nov 2023 04:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699618045; x=1700222845; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziu6y5kMWv25GqkZtPQxmr/4uKotFiq7lYQMCanhehw=;
        b=GJNOg6JdwHbJLE1SvQTaHaYcFu5uJ7ftggt4YpQ/yOIDpvbhxgnJCJWKc6ft+ce5MY
         DWAoW13R3nuwXJH9AE6TjqOzM97Ikfppn+lmE0z2d/kqnanka4VYAy3JKAjqFSPfU1Yd
         MjnWkO0ieaE2NbvPOqHGjvglpvz4mvtO7v3f15VZsVYyf9w+IA7AZByhFlYyn19V1LnJ
         0RTzPfOa3SjBlWNWneaoo81JStfyaq7p7xU7BtlJf8dn7qhAAqC7DchwJYz/Mm+Nousg
         i+JSkeOpw/VfidXoAVzmEip/Ix0aHOuEZkb4LSHhu41yy8wRmtg/JJCTlpOWzD8h8yzq
         ccPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699618045; x=1700222845;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ziu6y5kMWv25GqkZtPQxmr/4uKotFiq7lYQMCanhehw=;
        b=t9OvTR5gzJGEb1D8P8votE01/PTUcri5Opb1Ct8KbpIaTrYZEqkTKrfVXYa4ADWtz4
         6weILu+iIYYKEfn81j7ML5EMk9qG8hkKHIHUhxtizdAS3Ucr1tus5wFaGGN9MCJRgT60
         Lu0dYUAAc+5SKbOD22jfKrwNJwMUtAnNIuitp9xxs6BqvAtx39TUHqK8sHiOVt1/RrUH
         v4UTnavxRpixp9l6BOxjJ00K5/x0VgcxR9drNkn7r/TSQEMCIGM2GK6k1XOhV1khOhqn
         he+6awc4mn181JQXGA3G0JA9NenDImu65K/jodiSI0Kp2oystmsanKETz1/0VGRED7L9
         VMYA==
X-Gm-Message-State: AOJu0YyvWAvacoHgSgb3ZC0Ms7vQjGuJEVJaxmd2ZQaUxR5nu8hhebtl
        8AfC/Vy6TMIHQMeIf7Wma+E=
X-Google-Smtp-Source: AGHT+IG2ZkUZun9f/LdlHUkgkvZ6BN2lAKn/tL2UtyLIvTGStr7CM9zKixfGdPF9esMQlWXQdtiZ1A==
X-Received: by 2002:a05:6512:3087:b0:509:7915:a1d6 with SMTP id z7-20020a056512308700b005097915a1d6mr4844174lfd.58.1699618044689;
        Fri, 10 Nov 2023 04:07:24 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:cd7:bb15:91b6:862d])
        by smtp.gmail.com with ESMTPSA id j7-20020a5d6187000000b00318147fd2d3sm1801841wru.41.2023.11.10.04.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 04:07:24 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Helge Deller <deller@gmx.de>, linux-kbuild@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] linux/export: clean up the IA-64 KSYM_FUNC macro
Date:   Fri, 10 Nov 2023 13:07:22 +0100
Message-Id: <20231110120722.15907-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture"),
there is no need to keep the IA-64 definition of the KSYM_FUNC macro.

Clean up the IA-64 definition of the KSYM_FUNC macro.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 include/linux/export-internal.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/export-internal.h b/include/linux/export-internal.h
index 45fca09b2319..69501e0ec239 100644
--- a/include/linux/export-internal.h
+++ b/include/linux/export-internal.h
@@ -50,9 +50,7 @@
 	    "	.previous"						"\n"	\
 	)
 
-#ifdef CONFIG_IA64
-#define KSYM_FUNC(name)		@fptr(name)
-#elif defined(CONFIG_PARISC) && defined(CONFIG_64BIT)
+#if defined(CONFIG_PARISC) && defined(CONFIG_64BIT)
 #define KSYM_FUNC(name)		P%name
 #else
 #define KSYM_FUNC(name)		name
-- 
2.17.1

