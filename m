Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCD37B7A49
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241734AbjJDIkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241712AbjJDIkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:40:14 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBFEB0
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 01:40:10 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9ad8a822508so338570266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 01:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696408809; x=1697013609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVHhdkhp4eR4frDUkO6xbt9ArHtMALGKAATK2ZDSFtc=;
        b=HKj2aZ7MXAxzWjyKDR842YOhCXbR29ilf3dFH0wxG6/cvcLFgwo4s6aUO8RK9Vq/5J
         UkXhvNBuZbVIsbkZo+znOU8BQLrXsCyY+u7sn/YmGR4CkUXYnGux9eIiGSuCbNn+y+hq
         QOpAwFfU7F9tgQOMDCyI44cl9FBpHv9fCcRIVlXU3GmKIEmON4x/tkPLFB3273xUU/yp
         pCD7PwfQr9TwZtSgcNyU0Jh5ktWkjihBagEw5iqVE/kuvboInoqHYsi9oLZHgcQQIvED
         nXtbTWLEI48Tg9oy7D98knBCATdPYY1baW8ghL+UpaQkPL2XXJKLbh8wr0dhi0808uuA
         vhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696408809; x=1697013609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVHhdkhp4eR4frDUkO6xbt9ArHtMALGKAATK2ZDSFtc=;
        b=fYUczeX8E9QZHX8di3sfGXNKZOstEQuPV8MVP0hCtvFrUeo0D2LxjqP2R2/FT2/58l
         OLeZ+fH/IwMOheU112PfHsRzolCnTqWwZRr6/nY8Z0jO8wsBXiphp9o/QWNEWfD7AnY4
         OPkFIfKiWr+kQg3e+DNvH+E4dl7mbr315ZLoHKp+ximhmSlJOG9SAZihdgZbjNyhQxuS
         POfeoYbgs5y5eZMFfB2TNHSNM09AGS8JEEtSEfOcankWl2rTRdWQsrJIGBV63ncl6ovB
         F+HaWH/I5JEU7RikLaEg4HE0JniD/3hMNbFjBJMUQL9uer94/QDcxGVVOJNXRhSYVvvi
         raLA==
X-Gm-Message-State: AOJu0YxNA55JPY/Fz3QUljq/CLmW+R2UNtSgH+UpZYeAiMgdOlsYJ8RI
        ZhbQtS0RMeAIXm3EIq21llnk8w==
X-Google-Smtp-Source: AGHT+IGxGxUBlwF4Y53MwDjX8nT5oc9ijNUlqTAgeGKz6abn9IpaJEhrWZXPB7ixkM3kL1CsQzJt5A==
X-Received: by 2002:a17:906:31d6:b0:99b:ed44:1a79 with SMTP id f22-20020a17090631d600b0099bed441a79mr1376838ejf.3.1696408809253;
        Wed, 04 Oct 2023 01:40:09 -0700 (PDT)
Received: from hackbox.lan ([86.123.99.172])
        by smtp.gmail.com with ESMTPSA id j24-20020a170906411800b009b65a698c16sm2351094ejk.220.2023.10.04.01.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 01:40:08 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     linux-arm-kernel@lists.infradead.org,
        Adam Ford <aford173@gmail.com>
Cc:     marex@denx.de, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: (subset) [PATCH V3 1/3] arm64: dts: imx8mp: Add easrc node
Date:   Wed,  4 Oct 2023 11:39:40 +0300
Message-Id: <169640874933.222477.9945058108264507999.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831044431.250338-1-aford173@gmail.com>
References: <20230831044431.250338-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Aug 2023 23:44:29 -0500, Adam Ford wrote:
> The i.MX8MP has an asynchronous sample rate converter which seems
> to be the same as what is available on the i.MX8M Nano.
> 
> 

Applied, thanks!

[3/3] clk: imx8mp: Remove non-existent IMX8MP_CLK_AUDIOMIX_PDM_ROOT
      commit: 05eeeff22b216e871be76dcf216a2fdda48880e2

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>
