Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E357ED83D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 00:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjKOXf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 18:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjKOXf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 18:35:26 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B5E198
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 15:35:21 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cc79f73e58so25375ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 15:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700091321; x=1700696121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oek2kHOiJKwuGradh8KZUYYGEhpdoKxKkCGLT/Ex0Qs=;
        b=D5UwbWOre6mj6XRjaEoB2nZnaWO/F1Q+EyvIp57SEaS9BsFabaLlUIXIB3OPu9GNqk
         FNP+c+6rxmf7xP7e39SlzF9rAoH+Q8wQjh4xvyKp5msWXRzFOKao7N3Yk4ccSMgum78g
         XAq8HZtnRPnQuPOC2eXYgJmw49J8/lpljstexDm4aE6SAP19shdRjuBVJGZwFAC26C1m
         2scMo3r2CxBSJH6sXBGso2PvOzwU47ADhtrQrXWU7XJqqCaZHp2m4C+ws4UlHZ1smbRE
         ouuuXNrrS2gNfvN+7eFI3QqUMDYCG4Q+/0tOcZi5bGtAYhqO63ncaAV1EgtK2Jju41Op
         LMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700091321; x=1700696121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oek2kHOiJKwuGradh8KZUYYGEhpdoKxKkCGLT/Ex0Qs=;
        b=FBmgSn4HsxqeGKaxNsi5VC8VJNjvbkjWnR/lsGHgSfqRITjz/b6PFMLTjrvLLjmg36
         tn2+sZzh/pkqKPubdmDCQa75HNue62MCE8rQ3dUjiD1fqO1GDrk2REFC1aJ+8/a3szdl
         0Fp6HZ0nb0gJ31NF+lQ7sLRm4rup+fC4Xwo/9GBNUaefWrCuABCL0hWA8Ywt8NLVe/P7
         xVCt7AmJSaX6EImYyPXthuE5iYCwJ0Ic76EfuitjXRMYAjv+E2w12UTjRDDQxaq6TO1a
         1l29I557wph83YaVUz+VQvpmhvE72qUpDgoz7di7xNf4MpMJkCxYtLipFSGi5pLaAmg1
         4BHQ==
X-Gm-Message-State: AOJu0Yz7C3lN7tyV27wsZNxDfkwO2yOhkjml+G6D6fuGrg7ULgk8I9BW
        1iQ7szfpY977qQN0/RKgJUBqo2fR40hpjEmBOR+5
X-Google-Smtp-Source: AGHT+IGz9f/SLu5mPtYfVW8CPrScTnMxwCAhNmSPfXNU6OOHTiFkG39zGsXsGPkZucRS05i+dhBhg89vqZQYyDxclRo=
X-Received: by 2002:a17:902:f684:b0:1cd:fbc7:271f with SMTP id
 l4-20020a170902f68400b001cdfbc7271fmr66903plg.20.1700091320785; Wed, 15 Nov
 2023 15:35:20 -0800 (PST)
MIME-Version: 1.0
References: <20231111111559.8218-1-yong.wu@mediatek.com> <20231111111559.8218-7-yong.wu@mediatek.com>
 <0ccee72f-98ac-4a08-9253-9c22dad4d95a@linaro.org> <5d7b2458b8d1896ce575f4ed2d413f4e8eeb92b4.camel@mediatek.com>
 <3daaa2aa-61d4-40db-b36d-cd825a340d2b@arm.com>
In-Reply-To: <3daaa2aa-61d4-40db-b36d-cd825a340d2b@arm.com>
From:   Jeffrey Kardatzke <jkardatzke@google.com>
Date:   Wed, 15 Nov 2023 15:35:09 -0800
Message-ID: <CA+ddPcM5CuiOs+JGGBtn7ea1vzwHvawyApa_wRcGWNLD=yrrnw@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] dt-bindings: reserved-memory: Add secure CMA
 reserved memory range
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "jstultz@google.com" <jstultz@google.com>,
        "nicolas@ndufresne.ca" <nicolas@ndufresne.ca>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?SmlhbmppYW8gWmVuZyAo5pu+5YGl5aejKQ==?= 
        <Jianjiao.Zeng@mediatek.com>,
        =?UTF-8?B?S3VvaG9uZyBXYW5nICjnjovlnIvptLsp?= 
        <kuohong.wang@mediatek.com>,
        "quic_vjitta@quicinc.com" <quic_vjitta@quicinc.com>,
        "ckoenig.leichtzumerken@gmail.com" <ckoenig.leichtzumerken@gmail.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Brian.Starkey@arm.com" <Brian.Starkey@arm.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "tjmercier@google.com" <tjmercier@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "joakim.bech@linaro.org" <joakim.bech@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

May I suggest the following for the device tree binding? (I'm not very
familiar w/ device trees, so apologies for any oversights, but trying
to process the feedback here and help move Mediatek along). This
should align with my other suggestions for having an MTK specific
portion to their secure heap implementation; which also means there
should be an MTK specific device tree binding.

# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
%YAML 1.2
---
$id: http://devicetree.org/schemas/reserved-memory/mediatek,dynamic-secure-=
region.yaml#
$schema: http://devicetree.org/meta-schemas/core.yaml#

title: Mediatek Dynamic Reserved Region

description:
  A memory region that can dynamically transition as a whole between
secure and non-secure states. This memory will be protected by OP-TEE
when allocations are active and unprotected otherwise.

maintainers:
  - Yong Wu <yong.wu@mediatek.com>

allOf:
  - $ref: reserved-memory.yaml

properties:
  compatible:
    const: mediatek,dynamic-secure-region

required:
  - compatible
  - reg
  - reusable

unevaluatedProperties: false

examples:
  - |

    reserved-memory {
        #address-cells =3D <1>;
        #size-cells =3D <1>;
        ranges;

        reserved-memory@80000000 {
            compatible =3D "mediatek,dynamic-secure-region";
            reusable;
            reg =3D <0x80000000 0x18000000>;
        };
    };

On Tue, Nov 14, 2023 at 5:18=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 13/11/2023 6:37 am, Yong Wu (=E5=90=B4=E5=8B=87) wrote:
> [...]
> >>> +properties:
> >>> +  compatible:
> >>> +    const: secure_cma_region
> >>
> >> Still wrong compatible. Look at other bindings - there is nowhere
> >> underscore. Look at other reserved memory bindings especially.
> >>
> >> Also, CMA is a Linux thingy, so either not suitable for bindings at
> >> all,
> >> or you need Linux specific compatible. I don't quite get why do you
> >> evennot
> >> put CMA there - adding Linux specific stuff will get obvious
> >> pushback...
> >
> > Thanks. I will change to: secure-region. Is this ok?
>
> No, the previous discussion went off in entirely the wrong direction. To
> reiterate, the point of the binding is not to describe the expected
> usage of the thing nor the general concept of the thing, but to describe
> the actual thing itself. There are any number of different ways software
> may interact with a "secure region", so that is meaningless as a
> compatible. It needs to describe *this* secure memory interface offered
> by *this* TEE, so that software knows that to use it requires making
> those particular SiP calls with that particular UUID etc.
>
> Thanks,
> Robin.
