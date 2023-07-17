Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D65F756963
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjGQQko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjGQQkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:40:42 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F0CA9;
        Mon, 17 Jul 2023 09:40:41 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-57a8080e4a7so47447217b3.0;
        Mon, 17 Jul 2023 09:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689612041; x=1692204041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMb9H4PkmkiPa0FVYqc3RLn9o2P2FrhAS3xYXAFVgv8=;
        b=iwI61PncG4Y3Zzb2Zm6QxwurzzIJc/IRk72CpUeXExIe5JmlGi28GseD9dT/g1gQlF
         hmiIZi0JD1BWJZvxWxup0d6oFd87nHipIRPqquXqb2dLQ3ewE++qic5bGzt7G6FB8mJE
         8JgOgdrur0OsbCiMNZpnNehsSlCxWtzQP/rEA+XARRsijNVWa/sYRfguLY2Ekqx2WOFU
         VsDSaQwZnTi3fv8/+Ca/caWoq4KEEt4aG6Hii4cKL+LNuhAd4VV5oCgnLVkECB0p3Qfc
         zJikZUQ0QMn2+OITKj8kv5gEv7ypfbiO0rAvDJR7xy0ozhwmDm+ehzPOM4rCrcYm9+wc
         Iimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689612041; x=1692204041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMb9H4PkmkiPa0FVYqc3RLn9o2P2FrhAS3xYXAFVgv8=;
        b=VlPMHic73jwsHrJsv3yB0XyvT0R881HYjdzLk/pQMV6Ywb8eILQ+N5v8r7xd6D+jH5
         8uA/3DMfgz9xmgy+lxZcuxVAjA7wRGGyOLFvkdXSxudlqxC9teHODutuPSA+g1TYJ22P
         teah0ZTRoG1DEGU91UHx4fkxvZlw+Hd+2EaN+Yizr1TQPJWecg8fvYd1F65OUwib7nTK
         7DSnZNW+qEko+8yKKUdCLGpSBP1ABhY83TPGkAWT4zBJ8/UD1jXI/BRcBEQXnMKQmsHv
         jXeFH2bqOHP8wR50PkLkKVgiXJx3hj4ehM6U6j5X8QDqcq3JrolPiqnO4/hz83bNelH1
         YzHg==
X-Gm-Message-State: ABy/qLYCPpWlhv48w6+flzFqqS74wxWygV3oJlPxdAfGJ5Fxdvon3sgk
        +/zcv+uQFuHHcKpwdaJu/ypi6abHq0FJ/RFo4HUE0tWdbAw=
X-Google-Smtp-Source: APBJJlG43/bsUgpNQRfJ8+xO2X2ZbFkaLTVO+ZbD9D9VGw0BO5K7aCt7Lc+Ou1w0D6mDt5je9+KWjaOJpCJo3DSZZ9I=
X-Received: by 2002:a81:c30b:0:b0:56d:2e22:8b31 with SMTP id
 r11-20020a81c30b000000b0056d2e228b31mr11778471ywk.41.1689612041047; Mon, 17
 Jul 2023 09:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230717124013.38796-2-samsagax@gmail.com> <20230717124013.38796-5-samsagax@gmail.com>
 <2023071739-remedy-sloping-64f6@gregkh> <89c6c7e8-0407-b6bb-7085-be11efce2524@roeck-us.net>
In-Reply-To: <89c6c7e8-0407-b6bb-7085-be11efce2524@roeck-us.net>
From:   Joaquin Aramendia <samsagax@gmail.com>
Date:   Mon, 17 Jul 2023 13:40:30 -0300
Message-ID: <CABgtM3i9__CghL1ikLDRRL3n+kSU2K7jCiQouNTjyZZdAbTVew@mail.gmail.com>
Subject: Re: [PATCH 3/3] hwmon: (oxp-sensors) Refactor init() and remove probe()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Guenter and Greg:

> > Again, as in patch 2/3, you forgot a signed-off-by line.

Will resubmit with proper Sign-off

> > You are creating a fake platform device out of no where here, which is
> > tied to nothing, which isn't ok.  Keep it in the proper device tree and
> > have it be passed to you by the driver core in the probe() function.
> >
>
> This is a system with dmi data, so it won't support devicetree. Other
> than that, you are correct, this patch is definitely not a good idea
> and needs to be dropped.
>
> Thanks,
> Guenter
>
> > I think you will see that this changed where in /sys/devices/ your
> > device is now, right?

The attribute is created in the same place as before this patch. And
works the same as before this patch.

I can drop this patch and only resubmit 1 and 2. Thanks for the review
to both of you.

--=20
Joaqu=C3=ADn I. Aramend=C3=ADa
