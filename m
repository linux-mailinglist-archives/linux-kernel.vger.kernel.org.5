Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721997DCD46
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344345AbjJaMsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344332AbjJaMsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:48:07 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1FCBD;
        Tue, 31 Oct 2023 05:48:04 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5435336ab0bso2581587a12.1;
        Tue, 31 Oct 2023 05:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698756482; x=1699361282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cNqw8Df0KTWoMURhaCAzAC8cx2hHKx+9toGPqfTnvo=;
        b=ZNVm2DjvbWKoyNpEFKYUK5n4Kq8TVaypWsa5de0flpq0bHsN+mBftHvYfLdsjBOTG5
         QA32kZ8vV8Q8CNBQC9pU+aGsgd4hDQwpAvPf0LzHkcV0Tu3kx633hVj6Uq/ODvZAEKTY
         czkD5Jc7uxe87BqtESCMvyafTHULHxJOyBbMfEsMqLArKfWRNFrLv6tsQDW4goZ97uJb
         35RSQYr9n/l1asMfohboSEnJltr5f/Ak0iSJjrUIU+Z/N4y9faXaw5DiRIZfMml2i5yL
         MVMUJj37pavBbqmOB1VRKE2XpSWOtMv3uWy/+Ff1spfMaa6SmPL41a3FDL2LRWDxnKFl
         UBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698756482; x=1699361282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cNqw8Df0KTWoMURhaCAzAC8cx2hHKx+9toGPqfTnvo=;
        b=NSS9+EBspEkH+k5r+5eNEdCNM0PYChlWptC5jMAUXb9k1EZ7XqSF6lnvnxySTkCgv8
         4aYqPd/ZLkSeAkMa4Nw1wQXcgqC3ag6dwDtfvzErFhoN0OJhrMmTWSbcaxVoXAEdPD0c
         2bKh8bb7PzfIuS75U3YNrb43iqPjbC9y7a/OJ570Vj4Ov++Wn78DxjdEMArUyTjbVl/g
         7Jq+5PTFLWHARoEX1oGX78FXQLD+DrMv6OyPFW2ZFJixNiq47UBY+DFSrRl11dIqBQF1
         iMJLWTIR1CRB2JGuBhD7Z+2I6qvGUPj7p8qov5pozhiZHmgbjp9xeDvA47mwEnHjvOnl
         Y+Rw==
X-Gm-Message-State: AOJu0YyVhfiWY/paojfYqhBjppJY1hEdGVv1QrJfOM0i3flrz5tB+dui
        zowfbjxfqHoywh615RZf4VK6AUTwYUS/biI5CdI=
X-Google-Smtp-Source: AGHT+IGVYTmlrcy3cyujyUR5gC38iHICEwPtr+8Fv7clqc1AJi3ujCuVZwvc9Nwklhufs/zB+XLxdEfC0RHj5wlrdBo=
X-Received: by 2002:a17:906:4784:b0:9ba:65e:7529 with SMTP id
 cw4-20020a170906478400b009ba065e7529mr11702882ejc.68.1698756482355; Tue, 31
 Oct 2023 05:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231030-sc8280xp-dpu-safe-lut-v1-1-6d485d7b428f@quicinc.com> <ZUD0lhStirf8IN8-@hovoldconsulting.com>
In-Reply-To: <ZUD0lhStirf8IN8-@hovoldconsulting.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 31 Oct 2023 05:47:50 -0700
Message-ID: <CAF6AEGs9PLiCZdJ-g42-bE6f9yMR6cMyKRdWOY5m799vF9o4SQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: Add missing safe_lut_tbl in sc8280xp catalog
To:     Johan Hovold <johan@kernel.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@chromium.org>
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

On Tue, Oct 31, 2023 at 5:35=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Mon, Oct 30, 2023 at 04:23:20PM -0700, Bjorn Andersson wrote:
> > During USB transfers on the SC8280XP __arm_smmu_tlb_sync() is seen to
> > typically take 1-2ms to complete. As expected this results in poor
> > performance, something that has been mitigated by proposing running the
> > iommu in non-strict mode (boot with iommu.strict=3D0).
> >
> > This turns out to be related to the SAFE logic, and programming the QOS
> > SAFE values in the DPU (per suggestion from Rob and Doug) reduces the
> > TLB sync time to below 10us, which means significant less time spent
> > with interrupts disabled and a significant boost in throughput.
>
> I ran some tests with a gigabit ethernet adapter to get an idea of how
> this performs in comparison to using lazy iommu mode ("non-strict"):
>
>                 6.6     6.6-lazy        6.6-dpu         6.6-dpu-lazy
> iperf3 recv     114     941             941             941             M=
Bit/s
> iperf3 send     124     891             703             940             M=
Bit/s
>
> scp recv        14.6    110             110             111             M=
B/s
> scp send        12.5    98.9            91.5            110             M=
B/s
>
> This patch in itself indeed improves things quite a bit, but there is
> still some performance that can be gained by using lazy iommu mode.
>
> Notably, lazy mode with this patch applied appears to saturate the link
> in both directions.

Maybe there is still room for SoC specific udev rules so dma masters
without firmware can be configured as "lazy", ie. like:

https://chromium.googlesource.com/chromiumos/overlays/board-overlays/+/refs=
/heads/main/baseboard-trogdor/chromeos-base/chromeos-bsp-baseboard-trogdor/=
files/98-qcom-nonstrict-iommu.rules

BR,
-R

> Tested-by: Johan Hovold <johan+linaro@kernel.org>
>
> Johan
