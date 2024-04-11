Return-Path: <linux-kernel+bounces-141588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6802E8A205D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6D81C21D85
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D951C686;
	Thu, 11 Apr 2024 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDQpnlld"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15021865A;
	Thu, 11 Apr 2024 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712868269; cv=none; b=aDKlB+IUbQ1hVmPjITRAqn9eya1stIcz9bGsKdOUW+VwYNNP243HX1hzFbdrg5jXCYHI3lN4LNCVgVDN8YtMzEY24rI3ZTbo2ej5wifoGK0UAyikvrfeEieUQjc+SL+Ns7uN2jr3UC3hgeb9lTWH2ARC+LqVXsYHiHKXfqC1lCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712868269; c=relaxed/simple;
	bh=sJRicuIMdyPXST1iBQBaTpdPs5znDsy3fUbKNGxvvP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jE993pWlzNdSaQenq+NSmCrUAs+kPGthCZSqsNYER8jXMqLxiQLGvJGyZUL4Wp5Itmxen2xu5gJvf+taPyh+YhiM+wBOqHScC5rFMBp3ygE69s9KTHoQ5JZfTKL9Jukp1JUb2J3Ry+7HUVpY3+Ah2CBAjwyOpZ7Wx2An/0BCh8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDQpnlld; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2a2d0ca3c92so181989a91.0;
        Thu, 11 Apr 2024 13:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712868267; x=1713473067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vC6CFfrU7nNG00X2ZGZqSPYkqlRpBYfzzvwanWOLN0w=;
        b=jDQpnlldzjEKWuaaZXfC2OIHSqJ4gqMcF42HQs/xGgJYuZA5AeWMHJYmPBbuXzBQ2d
         HGt8Mp0G4VxWauUt9ZA6LcPnIiVh1OsufkzcDRIeajxjiftutouDGz50k/4/N+6Pk2SL
         7bgtMDzNwVC9OWwVGnlsEpi38zVIXsqRWhXKalHEPgn013RD9wbEamBGt1pOiV5SvLHD
         uGJ75bdgmsiddgv8c5dQOqgeWhRu+2AUqYcCJf3Blx1vhSuFEB3srUxqYI6HzyBdj4fL
         q1QFukweTfvk1yVezbk8YXqROwFiRxtHuY3Sp/qNq0kXWhWeH7JYvb3dQkcm+2qAw5nI
         wNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712868267; x=1713473067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vC6CFfrU7nNG00X2ZGZqSPYkqlRpBYfzzvwanWOLN0w=;
        b=IzKEJFHzumDhass2aGsDRIMDcD+GwOzeqmoeajdmwK4GOus1RaJGl99hrJQLbtRSm+
         EAOIy425DV6jZu/F7k9KKQqB5UeuRI5V0PY16vmuKftrMC8ARRAbn6sGkWfE1bhtMipE
         Bjzd1c0r50WX8DLlnQl4yvTp9PeCgQcQvpiKKx+XG8qt6XBCV8EK16QgIpqS89+btdeu
         yG/ibO6BUuMnpIhNKOWaAgISEWAO3F7cP62VXOqccobrwdOq0EB9sq+0wTuSaSKKbEN0
         RhbUKJigQXb0nSFpIqGZjrAGv74csqbMURsF6+oL4Kzn0l8bNuTO1uY1hl4VcegQ8ODH
         Ccyg==
X-Forwarded-Encrypted: i=1; AJvYcCXKXGH7oO7FdNK2gJwXJUzhbtQsYr9lp2tH2W5msSfEpq0FkqOsFjfV+KY4mlJ1d3kn9ws788tRRuMtEZ1BP9o8Dg5v65Z9RCMSvxM/Tkmh5hMgDRm6M6jti9Dz0mI4I23XGQnCwd9+4Q==
X-Gm-Message-State: AOJu0YwjIaFiQMnUDGmfjmcFrB/Fxgq/Ch+iXmA08kUpGM9gy3OErv7O
	PBSPcCuHH087+QsoSeuHMaUXqKpWTIclpINj24SVTTJy1Rp5mQLwoMaYdyqVA9Ony7bURP84zPQ
	CBusNZdM03kkvguD4IA9BVMnTFKzm2g==
X-Google-Smtp-Source: AGHT+IGiQm77cSB4QuSfQ02Bfp5Rm6BkGApg0uafJ0k/8V2knSJ7Kwp/cNvH2c29/Sa95IMhd1Z6a7OXTecubQVEk2g=
X-Received: by 2002:a17:90a:df86:b0:2a5:3f30:f5f6 with SMTP id
 p6-20020a17090adf8600b002a53f30f5f6mr1007173pjv.20.1712868267056; Thu, 11 Apr
 2024 13:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72mdRgMuQVD53Kp=hqaoiSNwPVZVSrbbMxRYehi73FZf9A@mail.gmail.com>
 <mhng-7603cdcc-24ee-4b19-b049-64d1bd4151b9@palmer-ri-x1c9a>
In-Reply-To: <mhng-7603cdcc-24ee-4b19-b049-64d1bd4151b9@palmer-ri-x1c9a>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 11 Apr 2024 22:43:35 +0200
Message-ID: <CANiq72kMvJAKCbOhYXZgUbfrHjeskRsW_FpL=TkfYa19By64Hg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the risc-v tree with the rust-fixes tree
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Walmsley <paul@pwsan.com>, ojeda@kernel.org, 
	tim.chenbw@gmail.com, Conor Dooley <conor.dooley@microchip.com>, gary@garyguo.net, 
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 9:59=E2=80=AFPM Palmer Dabbelt <palmer@rivosinc.com=
> wrote:
>
> I'm assuming rust-fixes will make it up to Linus well before I send the R=
ISC-V
> for-next (ie, next merge window).  So I'll just call this one out when I =
send
> it up.

Yeah, sounds good. Thanks!

Cheers,
Miguel

