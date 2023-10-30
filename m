Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483BD7DB45D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjJ3Hcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjJ3Hco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:32:44 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0AAA2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:32:41 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6ce532451c7so2445469a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698651161; x=1699255961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OS97Gly969hAZsKV6Q2Qngs0Z2OBQT8NYeJbqEJuAuQ=;
        b=W4z5rNy+uq3focv56tLoWj3G4tDBlQ0BH4exYEJltfoc2Mg61XgSm5MSrfcZMSGPG7
         7KR6kDy7jQnbsvpk1T/RvZLkZTJaAG6uCKbNhj0iQNM8SUcFeqMLLFA6nW9RylyvQElx
         38lxMzUhZ7EavxlvDgPX6hQnwOkCj0Bc3UKcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698651161; x=1699255961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OS97Gly969hAZsKV6Q2Qngs0Z2OBQT8NYeJbqEJuAuQ=;
        b=LACZraYAJqJM9dgSyM31Kj3IL2QIw9wnvRebEA6KdbVrntaYCGEcAp2vuCroqy41yA
         NO52f2zVxEnJg/t+4dQNpiHtg6CRXjVvcQmpsE6vUrp23NLo82Vc0bbddD4fEo7pl0R5
         AuQPMy0NvLXF+S23p4oO+lwOO3WKC2U1QQ5micm+af/AiJWEEc1VKLvCTkLTFlR6oZnf
         +rCD3LKKZ7GSlPA+43aDoK3J8S0EKj4v0lRw23Nnunbhzcctv8VOr7Vcg7a/9HeuLYs3
         qNOpWStaaEN1LiPbMf7e1kZAEsC7DIiPALWMPAqD0C+FGCBPdqbtADSSlT/eKAngUwaY
         Irwg==
X-Gm-Message-State: AOJu0YxNHyCxfeGi/xswCTursaq8fjgZ1VQk537s6fwqpE7jt2d95UFZ
        1QNCQpMgxQX9NnjkFgRjAvg9FTrr54HGUgbEZBF8PjipxVgSiNLS
X-Google-Smtp-Source: AGHT+IHL77UHTDV9OUWcsYurFmch++YSkIivuvKwbAT5lRWUVjbYbXkzJwGr33gA4/ptF3SP0jdxYIFIU1nbetPUscM=
X-Received: by 2002:a05:6830:4ac:b0:6ce:25a2:67cf with SMTP id
 l12-20020a05683004ac00b006ce25a267cfmr7644490otd.26.1698651161064; Mon, 30
 Oct 2023 00:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231026191343.3345279-1-hsinyi@chromium.org> <7b737537-38f2-4404-b469-c67005cdaf83@linaro.org>
 <CAJMQK-jQUHz8-hEx4DzNU3cOnN59JG1xFBPH5mUndLV-rbk+Jg@mail.gmail.com> <2a29c027-4431-4693-98d4-ba09ad46591b@linaro.org>
In-Reply-To: <2a29c027-4431-4693-98d4-ba09ad46591b@linaro.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 30 Oct 2023 00:32:15 -0700
Message-ID: <CAJMQK-jNa2ZTV4mSjMoPasM8TJVetExrWqZ_+6t77rVeAqqSCQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Add a few mt8183 follower boards.
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2023 at 12:58=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 27/10/2023 23:22, Hsin-Yi Wang wrote:
> > On Fri, Oct 27, 2023 at 4:17=E2=80=AFAM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 26/10/2023 21:09, Hsin-Yi Wang wrote:
> >>> Add makomo, pico, and katsu which are mt8183 followers.
> >>>
> >>> v4: based on https://lore.kernel.org/all/20231025093816.44327-1-angel=
ogioacchino.delregno@collabora.com/
> >>>
> >>
> >> Where is the changelog? It's already v4 and still no changelog...
> >>
> >
> > v3:https://patchwork.kernel.org/project/linux-mediatek/cover/2023102521=
5517.1388735-1-hsinyi@chromium.org/
> > v2:https://patchwork.kernel.org/project/linux-mediatek/cover/2023102421=
2618.1079676-1-hsinyi@chromium.org/
> > v1:https://patchwork.kernel.org/project/linux-mediatek/cover/2023102400=
0724.57714-1-hsinyi@chromium.org/
> >
> > changelog with previous version are in each of the patchset. eg:
> > https://patchwork.kernel.org/project/linux-mediatek/patch/2023102521551=
7.1388735-5-hsinyi@chromium.org/
>
> One would think but:
> https://patchwork.kernel.org/project/linux-mediatek/patch/20231025215517.=
1388735-7-hsinyi@chromium.org/
> https://patchwork.kernel.org/project/linux-mediatek/patch/20231025215517.=
1388735-3-hsinyi@chromium.org/
>
> Usually expected is in such case to wrote "v4: No changes".

Got it. Would add this notice next time. Thanks!

>
> Best regards,
> Krzysztof
>
