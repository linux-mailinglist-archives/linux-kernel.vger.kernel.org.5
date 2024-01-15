Return-Path: <linux-kernel+bounces-26198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5C782DCA7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C6A928426D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D2B17984;
	Mon, 15 Jan 2024 15:52:40 +0000 (UTC)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D71A175AE;
	Mon, 15 Jan 2024 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-598a2136259so487428eaf.1;
        Mon, 15 Jan 2024 07:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705333957; x=1705938757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWCyVuLmjKCX2AH0GVEqB/8MQb1jYnVII0XyIetB79g=;
        b=o3bCV75qcwwGmpW9oqsRwN8K37hicn0hA9FkUpBMa2QwHKW0BGsamWmgrsmPaCC/KS
         TbCuJIFrFS3YlwNRwzqyXflM8jPR0w9FdQ8nUttCGxjoTb2ona4mlGn78xJs45EsWRk6
         pGsotUfsZDIR8eDZ1QEhaXAqdezS57uwlHHjJon0l7NbF3u+X6KxKOFGlb05cOVA85sd
         vqPef0q/hzE/ciNBe5JqE08A7ivnzXhUgm4TWwHL0Jfu7e4sGiY7sZeJiYgtiQOk1xpu
         VVYs/lr+ouoEQ89de9cvW7q9lO4ZgCtOYwoILXJwwqDmjSjegD8azRy5NsuxqpSKWDQV
         FPzQ==
X-Gm-Message-State: AOJu0Yy41zr1UjxYfkiN9YBtY/1IEpfKTJ+88iaxkToQHGQakIaEQrdB
	Mu6XWDYNkPzpg0cr7D8IaUKRr8PN29rnEPOhBEE=
X-Google-Smtp-Source: AGHT+IF1ND5206O/f2aXt75nrw6gwy+BG//zXogxViI+zYpQ0ITUpymsqt5wJdR6Iqib4Ds8wbbOIYlYDjyNK+QX/zo=
X-Received: by 2002:a05:6820:510:b0:598:c118:30d1 with SMTP id
 m16-20020a056820051000b00598c11830d1mr11370658ooj.0.1705333957212; Mon, 15
 Jan 2024 07:52:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115082507.29651-1-duminjie@vivo.com>
In-Reply-To: <20240115082507.29651-1-duminjie@vivo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Jan 2024 16:52:26 +0100
Message-ID: <CAJZ5v0jPeYgGc9xmSrnLsg6RkhzmU=TfPdhrzxWBd_d_dmJh+Q@mail.gmail.com>
Subject: Re: [PATCH v1] thermal/debugfs: Remove unnecessary
 debugfs_create_dir() error check in thermal_debug_init()
To: Minjie Du <duminjie@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	"open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 9:25=E2=80=AFAM Minjie Du <duminjie@vivo.com> wrote=
:
>
> This patch removes the debugfs_create_dir() error checking in
> thermal_debug_init(). Because the debugfs_create_dir() is developed
> in a way that the caller can safely handle the errors that
> occur during the creation of DebugFS nodes.

I honestly don't see what the purpose of this patch is.

> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>  drivers/thermal/thermal_debugfs.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_=
debugfs.c
> index a3fa09235da1..695253559a61 100644
> --- a/drivers/thermal/thermal_debugfs.c
> +++ b/drivers/thermal/thermal_debugfs.c
> @@ -172,12 +172,8 @@ struct thermal_debugfs {
>  void thermal_debug_init(void)
>  {
>         d_root =3D debugfs_create_dir("thermal", NULL);
> -       if (!d_root)
> -               return;
>
>         d_cdev =3D debugfs_create_dir("cooling_devices", d_root);
> -       if (!d_cdev)
> -               return;
>
>         d_tz =3D debugfs_create_dir("thermal_zones", d_root);
>  }
> --

