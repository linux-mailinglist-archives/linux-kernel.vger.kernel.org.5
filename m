Return-Path: <linux-kernel+bounces-121357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA6788E6EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CC2AB289C1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6A9158201;
	Wed, 27 Mar 2024 13:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzuINk43"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA08B13AD07;
	Wed, 27 Mar 2024 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545420; cv=none; b=YWYLcBe8pMXQsMtdkJL0Je5I4UGRo0bCsC/bbI/QsDJUQWNPbIERGO5Kx9LVZrTIKb2ZYnHZLHQfl2uv5dmo16t43NuWvvZ71fzT3EDD440hs+TMWl/Pb9v9k8rV7+kHvhit7vk9RrxN7K5ZviJjdxJ+jNU3JdQ1BFYQOKUQsqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545420; c=relaxed/simple;
	bh=KB772K6yfcU4hKXW7HSRS4muGDBCrt9ntzx2TSR19P8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SsoSf4c8xSfBx798rTa5le0MnNu/A/B59SlZlLzOd4dBldy24k4r+2vUAofD69UpquMe5nfepm1bsa2T1MFGn/Guwi8x6S8xN0g9KSOXGNBv/w776rf5ZYabYxkgNima1wOQ/AMkHKREmd7Q4I4LkB45U0dkyIY9RGKzvls5aoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzuINk43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F66BC43141;
	Wed, 27 Mar 2024 13:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711545419;
	bh=KB772K6yfcU4hKXW7HSRS4muGDBCrt9ntzx2TSR19P8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DzuINk43Tn1Mu46vGyloK0RcIZjT/o1tO37IhMTw3vGuY8iuvQbfC1d2wuhVGcsvu
	 11L2zxwsTwcE7XYQee6vDMJHq4r9cM8rR8tK68KarEE8Ls8MlaUQuo7iFtWeq4/4cm
	 vN7xbALw3d3LM7cP291/Wb2Iyn/8gooXL9HkTTf5SU72EIMtgU2ssAT51bz/1X0cGC
	 l3MOS7g4HXtAMKtJKR287UtUghHwkIv48hVcpsuz5cisQC2vkKx2Jv20NpVrjH03kF
	 /hRoBnhHkVLj/0Sx5qOGUttptO1hRrQRB0i++C/FWqVIh+128a+cZj7paJ2AKb6Fwp
	 Xy9pZb7E7FGnA==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e447c39525so77621a34.0;
        Wed, 27 Mar 2024 06:16:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/Zpw9U9pU55sehhvw0QccjCcGXkFRFuiKO6PrOrtXJ6v6OOcYe7R6RDkxjozZVkjiM1kTCeqiqaez6WxRdjPgWio2eH4BvRwVl1156q+qHQ+EWnYXZMlTdpo9CKty57s3QB88XeR3kbJdTmUICit9Wczskd0xygh9Tx78kBAWfwEUcJE8Dyx8qnwo3dsWHTLYgZUvxTLIAJ5R+NJ6Tnf9YycnkjIjGSJMVJ1sqRnOa5lNUPXRpzR7NJ8mJmngZSb6YA==
X-Gm-Message-State: AOJu0YxnMJwnMEeIF4/yTCOp3BQ0FRzgF3m4pk67FBnVrPTGLxoYSlzZ
	3jmzb+Sjjr01gwbyCyzfi353WKs47H4G7RL09Wmv3z3GymC5iskCyRA3bZQYsgaOXUKXmpGlsNU
	xegFZpBMr1O6rJ3JsZD0xbIlIdUg=
X-Google-Smtp-Source: AGHT+IHTd8oEHRAH3g6srEsbWrNzFluzIX84L1KgTi5gMkKVrAYaOe8Cp3nobmnxM/cXjJi/h1wt0g2XfJgmb7R2UWU=
X-Received: by 2002:a05:6870:b156:b0:221:399e:959a with SMTP id
 a22-20020a056870b15600b00221399e959amr13119078oal.0.1711545418629; Wed, 27
 Mar 2024 06:16:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327-b4-module-owner-acpi-v1-0-725241a2d224@linaro.org>
In-Reply-To: <20240327-b4-module-owner-acpi-v1-0-725241a2d224@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 Mar 2024 14:16:46 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hEiKJJWn-TVoyL6DEbCcMpL39_q+HLG_YZyjf9g29CXA@mail.gmail.com>
Message-ID: <CAJZ5v0hEiKJJWn-TVoyL6DEbCcMpL39_q+HLG_YZyjf9g29CXA@mail.gmail.com>
Subject: Re: [PATCH 00/19] ACPI: store owner from modules with acpi_bus_register_driver()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Benson Leung <bleung@chromium.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, Corentin Chary <corentin.chary@gmail.com>, 
	"Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, Daniel Oliveira Nascimento <don@syst.com.br>, 
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Matan Ziv-Av <matan@svgalib.org>, Mattia Dongili <malattia@linux.it>, 
	Azael Avalos <coproscefalo@gmail.com>, Richard Cochran <richardcochran@gmail.com>, 
	Jeff Sipek <jsipek@vmware.com>, Ajay Kaher <akaher@vmware.com>, 
	Alexey Makhalov <amakhalov@vmware.com>, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-input@vger.kernel.org, netdev@vger.kernel.org, 
	chrome-platform@lists.linux.dev, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 8:44=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Merging
> =3D=3D=3D=3D=3D=3D=3D
> All further patches depend on the first amba patch, therefore please ack
> and this should go via one tree: ACPI?
>
> Description
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Modules registering driver with acpi_bus_register_driver() often forget t=
o
> set .owner field.
>
> Solve the problem by moving this task away from the drivers to the core
> amba bus code, just like we did for platform_driver in commit
> 9447057eaff8 ("platform_device: use a macro instead of
> platform_driver_register").
>
> Best regards,
> Krzysztof
>
> ---
> Krzysztof Kozlowski (19):
>       ACPI: store owner from modules with acpi_bus_register_driver()
>       Input: atlas: - drop owner assignment
>       net: fjes: drop owner assignment
>       platform: chrome: drop owner assignment
>       platform: asus-laptop: drop owner assignment
>       platform: classmate-laptop: drop owner assignment
>       platform/x86/dell: drop owner assignment
>       platform/x86/eeepc: drop owner assignment
>       platform/x86/intel/rst: drop owner assignment
>       platform/x86/intel/smartconnect: drop owner assignment
>       platform/x86/lg-laptop: drop owner assignment
>       platform/x86/sony-laptop: drop owner assignment
>       platform/x86/toshiba_acpi: drop owner assignment
>       platform/x86/toshiba_bluetooth: drop owner assignment
>       platform/x86/toshiba_haps: drop owner assignment
>       platform/x86/wireless-hotkey: drop owner assignment
>       ptp: vmw: drop owner assignment
>       virt: vmgenid: drop owner assignment
>       ACPI: drop redundant owner from acpi_driver

I definitely like this, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for the series and I can pick it up if people agree.

Thanks!

