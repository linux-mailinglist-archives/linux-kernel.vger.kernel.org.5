Return-Path: <linux-kernel+bounces-46103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA258843A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F56F293598
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B21F69D01;
	Wed, 31 Jan 2024 09:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4Hdxe1g"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB766519D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692023; cv=none; b=lxnZkdY4anCWd28BKk/oUBew8RuLnsSSN54PIV6wFDeXcYqgUwNGtvidPIYVIf6Cr+cDh2tEmJm17FFfYY6+/VxufIkdEtFO8nFYglnp297Z4rjKBYOu+K+DjpTnIBesiliqPWyMGAC4VIloszJM8Dq9YwdWOKsdxNGb1ZXeXLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692023; c=relaxed/simple;
	bh=oxgNymcs2LHMT7a99OhfjwHqo/ckBAFjCo6CZnsp21w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j83PAwKLR6kkiZY5FRmiDXnMtazF4zPqyPiF01X1SVxH9DPvCXEfZ0+Hx+kJ3F3nRk5Fzdlcc3QiV9y92MStOpD9dkudbwVRUWC6X+4IqL0r5mM21ZO9bqSV3QNUcN/+Znmu1RRzRESwn7qlaP4oKjNfjjqmtuMahsrwpddn4/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U4Hdxe1g; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5ff821b9acfso47023197b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 01:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706692021; x=1707296821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJd1d7Iygxt5liH5/uAuLMqXNf2/RDy0rKG9vrYq434=;
        b=U4Hdxe1gGbDKVQHucNE5yRlwi4ftddpT6yqDHpYEZVDiFAGtqJfmZNABEoBMPkjma0
         vAGdWzzaMusyhcE2GDpNNSkQ4MBSZKcHUn7DhHk03O9WsJrNV8PlAKZpdt0wT40597Q8
         +cr10qX8f+xVCYsExUV6dYhJ4CxUMKm9+a424Gw79M3LQLSMDYwFcTgLLp4yk1aKXxNG
         az6WiI/S2RyW3oy5sPPFAhQQVLhoSnR6jioeTf+M0u/2b5+suSfabI/GnHPaeum5AQTm
         yNPZMVdLaPbvsYp5E0HMWV6z+Lyn8/WSNUotY8NH1H4o+WSYzCcMAnm5EjNaIXchnr+g
         k/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706692021; x=1707296821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJd1d7Iygxt5liH5/uAuLMqXNf2/RDy0rKG9vrYq434=;
        b=d11dKhRXRWZeNjbbvAk83jRqtY2dvHL4+zUQtWxXIRmajS5/f5mKK1Ym+2TOPyCNUn
         KkpMFuLYKcWQ6YXba02uf7lohROc9zqsF4D4udNZ4p+ZJrWtebZBLLcsoQG9Naesagyn
         FIOLNAAZhNTpOqcllgdJJEHelfZWnNQDABzXsobIPAS8L0CVXPVWN3PwnyqtRWANHPyt
         i24smReenQQbsS4YGZqNDNk1xPywVOkwrOGU1Cjw/1CbRlPuKSGaiIST2znQKZvCDJaA
         WN4i6BtbC5LLsD4Aluzk9jJqCmW7e3VUzQY5wmtSVOBg++F3yEA0SOEv8QIzMl+I8n7p
         kxdA==
X-Gm-Message-State: AOJu0YzwPgFLhIB3HZErKZsSM3kK/MXuhQRkraGzfhFSICiBCMAT1qAq
	FCcGJIbD9p1V+BsjUPiFvIcXkP+0pEnoEvVZy/tBUBMajf0a5sieti64gFi/bi8OAUw0BE39U6P
	1+jf2ibI5La2WRJuHs3uJIcPypSx3smqygQc8MA==
X-Google-Smtp-Source: AGHT+IHtxghYqklapdMskeCjagfQLJmYYzv2N+Nrny54JoXQvG0QOhicxvt0LmPD2tmvUsJ1FOsoyUbBR+1WEU1IFz4=
X-Received: by 2002:a0d:d4d2:0:b0:5eb:d94d:4300 with SMTP id
 w201-20020a0dd4d2000000b005ebd94d4300mr850819ywd.19.1706692020767; Wed, 31
 Jan 2024 01:07:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123180818.3994-1-mario.limonciello@amd.com>
In-Reply-To: <20240123180818.3994-1-mario.limonciello@amd.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 10:06:50 +0100
Message-ID: <CACRpkdZxOovTOF0rOjyU1WwaRLZqML41hfYcC7z=HsAQjY8BsA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: amd: Add IRQF_ONESHOT to the interrupt request
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, 
	"open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Christian Heusel <christian@heusel.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 7:08=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:

> On some systems the interrupt is shared between GPIO controller
> and ACPI SCI. When the interrupt is shared with the ACPI SCI the
> flags need to be identical.
>
> This should fix the GPIO controller failing to work after commit
> 7a36b901a6eb ("ACPI: OSL: Use a threaded interrupt handler for SCI").
> ```
> [    0.417335] genirq: Flags mismatch irq 9. 00000088 (pinctrl_amd) vs. 0=
0002080 (acpi)
> [    0.420073] amd_gpio: probe of AMDI0030:00 failed with error -16
> ```
>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Reported-by: Christian Heusel <christian@heusel.eu>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218407
> Fixes: 7a36b901a6eb ("ACPI: OSL: Use a threaded interrupt handler for SCI=
")
> Link: https://lore.kernel.org/linux-acpi/CAJZ5v0iRqUXeuKmC_+dAJtDBLWQ3x15=
n4gRH48y7MEaLoXF+UA@mail.gmail.com/T/#mc5506014141b61e472b24e095889535a0445=
8083
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Patch applied for fixes!

Thanks for dealing with these issues Mario!

Yours,
Linus Walleij

