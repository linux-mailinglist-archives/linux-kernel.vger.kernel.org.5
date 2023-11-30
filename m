Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BF37FEFAD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345395AbjK3NCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjK3NCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:02:36 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F3A10C9;
        Thu, 30 Nov 2023 05:02:42 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-db498e1132bso781843276.2;
        Thu, 30 Nov 2023 05:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701349362; x=1701954162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+XQrviBlIMoJrwg4MwMEzdsSIALeidvNSbX1jKDmG8=;
        b=MjUaSoX989H8lActhZ9VtW/HseRPca2vYMfIPACvXZWNhWy39waB2cOwN876XBXb8O
         0BIzk6FkGrbsFl63DRrIKItScP+IQUj/X0EZ6XEWHBXNpUC+k9SFurSlP35/67DZMKDA
         d+1DJLACC+XNWAcH61TYerZEk5hgLC3Ad9rMs/rt2hYG8tkzEuKcdJKw2Fi5bBfbL5CG
         ZjOsxTZzOtZ9aRAMRi2ex8fgwjXVQGv4sFhAHnr5CEuBV0qlR0R4/cB+aZsL2+xXnDpO
         OS4gNjTnF0DOvXMlAiHyZOANL1g7U5ag4h7aqTE7jP14QT/Gwnf9rqPmizupn8b0YpEs
         HzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701349362; x=1701954162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+XQrviBlIMoJrwg4MwMEzdsSIALeidvNSbX1jKDmG8=;
        b=JqSAdsaZNG2hXI6zGIT58wfjHKIK2+JLnyWl2xgVYrzm31NSdz6x1PPOli/FBIS8wD
         qTY8H25Ds1ER3U9IEXeyB9djtKqbrJVbZ7gJqIPmP2dfiWnmmjHXLA+U23Gz9GL0UFPl
         Qd13J9fvqh+zAollmuDK8aPJCZdnS4cTV0/HO/sNNgk/BHRmbH9wEAYCiuQSftuZu28P
         tUG/yywCOgmEE0u/32OGULaj0sYWBoamGTqVzCipMQbDLEXgZKB1skKQhVSJqzqcQYXS
         p+hHCQoR+3WtMSNRIsYTBuJtPnElAsE4HHV9g8XcpLQYZ/XLOdnH/VwJ3xzymi2EfYHK
         U5Ag==
X-Gm-Message-State: AOJu0Yx9kIzkmKLNs1oHwkUkJ5G9C+oOvJM3f+e5mm59rsCgORlGATCY
        MhBZluM0Ix4MNVlBVDL1+nPaGHUoewe3Ay7ZV/w=
X-Google-Smtp-Source: AGHT+IHIwoQzWS4BMQgwFN+MZ738g0TwywAROWyKKdIPTEdVaVrBaTq/gSSsO5ifNGwIKJT7r35V4rLO/ylbgNI4JiA=
X-Received: by 2002:a25:6853:0:b0:db5:3c1d:76a5 with SMTP id
 d80-20020a256853000000b00db53c1d76a5mr1385840ybc.44.1701349361458; Thu, 30
 Nov 2023 05:02:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1700449792.git.zhoubinbin@loongson.cn> <cae772aa897f6b10c3f5c4c93a256b50c5de4b21.1700449792.git.zhoubinbin@loongson.cn>
 <20231127182836.GA2150516-robh@kernel.org>
In-Reply-To: <20231127182836.GA2150516-robh@kernel.org>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Thu, 30 Nov 2023 19:02:29 +0600
Message-ID: <CAMpQs4LSTV6PgZSuyQx2Nq+87OHxSa=-Wz5nbhFVsmmvHubQFQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] dt-bindings: interrupt-controller:
 loongson,liointc: Standardize the naming of 'loongson,parent-int-map'
To:     Rob Herring <robh@kernel.org>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, lvjianmin@loongson.cn,
        WANG Xuerui <git@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 12:28=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Mon, Nov 20, 2023 at 05:06:23PM +0800, Binbin Zhou wrote:
> > Since the 'loongson,parent_int_map' attribute naming is non-standard, w=
e
> > should use 'loongson,parent-int-map' instead.
> >
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > Acked-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > ---
> >  .../bindings/interrupt-controller/loongson,liointc.yaml   | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/loo=
ngson,liointc.yaml b/Documentation/devicetree/bindings/interrupt-controller=
/loongson,liointc.yaml
> > index 00b570c82903..70c125bf8095 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/loongson,l=
iointc.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,l=
iointc.yaml
> > @@ -54,7 +54,7 @@ properties:
> >    '#interrupt-cells':
> >      const: 2
> >
> > -  loongson,parent_int_map:
> > +  loongson,parent-int-map:
>
> Not what I said to do. Now you just break the ABI instead of maintaining
> both names.
>
> Just use loongson,parent_int_map *forever*. Drop this patch.

Hi Rob:

Thanks for your reply, and I am very sorry that I may have missed your
previous thought, but at the same time I'm confused about how to
handle the 'parent_int_map' attribute.

During the V2 patchset, krzysztof noticed the non-standard naming of
this property and suggested that we rename 'parent_int_map' in the
binding and label it as "deprecated". But you don't think it's worth
doing that.
My understanding is that it doesn't make sense to keep
'parent_int_map' for the new binding, so I'm just going to rename the
property in this version.
It's true that this will result in an ABI break, but at the same time
corresponding changes have been made to the driver as well as in the
existing DTS{i}:
Patch 4: Handles attribute names in both naming styles;
Patch 5: Replace all 'parent_int_map' in the MIPS DTS{i}.

Do you think this is a suitable way to handle this? Or just keep the "_" na=
ming?

Thanks.
Binbin
>
> Rob
