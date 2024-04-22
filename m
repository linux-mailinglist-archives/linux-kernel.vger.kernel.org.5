Return-Path: <linux-kernel+bounces-153702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 066638AD1D9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F763B25ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFCB153588;
	Mon, 22 Apr 2024 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2Ac9w0n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7201E49E;
	Mon, 22 Apr 2024 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713803048; cv=none; b=O/dRe6XhpJ7MTF+dn/aeg60YWPw5CUkZYVpJImtUSU79vmMqBp732IfnaExAGvL5Db+s4ZGvwzXYKv3JksfXVzSdwPPdzCEy0X+qEqVpF5tABtQYdFqmCXQAxOFxJyw/r/uxIYrGHfcB0eoDhiSwaH0BIEoYlHklOXOg4I1Xx60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713803048; c=relaxed/simple;
	bh=U/rBD+zuwxM9BxP71a0HT6BXbDy9zXeKfLaS8jskugA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TCWi/vJx3UZVeIa9ovxVj44iCr409lhQuh8lAyAQmFqr5Ltbj3DjgCdNTxyIh26iufhMXd7Do0QLYleer01a/zqDBZIdJP34rSQ+RIkX4jjJ6264ObKjG9/6m97y4cSdzGlUFAtTGDxrBjO3Tr3OvfH1ZvcsGvB3dnNnjUwkWW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2Ac9w0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A18DC113CC;
	Mon, 22 Apr 2024 16:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713803048;
	bh=U/rBD+zuwxM9BxP71a0HT6BXbDy9zXeKfLaS8jskugA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f2Ac9w0naqt4H5FrrWTNVvcbEA9GGD3rt/ogVMYU4YHWglLJs48cGZSwqjFM3lYI2
	 ghUvC4/ooul+xf2iU77kJZPHkvPxtt9eordC8FDV8fQgBVW3Rl9mdq1KbZ4Lvez7N3
	 lVZ5iG5WEO6+7cuncxSXTw4mNYaWV8bqoerjYiO365T2tt8/+dpA/5YGFuKAb2lu5y
	 GVlS6/v7CsI+qNT3fERiTlnracEMAXH8TqLN/1VgcGRbXlbzRugD8fcNN6I6CqGdLY
	 u3AtLYq1M9HnHKdC2bOi1A9kVxu6XoNiJkggrE+iOKXW+HTvganp7aFvucAkCKtBFp
	 V/TdIFG4Hy0Vw==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5acdbfa7a45so1491931eaf.2;
        Mon, 22 Apr 2024 09:24:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVh36kaPe+gn7FCQAFxaJC6J9oZTCfoe+FfkmcyqFsn6+2Xk9LeE+EwVvZlyGsQKk+JqsfkbTlEPfU3FefBmL51K/U3Znw5dTn0AA6IkxlVuuwpFsauUEXhJPAWRtbE83DcnMbjz2OA9A==
X-Gm-Message-State: AOJu0YwgWznE1hLURixgEJU3qz/Ig++VEwmG5Mipp/uxSABr9O/PokS3
	d+ZGxeSsunFsdqULMYcnujAuA25n2g2Dzlik1GT0VK0h4yt/V26QDXSYd3T8z14xxGKuxTZpH/s
	4qs9OkwJBlcB/98Tt/sOf3ugetys=
X-Google-Smtp-Source: AGHT+IHp2/+wxwVGAkGABcddJLJzdg5bU4VA7n9LIvmsHhyt4EpYdamJ34te3uwK1TRL+xbMf87x7ciCDIQgfUl5Bd0=
X-Received: by 2002:a05:6820:2c83:b0:5aa:6b2e:36f0 with SMTP id
 dx3-20020a0568202c8300b005aa6b2e36f0mr10555703oob.0.1713803047481; Mon, 22
 Apr 2024 09:24:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415185120.57973-1-gschafra@web.de>
In-Reply-To: <20240415185120.57973-1-gschafra@web.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Apr 2024 18:23:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jmtH6+C=GcWxXLM3qXBoMvuC-Nz8fuBG=1Ha1g95atGw@mail.gmail.com>
Message-ID: <CAJZ5v0jmtH6+C=GcWxXLM3qXBoMvuC-Nz8fuBG=1Ha1g95atGw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Do IRQ override on GMxBGxx (XMG APEX 17 M23)
To: Guenter Schafranek <gschafra@web.de>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 8:51=E2=80=AFPM Guenter Schafranek <gschafra@web.de=
> wrote:
>
> The XM APEX 17 M23 (TongFang?) GMxBGxx (got using `sudo dmidecode -s
> baseboard-product-name`) needs IRQ overriding for the keyboard to work.
> Adding an entry for this laptop to the override_table makes the internal
> keyboard functional.
> See https://www.reddit.com/r/XMG_gg/comments/15kd5pg/xmg_apex_17_m23_keyb=
oard_not_working_on_linux/.
> Patch was successfully tested with Arch Linux Kernel v6.8 under
> Manjaro Linux v23.1.4.
>
> Signed-off-by: Guenter Schafranek <gschafra@web.de>
> ---
>  drivers/acpi/resource.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 59423fe9d..c9af5d2f4 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -533,6 +533,12 @@ static const struct dmi_system_id irq1_level_low_ski=
p_override[] =3D {
>   * to have a working keyboard.
>   */
>  static const struct dmi_system_id irq1_edge_low_force_override[] =3D {
> +       {
> +               /* XMG APEX 17 (M23) */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_NAME, "GMxBGxx"),
> +               },
> +       },
>         {
>                 /* TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15=
 Gen4 AMD */
>                 .matches =3D {
> --

Applied as 6.10 material, thanks!

