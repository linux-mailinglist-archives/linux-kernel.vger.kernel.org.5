Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7863776ECE1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjHCOlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbjHCOkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:40:52 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F5046A0
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:39:58 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so728214a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 07:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691073596; x=1691678396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4VEn/Qj6DZvyXoC2OX+B5FMkh7YXzHCah+yE83TVaQ=;
        b=nk14RLzMmv8XbKhQsOFIQD8Rt+OHA35WxL8YUniWZm7lMX/GBGb608+9ysan9+g7K9
         A/EE1/Z2A5ad5Nqe/PJydhDPyQo40TFAnN3bfjmlfy3Y4l77O5OFcowOs+oOFKOWce3A
         E1N4MY2RzOLgiftjVpmWl0eTYeCeuc+SB4hX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691073596; x=1691678396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4VEn/Qj6DZvyXoC2OX+B5FMkh7YXzHCah+yE83TVaQ=;
        b=C4VfONtjhLLFN+bIty3zJLFW/+Cvv0B8jDU6f8jfLldhc67Jwtph1r55+W6oAiaWWl
         HkpBG4wvAyxYUtIYjAwgRMm09cPkSqVVKeYuNlv+27J6WQJ8QgKGm6aCeixFY8qexvV3
         qica0nRXdWj0Y8V9ZkUZULke325Un4tuGhaqrO5JQeE4XbbTwEFwz/nVmYnyApsSCsu7
         04Hsf9tRPrLRjlpfO8QLXzDzEV1Q+h8kmERj5vVBCrYYLpS2tOyJlVaRI1kYO5bbaym5
         9xIitackWIk4DemFsiHU38dpLloMDeczI8JyyFdmRdG7BRdFDjyaMImcE8PyVCi3Yvw4
         Ok2A==
X-Gm-Message-State: AOJu0YzJNpNrVEiwbx2qbMFJrgv+A6cqGazZ2az62wWno/n2o0XDfwr/
        gQvqGq/OPBEM6bbpNLDRJeySRZnLspersZ7t2pvdpQB7
X-Google-Smtp-Source: AGHT+IFTXYVeDy7NyrEco7Md5hmvEbecclvcBkIyYEwR1I4dUTkntqSQ3C6d2KzlH7AzL52uYplLwA==
X-Received: by 2002:aa7:c415:0:b0:523:108d:ab18 with SMTP id j21-20020aa7c415000000b00523108dab18mr1049561edq.7.1691073596085;
        Thu, 03 Aug 2023 07:39:56 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id v18-20020aa7d9d2000000b0052239012c65sm10248308eds.82.2023.08.03.07.39.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 07:39:55 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5229e0603edso10819a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 07:39:55 -0700 (PDT)
X-Received: by 2002:a50:9ea5:0:b0:522:28a1:2095 with SMTP id
 a34-20020a509ea5000000b0052228a12095mr66436edf.3.1691073595009; Thu, 03 Aug
 2023 07:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230802124947.1355415-1-arnd@kernel.org> <CAD=FV=Um=OsKA8LaHeOx0n=-1PJAdc6DJsWX9zmQZ+syFEa6vg@mail.gmail.com>
In-Reply-To: <CAD=FV=Um=OsKA8LaHeOx0n=-1PJAdc6DJsWX9zmQZ+syFEa6vg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 3 Aug 2023 07:39:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U7txm2iVYisUWC_gqQ_z3664eFj5mG2ygXiVvn0=pFgw@mail.gmail.com>
Message-ID: <CAD=FV=U7txm2iVYisUWC_gqQ_z3664eFj5mG2ygXiVvn0=pFgw@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: add more DRM dependencies
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 2, 2023 at 7:16=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Wed, Aug 2, 2023 at 5:49=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wr=
ote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > When a symbol is selected that has extra dependencies,
> > anything that selects it must have the same dependencies.
> > With the added CONFIG_DRM reference from I2C_HID_CORE,
> > this broke a couple of drivers that now also depend
> > on DRM:
> >
> > WARNING: unmet direct dependencies detected for I2C_HID_CORE
> >   Depends on [m]: HID_SUPPORT [=3Dy] && I2C_HID [=3Dy] && (DRM [=3Dm] |=
| !DRM [=3Dm])
> >   Selected by [y]:
> >   - I2C_HID_OF [=3Dy] && HID_SUPPORT [=3Dy] && I2C_HID [=3Dy]
> >   - I2C_HID_ACPI [=3Dy] && HID_SUPPORT [=3Dy] && I2C_HID [=3Dy] && ACPI=
 [=3Dy]
> >   - I2C_HID_OF_GOODIX [=3Dy] && HID_SUPPORT [=3Dy] && I2C_HID [=3Dy] &&=
 OF [=3Dy]
> > x86_64-linux-ld: vmlinux.o: in function `i2c_hid_core_remove':
> > (.text+0xfc8826): undefined reference to `drm_panel_remove_follower'
> > x86_64-linux-ld: vmlinux.o: in function `i2c_hid_core_probe':
> > (.text+0xfc8da0): undefined reference to `drm_is_panel_follower'
> >
> > Add the corresponding DRM||!DRM dependencies on each one that
> > is affected.
> >
> > Fixes: 96a37bfd232ae ("HID: i2c-hid: Support being a panel follower")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/hid/i2c-hid/Kconfig | 4 ++++
> >  1 file changed, 4 insertions(+)
>
> This makes sense. Thanks for the fix!
>
> I'm happy to land this in drm-misc-next (where the original patch
> landed), but I'd prefer an Ack from Benjamin first, if possible. If
> this is still outstanding tomorrow I'll land it anyway since it's a
> small fix and he Acked the commit that this is fixing.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

It's tomorrow, so I've landed this in drm-misc-next.

a0769f25a3a6 HID: i2c-hid: add more DRM dependencies


-Doug
