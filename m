Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CE07FE9DC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 08:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344777AbjK3Hkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 02:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbjK3Hkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 02:40:45 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DAE10DF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:40:51 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1f060e059a3so291865fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701330050; x=1701934850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zy3bexk/UdkiFEYq/BgshHxcfzBMkkII0D9hrrzOht8=;
        b=Yr5Oh43ph0WgjxTrER6QxeHzdA0ak+3StoIwSHeRMwsK5n4SXu6ceOyvb2MU7kpe1B
         aQXocRzjLv61aTbVg6BzlmJUAbrhRyYZPfXOVwydNZxxokuaMrMZszbFgkyA0cbiCb4f
         NIa8jomkNno8wK9OzbjWTRrfRa0/au9rKUNGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701330050; x=1701934850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zy3bexk/UdkiFEYq/BgshHxcfzBMkkII0D9hrrzOht8=;
        b=iVdkHwGQ3VNijnBBXj4uelWTrI7a14M4p8mDNhkCo4+3cVlwRrtY67u7PJ5wQJeF34
         JtNfLzkzporelj2CH1LAFMhukJ90bZp14/WzzppMVKfNEKpr+dRXYOyMBGQJ6agzX3kI
         TNkKrivhOCFiVmziMvaOVb6oDpskbtVCXE+oTOmRP+ZyagrpzuHTFQK8wBStKeFSyc+9
         OMNd3UazX/a9Ht3ZEtzyQRH7iUvkyWV5jj8ShPb+Zz1IeKrSkJczOKBvzJLZV3B70xEP
         ftSYWfvHyRHtIsRoy+tJB/ZvaaQx/OlcKGmMfXCozcTQA9COiSILQGWtggQQXc97zifT
         ZcfQ==
X-Gm-Message-State: AOJu0Yz45d1qld8Z0rmNT5Uott27KKsoqe2CPKspc5tB4PQARlLJ9L3z
        ItGDqu1larTxp0Pvex9Fc9Ger6dcG9GkBkeGGgE=
X-Google-Smtp-Source: AGHT+IHwi9RcnosuzpIAvSOXNm0G5GIasdXoLS/n1bNO323T/kQvMYm8EOB8Q6YuOyc1t9+FjbG4JQ==
X-Received: by 2002:a05:6871:7588:b0:1fa:25e2:efa8 with SMTP id nz8-20020a056871758800b001fa25e2efa8mr18245153oac.15.1701330050507;
        Wed, 29 Nov 2023 23:40:50 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:7c8f:dafd:65c3:2bcf])
        by smtp.gmail.com with ESMTPSA id p35-20020a634f63000000b005bd3f34b10dsm612870pgl.24.2023.11.29.23.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 23:40:50 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 3/3] arm64: dts: mediatek: mt8186: Fix alias prefix for ovl_2l0
Date:   Thu, 30 Nov 2023 15:40:31 +0800
Message-ID: <20231130074032.913511-4-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231130074032.913511-1-wenst@chromium.org>
References: <20231130074032.913511-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alias prefix for ovl_2l (2 layer overlay) is "ovl-2l", not "ovl_2l".

Fix this.

Fixes: 7e07d3322de2 ("arm64: dts: mediatek: mt8186: Add display nodes")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index df0c04f2ba1d..021397671099 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -22,7 +22,7 @@ / {
 
 	aliases {
 		ovl0 = &ovl0;
-		ovl_2l0 = &ovl_2l0;
+		ovl-2l0 = &ovl_2l0;
 		rdma0 = &rdma0;
 		rdma1 = &rdma1;
 	};
-- 
2.43.0.rc2.451.g8631bc7472-goog

