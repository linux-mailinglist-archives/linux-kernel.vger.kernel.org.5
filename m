Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D0F76BD8C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjHATUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjHATUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:20:52 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46001BF1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 12:20:51 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-44782e9d485so950897137.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 12:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1690917651; x=1691522451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mx7BwwXurF50YVscvCcFIAyHMNie8lV8iSngFfBztW8=;
        b=Q/ryACJY8mOBs7FzuG7mPffOSg1elIHIgquyvCGZzO7AKvm3K/7i6jn+5F7iZVW10U
         ZipZbcsmOtolOwBiEDf31l39vuN8cRsMbkS5AOSG1M7W4iCTF4hlyMayzFrCcoH1oyMp
         ezBTHNgUVvNhz+YdHM85U2Vn2Z+HP9xQcYNSoRCqXPohoxS69dzmcbOsPjHVJvuavOEE
         0r4D1zNojwjyXxrAy6AwHV/XgtWocKveLUvl0aDR+SwWfGrsTiGu4dXWiTXZuhWlBTXl
         KKJId/fv8ubSb4eoY8ZR69LaDUUXHrfrgrnhoRc4IFsGwbXRl9Hi4JUzXs5ZfHY8pe/p
         WfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690917651; x=1691522451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mx7BwwXurF50YVscvCcFIAyHMNie8lV8iSngFfBztW8=;
        b=LQeW4Rdvv437BfUMKhjfjfxN55Q23zsnJAaMa54SKrrZfhJnzRBhVY5ZNsistr9isH
         X8dQiTsNShiyCmPPLburV05e6/jMm9NvnGzCqROumbN19tl+Nd4LsAHhzgX9aqvrEUyL
         Wft4Aod+siOR6RkY5WnEX5yzHXDRTtaQ7OmCBC9bWyqHtwyi8CRN25ZAZtccshdeN1+O
         zHR4iYE4sdmfw0JN3hAnORXPPzAKk2E4DJOkbcsMWi0eCRomkvksMaKG1jYCc9dlCHVr
         ATtyvZCk0KFP0xU8eX73g+MuyTSdU+GBPEzBgEf+0axo1CACH/Lpn+tLoye8NY8D4rxf
         P3mg==
X-Gm-Message-State: ABy/qLYfHl/TULQv4PvQSBIfydnUUSIHEczpdOkqs3BHYJdxBgWpSSvF
        NW8cbcyHZROQ5c3KSRTKwTSyXG0w9/OTvYmA6xo61A==
X-Google-Smtp-Source: APBJJlFLP7KpI5D4cz6fjxg/9AdfjY+LGxKi41ExFBTmXN3hLhxkaI113sTTfgpZpUsnLsOw7mioSyVPWp+c0G4kVEU=
X-Received: by 2002:a67:f04b:0:b0:443:6917:215b with SMTP id
 q11-20020a67f04b000000b004436917215bmr2958771vsm.26.1690917650887; Tue, 01
 Aug 2023 12:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230725123045.6367-1-aboutphysycs@gmail.com> <ZL/KZ2Q5G7JHZMhw@smile.fi.intel.com>
In-Reply-To: <ZL/KZ2Q5G7JHZMhw@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 1 Aug 2023 21:20:40 +0200
Message-ID: <CAMRc=Mft3dTT+4H=4f4szSCc_NhJkDoG1xs8DkR=urgdhhHeqA@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: mlxbf2: remove unneeded platform_set_drvdata() call
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Andrei Coardos <aboutphysycs@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, Alexandru Ardelean <alex@shruggie.ro>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 3:13=E2=80=AFPM Andy Shevchenko <andy@kernel.org> w=
rote:
>
> On Tue, Jul 25, 2023 at 03:30:45PM +0300, Andrei Coardos wrote:
> > This function call was found to be unnecessary as there is no equivalen=
t
> > platform_get_drvdata() call to access the private data of the driver.
>
> This is simply not true.
>
> NAK.
>

Just so you know if that's not obvious from reading the code:
platform_get_drvdata() is just a wrapper around dev_get_drvdata()
which is called plenty in PM callbacks of this driver.

Bart

> > Also, the private data is defined in this driver, so there is no risk o=
f
> > it being accessed outside of this driver file.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
