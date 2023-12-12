Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074DD80E06C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345569AbjLLAq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjLLAq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:46:27 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23D89F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:46:33 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so578618766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702341992; x=1702946792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGDztTP9Y8jmLygA/ILQ99z4JlzsbnXKKrjvScgU9V8=;
        b=pk+ZLWqUHYIvu8d9k+G0s0CWKocvLC8DYhIushLNhPUSTu8f8+VH7lteILZTs+irpa
         Ak6dNTTDPlcBVf6+pFizlMoGDszp4ZtKdxCNcdZHiqj54f+i3xAE7sN7mDC4GIDvHtT3
         hCvFceWhvSMDpIs07mILYdbGSkVvmtToYfc/idiLuOF1ZOJqQtLKZAPEj0Cr3Yo9le0W
         LAstZg+Ed7LuLP7Bu7kUfdZb2Ci/x21m5mGoXPNBMGrGTplnfZ+xCIx5DWGZmOzN78QY
         ftWrj8fB/LXiODnVuT5LWkeNSDAQKNc42ww0Dnbowp6aFyJNf1Ao8vFhuH+srOzBekLq
         mSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702341992; x=1702946792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGDztTP9Y8jmLygA/ILQ99z4JlzsbnXKKrjvScgU9V8=;
        b=XomiAzOMRdT8gviNkCXsJsdFi7+3EGJn3/4r60A0zA04JSkTpd2C20YvMUIY0y1ACn
         YggdK2BjTFuu+2pzxsxDzhjXstEiK7PXDODYQEpBnr90PH1u+/I415a8OxSwX7te0QhH
         2CWS/xcDzjiMm60kfSBy3xubdBKf7x/uPnbGzC3WQPL+KON5Y7sZP34mrBoqZ3BeQK/D
         57GJo8OFsMib7JrrV/cmIA5W+DkvXt3QDOMR9fD0BKsAWGZgUb6qm0tmfmEXoxnJ1VuM
         lOl0A55PKiWHrrsndzer8GNlSg8X461ut8P1pYxeXACbo9eFsP66PJJPV0GZ2XzTyj70
         hmGg==
X-Gm-Message-State: AOJu0YwXSF7bkar/On6MKkMNRupaJ/ttg1UtQC2xSybAu4nKebQw4myt
        7y53ujtL9byItRCLNuSNVIhUiL/F4Hv8/X1uqJKmEA==
X-Google-Smtp-Source: AGHT+IF3Vb9uYK4veE0AEj+63MVpg5F+Fk633PnRVz/Mrgr8rxF8f0TZLUH4FJYcKHO1B7bz6tONcIHqoCsdrSHNL48=
X-Received: by 2002:a17:907:72cb:b0:a19:a19a:ead2 with SMTP id
 du11-20020a17090772cb00b00a19a19aead2mr3218422ejc.139.1702341992095; Mon, 11
 Dec 2023 16:46:32 -0800 (PST)
MIME-Version: 1.0
References: <20231026-strncpy-drivers-iio-proximity-sx9324-c-v2-1-cee6e5db700c@google.com>
 <20231028162638.5b477ded@jic23-huawei> <CAE-0n51eAH1tcqXVeReavq0US-Th2qwC_s_uAzRKTpSG-kXuwA@mail.gmail.com>
In-Reply-To: <CAE-0n51eAH1tcqXVeReavq0US-Th2qwC_s_uAzRKTpSG-kXuwA@mail.gmail.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Mon, 11 Dec 2023 16:46:20 -0800
Message-ID: <CAFhGd8p76R-oaPWR0G6wESe7kgM--2bzU88j2vz4QGy8wKNffg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: sx9324: avoid copying property strings
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 30, 2023 at 2:44=E2=80=AFPM Stephen Boyd <swboyd@chromium.org> =
wrote:
>
>
> We need to free it in other places too, like if the count doesn't match.
> It may be easier to extract this section and just have 4 string
> literals.
>
>         switch (reg_def->reg) {
>         case SX9324_REG_AFE_PH0:
>                 reg_def =3D sx9324_parse_phase_prop(dev, reg_def, "semtec=
h,ph0-pin");
>                 break;
>         case SX9324_REG_AFE_PH1:
>                 reg_def =3D sx9324_parse_phase_prop(dev, reg_def, "semtec=
h,ph1-pin");
>                 break;
>         case SX9324_REG_AFE_PH2:
>                 reg_def =3D sx9324_parse_phase_prop(dev, reg_def, "semtec=
h,ph2-pin");
>                 break;
>         case SX9324_REG_AFE_PH3:
>                 reg_def =3D sx9324_parse_phase_prop(dev, reg_def, "semtec=
h,ph3-pin");
>                 break;
>

I've submitted v3 of this patch [1] trying out Stephen's idea. I'd
appreciate feedback.

[1]: https://lore.kernel.org/all/20231212-strncpy-drivers-iio-proximity-sx9=
324-c-v3-1-b8ae12fc8a5d@google.com/

Thanks
Justin
