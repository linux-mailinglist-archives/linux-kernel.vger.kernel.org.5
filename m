Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC067A9D3E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjIUTaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjIUT3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:29:44 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC1FACD1B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:02:44 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6910ea9cddbso942570b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695319364; x=1695924164; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vWFU9+92AYyGMCA99CDBDorNnlMqG7zRdUzXQ1eXTkk=;
        b=UyJ82Ld5H56IryckCbm8FdC+mCSEzv2jBM8ufh9zau3QZTWTfi0+lWMNLapeTZcDNX
         CG0TSISERHw0diizTn/8iBPho9Qhe73fvt6EtenRbKRSnx/dGnEDacYz6vGW+zTWrp+N
         pfSloMcpiCUK12PfTWvoXo1T5KU0i730VCkwFhCZx4drd7Nq34kJ5jOfL64ZPQZNazv9
         VXdCFrKulfygrIj4xa0WKQNjHqShsimkfZeSm3kG8AZLCK6lkXU/UCxQyaFw3xrj3Vmd
         WDZ7uHqGsixQVm0g90Lf8PjhDWIWRNssyQP/O79thPdkfuuQygvEAknjyMYBpR+tP1oE
         uiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319364; x=1695924164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vWFU9+92AYyGMCA99CDBDorNnlMqG7zRdUzXQ1eXTkk=;
        b=CJ+7RYL90GY7D4EDkNyynzz0drreYFijgorZZI5IxPhnvBNJkrO/mxd3aATLRBte1S
         az/4KXep6mnjqQLM8jw7n63yoscKpfLZ0q5dYKm2t34FD2xzHG099i28O3amTentE73w
         SqhHYAR3rKknru0AwD1p/Uiwnal1cMmd0i8vgHNoeIGiukwWphwGmVOuRmA+lWRG6NdK
         lJt0QWL24vCPaSsHNiaUYhS3LvVh0JLrKzYlhSTOBJLL13kTc7UPfGa8UQ+XMEYxOH/Y
         f+zIQ5oXDFzUD00CB4V2MCiQJv0SeAFoqpHCHpKplIfJYKekD4WzPLgLkrnWahYzDETI
         VWtQ==
X-Gm-Message-State: AOJu0Yxl0/8PQNxrGIcl/xXEnZ3A6TIDyY5PNVhS9/My7cusRAWoQJjA
        KUp46HjbtCG0oURJ0/aWydjtOHxPYWYYK7Lryjnh7H5reERpJYli0wKjRQ==
X-Google-Smtp-Source: AGHT+IHJxqgLJEndMmGqkfQ92766qN8ENU8GmtSr+RVPCuctnkalJLmRsrmNuPCC5CHKCSgb8HOSlhgw01Ml85LsKBc=
X-Received: by 2002:a0d:d650:0:b0:59c:6ef:cd55 with SMTP id
 y77-20020a0dd650000000b0059c06efcd55mr5567040ywd.8.1695308009156; Thu, 21 Sep
 2023 07:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230911161518.650726-1-vignesh.raman@collabora.com>
 <a411b3fe-6222-4c86-8d71-afa992ea2f93@collabora.com> <29e47c3e-e10d-9268-93c7-133c959c5a82@collabora.com>
In-Reply-To: <29e47c3e-e10d-9268-93c7-133c959c5a82@collabora.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 21 Sep 2023 17:53:18 +0300
Message-ID: <CAA8EJpo13qR5hcjvQvfSwEPNPn2bj-T-qUHFgfcChqD1N588eg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: apq8016-sbc: Add overlay for usb host mode
To:     Vignesh Raman <vignesh.raman@collabora.com>
Cc:     Helen Koike <helen.koike@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
        daniels@collabora.com, emma@anholt.net, robdclark@gmail.com,
        Maxime Ripard <mripard@kernel.org>,
        David Heidelberg <david.heidelberg@collabora.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sept 2023 at 17:01, Vignesh Raman
<vignesh.raman@collabora.com> wrote:
>
> Hi maintainers,
>
> On 12/09/23 22:39, Helen Koike wrote:
> >
> >
> > On 11/09/2023 13:15, Vignesh Raman wrote:
> >> Due to the presence of the fastboot micro cable in the CI farm,
> >> it causes the hardware to remain in gadget mode instead of host mode.
> >> So it doesn't find the network, which results in failure to mount root
> >> fs via NFS.
> >
> > Just a context for others, this was part of this patch series
> > https://lore.kernel.org/r/20230908152225.432139-1-vignesh.raman@collabora.com
> >
> >>
> >> Add an overlay dtso file that sets the dr_mode to host, allowing the
> >> USB controllers to work in host mode. With commit 15d16d6dadf6
> >> ("kbuild: Add generic rule to apply fdtoverlay"), overlay target can
> >> be used to simplify the build of DTB overlays. It uses fdtoverlay to
> >> merge base device tree with the overlay dtso. apq8016-sbc-usb-host.dtb
> >> file can be used by drm-ci, mesa-ci.
> >>
> >> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >> Suggested-by: Maxime Ripard <mripard@kernel.org>
> >> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> >> Signed-off-by: David Heidelberg <david.heidelberg@collabora.com>
> >> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> >
> > Acked-by: Helen Koike <helen.koike@collabora.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> >
> >
> >> ---
> >>   arch/arm64/boot/dts/qcom/Makefile                  | 4 ++++
> >>   arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtso | 8 ++++++++
> >>   2 files changed, 12 insertions(+)
> >>   create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtso

-- 
With best wishes
Dmitry
