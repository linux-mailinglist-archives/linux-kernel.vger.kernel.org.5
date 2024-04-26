Return-Path: <linux-kernel+bounces-160495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 978778B3E3D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54388283EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D931F16DEC4;
	Fri, 26 Apr 2024 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9eZYhzH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C0C159585;
	Fri, 26 Apr 2024 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152592; cv=none; b=fpy0CUuOImGAe+5QebKhERVqzxNeP09HqyROl7BOBf3ytPpBhJYf5zTtb0szglKBzpYdhxMWnicN5X67FkzW59eKJ35X8rCcJ46Q+wdDMyPipxWbkessKdo4yrcvkpuETMGvu/HsI1kHjt4nmj0AU6yyAdih/PLT/3Q71Bk93Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152592; c=relaxed/simple;
	bh=BJdT96jPIV46Cyv8V9wT3gVr7uDS8d+LlcDE6fFZ5jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJHW2tPZrxWDq5DgSYTrxRKbXZAkmtCSmZFAvQCukqBJUxapUrLKzX03q7NtBsjCfa6m8qVL+TB9irAsZv6QSyLP/bdVP876aqJOBNQWJNr/c+Edo+XqmYPwNIdcN/tw4CzsKQWllOytZEc39jssd0+K0toQBATrZMLTVkZxoBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9eZYhzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77FCC2BD11;
	Fri, 26 Apr 2024 17:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714152591;
	bh=BJdT96jPIV46Cyv8V9wT3gVr7uDS8d+LlcDE6fFZ5jc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R9eZYhzHYbpCnw6emCRuXhNy5ntEmQkWwRLKu9hOvtlqozJvxMqPqqPq/diTjElXy
	 KfXWyYfFERQ662OTH/H7Av8hdK/0hO4EjyF+tmB71c35nnnwiG9XliWCncaI0HVDmF
	 SmO0NoDzfAJF7D7eiP7o6x7l2397ESMNRvOJViOSA83cIlT5qnr5H0gIqGSRo/Kfjx
	 onOt5AHSXo/CB/KhpyC1epHpCFWPQTH4F1MLcEK7ugrtc8X3LAmNB6Z7t1nL/7BGXZ
	 HcVqy/CSWQWw3HE3dI+MnxpKYPJus2iberq132qKojJ7dO2uTWocJSW/JSBC/mXf6s
	 ncG38ur5oyuqQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5acf5723325so635413eaf.0;
        Fri, 26 Apr 2024 10:29:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWXGNKiH2go4dlVOhs5/SWZ+AM6Rto17pagIMLYVd4936/b21WMZZHKc2ZXjrmMOdZSjdbbayaAQt4a0ucohmCk1NovBGbM5PcVBBxSrja5PHJtVkiw1EUjIYL4dbzr+t6lccy7hwd2uw==
X-Gm-Message-State: AOJu0Yx+odBv4d/ZwfAbsdkpEY7FCwHvobObE1+hKXyHAWJg1wpGkHhO
	20sDB/wIbXCDMa+LTHcTxnjvda5M5xyRiwpSsBW+7m7b2sYO6ZWSytvi0DZGpKWTrW38DD1VpIo
	Evk1fMx5nkcmdXsl8aI8N6TF6P2Y=
X-Google-Smtp-Source: AGHT+IEKbrS5Zi5PgkIPEXoqOznTo0BLcEvDy7UJ48p8ejOZzjyXJV2c3/hcdXqwf9hgqMpGLXG8v8ZUUihaib9nqLs=
X-Received: by 2002:a05:6820:e09:b0:5a7:db56:915c with SMTP id
 el9-20020a0568200e0900b005a7db56915cmr3849839oob.1.1714152590854; Fri, 26 Apr
 2024 10:29:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426094850.757123-1-yu.c.chen@intel.com>
In-Reply-To: <20240426094850.757123-1-yu.c.chen@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Apr 2024 19:29:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i5XhOzLr+9yrjzgM+GntFHFW+pQGV6EnHfNEoatXjjOg@mail.gmail.com>
Message-ID: <CAJZ5v0i5XhOzLr+9yrjzgM+GntFHFW+pQGV6EnHfNEoatXjjOg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: tools: pfrut: Print the update_cap field during
 capability query
To: Chen Yu <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 11:50=E2=80=AFAM Chen Yu <yu.c.chen@intel.com> wrot=
e:
>
> There is request from the end user to print this field to better
> query what type of update capability is supported on this platform.
>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  tools/power/acpi/tools/pfrut/pfrut.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/power/acpi/tools/pfrut/pfrut.c b/tools/power/acpi/tool=
s/pfrut/pfrut.c
> index 388c9e3ad040..44a9ecbd91e8 100644
> --- a/tools/power/acpi/tools/pfrut/pfrut.c
> +++ b/tools/power/acpi/tools/pfrut/pfrut.c
> @@ -174,6 +174,8 @@ void print_cap(struct pfru_update_cap_info *cap)
>                 exit(1);
>         }
>
> +       printf("update capability:%d\n", cap->update_cap);
> +
>         uuid_unparse(cap->code_type, uuid);
>         printf("code injection image type:%s\n", uuid);
>         printf("fw_version:%d\n", cap->fw_version);
> --

Applied as 6.10 material, thanks!

