Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5DA7A6C63
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 22:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjISUip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 16:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbjISUio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 16:38:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E6CBA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 13:38:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7e8bb74b59so6679357276.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 13:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695155918; x=1695760718; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tbuv3yAsMwGHjewKzCIjCL5MGM7AzGA9bemOVcUbEtw=;
        b=vTlpinQ1uyNdslmHPeVY/OdfcegAHquCm8KI6vuL4BGvcWUYbxRXPmpvb9OYE3HEMA
         vjAFki1OPSZluj+J3XUcFNMhrRe8NzeLPoNcvBhFd1uGHZY4zP2YZhjmC4XNcF7bYV8z
         34Mjsc8Jd5zj2xaAspTjz2TQRI68xN2lTOQredDqgGTt6uHld1U5u5Jf6xEnIuW2I0ZG
         5gQVXFgfuHEeZlbyB+QhDx1sj4fTw2hsZ4UDF8uvXSFM3IKDQDN41Tz0nOMIKOit0hKn
         Oj7uGRpThOckAb8QOfbOfkgxKYB80T19z0SmCYTujDiO+skJjGy4PlSnXEa+S84l//P6
         m+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695155918; x=1695760718;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tbuv3yAsMwGHjewKzCIjCL5MGM7AzGA9bemOVcUbEtw=;
        b=Em6QmSIjgLYU7NxKy/BLQCTA2OOLj7nYehzEVMp2i0Y422fUsis6rI5OE1zesq4LkP
         YLhqpVELsPjKXxd5TIk8kAIGUvPvcrWycmq2EzpAHg7wM5Q3H5iwWqSsdNTU2IqfBTLT
         5pbKo/0AVHH+VRCSk2bmqp/6btDV14CCX/3QL9yn7hsFZzn5VdCAqRX/QVY35O/PbMiw
         GEUbNT3fPLY7OAAw/kY4yoTC8x7FEy+7vlqo6PjK2QVxE3vrbfs11u07UfQkZ0jnvePf
         xVIQisiIQzkaA8IxEq4ik73blPWXRVoEdx7/kxD2S8+zJy1XL7x+tXEMXQEGiA73IaCD
         ASfw==
X-Gm-Message-State: AOJu0YwjoS2AsShA9WOYeZT0H2/9OghW8h8+W2NbFX79Dxlm2BnfkrwV
        ptWFD+4QlJe713KijyBDu5S6vf/ptGKwuxml/2g=
X-Google-Smtp-Source: AGHT+IH1qq6nUKqNZAK0YbjQJqKgVehqq9+7WX6fVL5KBywAr2lAwKAHSABqQpymxSSriK5MEDbTCsc7ZmInmh67k3U=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:118e:eaf2:1433:f9fe])
 (user=ndesaulniers job=sendgmr) by 2002:a25:4109:0:b0:d35:bf85:5aa0 with SMTP
 id o9-20020a254109000000b00d35bf855aa0mr9310yba.4.1695155918049; Tue, 19 Sep
 2023 13:38:38 -0700 (PDT)
Date:   Tue, 19 Sep 2023 13:38:31 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMYGCmUC/x3MMQqAMAxA0atIZgu2dVCvIiIxphqQKg2IULy7x
 fEN/2dQTsIKQ5Uh8S0qZyywdQW0Y9zYyFoMrnG+6W1vFkLaOeisfIQZVWWLxiG13rYeOyIo6ZU 4yPNvx+l9P2dmiUVmAAAA
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=eMOZeIQ4DYNKvsNmDNzVbQZqpdex34Aww3b8Ah957X4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695155916; l=1046;
 i=ndesaulniers@google.com; s=20230823; h=from:subject:message-id;
 bh=Co/d3mAUVcLoGAAxSpLDv73hB10uZG4S2eLmRtrW6TY=; b=55wTFO4UFDKkYg4VeCIdNLlPDaZUcDJbyBYyI/JJ4cuZJm02dpFVSLxRA8IvgcWjAN7a9rKfD
 p9b/a62WkELB2UmQHLhRA+StthSwDn8/+l73C3FnJQvt2yXqZP7PRIC
X-Mailer: b4 0.12.3
Message-ID: <20230919-bcachefs_self_assign-v1-1-830936792fc9@google.com>
Subject: [PATCH] bcachefs: Fix -Wself-assign
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>
Cc:     linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following observed error reported by Nathan on IRC.

  fs/bcachefs/io_misc.c:467:6: error: explicitly assigning value of
  variable of type 'int' to itself [-Werror,-Wself-assign]
    467 |         ret = ret;
        |         ~~~ ^ ~~~

Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 fs/bcachefs/io_misc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/bcachefs/io_misc.c b/fs/bcachefs/io_misc.c
index 668493bcfe36..32432bdddac4 100644
--- a/fs/bcachefs/io_misc.c
+++ b/fs/bcachefs/io_misc.c
@@ -462,9 +462,9 @@ case LOGGED_OP_FINSERT_shift_extents:
 				bch2_logged_op_update(trans, &op->k_i));
 	}
 
-	fallthrough;
+	break;
 case LOGGED_OP_FINSERT_finish:
-	ret = ret;
+	break;
 	}
 err:
 	bch2_logged_op_finish(trans, op_k);

---
base-commit: 29e400e3ea486bf942b214769fc9778098114113
change-id: 20230919-bcachefs_self_assign-2ac43143a8cc

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>

