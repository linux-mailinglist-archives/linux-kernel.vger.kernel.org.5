Return-Path: <linux-kernel+bounces-56254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED93F84C7F7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E82C1C22683
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6287E2374A;
	Wed,  7 Feb 2024 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ky96FDE7"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE96222F1E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299515; cv=none; b=GB62To91a2xNpeyVzlgq3gXtLcfytFMMLSF/QezhLSxRPAvnkM3YHQRcfIvHpOSYMklW33m1U0tsWovV26h/JO6ukTs0HD8m7U/5JZ8tOuHDCJQB7Hny2OIjRahI8fAURlwZBBXT0JsibC49maiD9sh3QwjZHWIki/atPxXYMp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299515; c=relaxed/simple;
	bh=KR2sG7J4c3ofHOmeepSU9gMmPKLoScOYxX43x3M1eFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVpJQtF8dPyXhBYdRK7blpKXE2cgZnFRn3TIK2UWZJILBaC2BD3tLtkGrd1imrlZiIDW+eFpW2ESALcC7NH8krvLQ14fahBGCmPxsgSyCXiC9A7bZzcWFXCQEdRYCHjqtzFdPuxEGI2JA0DH0umJYXh0N4jU1OUa2IdlfW1X25w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ky96FDE7; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-604966eaf6eso1963327b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707299512; x=1707904312; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tL/r8AXFGxGMMcyM8KcarAKkFwTyeEeSx1AZSjKfuYU=;
        b=ky96FDE7ziHgnLqlev77pd2UHXgEW/4rprecDW8MHgXeQm1ekDj+ud4MYzDUSCQKYf
         hphTkXd/Dv8GneMsGkuv3lli+ylZ1o6efp3GBgg012nkDM4a0FqkgIrX4PDf3oyPlVlk
         4KcXLYiUcGaYQC9wULjrHWmkEjyaFXTsbOalkZx7ZXTzQJFh9OIVRT+xiaIbhpdSy5Ro
         za7r+XDZz8hp7etUYtCPzIHrruOHzj1Q6GdtfNGOYlsK9UwJzMO5Osk0LHs6mI1ui5dH
         WYABlA5yxnPulYmBONbLUZ9A7CpPEv8Rckyi3xCOj1pOGm8vIaUMhBsJzdZiZ3/cSaTY
         p6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707299512; x=1707904312;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tL/r8AXFGxGMMcyM8KcarAKkFwTyeEeSx1AZSjKfuYU=;
        b=UWAaTNxxuE7ZQFW0q/8VLtRvyb8B0SgkidJmGvBeVcsnS2LuvHCRLMRH/yhkNDpA1p
         8LdY2lUYReUv48moZoohaGdwz28HZytOvHPB1Wt/qD1LAQONL1AbHDvIvmIB+X1EHnv3
         4LnNfq7KSzc8pYihbAvOCQ1h+5yygCe9G1Ywdk4/XsCXmZE5HJfobZKjU8aG8BHog6uq
         gVtPrFdT54ve4gx1SMaYA4JjpOmqDIxnwhO8sVThD1LbQwyjpFe9jH3NKBOhsyzhVUqL
         FRG3pWlbehBfFA5UZc62rJ92unjjF8UI6nvPrEDrDOQYslUVsWN2L/4xuweOytYrlPez
         2X9g==
X-Gm-Message-State: AOJu0YzQxXPCutwACLY3ss/TwJI+1hdJAjzP2CE8HCSNzu/xiaVV1yiL
	/SCS96X2S0dioS61zPPiKK2fqhk3IUbKTXv+Bs1bkiEX7B69Ztu2PcYIKOqaulpVvbD3UIq1MVo
	KbDUgkVKiJ0IRkMTGdWmkYCykUZvw1M1JmBOfwA==
X-Google-Smtp-Source: AGHT+IHijGzj8uRjINoynUtKvsODzePDZYI2IRClC5jIBfJbvgeat7fp8n2svTrjS5gczDAdT1OcKNi6CZuwYdJnwps=
X-Received: by 2002:a81:cf08:0:b0:604:5415:b204 with SMTP id
 u8-20020a81cf08000000b006045415b204mr3872325ywi.33.1707299512595; Wed, 07 Feb
 2024 01:51:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202064039.15505-1-quic_ekangupt@quicinc.com>
 <d8e32f3d-1658-4dcd-a1dd-e37b664986ae@linaro.org> <41703424-f711-420e-bcb8-290f68a0aec9@quicinc.com>
In-Reply-To: <41703424-f711-420e-bcb8-290f68a0aec9@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 7 Feb 2024 11:51:41 +0200
Message-ID: <CAA8EJpqB4OG1n9maGuwo4BLRPctD6-nHJBvzauxoodS_Xji86g@mail.gmail.com>
Subject: Re: [PATCH v1 00/16] Add missing features to FastRPC driver
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: neil.armstrong@linaro.org, srinivas.kandagatla@linaro.org, 
	linux-arm-msm@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Feb 2024 at 10:30, Ekansh Gupta <quic_ekangupt@quicinc.com> wrote:
>
>
> On 2/2/2024 1:41 PM, neil.armstrong@linaro.org wrote:
> > Hi,
> >
> > On 02/02/2024 07:40, Ekansh Gupta wrote:
> >> This patch series adds the listed features that have been missing
> >> in upstream fastRPC driver.
> >>
> >> - Redesign and improve remote heap management.
> >> - Add static PD restart support for audio and sensors PD using
> >>    PDR framework.
> >> - Add changes to support multimode invocation ioctl request. This
> >>    ioctl call facilitates multiple types of requests from user including
> >>    CRC check, performance counters, shared context bank usage, etc.
> >>    This series also carries patch to save and restore interrupted
> >>    context.
> >> - Add early wakeup support to allow DSP user to send early response
> >>    to CPU and improve fastrpc performance.
> >> - Add polling mode support with which driver polls on memory to avoid
> >>    CPU from going to low power modes.
> >> - Add notifications frameworks to provide users with the DSP PD status
> >>    notifications.
> >> - Add a control mechanism to allow users to clean up DSP user PD
> >> - Add wakelock management support
> >> - Add DSP signalling support
> >> - Add check for untrusted applications and allow trusted processed to
> >>    offload to system unsigned PD.
> >
> > Could you precise:
> > - Which workload are you fixing
> > - Which platforms are concerned
> > - Which platforms were tested
> >
> 1. This patch mostly consists of missing features from fastrpc driver and it doesn't
> carry any bug fixes.
> 2. We are not targeting these changes for any specific platform. These features are
> applicable for most of the recent platforms .

Please define 'recent'. The upstream kernel supports a wide set of
platforms. We have fastrpc supported since msm8916. Please make sure
that your patches will not break on such platforms.

> 3. These changes were tested on SM8650 and QCM6490 platforms.
>
> > So far I've been trying to run the "getserial" on SM8550-QRD and
> > SM8650-QRD without
> > success, would those changes fix this ?
>
> Can you please help me with the "getserial" failure details? Or the steps that you are
> running to get to the failure? I can have a look at that to understand the reason for
> failure.
>
> > Is there any chance we could get an open-source minimal implementation
> > of a fastRPC SDK using
> > the open-source Hexagon LLVM like we have for the AIC100 ?
> > It would definitely help validating the upstream fastRPC implementation.
>
> Generally Hexagon SDK is used to write and test fastRPC use-cases which is well documented.
> Is there anything else that you can suggest would help here?

Hexagon SDK is a closed source toolkit. Both in terms of toolchain,
library code and generated code.
The fastrpc_shell_N, which is used to handle loaded code, is also
closed source. As such, it is nearly impossible to verify the code.
Please consider the requirements for the drivers/accel/ subsystem: to
have complete open source userspace. Qualcomm AIC100, for example,
fulfills those requirements.

>
> >
> > Thanks,
> > Neil
> >
> Hi Neil, added my comments.
>
> --ekansh
>
> >>
> >> Ekansh Gupta (16):
> >>    misc: fastrpc: Redesign remote heap management
> >>    misc: fastrpc: Add support for unsigned PD
> >>    misc: fastrpc: Add static PD restart support
> >>    misc: fastrpc: Add fastrpc multimode invoke request support
> >>    misc: fastrpc: Add CRC support for remote buffers
> >>    misc: fastrpc: Capture kernel and DSP performance counters
> >>    misc: fastrpc: Add support to save and restore interrupted
> >>    misc: fastrpc: Add support to allocate shared context bank
> >>    misc: fastrpc: Add early wakeup support for fastRPC driver
> >>    misc: fastrpc: Add polling mode support for fastRPC driver
> >>    misc: fastrpc: Add DSP PD notification support
> >>    misc: fastrpc: Add support for users to clean up DSP user PD
> >>    misc: fastrpc: Add wakelock management support
> >>    misc: fastrpc: Add DSP signal support
> >>    misc: fastrpc: Restrict untrusted apk to spawn privileged PD
> >>    misc: fastrpc: Add system unsigned PD support
> >>
> >>   drivers/misc/fastrpc.c      | 1949 +++++++++++++++++++++++++++++++----
> >>   include/uapi/misc/fastrpc.h |  112 ++
> >>   2 files changed, 1844 insertions(+), 217 deletions(-)
> >>
> >
>


-- 
With best wishes
Dmitry

