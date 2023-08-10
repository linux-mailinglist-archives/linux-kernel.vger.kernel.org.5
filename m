Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6957771E7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbjHJHtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbjHJHtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:49:00 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA5510F6;
        Thu, 10 Aug 2023 00:49:00 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a640c23a62f3a-99bcf3c8524so18672466b.0;
        Thu, 10 Aug 2023 00:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691653738; x=1692258538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uzo+gvu4OHpp2LLjR8l6u7nmwovhc1gQKAx/9iythN8=;
        b=LYTHDKudHxs88slCuNqToO5Iu9ABsnhqS0YWGE34ApQmG2Y2lG3IxzSNc2Kp7Bw8zb
         zD7fVbmTl9vN8+nEDsV70UsVltZiKMadSFZPTHPRobnVH14V5rvQJnw0/KP+7vspxb8J
         6OysgbP2QgawJ+s7J5H0jp1Jd286zo2/3fwXXqPyOBQEvGKf5EUgQ78XibpG4WJ83yrJ
         qis/JQhTXvyxDA2oSO31G6T31Un0LOzU/6DixISsh+Th6P0z8ZNej0r40dl3hane+hjj
         jo0YQqaUM5DmHhCKYXhEesPahTKCbbFVwYY24R3yZ9m313qhHF9bwSmEP5eWboU/2rJt
         bpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691653738; x=1692258538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uzo+gvu4OHpp2LLjR8l6u7nmwovhc1gQKAx/9iythN8=;
        b=Tlkaifz01GJtflCIKfyyeNVN3oW1GgQyvKQf1hixxMvqgAMYOvwHM43XcuecMawu4W
         DGzoNU1h2Ywwnsm3RZD61x+sYDjRz+Fm93k3lXkzfEhtSEd+ipPUWs294jnRhfZ2AIdq
         yfxgI2RH/nfZ0xuftd6I2EFmCNWMIuSnmC7/GINTIdrMEjX7ihyJwcptjeiNlRqMwJJc
         K6cL1tApfeVsf7SmFsvcTu7gwiAN3Z4HFwvfH2mT2yujYdYzf1TxGg/LYwBC5fXmgS9B
         6iYFTmcTjRNMsftb1mqiZcFDJB7XSsNqr9zZfAXj+VQ3TF9jMJQPAJfW8mC9XkE96D66
         47cQ==
X-Gm-Message-State: AOJu0YxfZ7FSe8n5sPkKAIXGG3JpSrFcFlq2x19k8BPKB2US37WHjuz/
        m/swUisD74PdJSxk0xNvnBdDSjSzwuFtGj4oe14=
X-Google-Smtp-Source: AGHT+IFYl1yQAsagnGTUuX4z9nUIwePEpZGLbh9WgrweJ1wlcL2P2xUnbRSX/ORdN/tYGvDEDjJo06bnes3uZ7ndWB4=
X-Received: by 2002:a17:906:73ce:b0:99c:22e9:fbe4 with SMTP id
 n14-20020a17090673ce00b0099c22e9fbe4mr1214341ejl.1.1691653738428; Thu, 10 Aug
 2023 00:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230808072501.3393-1-Wenhua.Lin@unisoc.com> <487477f3-9708-4a28-a4fa-0c652353467b@app.fastmail.com>
In-Reply-To: <487477f3-9708-4a28-a4fa-0c652353467b@app.fastmail.com>
From:   wenhua lin <wenhua.lin1994@gmail.com>
Date:   Thu, 10 Aug 2023 15:48:46 +0800
Message-ID: <CAB9BWhf-VAuutVQ3PtyQDozTfPhLBbNPTPtWYTfa6g_sT4ZgTg@mail.gmail.com>
Subject: Re: [PATCH] input: keyboard: Add sprd-keypad driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
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

On Tue, Aug 8, 2023 at 4:02=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Aug 8, 2023, at 09:25, Wenhua Lin wrote:
> > Add matrix keypad driver, support matrix keypad function.
> >
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
>
> Looks fine to me, just one minor thing to remember:
>
> > +static int __maybe_unused sprd_keypad_resume(struct device *dev)
> > +{
> > +     struct sprd_keypad_data *data =3D dev_get_drvdata(dev);
> > +     int ret =3D 0;
> > +
> > +     if (!device_may_wakeup(dev)) {
> > +             ret =3D sprd_keypad_enable(data);
> > +             if (ret)
> > +                     return ret;
> > +             ret =3D sprd_keypad_hw_init(data);
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(sprd_keypad_pm_ops,
> > +                     sprd_keypad_suspend, sprd_keypad_resume);
> > +
>
> SIMPLE_DEV_PM_OPS() is deprecated, please use the new
> DEFINE_SIMPLE_DEV_PM_OPS() for all new drivers, and
> remove the __maybe_unused annotation that is no longer
> needed with that.
>
> With that addressed (for the driver in general, I know nothing
> about the drivers/input specifics)
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
>      Arnd

Hi Arnd:
   We will fix the problem of SIMPLE_DEV_PM_OPS in patch v2.

Thanks
Wenhua.Lin
