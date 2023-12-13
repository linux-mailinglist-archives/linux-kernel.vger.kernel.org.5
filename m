Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5038118F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjLMQQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbjLMQQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:16:13 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D499411F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:16:18 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6d9d307a732so5397612a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702484178; x=1703088978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcK4XOgKqcNfFHL25gziBNAjwVCjjEmkms+6zHPdluY=;
        b=nhnaC05kq3PKokzDucBZksgkSK21xDk6JCUHI+OewuiE27ffxmC0hrFbRLKEWDX8SK
         Z31fyKLN2G5KBQj1WU9nPfg+Tdj59z1F9h0tEr88feWUnsTctUFMqrA8oghOqtiVmLLX
         KKS/IjCvt4KRyuq9ijlc0e7GpAUHVCbjEBXYSTzNMyCV1gZgvM0lijTkvaTHP8w2gd2c
         skXU+RQjtvFk2qQ/smMn0aOciPOsOk0RGh4v9Ofb9n8Asm3k65H7GowC81V0UmXUjT4G
         VjzY4XEDvz6G3q0K/uhuZ0DOmJAEGv9l29iI09CncCP/uGi918AvJxT+NO7vQSpiSG3e
         t+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702484178; x=1703088978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcK4XOgKqcNfFHL25gziBNAjwVCjjEmkms+6zHPdluY=;
        b=ZbeKNGJ0DHeGKlF2WZ7U++LU97BjsCj4X5Vj7TgME+81p1hnCBZpqyjRX/jsbovFbX
         G3Yo2P++JqL60tOfVzlCy5Uh1V8N1wjecBtEw4wMUgX73yIATlujP9xWa9chySwcQpng
         TUCh39Di2MggOOPQmIz7eY4v/XVSPJf/o8zoZ510TL5EgcQajLTuLrsp57Z3EH3Eh2Tw
         ilNBLqVXBD9ZDFoNhAGbn1KlIanBVq1w74mXsYJJbPKu9YwrpxRhsV1941LpCzNq/h47
         TSkLYjsJZ31NlllkheUE8+0EDitXMVqTIduxQqbuSqeoCgKSOMMxZmzanbPz7mrDvI0U
         7ykg==
X-Gm-Message-State: AOJu0YxshDI0grjrZHz9Ejj4sOy35CapIKjnCHMmF9yI/lIPDhGwwdFd
        asP7M84eGjPYcw8aD0lh54pHnf7JGmmexHqz5nTfSg==
X-Google-Smtp-Source: AGHT+IGy4IlvSeIJvPndB1xZjI8LITnvxvWJSeenOMQb7qhzgb42xfFPZ1RIZk6ZXxVdgU1U36qcpj1NTC5f8qvjFRI=
X-Received: by 2002:a05:6830:1e82:b0:6d9:d4cd:88e with SMTP id
 n2-20020a0568301e8200b006d9d4cd088emr9023832otr.12.1702484178252; Wed, 13 Dec
 2023 08:16:18 -0800 (PST)
MIME-Version: 1.0
References: <20231212054253.50094-1-warthog618@gmail.com> <20231212054253.50094-2-warthog618@gmail.com>
 <ZXm3rayrcvfO1t1Z@smile.fi.intel.com> <ZXm_WsIpgIyOUNHt@rigel>
 <CAMRc=Mfri8K4ZqcHb_eQY6gi+q_-uBZc2wiMrrb-+a7Tric3FA@mail.gmail.com> <ZXnYjoXHGiar-hvJ@rigel>
In-Reply-To: <ZXnYjoXHGiar-hvJ@rigel>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 13 Dec 2023 17:16:07 +0100
Message-ID: <CAMRc=Mc45zQOQycNJ+XH-1V4=FHCXfXusrcHsKUtED1Z_4bYgw@mail.gmail.com>
Subject: Re: [PATCH 1/4] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org
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

On Wed, Dec 13, 2023 at 5:15=E2=80=AFPM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Wed, Dec 13, 2023 at 04:40:12PM +0100, Bartosz Golaszewski wrote:
> > On Wed, Dec 13, 2023 at 3:27=E2=80=AFPM Kent Gibson <warthog618@gmail.c=
om> wrote:
> > >
> >
> > > >
> > > > > +out_unlock:
> > > > > +   spin_unlock(&supinfo.lock);
> > > >
> > > > No use of cleanup.h?
> > > >
> > >
> > > Again, that is new to me, so no not yet.
> > >
> >
> > Yep, please use a guard, they're awesome. :)
> >
>
> Before I go nuts and switch everything over, is it ok to put a return
> within the scoped_guard - it will automatically unlock on the way out?
>

Yes! This is precisely why they're so great.

Bart

> Cheers,
> Kent.
