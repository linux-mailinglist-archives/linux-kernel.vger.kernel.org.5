Return-Path: <linux-kernel+bounces-147118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 575718A6FAC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1272D285E13
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F415130E4E;
	Tue, 16 Apr 2024 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dCxYMOWZ"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03836130AC7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280824; cv=none; b=ZqQmFDest8Dc1E3Pp9dBS1MRWwwvzWxDAP58GFEkoO4HzDqizzLhpiR1+XO/2MkKhWuHJgA2vUDSUm3dzf43OmmzLvAqIlROrHocIsQ+DxhsefQMkxF6XR7TZSjcjRdc86FR+ynknzmQ/M+CYEgYl2J4DlG+hmcUok2FPw6WZ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280824; c=relaxed/simple;
	bh=ogk92evleqkPuUaIzhiJjs+SO3WbwlZaxhfQYNosFdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNt0Q9KV7VFtnKtZAkJnK0c7rNQA1RgIWSo4Ulth7z75jc9w5tPKFdAYkwgDfOUMLcRkbveaBzr7O1qowHa4fRG3L2YGpYKbHxGJQ/OMscOtRqDrNZnLb3uPZy6eZIk4eA0SepViG7a9iEzLKSYwH60+BejWT+oRQGlY61oNZUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dCxYMOWZ; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso4814980276.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713280822; x=1713885622; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mMO3J/koq2VtvnAEkr+zbw/DfMlDxsEOqsgIHHsF7Fg=;
        b=dCxYMOWZLpi9SzxL82oYeoszXPlVu2T7t8nrGA8nYJLxiZHGfcZeqUGW2N2Nc0bm3a
         bk2ap5DaEJrk81YgtZYVM9Ac+yo0XyNNW5Q86MnbkgwgklZYx32jhLM2rCKZ9n5isACl
         TAjmyPrGUqhxvR5T1EhysxYFqE4nMnUpQkbL1dDgicmAq/BS2UuVSCjtUePDkT+vEkhy
         zun6F2bxPh6b08BHa/HixWddN7DXmNt6A+4HxKn5B5OwY2pFsr6c2b63JpirD1A209YS
         gz5RmufOo6AOOalk3LE0+AQVGLcgU+0SR7eeGb+j5cwGwpLWbKbx/jI8bOXaLefjRJIF
         NMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713280822; x=1713885622;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mMO3J/koq2VtvnAEkr+zbw/DfMlDxsEOqsgIHHsF7Fg=;
        b=X85MhEAGhVoeFzTl0Lnen5nGPrS/haYfxqqF9Ge55mmsHHZ7kbfqRyGjWb8knr7vZj
         5DEfvQ2XJk4SuCkXnU29LKkck6m7P96BV2TV14QUyX32VFqM2l6G2YG6Bxww5WtUgSMV
         WQ4BHwwAI2xXwDR8Wm1X6U93zEkGnvOzJqncRg59OYhaimzO6qy45scZYbjKI5SU4bBR
         MFS+qsxcsFmFD5pw5MIMNBUIM1gwVri+i7vT9mDVc28DsY32ePOpWpmkTXvKApwRaXdi
         tUePirKxBH3F6bdVQ92bRR5hsssbpfiEtqk/nNbcNWqkKhgd5B9AN0MIXgQRFSuHCT2b
         Qf+A==
X-Forwarded-Encrypted: i=1; AJvYcCX5jCJPoNHgWg8XKmYYC3l7J1bjaFYtzv+qholG338BK+zYlA6KLZf3XDCO4YHGYCUiBibej6uqdm12E1gXNTkpaiU1Jls2FX8Wgh86
X-Gm-Message-State: AOJu0YzuQ8h84L91tH7/vKR1hpD7hWjKNI1Pu6OiitGg/k81+4lElPjT
	4uvVGaWxvDIVhxIT65YA6Tm2i7IJz0KzoDiDmLdop4f/7N9/2mTWkhBBgBmcL3+zGNb5R8vmbvq
	LkKYdxtOZJwwGymNAWJpa7sG8cLdssVdwjtgll2rYDWrAgAz+VmE=
X-Google-Smtp-Source: AGHT+IEtsDJfZJ76KZn5Td8LpcHSFPRQ3TKmnwcVPVblLvXhJ7AGte9txzMCMRd181hjAL5xfz3A+oms+boqL8Xkn4s=
X-Received: by 2002:a25:8449:0:b0:dcf:b5b7:c72 with SMTP id
 r9-20020a258449000000b00dcfb5b70c72mr11140317ybm.0.1713280822073; Tue, 16 Apr
 2024 08:20:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416-ucsi-glink-altmode-v1-0-890db00877ac@linaro.org>
 <20240416-ucsi-glink-altmode-v1-2-890db00877ac@linaro.org>
 <c129b349-dfaa-4b10-9b8c-6098d04b9373@linaro.org> <CAA8EJpqH2_ENE6am=m9dtwk_+_Vbc4pZG9=Y_4-b-p0fKQ4sBg@mail.gmail.com>
 <66cd0d96-7576-4f70-b4da-b8d518253763@linaro.org>
In-Reply-To: <66cd0d96-7576-4f70-b4da-b8d518253763@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 16 Apr 2024 18:20:11 +0300
Message-ID: <CAA8EJppf9z+q4_xjQE62Vi-2BiHJpUi7mS0EMSRV_XxbGH==qg@mail.gmail.com>
Subject: Re: [PATCH 2/8] usb: typec: altmode: add low level altmode
 configuration helper
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Apr 2024 at 17:57, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 4/16/24 16:48, Dmitry Baryshkov wrote:
> > On Tue, 16 Apr 2024 at 17:32, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>
> >>
> >>
> >> On 4/16/24 04:20, Dmitry Baryshkov wrote:
> >>> In some obscure cases (Qualcomm PMIC Glink) altmode is completely
> >>> handled by the firmware. Linux does not get proper partner altmode info.
> >>> Instead we get the notification once the altmode is negotiated and
> >>> entered (or left). However even in such a case the driver has to switch
> >>> board components (muxes, switches and retimers) according to the altmode
> >>> selected by the hardware.
> >>>
> >>> We can not use existing typec_altmode_enter() / typec_altmode_exit() /
> >>> typec_altmode_notify() functions in such a case, since there is no
> >>> corresponding partner's altmode instance.
> >>>
> >>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>> ---
> >>
> >> Should this now be called from e.g. typec_almode_notify to limit
> >> duplication?
> >
> > typec_altmode_notify works only if there is an altmode->partner (which
> > we don't have with pmic-glink).
>
> Yes and this seems to be an excerpt from these functions, should they
> now drop that code and call this function instead, so as not to have
> it in the tree twice?

I thought about it, but then I abandoned this idea. The
typec_altmode_notify() has its own use case, normal altmode drivers.
It is an error to call it if there is no partner registered, etc. So I
wanted to preserve error checks in that function instead of dropping
them. The significant part of the code is shared anyway thanks to
typec_altmode_set_switches().

-- 
With best wishes
Dmitry

