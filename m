Return-Path: <linux-kernel+bounces-129969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5048972A8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503D01F21575
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1EC43AB6;
	Wed,  3 Apr 2024 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EblNiMH5"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF81433C1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154745; cv=none; b=V9Or9zTklq4b+EfDote/sm1Ep7N4esrRt0luw3i0P93huetbuPdzRfpYLKROLrY61PPBVUgFLcFdiSvc3s0osRElJI9UDzGnnaqlt3uiU2h4EqiZBlbh0BlhFuoDBKUbDjZFG4B34dXtPMXNRMAJKYsd/F53oX4im6HKstUAj/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154745; c=relaxed/simple;
	bh=aipPs+nNO2Bho5jPcYvxXCxYtS5rlWyrH/B5Kl5LKTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzBA8KOMvbF8PVPCAR+u9ZO9UOZii0kPWHU/aVOS3z20Eos4yBK7+wxZEIxDVXImoSufLPM7ewkXBjRQGT9hSdYZJk8oxu4fxxJ3GIIdAOhod0eIrFZo+iPlWbbI5RTXg7viEhT8giwQfsWrzN4Qv1/AfnEskzdz5bMLGXeqvaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EblNiMH5; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6157c30fbc9so3409537b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 07:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712154743; x=1712759543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34CSkv0ffEjJCmKkTU1MygJJn6kuTYj1aCVEbSSRxPA=;
        b=EblNiMH5l8EgC02lIbwS5FjXf1LFOG0qTTbXEn+bbZoFVgj3NdjO5FBBEG5XK1h/m8
         GOlw7Xjzj/L+Kq9zo12noOv2ls4agJVOPJxNolzHVV973/U5kpLP2kZfaAaHoORG+Ks3
         kNNt0KrklA1ui4B60kfShEs0gFNFrJUNvpq7QFEmOfVk8Bvb94M1u8ZaAU27uPtpOb/g
         JX4lV4wu2a5wFIrl75S3dt690GzMg/qHWdJW+PenGawFinFsAxTAftvc8iQbnHBYVxau
         etfBj6IKjmI6lzKIC5Pw4INxUk1v/l4qMPCBr4VJj0zIyY9JdwIrUAivx+oV0kZ6lc43
         j9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712154743; x=1712759543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34CSkv0ffEjJCmKkTU1MygJJn6kuTYj1aCVEbSSRxPA=;
        b=b7esb2MPsnLrUK4V/m/sbBkGe/NPYdkb4DJ+kSlSNT8V3TSF2FZIzhWWrYPCKip0hL
         qK0DWLqgyoUKPc4GUMx3Id3W4mT1pSW+zsjBHDxaGixJidBbJnF0YQDJdPVdwfvT74CL
         aZD4h9/8A/IN/Asup/5vayUtkAeulKRazZlJKG/YlgaTmqnpiVw26r+1ALwMzBb4/MvW
         PaXpzc4fnG5iJehcFoge4dFem7Qa+cFb5BI8HGpyyNSQb7yXlmIdLF2D+nEZtDTMI1gF
         K4NFZlHCmnb5W2QmlHdPWUBI7pqx2lM+McaPN2qWQyQybVTyOWzYJrUxGRdTd4djFUN4
         sO/A==
X-Forwarded-Encrypted: i=1; AJvYcCVq+W4AEaWMgiJ7+Yj2+sZ2z38LRUZX8UtlOhC4gD0v1EICXMmMbOwSyIo2ZBJx5PWJBNBsD0/12l+DtDJu60cPqeN37z3LnALpVvdS
X-Gm-Message-State: AOJu0YxpyKiD5mlptWQeZAre/aOR2R+j7YjTqTwxYidJNe1X8dP4R1Pj
	4cA8mdz7JQGOH015Z+AzGR2RljVEhmwo+NE39IQPeZavOp2pxhPzp5M8KKi7CMiB+3bXBsUfrBs
	sBkHom8SaqfFszacSIh2Re3Folo20Tt0Q8L0EOA==
X-Google-Smtp-Source: AGHT+IH98EISaj94HpDi2rlmrd8w9Fj6vSdDh3ZnOjMDuCqy7Y1IBEY6ToBgt88nGS+ar9pdmZ/9uSUzzjKPwGwom1I=
X-Received: by 2002:a25:c543:0:b0:dcf:3ef1:1997 with SMTP id
 v64-20020a25c543000000b00dcf3ef11997mr14153649ybe.1.1712154742988; Wed, 03
 Apr 2024 07:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403-msm-drm-dsc-dsi-video-upstream-v1-0-db5036443545@linaro.org>
 <CAA8EJprd78g0jM4u2uY-vZnqQibbWevjxqzXFaPohkvmyWHkHw@mail.gmail.com> <CABymUCO0cpixiC9Maz5cd-L91qzE3_4QF=4qvNodpzaOR4Vi-w@mail.gmail.com>
In-Reply-To: <CABymUCO0cpixiC9Maz5cd-L91qzE3_4QF=4qvNodpzaOR4Vi-w@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 3 Apr 2024 17:32:11 +0300
Message-ID: <CAA8EJpoFA3JsxzYrCR7Py8AHcOSrxUZRPO4hMMMDr1SrQFsWRw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Add DSC support to DSI video panel
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Vinod Koul <vkoul@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Apr 2024 at 17:27, Jun Nie <jun.nie@linaro.org> wrote:
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2024=E5=B9=B44=E6=
=9C=883=E6=97=A5=E5=91=A8=E4=B8=89 17:49=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Wed, 3 Apr 2024 at 12:11, Jun Nie <jun.nie@linaro.org> wrote:
> > >
> > > This is follow up update to Jonathan's patch set.
> > >
> > > Changes vs V2:
> > > - Rebase to latest mainline.
> > > - Drop the INTF_CFG2_DATA_HCTL_EN change as it is handled in
> > >     latest mainline code.
> > > - Drop the bonded DSI patch as I do not have device to test it.
> > > - Address comments from version 2.
> >
> > Which comments? "Adress comments" is the worst case of changelog.
> Adopted. Will add more details in next version.
> >
> > Also, what do you consider as version 2? Jonathan Marek has only sent v=
1.
>
> It's wired. I see v2 in patch title of below link. Just notice that
> there is v1 in the link address.
> https://patchwork.freedesktop.org/patch/567518/?series=3D126430&rev=3D1
>

Ack, I didn't remember that there was v2. Please excuse me then.


--=20
With best wishes
Dmitry

