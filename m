Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7B67E4782
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343883AbjKGRsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbjKGRsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:48:01 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAECD77
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 09:47:58 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9e1fb7faa9dso204014366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 09:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699379277; x=1699984077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCPAQiBeVySoeJKAHJeq5sOYdSn0tG90ibTG5f+jP5s=;
        b=PdGfanwzoeIol4Mn3czGN61UzZFV5wR4dVBIxKFSJiiFZhyMFqfsEoV8TX/FGyovkY
         S2oEs38eomWPcunyskSra+oOHIlvpnPv5Nx/rAF3UCVtaWKJwFLkWWioTIcWRrCoxiHA
         xBukwpeggBjDvKxG44y/LqtDMq6PIea2MDnd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699379277; x=1699984077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCPAQiBeVySoeJKAHJeq5sOYdSn0tG90ibTG5f+jP5s=;
        b=ezcqk4Ec7lYHDNC2IZX6X132r1aFkLp3J7eJ8xUjZqPfKE5WTUVUvT5jEm0HbOShss
         +w9u8l//BFnvwDjdCWOH1+5q8YXZaxxpRYs66ohPAFj1BKbaU0q0nBa0t26qpB3VlfAL
         0gNfwztUPXXlno6zvN+CXErwn1UCc0vsdzzGRdzDT/uTOhnjNHlCCdppvNeuF45lkrsH
         amEW7LF0ber1BZj122+GVGfn122CjyIR0HIpqEE+LK6S2TFuV3pnU+a+peQjvE8y9kcN
         INcoM1iBHFuGTgo23FTf3p3OkNArTu6ahl4zhGK6XicM69S80OifYkQROCMEgRJk0l2P
         em+A==
X-Gm-Message-State: AOJu0Yz9Ncl8v6zC9BZXsu2N2cXkSMoRjHOB9pp/j7G3pdJbhEUTKWFB
        Kdp1s9ESzsBUmn4qVcXOfx5wL89jyOP5ZQ2QXPv8NXNm
X-Google-Smtp-Source: AGHT+IFGVClafF7AFNRI8NBhy6YjQQP1lLST/IUX8wErdXDWxPkAkdRFzcy9r+kcn7g6IQnFv3i7Hw==
X-Received: by 2002:a17:906:fe45:b0:9df:bc50:2513 with SMTP id wz5-20020a170906fe4500b009dfbc502513mr7536557ejb.65.1699379276945;
        Tue, 07 Nov 2023 09:47:56 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id jt10-20020a170906ca0a00b0099bcf9c2ec6sm1299900ejb.75.2023.11.07.09.47.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 09:47:55 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40853f2e93eso3735e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 09:47:55 -0800 (PST)
X-Received: by 2002:a05:600c:2217:b0:3f4:fb7:48d4 with SMTP id
 z23-20020a05600c221700b003f40fb748d4mr101271wml.3.1699379275221; Tue, 07 Nov
 2023 09:47:55 -0800 (PST)
MIME-Version: 1.0
References: <20231107072651.v2.1.Ide945748593cffd8ff0feb9ae22b795935b944d6@changeid>
 <9b2e37a0-32ee-4aa4-99e8-d37103674847@collabora.com> <CAD=FV=Xv7XKvePTZ6LKT97EViG81d8hqk+T68B5eXamKTU407A@mail.gmail.com>
 <e2e7762bfd16f67bdc253dc23a967c46@kernel.org>
In-Reply-To: <e2e7762bfd16f67bdc253dc23a967c46@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 Nov 2023 09:47:43 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X-5Z0ucRqrqkoEf9T+f7zQeXq2bJ3hpPw=d11mAdvgbQ@mail.gmail.com>
Message-ID: <CAD=FV=X-5Z0ucRqrqkoEf9T+f7zQeXq2bJ3hpPw=d11mAdvgbQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: Move Mediatek GIC quirk handling from
 irqchip to core
To:     Marc Zyngier <maz@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        James Morse <james.morse@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 7, 2023 at 9:43=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2023-11-07 17:37, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Nov 7, 2023 at 8:30=E2=80=AFAM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> > +static __init void detect_system_supports_pseudo_nmi(void)
> >> > +{
> >> > +     struct device_node *np;
> >> > +
> >> > +     if (!enable_pseudo_nmi)
> >> > +             return;
> >> > +
> >> > +     /*
> >> > +      * Detect broken Mediatek firmware that doesn't properly save =
and
> >>
> >> s/Mediatek/MediaTek/g
> >>
> >> Apart from that,
> >>
> >> Reviewed-by: AngeloGioacchino Del Regno
> >> <angelogioacchino.delregno@collabora.com>
> >>
> >> On MT8195, MT8192, MT8186:
> >> Tested-by: AngeloGioacchino Del Regno
> >> <angelogioacchino.delregno@collabora.com>
> >
> > Thanks! Unless someone wants me to spin it more quickly, I'll plan to
> > send a V3 with the Mediatek=3D>MediaTek change tomorrow.
>
> I really don't think that's worth the effort.
>
> Catalin can fix this when applying the patch, and even then,
> nobody is going to notice that sort of pretty irrelevant
> detail.

Sure, that's fine with me too--just trying to be helpful! OK, I won't
plan to spin the patch unless someone tells me otherwise.

-Doug
