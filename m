Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64187BC228
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbjJFWRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjJFWRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:17:45 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C84BE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 15:17:43 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9ad810be221so447998066b.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 15:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696630662; x=1697235462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhO3ehWc1dLHvm/xZLr7SfH1xniT/+pUCjErhuF2vy4=;
        b=XtIozXrfIsIA9DPsPbmAyofab6jlrYN0K0xxhpLmqnXD4TyXc7mdPUJbpoiZDntM/q
         y2/GGKZR7iGHiXlEb+dL7fWqpkVWMy3oIu2434UYTVCHJX7HaSiMZ5EYJYrJiD3Ho8Kj
         uXYKVtA5WKKP9yxSZtX111HdhattYUPSs2Tjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696630662; x=1697235462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhO3ehWc1dLHvm/xZLr7SfH1xniT/+pUCjErhuF2vy4=;
        b=wZ64MjJ3FNCdafb/Ufz1PFGc/t+dbPZsjLu9erc5up50AIAd5YTSPKjspTkGEF+uWY
         5yYKMElCyyKV6xazel8IObxKF25NNobaL3Dd3KjL6DkFFpZA/7gB+Il8037vifZG+jjT
         dyIL+RWwNLPEGtAgCPW3ZwnS8qYZ+9rmvGbrEy572a9ATUqF52LvHh8ejAYoV5Ukm1ys
         1k0EIymV8D0G0Ie7sHg5prkCKWp32OH8RdQxtg9smwuEcDgr42OX3/yipmvLaRnTdIxE
         QBNAqrRU7VtLXYaas0BxPgAjXEiSjen/jVojrSst5C6xaMAGe/YnDmG88cvfFiCQsTkB
         xByw==
X-Gm-Message-State: AOJu0YzRVFYU4DtePzjLyzCWlD6cM18l9Wp0jNWEz7JffHiARt5Zdkss
        jDcWaapREU9inD37axEWSq/N9J5p0veLCvTOiOjve+N5
X-Google-Smtp-Source: AGHT+IGLBN/OLS3tqhNsRbwFJ1WwvJ/dpMDUtkYtmLEEq1Cm0shxPHY3UJ6bFFiRKzSimSVA+F//jw==
X-Received: by 2002:a17:906:13:b0:9ae:1de:f4fb with SMTP id 19-20020a170906001300b009ae01def4fbmr7621920eja.46.1696630661563;
        Fri, 06 Oct 2023 15:17:41 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id q14-20020a170906360e00b009a5f1d1564dsm3415171ejb.126.2023.10.06.15.17.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 15:17:41 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-405459d9a96so27835e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 15:17:41 -0700 (PDT)
X-Received: by 2002:a05:600c:2e11:b0:3fe:f32f:c57f with SMTP id
 o17-20020a05600c2e1100b003fef32fc57fmr226863wmf.0.1696630660734; Fri, 06 Oct
 2023 15:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231002094526.1.Ie8f760213053e3d11592f892b30912dbac6b8b48@changeid>
 <ZRr8r7XMoyDKaitd@FVFF77S0Q05N.cambridge.arm.com> <CAD=FV=UeeL9uycVeKpOm+eDm3xHrOnKi2frt6a1qFG1HX9yEUg@mail.gmail.com>
 <ZRwJKBZaYwF1rrur@FVFF77S0Q05N> <CAD=FV=WASz1uvTgwsu3H3cTr3smHk+E_XNUVnjoPpttwv095rQ@mail.gmail.com>
 <ZRxCCZxZWCG0NBur@FVFF77S0Q05N> <CAD=FV=Xk-OMKQPXxU9Z9HOcWwUxxrmLZ4vD0u5ouZRW_zDFDPg@mail.gmail.com>
 <ZR03liCodnTQWs7s@FVFF77S0Q05N> <86jzs2ofqs.wl-maz@kernel.org>
 <CAD=FV=XasZR6dhKBjpbYfby4F1Nu_bsq1m_HP+NpufjsJi0COg@mail.gmail.com>
 <ZR6Pjk_3gpx1K3pF@FVFF77S0Q05N> <864jj4njb7.wl-maz@kernel.org>
In-Reply-To: <864jj4njb7.wl-maz@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 6 Oct 2023 15:17:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wdkm6uMMtSL0qWmciaNV33Q-OFw_ttPo3zUzpoguBjsg@mail.gmail.com>
Message-ID: <CAD=FV=Wdkm6uMMtSL0qWmciaNV33Q-OFw_ttPo3zUzpoguBjsg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: smp: Fix pseudo NMI issues w/ broken Mediatek FW
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Misono Tomohiro <misono.tomohiro@fujitsu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
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

On Fri, Oct 6, 2023 at 3:20=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 05 Oct 2023 11:27:26 +0100,
> Mark Rutland <mark.rutland@arm.com> wrote:
>
> > 3) Partial fix: make the ARM64_HAS_GIC_PRIO_MASKING cpucap depend on th=
e
> >    absence of a "mediatek,broken-save-restore-fw" property in the DT. I=
 believe
> >    we can check that in early_enable_pseudo_nmi() or can_use_gic_priori=
ties().
> >
> >    That'll avoid potential issues if/when we change the priorities used=
 for
> >    pNMI (which is something I've been looking at).
> >
> > I'm happy with (3) if Marc is.
>
> Definitely worth investigating if you have the bandwidth.

I made an attempt at it. See:

https://lore.kernel.org/20231006151547.1.Ide945748593cffd8ff0feb9ae22b79593=
5b944d6@changeid
