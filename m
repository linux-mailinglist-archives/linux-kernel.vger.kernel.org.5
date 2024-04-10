Return-Path: <linux-kernel+bounces-138607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2CE89F453
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8981C20E34
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8B915EFBF;
	Wed, 10 Apr 2024 13:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qnpqka6z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF967158D76;
	Wed, 10 Apr 2024 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755874; cv=none; b=kI/w4MjcjZ/9BzKu+4sSDAYwkk0T6tDj/D8jKyrrdM/h1V0FJu+kcvtOAhP9nzOQ2MqRou3Mxd5HYR8ZVf/NC2oSyIhFQ6Q1xa14CWorio+CXBfpja4xsSEmHTgA51viyeSap3zurqw5+2QWMFP2hM9ySQ5sWddixMBOuMxiu8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755874; c=relaxed/simple;
	bh=zfLSD41E2JenoaoPH1O+sKGPiDJDFWMakf+QIw7ergc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6QwoBdCc2KH32cAeHUxOckUMQa0LMVbXjnW/Qw7Y6y/weoRQvXwUA0oJgLBohe7aR9RoelcwTgubR/LbtKB91elBjpG4JW5yfIeSoX4Z58IvxkeamppTEXlBZRSFQ8B8IKwzbySOc2wMoOay/1NWp6FP9+wRte1qmpA3Sv+NQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qnpqka6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA84C433F1;
	Wed, 10 Apr 2024 13:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712755874;
	bh=zfLSD41E2JenoaoPH1O+sKGPiDJDFWMakf+QIw7ergc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qnpqka6zLNqeggJmofQA0OUZ7ZlkJbBMHx4+OuNsjTjXSUuJ9LDLTt2zHxcjUt5sw
	 aMH+FcnCv1y50Z1zNn8U1bidV1MDHYpSZZEFidGC2SlZ0R4SHQVcxwPeMSQX+GGcSc
	 TDrKmenuipM4reDXNdlDIR8CSSdeG22Y1IQ720CYzmGa68atHK9vfdLDunQNRrpk/p
	 liMn1wJJvqfyYy43T9v75bl7zG2Xf30CaR9FFCt09SMMASEwVgii/1t7c3fXgJZOF0
	 bynlg8X59dn7iJTfDcUXAG0c8V/Sd0Q0QZIBUBgQMS2jO6jko2TGDll8k0VBl8b1xy
	 rFqn1hwnaHKMg==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ea3855e873so59383a34.1;
        Wed, 10 Apr 2024 06:31:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxbZ0uTW0R6BeBi9Io1XvHxuB2Er0/L8xtZ5HbjwEZ9ueYQ88323idBBqyRpvLIWgwzpNf/bfMGvUFgUhntruGjt6usCDxJZNcaXWC7pJ1mC+7zni+mdjIq/R0Jbu9WcQnFhxsIh8S5Q==
X-Gm-Message-State: AOJu0YwdSOZU3p22vPj9f15HFTgbrolVBQasUXleSTpfmVkFWtGHJIOF
	OmKD/8O6hZGHcjMIVFYxTk2a/Qc0H2Evir8lsT86lPksHit6W+h7IU3Is5UP+WNIZY8uNr5CpCG
	KDUMzU8uLntZWx2N9E+MTTbO14G0=
X-Google-Smtp-Source: AGHT+IFYvZ6wewkoSuhtTaIF3PMZ+E+76ZGLEZUrYkszBd7MFEyZdSN3tcBqx1bogeh+Rx2RmSKe2XSA6KZHDhUFNNE=
X-Received: by 2002:a05:6870:4687:b0:232:fa03:3736 with SMTP id
 a7-20020a056870468700b00232fa033736mr2649698oap.0.1712755873721; Wed, 10 Apr
 2024 06:31:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328035540.13194-1-raag.jadav@intel.com> <ZhYq_HDwAi4B49Zz@black.fi.intel.com>
In-Reply-To: <ZhYq_HDwAi4B49Zz@black.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Apr 2024 15:31:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0idPeRmx1oRHoVEZYmGm1D-5SFP9_C0Bu_fiuyf7YiYqQ@mail.gmail.com>
Message-ID: <CAJZ5v0idPeRmx1oRHoVEZYmGm1D-5SFP9_C0Bu_fiuyf7YiYqQ@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: bus: allow _UID matching for integer zero
To: Raag Jadav <raag.jadav@intel.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, 
	mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, 
	stanislaw.gruszka@linux.intel.com, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 8:00=E2=80=AFAM Raag Jadav <raag.jadav@intel.com> w=
rote:
>
> On Thu, Mar 28, 2024 at 09:25:40AM +0530, Raag Jadav wrote:
> > Commit b2b32a173881 ("ACPI: bus: update acpi_dev_hid_uid_match() to
> > support multiple types") added _UID matching support for both integer
> > and string types, which satisfies NULL @uid2 argument for string types
> > using inversion, but this logic prevents _UID comparision in case the
> > argument is integer 0, which may result in false positives.
> >
> > Fix this using _Generic(), which will allow NULL @uid2 argument for
> > string types as well as _UID matching for all possible integer values.
> >
> > Fixes: b2b32a173881 ("ACPI: bus: update acpi_dev_hid_uid_match() to sup=
port multiple types")
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
>
> Bump.
>
> Anything I can do to move this forward?

Should be there in linux-next already, isn't it?

Maybe I forgot to send an "applied" message.

