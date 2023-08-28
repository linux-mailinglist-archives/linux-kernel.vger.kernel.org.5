Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1884E78AA22
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjH1KTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjH1KSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:18:39 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E88120
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:18:23 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d77f869dccfso2663651276.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693217902; x=1693822702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DOlacRbCs6vM8uMvbM2eclNYLFZ94KY8m9F6JruA3Ic=;
        b=UsrTZxNov7k9QUaDvwYgehFDqB4LoTMnE0NRD+A2Z084TiMwu8g6JuXVrhzBywgLTD
         Uw6wI04GDpcD9CUVdpRlfy+w0JZAwY/5oQbXxIHPUp+JHJ70b/vBsFCD8AWgzXptY8it
         zVQwZ/IgsfOoweoQFcPecvrR6IWWBwZIkF6qp0tFhdEzah2TuT/hvIZGYu5ux1UwvQt6
         llHLHHOvtO2GzZYvrQ2VUZgHc86FyDRckidWfJfF4X2XfMNU0RTa6JrKWM0Wmxp6jeJr
         RbVdlIw1l1tVt7mgXPh0Yb3mq5qyqwBdAICYMndY42IoCiXl2lnRfMlKoTWFPTSWKzE1
         C9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693217902; x=1693822702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DOlacRbCs6vM8uMvbM2eclNYLFZ94KY8m9F6JruA3Ic=;
        b=Jf+nJP5NGpMGVieGrbg6Oa7FeC392QRQ2L2DnUc9GnSKAfhC6Fo8EPHHoIh1Zr/eC0
         0hQ3Ymoz8WEqydXo6MuFFd95gsjvwQEmPnXOCM415R0pHutd46kxhln1uLIWhNi1Fk7J
         Gj/3WI5WEg1vRMfZsDspZZd1JlfBOkEa2qmrV4UvQA98/jTtZX/81qjpRC9iaoYb/Svh
         Mv/IwcU+T6NKTf/o+0FoHwgoVb5lXLOxu+3jOxmdp1BledMXod+aS6mSr0xTHnVheoXN
         LN2LxPyNnAutmYL6Uk7x0VfxpomfxmqnLKkdOvcIkj/uoecoXVf2NUiJfUYZxBqF9b7H
         DL2g==
X-Gm-Message-State: AOJu0YwwFpQwm6OdVszBBiPIYHZcQx5k1U7jKa8i6SXaDe+oSm8ZPPTN
        MZkF6l+Mr7Ho+dugMvf9HcC1xVbkJ8yh8R2Ru0xuBQ==
X-Google-Smtp-Source: AGHT+IEg7dmgnDwLWFroAFo7rqNzxdRqAnvNFxa7XnM4E7yR/WIXPKajgzko22KeEAwSZZCmNdzb3sXOB2hknU1d7Fg=
X-Received: by 2002:a05:6902:351:b0:d77:8080:52e1 with SMTP id
 e17-20020a056902035100b00d77808052e1mr15933887ybs.3.1693217902201; Mon, 28
 Aug 2023 03:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230825213552.1646321-1-dmitry.baryshkov@linaro.org>
 <09d89b1c-8c78-7671-a385-99c6a8910fde@quicinc.com> <CAA8EJppmn5hM5=zdkQoaGAYghw822vP8YoW0wQsNmAZY0v7dtA@mail.gmail.com>
 <865y4zfppf.wl-maz@kernel.org>
In-Reply-To: <865y4zfppf.wl-maz@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 28 Aug 2023 13:18:10 +0300
Message-ID: <CAA8EJppkJ1s=yjruBm0mntGQ4NBGut2jMLFRtZr6KquA5zn+=Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] irqchip/qcom-pdc: don't read version register if it
 is not available
To:     Marc Zyngier <maz@kernel.org>
Cc:     "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 at 13:04, Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 28 Aug 2023 10:46:10 +0100,
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Mon, 28 Aug 2023 at 12:36, Maulik Shah (mkshah)
> > <quic_mkshah@quicinc.com> wrote:
> > >
> > > Hi Dmitry,
> > >
> > > This patch may be useful if there was a case where some PDCs don't have
> > > version register populated/available,
> > > In all PDC versions, version register is always available but due to reg
> > > size not good enough in device tree for SM8150 it failed to read.
> > >
> > > reg size in device node must be expanded if its too small to access all
> > > registers and i think
> > > additional check in driver to check if size is good enough would not be
> > > of much use.
> >
> > Unfortunately, it doesn't work this way. DT files are ABI. Even if we
> > change the DT, the kernel should continue working with the older
> > version.
> > Thus, we have to add such bandaid code, which will keep the kernel
> > from crashing if old DT was used.
>
> You're missing the point: all existing PDC HW have version register.
> The fact that the DT is crap doesn't invalidate this simple fact. It
> is thus perfectly possible for the driver to *ignore* the crap and do
> the right thing by expanding the size of the mapping, rather than
> falling back to the non-versioned code.

Ah. Interesting idea. If that's the overall consensus I can send v2
doing this. Not sure what is better though.

>
> There is definitely precedents for this sort of behaviour, such as the
> ARM GICv2 probe code.

-- 
With best wishes
Dmitry
