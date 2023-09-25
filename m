Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4B87AD384
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjIYIjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjIYIjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:39:04 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23788AF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:38:58 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so4280090a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1695631137; x=1696235937; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDlQRlGUPTfJlUUMPRtJLma/aq2eNwYNR02CUUOI7A8=;
        b=RkG6BfMWZA3CMfBYdSQ8KWwL0emK9msOS+gdin5JXAoacCHLswsVGb3Kc4J3GfJI6X
         KRoLL7xfvxAQV72uKaxg21WEDhfZtBAfgiCmlvzYsZpk0oMK1ER4Wh21rn2cwFKBSjmn
         CG/+aT9F5HCkDNVgoJdKH1z+u3FDxiQNVWGU4lqTZL8ibVgnQU+mKXCFm7NVe7qYZwme
         DNx6bCutlGFX41xl/aGeRXqohSJ/ZCkZaLrn8rkvjXzqhiBSDWoxCMeMs7E8WJt5mZwC
         6EBMxFtmDjdr9nWPF0/DeNfaXMFNiyo/WTSFaeHs3JAaejJX/UKnZYOlAv6phr8bYsPy
         g1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695631137; x=1696235937;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDlQRlGUPTfJlUUMPRtJLma/aq2eNwYNR02CUUOI7A8=;
        b=f5cuOhpiG42oUziptVtWUzlYos95exot9morThUddg7c4L+HrRm5nWeKELhnnkLPrF
         GbavRp8BjwJbwL9moePf+Jyh3GcY7e2NupghhEeIIRE0JBj/EzIDT/3Rih8Ja1kLjPRR
         yNdb/tjgKtF1qTC1IDMGtrIoVMQvUj80f22sZiHrQ+2NXNu70eDQcHuV7f2sTckkFC16
         Es1OSRIm8NtxD2JypeUVnquLVBYtrwADiMT2lW7cl5LHnX5dg7YcyF/J0CQmmSITyR6O
         e0TBizeUUY0oyLlifVuBJW30iV9gaLXMQ7D85mUrepGqJ9Q1aAJ+Exkyz5N1hW8i+vtm
         W1Uw==
X-Gm-Message-State: AOJu0YzZJ8Fl6AWQAprGAGj6Kk6LZFXDcCQ4j7J5ISGxLDA90ozBLPXh
        5CIoqr26VMCulVLSpykjjNrIvw==
X-Google-Smtp-Source: AGHT+IGRzWUFKvAXUdW7P/gM1pTcDYhfc2VIx4gXPNUiXkY34HMjyU1m/YIX7/WbQhw3zmUkXjMlHQ==
X-Received: by 2002:a17:90a:2a4a:b0:26d:2bac:a0bb with SMTP id d10-20020a17090a2a4a00b0026d2baca0bbmr5300954pjg.6.1695631137400;
        Mon, 25 Sep 2023 01:38:57 -0700 (PDT)
Received: from ubuntu.huaqin.com ([101.78.151.205])
        by smtp.gmail.com with ESMTPSA id 14-20020a17090a004e00b0025dc5749b4csm10141132pjb.21.2023.09.25.01.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 01:38:57 -0700 (PDT)
From:   xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
To:     lgirdwood@gmail.com, perex@perex.cz, trevor.wu@mediatek.com,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [v1 0/2] ASoC: mediatek: mt8188-mt6359: add rt5682s support
Date:   Mon, 25 Sep 2023 16:38:45 +0800
Message-Id: <20230925083847.1496-1-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To use RT5682S as the codec and MAX98390 as the amp, add a new
sound card named mt8188_rt5682.

xiazhengqiao (2):
  ASoC: dt-bindings: mediatek,mt8188-mt6359: add RT5682S support
  ASoC: mediatek: mt8188-mt6359: add rt5682s support

 .../sound/mediatek,mt8188-mt6359.yaml         |   1 +
 sound/soc/mediatek/Kconfig                    |   1 +
 sound/soc/mediatek/mt8188/mt8188-mt6359.c     | 154 +++++++++++++++++-
 3 files changed, 155 insertions(+), 1 deletion(-)

-- 
2.17.1

