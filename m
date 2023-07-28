Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2774A767086
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbjG1P3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjG1P3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:29:35 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9367735A8;
        Fri, 28 Jul 2023 08:29:33 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe1c285690so2632369e87.3;
        Fri, 28 Jul 2023 08:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690558172; x=1691162972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWY5MitYzqJ4d1bWl5n1gXmIbqPwv+V3mvdT6pw4Joo=;
        b=spL3/dRcoa3f8wiIiP4KqpRnJi5z+v7W8ANf+zhQjBOBZZo931y9+BgkQkiNBesEtg
         atYPhabihDsA3VLHbn7Dz08mDbJGqwdJPsliHSHanX0fVDB6WEFf1WnCiJjkrk195LtG
         WimZisfkapB/STS57H7637OhqQ5SuV1fA3uiQCk5QwCD5Lc/bSizj6/trIl/g6AxU2H2
         FiUnXlPE6e9l1sKVkqU0w9etFNmp1tDgw/etFEND+xo7SPaVF0cHQe0smbkpyBNQMLHS
         quujH7k9Vk0rZwusd+jLvaKgIonLmUT/JCeO+57s/O/3oTEGSuPTvF3Khbc8HTkvrCxO
         gBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690558172; x=1691162972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWY5MitYzqJ4d1bWl5n1gXmIbqPwv+V3mvdT6pw4Joo=;
        b=DdDZtkZQ2Rd5jZOpxE08fITE7wLVniAe7DsM5a2nm84nR+T0QqfY42MHyhdVGuYA3d
         R94nX+3CIG+gL3xPgXPBXebQ1bkE3DimpTBS6GD9d3IR3/1UvEdKCc6RDwgOIojtitkO
         h4b4hQ1n0MOU+Vd901VGAUH0OImVNEqd/0PBgy+IPPiRu360qkgE5Es8oT7k1RStcDGV
         SHKZUUhMn1TBfhkJSr/DFHaMz6N4iJkXnKNfdNWT5PKSsehoPtk46tEOJPPO21rwAqjO
         wPEFHUWaJmvDMpsL8bA1jpxUjRKEohDLKzeFFlq28Uie3MzHUKxK9QmYP57Eyv+BECus
         m0gw==
X-Gm-Message-State: ABy/qLYZwnwn46A8J3BuVxssVgY6i+98pS4ePF1+WeJW0/0sKKt8rmvK
        aTDi8X0fI9emkmuWCTp7K6/ziAowT87ue/VgTsrmb2C13LtcTg==
X-Google-Smtp-Source: APBJJlG9HA1renQSWWmK4jFIFA634+RbkACkuwQYa0S4sEwxKAw6D1WHjQhQGkb90LkAwDcSFZFj21mMVuuM+mbHCA4=
X-Received: by 2002:a05:6512:2253:b0:4fd:faa5:64ed with SMTP id
 i19-20020a056512225300b004fdfaa564edmr2283534lfu.11.1690558171553; Fri, 28
 Jul 2023 08:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230727212208.102501-1-robdclark@gmail.com> <20230727212208.102501-13-robdclark@gmail.com>
 <08cd9bb5-678f-e03e-4598-dd1785f0d7a7@linaro.org>
In-Reply-To: <08cd9bb5-678f-e03e-4598-dd1785f0d7a7@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 28 Jul 2023 08:29:19 -0700
Message-ID: <CAF6AEGu-aRzi6ADqCnLU46DC0ZoWmSmhYU2sZj83wTyTbazbxg@mail.gmail.com>
Subject: Re: [PATCH v2 12/13] dt-bindings: drm/msm/gpu: Extend bindings for chip-id
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 12:27=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 27/07/2023 23:20, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Upcoming GPUs use an opaque chip-id for identifying the GPU.
>
> Examples?

We'll know when we bring up the hw.  But the main point is that we
shouldn't expect, for example, the high 8 bits to tell us the
generation, any more than we could if it was a pci id.

We may not end up needing to use this new binding much, I _think_ we
should be able to read it from the fw in most cases, at least for
android devices.  I'm unsure at this point about windows/chromebooks.

> Anyway, I think we should insist here of using something human-readable,
> even if Qualcomm/Adreno internally use some weird numbers.

I mean qcom,sc8280cx-adreno is human readable but not really very
informative.  Encoding the chip-id is just a way to avoid the
qcom,chipid field in the bindings, which qcom used downstream.  The
new pattern accomplishes the same thing as the existing one, but
without trying to imply some meaning that becomes increasingly
non-existent as qc moves to decouple the id from marketing names.

> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  Documentation/devicetree/bindings/display/msm/gpu.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/D=
ocumentation/devicetree/bindings/display/msm/gpu.yaml
> > index 58ca8912a8c3..56b9b247e8c2 100644
> > --- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
> > +++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
> > @@ -13,6 +13,12 @@ maintainers:
> >  properties:
> >    compatible:
> >      oneOf:
> > +      - description: |
> > +          The driver is parsing the compat string for Adreno to
> > +          figure out the chip-id.
> > +        items:
> > +          - pattern: '^qcom,adreno-[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-=
9a-f][0-9a-f][0-9a-f][0-9a-f]$'
>
> {8} should work?
>

so '^qcom,adreno-[0-9a-f]{8}$'

BR,
-R

>
>
> Best regards,
> Krzysztof
>
