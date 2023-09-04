Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CE7791E36
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 22:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbjIDU05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 16:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjIDU0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 16:26:53 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6CD180
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 13:26:50 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-59231a1ca9eso17195257b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 13:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693859209; x=1694464009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOPCv2NI+axDv4gb4abMd4AMNhAMpkyYYjA0xE2SSU0=;
        b=DQtAgI9LUBkGSB34l/x/5tq0yeU19UmqOjF8QJ0Mc/XD3KBqRTBy/EHl44jjHfrIWm
         ynOLQWBLj8B9LB3qVXdSDw6EYECAc/0KD/HjyUqP+qcrOJMZpSjqgov9U0jMyxlGe1uW
         2MtMeCCX5K1DlMo9Vicx1eeqJ5moWdIooo1rjrmUi8zr1WNG+pzUPYtjJk/4U2hzz5E+
         f3usUBIUGUvE9fBu4lGu60dDE+sIkCmsW7+AM9l0qmnWCC/KayqwxdTmW5O5tMuJ9cZ6
         JOmZ8jz95U32Vmrj/P550LybSuEj+O29wTi1XQexKjsm+j8pGq20ksBIThCG9YLndkd8
         QSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693859209; x=1694464009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOPCv2NI+axDv4gb4abMd4AMNhAMpkyYYjA0xE2SSU0=;
        b=LW9RwbMZxptKAI/iBBwvGMtencX1JXGUdd+ANdjR/ezgR2pXohF3iY8bPAy03OCdoS
         3uE6WPPraand4lJvCIOPM0HJOTRyw08CDCd2GuASFHMfRoZkl828dKEEos4mK6hFBISL
         ZLdthUIn10bMpDCxAnrs8TLYq6ajuIad2LYZ+5F0UgVaPcO4gN0/NF9Ji5iLpXkIz2a5
         5bUmg3jlqMMRATHgRw/QUxLxqjAQBF2shFJWJUD/+v9l8t1WcJphcGsrEKaAWCrQO0Tu
         8+M9sa9DV1InEjotrAfZfAkqSekF+HNVDnpkZYH3AFsZVzy/PhPlb8u13TegBhq0v4Fw
         +4iQ==
X-Gm-Message-State: AOJu0YxMrl2eGcIXmsPfZf7mGGqwUBK+FH6RDAptmXvzNBLo92/KBvGA
        wDcsYwAY0S/HlITnKiS5AJq5KW/aSJCVF9UvxSrSxw==
X-Google-Smtp-Source: AGHT+IGYxkclG89PUKOkDm67cPaVgl3DF1XdYgrU2viuEanv3N60lpWFmpZI/6uf+KY5yjj97vqPkmRPUzx+tp+//GE=
X-Received: by 2002:a25:40d:0:b0:d78:4638:d52c with SMTP id
 13-20020a25040d000000b00d784638d52cmr10982720ybe.34.1693859209653; Mon, 04
 Sep 2023 13:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230904114621.4457-1-wangweidong.a@awinic.com>
 <20230904114621.4457-4-wangweidong.a@awinic.com> <5ea76d3f-c9dd-10f5-4f9a-7b32b535ab5c@linaro.org>
 <598febde-429e-4319-98d4-4306a7f8bfe8@sirena.org.uk> <0360d279-b535-f3f2-9651-07dff2df2e37@linaro.org>
In-Reply-To: <0360d279-b535-f3f2-9651-07dff2df2e37@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Sep 2023 22:26:38 +0200
Message-ID: <CACRpkdbWE3enEjweZZQSQpdUDvCPXxQZfzOReS9YvZ2mxmevAg@mail.gmail.com>
Subject: Re: [PATCH V1 3/3] ASoC: codecs: Add aw87390 amplifier driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, wangweidong.a@awinic.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, rf@opensource.cirrus.com,
        herve.codina@bootlin.com, shumingf@realtek.com,
        rdunlap@infradead.org, 13916275206@139.com, ryans.lee@analog.com,
        ckeepax@opensource.cirrus.com, yijiangtao@awinic.com,
        liweilei@awinic.com, colin.i.king@gmail.com, trix@redhat.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhangjianming@awinic.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 4, 2023 at 3:02=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 04/09/2023 14:30, Mark Brown wrote:
> > On Mon, Sep 04, 2023 at 02:17:43PM +0200, Krzysztof Kozlowski wrote:
> >> On 04/09/2023 13:46, wangweidong.a@awinic.com wrote:
> >
> >>> +   ret =3D regmap_read(regmap, AW87390_ID_REG, &chip_id);
> >>> +   if (ret) {
> >>> +           dev_err(&i2c->dev, "%s read chipid error. ret =3D %d\n", =
__func__, ret);
> >>> +           return ret;
> >>> +   }
> >
> >>> +   if (chip_id !=3D AW87390_CHIP_ID) {
> >>> +           dev_err(&i2c->dev, "unsupported device\n");
> >
> >> Why? The compatible tells it cannot be anything else.
> >
> > This is very common good practice, as well as validating communication
>
> No, it is neither common nor good. The kernel's job is not to verify the
> supplied DTS. Rob also made here a point:
>
> https://lore.kernel.org/all/CAL_Jsq+wcrOjh7+0c=3Dmrg+Qz6dbhOUE-VEeQ4FoWC3=
Y7ENoyfQ@mail.gmail.com/

I disagree, if a vendor one day decides to mount a new version of a
component without notifying the community or users this is really
helpful.

The function is named "probe()" for a reason, as in "inspect
the hardware and see what we find" this has always been the case
I think.

Yours,
Linus Walleij
