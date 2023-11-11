Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07ED37E8A3D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 11:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjKKKmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 05:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjKKKmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 05:42:40 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA07B3AA6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 02:42:37 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9e1021dbd28so457252066b.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 02:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1699699356; x=1700304156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ge0gNi9DVXfC2vKDgGEclw0Ori58fekABd1HKK5RJHA=;
        b=MbbU5Gvv4vY/L2xQb9BPBSBuz7AttYNt7KrblUKUMWD8MIAYUh9aCcMfrTOimHshHe
         ZdJ1nkCamch7LQLY+9ZFu4f5qy8z9FWYu3edY4qBE1d1obd3AUdUq27wvlVyXK5QOY8I
         BKUC1ICenXwIPVnHF+58SG/z7whQKmQvw2NgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699699356; x=1700304156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ge0gNi9DVXfC2vKDgGEclw0Ori58fekABd1HKK5RJHA=;
        b=lhTUboeAnr7P34kTCvXjNp4jFNQHZxTpjDRdsiEA9LPb1TWdAUCZHInrRRiDr5mnaq
         0RaIv8UiAeawS2pK0z8csJj4kMJDK4odxFvRpZyy2i/6HE98siV034tvHjy9k7+pb/nZ
         24ZzR2fxaAzATTLrAyaF9tGjtQDbW51/ZFpyrRJJyjcd7ZPEwKKDe/3qd4OSe9DYsWya
         CLO0EprE4bBvW7d7MsE3n5F3U1vXaFFSDgrSi4z5K9fSZ2YnAFKQwGfYiciQt+93DYIV
         7x3iViVlfhP1meS/Zp4ZKKQNHDNNH/TmW4m/4LD240qX59qvJIiYZzb3rat6CBEX9wkK
         2gzQ==
X-Gm-Message-State: AOJu0YxncToK9qARpvoW+Xh+6EOn9kHmjnhUuY4JqiVwznoCKgl9U5Hc
        9KuE6UTxroIei6e6ki/9wJLrQonzrLfQ5bicMcfHuA==
X-Google-Smtp-Source: AGHT+IHi7umdHJSN/J3vKG6LIaXqc2IzKyZTj5K72HPZNOWFZKca+Sq8nOJ2Izx28leKgWLIeRgloQ==
X-Received: by 2002:a17:906:4c84:b0:9cb:5a8a:b19d with SMTP id q4-20020a1709064c8400b009cb5a8ab19dmr929295eju.5.1699699355850;
        Sat, 11 Nov 2023 02:42:35 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-20-97-182.retail.telecomitalia.it. [79.20.97.182])
        by smtp.gmail.com with ESMTPSA id ga33-20020a1709070c2100b0099e12a49c8fsm872183ejc.173.2023.11.11.02.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 02:42:35 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-amarula@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Fabio Estevam <festevam@gmail.com>,
        Helge Deller <deller@gmx.de>, Martin Kaiser <martin@kaiser.cx>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 00/10] Fix left margin setup and code cleanup
Date:   Sat, 11 Nov 2023 11:41:49 +0100
Message-ID: <20231111104225.136512-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series was created with the intention of fixing the left margin
setting. At the same time, I made some changes with the aim of making
the code more readable, as well as removing the errors/warnings
reported by checkpatch.


Dario Binacchi (10):
  fbdev: imxfb: fix left margin setting
  fbdev: imxfb: move PCR bitfields near their offset
  fbdev: imxfb: use BIT, FIELD_{GET,PREP} and GENMASK macros
  fbdev: imxfb: replace some magic numbers with constants
  fbdev: imxfb: add missing SPDX tag
  fbdev: imxfb: drop ftrace-like logging
  fbdev: imxfb: add missing spaces after ','
  fbdev: imxfb: Fix style warnings relating to printk()
  fbdev: imxfb: use __func__ for function name
  fbdev: imxfb: add '*/' on a separate line in block comment

 drivers/video/fbdev/imxfb.c | 179 ++++++++++++++++++++----------------
 1 file changed, 102 insertions(+), 77 deletions(-)

-- 
2.42.0

