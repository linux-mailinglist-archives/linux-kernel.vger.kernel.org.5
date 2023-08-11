Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338397791C6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbjHKO0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbjHKO0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:26:00 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFF21994
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 07:25:59 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-487546cdf68so827567e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 07:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691763959; x=1692368759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8Z6jYUUE4XSqtFocIF3XavaecNmFuBcBwCtSkrLy4Y=;
        b=N3rdtuMNz7bD3/zJfqF6WGQ6DoJQi560eG5AIFeqdw7VdkcP7FFuW2JqyffSoXwZpc
         2K8/eOCYmLXXgamZR98wHvSr2BV8BtBykU21lHaT8sAlOvzBd8rxdxs8cQ9v64P+OGvS
         TNRdXqNiUNe0i07hY20CYSdu8gIKqkbgwaax9jzVw6Ssq0u0sgQQ7TuSPx07OK0NiDBR
         nLKwdOlY3HBHfXxCMUFmQ9Wb5ehiyqfplZkbfP/j7Z/MiQmXbcijrNhyi+/Ozst9wOFh
         oYmgu/hRk9J3dz4DDFfXgCVxrD75cmazN30/MPi08gHDyoGZkT2kqw8ietfMIIDfE7x5
         sunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691763959; x=1692368759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8Z6jYUUE4XSqtFocIF3XavaecNmFuBcBwCtSkrLy4Y=;
        b=DnskVSz7Ctyvv7zSsjQZPXF/spVd6K4pJu6SsG9zgKHKiaoVBK3a4OYPRX08AUrnsz
         8poBYbDfAbp+iig+0HC4A9ANc1fdc8sgF8DEWnMvNSMz9/XomzqQ7jExfRyEaEKw6sX9
         /hBE6uTawi0iThvIJFyHheNOB0OYb9OR7+HnEcWOjVDfrHtDEWNXmuJODBzDg1UepUrG
         hB9jC30KlOKcfBjLyYNz6jTTb9adovxZNLmaO5LClL+6qEM3bhYdbTwydqQCBtzTCl0m
         JUJyl94HpTc1z4UREYdgGTAoy3Xe6G2ynA2I6WNJP0Treyo4HQYU9mxmhPRljgAmu/W8
         yIFQ==
X-Gm-Message-State: AOJu0YwhnWshsStsiSdpqts92KOQ1kxP+yHu0/AkzkTu3l0II8/Aqamf
        hCvDiLD3rf0BVK1JF1FM9mL0vskfRJ9U1jL2netDRQ==
X-Google-Smtp-Source: AGHT+IGkTIlQGSaflTKp9yzn3Fx3nTqJGVchCm0k0+ohA33iQIeq7KFPW/dUVjUKYBm0OArLwRPPoSX3szmmzy3LVKQ=
X-Received: by 2002:a05:6102:34c2:b0:447:46e7:1343 with SMTP id
 a2-20020a05610234c200b0044746e71343mr1803546vst.23.1691763958783; Fri, 11 Aug
 2023 07:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230807074043.31288-1-zhuyinbo@loongson.cn> <20230807074043.31288-2-zhuyinbo@loongson.cn>
 <20230808-amount-urban-9a6eb09852ca@spud> <536a9062-65b2-5518-5c50-1a61e23870ee@loongson.cn>
 <20230809-circus-photo-6911d2e18f96@spud> <d4e16768-bed0-beda-42c3-f0a01b7e96cc@loongson.cn>
In-Reply-To: <d4e16768-bed0-beda-42c3-f0a01b7e96cc@loongson.cn>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 11 Aug 2023 16:25:47 +0200
Message-ID: <CAMRc=Mc00yy6DxdEos_w7HAkAwH7j0HBvkbQbaQiA_wTXiwFUg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] gpio: dt-bindings: add parsing of loongson gpio offset
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Conor Dooley <conor@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 8:19=E2=80=AFAM Yinbo Zhu <zhuyinbo@loongson.cn> wr=
ote:
>
>
>
> =E5=9C=A8 2023/8/9 =E4=B8=8B=E5=8D=8811:39, Conor Dooley =E5=86=99=E9=81=
=93:
> > On Wed, Aug 09, 2023 at 03:47:55PM +0800, Yinbo Zhu wrote:
> >> =E5=9C=A8 2023/8/8 =E4=B8=8B=E5=8D=888:05, Conor Dooley =E5=86=99=E9=
=81=93:
> >>> On Mon, Aug 07, 2023 at 03:40:42PM +0800, Yinbo Zhu wrote:
> >
> >>>> +  loongson,gpio-ctrl-mode:
> >>>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>>> +    description:
> >>>> +      This option indicate this GPIO control mode, where '0' repres=
ents
> >>>> +      bit control mode and '1' represents byte control mode.
> >>>
> >>> How is one supposed to know which of these modes to use?
> >>
> >>
> >> Byte mode is to access by byte, such as gpio3, the base address of the
> >> gpio controller is offset by 3 bytes as the access address of gpio3.
> >>
> >> The bit mode is the normal mode that like other platform gpio and it i=
s
> >> to access by bit.
> >>
> >> If both modes are supported, it is recommended to prioritize using byt=
e
> >> mode that according to spec.
> >
> > So, sounds like this property should instead be a boolean that notes
> > whether the hardware supports the mode or not, rather than the current
> > enum used to determine software policy.
>
>
> okay, I got it, I will use boolean,
>

Why do you want to put it into device-tree so badly? This is not the
first driver that would have of_match_data for different variants
where you can have a structure that would keep offsets for different
models. It's not like you will have hundreds of "compatible" chips
anyway, most likely just a few?

Bart
