Return-Path: <linux-kernel+bounces-6496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE978199A7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A93282421
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D20C1642F;
	Wed, 20 Dec 2023 07:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MvhJHkJR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E3D1D520
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5e734251f48so3987317b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703057869; x=1703662669; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4wEy7aKZB6aXhf/1YBwq1yRA/BeCIlX1y23vgvuPgWw=;
        b=MvhJHkJRIeAKqOOgWypXF708UzfH1UEx39lOtK8Reae7w4ca7T76EcXCOH3cdCMJEk
         txEgJCavscXcmsuLB0VbJGIu4NMJJGnxrefMCP202YgBYULmVfWAGI2J/QLNGUVGRfHV
         yUKLVj8ak1Tns7HWnqsoCuoF3MJ+pmMI8i4T2cN+1nR3mitpSi8VpLnK57FMzxJ2acOR
         TT3xSP5HFX1G0FNw/3Nhc46uo6WSpL02VIQU2Zyi+Xf5Y4QOd2ZBvgduKtPxiH1z0U+X
         IzWtvb5DENMCcTRmbkUguwmCwtZWUZvrYSJh39XVoeSrKb+3fKACN7AxZ2YkUor2uZeO
         ekYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703057869; x=1703662669;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wEy7aKZB6aXhf/1YBwq1yRA/BeCIlX1y23vgvuPgWw=;
        b=KFlMpgKru36UzaQVOJjX2Wj6vSF/6t/XRmP3vq6R7jAa6s/NG+2HXg6OtxTKEKfEKX
         AFFr5Q/jtmZlMD21B12TKvEfy7GzxR4iEf4Xk7nLma4eAkyovCxQR2O7xM3iYkSJcWxr
         XwFoBNw272M++TilfO+pGsVTxqaLswPhR6mwy5hb4qKQaQBSdF0HCe87nz0kXDvKTNjh
         9eoYCGLIxpWRcUjg1NkY8jbUP9hCYOCfVaKO29wHKS+DmZZCh2dVY5HJ3mTostEAWGf+
         JAoOsHpkPeighM+Zk9EuDQa3GYPUYQrdpMgT1/98iQjlOrjFzFvAoa8Z35NRdsyG1kP7
         7mDQ==
X-Gm-Message-State: AOJu0YyDO/14S8WbbvUiBnmnBwrVHg6IC/GpHCnN3ib1jk2pdTu84zhF
	By9ikujusLC6pORs5UAnR7QalEqO/QdGRbJmpEiZRA==
X-Google-Smtp-Source: AGHT+IGR7yLin4e6j26Ca0diNkMq+UpXkjGay37wddrKam/6iQT1PLWaB6BjjU606OEKywmSjK8vjFHclLMr6S1uNB8=
X-Received: by 2002:a81:4ed6:0:b0:5e4:e8e4:4aa6 with SMTP id
 c205-20020a814ed6000000b005e4e8e44aa6mr1494439ywb.44.1703057869130; Tue, 19
 Dec 2023 23:37:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <a033dfc5-dcf1-4969-ad4d-1836ff9ff0a3@linaro.org> <d0ea23ae-8fba-d229-b0f6-dc522f285233@quicinc.com>
In-Reply-To: <d0ea23ae-8fba-d229-b0f6-dc522f285233@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 20 Dec 2023 09:37:38 +0200
Message-ID: <CAA8EJpouBOLJ_1Pz_YauuOX+97ud9RkLYRaui4GM6ZFJUKYJMw@mail.gmail.com>
Subject: Re: [PATCH v2 00/34] Qualcomm video encoder and decoder driver
To: Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Dikshita Agarwal <quic_dikshita@quicinc.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stanimir.k.varbanov@gmail.com, 
	agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, 
	mchehab@kernel.org, bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org, 
	quic_abhinavk@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Dec 2023 at 08:32, Vikash Garodia <quic_vgarodia@quicinc.com> wrote:
>
> Hi Dmitry,
>
> On 12/19/2023 12:08 AM, Dmitry Baryshkov wrote:
> > On 18/12/2023 13:31, Dikshita Agarwal wrote:
> >> This patch series introduces support for Qualcomm new video acceleration
> >> hardware architecture, used for video stream decoding/encoding. This driver
> >> is based on new communication protocol between video hardware and application
> >> processor.
> >
> > This doesn't answer one important point, you have been asked for v1. What is the
> > actual change point between Venus and Iris? What has been changed so much that
> > it demands a separate driver. This is the main question for the cover letter,
> > which has not been answered so far.
> >
> > From what I see from you bindings, the hardware is pretty close to what we see
> > in the latest venus generations. I asssme that there was a change in the vcodec
> > inteface to the firmware and other similar changes. Could you please point out,
> > which parts of Venus driver do no longer work or are not applicable for sm8550
>
> The motivation behind having a separate IRIS driver was discussed earlier in [1]
> In the same discussion, it was ellaborated on how the impact would be with
> change in the new firmware interface and other video layers in the driver. I can
> add this in cover letter in the next revision.

Ok. So the changes cover the HFI interface. Is that correct?

> We see some duplication of code and to handle the same, the series brings in a
> common code reusability between iris and venus. Aligning the common peices of
> venus and iris will be a work in progress, once we land the base driver for iris.

This is not how it usually works. Especially not with the patches you
have posted.

I have the following suggestion how this story can continue:
You can _start_ by reworking venus driver, separating the HFI /
firmware / etc interface to an internal interface in the driver. Then
implement Iris as a plug in for that interface. I might be mistaken
here, but I think this is the way how this can be beneficial for both
the video en/decoding on both old and new platforms.

Short rationale:
The venus driver has a history of supported platforms. There is
already some kind of buffer management in place. Both developers and
testers have spent their effort on finding issues there. Sending new
driver means that we have to spend the same amount of efforts on this.
Moreover, even from the porter point of view. You are creating new
bindings for the new hardware. Which do not follow the
venus-common.yaml. And they do not follow the defined bindings for the
recent venus platforms. Which means that as a developer I have to care
about two different ways to describe nearly the same hardware.

> Again qualcomm video team does not have a plan to support sm8550/x1e80100 on
> venus as the changes are too interleaved to absorb in venus driver. And there is
> significant interest in community to start validating video driver on sm8550 or
> x1e80100.
>
> [1] https://lore.kernel.org/lkml/8c97d866-1cab-0106-4ab3-3ca070945ef7@quicinc.com/
>
> Regards,
> Vikash



-- 
With best wishes
Dmitry

