Return-Path: <linux-kernel+bounces-166352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28988B997C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC504B20BC8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A126E5FB94;
	Thu,  2 May 2024 10:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADc83FN/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94C856B7B;
	Thu,  2 May 2024 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714647292; cv=none; b=a5VnU6Ilvb5xM73UlvCx+6MhF6Nx80QgL9wQZ9CRNTYmXqlD5oVfg2u9IKPt421PJ7HzwikTZkq5o7cRSDmshmBe6pcS4Tk/O6eXX3ssmyUEIelekcuogNjBbQJn/qgUQ3gmCE4Ldj+bvesZADiIvgyVyzXDxXagc9XUbbu3cW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714647292; c=relaxed/simple;
	bh=2zMMgDtblAfRMoupiInjzu+rYzRFbq4eE1vS2UNSkZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flq1GG2oDWzpLyEMCpUzYgISR++kOw8iNArFN+8qQNNUueZlekGpJMLtohk4qSPAVzdUePeLcYHRhWr0QDSmXw+FAjF1knaR+S6SoK+B5BFvDloDBc9bXQw7KKCiaOY9h/YiK18ZQKx5P1bSaTlD7JhAw9W6GRytWNwrs+T0580=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADc83FN/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C37EC4AF1A;
	Thu,  2 May 2024 10:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714647291;
	bh=2zMMgDtblAfRMoupiInjzu+rYzRFbq4eE1vS2UNSkZc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ADc83FN/7InmE8+BsUu87A58zfvwNkMsrp3wz4s0jkj9Bz8Y8xvZgmBG+08zIOZ7m
	 apI9BXdYfadpsKqS9kGAYRY3vRb7rTc+4ZSgiQGBccNjEoaW8vKZ+vNUujHPv8K/gu
	 D4q0jywmG4+9Q9TL7+AuPq6WAy8blcKI9si5MqOfOQ8iz5AW6eu0eH2n1htpW9PtTg
	 i1BwW1nJbstqeGLpLBgutAn6vxi8UgImcIwHVjMZy4Njw7eiNANPc0kkd/Xu7JFNgj
	 hOccUKBDaVyusO8+zX2qKw/qOWq6gyBKBLsunuSyPUXVe0xjDPfFmpvb5MPyr8bH1H
	 qCSFx28P7c02w==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b1b03dc01dso360797eaf.3;
        Thu, 02 May 2024 03:54:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUiE4h9xxTsIrpL7lcjDPDbwbGLrEH6m856cdTxkTpbqlaNuNfBAYN6wWI4OGrtVrsuMnZvXKtZWbGXQlokXOz0BAUl4ILC4fd2TfegEpvS3X8NQtkZzdC2XideX2/WXFuUdN04F40=
X-Gm-Message-State: AOJu0YxGzZ0QwJ3SW/LghhjYNUQoiOuAsoQX48dqEljz1zZJG9SPes1k
	5+phfGxcg/1Xg24cqVTWZSGS/wBUQAwBpwrxUx4FJmlF+fuWQ6i5RtgdAxM+xAgm/fCPNQDHZd4
	irTxuL0ah8KZmRzZcjZvP63TgwBY=
X-Google-Smtp-Source: AGHT+IHTtFLtzAIcPI232H9S3+Qt/XcskxoU14vG/wR76VMfYJzsf+zXY7sqUfPW8wjwo2SXQlV+LiNaIfbgSTg+7og=
X-Received: by 2002:a4a:2546:0:b0:5a7:db56:915c with SMTP id
 v6-20020a4a2546000000b005a7db56915cmr5724735ooe.1.1714647290569; Thu, 02 May
 2024 03:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430225826.65289-1-srinivas.pandruvada@linux.intel.com> <ZjNdILvlyei-_Z7A@smile.fi.intel.com>
In-Reply-To: <ZjNdILvlyei-_Z7A@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 2 May 2024 12:54:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gYbn5jGE21RyzfOXCP7onhJSB5_D4fTJKW=Zf=K8zLxA@mail.gmail.com>
Message-ID: <CAJZ5v0gYbn5jGE21RyzfOXCP7onhJSB5_D4fTJKW=Zf=K8zLxA@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: Add missing module description
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 11:30=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Apr 30, 2024 at 03:58:25PM -0700, Srinivas Pandruvada wrote:
> > Fix warnings displayed by "make W=3D1" build:
> >
> > WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel=
/intel_soc_dts_iosf.o
> > WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel=
/int340x_thermal/processor_thermal_rapl.o
> > WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel=
/int340x_thermal/processor_thermal_rfim.o
> > WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel=
/int340x_thermal/processor_thermal_mbox.o
> > WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel=
/int340x_thermal/processor_thermal_wt_req.o
> > WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel=
/int340x_thermal/processor_thermal_wt_hint.o
> > WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel=
/int340x_thermal/processor_thermal_power_floor
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Thank you!

Applied as 6.10 material, thank you!

