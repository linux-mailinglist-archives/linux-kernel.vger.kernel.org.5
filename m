Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB4D813274
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573412AbjLNOE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573399AbjLNOE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:04:56 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08D9114
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:05:01 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5e282ec7537so22691787b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702562701; x=1703167501; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jg6+o4DsrIVctuKLZzquDKxy0KIWyG3DEzWy+09p0D0=;
        b=uyq0eYU9IWy2ggdlD4vf1zWL3eeyWfOLsX1HYfBsyCYyOCrK7msrXoowDoRelnKutJ
         V6fk1v7RbwVfvxO6kQewyYlvODda7cOjJ87vOsZCJXKoa4H6c42ZD7ZzeeGoF3yONd2y
         CMyF/E6/PcCRv2sLuJ5uMFopZLmbgYYR6Vo88ybZo6ARlYe/lE+bZss/liqjaXZVrszT
         s3iCQbYXB0wloBUBI17/BLh9TFhBeRI+vxCAHOXPHsTJIVOhNhTZEJGHXeklUsOLzahC
         7zKnIvkj/4GWQkXm3hJLrIybelEwlHEMKbEgELFNTOI5cFVPxncFtutkGbAiOPd0wNj/
         ZFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702562701; x=1703167501;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jg6+o4DsrIVctuKLZzquDKxy0KIWyG3DEzWy+09p0D0=;
        b=J537BHngpnEJxL6X4fjdOALoEj4MNes/QQ6JL0syOX+64Bm4MBOQqKEfvSR6MBXDZ7
         uEi5X0EROzh34U8tq3+ShS7eA2wye5NqAzP3u+atD1FQorVLSkEjmVrc4Um0xE1r0h6o
         eKnxBSXRvXztCv+XIXo/VUHwU39lrqrMZxGa6tuDiUevQ7bVAi8Kd3buXHSgQqlZcydx
         aq0wtH4jUKGJxDqhDrgAgo90VOtvOXP/tmcBWNw2T1TDxhBTIj/OHKOXy7tAp+jSvftO
         O5txpd17AGGb7iIFkJGvUs90+VwUV02whIQ0n86n339L0vPU1oYXhsA0clhZZhC6Fm8+
         a1Bw==
X-Gm-Message-State: AOJu0YwXWt3BeSWB/+3jhWxGidM5Fd+3cHjg5IcPSg0HGRwCMhMvU1kO
        PWPFcMlbCCoGWRlorU2RmaXuKnWuHbHwZnbliKLSYA==
X-Google-Smtp-Source: AGHT+IGpSmmLZXuBKl2fQ0FWNs06IBa00iIeuRgq5oPka6QFw5K9uddDc0PULJ5XWAfqwwY1mcHg+Pel1zShEfFWfA8=
X-Received: by 2002:a0d:d701:0:b0:5d7:1941:3582 with SMTP id
 z1-20020a0dd701000000b005d719413582mr1996340ywd.105.1702562700940; Thu, 14
 Dec 2023 06:05:00 -0800 (PST)
MIME-Version: 1.0
References: <20231213210644.8702-1-robdclark@gmail.com> <ZXqr0RFw9KsP876v@hovoldconsulting.com>
 <CAA8EJpoSvaq9imP-dT4p=4jveZyFmh=OoWOP7jWGo4OYkHQDTA@mail.gmail.com> <ZXsKzsij3Xb50Ap9@hovoldconsulting.com>
In-Reply-To: <ZXsKzsij3Xb50Ap9@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 14 Dec 2023 16:04:49 +0200
Message-ID: <CAA8EJpqBstKyAfUcBPzoF2CitTwWBZ9Xhd28Y+FCo14OoBqkxw@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: pmic_glink: Fix boot when QRTR=m
To:     Johan Hovold <johan@kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2023 at 16:01, Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, Dec 14, 2023 at 01:04:43PM +0200, Dmitry Baryshkov wrote:
> > On Thu, 14 Dec 2023 at 09:16, Johan Hovold <johan@kernel.org> wrote:
> > >
> > > On Wed, Dec 13, 2023 at 01:06:43PM -0800, Rob Clark wrote:
> > > > From: Rob Clark <robdclark@chromium.org>
> > > >
> > > > We need to bail out before adding/removing devices, if we are going
> > > > to -EPROBE_DEFER.  Otherwise boot will get stuck forever at
> > > > deferred_probe_initcall().
> > >
> > > Can please you expand on why this is a problem here in the commit
> > > message?
> > >
> > > The aux devices appear to be tore down correctly in the probe error
> > > paths so how exactly does that lead to deferred_probe_initcall() being
> > > stuck? This sounds like we may have a problem elsewhere which this patch
> > > is papering over.
> >
> > This is a known problem. Successful probes during the probe deferral
> > loop causes the whole loop to be reiterated. Creating child devices
> > usually results in  a successful probe. Aso I thought that just
> > creating new device also causes a reprobe, but I can not find any
> > evidence now.
>
> This still needs to be described in the commit message.
>
> Only a successful probe should trigger a reprobe, and when the child
> devices are registered the parent is not yet on the deferred probe list.
> So something is not right or missing here.

Child devices can be successfully probed, then the parent gets
-EPROBE_DEFER, removes children and then it goes on and on.

-- 
With best wishes
Dmitry
