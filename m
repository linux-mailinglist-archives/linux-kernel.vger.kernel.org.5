Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0300E7B120E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 07:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjI1F1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 01:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1F1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 01:27:16 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1863C98;
        Wed, 27 Sep 2023 22:27:15 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-577fb90bb76so6789703a12.2;
        Wed, 27 Sep 2023 22:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695878834; x=1696483634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2p2z7A/m94fJlY/YCyPmolz6NyjAMwcybhIRjtSPtC8=;
        b=CTFv2+/5jmmP6xMwZ9DfYbjz4VBH5T1lrpoOsvDrShujhn56M59UK3zT5/gTMnT1c8
         GCBIq4ukdp2dRbMwL9aSk5iVSQuqnkYiJMxj4zD8WSPoWHQXPA3UUBVA/SwTbrLjbTG1
         PGrd8/dkc3zcHrG1nSsQ3mZt3ZSC/drWvN2nMcyNOaBfouI4OurCzaidDHxaydW/Wgch
         uXKMz2pZL7yedOAfeOXUGXTI1EAx2IZaOF16YkKema3f0/falXPyQmanKMERx8UJIrJ/
         PnIpddA24KJoE3cgXcN5ZUm4sAVAnZM1ro0M94Ad4/lYK/PrVfr4ZbHnOLxuU3zqYa8d
         gySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695878834; x=1696483634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2p2z7A/m94fJlY/YCyPmolz6NyjAMwcybhIRjtSPtC8=;
        b=TabTufuNKEb+rVWy1yMX9TELxI5Tld994/deFA6yhobcj/qWKGEo5C/OZyCoFyIpkY
         U41RAmOHyLi8/KIYqCZIYCl/SFHOhVsqiYfI9Jctsps+MxotLcv9+B28BHErzrBkNf76
         ucrxWw+4kyy6whvlqNOz3yIM2aDRGkHbQSx3yP9GygtH0ieuH/2YYYqbxiruqbXr7LvS
         fsFWcUfZBIv4glxTghPjTBeH1dmaOxKp0OVbBFuEX9vy3cKrmny/7kbpZRTvbwRZ3yud
         4uXmCWlKbHupEPDuBCKV0RwxZMZPLebk2memUPi8sHnSsRUox5hznmkgXW5Qo7Enyb9a
         IfsA==
X-Gm-Message-State: AOJu0YzaqXd0pkxoHotrnQuwrv/eenTo+zSUupae2MRuyoC0CSJMtJzL
        VQgprUvZueH+AS7Ys71OG1o=
X-Google-Smtp-Source: AGHT+IExjFDG5flDN+mT/u/PJm+C7/4MHZ1JI88VcmNeM6b5kZkmxAReYsCqgeFEUy7Ta/cf7UrgCQ==
X-Received: by 2002:a17:90b:1009:b0:268:7ec:51ae with SMTP id gm9-20020a17090b100900b0026807ec51aemr186513pjb.41.1695878834452;
        Wed, 27 Sep 2023 22:27:14 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id t11-20020a17090a024b00b0026b70d2a8a2sm8997647pje.29.2023.09.27.22.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 22:27:14 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 5B8B3816018E; Thu, 28 Sep 2023 12:27:09 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Networking <netdev@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        kernel test robot <lkp@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH net-next v2 1/2] Documentation: dpll: Fix code blocks
Date:   Thu, 28 Sep 2023 12:27:07 +0700
Message-ID: <20230928052708.44820-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230928052708.44820-1-bagasdotme@gmail.com>
References: <20230928052708.44820-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2341; i=bagasdotme@gmail.com; h=from:subject; bh=mfk4yNlrSNx4x3xH+ptdTgkFQ+eyBO67TFNPT7C/BM4=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKmivLHJq3KnLTgkbbbuW/hXoZcSPLJzShZdP/t7y7E2D 9UOrxlaHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZiI9FFGho8+TE46S5W/NFwr boxhebXP/nX8cfW9u1yTplzoM3l4U4ORYdPN03c7mfpvB9Q8+mSXXzntu+zTTYde9ByKiGL6vcH CggUA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot and Stephen Rothwell report htmldocs warnings:

Documentation/driver-api/dpll.rst:427: WARNING: Error in "code-block" directive:
maximum 1 argument(s) allowed, 18 supplied.

.. code-block:: c
	<snipped>...
Documentation/driver-api/dpll.rst:444: WARNING: Error in "code-block" directive:
maximum 1 argument(s) allowed, 21 supplied.

.. code-block:: c
	<snipped>...
Documentation/driver-api/dpll.rst:474: WARNING: Error in "code-block" directive:
maximum 1 argument(s) allowed, 12 supplied.

.. code-block:: c
	<snipped>...

Fix these above by adding missing blank line separator after code-block
directive.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309180456.lOhxy9gS-lkp@intel.com/
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20230918131521.155e9e63@canb.auug.org.au/
Fixes: dbb291f19393b6 ("dpll: documentation on DPLL subsystem interface")
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/driver-api/dpll.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
index bb52f1b8c0be31..01eb4de867036f 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -425,6 +425,7 @@ The simplest implementation is in the OCP TimeCard driver. The ops
 structures are defined like this:
 
 .. code-block:: c
+
 	static const struct dpll_device_ops dpll_ops = {
 		.lock_status_get = ptp_ocp_dpll_lock_status_get,
 		.mode_get = ptp_ocp_dpll_mode_get,
@@ -442,6 +443,7 @@ structures are defined like this:
 The registration part is then looks like this part:
 
 .. code-block:: c
+
         clkid = pci_get_dsn(pdev);
         bp->dpll = dpll_device_get(clkid, 0, THIS_MODULE);
         if (IS_ERR(bp->dpll)) {
@@ -472,6 +474,7 @@ The registration part is then looks like this part:
 In the error path we have to rewind every allocation in the reverse order:
 
 .. code-block:: c
+
         while (i) {
                 --i;
                 dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin, &dpll_pins_ops, &bp->sma[i]);
-- 
An old man doll... just what I always wanted! - Clara

