Return-Path: <linux-kernel+bounces-57868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E2E84DE60
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3C21F22F07
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96C34205A;
	Thu,  8 Feb 2024 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPHhS4ob"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBFE1DFF2;
	Thu,  8 Feb 2024 10:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707388339; cv=none; b=TLzFTBSUJnsrrFgOxAlEde6z6G4ha7RkH2/0xbusawl9vQMzVyrJMag+cP6HKfA4Ny2mZgtMp1hgG3g525BuEx4HigpGly6OTwP/UoJW50t5uYEFCOyhv3Kcca3j01mLXHiWp8gdeK8bxDUQT2t7S8AhoPqIf5NhKciVVyGZb7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707388339; c=relaxed/simple;
	bh=ct2XFvWhqpfoUsfCy+F5xMjFMJpQ0jg6R8meoFXaZyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJ75iC4wicMH0sQWvPMGcSYwokvRkQkMRTNLTBEn+ZCYovSxGEQOSr+zdZmW7O5Ay6TAAIrTxBnq35noC8x/b0sfph2TJLrjDIpxsV4NeLrYcd38jtsax7wlSdh4WcgqFG3XdIFO7VCT+tg5ZSxTGvU9BOdLJFowfp4EIOQdCC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPHhS4ob; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc6dbac5fd1so547072276.0;
        Thu, 08 Feb 2024 02:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707388337; x=1707993137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ct2XFvWhqpfoUsfCy+F5xMjFMJpQ0jg6R8meoFXaZyQ=;
        b=YPHhS4obmlfkzs9IbmbaJ1/OhEzshA8OpaNlRdZdamVKCPaaZIrvj9JjLudBFuRcyq
         VY5Ml+Nee06ccDbsMazFKfM8aKjkLl0wWBJi8Y7wWAxBnQZCQwu2wcEBucUGAmJSbXLU
         FTkdLS97yh1IxeAEcaspJDk7kwc1CRcZDkodp6HueFRRgxIG9yJjKoAxb8/mF6uDdQw0
         25hAnLgu+GppMW/U4lb7Rmd0/3tUJRIGL3y7ZBPSaAuggmvB4pneHTYABcb+s2CUujYA
         bOSt0nwV7JuLjoi+88HEFjvDSFXUOCmzYB12SwDDR+YmoKvcrmQUQl+/G8JBoVJJYYfY
         7yug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707388337; x=1707993137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ct2XFvWhqpfoUsfCy+F5xMjFMJpQ0jg6R8meoFXaZyQ=;
        b=XR6dKi8NK2CUmmE9Gldak2Bap5DqFUmiboW2yX91N2h9hmAmBx1P5drSCO6lqTOoCw
         G9WNR+tnrIFVlyqTxvz8f/yYKqcPkLkkpgBUv1I5Yzen4yqpmJ5prKs67/gvXE94IjEs
         T837jjoJwFOGm5wK/rA6ZwUK6U/W9KnEuCIQ+W7D+rEEVbe6HQPNJfvZSbA+4chpQBJn
         3kZBvR+DaQ8IseJes4OUG2zqD8sDff/hzPltiD02V4neTbV3jLQpRzYAjUDR1TPxRipk
         z12gxxFeQWeET6UuiXZeh07NPbt45Z6LV7HUI34s0fYZv7CTxz/iqFvKNMLcCff3xPz6
         2pWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCAMiDqvz5rXzEvvmWO6AX4fPMNySk2cZYrFWSYJ2id5BEjGb4gq0/ucuXr9zCNfu4aQkO6MVfNlli6FEvNrhKo01BBUP3qzZpfAZ6RQZ+a586d/DLMPU+5zkRYPhXHjaxU4VuoJIf
X-Gm-Message-State: AOJu0YyJxEiDLBNJqjiyL82M9FaJLNHcHJ8qivoY2jFEC+VQYHKte+12
	qmsH6rRyBS1M3kdcCu4gsPHdkOZBNZ/rc4dZTLKkyuWFnVAdkaV7zz+rbk3BkJOeO6hwSWgDFbU
	3CCIPKAD/Fd5oAcTIQjcNmfqHRAh6YDY+vdQkHUPzBkQ=
X-Google-Smtp-Source: AGHT+IE6boa42YcgBsEDGRBfyjaqIyemxo4ljX/7BDmTidXqujpn8bc6Ol/zQxc9UfNiRHVnb4GNFyU6wGFd9TgPMYs=
X-Received: by 2002:a25:8389:0:b0:dc2:294d:5adc with SMTP id
 t9-20020a258389000000b00dc2294d5adcmr6701737ybk.0.1707388336606; Thu, 08 Feb
 2024 02:32:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>
 <Zb6D/5R8nNrxveAP@cae.in-ulm.de> <Zb/30qOGYAH4j6Mn@cae.in-ulm.de>
 <CABXGCsPu73D+JS9dpvzX78RktK2VOv_xT8vvuVaQ=B6zs2dMNQ@mail.gmail.com>
 <e7b96819-edf7-1f9f-7b01-e2e805c99b33@linux.intel.com> <CABXGCsPjW_Gr4fGBzYSkr_4tsn0fvuT72G-YJYXcb1a4kX=CQw@mail.gmail.com>
 <2d87509a-1515-520c-4b9e-bba4cd4fa2c6@linux.intel.com> <CABXGCsPdXqRG6v97KDGy+o59xc3ayaq3rLj267veC7YcKVp8ww@mail.gmail.com>
 <1126ed0a-bfc1-a752-1b5e-f1339d7a8aa5@linux.intel.com>
In-Reply-To: <1126ed0a-bfc1-a752-1b5e-f1339d7a8aa5@linux.intel.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Thu, 8 Feb 2024 15:32:05 +0500
Message-ID: <CABXGCsN5_O3iKDOyYxtsGTGDA6fw4962CjzXLSnOK3rscELq+Q@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_This_is_the_fourth_time_I=E2=80=99ve_tried_to_find_wha?=
	=?UTF-8?Q?t_led_to_the_regression_of_outgoing_network_speed_and_each_t?=
	=?UTF-8?Q?ime_I_find_the_merge_commit_8c94ccc7cd691472461448f98e2372c7?=
	=?UTF-8?Q?5849406c?=
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>, niklas.neronin@linux.intel.com, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 2:23=E2=80=AFPM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> My guess is that CPU0 spends more time with interrupts disabled than othe=
r CPUs.
> Either because it's handling interrupts from some other hardware, or runn=
ing
> code that disables interrupts (for example kernel code inside spin_lock_i=
rq),
> and thus not able to handle network adapter interrupts at the same rate a=
s CPU23
>

Can this be fixed?
Can I help you here with anything else?

--=20
Best Regards,
Mike Gavrilov.

