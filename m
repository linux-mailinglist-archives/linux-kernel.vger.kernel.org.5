Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940F77A0329
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238194AbjINL7l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Sep 2023 07:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbjINL7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:59:39 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD97CC3;
        Thu, 14 Sep 2023 04:59:35 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-59b5484fbe6so10296287b3.1;
        Thu, 14 Sep 2023 04:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694692775; x=1695297575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ciw26AsWEo5nycCia/57VQEtOMTYDTMQR3HYgBEYJoQ=;
        b=SzLDjaoZz34yKmaSJUoPrD1Mzq1pUBHQ62NnE9QolpquROzHb9u6WrILUIPZ53G6e2
         koPsMGtl5lr0kOOBd4CK7fAfauMTV1tBDBX7DcwIDeEw802ipnputqyCpRatKCZKvM/b
         IoB5Q7FGfBN048NtiCoVicxCTj/n9CCrCFvup7vGX17DfBmWLMWoKTIqlr3raGa9XNmj
         DsvmwqTz0Mzs9YWESzPwe2fBCz1YynpoBn/1+xyFTgMatw5XYTa0Nml4fZb3GWuY4sbK
         ciBh/LZ3NQ91WQqr6iW44mRe/hXjlja/+K87QIK45ahbKc3fBXb4dcIQHWYhWhG0Cnv+
         hgpA==
X-Gm-Message-State: AOJu0Yyy2SHjhThM1k0HbLK3L1rkiR5m+1ySx4TcvMieTJI7xuN3B3Fm
        d353Re064JeV1znMLvCEW/4nbV0Y7xhYfA==
X-Google-Smtp-Source: AGHT+IH42ycJY6zUJRgQ0J02BdrTkwTX2BMIWOG7gYcQ93lwjVn0mo52yd7XVh2B2TeM991fSRD7ew==
X-Received: by 2002:a81:4ec5:0:b0:59b:e9d6:cad1 with SMTP id c188-20020a814ec5000000b0059be9d6cad1mr2069931ywb.22.1694692774916;
        Thu, 14 Sep 2023 04:59:34 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id j129-20020a819287000000b0059b3c406af3sm280322ywg.82.2023.09.14.04.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 04:59:34 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-59be6605e1dso10123717b3.3;
        Thu, 14 Sep 2023 04:59:34 -0700 (PDT)
X-Received: by 2002:a25:8c82:0:b0:d81:9068:3606 with SMTP id
 m2-20020a258c82000000b00d8190683606mr1261617ybl.24.1694692773748; Thu, 14 Sep
 2023 04:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230914111554.586438-1-ulf.hansson@linaro.org>
In-Reply-To: <20230914111554.586438-1-ulf.hansson@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Sep 2023 13:59:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU-0i34XiQTkjkzJrG7kFX8kdSQjG57WS+sW+OLTLH4eg@mail.gmail.com>
Message-ID: <CAMuHMdU-0i34XiQTkjkzJrG7kFX8kdSQjG57WS+sW+OLTLH4eg@mail.gmail.com>
Subject: Re: [PATCH 01/17] pmdomain: Prepare to move Kconfig files into the
 pmdomain subsystem
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On Thu, Sep 14, 2023 at 1:17 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Rather than having the various Kconfig files for the genpd providers
> sprinkled across subsystems, let's prepare to move them into the pmdomain
> subsystem along with the implementations.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks for your patch!

> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -175,6 +175,8 @@ source "drivers/soundwire/Kconfig"
>
>  source "drivers/soc/Kconfig"
>
> +source "drivers/genpd/Kconfig"

drivers/pmdomain/Kconfig

> +
>  source "drivers/devfreq/Kconfig"
>
>  source "drivers/extcon/Kconfig"
> diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
> new file mode 100644
> index 000000000000..c32a76b51840
> --- /dev/null
> +++ b/drivers/pmdomain/Kconfig
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +menu "Power Domains Support"

PM Domains

> +
> +endmenu

"b4 am" cannot download the full series at once.
It looks like you didn't send it as a series, but as individual patches?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
