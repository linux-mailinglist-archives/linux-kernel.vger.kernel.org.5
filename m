Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684367AF9EF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjI0FTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 01:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjI0FSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:18:47 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676301E97B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 20:19:29 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59e78032ef9so210702967b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 20:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695784768; x=1696389568; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XvH7PL3IpModIaBYSEYbzRLGYczZCvDsof3AAq/Ed5g=;
        b=OnFJE9kRJEMfnj+J8Dazd3JtLlJOfuWeEGIJ75lxe9pSGvoYTig6LWVxRmD3WV4UDd
         ngpzt3poF50HsYl6XPmP6V5dOtwjoON53X4i3J+ne2MWuiRGY8JDeGvTRH44tiMRBw6w
         CMsW1fjm5hBTtypzISnFucs3S+9VeIlM+sspcbeCrr974+I/xgITt08KWV4nHXmnd91/
         nqb3qajN2PynCDpFIq65MTKNg31QKAS40pxEPbFO05imvQ1BMkw9OoLCjTVg365ud/sc
         pnpQz+hX7O0y/GIoXNw1RM0jrb0A/pbBvJWxfoChdvF2vm8F6Hts2mts1Z0u/Ybd28N2
         IYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695784768; x=1696389568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XvH7PL3IpModIaBYSEYbzRLGYczZCvDsof3AAq/Ed5g=;
        b=FB6L94eZ6pw2MxoQhzqlW04nfC8T5GVMJFiT5Zr/HQfoX3bQktH6wv0H0AQAPbhNib
         x2gwhc9I4UWRx04czncJY55xNxbDoBgTz+TqWpX8YH4NKpR5pqLLKtcdCUcy67QqMRs9
         0yvPPmEu6DUATkNNWJriHFtm7rPTRteHI+XpArPg3iKkSVux05I15iRFlC9I5W+zFge+
         XO/TAHH+hBPuC1ZoR8BVifuFA8ZS8jGKDbSj/JcUNol8BTeEFp5nRv5l8oWpn09rPsgU
         xYLzdKShTLbFt+vRASC3pFVzZ6qVLNAH+VG+4Qy0KynTkiR2teFb3TH56Of1egH3sgcb
         xRKg==
X-Gm-Message-State: AOJu0YzC0vLw3+qaqCo8FY+pvMbY0GxOMXODKr+eMPwJHj5KDnn+WC/2
        RS3QA3/lOSpliTFY+IaYjrwMHTCcAgnJJm5B7A==
X-Google-Smtp-Source: AGHT+IGX4aoZtFbXWqtcc89JYRugDUdZL8Q0ZVg1uDzMCVnMVhOige2x8o48WdF4wz747v/NdVDp0Nfv9lnj33uqnQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1682:b0:d81:78ec:c403 with
 SMTP id bx2-20020a056902168200b00d8178ecc403mr8895ybb.12.1695784768704; Tue,
 26 Sep 2023 20:19:28 -0700 (PDT)
Date:   Wed, 27 Sep 2023 03:19:14 +0000
In-Reply-To: <20230927-get_maintainer_add_d-v1-0-28c207229e72@google.com>
Mime-Version: 1.0
References: <20230927-get_maintainer_add_d-v1-0-28c207229e72@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695784766; l=763;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=2rn2uSI1b/tbHIH/62Nxy5AAUtpBQ8U5oR+vuYQXIoI=; b=k5mgYo0NjhNugGvWFfhtXCMelIJg2LvlsL9wPmo4rkG4DGHOlWQBB/INT2DnhE1URuwBK7bcG
 skiIAN+HNkDDW8yYsxqZez8N7mkqSxYepGVQRhwoni0TZfLCcmEuIfO
X-Mailer: b4 0.12.3
Message-ID: <20230927-get_maintainer_add_d-v1-1-28c207229e72@google.com>
Subject: [PATCH 1/3] MAINTAINERS: add documentation for D:
From:   Justin Stitt <justinstitt@google.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        workflows@vger.kernel.org, mario.limonciello@amd.com,
        Justin Stitt <justinstitt@google.com>
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

Document what "D:" does.

This is more or less the same as what "K:" does but only works for patch
files.

See [3/3] for more info and an illustrative example.
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b19995690904..de68d2c0cf29 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -59,6 +59,9 @@ Descriptions of section entries and preferred order
 	      matches patches or files that contain one or more of the words
 	      printk, pr_info or pr_err
 	   One regex pattern per line.  Multiple K: lines acceptable.
+  D: *Content regex* (perl extended) pattern match patches only.
+     Usage same as K:.
+
 
 Maintainers List
 ----------------

-- 
2.42.0.582.g8ccd20d70d-goog

