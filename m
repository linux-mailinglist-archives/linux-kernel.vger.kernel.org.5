Return-Path: <linux-kernel+bounces-103492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7111587C033
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3D228124E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E5A71B5D;
	Thu, 14 Mar 2024 15:29:50 +0000 (UTC)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E467571B4F;
	Thu, 14 Mar 2024 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430190; cv=none; b=JU2SFbYCfHyiilh+tNQuv3/SIC72VcFAtMDzkgehtVaup6FYWEv2f4KQxcQO7JaBUlmL5nlAdl80bstB1MAFlhq4IXLmHDSQGF9j/6+kx1utNQzDrkrddi3QbdvUD1g6uAMa1N27CwgVLx8tziDZPkZSuMyIkdzJRsV8txS+0uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430190; c=relaxed/simple;
	bh=sz4vtJtgjtxGimNuodR5Dts8e41V2G0abFSVNiYfOig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuTDITw3ZzUAGMIe78Qs0EUOgWrU7RDlNblxGdy766wXZKVn+k4I7g4q2cA0mk28a8XRr+HHwy8e56rQlzleqGIyOORRcnIkCCmsGymUuShZQOVgjQZgEKrPwa0YfRypRzTk4RO7igXI6Edx3gwhl8NVvfpZwudGJzF07S7Uk4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-221d4c52759so92285fac.1;
        Thu, 14 Mar 2024 08:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710430188; x=1711034988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sz4vtJtgjtxGimNuodR5Dts8e41V2G0abFSVNiYfOig=;
        b=iTh112JXa3u+Utr0j1CTf/n5InCwSNN8pfXbetQmyaqpS0OWZYZYeVknKZWmvFjNrT
         Zv77EqHFEvPrhTNy0AYfGOuVeOJIxyrBFEqTweeLAYetu8KDk/zBeWd08sf21MKcimPR
         oQorpqWVL4Bpn+jf42Jti62HngOoa/G7adg48aqjx//9YUbj3yaJl4oIUyv8/f8fhG/X
         IdkRvG+q3MGf7qugdGvgp6a1RQdp4kWQdD7K+odV7dHc4U0m7YtpTBMLsmE6AkqTmLho
         I04TTPiLedsVjgaq5r7hSp5OMCjp8EdnxOBvfuzR8FZHra3Vjuv5obqeiHFk1pIRqOsR
         CvYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCveDBQRAALR1y7VK/YFlk0aWTibIDUOQgZTKjG1Hft7bB/4klXkV8a+YlXEoRC0fviFrzr8n2B8djluT2UqiBQVwumNXqXnqczk7Y0dccaksQj4Q4DfIuZV1BSNvsevNSpiaO2XI=
X-Gm-Message-State: AOJu0YzmYisNGvYpzVegzejQRBOCi97dYj/A4GldUx/K4GOg0XYaMaUJ
	sNOyhKIfeGT7boi/tAdQoLWxzaKmaGoSKofZOB85+tEeF1hJw+pzoHEh4JF93PbdwDdePabAmUP
	11rFiGB5Asi+OeOKu8Cq6ho+X+GQ=
X-Google-Smtp-Source: AGHT+IGw1wzCrd+KShFy8gIzPHGgdEgl6nALTcZHtfMqpjOxXMESDUNLraIbxUslw88qM0F+kZ+0mj1dkWxYreVQGI0=
X-Received: by 2002:a05:6871:5b11:b0:221:a151:7f3d with SMTP id
 op17-20020a0568715b1100b00221a1517f3dmr2177153oac.2.1710430187943; Thu, 14
 Mar 2024 08:29:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314075429.1164810-1-d-gole@ti.com> <CAJZ5v0iUt+tudMV-rJ80GR6iNQVv06+054h0UyNgpEOUF6QLRQ@mail.gmail.com>
 <20240314151846.u3r3eaklrl3hf7pi@dhruva>
In-Reply-To: <20240314151846.u3r3eaklrl3hf7pi@dhruva>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 14 Mar 2024 16:29:36 +0100
Message-ID: <CAJZ5v0gwkKa+AYgOwydzsKjo=_M56t88PwVo7R+fe-53abAdVw@mail.gmail.com>
Subject: Re: [PATCH] PM: wakeup: Add a missing return case in init_wakeup
To: Dhruva Gole <d-gole@ti.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Tony Lindgren <tony@atomide.com>, theo.lebrun@bootlin.com, 
	Sibi Sankar <quic_sibis@quicinc.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 4:18=E2=80=AFPM Dhruva Gole <d-gole@ti.com> wrote:
>
> Hi,
>
> On Mar 14, 2024 at 15:01:36 +0100, Rafael J. Wysocki wrote:
> > On Thu, Mar 14, 2024 at 8:55=E2=80=AFAM Dhruva Gole <d-gole@ti.com> wro=
te:
> > >
> > > The device_wakeup_disable call can return an error if no dev exists
> > > however this was being ignored. Catch this return value and propagate=
 it
> > > onward in device_init_wakeup.
> >
> > Why does this matter to the callers of device_init_wakeup()?
>
> If atall !dev->power.can_wakeup then the caller should know something is
> funny right?

What would the caller do with this information?

They attempted to disable wakeup on a device that doesn't exist or is
not wake-capable, and so what?

