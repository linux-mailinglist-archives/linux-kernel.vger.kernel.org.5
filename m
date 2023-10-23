Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A817D398F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbjJWOk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbjJWOkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:40:25 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CB31A4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:40:23 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7788ebea620so228520085a.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698072022; x=1698676822; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k7PS6ahcPaPVgkaLyfG2/5fLxZhHFw2R9jMfOoRovw4=;
        b=Fhzi26z0I/oSeWepZTUQMtohE8gLKcMIOiQn++1QQtF95KyRBzN5agWIljC1nJIeRi
         WvvXW4ONu5tj0T5rljv4h3Vmq8JbPcxwvxIFbpVFH5rD0Jbzn9w7ej9Xi+xki6L8DPi5
         1x3xBGcSL/iffAQaDBhsKrIa1CHzRdoZOP2jMBKeY+6S72/e70NrGUIT2dXJhaRLGr3X
         kNtCRy445MlJdyNDFRIRv+stmEve2dJm4+fgtrDFiCJ1rAnS1FcxTfmhvJYSHa+cDP/1
         J725tgKwCUcC6y9Th/vkJHCc7GCrAdY8SI+PTBHXLx7d2tRNy1MD49nGkZh2h+Y9T9wp
         DtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698072022; x=1698676822;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7PS6ahcPaPVgkaLyfG2/5fLxZhHFw2R9jMfOoRovw4=;
        b=C1BNXeaBrs1oc6DAOEU5e7vIoY2XUSVNqqi/5waLWWNohwIzGoXkoHIWXb/x4CSFJJ
         r05XH6eIkcstHs2v9nQteDlc70h7pefz+XClbt9GyhukLh0CalAzAykByV3dyi2kGTJ8
         bhP857beZJRdhaG4+4RwonzOPuIgUO/IyUeBdSnpBB2e53dBJf+7WEIz1KZua/pU4m3z
         lv+PquKXpRyiamfmt2mDiOdDX3Q00DaJ3xfoPWAnCT+7l5dcsPZTi6vsWnv2Zpt3K9w3
         mrZHEfa18oqTVBiyZZ3DH3qw0Ul5FrDjlX2O03glgiJ6QjgpRNb0hMRVZR4O0GRZ0Wmp
         pfwA==
X-Gm-Message-State: AOJu0YwygTOBqU5tuVrL91OzclguUdLTwZf4jAlc/LS2jmS3FvATPvBn
        CMTiBhDiY9Ck/zRpzRcuRGCwOKJWc8Qo1nm5/PClMQ==
X-Google-Smtp-Source: AGHT+IH0nODYbrvEMwbGxVa26dTGc2msGtTG34VMr3BZQ5GiO1cLSJzBEsMmNuRzIEAMQXxLVf8RPA==
X-Received: by 2002:a05:620a:2451:b0:779:d1a6:ee76 with SMTP id h17-20020a05620a245100b00779d1a6ee76mr5162073qkn.37.1698072022214;
        Mon, 23 Oct 2023 07:40:22 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f1-20020a05620a408100b007789a3499casm2725020qko.115.2023.10.23.07.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:40:21 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 23 Oct 2023 16:40:01 +0200
Subject: [PATCH 01/18] dt-bindings: display: mediatek: aal: add binding for
 MT8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v1-1-5c860ed5c33b@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=924; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=Ui729mTu13aA0ns8kExm+eoWD4rbfjwSg3rfyfGgZBs=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBlNoXOcFzr25uHjdnQfeDxVFE5X5hyS8aufQwwKFCN
 G43v/POJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZTaFzgAKCRArRkmdfjHURa3LD/
 99DHn31961gfxqzckKqZvja192V6gfiNXzsC6hHBBZ8geTJi8IPYTSVbFQxhFdyZ+auYgAjFP5m2xq
 BemZnwKfzObqDIyzohgIPuAu9AlAR2rG1N+HlnAtyqdooBQfywPdJds3RDO1TcMU/8HQ67qtPTa3T5
 9vDOBdgqAb3x5IF5ZiWOd/a9M9V3UHmSIoTL4KQBea3kynTtsw7AE7yrjJpgqv/jBfAq5FhDh1B8pm
 vSv35urioNBPCXdjyegst5HBRzIVnUqhK7c5xwnLaZmsJVXlgWdfkLwQrV9KJS6y4nc8/gmqQLOQIc
 MJxYUXah3PdpvkNr+YfECux5xjQztcI3oHxmpqL6hG/PQmrA5xgK8d76w6fLbXy9T+3N3PjLU+6l/n
 dubODhA5S/1uBw15CbmV/WsA6UKYerpl5W5kkIgSWAgz2KFxcb4AnOBdfwXN1SAri5BMeSz3wGzL/W
 j5teR7NaRxFwczR+3MYebDqu+7sWbcxmAECe+JpDB9QyNhme2SgQ93rYOx3hyMrR97nVPOhDvGmMIh
 gxB8/5AXXSSeqR9YIuNZfCvNq9R3FLFNQ5rAt4WLIexZnWX+vUxROE0pqg6FbrswpRTzcpJYsYOPfO
 nh5gp7N0SCNp1bdgVDKrQHGD+5Dsm8j3ZoiQnMgoOhNBa1lxOGzoY36JBAPg==
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

Display Adaptive Ambient Light for MT8365 is compatible with another SoC.
Then, add MT8365 binding along with MT8183 SoC.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
index 7fd42c8fdc32..840b48a878ca 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
@@ -35,6 +35,7 @@ properties:
               - mediatek,mt8188-disp-aal
               - mediatek,mt8192-disp-aal
               - mediatek,mt8195-disp-aal
+              - mediatek,mt8365-disp-aal
           - const: mediatek,mt8183-disp-aal
 
   reg:

-- 
2.25.1

