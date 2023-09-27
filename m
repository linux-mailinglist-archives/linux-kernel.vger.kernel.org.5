Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11147B0631
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 16:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjI0OHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 10:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjI0OHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:07:04 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD0BF3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:07:03 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50433d8385cso17409889e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695823622; x=1696428422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxIurClC31dJCUYmGw9WZVx191Ab8aKe7tsScLLtFLQ=;
        b=el1dcfJH4bZL+04ffjF9IXBrlyKk6WiVCjvvZjIe7g/IUYxILmnN9AhJUpzQovqakj
         0wQ0Lo2awiapze8GFiFPzDxYvuhl4miC1HifdhfP88Fs1lMwsgz7EIfxWRqAPLhPL0jj
         0e0eFTqLgwZfmScBNbDzjl9hnXeKCNyDEKbvdWgsvtfgFhOZgx+3696YK5u1oYGLWWJX
         T/irl0ZhNfTNfpaHitxRi+yYfbfpU4IWQ6D4Bqdw+uojWyJwxTzCzYoyfo0bvNn6zv01
         j7F8ERCT0XJ0BgV/d9U1znbtTEKFWj/ZunCuEAyzgNU+OJvoWP0ZBMzy8bSLYll1Wm82
         sw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695823622; x=1696428422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxIurClC31dJCUYmGw9WZVx191Ab8aKe7tsScLLtFLQ=;
        b=fXRskRHCakz+7VzJsBPdAwGhT8CXZbHgCT7ADuwKqpqPF0W6S0XdFNayiJtI6siNrX
         bVOyKsuLL9OxdHBWLw13knS5NqA5sRqKXTcDrSv8/z6gKxvBFXqYdKGNtxCbpYXlCcMk
         QSLeNiaqvh5bq2WHuppWZGvwRPX8grVVz/1PrwKf8a45UMttY06pv+k62qdZtMlSIgPQ
         OxSVCM8bQCMj81/6CjjsX3xTlpZBZSEJEsMD8R3GcXnLL6YS4GCWoHWMCiZBe4tB/OEO
         0DQllK15TdaGoSqG1E/fZ5B+nrda8EH+71riqEgFqurZU5VfZTdI3gBOCyWYagnNepUP
         RtVw==
X-Gm-Message-State: AOJu0Yyz+ILgLu+b4ODIqwJAL+nhLeVBZpFc6uiGyDb89vbZi0yjjMZe
        BQF3QAX7KsHUn0ZrlfwwerelTfuycB1PAhEmEGC3ju2tvvZiqUKMWxKkgw==
X-Google-Smtp-Source: AGHT+IED+ggK1hsHs8LtpMRs/O+b9QkJMT3WVY71shk1T13cnA6p8SXWujCQ9gCs5OsrcSkNfrgFvf/okbot1nijUQ4=
X-Received: by 2002:a19:ee0c:0:b0:500:ac71:f26a with SMTP id
 g12-20020a19ee0c000000b00500ac71f26amr1825911lfb.57.1695823621877; Wed, 27
 Sep 2023 07:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230921-strncpy-drivers-hwmon-acpi_power_meter-c-v3-1-307552c6ec3f@google.com>
 <9837d8dd-d802-4d5d-bca7-6e029658ba76@roeck-us.net> <CAFhGd8rY5uTh+e0U8jG94dga6Acx5R1G+MKWt=LfD5orNNca+Q@mail.gmail.com>
In-Reply-To: <CAFhGd8rY5uTh+e0U8jG94dga6Acx5R1G+MKWt=LfD5orNNca+Q@mail.gmail.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Wed, 27 Sep 2023 23:06:51 +0900
Message-ID: <CAFhGd8om4HrsSFKXYecpLxWoYc3WiVBO8jfKP-9x4ToiCYEU_g@mail.gmail.com>
Subject: Re: [PATCH v3] hwmon: refactor deprecated strncpy
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 11:05=E2=80=AFPM Justin Stitt <justinstitt@google.c=
om> wrote:
>
> On Wed, Sep 27, 2023 at 9:49=E2=80=AFPM Guenter Roeck <linux@roeck-us.net=
> wrote:
> >
> > On Thu, Sep 21, 2023 at 05:41:46AM +0000, Justin Stitt wrote:
> > > `strncpy` is deprecated for use on NUL-terminated destination strings=
 [1].
> > >
> > > Let's refactor this kcalloc() + strncpy() into a kmemdup_nul() which =
has
> > > more obvious behavior and is less error prone.
> > >
> > > To avoid truncating the last byte supply `...length + 1` to
> > > kmemdup_nul() as `element->string.length` does not account for the
> > > trailing null as made obvious from it's definition (and associated
> > > comment):
> > > |       u32 length;   /* # of bytes in string, excluding trailing nul=
l */
> > >
> > > ... this is precisely what the original kcalloc invocation did as wel=
l.
> > >
> > > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#=
strncpy-on-nul-terminated-strings [1]
> > > Link: https://github.com/KSPP/linux/issues/90
> > > Cc: linux-hardening@vger.kernel.org
> > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> >
> > I have multiple patches with the hwmon: prefix but no driver,
> > like this one, suggesting the change is in the hwmon core,
> > when in reality it is in some hwmon driver.
> > I am not going to apply any of those, and I am not even going to
> > look into them.
>
> Whoops, I was using some tooling to auto-fetch prefixes and the style
> of "xyz: (stuff in paren)" isn't always caught.
>
> I will resend with a fixed subject line matching the appropriate driver.

Erhm, In this case I seem to have caught the mistake over in [v5].
>
> >
> > Guenter
>
> Thanks
> Justin

[v5]: https://lore.kernel.org/all/20230926-strncpy-drivers-hwmon-acpi_power=
_meter-c-v5-1-3fc31a9daf99@google.com/
