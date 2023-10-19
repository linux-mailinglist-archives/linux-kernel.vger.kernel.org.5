Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587187D042F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346610AbjJSVuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbjJSVt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:49:58 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2BE116
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:49:51 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53db1fbee70so131861a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697752187; x=1698356987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjbyO4SJjTnd1AUbvV5WE6Kpd8PKFlqFC7dLrc64puM=;
        b=La3bglWPNzmH59knU40QsbuSsMZ44upB7f1rM1NcvB0ssfzdhzmn39CMlC3cGwRt4k
         JrdYXy5Vg9xuKxWjgmTUzTzDufBru2ymb4KQ6fNKsBjyf8shCHL5q7u5qyVWhqAY+Nyg
         zCjnoXsOj+nkD2cUEiyO99/51R7eIE53vLuoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697752187; x=1698356987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjbyO4SJjTnd1AUbvV5WE6Kpd8PKFlqFC7dLrc64puM=;
        b=oL4Cy8CzTj7EPwW5+H0wzGssbjZ7hXT5GXvz0si3DUdMrAkacTdNRYD2czhr5l7Lwc
         HK5d4FuFfJ70v8ep2AQXd4QAHrgY92d7IxOdZVSmgIiyftmP5tco40umEw8XCWfuJsL4
         kl/sO7+0/5GeVaDzOYL8y2iujzsWunBZxzAbcxR+flCELVOhdDmfjHkCoZZPVGyyJg1p
         gdeA5O31kEhYJVPgWa8bWghWsNyfxC7Y4WvPOKo7axaKjoi//gWV57LL9JnPco+AGRFR
         UsV0NBT85Q/rknp8FhbfJa9YrlBf+eztDCZRzSF9xuXfALwjjQvtWF1bllHUD2UeQ+e5
         G7yA==
X-Gm-Message-State: AOJu0YyvqC2jLAZZZ1//wRX9JRuO9dvp5mvIvZZZI9d15yiQndJMruof
        g+4Yxq63OtRbxefk++cYPHtTUJh2+2c4jmKYhkC8EA==
X-Google-Smtp-Source: AGHT+IEEl/0DUZj5T0+5N3QQRZtRpX4vuZB+Sbe4Pgl/8zuIwd+3X79Q3xuI0Niz0vmwInmt/yk2EQ==
X-Received: by 2002:a50:a691:0:b0:53e:34c5:ad8e with SMTP id e17-20020a50a691000000b0053e34c5ad8emr144433edc.19.1697752187415;
        Thu, 19 Oct 2023 14:49:47 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id cb9-20020a0564020b6900b0053ebf32da31sm269604edb.57.2023.10.19.14.49.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 14:49:46 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40662119cd0so10245e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:49:46 -0700 (PDT)
X-Received: by 2002:a05:600c:358e:b0:405:35bf:7362 with SMTP id
 p14-20020a05600c358e00b0040535bf7362mr35144wmq.0.1697752185862; Thu, 19 Oct
 2023 14:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231013091844.804310-1-yangcong5@huaqin.corp-partner.google.com> <20231013091844.804310-2-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20231013091844.804310-2-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 19 Oct 2023 14:49:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V3Y6bSkCivGLgmJS7wQ+U=R=43inqKJYVX-e_rrDpjiQ@mail.gmail.com>
Message-ID: <CAD=FV=V3Y6bSkCivGLgmJS7wQ+U=R=43inqKJYVX-e_rrDpjiQ@mail.gmail.com>
Subject: Re: [v4 1/3] drm/panel: ili9882t: Break out as separate driver
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
        hsinyi@google.com, linus.walleij@linaro.org, swboyd@chromium.org,
        airlied@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 13, 2023 at 2:19=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> The Starry ILI9882t-based panel should never have been part of the boe
> tv101wum driver, it is clearly based on the Ilitek ILI9882t display
> controller and if you look at the custom command sequences for the
> panel these clearly contain the signature Ilitek page switch (0xff)
> commands. The hardware has nothing in common with the other panels
> supported by this driver.
>
> Break this out into a separate driver and config symbol instead.
>
> If the placement here is out of convenience for using similar code,
> we should consider creating a helper library instead.
>
> Co-developed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/Kconfig                 |   9 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 371 ---------
>  drivers/gpu/drm/panel/panel-ilitek-ili9882t.c | 759 ++++++++++++++++++
>  4 files changed, 769 insertions(+), 371 deletions(-)
>  create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c

Pushed to drm-misc-next:

e2450d32e5fb drm/panel: ili9882t: Break out as separate driver
