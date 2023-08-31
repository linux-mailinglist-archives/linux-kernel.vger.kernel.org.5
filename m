Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDA278E48A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345631AbjHaBrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236116AbjHaBro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:47:44 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A146CC5;
        Wed, 30 Aug 2023 18:47:42 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-79a2216a22fso180180241.0;
        Wed, 30 Aug 2023 18:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693446461; x=1694051261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCKBENiq4GEwRaH031J4XimFDimD7/kiZ0SVXcm53oY=;
        b=RjOgwhMXsutkCae+YcieM10bH0wR3klFm5czKsgMDVhVo7Vi2MAaWV00CR1pVsMVVj
         RiOKyoU6xLsGZaDpVOY0VCv2USFTJwU6OIX/Ab8JE8l5unmKZtrA1PC7j6V4mwL+y++h
         VD4tI0VTbLSqVxLM/DbXMQQS5IuNFs3USepyjco9H7Z7UQWbw12FqPoNo5eHykWWNcF6
         h+DLsIq0VI8MvIu+pPebhj/NV8UdqmFFbcTpYU7txF4bVeTVNqzyLeEB3lCqA/ck+pVD
         rEnQe+kAVk0zfrvU+7K7ksPjQQwA6gNiVvgTCEK2sJbd4DUEVXxAo4zSXnbumurC+cwL
         ERgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693446461; x=1694051261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCKBENiq4GEwRaH031J4XimFDimD7/kiZ0SVXcm53oY=;
        b=Sw5oZNI801143MRuXnN2IXcgopxHPYbnuDKkg/ozSZ6hib9GyqSTVdEgCzVGSt77UC
         m/8sFRd53Z0dsSM1bAsWlgdICO6YRCKyju+5Pjp6FyKl8sUqY50dfCt2OFacVP8ipale
         07rIh3uRme2vmY4LBss3vd4m4Gaiixux0YDe4hWX+9h/lI9g2Kddyt+Gz7LZNMkJnYdG
         CbTrPPKAl04cdwn/sH00PaiUZGhnFFLnNisb8hPOASS2ySO/lPgrOvNekC7GzOZ8g8VT
         CmDJxfIyZ1HSsQZWAv2vP1lSlWt017qT1ouKzZ4X/9wsYKC2LW1dp9vcr9F3LC2ae3Cw
         fcCQ==
X-Gm-Message-State: AOJu0YyxmhvHbnUMHLIM6UXHxahdYGpNsLCpN7HkKymotaLE56ipMw/k
        WDz+fGMgY+CjOP2BrXLTeIy/DSExgAYm5kQ7ZJvEdj+Wzx3LiA==
X-Google-Smtp-Source: AGHT+IEgXvCdGkwoSUW87TOoIjX391zkXhYoxSkzUI6iH78aXeQAHYdqdYdmh5DFCvd5a1z6Ri1JRAnPFkIpFJSV9fY=
X-Received: by 2002:a67:fb19:0:b0:44e:a9b6:5298 with SMTP id
 d25-20020a67fb19000000b0044ea9b65298mr3904828vsr.24.1693446461534; Wed, 30
 Aug 2023 18:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230821061315.3416836-1-zhoubinbin@loongson.cn>
 <e62185ca-cdf6-bde9-ad46-f4150db9ed6d@linaro.org> <CAMpQs4JhfuB4=s9VFc+xmw_+8h5u2EwPdM_0x2vO_=SYabAAxw@mail.gmail.com>
 <6ba31912-6738-6156-d5f4-3c8d3a3ca7bc@linaro.org> <CAMpQs4+GiExt9uMmV1pf8gg8rFwWxbLkx9mdW7hY9xxXDOza3Q@mail.gmail.com>
 <d11873a1-b552-71f5-1100-7464687f8bb4@linaro.org> <a084e6e9-46b0-42ef-b500-69c114ae11b2@flygoat.com>
 <3412e871-ae2b-bed0-88fb-2272f9db3af0@linaro.org> <a3e934eb-7517-f313-46d9-fd5335ce305e@flygoat.com>
In-Reply-To: <a3e934eb-7517-f313-46d9-fd5335ce305e@flygoat.com>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Thu, 31 Aug 2023 09:47:29 +0800
Message-ID: <CAMpQs4L0DYxoqQbpi7WeNMBf9g+58L2=D6BXrKbSUqJQEEKZLQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: loongson,liointc:
 Fix warnings about liointc-2.0
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, diasyzhang@tencent.com,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cc Jianmin Lv.

Hi all:

Jianmin knows Loongson interrupt controllers well, he may have other
suggestions.

Thanks.
Binbin

On Wed, Aug 30, 2023 at 11:31=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.c=
om> wrote:
>
>
>
> =E5=9C=A8 2023/8/30 22:35, Krzysztof Kozlowski =E5=86=99=E9=81=93:
> >> What's the best way, in your opinion, to overhaul this property? As we=
 don't
> >> really care backward compatibility of DTBs on those systems we can jus=
t
> >> redesign it.
> > Deprecate the property in the bindings, allow driver to work with or
> > without it and finally drop it entirely from DTS.
>
> I'd love to have such configuration flexibility so I'd be sad to see it g=
o.
> + Huacai and Binbin, what's your opinion?
>
> If dropping such functionality in kernel is a must go, we can hardcode
> to route all downstream interrupt to the first pin that passed to DT.
>
> Thanks
> - Jiaxun
> > Best regards,
> > Krzysztof
> >
>
