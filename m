Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A6177E64A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344672AbjHPQY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344665AbjHPQY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:24:28 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8441990;
        Wed, 16 Aug 2023 09:24:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so5857213f8f.2;
        Wed, 16 Aug 2023 09:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692203065; x=1692807865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAgSwqBs7l/IQbeGRgXFIlPuf71cshQlwnalgFiUTo4=;
        b=XB4dL9Z55LDr6ld6X6jbIvAfGS4YkrCsVRTM8EMVsSBJd6BgB9/AtJrUuBO4d2e9U2
         xaVFhNysWs9DtT/S+YcXP+bzFldKulberD9DDVtMT54so9wK8LL4bsL30TL+z1c5IkAv
         Dm+DyymYtFksh5T57KF4Yhp37TJMVuqgDFwIuqWnV+2hdr9HAT+7z9cLDgPX1tFPu4/S
         b7eHBVcCBvUEbvHIq49+Peuo+UAHffD68mEqIBWbi/nlFaQqWqQuD3N9IeEjyUezPsYh
         NhDtjiZSqUOnJS2I3Abvv+S6pnCzS//OkjETHpS6tQlSt7t1PeApoOh8ouHX3wMuxlhp
         D9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692203065; x=1692807865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAgSwqBs7l/IQbeGRgXFIlPuf71cshQlwnalgFiUTo4=;
        b=SztOe0mag3oNzgULEjZuHlW8A308Mc9gHg0MUMXCKGI/IANABSkpU3ajHHCnaaON2c
         9EFXTXESClumIK3GUdaxoh8luP3CXt5COmCIVp4SCzw7mHtIRrh7dBcRBDiY3jzsXxjB
         qs7rHKSvkQKeE1BYq4eGEMSLc/ufyfTF4m0BnuA+pH2vNOksLk3Jq64M065x/uasJ4og
         k+QewugUWafSIsKcz3TEzkgnkhbtRJrdMHM+apO2Fm+PnSh91O0KZvF4Btwm13z74pc5
         yd1Y7aPIYhSleZHgFlPGuZ3uWhqCrFbFimfnYyTo7RiG9+lRgYwQ8uAAoOgK0TFa37zs
         NncA==
X-Gm-Message-State: AOJu0YzrGi7TWKH3+uozNFDFNqe9D/FodS0sgHFI4L0FZhEsk60HdN/5
        96jWVkwSDioBYWYsiQHzfayV8FzRocY=
X-Google-Smtp-Source: AGHT+IEi/xQCaxdZxOdEliKraJYTgkvCK+ChOXGacZjHADhzQS1C+PsGJ0laBzOvFRfCkil7xFZ+9g==
X-Received: by 2002:a5d:474c:0:b0:317:618a:c72 with SMTP id o12-20020a5d474c000000b00317618a0c72mr1910812wrs.64.1692203064711;
        Wed, 16 Aug 2023 09:24:24 -0700 (PDT)
Received: from localhost (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d4112000000b003144b95e1ecsm21763549wrp.93.2023.08.16.09.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 09:24:24 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     linux-tegra@vger.kernel.org, Rayyan Ansari <rayyan@ansari.sh>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: tegra: Enable IOMMU for host1x on Tegra132
Date:   Wed, 16 Aug 2023 18:24:23 +0200
Message-ID: <169220305601.3328500.2515040658604852888.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810214543.16235-1-rayyan@ansari.sh>
References: <20230810214543.16235-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

From: Thierry Reding <treding@nvidia.com>


On Thu, 10 Aug 2023 22:45:41 +0100, Rayyan Ansari wrote:
> Add the iommu property to the host1x node to register it with its
> swgroup.
> 
> 

Applied, thanks!

[1/1] arm64: tegra: Enable IOMMU for host1x on Tegra132
      commit: ffca3ccbe50e12a83facfc7e9beabd1851345fa0

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
