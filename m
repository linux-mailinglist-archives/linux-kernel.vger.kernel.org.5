Return-Path: <linux-kernel+bounces-135529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0DF89C734
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1CA31F22FFE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F3013E8A9;
	Mon,  8 Apr 2024 14:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rM0jA44C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE193768EA;
	Mon,  8 Apr 2024 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587083; cv=none; b=Ne8MR7VbAiMsQXv8OvDoq4MVvgVRCLaO3zFkP9YHXvo5gVqjVjGbSlrhvMDEG2HcMnZj1gEid+uxbsphcvlHsGXCtwRNT4lksohNyq++/1KC5U9YrYpDfMc02V7Uy/hYaZWkqxijG19hs3C45398Qf5vb0tocOTd0iYgIqPSCWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587083; c=relaxed/simple;
	bh=ZYMMKfFOivNhDtj80tBTwOeXAwS3KmSz3sLf7icExEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X1DAeEFHBuRKQkKmbCf7PEakEuvM+rkzYL2NCnFW+25pkXSCdzwzdT8xcySOmiNrluBYun7XI4aWJIYgUcM2hdswPZsdCGAOJMb7geIjDs8K6N2arbvXi7ezb+WYkWQig57PBkmWUSE+kgCTCj/mgWohhcEvK5IrQkd4i31t0HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rM0jA44C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829DCC43399;
	Mon,  8 Apr 2024 14:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712587082;
	bh=ZYMMKfFOivNhDtj80tBTwOeXAwS3KmSz3sLf7icExEQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rM0jA44CtcwCaaI7JHx6Opc4+s02GKJM5hEf9nlZH51u0se7R0EPl/5raY0BfqeFn
	 SAHHJhX7ZJc6CpZ2/T2lpC/0shWQjuvdg0YOjsJPwrMqBoSHRltwmrWkwOf0b1jEoP
	 3Taa8vcAp+DXsIRI8SEdyZoNLU6EgtgvnTWabdfZkkZdxAn+8CY7mBAyPveLZJf/5+
	 7ufqvV2n6rB2nGh0LAXh/TVJezmCta9Cbb0rgsfOSY5JKrHKme0cRZfAeo87oT3/KM
	 PNtp+x5uBT3K05hZk2NA7d5tntNuY8wXYsQFb1ufPseXtwgwtYFFe5qr8pMrV0+LLW
	 8DNqFgnCFwftg==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-22ed9094168so79056fac.1;
        Mon, 08 Apr 2024 07:38:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkiIZdtyN704R1KsyViyRv4Us0uVR9rOTTFrMoM85ZePSiQ3pLGaju1/hO4Cg8gS7r/DZSxWpVomFWi7g/ohRtNkuaji4/320fqN5w
X-Gm-Message-State: AOJu0YwKtFxVU1s0Zp43TpRWYpZRMk7hRrDWBqo4vlMB2WlzwH7qG99W
	bdms5L0TM0OUMF0UmhvyIDz520aeJxD/EcAxAD+Tm6RD45qWMJxokR2UB2mLVf3JTTED8Q1DpW8
	vU7l4fXEoteYA+i0vTKjKk0cE7Ow=
X-Google-Smtp-Source: AGHT+IGtmZXNEoC9c+sdC1heDm8rgMBGwpq2DBXgaueWP2WRdsxUJgN/rzMJUV0g5kWrVGqDlbPvXQCeHGz3/ow3FJI=
X-Received: by 2002:a05:6870:218c:b0:22e:b2ea:5758 with SMTP id
 l12-20020a056870218c00b0022eb2ea5758mr8972934oae.0.1712587081788; Mon, 08 Apr
 2024 07:38:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404120856.4109303-1-andriy.shevchenko@linux.intel.com> <Zg6Y8AVId_R83yMI@smile.fi.intel.com>
In-Reply-To: <Zg6Y8AVId_R83yMI@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Apr 2024 16:37:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hYWVpXqNfy834w+PYRfsN4XocBfZ6cGygLucdz1bcQig@mail.gmail.com>
Message-ID: <CAJZ5v0hYWVpXqNfy834w+PYRfsN4XocBfZ6cGygLucdz1bcQig@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] ACPI: LPSS: Prepare for SPI code cleanup
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 2:11=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Apr 04, 2024 at 03:06:57PM +0300, Andy Shevchenko wrote:
> > An ad-hoc cleanup followed by preparation for SPI code cleaning.
> > The latter will be done in the next kernel cycle to avoid conflicts.
> >
> > This patch series should go before
> > https://lore.kernel.org/linux-acpi/20240403170302.1073841-1-andriy.shev=
chenko@linux.intel.com/
>
> Indeliberately forgot
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux=
intel.com>
>
> (Code hasn't been changed, commit messages also stays the same, hence I a=
dded
>  it from v1)
>
> > In v2:
> > - added Fixes tag to the first patch (Rafael)
> > - reordered to get Fixes first in the series
> > - v1: 20240402152952.3578659-1-andriy.shevchenko@linux.intel.com
>
> --

Both patches applied as 6.10 material, thanks!

