Return-Path: <linux-kernel+bounces-88544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 324DB86E331
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68CD1F223FE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F209E6F06D;
	Fri,  1 Mar 2024 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9eAhn31"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73DB69D0D;
	Fri,  1 Mar 2024 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709302777; cv=none; b=d2RmQtZIyMXSE1ErRmMvMQsh+nBIrOO1o2/qmfVEmuR0TEyeEeB5UvNF7hyd/i1JpsIdv6MXpNCwm2FvncRZDG1UN4qgGh8ylwM8iO+fjEk+xaeEX/bsXLAayhHtSdcBWuHPlHw/GDrHD4q3VMNlJj6BapU+Fw/IMaOXz10P+/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709302777; c=relaxed/simple;
	bh=oWApTNsFnjDQr9F2G8qFXul4Y3OtYCYATCmwSwhoKHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZupSA1VCf7U4bdmkg1VqDwYHC3b/1eZIWNsZGp2RZ51sRY88HxY4ABv9mRBiOTpvlpk/HB1tGzhXaK32DsjYqMjrUQoHnSvIbyQ2YFJF8DK3Ul9cTE05PJQfe4q+UXlLk1XvmNytGnFOCFX8iIj/hbaka1rUDOD43HUZIkWYbT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9eAhn31; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3566c0309fso298370166b.1;
        Fri, 01 Mar 2024 06:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709302774; x=1709907574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWApTNsFnjDQr9F2G8qFXul4Y3OtYCYATCmwSwhoKHg=;
        b=j9eAhn31ZSLOIeNbTkNhNhUXtZLvMlF/YROMVlkVjZVJBZGgqgnqTgwYb0B+w4Kq5B
         IHHEJobvpoNG7saTdLwtC+TiuGhC98ojrA01plLB/Uq7ujEPfZdLZ0aublZBgVqxLJhh
         wGRK8PkoNO4BPF1+2t1QU53z/siBt1DHk/TSh42lkxSDhc/OPcq45CBa/8orJ5F1KfTA
         0NF3/Y9Y4nrJMvGTYKrsDpGL+0ffUzeHGdNwSd1iDfC4//t5ZysLAnNQCiv4G/ZSpDk0
         81mwBUMLeFaNZSd9MT9cbITcRpsDSfqzhymYuwrdk9rUg1mpzWUhM73y3Dkw8m8/6Fze
         1KMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709302774; x=1709907574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWApTNsFnjDQr9F2G8qFXul4Y3OtYCYATCmwSwhoKHg=;
        b=ZbJYdbdG/r/70QqzdqR5LBK8bIfMNCo4xBylT2BZ/EA43YdD/WELdk+fevEPn9goXI
         uCPQgZOc/BrLDoxV6m//lWM6njjc6vwMuQS8N7OqZtib8w5hqOw6hYb0gKCltboQzxP5
         aIvH1+EVF6kykKY8KnNR/uxJF3cpD7lbre2kvCWRP4P+She4CyV1BG7hvMhdOrghLv40
         aivsdvSaF+zojFzZCJEebaeL3uZGJ6cFYuNK+bEarMhP2bl09VEYha+Gwbdr8163ncwc
         CDAMdNtAWItYjt7hCpDndH2arsjUNan0f14Yq+BclVGwl5psjvamyjj9fhZCACLhmx5/
         I2Vg==
X-Forwarded-Encrypted: i=1; AJvYcCU7tbc+29iYWkcTWk7WemZmzZjz97gprtRUrywNpcEq2Vfmi/Ls5lASyLbWBrZCDQyw7simh7rrB6CW1DOjO4Bar+eQaX9JdxIi17e98VCNHWPy1CCLO3LenXBkSCRZYjsoiAflS2qp
X-Gm-Message-State: AOJu0YxFn9nStIPVEmnLWQgXsyKW2mmLyQyEg5UivpVGrNkqtjtxmcqh
	y/TT8K0kd3wCZPMPr/XiJC2kf1HJXzuyQ27+tMxoSSift6JKRPlbDOYm7ppzz38Biira4Soxm0R
	gWBLzTjif/AYCV1b3YVlYT4u+S6EVEuLjrD0=
X-Google-Smtp-Source: AGHT+IFXEHGsIrvwY+jV6XUZNBG6TKiT9hS0PoYaCnN9n2zNF0X8feRu3Vgf1Iv4zRSPRvLBYPmXjCUkveLQ0Rx/KKI=
X-Received: by 2002:a17:906:40cf:b0:a44:21db:5f24 with SMTP id
 a15-20020a17090640cf00b00a4421db5f24mr1557315ejk.66.1709302774084; Fri, 01
 Mar 2024 06:19:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227131410.35269-1-lukas.bulwahn@gmail.com>
 <e6441dc1-6821-4514-b285-ebc24114aece@oracle.com> <fc6563ac-e705-48ff-9581-ac4154a064ac@gmail.com>
In-Reply-To: <fc6563ac-e705-48ff-9581-ac4154a064ac@gmail.com>
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Fri, 1 Mar 2024 15:19:22 +0100
Message-ID: <CAKXUXMxtp2LLWasuU6oJU9zV8EcCL6h4RdbopVF-RexH+-Z5OQ@mail.gmail.com>
Subject: Re: [PATCH] docs: drop the version constraints for sphinx and dependencies
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Vegard Nossum <vegard.nossum@oracle.com>, Jonathan Corbet <corbet@lwn.net>, 
	linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 3:33=E2=80=AFAM Akira Yokosawa <akiyks@gmail.com> wr=
ote:
>
> (snipped)
>
> Lukas, many thanks for doing this.
>
> Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
>

Akira-san, thanks for the review!

Lukas

