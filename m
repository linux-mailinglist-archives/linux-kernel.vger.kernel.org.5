Return-Path: <linux-kernel+bounces-60461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D722D85053E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163E31C22E1A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA485BAF4;
	Sat, 10 Feb 2024 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyPED/fA"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64322B9C2;
	Sat, 10 Feb 2024 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707582863; cv=none; b=dHVZ39w2wtvG1PJlQv/ZdK9W36ENF5aCjpxQ+GlygG1Vhg534Dcx8M+vvbdNElCbo9xTazaBM4bZjn8pS7slta8cGfW0WF4FU2ultThlP6GvBoPS+gfjpG4gf9jDFDx+UnkI7hA728SzKqKHexW3wvAkkwnTarHtk8VJxx2u0Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707582863; c=relaxed/simple;
	bh=Ktc49ggsnwEr1xhQzDFAayYH39FRXOX1ED7Hxw0AhIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bgQdwgIMb/jFPK0YVVazaVGPL2Tawj9ywECyLGHxBz7KV0bDlUd4+BxxS4B2l2S8cEQGoMPzgFFgmP1b4C6LGkmE/O3V4zHQHUoNJExE/Ph+e5z9cM0lXzZHT8r9kuceM4Z58MdsUYK2DWDJDigaOT79gNJNQ1UMoQ3YbScfg4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyPED/fA; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-290b37bb7deso1431770a91.0;
        Sat, 10 Feb 2024 08:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707582861; x=1708187661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lyJHFrg7zCWGym+YlMTg2RbWRQjPifpNEF3JissgL8=;
        b=GyPED/fAKotky+pjwYKRtNKvjHVhVqzre0aKEBXxIW0zSXjLAGtFMkXdbjGC3SYrDP
         ub4vnKzaM7F8AYtNd9VvE2LRvt1c+gMSeR0DdGXa0VXpYX9f9i2ZWlsFVunwpr2VpuKa
         W/6hZmaSlmQHlC4xPgpS8UJrpGmLYXY8eU/6BnmzRbajNsjImeFqxDwbdHmoSGoi348m
         WOs3cJLA1gKMdcNtSgXslAVsCExbwy93YfoM/w/MOro9X8ek+djkwNL68kx3oPURJ0fE
         TfuUk96aNgIKDs7/nb4e9uW+pCS/hWiU84FGOreRj+N1HocwZ9kZ3NCpgh09cZBlyfhs
         ecCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707582861; x=1708187661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lyJHFrg7zCWGym+YlMTg2RbWRQjPifpNEF3JissgL8=;
        b=R7kEmn4FX+/pGklwk0pHtg/JxDfGPtxeNdxU6iH7wL/7cVyXPbj2rtJLdTqhSjpeyj
         vLAKt74PkofwG6oXubQIRESlrzVzHf4V5O6Uu8LEjA8A8vUUr/8qKZwZ0SG9K9QYjArn
         X3XTuLZHz6Gd8ZoPwuVrpYrYQb2CblggoJ1gMI6A1OtpHbwpaTOsPPAgaQJkgz9yz60A
         43XRIq1O5qPiDzUKI3Iy8sEzmIP22INL4UYXzvFr8fB9rcYBcOJVqCSUKQPYo3aJU7N1
         3xz+DiT+07q30/XvHMRCB0lXp84xcmBHZv4Y2/HmMI9//yPs0FsuX93i72iWBOARY9va
         TqXg==
X-Gm-Message-State: AOJu0YyvlGEUQoQY7BgwClsHtDhv/IcInE8Elw9VYxgwjs/TPQxNa4AE
	4Hi365zKolklBqTb/XA1oXyGcc4uj20pkJXnMOUOTDVr986FZPcRqhBx2qZIcNdFp0Qahlc6IOR
	wijVPu49IRxVfUS8xNe1/H/mZc0o=
X-Google-Smtp-Source: AGHT+IFMWvYx8cuFwf+pqnbaAaxSl9M0MGFbQn+PShgZe3O3V43mko1Wr7UDySU/27keBm3fxQlixHx2rAJTKBh/OEw=
X-Received: by 2002:a17:90a:7408:b0:296:bf9:dc69 with SMTP id
 a8-20020a17090a740800b002960bf9dc69mr1848401pjg.20.1707582861060; Sat, 10 Feb
 2024 08:34:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203162524.343936-1-singh.amitesh@gmail.com> <170739214246.950581.13917324551294999476.b4-ty@kernel.org>
In-Reply-To: <170739214246.950581.13917324551294999476.b4-ty@kernel.org>
From: Amitesh Singh <singh.amitesh@gmail.com>
Date: Sat, 10 Feb 2024 22:03:44 +0530
Message-ID: <CABKcAmVsssKR8zCPwgODxcEuodCi_+m8GEdxzOVSJ5Gth095zQ@mail.gmail.com>
Subject: Re: (subset) [PATCH v3] leds: pca963x: Add power management support
To: Lee Jones <lee@kernel.org>
Cc: pavel@ucw.cz, linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 5:05=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Sat, 03 Feb 2024 21:55:24 +0530, Amitesh Singh wrote:
> > This implements power management for pca9633 which enables
> > device sleep and resume on system-wide sleep/hibernation
> >
> >
>
> Applied, thanks!
>

Thanks for reviewing.

> [1/1] leds: pca963x: Add power management support
>       commit: e684dcca3659a3f88945a2a5c6fe5a156d4b0178
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
>

