Return-Path: <linux-kernel+bounces-102464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB64587B279
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5119828A90C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BCF4D108;
	Wed, 13 Mar 2024 20:04:04 +0000 (UTC)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB834CB35;
	Wed, 13 Mar 2024 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710360244; cv=none; b=h8sIQyt84oiN8qOYlzjIVtCzMXrOOA17+9N4Sq/ihKEvHEFDOYNFR38doqN2udJaXrqcQcecSlcAcK/MqZfrdERrRCOhDsNRMePtPxtrqX1si4qFtonCC/4zAQnzehjUAaHIIxomcRzB4bH4/vqn/BRTKa/jQ3w/4j1yZ7QGiyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710360244; c=relaxed/simple;
	bh=HpnEoUB/oMjy6t9QQon1zh6WUkd8bXZJNBtBgtGcZ38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C73sVRYyk0Ra6n2F+nJhbkb4GPtK250CPjHId/aeIO+ZylytvEFE4UeP9UGIz99dDobGYckE2c8bGEgb6pXmAuicWxbH0OwFJ617cGZJOkjyGv0P91VhsuZZvY6oeEppuS+jjRF2tIXw0BV8PIp4MCJeYiTVWq/Zrd8IRJZQqgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bc21303a35so74928b6e.0;
        Wed, 13 Mar 2024 13:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710360242; x=1710965042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HjfA5JeS0LPF5tA3E2BddNSyfSC+siJkaEjPswhwp4=;
        b=vFtyYy0lhshYq+oFdf80W6M7s5/neMjUvJ+jLWA9LMSFFT7hbPNRZ83YO3abBp2ImJ
         NO4wzwaf44kEB+BLZCq1mnAbgqAURroZQEbjyQr2hUTdJXAPdsGsrcOOFizddWonNZCP
         9bF70SHg4f6NC0Q6Il2CAHodwc3dkrd6K+XDrh8QmLzc6gWl8Yw3f3DZK8zJ2BcExDO1
         d0ZcdGUgQwiWOtuPtbgibK3opf8jFRT9WORsM547dDdVfP2L4sliJ+cIj1KWvrLzCiiT
         dVxPQmWhOu0yzljWWY7uK2w5SQyGei8mGd6t1HvPqe1iSf8gqNpAMyCEEFkeocayWQuY
         Hqcg==
X-Forwarded-Encrypted: i=1; AJvYcCWOAAeIdJV9eKh3FrKkB6i2aFeGbGPSkJq6+42vabV5fDR7lhKKAwtVioTxg6VwmyS84o8UVUNUjLVUr6hUAYmm3noWMpf3hErDvCht7Y6R0cmsM/wdZXdunkcRjJipA7N5leg3PqI5/w==
X-Gm-Message-State: AOJu0YwMXqrTJ7JUa312G4LtwhsAGHx+izrKHVkud9LFPeUacf814r26
	HIvAQzMKRFQExpQIXMYXYBUhh9TKUJnlHz4JU6p6xQPIfbBaVGrJVHUYVQduxj3La8uQh+6sSbA
	mR7TOEvxkDNioAMrkynTHxVqOBb8HFjJX
X-Google-Smtp-Source: AGHT+IGoah+dWg2O7jbUzVhRGML+Fdut2kM0oYls7T42xhIzyeWm7X4GmCawVRkDOSnQt1bBxxcOJyOGsW3fPjozBw8=
X-Received: by 2002:a05:6871:54e:b0:221:c9ef:43f with SMTP id
 t14-20020a056871054e00b00221c9ef043fmr11194388oal.1.1710360241762; Wed, 13
 Mar 2024 13:04:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308073214.11262-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20240308073214.11262-1-yang.lee@linux.alibaba.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Mar 2024 21:03:50 +0100
Message-ID: <CAJZ5v0h0KwKE9QOZSej6HVR1WePw_jd=GR03hDd_Kg6Fo2s3qA@mail.gmail.com>
Subject: Re: [PATCH -next] ACPI: Add kernel-doc comments to
 handle_eject_request function
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 8:32=E2=80=AFAM Yang Li <yang.lee@linux.alibaba.com>=
 wrote:
>
> This patch adds proper kernel-doc comments to the
> handle_eject_request function in the ACPI dock subsystem.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/acpi/dock.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
> index a89bdbe00184..a7c00ef78086 100644
> --- a/drivers/acpi/dock.c
> +++ b/drivers/acpi/dock.c
> @@ -380,6 +380,8 @@ static int dock_in_progress(struct dock_station *ds)
>
>  /**
>   * handle_eject_request - handle an undock request checking for error co=
nditions
> + * @ds: The dock station to undock.
> + * @event: The ACPI event number associated with the undock request.
>   *
>   * Check to make sure the dock device is still present, then undock and
>   * hotremove all the devices that may need removing.
> --

Applied as 6.9-rc material with edits in the subject and changelog, thanks!

