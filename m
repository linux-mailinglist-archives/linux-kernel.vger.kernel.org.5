Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5DF77CE6B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237777AbjHOOsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237799AbjHOOsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:48:16 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1222FE3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:48:14 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b72161c6e9so75748851fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692110892; x=1692715692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibbiZiUA+psUXSR5jUh/+IlNRDXZdtdDillHT+rm3pU=;
        b=U6hg5sg6uAKSWxt0HUVBLWSx0P/Va40jtTADSEVuzIH5KWeO3zdr21ZbxzFVKpfBlW
         KB24HHDVpVo7o/EFigR2hlv89p5idw9I8cydSgr34swBjeccniKPaLFWsjj6eBP8fehe
         xUIHKwJdDXkOatWNSUnQLVWbU7I6GIGScGp5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692110892; x=1692715692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibbiZiUA+psUXSR5jUh/+IlNRDXZdtdDillHT+rm3pU=;
        b=OveWhpMG1tVTIwegjBH1BM842PccDWpZ4uK/kPBb5zBOBhnopHPlMoKpULeUK5eN3/
         nrW1nVifs0PUBGrF1lEXoPkADv2gS4Slc382EIiNHU79Hbwri0xFWSY3xcnFCdq6hsqt
         HcIJozcDv1uhOfyGdG0Gq3K7wTTTYyuT62h635btK4sOrkVl9ITbDllHNtMK+BJTjhZA
         dWMYK/KQbwGk/F1SQBBLtYyi5LYJpFpSdcaQZXWnT9BxaYC32miySBah7j/9WLMV4yDm
         wJEdCOxkGO+1nLRzYpAMngckR4gt3VcPc5H47FMqB9ietYoiv/QuvpgA0Yc/mKgBD+Us
         nmBA==
X-Gm-Message-State: AOJu0Yzkg6Hj3mZvYiPJ89opEhX9cz72JgSi31e1/yvgu2Crk0nzp2xF
        LbN46zvYLLyL6PFWrq7g3LsSuopdHsN2eVkV0vbDbQ==
X-Google-Smtp-Source: AGHT+IHTIyZF2a0Lewx1kaEyopouMrrXNjHT3NJi7iQHgr1EAUrSfMtmSq7xI4WQF76YzqD1XX4CAWsZeuHhipxQA3A=
X-Received: by 2002:a2e:9206:0:b0:2b4:6a06:4c26 with SMTP id
 k6-20020a2e9206000000b002b46a064c26mr710210ljg.2.1692110892069; Tue, 15 Aug
 2023 07:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230616122815.1037425-1-juerg.haefliger@canonical.com>
 <20230620054031.1203960-1-juerg.haefliger@canonical.com> <b0460532-b5f1-7efc-49af-8d4feecc1085@linaro.org>
 <20230815135214.15aeff63@gollum>
In-Reply-To: <20230815135214.15aeff63@gollum>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 15 Aug 2023 10:48:01 -0400
Message-ID: <CAEXW_YShF2RMnsgTzjB1z6vLU+3oOv1vEPtWnmBT-NsREh88-g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/adreno: Add missing MODULE_FIRMWARE macros
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, johan+linaro@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_abhinavk@quicinc.com,
        quic_akhilpo@quicinc.com, ribalda@chromium.org,
        robdclark@gmail.com, sean@poorly.run
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 7:52=E2=80=AFAM Juerg Haefliger
<juerg.haefliger@canonical.com> wrote:
>
> On Thu, 22 Jun 2023 21:44:25 +0300
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
>
> > On 20/06/2023 08:40, Juerg Haefliger wrote:
> > > The driver references some firmware files that don't have correspondi=
ng
> > > MODULE_FIRMWARE macros and thus won't be listed via modinfo. Fix that=
.
> > >
> > > Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> > >
> > > ---
> > > v2:
> > >    - Drop addition and removal of zap files (needs more discussion)
> > >    - Add new a690_gmu.bin
> > >    - Update commit subject and message accordingly
> > > ---
> > >   drivers/gpu/drm/msm/adreno/adreno_device.c | 11 +++++++++++
> > >   1 file changed, 11 insertions(+)
> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >
>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel
