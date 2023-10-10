Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C99B7BFF47
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjJJO2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbjJJO2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:28:22 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B97C6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:28:18 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d81dd7d76e0so6650969276.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696948097; x=1697552897; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VieWLMAOeMVC3rl3XsXfYG0X2k/MOxV7sD3CF+kS9Yc=;
        b=UiKbVNY5kR1X7vOoXvQOd0vIPAqzOVn/Y/BfLBEvgPYCAcG/aHC4lp2z+6gF7y1u/F
         C9tPiwLjVWTbEuAlabTUjp50RTtBMHIDAOBpLzzJmpZ8PKy9WOOy8GwrvBT/ZkHgyxNt
         dIxRMqoZepzr0XFS5YqmHi7bC+/4CBHNOA8FhhHa/8y2vpLaTr/Tb6hXJUJ1uY3lIwDw
         Ixy25xNZfXNEkq/aAMbRIEbuDfYoQ/b9OKOUArfJajaWofAKSNhuistgsWVRYTEwAkF8
         t5ShV2+CIOgXH55sM2u9Kx1iiEOkjK5EKM/XW/IbHOPpEYxebLxeDvZawCTfHxsx4nxm
         dNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696948097; x=1697552897;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VieWLMAOeMVC3rl3XsXfYG0X2k/MOxV7sD3CF+kS9Yc=;
        b=MtZvGmElGW+FG/Xbo2O2TC3794BoblHIQPp8VUJGdJt6QL4L7jC5gll06kdNFJsVwJ
         e6hXyTTY0mMtEi6p6dfN6GcK5rnjJJOPOEbVc9n5EPJmLWi+8jgrreNy843/uRYXNsbI
         TxjvYVq9Q8vViLTP9wBTNm2/lKSlQNHdAMW2VpbIY2AE/8MTEnP0EsuzbC9/b3YcJKlf
         3PDr/QO1+YvyrqV/9iy5iYUEeH3ONpHSWNTi8qe6HNddzXznc5TkMjlcyA8epV6EKqZC
         Tnky5bt61ZH4X9LB8yJ9sKcFNmkKbPIxrdmJ8GINhs2Nbn9x2mjI1FBVdsV7XmV8uOEo
         jzHw==
X-Gm-Message-State: AOJu0YwTcuqJkptjXVWQy1lGCQ4KbU+0d9op+m6scLNbGNc/EOjmi3uB
        SMuKEO8JUy16h1SdknLBo1gaR7pVlgG1Ht7208dtAA==
X-Google-Smtp-Source: AGHT+IEyR5gyWtdqFzf5k1RG5nTB/n8+9hlLKGCgokeEptzxamgxwENVYWcMtkuqr9JZfmwIzZbHqicq0j/xu0oox4Y=
X-Received: by 2002:a5b:a50:0:b0:d97:213b:4775 with SMTP id
 z16-20020a5b0a50000000b00d97213b4775mr10319439ybq.34.1696948097328; Tue, 10
 Oct 2023 07:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231002200610.129799-1-tmaimon77@gmail.com>
In-Reply-To: <20231002200610.129799-1-tmaimon77@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Oct 2023 16:27:41 +0200
Message-ID: <CAPDyKForPWPHoAuRuyXBHRpNVA9MvYa-eTXDrHx8Z94nSWpXBg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] add NPCM SDHCI driver support
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        adrian.hunter@intel.com, skhan@linuxfoundation.org,
        davidgow@google.com, pbrobinson@gmail.com, gsomlo@gmail.com,
        briannorris@chromium.org, arnd@arndb.de, krakoczy@antmicro.com,
        andy.shevchenko@gmail.com, openbmc@lists.ozlabs.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2023 at 22:06, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> This patch set adds SDHCI support for the Nuvoton NPCM Baseboard
> Management Controller (BMC).
>
> Deeply sorry it took that long until sending version three, promise to try
> to do better on the next versions (if needed) :-),
>
> The NPCM SDHCI driver tested on NPCM750 and NPCM845 EVB.
>
> Addressed comments from:
>  - Andy Shevchenko : https://www.spinics.net/lists/devicetree/msg638000.html
>
> Changes since version 4:
>  - Remove unnecessary clk_disable_unprepare function.
>
> Changes since version 3:
>  - Use devm_clk_get_optional_enabled function.
>  - Add mod_devicetable.h.
>  - Modify copyright year.
>
> Changes since version 2:
>  - Add data to handle architecture-specific SDHCI parameters.
>  - Change config place in make and kconfig files.
>  - Calling sdhci_pltfm_free to to avoid a memory leak on error.
>
> Changes since version 1:
>  - Use correct spaces in the dt-bindings.
>  - Drop unused labels from dt-bindings.
>  - Order by module name in the make a configuration.
>  - Remove unnecessary blank lines.
>  - Using devm_clk_get_optional instead of devm_clk_get.
>
> Tomer Maimon (2):
>   dt-bindings: mmc: npcm,sdhci: Document NPCM SDHCI controller
>   mmc: sdhci-npcm: Add NPCM SDHCI driver
>
>  .../devicetree/bindings/mmc/npcm,sdhci.yaml   | 45 +++++++++
>  drivers/mmc/host/Kconfig                      |  8 ++
>  drivers/mmc/host/Makefile                     |  1 +
>  drivers/mmc/host/sdhci-npcm.c                 | 94 +++++++++++++++++++
>  4 files changed, 148 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/npcm,sdhci.yaml
>  create mode 100644 drivers/mmc/host/sdhci-npcm.c
>

Applied for next (and by amending patch2 to remove some commas), thanks!

Kind regards
Uffe
