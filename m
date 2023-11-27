Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469D37FA226
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbjK0OOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbjK0OMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:12:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B5B2D5E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:03:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12D1C4AF73;
        Mon, 27 Nov 2023 14:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701093816;
        bh=KCZKisXR1n78+RfI83KrbOl2Cm27WXfa6iz/K1QPJPo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a2aOf09I75DdKUvvNJhSkD9GQ6WGBE1jrWs9pDpOCpwNhS0TbxHWoRRSn9ck5Mhc+
         gZca7EfxNyQp1inBZAfRqD47gcVR/2j2P6kSPCkih7i49cwEZ7pOo/irs5zW0XlMiF
         9t3wBImUkMRmLnPX2jf+oEXtdtP3HdA2v5iDopicDPaZiELC/QCHIid2KwS9yeW8Yk
         sDtIdNfLMQ2+8k4BxzPSCP/qhcQirHg9eszKNpXUSGX6VzAN3kehB6MI8Qj+xuPUcx
         pQuQyJsiwfL3/G2Nx7qvojox0+j3lTPPcUWpxZDJzU/NZmi7fMpyxZ2ILAb/+cKK1F
         d3or7UmfDwFkA==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50943ccbbaeso5863772e87.2;
        Mon, 27 Nov 2023 06:03:36 -0800 (PST)
X-Gm-Message-State: AOJu0YzKhEgsCPjAFuBPAKg2p3Slb4kxARX4ofB65cuZ1KNRZXMMxL6X
        cxHKF5Lr8XxvaH6WIGu5pOTim5HmUO/Pp39UpA==
X-Google-Smtp-Source: AGHT+IHHn/0tbob/Zvt/F/xavRxwGiGH47uaym2qWQ3/Wvw2D2ahyijP+Gg34c/5ffttsPErtLGmPrZcuMVpkTAoeU0=
X-Received: by 2002:a19:7514:0:b0:4fb:9168:1fce with SMTP id
 y20-20020a197514000000b004fb91681fcemr7182211lfe.59.1701093814870; Mon, 27
 Nov 2023 06:03:34 -0800 (PST)
MIME-Version: 1.0
References: <20231122-dtc-warnings-v2-0-bd4087325392@kernel.org> <CAK7LNASVMjVg4dr=KdSDHwGww_47H78H7rMXA=wf+ncugesDSA@mail.gmail.com>
In-Reply-To: <CAK7LNASVMjVg4dr=KdSDHwGww_47H78H7rMXA=wf+ncugesDSA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 27 Nov 2023 08:03:22 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+N0GxwZ2YmspEzfiuGOw7M+DmYkyhLgaYtk+Ov2ycY_A@mail.gmail.com>
Message-ID: <CAL_Jsq+N0GxwZ2YmspEzfiuGOw7M+DmYkyhLgaYtk+Ov2ycY_A@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] kbuild: Per arch/platform dtc warning levels
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Conor Dooley <conor@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 1:39=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Thu, Nov 23, 2023 at 7:12=E2=80=AFAM Rob Herring <robh@kernel.org> wro=
te:
> >
> > This series adds support to set the dtc extra warning level on a per
> > arch or per platform (directory really) basis.
> >
> > The first version of this was just a simple per directory override for
> > Samsung platforms, but Conor asked to be able to do this for all of
> > riscv.
> >
> > For merging, either I can take the whole thing or the riscv and samsung
> > patches can go via their normal trees. The added variable will have no
> > effect until merged with patch 2.
> >
> > v1:
> >  - https://lore.kernel.org/all/20231116211739.3228239-1-robh@kernel.org=
/
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
>
>
> There were some attempts in the past to enable W=3D1 in particular subsys=
tems,
> so here is a similar comment.
>
> Adding a new warning flag to W=3D1 is always safe without doing any compi=
le test.
>
> With this series, it would not be true any more because a new warning in =
W=3D1
> would potentially break riscv/samsung platforms.

The difference here is the people potentially adding warnings are also
the ones ensuring no warnings.

> Linus requires a clean build (i.e. zero warning) when W=3D option is not =
given.

Linus doesn't build any of this AFAICT. We are not always warning free
for W=3D0 with dtbs.

Rob
