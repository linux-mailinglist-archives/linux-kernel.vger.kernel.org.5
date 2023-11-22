Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBB77F41D4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbjKVJmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjKVJmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:42:08 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF41EDD;
        Wed, 22 Nov 2023 01:42:04 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6c33ab26dddso5706276b3a.0;
        Wed, 22 Nov 2023 01:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700646124; x=1701250924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SV/osW0R7bVpYMTd62PKwIsgqxKMwJ1fiVW5wV1ilHs=;
        b=M3Uyz9ijIcr34VP8bulaJ7VLXGAM1M6/S53I1o5CHy2xUvKlRX61g2o/qD2bTycNuW
         RgE4dvJRaPRMA24R6in47NyI+lb3M9bk+Y4dKUJCdhcslnFBzKu7HyfAVyGVSo5KL/s7
         rEdZE8JBivCrcTv3pCdjEHFbCMsAbQcT2wAtwDC2qdW20PmmXcS2Uq18/AQQ7smrz3Vr
         0ZwEyC4+7WeQClsHERgZM3vDF25C3Oa35o7zMB0JCxpSwV1FBK7ToFSrY9g1fAndWTs/
         sx3Iqec9FTUNShjYZCCtYVz+el2XCdpGjQMqJJSh0v3ujA2mZpG2r8sxOc5YQLAyZGUK
         v/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700646124; x=1701250924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SV/osW0R7bVpYMTd62PKwIsgqxKMwJ1fiVW5wV1ilHs=;
        b=eJ9hduTtwiTLTDkLcDFrPHKrSW0s+JfSgJjMk0v71B8q9ZAM4g7dsi8Brqjh6VAajc
         5XCMR28pLGqU8rY1V1dlaVHRGMHw79Xg++ITu7Pgk/CnFA9M1z6r0+AOoNTwuwJqpiZT
         nSbayIcIk1OWanvs5IwYTEsBicjNeDpvb9rt7WqaoAp+NXYMdcUH5/DMo35ISpCIyLlb
         GldH4Gx2g7ObhfUrAZgPVpcuIX4d5Lm0OerqDen0meXrJEr+u01pRsrxSg3Me3TOtRlp
         /qaW45nSzPb3xF4qby32ak1oVyZu72FhJf4ZL5+9/qom1thkkDuBjiF/HI4mWHNJS1sm
         5JeQ==
X-Gm-Message-State: AOJu0Yy0+W0c+W4tjDalQV2K5D0YAW3+Xp3ZwKsxE/qVXyt9P0rNDl1l
        dyV+Mpyf1Zn/rutx9DgPE5g=
X-Google-Smtp-Source: AGHT+IFzf3ahprBjT8RgnY9ilotsSVvN6c0RYl7tlZ7ISOBudnHGIt779Lq+6/qdV5RVMMvH2vuzGA==
X-Received: by 2002:a05:6a21:338d:b0:187:c082:3e35 with SMTP id yy13-20020a056a21338d00b00187c0823e35mr1917336pzb.14.1700646124312;
        Wed, 22 Nov 2023 01:42:04 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id c10-20020a631c4a000000b005b82611378bsm9144852pgm.52.2023.11.22.01.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 01:42:03 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 7F5CA10210555; Wed, 22 Nov 2023 16:42:00 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Staging Drivers <linux-staging@lists.linux.dev>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <error27@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Bruno Moreira-Guedes <codeagain@codeagain.dev>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Martyn Welch <martyn.welch@collabora.com>
Subject: [PATCH 1/2] MAINTAINERS: Update Martyn Welch's address
Date:   Wed, 22 Nov 2023 16:41:55 +0700
Message-ID: <20231122094156.30642-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231122094156.30642-1-bagasdotme@gmail.com>
References: <20231122094156.30642-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1650; i=bagasdotme@gmail.com; h=from:subject; bh=v5yUaK/fxsxugJsKLcf76rnii+QRaf0Iwcy7KBtjsIQ=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKmxpx8L/f3/7fy0JeL3Ch/eDRTgnbDttfJtIY7/JzPcS 2VU2LzmdZSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAinL4Mf+WO9N+7KXs90Z5X VHr+pozMXfemas7ifzTLUUKJ7eKtphMM/5MDjnbN/sq15BGXCXdSUtaWP61RO0XcbxiqHpZOaRB O5wMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

He is now active on the mailing lists using his Collabora
(@collabora.com) address. Reflect it in MAINTAINERS and also
add address mapping for him.

Cc: Martyn Welch <martyn.welch@collabora.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Martyn, if you still had like to maintain VME subsystem, please let us know.

 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 43031441b2d922..1df03996c73bdf 100644
--- a/.mailmap
+++ b/.mailmap
@@ -368,6 +368,7 @@ Mark Yao <markyao0591@gmail.com> <mark.yao@rock-chips.com>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@ginzinger.com>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@puri.sm>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@theobroma-systems.com>
+Martyn Welch <martyn.welch@collabora.com> <martyn.welch@collabora.co.uk> <martyn@welchs.me.uk>
 Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com> <martyna.szapar-mudlaw@intel.com>
 Mathieu Othacehe <m.othacehe@gmail.com>
 Mat Martineau <martineau@kernel.org> <mathew.j.martineau@linux.intel.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index ea790149af7951..a02aa52fabe14b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23234,7 +23234,7 @@ F:	include/linux/vmalloc.h
 F:	mm/vmalloc.c
 
 VME SUBSYSTEM
-M:	Martyn Welch <martyn@welchs.me.uk>
+M:	Martyn Welch <martyn.welch@collabora.com>
 M:	Manohar Vanga <manohar.vanga@gmail.com>
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 L:	linux-kernel@vger.kernel.org
-- 
An old man doll... just what I always wanted! - Clara

