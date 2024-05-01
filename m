Return-Path: <linux-kernel+bounces-165258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DA28B8A25
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAECB284061
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B9644C8C;
	Wed,  1 May 2024 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BU2zS/pz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4393CF9D6;
	Wed,  1 May 2024 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567203; cv=none; b=qY6yaS9WjqHWPa+EoL+Hgc1y3T52H+K6S8xThQ8vsUDJjSkAcsUYvLBCQYjSI2GifC8Efi77sdaLdlyQ2tiHx8erbWB1RsnhrZIhhsk1Sk48Q2KUvicAuqSL/jfyA0/fodd9nc9XQtpkPKmsH65XPsDnJZiaEmhCpQTYO+KEt1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567203; c=relaxed/simple;
	bh=cl0dB5wGo+5uj0Y4IQNMQknyPfpkK+3SgXwRRuMM5EM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VH4DnpQ8XzS1hAyX5TuSntcjiQMCBOHFz5ZYJA3kpms/41VrhuRe9MFdoYPUvJiJ8u8dj4FbnHYQ5qIgNST+FQo3gWc6Mwm3Ci0nLbMoLLpkzFNhPIYN8IPslqKq8spXlSgs6KFXNGo/A6zXdh4jnox+W1J5/QLnfUMBllLbbGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BU2zS/pz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03D6C4AF14;
	Wed,  1 May 2024 12:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714567202;
	bh=cl0dB5wGo+5uj0Y4IQNMQknyPfpkK+3SgXwRRuMM5EM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BU2zS/pz6catu1evdEGNz+5JPjugv/TZDFsNqElqDT3eLgxQl+AsZk7j6Z0xQ9j/w
	 l7QxAWnwHalymxPBytEy0dobttdhXqel1zgQFKWN+/OFmBgLcp+MXJejeT07AKZi2O
	 Lh9x4qsaZcz0wadMswTjmrWZMGJUmWt6mEj6ADUUg2+O1tjtDoxd/Cp5IB4+TyF1gF
	 vG7sUo0cqt43SLkUt/tZ0V6fjvR59/TJjgEEyacouyj7vSU9mYjoXaxTy0fjkozTQs
	 mMngeWklfzhGcCKnEVl9pqO87GwnouiHOBLGTLizxjMXxmLQiz302iLFBtu5DRuGSN
	 0I+iP5hWJJysQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-516d264d0e4so713117e87.0;
        Wed, 01 May 2024 05:40:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXeSu0iEiNRKgYTFsdg5sKX39pNV9HCrHV/IWv0MvwowC0+1Vw6kFJyY+qvMziTFq+9leHOF9HK6lUR83Im+SBFrkYcLnXnWMiWJBqzcwB/wM3+Aih3sz4TGKmiCWjsipIyo8r7134zRg==
X-Gm-Message-State: AOJu0YzLnr0RUWvkQet8wsQ58i/rn050EZWHXMw67zxeZowck9IOtT+Y
	df1WrhnpDsgtKE8ri0CaPFv0Ac/NwEwJ8+yk26wWLO15Lz19HffIs2am9I6ovPMI+gb9Y1V4NvL
	Hd+llaaeLLViCRfqE2GYzgrUhbg==
X-Google-Smtp-Source: AGHT+IHfnLb4uX/CU49Wr6YrEIPeVaOTobqSBnrzfgvUOpXZjqc+PjMD1HIeOKWFvDKbqLBLBRoBOD0nP82bn0JE5fo=
X-Received: by 2002:ac2:42cf:0:b0:51c:4e0f:ba33 with SMTP id
 n15-20020ac242cf000000b0051c4e0fba33mr758683lfl.18.1714567201151; Wed, 01 May
 2024 05:40:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430172520.535179-1-robh@kernel.org> <4f3ce3439e3d996471085e906902e508528308d3.camel@codeconstruct.com.au>
In-Reply-To: <4f3ce3439e3d996471085e906902e508528308d3.camel@codeconstruct.com.au>
From: Rob Herring <robh@kernel.org>
Date: Wed, 1 May 2024 07:39:48 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJmciSKp4H2KXcqv78Vga5gDi0JU_PY4Dth7LJrq6swMA@mail.gmail.com>
Message-ID: <CAL_JsqJmciSKp4H2KXcqv78Vga5gDi0JU_PY4Dth7LJrq6swMA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mfd: aspeed: Drop 'oneOf' for pinctrl node
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 7:40=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Tue, 2024-04-30 at 12:25 -0500, Rob Herring (Arm) wrote:
> > The use of 'oneOf' to include 1 of 3 possible child node schemas result=
s
> > in error messages containing the actual error message(s) for the correc=
t
> > SoC buried in the tons of error messages from the 2 schemas that don't
> > apply. It also causes the pinctrl schema to be applied twice as it will
> > be applied when the compatible matches.
> >
> > All that's really needed in the parent schema is to ensure one of the
> > possible compatible strings is present in the pinctrl node so that its
> > schema will be applied separately.
>
> Thanks, I think it improves the readability of intent in the binding as
> well.
>
> To understand the impact better I grabbed the patch and diffed the
> output of `make CHECK_DTBS=3Dy aspeed/aspeed-ast2600-evb.dtb` before and
> after applying it, but there was no significant difference in output.
> Should that not demonstrate the errors being cleaned up? If not, what
> should?

Try it on one of the new boards posted in the last 1-2 days. It showed
up on my testing dtbs_check on patches. I didn't send a report because
there was so much noise in it.

Rob

