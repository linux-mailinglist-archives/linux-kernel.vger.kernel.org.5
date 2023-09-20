Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C57B7A8CDD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjITT3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjITT3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:29:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394301B7;
        Wed, 20 Sep 2023 12:28:58 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-502934c88b7so389497e87.2;
        Wed, 20 Sep 2023 12:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695238136; x=1695842936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JamuYRg/bmHGo8DyK8kNadLYs1ZIGP2QJGW5LQhCWc=;
        b=Hh8BWqYObv5wesG9jZxqawXtYHAPXVP6jDHygiaBZngJGbOkBN3dmkWymAS6BASBw+
         cofSyZF6L339PeSjPOkcWYZEh3KPP2lebcOm4+0HSSnGHq5w4tkFfSxyz12ToBfKoLta
         w77xItzL7Dl1up9Nl2AO58k5tBrmQD97OWD1plKRBgIIayUDWywWpdpVGvE4ZmEGRWXF
         QKOwY6upbapkoYj4gVTXP6E+R+VlrAZXC/1EHeNyZzHdwdG7aN5e3XFLRZiuc/qxpJ05
         pWyVoKjiwVfBpvQygh9A7pqx7I8kLtrqchosPo8khf8lbx5orh7zFM8o7NFl1SZHciEb
         8R6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695238136; x=1695842936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JamuYRg/bmHGo8DyK8kNadLYs1ZIGP2QJGW5LQhCWc=;
        b=Tan7Spayj1nDiQ3mGXkHORv+0xidiBomhi231nR10aDM93bFw7KQOjNYBEaIgxzDIW
         BbLHtjSThwJI2vmohnaVM3Zt2gTV0Qa+C7+OIA8HwT+eaG/f4m5VZLyqUf11pJItdZhm
         cLA3igbyQvhkthcF31QDAaUrBfqWNt+ZkmD9kjGU08N6DwCmoPmWlabYGGGPDRc9tumr
         f+Ei0cd21gTwJdzlPyS9ntoguqTuPHVjgg5zskSviWzzofMAw93dcehoxHg2LPmRbvEL
         ncwtcaYazf1qzwGw+zQ9+0iKxnsoCDYweQwsHO76ftuIPBlG41fC8YSkCGPCFFd94K7j
         7R6Q==
X-Gm-Message-State: AOJu0YxbHvrXwy2Ad0ZDiefWmHywqGZx+GsCcSStqtDQsf2eA7WPLEJF
        YNm225ScovO+fFgwX7mkQJQ=
X-Google-Smtp-Source: AGHT+IHed65zcIiGfMl4641Tw0aSRdFZiaSvi+nuE8E8l6I8lUHfaSfYYBmvSyduJ4FWc0Z/ibqVGA==
X-Received: by 2002:a05:6512:32b8:b0:502:adbc:9b75 with SMTP id q24-20020a05651232b800b00502adbc9b75mr2680835lfe.51.1695238136237;
        Wed, 20 Sep 2023 12:28:56 -0700 (PDT)
Received: from localhost ([85.140.6.205])
        by smtp.gmail.com with ESMTPSA id y20-20020ac255b4000000b005009d5aaaedsm2822225lfg.172.2023.09.20.12.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:28:55 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/18] EDAC/synopsys: Pass syndrome to EDAC error handler
Date:   Wed, 20 Sep 2023 22:26:56 +0300
Message-ID: <20230920192806.29960-12-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920192806.29960-1-fancer.lancer@gmail.com>
References: <20230920192806.29960-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EDAC MC error handler permits specifying a corrected error syndrome which
then will be printed as a part of the generic error message. Since it's
available in the error info structure pass it to the
edac_mc_handle_error() function.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v4:
- Get syndrome from the ECCSTAT.ecc_corrected_bit_num field rather than
  from ECCCSYN2. The later CSR in fact contains ECC.
---
 drivers/edac/synopsys_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index e08cb30b7a7d..fbf1f8af9788 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -474,7 +474,7 @@ static void snps_handle_error(struct mem_ctl_info *mci, struct snps_ecc_status *
 			 pinf->bitpos, pinf->data);
 
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
-				     p->ce_cnt, 0, 0, 0, 0, 0, -1,
+				     p->ce_cnt, 0, 0, pinf->syndrome, 0, 0, -1,
 				     priv->message, "");
 	}
 
-- 
2.41.0

