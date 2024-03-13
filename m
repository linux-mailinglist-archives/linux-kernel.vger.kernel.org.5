Return-Path: <linux-kernel+bounces-102453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D5987B29C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D24ECB27F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DA64C630;
	Wed, 13 Mar 2024 19:52:43 +0000 (UTC)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE7C818;
	Wed, 13 Mar 2024 19:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710359563; cv=none; b=bfkfZT+tZQsNcS7yyiPdjryUSesA1X31IcxdYYyf5V2gi47rdw7nKNUMc1L/wDbxJEJjZW36/ZHgWF6sVglSCNX1wa9xMSoK5sxNeowmYt/IHRPm4sGztRp8Zdj/wtmmwBacQHQE4E755q7vBXg9+dNVTb68weOcqLa/NEqbMgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710359563; c=relaxed/simple;
	bh=3YzoVlwIF1iieFyYn1mdafpqQtsXqd13TNxdyyO8++o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxPlq9TZr0ywfFlU+Lnj8mJ62iBAt6FzGQPdPkUrL5EXPSn3KO88XNr48bZ69AwIqDPEMRWN+w4YIsxYekbcHNladXNOjCjQ+wY3XRk/tMeHyZiZz9ULyDQNq7oyVTSYidZj7FC/hVSC7o7VYBCjthxODkj5dTpY0/d3OHIfaXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-220ce420472so64833fac.1;
        Wed, 13 Mar 2024 12:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710359561; x=1710964361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsyYxxDckIJsGNwJdIcBtryvdcdG19TdU6Mr0Ia8P1I=;
        b=GnmaBG91JKqvVun/Wj0Gujr300fJxN8qWAEdjOkQDAjKBKXa5/2e0WdjR9hIWaG7/T
         hHTN2kPmvqtOVJ4r9mD6fm7DPjPCH4g31/c30U1Ap+58rcgdgmw6R5omLraAHMO/v3i0
         QJXZmKZ0M4m6D+F3imCk5N3zjB29PwZPrU+1zwVPbRgxczqPn2xGS6lPZKV6zIUmJgWc
         ZSjNNFpwH71G+PowbVx4CN+XdvcT3Ff8HbfQv+mMa6gqbD36VgXRpewY3KSK9Sji32pi
         C7b3Z4/IQ7Bt+udYDyiSFtGmGdt0FE99l0iz+pazolKmipBwO8ojTNiKN4VTj61eMIz1
         OeAg==
X-Forwarded-Encrypted: i=1; AJvYcCXmzpi+dgqGXqK+boeZq0XnILdyQLggBDCwerAnncaaPI+E715nQU8/TGeJEzRIqvnJ0D5Q0t4goalps/baeqDkFPh3zb7hsWVd01vFcBhJnYHD4cDX8LGsg6/c7DZnDR63DUSWtg4=
X-Gm-Message-State: AOJu0Yw1WRCuFEI8LR+V+70rkRJvRnnYf8LBluQu3NOmpACmOtO+OzFC
	nEkKiZZQsWD6YXonbH1YkG6GwDLzuQZDdz4ixkrOM4m5W5s9NibCcHtSR27xIQwB5OOqzhRltZg
	e1pib8dzJMpJ2ZFbIlZkLWvgGUH0=
X-Google-Smtp-Source: AGHT+IFFi8nzhAb8uM1LSe/79phBF1NaxMX14wQLkupvPGA94MBnJn0aLn6QlcT0KEarEt5KsA5p/KryJ4YyhfBZj1A=
X-Received: by 2002:a05:6870:37d1:b0:221:bdc9:6a1d with SMTP id
 p17-20020a05687037d100b00221bdc96a1dmr2805997oai.2.1710359560806; Wed, 13 Mar
 2024 12:52:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308224450.2327415-1-saravanak@google.com>
In-Reply-To: <20240308224450.2327415-1-saravanak@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Mar 2024 20:52:29 +0100
Message-ID: <CAJZ5v0gn+FdDxsAtQj5d2CmBi+GpB0ATq+5QimGLAiovwOHCGQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: power: Fix typo in suspend and interrupts doc
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 11:45=E2=80=AFPM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> Typos are bad. Fix them.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  Documentation/power/suspend-and-interrupts.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/power/suspend-and-interrupts.rst b/Documentati=
on/power/suspend-and-interrupts.rst
> index dfbace2f4600..f588feeecad0 100644
> --- a/Documentation/power/suspend-and-interrupts.rst
> +++ b/Documentation/power/suspend-and-interrupts.rst
> @@ -78,7 +78,7 @@ handling the given IRQ as a system wakeup interrupt lin=
e and disable_irq_wake()
>  turns that logic off.
>
>  Calling enable_irq_wake() causes suspend_device_irqs() to treat the give=
n IRQ
> -in a special way.  Namely, the IRQ remains enabled, by on the first inte=
rrupt
> +in a special way.  Namely, the IRQ remains enabled, but on the first int=
errupt
>  it will be disabled, marked as pending and "suspended" so that it will b=
e
>  re-enabled by resume_device_irqs() during the subsequent system resume. =
 Also
>  the PM core is notified about the event which causes the system suspend =
in
> --

Applied as 6.9-rc material, thanks!

