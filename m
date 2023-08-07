Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799BB771CB5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjHGI6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjHGI6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:58:32 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FFAE6C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 01:58:31 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bbdc05a93bso26965975ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 01:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691398711; x=1692003511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ivUPZKkU9V81XA/9ZzpML9/MoT2AN2Em4Cdug3APMqE=;
        b=k8fdQc/jO9CQK9AMjUVaYJPPF2jGJAozl8L6QG33AYVjHyCCEaGfbC5AIX/6CcLksi
         rkAK2yqBJ9RFvU4SquPBJRCd+ZDPS0HT+mOlMwi6RdyMz/upN9GfrgmN0J9s3PPUdFyB
         E5sLEIa+3V5TvPiqn6O5to+Z1e1f7LyZVUOoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691398711; x=1692003511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivUPZKkU9V81XA/9ZzpML9/MoT2AN2Em4Cdug3APMqE=;
        b=Z3d3Z+yA3Fkpl1huZfW7CRbdbWRbzRN42d0Ixzh94cw1RmVWG/Dtx7qKVGc9Gw5Axm
         pjRoNzARZBHA05Z+xlqJDYCQ/BznL6Z5yQo+lkY6KyXPc8RSIBJkE+3l37boe3ajSk7p
         VwlcBZSVT0mmvbzy9G6EM5Ps3smt8eMUPN5za/ZcbmlfgWJC+Pu3JgefPHo0MRvmc0gk
         HGztzENryjAG49LKHI7QVsDckEysEMwaKYdBl240CcnhvC0eAQdam6sWn3Qh3YLMsQJ7
         gF9d8UP9suxc4fHnqB/CAkYJHG+7BQ6jyZQ/MT5cA5IuJRC1LPbTZGLyExBvC/5eCkoZ
         5zrw==
X-Gm-Message-State: AOJu0YwyaTVXh/f5cKhT2v3vIsN6pxQ6GTp8iMnRSRypfa3I/7E95QRR
        USyX7l5lQ0hXGqEzoNMl9Zyz49uCFnzGhiReMJ2X/A==
X-Google-Smtp-Source: AGHT+IFdeJORfRK7L+sj/NaxVhQeqQYdqhFUl6jyK8r0GnET7N4tBUbW1ngbqwX7Pj6YJBp7RXGPeQ==
X-Received: by 2002:a17:902:ec92:b0:1b8:b827:aa8e with SMTP id x18-20020a170902ec9200b001b8b827aa8emr8776343plg.11.1691398710772;
        Mon, 07 Aug 2023 01:58:30 -0700 (PDT)
Received: from localhost (97.176.124.34.bc.googleusercontent.com. [34.124.176.97])
        by smtp.gmail.com with UTF8SMTPSA id q9-20020a170902b10900b001b8622c1ad2sm6286044plr.130.2023.08.07.01.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 01:58:30 -0700 (PDT)
From:   Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Google-Original-From: Hsin-Te Yuan <yuanhsinte@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Hsin-Te Yuan <yuanhsinte@google.com>
Subject: [PATCH] arm64: dts: mt8195: change watchdog reset boot flow
Date:   Mon,  7 Aug 2023 08:58:12 +0000
Message-ID: <20230807085811.1.I7d08b8323531c59c0ec247570b2d05a790bfd3d4@changeid>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The external output reset signal was originally disabled and sent from
firmware. However, an unfixed bug in the firmware prevents the signal
from being sent, causing the device to fail to boot. To fix this, enable
external output reset signal to allow the device to reboot normally.

Signed-off-by: Hsin-Te Yuan <yuanhsinte@google.com>
---

 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 37a3e9de90ff7..5dc4214e1840b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -1147,6 +1147,10 @@ &uart0 {
 	status = "okay";
 };
 
+&watchdog {
+	/delete-property/ mediatek,disable-extrst;
+};
+
 &xhci0 {
 	status = "okay";
 
-- 
2.41.0.585.gd2178a4bd4-goog

