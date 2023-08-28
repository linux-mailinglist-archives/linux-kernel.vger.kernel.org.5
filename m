Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E8678B3F6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjH1PFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjH1PFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:05:18 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45C5128
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:05:14 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9a1de3417acso904655766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693235112; x=1693839912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfPK78oI6HF2aKszLamjdHUKrUN9+ephAhq79b1VoJo=;
        b=RY1OtA62cgTfP/oR1c+rmmXq9JROmQoFzvqi/d9Zovnh9Gr1r1U0DbUkN8j30qhkzd
         PWazlcJ9zn9RG7DTPo6sJerAD3E7ujEECdEcg0CUtmLLvcTofg97/MX3EXZROErqDT0f
         Qrpa/swhUwfguCipPZ7abEJiZyGHA0H38zU0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693235112; x=1693839912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfPK78oI6HF2aKszLamjdHUKrUN9+ephAhq79b1VoJo=;
        b=j4j2Ix6l+B6AqU7MczftGD4ag6YY0V+dkKPtQqCrmApkJYsTi/eNPzonahN9Gyqp4v
         Vma+LFvoGlOBXpKWGp6lSl2lLudkkb4IMoc8L9mzT4+QVTUvf5uLJZCx+Ve1EhGGw4sb
         2+QUVfXJ3JwHXOzqKCJvD/akdAk2Nx0lyTdsAvrxTL8UyX/ifQRARwhfUSJvI7co7Sii
         3P/G+pEw+diikFmZoHkee3qQTmN20KFn69WzhiI/Sb2O2UW5Z74q54Qd01yaLe/kVQkk
         A+5cleWHQCVwnV6f2HBRjFxJd3ZihCsWN4VM0A6EeqNLy5J4qeNnA8usDIktLpKmC47e
         Wc0w==
X-Gm-Message-State: AOJu0YyfsxAtFrwYeXjwFn21468UKdNtFCGO6+jai203Mu/9qVn8WQyE
        i6Eu5X+l1udO9AgnkNRV5he66J/x8ET4bxBRAkUr+g==
X-Google-Smtp-Source: AGHT+IHn6lbB1EeUUknQbC7vVq7V+bntSrsUqGczgDp6bTB4TsRx6DtglDYkW3HkZlNZBuA9Vcwp/g==
X-Received: by 2002:a17:906:76cd:b0:993:eee4:e704 with SMTP id q13-20020a17090676cd00b00993eee4e704mr26536034ejn.38.1693235112380;
        Mon, 28 Aug 2023 08:05:12 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id vw13-20020a170907058d00b00993664a9987sm4745098ejb.103.2023.08.28.08.05.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 08:05:11 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so130345e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:05:10 -0700 (PDT)
X-Received: by 2002:a7b:cc95:0:b0:3f4:fb7:48d4 with SMTP id
 p21-20020a7bcc95000000b003f40fb748d4mr308827wma.3.1693235110566; Mon, 28 Aug
 2023 08:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230816112143.1.I7227efd47e0dc42b6ff243bd22aa1a3e01923220@changeid>
 <20230816112143.2.I29a5a330b6994afca81871f74bbacaf55b155937@changeid> <610a1b08-ced2-4e07-8b69-b2dd2749293e@linaro.org>
In-Reply-To: <610a1b08-ced2-4e07-8b69-b2dd2749293e@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 28 Aug 2023 08:04:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VRj4oXFimYxkEOAj7c2ddkWhX1hpTfOFYuAW_svRuAqA@mail.gmail.com>
Message-ID: <CAD=FV=VRj4oXFimYxkEOAj7c2ddkWhX1hpTfOFYuAW_svRuAqA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc7180: Reorganize trogdor rt5682
 audio codec dts
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Aug 26, 2023 at 2:36=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
> On 16.08.2023 20:21, Douglas Anderson wrote:
> > It was asserted that the "/delete-property/ VBAT-supply;" that we
> > needed to do in the rt5682s dts fragment was ugly. Let's change up all
> > the trogdor device trees to make it explicit which version of "rt5682"
> > we have and avoid the need for the "delete-property".
> >
> > As a side effect, this nicely gets rid of the need for a delete-node
> > in coachz, which doesn't use "rt5682" at all.
> >
> > A few notes:
> > - This doesn't get rid of every "/delete-node/" in trogdor, just the
> >   one that was used for rt5682s.
> > - Though we no longer have any "/delete-node/", we do still override
> >   the "model" in the "sound" node in one case (in pompom) since that
> >   uses the "2mic" sound setup.
> >
> > This is validated to produce the same result (other than a few
> > properties being reordered) when taking the dtbs generated by the
> > kernel build and then doing:
> >
> >   for dtb in *trogdor*.dtb; do
> >     dtc -I dtb -O dts $dtb -o out/$dtb.dts;
> >   done
> >
> > Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> [...]
>
> > +&mdss_dsi0_phy {
> > +     qcom,phy-rescode-offset-top =3D /bits/ 8 <31 31 31 31 (-32)>;
> > +     qcom,phy-rescode-offset-bot =3D /bits/ 8 <31 31 31 31 (-32)>;
> > +     qcom,phy-drive-ldo-level =3D <450>;
> > +};
> > +
> > +&panel {
> > +     compatible =3D "boe,tv110c9m-ll3";
> > +};
> This is odd

Can you clarify why it's odd? There are two possible panels used in
wormdignler, one with an INX display and one with a BOE display. This
one has the BOE display.

For the BOE display, there is one with the old Realtek audio codec
(rt5682i) and one with the new Realtek audio codec (rt5682s).

Previously, the BOE/rt5682s device tree could just include the
BOE/rt5682i device tree and override the audio. ...but Krzysztof
didn't like that. ...so now we have to duplicate the BOE bits in both
the BOE/rt5682s and BOE/rt5682i files. We could make a fragment for
just this bit, but that feels overboard for something that's in just
two files.

As per my "after the cut" description, I'm not really convinced that
the end result here is easier to understand. Some bits are clearer and
some more complex. I simply wrote it up because it was requested.

-Doug
