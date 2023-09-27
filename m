Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239517B0EBE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 00:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjI0WCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 18:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjI0WCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:02:03 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF657194
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 15:01:58 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-504b84d59cbso1467325e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 15:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695852117; x=1696456917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSjejR5JF3wP/eMQJYeeQ3/RdpG//Fx9fX4rCgiiwsA=;
        b=nA1MPKGhAJBCTrEnASX1o3wwHSDH3cO7zZokWQCm61ftStt8KJlPtUQpkOrcsMeVT2
         J83k8ko1v5Qu6jWhsq+BONEG2J44sG3uu3wWSulnjB6OCj0HZl04K0ZsSXe8dwHrE+TE
         glkT00cvZKpeGjUjX1PC6WAr1YZwKtRFcJMaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695852117; x=1696456917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oSjejR5JF3wP/eMQJYeeQ3/RdpG//Fx9fX4rCgiiwsA=;
        b=ZwW/JCSXrTqV50BMRAhPQLtcx2R/RIXhnMPSlOX7/W7sROzBm2C88pXMl8cp488vbi
         79kq+AcJgB9GPT+m8c3hTK6wkZ86TJ+C+HWUuGtOJ08w866o2O6KHi64+Ff48+u5uxJT
         1763Ienn+plyh2jb0pY1Ma+o885DbUABTV87XSjmBPJnK4XtunYeQ8fp99Lgpt4L+iJw
         avUTCUkxELitY2PAeUwrBTD96CINyKg0vQz6MtvitKzcbLlsmfunVAJYQL96+FZ0x1sz
         NvyoflWlVo0W4Sj2NbekuCjhloHczaWgjah8AUliO3ZZ3z1m1LglMG8qOMetdOzVrsyg
         A3jQ==
X-Gm-Message-State: AOJu0YwKgyez/upawoNP9RqGmpNPSpeuSUp+XMrQvOr0MXA75WElcsEU
        3HJtmn8oZc6Ew6SLTFq/NGk3TyDSeMO+HqVyCXtY5w==
X-Google-Smtp-Source: AGHT+IEgoSwtXUeWp+41zOUCP+Gyi7NJVp2syU0i8Hpe8Zg2aPjEvc03dD/eiB9Gw5SnGn3VLWFNtVmb2S4r5fJtUcI=
X-Received: by 2002:ac2:410e:0:b0:502:f740:220 with SMTP id
 b14-20020ac2410e000000b00502f7400220mr2552704lfi.58.1695852116130; Wed, 27
 Sep 2023 15:01:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Sep 2023 17:01:55 -0500
MIME-Version: 1.0
In-Reply-To: <1d9bf80d-0267-937b-4dd9-c57db7a89cb4@quicinc.com>
References: <1694813901-26952-1-git-send-email-quic_khsieh@quicinc.com>
 <1694813901-26952-7-git-send-email-quic_khsieh@quicinc.com>
 <CAA8EJpqPXoFX4LXyXYgfh07Vpxg-KgD8VBR6x5bXf4GOJmbOtw@mail.gmail.com>
 <2f98d5f1-57c1-d9fe-cb1c-b975db057287@quicinc.com> <CAA8EJpr2wRq6Txi7YAQpJKa_9UGqH_nmHzvVOaAPkwOrtDg4Tw@mail.gmail.com>
 <CAE-0n53dqHONzMTd_ZC-fKWTzDVq6Wqwo4OFZMUcghZ5SD5RhA@mail.gmail.com>
 <65566a68-3510-2e5f-7d57-e4dba08c008c@quicinc.com> <1d9bf80d-0267-937b-4dd9-c57db7a89cb4@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 27 Sep 2023 17:01:55 -0500
Message-ID: <CAE-0n51Hrs66oG4NF5rDETkVO-ocG_6_=Aqc5cE-qPDViSgKyA@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] drm/msm/dp: add pm_runtime_force_suspend()/resume()
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, dianders@chromium.org, vkoul@kernel.org,
        daniel@ffwll.ch, airlied@gmail.com, agross@kernel.org,
        andersson@kernel.org, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2023-09-25 09:07:18)
>
> On 9/22/2023 6:35 PM, Abhinav Kumar wrote:
> >
> > Doing link training when we get hpd instead of atomic_enable() is a
> > design choice we have been following for a while because for the case
> > when link training fails in atomic_enable() and setting the link
> > status property as you mentioned, the compositor needs to be able to
> > handle that and also needs to try with a different resolution or take
> > some other corrective action. We have seen many compositors not able
> > to handle this complexity. So the design sends the hotplug to usermode
> > only after link training succeeds.
> >
> > I do not think we should change this design unless prototyped with an
> > existing compositor such as chrome or android at this point.
> >
> > Thanks
> >
> > Abhinav
>
>
> We did perform link training at atomic_enable() at eDP case since we can
> assume link training will always success without link rate or link lane
> being reduced.
>
> However for external DP case, link training can not be guarantee always
> success without link rate or lane being reduced as Abhinav mentioned.
>
> In addition,=C2=A0 CTS (compliance test) it required to complete link
> training within 10ms after hpd asserted.

Is it possible to change that timeout? I have to look around for the CTS
parameters because I'm pretty confused how it can work. What do we do if
DP wakes the system from suspend and asserts HPD? We need resume time to
be < 10ms?  That's not realistic.

>
> I am not sure do link training at atomic_enable() can meet this timing
> requirement.
>

At least in the DP spec itself it doesn't require the link to be trained
within 10ms of HPD being asserted. Instead it simply recommends that the
OS start configuring the display promptly after HPD is asserted, e.g.
within 100ms. There's some strict timing on IRQ_HPD, so the driver must
read DPCD registers within 100ms of IRQ_HPD rising edge; maybe that is
what CTS is checking for?

TL;DR: I don't see why CTS should stop us from link training in
atomic_enable(). It would be beneficial to do so to make eDP and DP the
same. It would also help to report a drm connector being connected
_before_ link training so that userspace knows the link itself is the
bad part of the equation (and not that the DP connector looks
disconnected to userspace when in fact it really is connected and the
monitor is asserting HPD, just the link training failed).
