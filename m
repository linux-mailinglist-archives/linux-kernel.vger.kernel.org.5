Return-Path: <linux-kernel+bounces-35819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA618396EE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6472B28557C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B6281207;
	Tue, 23 Jan 2024 17:51:19 +0000 (UTC)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC19C811FC;
	Tue, 23 Jan 2024 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032279; cv=none; b=WoKLCOOVr3itQChrqwscHOzaOr9nxgaqtj2l2JVWnDDfOLph9dkq3Q9HAiU6qYSudWnpOfWSANhfpBrznXGBR9/kdyMyLVnQD/d9k77fUx4CaV7TBU4brhdjqN17g0lFO1NQI4iV89qEuyfQx5v2qBRz8yXmk30HECZGGFPYnhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032279; c=relaxed/simple;
	bh=kbHQ7RoDPR/yeMKnb+tyZjRdLUYh0JKqS2LM0KSiH+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPMZR7AY3p5VnXqedoD8SLei/LDWwvYfJzw1OevpCk7Vdx2aedndlHxEnp5kJc16hBfltV7DvSFzshlC+8e9LADMAoLyPm+CguaOW1jyysn0v2Ne2bh1uyJTtYFT4f7guBWGQomK/Q+xn4yt9uGGuF5kAuplc/YPjuAcN4H9Z2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-59910dcc17bso850193eaf.1;
        Tue, 23 Jan 2024 09:51:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706032277; x=1706637077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbHQ7RoDPR/yeMKnb+tyZjRdLUYh0JKqS2LM0KSiH+k=;
        b=UA2Xa426fkrGKcgK+QAd3LHhxPIiCB4LSOGsd9OJ70biIZXpm7RqizTuAdKM8rW/jC
         Qa0sG/LGOkFvdX++oOx3TaUcWDrCuVwkeKD/AUfyLN3A7R5etvNs4c2jR7G6gaDjn4/8
         SpekWRr0PC/h7LFRUA8eV2iiSZeyumD7CBP0R6fskOkeUyZucHNmhiLn1a0q+bIfUUy5
         usneaJ4Kxst/DBcdJviIEJTd0UkHGBaPlVq9LNmULvHM3wYln009Ny7kKhm0JAx2+laE
         WfRwmnWdk/yAhCEufjbaMRPidIOiUnvnqEm/tdfdTyrQ3/tj3+dKpWqRipPlIJtwlm7p
         2W5g==
X-Gm-Message-State: AOJu0Yxv0nxfLWDGDtyA2KyTU3dv4I3DCEHTJ0uBs68+BgU53qqitIrD
	o0a8cYqLg7NLu6hMsGM6lzZXbFvgzgqrzkmWSB0Dt4Y+yrU1zqp0Ec8Di8oxfczl3StqxT0wZlQ
	FW+6tyc0zRK9cZBkCmChPgIfEdUc=
X-Google-Smtp-Source: AGHT+IFyREHCRkF5oQfCsKy5MTAAMSUWbbC2Pr/szEVe+an82nfq/YAAivz22Lsd+ga8WFx7V17+GDeQ+ThJv17J1QQ=
X-Received: by 2002:a4a:d084:0:b0:599:b30c:51b with SMTP id
 i4-20020a4ad084000000b00599b30c051bmr1014164oor.1.1706032276844; Tue, 23 Jan
 2024 09:51:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5745568.DvuYhMxLoT@kreacher> <20231129085600.GQ1074920@black.fi.intel.com>
 <CAJZ5v0iRqUXeuKmC_+dAJtDBLWQ3x15n4gRH48y7MEaLoXF+UA@mail.gmail.com> <kvoclxvyhmdmrfpfgwfjr33bdltej3upw5qcnazc4xakwdgg2b@krewjw2uk42k>
In-Reply-To: <kvoclxvyhmdmrfpfgwfjr33bdltej3upw5qcnazc4xakwdgg2b@krewjw2uk42k>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Jan 2024 18:51:05 +0100
Message-ID: <CAJZ5v0iHV7OVZ=-R6xbuZGaK6BSHM6KyCT3+RPhj=Da-u2cGZg@mail.gmail.com>
Subject: Re: Re: [RFT][PATCH v1] ACPI: OSL: Use a threaded interrupt handler
 for SCI
To: Christian Heusel <christian@heusel.eu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Michal Wilczynski <michal.wilczynski@intel.com>, Hans de Goede <hdegoede@redhat.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 5:39=E2=80=AFPM Christian Heusel <christian@heusel.=
eu> wrote:
>
> On 23/11/30 02:28PM, Rafael J. Wysocki wrote:
> > Hi Mika, Hi Mario,
> > Thanks for your replies and tags!
> >
> > Given the lack of response from anyone else I'm going to move this
> > towards linux-next with 6.8 as the target.
> >
> > Thank you!
>
> I got a stack trace in dmesg with linux6.8-rc1 that seems to be caused
> by this commit according to my bisection, see the bugzilla report for
> details / further discussion:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D218407

Mario's suggestion to add IRQF_ONESHOT to pinctrl-amd in
amd_gpio_probe() looks right to me.

