Return-Path: <linux-kernel+bounces-78296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7B7861184
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54406286A72
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBB673F0A;
	Fri, 23 Feb 2024 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnSQt1sL"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3D3134B7;
	Fri, 23 Feb 2024 12:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708691514; cv=none; b=h30526804+raLuf5rqatCPgnF60G+Ft1KIe9CZKgd3B0egXgqCNV07ZSuoszhpCGG4eyG14B6bRaAGVDzji7S9QQQe77QaY/ZgssWIiUDbKLt7R0FU2C6w8EBo1Xs/nS23fco0i1xLwwhUkQReaH7VTOjdbTvtmIt0lIEFbdSNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708691514; c=relaxed/simple;
	bh=xoYCgBeNqtGNxoqBdeEfgupdpkUzCMQPgui5YPz3jpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AgL/nXhQsl4Unhj6/C3hKKN4LhelBOS67uF2CyfZgWoNlJ5S9Cuh6sLklXY+40Ht/bw19sapMnwPgYEQwwyp1wAc4UCU7tzjdQr2T9l4sFsRMUfc+0yux7M8eJmodg7VxXEgX5vQPoNC5tx3wG/uH8Hb0/pFgknpBOuo7T9syfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnSQt1sL; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bba0ac2e88so171285b6e.0;
        Fri, 23 Feb 2024 04:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708691511; x=1709296311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/K7A+AIftwNxa8nwsHRE+wIGsuoNZibDyiJclZmLSLE=;
        b=dnSQt1sLKmZYz0PiLqxLYyIj+bZuOQTJumR1kunke24aN/HYNpLWdhncOnDnaNFxki
         EKFGecydltGFxYzQkztGNh9OfJEr4HoBCWQkpb0NjTcp09C8qM43epIi8EMDTm97Azn/
         NrzzYO1Ve+w5+jhsY4n9tO6WnZfn7I9OptYrlV9QA+wIrosId/UvUbaaNtb7+ZVMe4+3
         4knU16JPBq/zXNq54FVZthXX1lFRKdp1dA1PjFTBvKliLVe9woP1++K0Sh7+3ry9DLaD
         waJaBoDVl672BsqYA1tnm3Ijn8zjE2mVyWhW9DO37ufrAiLfOx3SaCsD9vkb5CfvFNUO
         4Qwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708691511; x=1709296311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/K7A+AIftwNxa8nwsHRE+wIGsuoNZibDyiJclZmLSLE=;
        b=udAT5+N+b8vOmE4I9qDn4CRiW61Y8xkfCnTCcGarJpz2qeV0GaQuiEBKsAMQSxk8Xe
         HLC3Uz6McNlfCMwW5+W/Tu6l1OKyM1bT0NL8F5gAzLRk05pWoYNnLuW+EjqsdRKWvJIN
         tUDiDzOyjuhfua3iLRQkUofZMyT6Ax9yVrUHHlFs9L6YZ12b3BD1y8rBoZunoCysjM4g
         OEiP7acf3ureW7sHawqmDyN3fdLw68xihXyi1st06CEECJsImAGIxotdIbtNAGVHn3tR
         DqAVJKJF72zTF6YQTkJpVzwGDdPhi2phwFaZYP8oIBtTZEjrttUbAs9ihR4u5WkarSCM
         BFaw==
X-Forwarded-Encrypted: i=1; AJvYcCXGoGN86EzmtGsj8Jyo+PX6EYzM+9r66VqjbXat2Pfew5DykR9aoqnnhOMaiInpBV/nbzs1iNHnBmEeIzqK2pekbl0R85pWR2TsPqZ4
X-Gm-Message-State: AOJu0YyvueKWD8DqbySFYwAGZNPh4WXrvoDGS307pzIfYlFAb6R0IqoZ
	ELTSshF7Ldqp9BFZL+zYiswzRvdemdc8FnAgHG7/4XAHNZpxu6cU9wZw1dBRKfuxRb6tn4z/1wv
	qnc8l0gJ4a3s2Qkr+ZIVwxdBGx0w=
X-Google-Smtp-Source: AGHT+IGwmuWoSYk3dQUFPAiF/a28zVOnHOxwyDy3DT4rePOO1G0IO8jUk1OU7lyRupoZiESAWYF4XnYp1ujyiHfF/nI=
X-Received: by 2002:a05:6870:e2cd:b0:21e:5bb9:5d7a with SMTP id
 w13-20020a056870e2cd00b0021e5bb95d7amr2401314oad.27.1708691510791; Fri, 23
 Feb 2024 04:31:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212093443.1898591-1-sergio.paracuellos@gmail.com>
 <CAMhs-H__b2dNQH+nsbc0+gTeQPmkZf5B95+3Y88iRZ5KZmu=yQ@mail.gmail.com> <54605748-e737-46f0-ada5-0e3e79699262@linaro.org>
In-Reply-To: <54605748-e737-46f0-ada5-0e3e79699262@linaro.org>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Fri, 23 Feb 2024 13:31:39 +0100
Message-ID: <CAMhs-H-oBOQMqkpjMYRRDQAoDL3e6xnBXy=HdOfrx+PSXst2-A@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] dt-bindings: timer: add Ralink SoCs system tick counter
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: devicetree@vger.kernel.org, tglx@linutronix.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 1:23=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Sergio,
>
> On 23/02/2024 12:27, Sergio Paracuellos wrote:
> > Hi,
> >
> > On Tue, Dec 12, 2023 at 10:34=E2=80=AFAM Sergio Paracuellos
> > <sergio.paracuellos@gmail.com> wrote:
> >>
> >> Add YAML doc for the system tick counter which is present on Ralink So=
Cs.
> >>
> >> cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> >> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> >> ---
> >> Changes in v2 RESEND:
> >> - Add Daniel Lezcano to CC in the patch itself.
> >> Changes in v2:
> >> - Add Rob's Reviewed-by tag.
>
> Applied, thanks
>
> Sorry for missing this patch

No problem :). Thanks for letting me know.

Best regards,
    Sergio Paracuellos
>
> > Gentle ping on this patch. It has been a while since it has been sent.
> >
> > Thanks,
> >       Sergio Paracuellos
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>

