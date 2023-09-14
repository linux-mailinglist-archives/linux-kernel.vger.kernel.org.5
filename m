Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D127A0347
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238320AbjINMDw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Sep 2023 08:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbjINMDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:03:50 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F54FCF3;
        Thu, 14 Sep 2023 05:03:46 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-58dfe2d5b9aso12660707b3.1;
        Thu, 14 Sep 2023 05:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694693025; x=1695297825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GF1PWLezaV5cS/gfIcso5BSf2fmLOe110VZS1fv5p0=;
        b=NIUXfVIumMR3bu6Ocn85CUDEajho32k9QgKuKsfPLg8JVuARxq6ZgIkQGIu/GLn2dn
         i9ttVR0SpExv2AfrzM7xDxu9R7b9hDeergfwFm53ClpspEo+IMoyDDMXxYwwWBBNasy7
         vC71AK4RVnsODMaXMSRFkEcDOwDgWzDtGWSBKO0MIaDu4yDYsl+iUB+I9zxSC/goowCj
         +CONWZYSTxuwVrpsFjomVnxwi7bjFpfO8KRBO7Xj0uRiBWt2h62M61qE+dAw8KcHbxiy
         Pwkhy+4uR9whTnLPxkJuUrngSyzcwm/xtUuXvtStM8La2F03Ad4LaOVIMOp1sbk5OCwG
         nowA==
X-Gm-Message-State: AOJu0Yxny1074aJsAAiMw3DC8v3kNA6Eg5P3dkhh4A+trajjVTt2naeV
        EFjBm4bk0+KAxF6vrAo52QG1xmzBbqQzsA==
X-Google-Smtp-Source: AGHT+IFofKJvvJUeW1AjzM2TvLH82KxkXdQFhqIOe+T+sULFQzmzIfWz7gDl+6UzVabOLUH73cmpHw==
X-Received: by 2002:a81:a04b:0:b0:56f:fd0a:588d with SMTP id x72-20020a81a04b000000b0056ffd0a588dmr1167104ywg.8.1694693025633;
        Thu, 14 Sep 2023 05:03:45 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id p188-20020a0dcdc5000000b005777a2c356asm281378ywd.65.2023.09.14.05.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 05:03:44 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d8165e3b209so2075333276.1;
        Thu, 14 Sep 2023 05:03:44 -0700 (PDT)
X-Received: by 2002:a25:ab47:0:b0:d80:ff8:d45f with SMTP id
 u65-20020a25ab47000000b00d800ff8d45fmr1229473ybi.14.1694693024243; Thu, 14
 Sep 2023 05:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230914111801.586648-1-ulf.hansson@linaro.org>
In-Reply-To: <20230914111801.586648-1-ulf.hansson@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Sep 2023 14:03:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWpYuk93eQn_pW=D3iBKFvv66LHBmPu3xdL0DfNRU+d_g@mail.gmail.com>
Message-ID: <CAMuHMdWpYuk93eQn_pW=D3iBKFvv66LHBmPu3xdL0DfNRU+d_g@mail.gmail.com>
Subject: Re: [PATCH 09/17] pmdomain: renesas: Move Kconfig options to the
 pmdomain subsystem
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 1:18 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> The Kconfig options belongs closer to the corresponding implementations,
> hence let's move them from the soc subsystem to the pmdomain subsystem.
>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: <linux-renesas-soc@vger.kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
