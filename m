Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFA078D20C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 04:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241700AbjH3C13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 22:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241713AbjH3C1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 22:27:14 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990E0CD2;
        Tue, 29 Aug 2023 19:27:11 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52a4818db4aso6463484a12.2;
        Tue, 29 Aug 2023 19:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693362430; x=1693967230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JE8hnIxCXr8U3qk0svTUe9K1s4/roIND9EZ2Jy2dqo=;
        b=DSxweWxa9Qh2f7CnqJxG3DgbVeVqK/IKs9mfdmE2rIPKGiFmA63NtzJBm5+eljHsfD
         b7puvs7YpQPgGb5yVSucWQ1ejGuBa3Lzwz/togtofUrFdcE4V4/SLndR4avMTq96lVLf
         QKtZDEY2LIDoeDU8e+6SUC0QlXL7hAB4IX9F64ZafGXOMBqRAUsJbNwvdoVK45HZs1Vg
         907N+P3BqltxnSU9JGfZlb9dWTyAOx6RKzcgUHl2EtdnE8aq2oGdrVh7C9k71HV+OK+A
         L3Ypqc4gt1Tkf4OcBlScC2b6YreJflPulJQixV6kkydxXo4qLLAJEMmRFYCrsznwNhaO
         Ug9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693362430; x=1693967230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JE8hnIxCXr8U3qk0svTUe9K1s4/roIND9EZ2Jy2dqo=;
        b=S+pLnyS+NEVEqdBhWTT57UPKoEfheE5CpQzfE0gidd+qyG8dhTIKNtjK1QNvybkwZ0
         cWUxMRyvl4weXIv3keA1elIMqEVUD4T6EHCfX1pykE8oj5wfOOdVzVWyuf9Nf9pbxHoh
         trc2BMkYuifL3W/rbe/zRGFa2JG+1fIIH/PueD3U4g1TvNYk//k+q9X2D2R8nc+mxWpG
         wt6VnSfoRfVcg/m+abu0hzKRqQmPCMbjZ91GpdrYjJu2d0J9am49bsh4qqJcUkP4gWQK
         9/VNxhxsnWD7zXmimiicstSLXfxPthQ9LpCiHwvXTs7KIYc2AhSSHSY86XmIL1ZBmWwp
         zcHg==
X-Gm-Message-State: AOJu0YyJ27VSbnFrxTzaTw2KFFhKbQoQe/tXs0pkdhL9FR4+whRHCKg6
        oz9Ks1p0W9NiC2ydJ/WIzc1ysPjrnF++EyOCl7M=
X-Google-Smtp-Source: AGHT+IH8LujHkY5DxX8PNSWnczR+zMlFkeA9IvuEfId5ZWsGHO109BtUJvyFnH1zqu1T3/muTPWzqG0CMUTETs3oOI8=
X-Received: by 2002:a05:6402:8d0:b0:527:237d:3765 with SMTP id
 d16-20020a05640208d000b00527237d3765mr777624edz.26.1693362429902; Tue, 29 Aug
 2023 19:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <391c4270-637a-2afb-210d-6b6dfef01efa@intel.com>
 <20230828100313.3051403-1-benchuanggli@gmail.com> <CAG-rBig+koxDf3TuC-0p=tcBY_2WM1sPCvRDtjRmR7AnikrN-A@mail.gmail.com>
 <CACT4zj-BaX4tHji8B8gS5jiKkd-2BcwfzHM4fS-OUn0f8DSxcw@mail.gmail.com> <CAG-rBihBkTeZR6yMSF+5zg-h1U1pxGuN-nv=Y7DXLvxV435hDw@mail.gmail.com>
In-Reply-To: <CAG-rBihBkTeZR6yMSF+5zg-h1U1pxGuN-nv=Y7DXLvxV435hDw@mail.gmail.com>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Wed, 30 Aug 2023 10:26:42 +0800
Message-ID: <CACT4zj_84eCYOq56zdqaydaEGqyqBrXDrsTkDRyCntvVF78-0A@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix
 SoCs can suspend
To:     Sven van Ashbrook <svenva@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        skardach@google.com, adrian.hunter@intel.com,
        SeanHY.chen@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, jason.lai@genesyslogic.com.tw,
        jasonlai.genesyslogic@gmail.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, reniuschengl@gmail.com,
        stable@vger.kernel.org, ulf.hansson@linaro.org,
        victor.shih@genesyslogic.com.tw, victorshihgli@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Wed, Aug 30, 2023 at 12:35=E2=80=AFAM Sven van Ashbrook <svenva@chromium=
.org> wrote:
>
> + Rafael for advice on runtime_pm corner cases.
>
> On Mon, Aug 28, 2023 at 10:48=E2=80=AFPM Ben Chuang <benchuanggli@gmail.c=
om> wrote:
> >
> >
> > My concern is that when runtime_pm is false, gl9763e is disabled LPM
> > negotiation, gl9763e can't enter L1.x and s0ix may fail.
> > It seems that runtime_pm will always exist and that's ok.
> >
>
> Thank you. I believe we can address your concern.
>
> - XXX_suspend/XXX_resume (i.e. classic suspend/resume) depends on
>   CONFIG_PM_SLEEP. This always selects CONFIG_PM. This always includes
>   the runtime_pm framework. So, if XXX_suspend/XXX_resume gets called,
>   the runtime_pm framework is always present, but may not be actively
>   managing the device.
This is ok.

>
> - "when runtime_pm is false" AFAIK the only way to disable runtime_pm
>   when CONFIG_PM is set, is to write "on" to /sys/devices/.../power/contr=
ol.
>   See https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-devices-=
power
>   In that case, the runtime_pm framework will activate the device, callin=
g
>   XXX_runtime_resume() if necessary. Are there other ways of disabling it=
?
>
> - if /sys/devices/.../power/control is "on", then:
>   gl9763e_runtime_resume() always called -> LPM always disabled
>   gl9763e_suspend() -> LPM enabled -> gl9763e_resume() -> LPM disabled
>   In between "classic" XXX_suspend and XXX_resume, LPM will be enabled,
>   so the device can enter L1.x and S0ix.
In this cas, after gl9763e_resume(), it is LPM disabled.
Is there no chance for gl9763e to enter L1.x again when the system is idle?

>
> And the LPM negotiation flags look correct.
> Does that address your concerns?

Best regards,
Ben Chuang
