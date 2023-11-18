Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268FA7EFD4E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 03:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjKRC6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 21:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjKRC6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 21:58:11 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B72120
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 18:58:08 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5bc3be6a91bso29617217b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 18:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700276288; x=1700881088; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ua0IE78OI3V4iuwp2QSoKWUWADgF+ZXc9DJoA62znV8=;
        b=F3jRmmh2EUK+OfbPUNe20oapoSvEhNicFeHmxJ/ixVlLf1ZBkP22OAHd1hmZUCvZsu
         1VaOG1HutflZuwff1N+aB+ElGpfYHHU4huPgCGLS5IZyL4BRRPQ8VynifDc2AdQB3/AZ
         LQr8z+SzK+8PjJn21ItvbT/PJLJ3KSP9engLbXThkfCdz9Z12vPovpZ/s8mLqf9A+mXq
         wEG/0DJy8KVjt0wODrqkkmyxJO2w+loCUzYFLF6rD6dw6h9bxF5mjwovRIMujp1TbwC4
         WYN/glhBqY5rX8A4edfLXeIaR7hNqbYMSTGlnh669YFyHe0NwOxbEmVhM3L7YXwH/IKe
         ou1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700276288; x=1700881088;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ua0IE78OI3V4iuwp2QSoKWUWADgF+ZXc9DJoA62znV8=;
        b=aCPZQa2DRY4KobAkV78LsXJpuFRkivk3xb0WLBMgVYzbVYr7O85p5byZcR9RaqpxqZ
         5BM4/FMfXUOer7zPEfgWYECZve9Lmz0fGJhJOugHVPOuGHFgnmgEYqw5fjiCT+Eaz0Sz
         P7UdCSWZLhjc+DKT43tn7ZMsIPS+vy52F9jrGC/SZmCsGcKvLafg014/U6TcuXu3mIvU
         xuJtJOi1N8sbJ6LLBkemtNqT1Ii/q8oEbllR+fViyF4HHDTsOfFnD3JJmWWw77cE0AYX
         ixUrbnR/+qJR9XMQy08Sb+soqkBABRdlNUV6x7yy+fJtBm1TxWvQRxLKVzTFRKlQHFrh
         uiMA==
X-Gm-Message-State: AOJu0Yx5dH2zQdrtC8YDO7oq0xL7zXcift3nZhTmK0H4VyQnVvgx5A/g
        4FgCrVk+HkjyGz0v6MmauZ6fJ1kDaFry
X-Google-Smtp-Source: AGHT+IERm4l8aRNMXSza7sGbPFbUkdTe33rpYyqpHWn57Z3BfKIw6SvQM+EZkHQPY3+Yu4peV7KukI7LkV3P
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:e6c1:0:b0:daf:3e84:d016 with SMTP id
 d184-20020a25e6c1000000b00daf3e84d016mr29963ybh.2.1700276288083; Fri, 17 Nov
 2023 18:58:08 -0800 (PST)
Date:   Sat, 18 Nov 2023 02:54:42 +0000
In-Reply-To: <20231118025748.2778044-1-mmaurer@google.com>
Mime-Version: 1.0
References: <20231118025748.2778044-1-mmaurer@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231118025748.2778044-2-mmaurer@google.com>
Subject: [PATCH v2 1/5] export_report: Rehabilitate script
From:   Matthew Maurer <mmaurer@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org,
        rust-for-linux@vger.kernel.org, Laura Abbott <laura@labbott.name>,
        Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* modules.order has .o files when in a build dir, support this
* .mod.c source layout has changed, update regexes to match
* Add a stage 3, to be more robust against additional .mod.c content

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 scripts/export_report.pl | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/export_report.pl b/scripts/export_report.pl
index feb3d5542a62..dcef915405f3 100755
--- a/scripts/export_report.pl
+++ b/scripts/export_report.pl
@@ -55,6 +55,7 @@ sub collectcfiles {
     open my $fh, '< modules.order' or die "cannot open modules.order: $!\n";
     while (<$fh>) {
 	s/\.ko$/.mod.c/;
+	s/\.o$/.mod.c/;
 	push (@file, $_)
     }
     close($fh);
@@ -120,10 +121,14 @@ foreach my $thismod (@allcfiles) {
 			next;
 		}
 		if ($state == 1) {
-			$state = 2 if ($_ =~ /__attribute__\(\(section\("__versions"\)\)\)/);
+			$state = 2 if ($_ =~ /__used __section\("__versions"\)/);
 			next;
 		}
 		if ($state == 2) {
+			if ( $_ =~ /};/ ) {
+				$state = 3;
+				next;
+			}
 			if ( $_ !~ /0x[0-9a-f]+,/ ) {
 				next;
 			}
@@ -133,7 +138,7 @@ foreach my $thismod (@allcfiles) {
 			push(@{$MODULE{$thismod}} , $sym);
 		}
 	}
-	if ($state != 2) {
+	if ($state != 3) {
 		warn "WARNING:$thismod is not built with CONFIG_MODVERSIONS enabled\n";
 		$modversion_warnings++;
 	}
-- 
2.43.0.rc0.421.g78406f8d94-goog

