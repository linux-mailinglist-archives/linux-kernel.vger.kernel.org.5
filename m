Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9738C7AE46A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 06:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjIZEJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 00:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjIZEJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 00:09:19 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFEEBF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:09:13 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-774141bb415so399518985a.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1695701352; x=1696306152; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AnkYs5/BG/9GOQBaCWwWyOfl1fNQBQrw4AiO+6MYmI8=;
        b=i8Tlhn5z/DXIrbZRAgIMzuHz4sjEf5BhfBL3AfDhFve3498UMrFNyaBPK8AefdQ6tY
         OPIT59aYeeXe2uqlqH+x9fzaHuF9uZUhHbiG/QhApu8gMLXQzOH+LsRJ9Di0QayPJOSw
         +/0xfgsA3/RY5o5aa6kZe+w+tiEY9si3jAVOq6TqRNOEWMhzSeGab6qX17iK6GrsYmK7
         Ic+nJmngtyS/aEgwsmAs8GiRLsApOwh+Ji+/B96yX/udtnLMT+OpUJPG7x5eTfxpb28i
         M+CHgxHC56i1gamEsQUlE6re1nANAI/gTChyR4csSu3GLPFhMqPB1BCzD+iW2HCzP4pz
         QZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695701352; x=1696306152;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AnkYs5/BG/9GOQBaCWwWyOfl1fNQBQrw4AiO+6MYmI8=;
        b=hVpV0IaLfxi3A7JYEkqBySI31pyTtroic9nKjPPqT0APLivoDPflPnh92oYSoixB0n
         ugS9otRg8ttY6B3zhtGEcVxPCtrZ5gWRDM6PbGaBwfMzDraWxKQ8/JVwJ+udSwNBqIn1
         ZxgEmPUnIXUi/wrEg7SPdl8AgFU8KJdNbq5b2TjE3Z8qB31jRgEfq0BO4UqTnnpJrtQp
         YUGHLDdKKpEJMJMFSAWGvJLZUx80//fWXPf7jOYDv5mQYlv33QKdB6w7VaNu7s9buyuC
         Kr3oP6oxhKtxxaUmtLw5nSH7rLedb7fLke3TFM96BWyN5PuhwBUR9+pb9BFzZn+gc2ij
         uEqw==
X-Gm-Message-State: AOJu0Yz9TIkH7IbcrFlg83OYD+c5Q7OGDejMZg8fwKx2hKJK1Buonn+i
        xS1ZAFEJzoPd1tgr/ZMAx8HEvg==
X-Google-Smtp-Source: AGHT+IEGk8Eh0HkJJqF00QSQdnOkthXsg5tTDBAC/R5jcwbJQegRrx9uaFUuouljq8+bvVSWeshFcA==
X-Received: by 2002:a05:620a:f13:b0:773:a229:5a4a with SMTP id v19-20020a05620a0f1300b00773a2295a4amr8412741qkl.25.1695701352202;
        Mon, 25 Sep 2023 21:09:12 -0700 (PDT)
Received: from ubuntu.huaqin.com ([101.78.151.205])
        by smtp.gmail.com with ESMTPSA id z22-20020aa791d6000000b00682669dc19bsm8824907pfa.201.2023.09.25.21.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 21:09:11 -0700 (PDT)
From:   xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, perex@perex.cz, trevor.wu@mediatek.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [v2 1/2] ASoC: dt-bindings: mediatek,mt8188-mt6359: add RT5682S support
Date:   Tue, 26 Sep 2023 12:09:00 +0800
Message-Id: <20230926040901.20338-2-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230926040901.20338-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20230926040901.20338-1-xiazhengqiao@huaqin.corp-partner.google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string "mediatek,mt8188-rt5682s" to support new board
with rt5682s codec.

Signed-off-by: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
index 43b3b67bdf3b..4c8c95057ef7 100644
--- a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
@@ -17,6 +17,7 @@ properties:
     enum:
       - mediatek,mt8188-mt6359-evb
       - mediatek,mt8188-nau8825
+      - mediatek,mt8188-rt5682s
 
   audio-routing:
     description:
-- 
2.17.1

