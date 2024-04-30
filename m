Return-Path: <linux-kernel+bounces-164638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C120A8B807F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE7F3B21EE0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAE6199E87;
	Tue, 30 Apr 2024 19:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruvsN0sZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A9C7710B;
	Tue, 30 Apr 2024 19:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714505177; cv=none; b=gLSbGPXTL64euN2prK4LDa5hLjSeoDaEJrlRaqZYJZ32vwJk8rdLb7wQXgXkCRyHkvib+6H8QSUmBT2JMafWs0hPYT0Ns/dtAg8c4Sv5DG6lSI5+vrERzoxnwYKzshY7ZDgG58UA+ZwBWepYRedGNiPWjUE7VZ2nCPfHs+Jt5bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714505177; c=relaxed/simple;
	bh=cwCvI1B5XdbNIfwGyebr6bslFHp0cGYJbC6jpBfiOW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pN/LcYWMz7xkSLLeIjt5JMBdOa+isdPafx0jxFK+Z2eW6H98PD/qgOQU+Q9OV4IjEC7Ayqewf/+mi1d/u2VmNrNpjcugXS0BnE5qhFYNbMh2QOhUn66DHTuXJJSiOtoQItb2ertJ8cF0QBav0/zFvBLp7BZDwKTmFYuMbRgmHzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruvsN0sZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6006FC4AF14;
	Tue, 30 Apr 2024 19:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714505176;
	bh=cwCvI1B5XdbNIfwGyebr6bslFHp0cGYJbC6jpBfiOW8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ruvsN0sZWjc+oPswxOMu1PtojpdQ1NeOUfmyCSyjnmwbDS9aMndZwqghj/B+E5bxo
	 SIAQstzwHElbPtSc/piEu49Wxi+DRFVwXjmYUY6zZb8CBZ05V2SVWqwVkCm1S+A1kj
	 VmeUlf+HnxrMCM2o9bx10Ic8rUEwhSv92bKk/UZMXVteqXhhAMf6n6pmGZ2z4io4Mu
	 2jmGZh3PTUSkkjUTErTGGuNWrz0Yc7lW7V3omejAKii31E+ytONMyYHpNk/Ey4o8ey
	 RKvk3SQNMG7vaa+FGYRltxwZE5fWvCMUw8FWbPL44RFvj8zi7laLtj6Jd2fq/22h8d
	 focsCCvgDUtDQ==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ee5ee29423so333217a34.2;
        Tue, 30 Apr 2024 12:26:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWTO8nV+Fkxgg3vdvxrS7U7vMOBV9EKQ9NqkLgyC52709IL/B40+tz/SVu6hOY0GeY/zsQNpSAtQINCUJvbEoeFIZt8RqyZZj0tum2veIurpR0qeJNdzL32rJc989l/FpjIQgMwRy4bhQ==
X-Gm-Message-State: AOJu0YwD3eMGokSUuPzhkVmr+6ZldPAviTyR1ZPBWKXDCWNPRUtB9CyU
	NxySZstBmqkhrqJJ/eyMZexdEe56bbrnxaoGlJ/1otKW3456Lj2qHxX9kCbUQO1lYfhUvTt95tn
	I6xYahHsjxH5xMNRw0NCUFcOeDIU=
X-Google-Smtp-Source: AGHT+IGB+aHIqdzo6v0WiIJCN2dlCjoW1lAu9eK8qwwMf4191WEufZJndIOJRuyoyJC4E+OouftD+/NH9b7Oo5Fib3c=
X-Received: by 2002:a05:6820:1007:b0:5aa:14ff:4128 with SMTP id
 v7-20020a056820100700b005aa14ff4128mr403894oor.1.1714505175515; Tue, 30 Apr
 2024 12:26:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430184146.66887-1-breq@breq.dev>
In-Reply-To: <20240430184146.66887-1-breq@breq.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Apr 2024 21:26:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0goAujo_eAZT4Di-1Wm17rPXneaHoKU+kT2GO2WVkxfKw@mail.gmail.com>
Message-ID: <CAJZ5v0goAujo_eAZT4Di-1Wm17rPXneaHoKU+kT2GO2WVkxfKw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Add Asus Vivobook N6506MV to irq1_level_low_skip_override
To: Brooke Chalmers <breq@breq.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 8:42=E2=80=AFPM Brooke Chalmers <breq@breq.dev> wro=
te:
>
> Override the keyboard IRQ level on Asus Vivobook N6506MV laptops to make
> the internal keyboard functional.
>
> Add a new entry to the irq1_level_low_skip_override structure, similar
> to the existing ones.
>
> Signed-off-by: Brooke Chalmers <breq@breq.dev>
> ---
>  drivers/acpi/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 59423fe9d0f2..1097d9dd657b 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -440,6 +440,13 @@ static const struct dmi_system_id irq1_level_low_ski=
p_override[] =3D {
>                         DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
>                 },
>         },
> +       {
> +               /* Asus Vivobook N6506MV */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."=
),
> +                       DMI_MATCH(DMI_BOARD_NAME, "N6506MV"),
> +               },
> +       },
>         {
>                 /* Asus ExpertBook B1402CBA */
>                 .matches =3D {
> --

I think that this is equivalent to

https://patchwork.kernel.org/project/linux-acpi/patch/20240428170841.487584=
-1-tamim@fusetak.com/

that has just been applied.

Thanks!

