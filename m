Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE63178E404
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 02:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243929AbjHaAeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 20:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjHaAeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 20:34:18 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB20E8F;
        Wed, 30 Aug 2023 17:34:15 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52a1ce529fdso252490a12.1;
        Wed, 30 Aug 2023 17:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693442054; x=1694046854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WYYqNRnYoE3zNvJQG0tX9C21x0Z57t6U8jcoHTh4gw=;
        b=bPN27HmYgPYAdnCvHaUn4KEHNdPRcIHp/jvJxnurXwLviz0VZeKeOlmDO1cODV4+Fy
         MhFqMw/iDHnT9e/6dxu5KGgUZ8s55Y4N7NyuRUWtBYUo1UKaR9k6V5294/f+CNs8UtaZ
         Wk8/OTPbP+rnQHF6x+DU3C8DePnr3XpU4e4yPjmYKo1KIjDT38r86c2B3mrMTQuF4UgH
         E89I0JdmDee+nhz2hTutyw+rKArNliM2dMeoYUFdX39LjtpMPQRemkgEiMHEkXUmzha9
         lHVtR8t9vwfsr33AxZA1Uev7BE5EvvP4w436blB7agnPOHBZbmORcBVDxH1YxrYGWv0i
         sk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693442054; x=1694046854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7WYYqNRnYoE3zNvJQG0tX9C21x0Z57t6U8jcoHTh4gw=;
        b=lrhtZN5yLrxJLl1BKcjTh0vjJugft6Vn+744YN04sCdkcNLwUj4k6AT85oFFVhXWo3
         5LehgsWDBh4ysTE2AWZgDd899egLxL9hSKEt+QJ1HppqYjEW7/MmaKsJk8GF7wtFHUNB
         YvlK+NV0WofJs5sZZLI5sEoo5c/YcZyGDa2kY1ltm1jA7ouJoJU2JUXLPehJXMBXVLXC
         2Oam+U8tY5tSWd5AAI9tHgf1HlGD5FlFhMH0gn3eceYgPBRCpxcNGoDeaTmhkfM87OD1
         DL4UUqJdRMZDctiRs+jEvEEBherPpzfHTz5MB+kkd5JcmRF/+F4gDZ+7yXuFQYes34jK
         JpCg==
X-Gm-Message-State: AOJu0YzT6b+NnXl6SZpWFxIRw5PinpNG2sMthywekwDWhmcFsqXRFndV
        nJ/Czv+5tM9mHb/c0TetsaPItCQgEMbjqi98YNg=
X-Google-Smtp-Source: AGHT+IHVkytiLr4VrU84uJsaImqb/UjI8ESSbFxlEdBjsTpKhMrDx0Rzf1JVIZe0qRpmT9Umg8kLom5XzUz98PSnruU=
X-Received: by 2002:aa7:c7d8:0:b0:522:1e24:afb6 with SMTP id
 o24-20020aa7c7d8000000b005221e24afb6mr2932468eds.0.1693442054085; Wed, 30 Aug
 2023 17:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <391c4270-637a-2afb-210d-6b6dfef01efa@intel.com>
 <20230828100313.3051403-1-benchuanggli@gmail.com> <CAG-rBig+koxDf3TuC-0p=tcBY_2WM1sPCvRDtjRmR7AnikrN-A@mail.gmail.com>
 <CACT4zj-BaX4tHji8B8gS5jiKkd-2BcwfzHM4fS-OUn0f8DSxcw@mail.gmail.com>
 <CAG-rBihBkTeZR6yMSF+5zg-h1U1pxGuN-nv=Y7DXLvxV435hDw@mail.gmail.com>
 <CACT4zj_84eCYOq56zdqaydaEGqyqBrXDrsTkDRyCntvVF78-0A@mail.gmail.com> <CAG-rBigLPfJ6u5LQZ4FwMMm_h3b5fQiRYFkwNjFHm4cDCN1VRw@mail.gmail.com>
In-Reply-To: <CAG-rBigLPfJ6u5LQZ4FwMMm_h3b5fQiRYFkwNjFHm4cDCN1VRw@mail.gmail.com>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Thu, 31 Aug 2023 08:33:46 +0800
Message-ID: <CACT4zj_fVyz2oCw6aw7TLmyfZ04WcPeZmwSr79TdWsSP435xoQ@mail.gmail.com>
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

Hi Sven van Ashbrook,

On Thu, Aug 31, 2023 at 4:14=E2=80=AFAM Sven van Ashbrook <svenva@chromium.=
org> wrote:
>
> On Tue, Aug 29, 2023 at 10:27=E2=80=AFPM Ben Chuang <benchuanggli@gmail.c=
om> wrote:
> >
> > >
> > > - if /sys/devices/.../power/control is "on", then:
> > >   <snip>
> > >
> > In this cas, after gl9763e_resume(), it is LPM disabled.
> > Is there no chance for gl9763e to enter L1.x again when the system is i=
dle?
> >
>
> AFAIK the only way to disable runtime_pm is to write:
>   $ echo on > /sys/devices/.../power/control
> where
>   $ echo auto > /sys/devices/.../power/control
>       means: runtime_pm is actively managing the device, device can be "a=
ctive"
>       or "suspended".
>   $ echo on > /sys/devices/.../power/control
>       means: runtime_pm is not managing the device, device is "active" on=
ly.
>
> In the "auto" case, we know what should happen: LPM negotiation is enable=
d when
> idle, disabled when active.
>
> What should be the LPM negotiation state in the "on" case? We have to
> make a choice:
> a) LPM negotiation disabled: normal performance, high power consumption, =
OR
> b) LPM negotiation  enabled: low    performance, low  power consumption
>
> If userspace disables our device's runtime_pm by writing "on", it expects=
 the
> device to be always-on. It should then expect a higher power consumption.
> It should then also expect a performance that is not-worse than the "auto=
" case.
>
> So my suggestion would be to use (a), which is what this patch does.

Understood, I accept your suggestion.

>
> Appreciate your thoughts.

Best regards,
Ben Chuang
