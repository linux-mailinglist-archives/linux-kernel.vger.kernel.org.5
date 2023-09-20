Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365D97A72FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbjITGlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbjITGl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:41:29 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8280CF;
        Tue, 19 Sep 2023 23:41:20 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-5735282d713so3955061eaf.2;
        Tue, 19 Sep 2023 23:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695192079; x=1695796879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPzRtbGVAyCieAczzidwpR61L2JC0XRU2iih1ur/Z2g=;
        b=IAax/uPsrEoqtah8cBrvsL21PtYQOWnbUTGdtu84Uxkzn/kFuf5I7Bj2CFYHph6ZXH
         4cmStyKjd8HSJo9HqV2BcAftUWPz8D/kmYILmbSyuzSQE0dPEsTfzX6tpCjLgQ5XBgaB
         nn91H/nPRynz675uckOe7+29fgLWcYZAvscb2eWqveCPHGd3BVedK/vwWXoey5wPcVlZ
         Q/POd0S8WeeUcoocgi4dXkzS2tQqSrTJRhSLGavRYWujXemKOrgtO87OyjSmXFNaNZVz
         ok7gwb4zNfugQT99LndtKwunKjrP7mt74Z8yk5hbzOoHghzQllYYH3HsP7g1uyJETUzW
         NEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695192079; x=1695796879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPzRtbGVAyCieAczzidwpR61L2JC0XRU2iih1ur/Z2g=;
        b=ZZfIGHwiaT456eevUTnW06gIxYwHWqQSDUlFaPcsFTas+6ORnBHhUCR6clMAWyKqQL
         WlIltsLzFBEf7d4XF35fNGGPvEbndqPeumN69dGXZ4eyivPfv88ugtRqwe84JW6z0Gip
         xwYnaa27/sLyOvJVVp7PzcnJ8PVBOnxTZFStR2QkpxBinQAXGFGWNT0PQwZMkoDAzVzK
         h3H8x4Xdsw0aV1rfhjMf//l1CGC1m51QGwZiwjxl1LZ70vPTJdcTOMf3hr5AD8xY3gBV
         Si9pZ6cB7mQ/dTO3WlJPDdrjZ6R520yMaqWr6/z3az5291UpRVQM7Ro7yUGrA8pjKo6t
         aE1A==
X-Gm-Message-State: AOJu0YxoI3LNusOcFm2/wHud2aHtNDttM42lbrQEtbnt3w+8qlThns81
        AUT46r2CgFUODGEpkEddpww=
X-Google-Smtp-Source: AGHT+IHPq6IFe9QBQQR+FnLEJiN55AB/ok6hOPAoJV6EieiQGia1ukQ+myI+nr9AP44rQ2wojZmBsA==
X-Received: by 2002:a05:6870:b313:b0:1bb:4606:5be with SMTP id a19-20020a056870b31300b001bb460605bemr1792059oao.9.1695192079100;
        Tue, 19 Sep 2023 23:41:19 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id ch17-20020a056871c41100b001d4c5e4c2c5sm6860300oac.25.2023.09.19.23.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 23:41:18 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
X-Google-Original-From: Chen Wang <wangchen20@iscas.ac.cn>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com
Cc:     Chen Wang <wangchen20@iscas.ac.cn>
Subject: [PATCH v2 11/11] riscv: defconfig: enable SOPHGO SoC
Date:   Wed, 20 Sep 2023 14:41:12 +0800
Message-Id: <835006e5c76ba1c53eed1b7806a08ddea3390bc5.1695189879.git.wangchen20@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695189879.git.wangchen20@iscas.ac.cn>
References: <cover.1695189879.git.wangchen20@iscas.ac.cn>
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

Enable SOPHGO SoC config in defconfig to allow the default
upstream kernel to boot on Milk-V Pioneer board.

Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index ab86ec3b9eab..bf737cfa1d2c 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -32,6 +32,7 @@ CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_STARFIVE=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_SOC_VIRT=y
+CONFIG_ARCH_SOPHGO=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
 CONFIG_PM=y
-- 
2.25.1

