Return-Path: <linux-kernel+bounces-153598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0318AD02A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1C11C21D2B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C468F152DFC;
	Mon, 22 Apr 2024 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6oTyXj5"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70154152DEE;
	Mon, 22 Apr 2024 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713798269; cv=none; b=fFKHW225T1FhwsweJ0LgPzfe3gcra84ZJmx8aw3C3+Jefm5SN5c/Bk62YbiUT64T+Rzps6MT4OyUHZo9ydaqzFHvzThW0BI/l4MmTSE/fV9ZU/5lqOrHoPEqtWEdG4MbZty5RxIeo59omZfs8fiGrfP4JSoNHA5zFl9jFOkKTLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713798269; c=relaxed/simple;
	bh=gY/Fi+RRBpIEtt4g2iWf4ZHqsFPkeoWVasKLGqMuD/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLHnnVvn2UiRRfyq78lSbxfiLp2y9TUeMMmWi7PjPE05L1niMBWnPjLUT2Jdei4QOyqDuN2/SxflsWr4tG4RgtHgFuAaWq9zYHVfrLqFkDmQlJZVb7mHGGl7A47d0yUmFuDQmZp4Cmcyp+S3I+J0IQpe1Gi2HLCZICQQ0R79lLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6oTyXj5; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso4111276a12.0;
        Mon, 22 Apr 2024 08:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713798266; x=1714403066; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gY/Fi+RRBpIEtt4g2iWf4ZHqsFPkeoWVasKLGqMuD/g=;
        b=L6oTyXj51vKPEeiEMXkPtGzLwNOYhILnNZLSa+ymMCu5L9kTnOo8UE8Iq0/zbAtMSu
         5rtD9KnU+xFrTaVDM7ZdU5RWYIx9bShMTiHMHTb5ZoAuvS2abKP3ox8sR4wXDz20K49R
         sKNJXoLvtrkeBrQNKyXZxrid4AI1d9GmnFPFtZ0ankeOqt7GQ68DBZBtH/EhAmeSd5zv
         5zVr8NGo8ABO1FM80/KxU0oi5QkZ00wUAplGX9k9sN8PkX23vcodSvqjBml3FXfNcrgJ
         LyMUP6Y1tV2cJ+PEFUBJ0gP6azCSv7eIcJFGVXfALc9+kZqveYEakMmLpc53DHIavoue
         sjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713798266; x=1714403066;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gY/Fi+RRBpIEtt4g2iWf4ZHqsFPkeoWVasKLGqMuD/g=;
        b=AwGjMiORdJ57OHQJgDnbOJd8KQDQhs3NCWemuXJCZX/GxdBthKT6UTR7vwWRbgfNp8
         YXwmV+1OiS2Q4M8r1ckagKNCCcyIkrKh8ulUzzzyHk2mvKC7Tx4XygFSagBbpoSG3Zpy
         hSzYaWMtkx0praCgML4kyfgUZlBcofpRNVZrEqbYXfql9mOWMPgUYWm7cZJQFZl4RLlQ
         EeJWBYjYRTEjO2yYtmW/D8Dcd8q3vSKUoxqZRNamXBjUefTpkwsS69FcAl8QImGPHluy
         pS7/5YYIlnVSeE+jqjn//PVCuBPtg6Fn/s2K3rrDDFuhjtqMgZFeGrpuc2t8UD9xYI83
         H7IA==
X-Forwarded-Encrypted: i=1; AJvYcCUmlbor7o9ST7iVSr/z7wU+n0t2WATbCDqJSS3Zw0Vw84LedXXQL2C0CrQG5QpEedNuXt+/8TEWUjIoTQZEaZa6kb1LMmvOeQgDtv2x7u4mbbN6VIZ3UX5C2NUcInBYs64ExSYb7gMTLd4=
X-Gm-Message-State: AOJu0YxfBhAjDhzSeSikHlPqpy4xSQG/OXyofxGXCaHwWE93c+VjrXXT
	zU6HfawXJykcAzj4ls1PzrR8vSqfvw3f0xOj5y8hqHwMvyMlE1PmbSh85ykngW6rfIJxSfSB4fz
	yeTpJMxOzpQGrkA/WZT8N6dMtLFk=
X-Google-Smtp-Source: AGHT+IFjdK0F6Mzl4xHNa8qxjJqTkNZkhrQiips+tPOEjhjdY1XsbD081mImRM2z5k2J0XZ09hqyu8Rz8Tifkr3lZFs=
X-Received: by 2002:a50:c010:0:b0:56e:e76:6478 with SMTP id
 r16-20020a50c010000000b0056e0e766478mr6177689edb.31.1713798265473; Mon, 22
 Apr 2024 08:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJg=8jyC1+s80etZgWteps0Q0yEsR2NE23+Bf+Daa7zgJ2qKBA@mail.gmail.com>
 <ZiYDaN7fDzzEyVQr@infradead.org> <ZiYDiptCPKDNwE-J@infradead.org>
In-Reply-To: <ZiYDiptCPKDNwE-J@infradead.org>
From: Marius Fleischer <fleischermarius@gmail.com>
Date: Mon, 22 Apr 2024 08:04:14 -0700
Message-ID: <CAJg=8jwM30ui5zZuFW9d33oAdKk4uk1i26aoKQ2TrQcv6PGsdw@mail.gmail.com>
Subject: Re: INFO: task hung in bdev_open
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, 
	harrisonmichaelgreen@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Christoph,

Thank you so much for your responsel!

On Sun, 21 Apr 2024 at 23:28, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sun, Apr 21, 2024 at 11:27:52PM -0700, Christoph Hellwig wrote:
> > On Sat, Apr 20, 2024 at 06:19:01PM -0700, Marius Fleischer wrote:
> > > Hi,
> > >
> > > We would like to report the following bug which has been found by our
> > > modified version of syzkaller.
> >
> > For your reports to be useful please make sure your szybot actually
> > provides the same features as the real one, that is link to the
> > reproducer, mention the exact git commit reproducing it, provide a way
> > to submit fixes.
>
> .. or just feed your modifications to the original one so that
> everything just works..
>

Please note that the original email does have a reproducer and kernel config
attached, and specifies the exact git commit of the kernel version on which we
found this crash. I am happy to manually test any patch attempts. Unfortunately,
I do not have the infrastructure to host an automated system similar to syzbot.
Please let me know if there is any additional information in regards
to this report
that would be helpful for you!

As of right now, we are not yet ready to approach the team around syzkaller
to see if they are interested in our modifications as our work is still ongoing
research. We are certainly hoping to do this at a later stage!

Wishing you a nice start to the week!

Best,
Marius

