Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A040477B633
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjHNKMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbjHNKLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:11:45 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380041715
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:11:04 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe2048c910so37918475e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692007862; x=1692612662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MaXuPYqFCt1cmjyTonXoDUuLsOvVzVy8hsMCkW5COjI=;
        b=bSZ+/4DNFkKeUladW5jBTnvjRx/qaS/6iW4dZtbTJm38E+5ad7uWL9AMgasZ3llT0I
         PDRy76FrGf8RlBnMtm3W1VFdT3kP6bXg9Q8QJkoHPYGr5r6wVLnwzSjzfGhmOZo2ayR3
         DHYgavRaCGHyr9k/1EocIc+NCGu3Ph321AxJhwY94CxyBXWNq1sM2NzVXAdhzhRuA0sT
         dxX7mXAAWctFDbbtY5gmPC1eL9SLDoTXYGE1fy6Q+S0bsIV/4LgnNTe792x02K0eFh5F
         PkuMNyiuXgYM12DveOXhOfeU9UCLiAoFVFbjq1YLgmqQsdb/3VWysQ6pd+MnAYXfDn1v
         zc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692007862; x=1692612662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MaXuPYqFCt1cmjyTonXoDUuLsOvVzVy8hsMCkW5COjI=;
        b=dPcRIQIezfNYBhDq3nNNiZS2EuvB5iqvwWKQd3pUwn+OSxh2TF4NWIy2YKL0SD91Ar
         1sKZ+Km0NuSFE1yPldJRCh3OitkN5ld42IMFQXMc1aWbfPedUScoJgaDrT5sOJUZATUZ
         99U8cYpMHESpC+aZhFeUcK3YBCGdk/NZAQK43IX4F7aMFTqvaE+YuQR0Gi7DIhSG9uME
         CzLgS+bZgSbvXnArvs5OuUjcu84688ax/QzHynzdFnyL7AIwmNzjFg4AqdCK7YibsL2q
         ZyvhY4o2JFemCZAtuEHna97w1q2WdIfOlYxvHJaMP/tQb/44Kc7YLEc5Z3fT1MHLzK29
         vB3w==
X-Gm-Message-State: AOJu0Yz67LdvjBI68Y7aq+Tw6chZW/fSI+uQm/6bE5pKgDyh1wSpWv4s
        2cx8OeGHUVjqDW0TDfvjtQHOyA==
X-Google-Smtp-Source: AGHT+IGZPHA+4ZqAgm+/n/NGaG1qCgAGrKpvZpUTdFrXfR8fObUEhvPkLDdn3AhuUSwCV+8k2c4eZw==
X-Received: by 2002:a05:600c:214d:b0:3fc:62c:8275 with SMTP id v13-20020a05600c214d00b003fc062c8275mr7326938wml.35.1692007862509;
        Mon, 14 Aug 2023 03:11:02 -0700 (PDT)
Received: from hackbox.lan ([84.232.191.92])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c294500b003fbaade0735sm16750396wmd.19.2023.08.14.03.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 03:11:01 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH 1/2] clk: imx: pllv4: Fix SPLL2 MULT range
Date:   Mon, 14 Aug 2023 13:10:02 +0300
Message-Id: <169200755846.527063.15298642342561865531.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625123340.4067536-1-peng.fan@oss.nxp.com>
References: <20230625123340.4067536-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 25 Jun 2023 20:33:39 +0800, Peng Fan (OSS) wrote:
> The SPLL2 on iMX8ULP is different with other frac PLLs, it can
> support VCO from 650Mhz to 1Ghz. According to RM, the MULT is
> using a range from 27 to 54, not some fixed values. If using
> current PLL implementation, some clock rate can't be supported.
> 
> Fix the issue by adding new type for the SPLL2 and use MULT range
> to replace MULT table
> 
> [...]

Applied, thanks!

[1/2] clk: imx: pllv4: Fix SPLL2 MULT range
      commit: 3f0cdb945471f1abd1cf4d172190e9c489c5052a
[2/2] clk: imx: imx8ulp: update SPLL2 type
      commit: 7653a59be8af043adc4c09473975a860e6055ff9

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>
