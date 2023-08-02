Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A27D76CFD8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjHBORL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjHBORJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:17:09 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A462685
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 07:17:08 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so223038966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 07:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690985825; x=1691590625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CG/1niNkvQnFKY0Nb52FXwSkYtV5RgqG0BYmB+t2rnc=;
        b=mwgmhFv289OQ8WPTHEsEtjsDZpaB8HO+yAVItLo0jLvWaCgO+nrT/W2P2lSh1GZ/mf
         7khAcZZVsekUWSqBpTZPnSRhydGPVrC4ttw6+LdIP0KJL2TnrdhjQ3fUBOl1XQo858QI
         YnA+s/xHdzIErq9PNk0D2vDCiG43ss4PsHAAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690985825; x=1691590625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CG/1niNkvQnFKY0Nb52FXwSkYtV5RgqG0BYmB+t2rnc=;
        b=ADP4QcCQRUZI1kUOfyviBsuopdZ9VqCW/TrIUGToq78Na9/qRRvnoNoUaQdda8Eb8Y
         ZVfzeu5SHdMubHKKVGdGyLJ90NdDeSDu7vrdgPBdf3SJkQyUZgSQNNSO4UgLIokQ1gAj
         maLW14bbL2B0l8Wfmq3qfZBQZehFbACiNTP15UHmBXx//rzU1iRHsK97jxaHml/0buqg
         BWaHhueN5kiAF3n6whBg3ZXoNvX+KUKFenoFhxkCi6nLc2V6yydSPPsQFrK5/9G1jsop
         i547UWI0i3ch41Mljdj/lUwZvBrvgAQt9YfVOBmh3NjSsqFK9sMYRFh1MF/BDMtjlM2S
         j7FQ==
X-Gm-Message-State: ABy/qLaxD8ot6n/Ezhva39+rXB3bCp3v7oB88olXIACtx78qywS+cVti
        +A+RJT7Y4x4eOJuLyVa61znkVprNNN/siTW2J8zwNI4v
X-Google-Smtp-Source: APBJJlFfZ5vklp59GFigrT4N1q/SCsFt6BS+J/uBEa1QwLUZUIi7wEKijY3xHdeEG5H+lkLNVU28tg==
X-Received: by 2002:a17:907:78c8:b0:992:ef60:aadd with SMTP id kv8-20020a17090778c800b00992ef60aaddmr7263283ejc.13.1690985825107;
        Wed, 02 Aug 2023 07:17:05 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id f5-20020a1709064dc500b0098f33157e7dsm9200822ejw.82.2023.08.02.07.17.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 07:17:04 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3fe32ec7201so54455e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 07:17:04 -0700 (PDT)
X-Received: by 2002:a05:600c:880f:b0:3f6:f4b:d4a6 with SMTP id
 gy15-20020a05600c880f00b003f60f4bd4a6mr359654wmb.7.1690985823938; Wed, 02 Aug
 2023 07:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230802124947.1355415-1-arnd@kernel.org>
In-Reply-To: <20230802124947.1355415-1-arnd@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 2 Aug 2023 07:16:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Um=OsKA8LaHeOx0n=-1PJAdc6DJsWX9zmQZ+syFEa6vg@mail.gmail.com>
Message-ID: <CAD=FV=Um=OsKA8LaHeOx0n=-1PJAdc6DJsWX9zmQZ+syFEa6vg@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 2, 2023 at 5:49=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> When a symbol is selected that has extra dependencies,
> anything that selects it must have the same dependencies.
> With the added CONFIG_DRM reference from I2C_HID_CORE,
> this broke a couple of drivers that now also depend
> on DRM:
>
> WARNING: unmet direct dependencies detected for I2C_HID_CORE
>   Depends on [m]: HID_SUPPORT [=3Dy] && I2C_HID [=3Dy] && (DRM [=3Dm] || =
!DRM [=3Dm])
>   Selected by [y]:
>   - I2C_HID_OF [=3Dy] && HID_SUPPORT [=3Dy] && I2C_HID [=3Dy]
>   - I2C_HID_ACPI [=3Dy] && HID_SUPPORT [=3Dy] && I2C_HID [=3Dy] && ACPI [=
=3Dy]
>   - I2C_HID_OF_GOODIX [=3Dy] && HID_SUPPORT [=3Dy] && I2C_HID [=3Dy] && O=
F [=3Dy]
> x86_64-linux-ld: vmlinux.o: in function `i2c_hid_core_remove':
> (.text+0xfc8826): undefined reference to `drm_panel_remove_follower'
> x86_64-linux-ld: vmlinux.o: in function `i2c_hid_core_probe':
> (.text+0xfc8da0): undefined reference to `drm_is_panel_follower'
>
> Add the corresponding DRM||!DRM dependencies on each one that
> is affected.
>
> Fixes: 96a37bfd232ae ("HID: i2c-hid: Support being a panel follower")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/hid/i2c-hid/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)

This makes sense. Thanks for the fix!

I'm happy to land this in drm-misc-next (where the original patch
landed), but I'd prefer an Ack from Benjamin first, if possible. If
this is still outstanding tomorrow I'll land it anyway since it's a
small fix and he Acked the commit that this is fixing.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

-Doug
