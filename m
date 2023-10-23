Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3940C7D39D1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbjJWOl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjJWOlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:41:20 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7743B1BC9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:41:01 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6cd0963c61cso2012659a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698072060; x=1698676860; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qudfebjcrf3NxTvPd9cnhg6s1+eggmH9h9XstTC+9Nc=;
        b=0AlLjbnu/eYv+YprnTPblgV6/AisEUDQnGeo1+NwFRU2wF7AdKyRW8Akx0Icxzy6R4
         mNblaL/e+/2QFTroCnzAuw+n3dBayiZz9D3+RPxere/L1Hxn4MXnv/nAugmCpbDCmZXa
         PvirWvLYc2Eiji/UA/QTMLkv6Xw/e8W9mNz+jh86unyAB48N2jzk8b0DvddPvrMiGJAG
         Zxu5u8zJO44Ux0q35E80wutvqCWHgvFriNiO1CLZ1SbEnmb4vp2xsdb+lfS3SZAQCetU
         hxNeKbY9mh1v6xxpR8EiVGxJcWfWg4b/0OwZXiSGULyk3OHTiu+d8ktQLQFT50y/PQYt
         KSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698072060; x=1698676860;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qudfebjcrf3NxTvPd9cnhg6s1+eggmH9h9XstTC+9Nc=;
        b=OtgA1us0d0AYs9CRVVC6LU8aAhuD8WLvw4VgfinU2nEsmlfAwAVYpoGJF/xcinBByp
         05nfK1YwZ3q4FXcXg3tzBKcgVTTQKiVS+lBnkPesDz80g/GonchUPmd4lTqxD93G/NNy
         mDKTs14Nl74oukZD+jE/YSMP5q3xsNRgk3DOuN9tMuqzBHBthe1FZB/MNtBRy+Z69AAe
         ARZmnHZSYX9OCZijKYFU+/iE4ySOkqovEgqoayl7xVc2M3xfNLh0tUHvltf+yVzr79Wc
         ol9IilW9pCFKzwkPIYDOabyCleqxrMYvpuFJhOlqIFZvCON5//45MSmxz/Xj4YFOczDj
         4iKQ==
X-Gm-Message-State: AOJu0Yy0Sspfgd/TQI/CIW68HGQK+6z+v+19fXmZNA+DD6G68Jf5sr1g
        zuLNQgcU84vJtYgTH0AHIrQjRA==
X-Google-Smtp-Source: AGHT+IEm9PyIg3Jn6Sranv/OuVsKx3BtStd2/S2hWeKlYnsrLCZVCoCeMweFPm/ILO9p7wr+RzI5HQ==
X-Received: by 2002:a05:6830:12d8:b0:6b9:c41f:ede9 with SMTP id a24-20020a05683012d800b006b9c41fede9mr8427446otq.16.1698072060546;
        Mon, 23 Oct 2023 07:41:00 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f1-20020a05620a408100b007789a3499casm2725020qko.115.2023.10.23.07.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:41:00 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 23 Oct 2023 16:40:12 +0200
Subject: [PATCH 12/18] dt-bindings: pwm: add binding for mt8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v1-12-5c860ed5c33b@baylibre.com>
References: <20231023-display-support-v1-0-5c860ed5c33b@baylibre.com>
In-Reply-To: <20231023-display-support-v1-0-5c860ed5c33b@baylibre.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=860; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=ffAXKXJ9cZhbqlXUqaqX2HWdbChLJu80R5DE84NCORA=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBlNoXPMQfrIcZqNQJQO0Ys25obPGYM1stc5OlxnvAk
 nFfDrjyJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZTaFzwAKCRArRkmdfjHURdavD/
 0ZHAZ0Cjk4mWoa9zs6Fp9jRc9KI2yB7gYjoYxe/765Z3sfJIriT6yE7EbmApJeAFwZXuxMtXTxp1ap
 LVnEtyhFnLZn9KfHA+ALiIERlyx6i1MPCmiGtdhBSH2kgn5rVrELtf/LrFTJ9LUEuy5MMzV6vnxU3R
 E+uKJAxMTzdrTUBbvpmehqvKKL05WgmgdrInZWPK+kJHrJ1AYdlXFrFnBPb/WOnmIKBe5agU5m46tc
 fwUSK/zMXFAjySNrRw+spBLwPUIo5T8iCdLo1VnjYRvJtzkMeyc1hzZGTDWkmKoHGmPx3p0Ee5RUFA
 7OMDbifvVvc5t1VQ5KlsyuJcr2nNZWaVFtNotj2PjUSFaiqVubPTbRdk3hcZAKtGSnA9reIBsmViaJ
 z0e9t0zUGEHa6oTIHkBpFQStDh8lgpeoM+tKKh9RL/OtyNDRvIocFqYTOU8/JVcsUSWlJ0xi3w0EDA
 Uy1/BPSzCu3Xi4oAs2iNbnzwElhIXn7l4/2+s6fXHQL49j8l9+wkpBITfsWZM0++zwWxgIE89bW0q9
 kTB2XBw2jQMfD6NtU9QnfS7D4PztrSV36Dqn0v20qW51tyHLvq4sxPAq2b6GBE9LKE8LKQYx77NnT2
 3/+4xLlLo34+v7R651isf4We2qMe+NsPxHGpuHQMIF03yxjM02olxLhcaoaQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display PWM for MT8365 is compatible with MT8183. Then, add MT8365 binding
along with MT8183 SoC.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
index efe0cacf55b7..e4069bcbf8d5 100644
--- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
+++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
@@ -32,6 +32,7 @@ properties:
               - mediatek,mt8188-disp-pwm
               - mediatek,mt8192-disp-pwm
               - mediatek,mt8195-disp-pwm
+              - mediatek,mt8365-disp-pwm
           - const: mediatek,mt8183-disp-pwm
 
   reg:

-- 
2.25.1

