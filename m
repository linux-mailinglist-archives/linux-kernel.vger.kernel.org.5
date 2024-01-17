Return-Path: <linux-kernel+bounces-29549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67156831016
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B74C28C6E9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7B525620;
	Wed, 17 Jan 2024 23:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhAU0Y24"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9A91E88C;
	Wed, 17 Jan 2024 23:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705533891; cv=none; b=iueRreiQbz6pTKF8wyxoRkhqglrbc2PWpx92jrqqFgl9HBCDRGO7wz89OLY51NNff5I/P6p3IOTQUhtPwCaHRmAlBP7e2xaYaXMHdwtrn6IO5z4eBSr5fwO5dLSfXJVvdDi8+MMXeF7fTWaU1tWQ6vC7//GrirZbLGsZcHYF2vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705533891; c=relaxed/simple;
	bh=PZxb9AvMiThVAwhHT4UaTU5VJkmSeombBohGnrrNpUg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=oSwf3h9nkWOAsjl/pelkkgexCSNJbSR3pj9kYge4tVrHjqreXH0W+VbxxAmeOcJhnoGYerETVCXek+ZZ7My+SmvVyJeO6VJ0rDHsAWFUm3wMDXssoCAdz+i+hnH8zz+1m+xbiP0D+Acvlf6DjaATQF5he8snPEAtRTyeJsNd1AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhAU0Y24; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2cad931c50so638088566b.1;
        Wed, 17 Jan 2024 15:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705533888; x=1706138688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rl+tQ9EKwfSB4gCOXNaSUJ6FtEKX7RcqnG6Ht3P/Ck=;
        b=GhAU0Y24pVoN0vAaHGpA9f5oTMFvG3Wxa9fSalTc7dAAc2onFhtHVgTiKrVf130bty
         cwEZ8zjh9rcTK3yDMGgCXldVksUdA0mo00kYQGGKTPIGInAHQyOJSf4YMoF3kF22f55G
         sHBwpE+goTRxogqGsHmY7eM7HRUrVlxMOGnIXbYkLLUVmvxtka4Hmak1o5pGOQh0L19d
         KMDK/nuYrXtOjgsKRBDc+xGIXtUfUkkRW77/Pdyzw0bID9E7zDcQyi/v9GYhklUxQW9x
         IzB3gabH6LTaA4kCYYJEj15JhefZBeiMQ7EjubXqXslI0idYlXa3t45VJ5tguSDi6+UG
         DLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705533888; x=1706138688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1rl+tQ9EKwfSB4gCOXNaSUJ6FtEKX7RcqnG6Ht3P/Ck=;
        b=a1mu4iX042BNfsjKsROigQb27j0Z8TCl9HjtFsVJcY1cOUH8dGcgE0X5r+KJR3E3QF
         rVEFFXS4X2SHHyGnnqA8IeKrqSXqHmPsnm2OtLJg2yI7QyhQqAGjC7yehObBD8BDgs/J
         ghqLKZy78sRZbgXCsopqYsPusgZ3lvKty/j5ll+9zd9G8gGI51+h+oU3n7E8tbt/sORS
         qABqyPj+GUnKZxpwv1kdsd+6LoAljtmAQx+wmjEWNYFviK/no+Dce7Gcs1fzSaYDDrjg
         5JbT1HWihpvZLjjqaT+4OjzrdhxCrhOC6Ujm2OwAckXZTiUFsXPMKxw3gWU38s5U+uX+
         AxXQ==
X-Gm-Message-State: AOJu0YwYqYaSpHstcE058xqaZbjPXh38Dkhx8lXgs59BFTBTHG+zUAST
	V4PjDm+J8s1d8Ekhd1r4xGc2bsjh/VywcPZPOX8=
X-Google-Smtp-Source: AGHT+IHo3Z83XqPy4DxfTALjbn9YEf5c92EblHYefRNfovl9+qqxOdQQU/gRkPt7BLFFZMTiKaaZ9WVLB6162X9P2PQ=
X-Received: by 2002:a17:907:a645:b0:a2e:8631:2833 with SMTP id
 vu5-20020a170907a64500b00a2e86312833mr1741166ejc.77.1705533888259; Wed, 17
 Jan 2024 15:24:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117223856.2303475-1-hugo@hugovil.com> <20240117223856.2303475-16-hugo@hugovil.com>
In-Reply-To: <20240117223856.2303475-16-hugo@hugovil.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 18 Jan 2024 01:24:11 +0200
Message-ID: <CAHp75Ve5PYQTRdxcffdQvYWJ-iwvfEHfMnL-vhs_mv7yg+GJ5Q@mail.gmail.com>
Subject: Re: [PATCH 15/18] serial: max310x: replace ENOTSUPP with preferred
 EOPNOTSUPP (checkpatch)
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	cosmin.tanislav@analog.com, shc_work@mail.ru, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 12:39=E2=80=AFAM Hugo Villeneuve <hugo@hugovil.com>=
 wrote:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Fixes the following checkpatch warning:
>
>     WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP

NAK.
It's a false positive.

> According to include/linux/errno.h, ENOTSUPP is
> "Defined for the NFSv3 protocol", so replace it with preferred EOPNOTSUPP=
.

The GPIO subsystem uses this internal error code internally. User
space won't get it, so users may not see this one.

--=20
With Best Regards,
Andy Shevchenko

