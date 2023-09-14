Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20A179FEB4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbjINIoy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Sep 2023 04:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbjINIot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:44:49 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373371FC9;
        Thu, 14 Sep 2023 01:44:45 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-59b8f5b6c0aso7805657b3.0;
        Thu, 14 Sep 2023 01:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694681084; x=1695285884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TWBuYKi1PnXyDlaO9Zh+t3iJnn6mw95ujQMJVIW/pE=;
        b=v7ipYdvacqT7QsdoD3wD/F2QK8KcSN4sKlIWfxDIfy1J0d6qMOVhKkfWx7DweAlFo6
         Y0WevVOPua09sABTpgaJVF3jqdZ8PNDP/f+Heg62DmpauuKYsBogXbE0Ut04Zj0+1vjP
         ERxMlykocFiSo/vbHoVj5IwzP8R7qhly9nXLBmXVoivXKedopoG8cjcikZdiVRnjKF+X
         dBIpMwDlBtpIfDfCm/qssMMA83bYjKpvGPtTHko2IqJhJ8TmOan5t7OddYe13UGBkMIJ
         MOuWpVnrMlHmNcNaNKaUl6lspHOu0Mmk/RnDiEgZiK5EsqJYT5Euo7iqkEm29A8zfWHH
         D39w==
X-Gm-Message-State: AOJu0Yy4nap/Szj+hPM5vn4IoXcpUqL8ejQMh3TBaQiVJH8aTv59aDw1
        eYVmHsFwfy3F2+rMQxBiMxIgmRNO3yJvzA==
X-Google-Smtp-Source: AGHT+IF+B6FHu4HgzJGKcwXNRaELWz9krCDg4TZoAfoqHT7AZHJVZbB4zf4SWMypzYIl3n/hpWqZUQ==
X-Received: by 2002:a0d:ccd3:0:b0:59b:4ed2:a33 with SMTP id o202-20020a0dccd3000000b0059b4ed20a33mr5516716ywd.35.1694681084125;
        Thu, 14 Sep 2023 01:44:44 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id f128-20020a0ddc86000000b005929fd6a6c7sm222757ywe.41.2023.09.14.01.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 01:44:43 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-58c92a2c52dso7549137b3.2;
        Thu, 14 Sep 2023 01:44:42 -0700 (PDT)
X-Received: by 2002:a81:a50d:0:b0:59b:14ca:4316 with SMTP id
 u13-20020a81a50d000000b0059b14ca4316mr5373508ywg.43.1694681082479; Thu, 14
 Sep 2023 01:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230913203805.465780-1-ralph.siemsen@linaro.org> <20230913203805.465780-2-ralph.siemsen@linaro.org>
In-Reply-To: <20230913203805.465780-2-ralph.siemsen@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Sep 2023 10:44:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVpGGHcP4tDunsZ_b5sSucezZn76PwLaCbWF-rFS4hZpg@mail.gmail.com>
Message-ID: <CAMuHMdVpGGHcP4tDunsZ_b5sSucezZn76PwLaCbWF-rFS4hZpg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] clk: renesas: r9a06g032: name anonymous structs
To:     Ralph Siemsen <ralph.siemsen@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralph,

On Wed, Sep 13, 2023 at 10:38 PM Ralph Siemsen <ralph.siemsen@linaro.org> wrote:
> Clarify the content of the r9a06g032_clkdesc structure by naming the
> remaining anonymous structures defined inside. Renaming each field and
> updating the doc then becomes necessary in order to avoid name
> duplications and kdoc warnings.
>
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>

Thanks for your patch!

> --

Please use three hyphens next time, else the below will still end
up in the final commit.

> Changes in v2:
> - split this out as a separate commit

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v6.7, with the above fixed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
