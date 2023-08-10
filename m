Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9557771BE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbjHJHm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbjHJHmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:42:07 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DDC211C;
        Thu, 10 Aug 2023 00:42:06 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a640c23a62f3a-98273ae42d0so21020766b.0;
        Thu, 10 Aug 2023 00:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691653325; x=1692258125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Md3LDi6Tw5YUiSHKL8K9CojxtZIkpbSZE+wWDSjDtU=;
        b=eXZmirF6heWYSgC68dCabH7cY/74cw4Pnc3EEx5J6/Ar7zdNSILzTh+7RSkto67p96
         KzWmEQtVm0JQuDutoz2P8VPIZAfPYUyPW0CExNHfqUvN/eAH18ZmK9PhQ7i1b25/Hl6C
         AwSoH//gN1ikAFzalPBpD9/s3sCDMCUbinKR/rxGMUWnszuQmL2iieFmyM/qnmpl/g4g
         nn8GlE5E4jEeXIeyvm0R25R6cEcGbesVZz1WSmTt+xeuTlshvhjT6jpbq++1cifQZiJf
         5MKBjtvvKGcpF/TERd4R2yfVeMbLU3mPXd2Z9bjEVhjojV7lipXqx3c7UQtVwf61BT1h
         xq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691653325; x=1692258125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Md3LDi6Tw5YUiSHKL8K9CojxtZIkpbSZE+wWDSjDtU=;
        b=VlLfPp2eQ4PtSAot4DDOi8qUY1DA4LmXSE6jxqg6yl9q+u0NKuxGUanPH7QZCf1L7R
         +VKNOTlpvDaEj18YCDX3Gfg2bbx6+rxvy51UdW9Vs+PeGp3XChbFRmjdOzDAsHP74vP/
         VJsr4fxcdu4dxn4Mk1uQLNH8KdnxxcCa+AeRQIMJMU2+ePnCsUlUQO5S80+60I8FauXu
         5s4KJ2Ue0zrK2BusEMAwWtB9FD4GHD+2Ljur4GJaNihKrU4Nb6I6xRMuJmFjDhJPAXRH
         IMzf4bctiwZSpcFkyW7E6xW18+pXIZM2K54dgJJL/gZsRBB9JmloltjYw3VuSmP9TAQX
         BQzQ==
X-Gm-Message-State: AOJu0Yz6uCQAKEwWUD8tvdQ+0KDidFtMrG6GpD2M8HrYxP1Y/Qqj3zHa
        Yt8Dfstw6WalJdDpELVAmvrfGZ1tqKCX3XLpWxU=
X-Google-Smtp-Source: AGHT+IHegUQ4czVbeszlhFTnvcTn/HUzNata8U9yzItdII52auC2uvKmWAP5rQP0MDr0Z/4p6Excgx2t+/q8Mzrn3Hs=
X-Received: by 2002:a17:906:dc:b0:993:eed1:8f7 with SMTP id
 28-20020a17090600dc00b00993eed108f7mr1297820eji.3.1691653325144; Thu, 10 Aug
 2023 00:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230808072252.3229-1-Wenhua.Lin@unisoc.com> <ZNJC8OVzJEQyQugF@smile.fi.intel.com>
In-Reply-To: <ZNJC8OVzJEQyQugF@smile.fi.intel.com>
From:   wenhua lin <wenhua.lin1994@gmail.com>
Date:   Thu, 10 Aug 2023 15:41:53 +0800
Message-ID: <CAB9BWhdVGTfXF__mzOycHVpB-TB9Fz26kZTWn5ZdwTG8hxd+dQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] devicetree: bindings: Add keypad driver ducumentation
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Samuel Holland <samuel@sholland.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 9:28=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Aug 08, 2023 at 03:22:52PM +0800, Wenhua Lin wrote:
> > Add keypad driver ducumentation.
>
> Why am I Cc'ed to this? I'm not a DT person to review this...
>

This is one of our mistakes, thank you very much for your review, we
will correct it in patch v2.

> ...
>
> > +             reg =3D   <0x40250000 0x1000>;
>
> TAB and space mix

Hi Andy:
We will correct it in patch v2.

Thanks
Wenhua.Lin
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
