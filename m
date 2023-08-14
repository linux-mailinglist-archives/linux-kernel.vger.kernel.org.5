Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9242C77B621
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbjHNKLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236758AbjHNKKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:10:51 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F010710C8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:10:37 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe1e1142caso40920805e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692007836; x=1692612636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXpw+9AlxegTAFzua86sCIHRPLxwX07oUCaO4xZ4CCU=;
        b=ajPe0gO9yHcdleOA7GfZrRigrZ3bWfpSNzNqR1rOXEVtoFpu4/rC04EVdHoEMvI+dS
         +4SQ59Gkl+jHC+BF1Pe0sxewKBaQFs6Eb4Oe7ppEmHvAQK2epRWKpIcUSqwXP3X4oY3J
         v57p1PL7RSuE1pdSA9tLs06eALpNiNelU1w5h55JHara6wKJ4EvsGzpIiFs5MFjsBOg8
         tgL+RnTmtVIyRiTkP7GVDTCa8MEu/s63REMJMgunvMC1SKcA1to0z6sV3ztBqZbhHEuK
         L6p7uvwD85TN0KbO8GWYm4CIr+0ubkYD1iif3TYVjeTOAW9/BuIS4r6VGaIxzZGD9vFz
         RGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692007836; x=1692612636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXpw+9AlxegTAFzua86sCIHRPLxwX07oUCaO4xZ4CCU=;
        b=B/GFX/dJMCmU7d6fYtZEhimtRuKX9wVbt7VRLU7WOx6FHY8oGKh0Q8Jz8UTMnUQJID
         gXN0VPaDvK0PHOwGnVD0T4J9DgAWWgphZbqUur7wdmSn2LPqf0vPVsEC26qbNaKKzCyE
         0B/N/a3L0IpcQ9OvZz6+GTqKw5XCKPXraAZbuLVPlIaXXg4g9l2PUwhd/nRJOxHd2JE7
         MSUiEjjKn1Jhsj9VVDovIT7fsYIH7KnmAbtBBvFV/4X1KkJ0FjvJTd6nRdboE9Oyohn8
         bAi2tmPMakb/Id+23/toOabpv63BYuFRnWgTFgyujaEYiil8OuRMFQPatvvjF2kqdO+M
         ftXA==
X-Gm-Message-State: AOJu0YzoJIQ7B/lSZJweMLYj9qhsaO7inEGfBWpLsYkbSqy7XzlkXUmr
        NrfFNXUC8BvmcXYxwIiXEMF74bdnHaM1Jud8SLU=
X-Google-Smtp-Source: AGHT+IFNo+C5EmcPuov2d0Qzt0mhqc8nKMkq/SPTXqLgaQ6sBJ4IjK1X3uzRcysnFfcyTIarPhDfGA==
X-Received: by 2002:a7b:cc1a:0:b0:3fe:2859:a7b1 with SMTP id f26-20020a7bcc1a000000b003fe2859a7b1mr7828426wmh.19.1692007836449;
        Mon, 14 Aug 2023 03:10:36 -0700 (PDT)
Received: from hackbox.lan ([84.232.191.92])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c294500b003fbaade0735sm16750396wmd.19.2023.08.14.03.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 03:10:35 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Peng Fan <peng.fan@oss.nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: imx: composite-8m: fix clock pauses when set_rate would be a no-op
Date:   Mon, 14 Aug 2023 13:09:57 +0300
Message-Id: <169200755848.527063.16780652057592961020.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807082201.2332746-1-a.fatoum@pengutronix.de>
References: <20230807082201.2332746-1-a.fatoum@pengutronix.de>
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


On Mon, 07 Aug 2023 10:22:00 +0200, Ahmad Fatoum wrote:
> Reconfiguring the clock divider to the exact same value is observed
> on an i.MX8MN to often cause a longer than usual clock pause, probably
> because the divider restarts counting whenever the register is rewritten.
> 
> This issue doesn't show up normally, because the clock framework will
> take care to not call set_rate when the clock rate is the same.
> However, when we reconfigure an upstream clock, the common code will
> call set_rate with the newly calculated rate on all children, e.g.:
> 
> [...]

Applied, thanks!

[1/1] clk: imx: composite-8m: fix clock pauses when set_rate would be a no-op
      commit: 4dd432d985ef258e3bc436e568fba4b987b59171

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>
