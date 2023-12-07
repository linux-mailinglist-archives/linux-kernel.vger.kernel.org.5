Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2134E808933
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441885AbjLGNaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjLGNaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:30:02 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEF110C2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:30:08 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c29f7b068so6489315e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 05:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701955807; x=1702560607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDb0keQL27XbR+XZzk5KT1NorqWrdjC2/zChC8N2ewg=;
        b=od9psL6y3sE37xmVIfCRuIcibM/zgDJ92tlGnLZcM9+jGxnjPJaLsjhdqJVghalUE6
         E26kn3momNJjyX/n6XQWbfFnALEtz8aOMeScL/hwFSf769+7episnUABTW+JpkAR8uYh
         Rf2jJqENO9Z0DnF1CsYwX1/K0AUYCdp5/lGLrhLM2FEpTF7rXzne+6B06M/vdkc/y34z
         eBX2LtrGZ4DfA0KIju37hfzs/dGvMhN55XKOhAirHu/q4Y/UIQd8IkggfolwTImkeuFX
         xnZ6gDRXAZ5fl3IfoAwRQvEPkaiN/YhabO3oBUVzSCZPx5QV7ea+Jjqs1lNp660lP/Mc
         PnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701955807; x=1702560607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDb0keQL27XbR+XZzk5KT1NorqWrdjC2/zChC8N2ewg=;
        b=T2bDd6cN+QAQYvYDHjAyZVz+Yuh1pMtEmWTp4r+GDBmaNpVwbVnqHTRPLgUTu+N1ed
         yr9UcMP6VBU3xugCylRH5tvDPxXuZG6T09gZ9v5Ns238U+MN+J/W0jlgY1U708CFSLoE
         qFJjNLy+rSbxuDsojYICwk56Y2raVaWY6KIiuyl8TbappJ2IMArKaoJ8qs1VbYmUgCEG
         F5n4HOTftPH1NGH7Rt38OEIBFUSkPeOk7Cq+NmX+3Tt4ESQlZ5ORV59W8bHHmOKqRp8O
         XQHIyvRQR8xm36tkD8joWRiUDid1Iwn1HT1LUy4fkaSlEcy3LO9U3hItQWlRpM4Q/iDl
         i5sg==
X-Gm-Message-State: AOJu0YyAzfFDy8r4zR0zYoIAVbyNdXIH9XxLOeAw4M6/J5C6PUvs75H8
        Y2Xh3K8rcRIq21EO/xCpicbrVoQG9mbuLI5A3bo=
X-Google-Smtp-Source: AGHT+IHxDCUmVLcyywZDnp/+cesSkkXFm+mxDZP5/wJzZQs3NtBr5QKrHKKokvxvVeapexo6lDHYuQ==
X-Received: by 2002:a05:600c:34c5:b0:40b:5e59:b7d4 with SMTP id d5-20020a05600c34c500b0040b5e59b7d4mr1475753wmq.177.1701955807023;
        Thu, 07 Dec 2023 05:30:07 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id x16-20020adfdd90000000b0033326e90496sm1454105wrl.18.2023.12.07.05.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 05:30:06 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 0/3] w1: gpio: Some cleanup and simplifiction
Date:   Thu,  7 Dec 2023 14:30:04 +0100
Message-Id: <170195580175.91459.12009562325356253942.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1701727212.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701727212.git.u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 04 Dec 2023 23:05:20 +0100, Uwe Kleine-König wrote:
> v1 is available at
> https://lore.kernel.org/r/20230525095624.615350-1-u.kleine-koenig@pengutronix.de.
> 
> The changes in this v2 since then are:
> 
>  - Fix a build problem in patch #3
>  - Rebase to today's next
> 
> [...]

Applied, thanks!

[1/3] w1: gpio: Don't use platform data for driver data
      https://git.kernel.org/krzk/linux-w1/c/9c0a5b3f9e55cf9a3dc85843666cae28adfdf7e3
[2/3] w1: gpio: Drop unused enable_external_pullup from driver data
      https://git.kernel.org/krzk/linux-w1/c/deaba3d687b7cb1a2868bd514fd665ee5efcaaf3
[3/3] w1: gpio: rename pointer to driver data from pdata to ddata
      https://git.kernel.org/krzk/linux-w1/c/0ca9223fe9f75dce6e5cd306c685ee687a0bbdeb

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
