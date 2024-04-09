Return-Path: <linux-kernel+bounces-136739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E8689D7C5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79309284914
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360AD86AC2;
	Tue,  9 Apr 2024 11:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m72dVVJR"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E95385C59;
	Tue,  9 Apr 2024 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712661733; cv=none; b=n3l1QtkC1s3GOb/i7LD74FPpzuiB3sa16h1JxqTCHrOf4BFGrggxW+n0a2W1mkNzvd9Kl3r0xyrYUPLh1XcH7Gow4+TfKH6VvgSSUUv0woz9qEK2Nx9FBjrPaUZUuQeFasLAUZqfldDHUP0aqxJny+YX44CAtcLbuR3Pv+yVd4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712661733; c=relaxed/simple;
	bh=z2BYcIxpPV7dA/hoWGZiUhKQFrHNrFSXIXX/wN3zASA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ul/tfcBBSP5sq+NJR6+SU3yZuV4QipnxcQH+AEdkh7383h4Q6GEAxYbpJI3pQDX8ryAK0BZG4m858d8/edmOlz1ZVeYhGN4RYcsr/mqINmpct6P4PIOBGP8iXBuEVw6TQaFtzKM6J/yqFb8LBiaAhuxKp2H4hMq/kFzNe+NKiJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m72dVVJR; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7d5f90dfdaaso61431639f.0;
        Tue, 09 Apr 2024 04:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712661731; x=1713266531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUPlYyCbnZyXJn6L4cZK1glpJcPHCmQEuO505nrY/Cg=;
        b=m72dVVJRM7Cv0XqPsVsMkgjYf3Oy/fY9MOXwxznVEokLN0QIY02DzJXZOC217JsiWG
         pKG++QOd6BeC/gCExKHM0yN0JBPfFLOt33N+gCJm/aBYinJTMW+d+lZ91McLrTZcdPAk
         V5HOS37GNyYEk6wT8feUdHGO5adoL0/4kU1BU5TOGbQUb47PfZMERsKtRjOWqFXVbwlt
         S7q4isI9IEZVV921gL9TJ9r61eRMTz7E1hmTt5WNoi76SoYGxtl4DDIeg78f7KHXruaI
         2ZgClSZPvhVxpFUmkOXeDvTfD7aWAPqiRUyq/3i4zrQJCG0WDnG2UXI5L+fsLfI+aWPj
         EKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712661731; x=1713266531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUPlYyCbnZyXJn6L4cZK1glpJcPHCmQEuO505nrY/Cg=;
        b=XI9/TeZkkCy7mzELdn0kb7wmyfd+zRdcWfZSAIkUJeduILITweUQsl1WzgXrO+/Wso
         ywcL+CoOnEr/71Y7JlJ9YcWus8UJd5wNDmpClzW3Y/KiAnNqufZ7VF7Yf0lVzg/EH9pC
         0v7PyIyELEOdA0wkMQ3PKsr8zRSBG8PAPFQsvmNAupcVX1rKydkCY1SFN8ELEyEcYUJz
         DWof2bTW4AJ+ZFAk5p+9s8tkM+4W9tnIWV7fmWM3qJweKSR5bbKP9xoP8dC4UdbwTAzF
         LMkQnBXP6nMK3QT3f+V3qSycHW6fUmIbPgLNKR8b1N+u9mQ27dizcnR8pVeFU/+syL9J
         kTVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmbRJ8lgVOOYgLQPc2deZ6NtN/z7IGEEO4jazcmwRRLEdW2vnOjUI9xd2UJFci1vSgAyhaEmgMXass1AHWhANjJIuL9GTj3emPYE65VTlpBb0+GdY79dC/IhhDqsJZ0aMYOMkjaVMZo6OSCEqBWY1zMrV7nHD1DxCANqPSekgbp5JIRzVE
X-Gm-Message-State: AOJu0YwLk/WhWInoPWNc/CnF3j47aYD7tmFgCYqtqp8gYSAhUr8POBn5
	COXNsDYSqozx1xeygPpILb7deL8EiCjmwIB9Hyk76LN2ahvWSIqXDJilIFOwNcHHupXwf2GsoNo
	qmnJr7GNIL+vWEgtYlMoFvdjZZRw=
X-Google-Smtp-Source: AGHT+IFwJhpIsKcZb+Asw4W/YnwlWjJ+/9Z/cP+F5xlsh0I1LU5T/T/6y3yuehkk3NNmH5hNvipHXtlY44zFA7XMvgU=
X-Received: by 2002:a05:6e02:1ca5:b0:36a:190f:1932 with SMTP id
 x5-20020a056e021ca500b0036a190f1932mr10670474ill.23.1712661731192; Tue, 09
 Apr 2024 04:22:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1712652644-28887-1-git-send-email-shengjiu.wang@nxp.com>
 <1712652644-28887-3-git-send-email-shengjiu.wang@nxp.com> <CAOMZO5Cku1kifsnWJOr0Zd-5+49j-KB67iHZDcvUsKwrhVPtLA@mail.gmail.com>
 <CAOMZO5BfJBkyw2q3wi4q3yjEmQowg7Zsw8yEFyANMYYez3ai+w@mail.gmail.com>
In-Reply-To: <CAOMZO5BfJBkyw2q3wi4q3yjEmQowg7Zsw8yEFyANMYYez3ai+w@mail.gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 9 Apr 2024 19:22:00 +0800
Message-ID: <CAA+D8AN+7Ca5wFzTKFDHDEgL5MeW62K4qLsmP6LrngiG75RPBg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ARM: dts: imx6: exchange fallback and specific
 compatible string
To: Fabio Estevam <festevam@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com, broonie@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 6:06=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> On Tue, Apr 9, 2024 at 7:02=E2=80=AFAM Fabio Estevam <festevam@gmail.com>=
 wrote:
> >
> > On Tue, Apr 9, 2024 at 6:08=E2=80=AFAM Shengjiu Wang <shengjiu.wang@nxp=
com> wrote:
> > >
> > > exchange fallback and specific compatible string for spdif sound card=
.
> >
> > Ok, but please explain the reason.
>
> I mean, why can't these two .dts files be changed to
>
> compatible =3D  "fsl,imx-audio-spdif";
>
> , like all the others?

The specific compatible string should be first place
as the dts rules I think. This patch is just to fix this problem.

For removing the specific compatible string,  I think we can
do that.  but this change may be out of the scope of this patch
series I think.

So I just change the order of compatible strings

best regards
wang shengjiu

