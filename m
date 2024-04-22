Return-Path: <linux-kernel+bounces-153822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F068AD3C8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75621F21907
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4611615443D;
	Mon, 22 Apr 2024 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efR2R39b"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0587A153BFF;
	Mon, 22 Apr 2024 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713809920; cv=none; b=OslJOWDUKgUx2bnhdDWO+bOFxQfLvQXroWGolZ0pPhZBSCCxn78BSw76RG5bXRtBfmg7tOW5nmtWS+jg/CEA/8dRpzheDaeqOO+Pkzbq1PNmQzFIQ2YDdAC4RmIiyHuqCQFBSqqLhXhnDzYVrd2P3SQjqwfMe/CJCVpMOgSQbxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713809920; c=relaxed/simple;
	bh=QKW8kzvOS3DmTNnUdKWg0SzbHFteCmaAmJ2NvPiPvWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mh6RmyY/cIThNji0UZ7N0k8gzTWHftPO2t92oowPUkR5MxM/Ej5XlBRdgEngdb2zHJR4HKLLJf44Ky2TXxZvxeoTYfgY8qRkhUDiWb+0O1WHAnJLFkkI0zelAtm3/Qu/FEcwm0WTr7KfqgX+LrfmvNkwbpvMRSAirt5DEtcG8nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efR2R39b; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d8a2cbe1baso60999411fa.0;
        Mon, 22 Apr 2024 11:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713809917; x=1714414717; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QKW8kzvOS3DmTNnUdKWg0SzbHFteCmaAmJ2NvPiPvWk=;
        b=efR2R39bELq168VJI7EpJEco3BDIUgG375a6K3ftJIkrQLAgjIOpsb8fWLE5gejnVu
         Xj9PMnVLzi3OSwQUmK9xaWsHLIu+bl/CCzRvJhLgRAWT4D49cLyDnPReNiZCHEqY6OGY
         RfXYbKrVdc/ex2NYH8MiVeqwwHeJYvmFqRQ8iGkPyoAEZ7/WnSi/69BVnLuzS+rIOal1
         S3OJaUx6kjVUCWrK5YSuQMu6Afvd7ODBdlaErFHvkJWDMZ3bcnYz1eclNsgzELi5kWld
         hmLPL3r+fkdRhgtsRm6l6BiQ8ZLA3YClN+6uFX8LnKveU7aBxX09ZsA0Kk67ZLjcoRQc
         Kodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713809917; x=1714414717;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QKW8kzvOS3DmTNnUdKWg0SzbHFteCmaAmJ2NvPiPvWk=;
        b=nJNjFchss6O2H0TzJuoiGSoKH9dmXeALJiwIj0v7giiE7HKvtuyMWeLjELwgEqCnxk
         sQHyQN8Gri464IOL6qHaeA/RFNWC8LUOLitDSY+rV1QbiaRAyJI5uU+92GrP/KflThoO
         pqx4hYdk5XeFKUGY4UkLL4GfFolyr319ssePfPRX2E/zQsj5z39idWr+v/N32OZDS072
         tnoAPNp8zGYGrduz+yoARyV9Mnv2b522ajOoKzO5SgzVxiG74KCcxEZAmBvUuNJ9+gNf
         rBDv/PrseR0i6/a2TnQByEBFD/agW58jqqxByMq+l1qZOX8HMc7CvcJg5rwWYklIRVQs
         0fjw==
X-Forwarded-Encrypted: i=1; AJvYcCXvMyJT236bNoedEApp9sLNCojt/wo1tF1zOgFwv/BByY0/MCUYGIkEmePraIruyPbZ+PodREcNgOkpgmc//YtiICqD6XxqBcv1YigleyBWCRmoH2WMEaSrtXExl94rhK6LGS7F/+qS4rE=
X-Gm-Message-State: AOJu0Yy9APSkMIyORhPMubzSmjaWe3weulVxHylbA1pCEi0WJSuEMUTd
	+f2blJ44oWeHgd1zTu3r7+b/lN0dTSC9L6txpVZjmYKpxctNPYsw+sYKgs79fX4DoAAQygVJ5rG
	NjhF8ufM83D8hbzRsEc6o/rqBYdo=
X-Google-Smtp-Source: AGHT+IGezo0V7L93amzj52C06QN8zgMkTnGGaa1UlIQBQEAgdXLlOGZ32k1GVoHCQgcKZfgz5DmonKhGldTTQAwPEAo=
X-Received: by 2002:a2e:3e01:0:b0:2da:a3ff:5254 with SMTP id
 l1-20020a2e3e01000000b002daa3ff5254mr9103976lja.1.1713809916833; Mon, 22 Apr
 2024 11:18:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJg=8jyC1+s80etZgWteps0Q0yEsR2NE23+Bf+Daa7zgJ2qKBA@mail.gmail.com>
 <ZiYDaN7fDzzEyVQr@infradead.org> <ZiYDiptCPKDNwE-J@infradead.org> <CAJg=8jwM30ui5zZuFW9d33oAdKk4uk1i26aoKQ2TrQcv6PGsdw@mail.gmail.com>
In-Reply-To: <CAJg=8jwM30ui5zZuFW9d33oAdKk4uk1i26aoKQ2TrQcv6PGsdw@mail.gmail.com>
From: Marius Fleischer <fleischermarius@gmail.com>
Date: Mon, 22 Apr 2024 11:18:25 -0700
Message-ID: <CAJg=8jzF9xVKiQz0s8=1P4_kxDT-tYAma4u2nXKHnv_jkGDkyg@mail.gmail.com>
Subject: Re: INFO: task hung in bdev_open
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, 
	harrisonmichaelgreen@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Quick update from my side - this crash also appears in 6.0-rc5 with
the same reproducer and kernel config.

Best,
Marius

On Mon, 22 Apr 2024 at 08:04, Marius Fleischer
<fleischermarius@gmail.com> wrote:
>
> Hi Christoph,
>
> Thank you so much for your responsel!
>
> On Sun, 21 Apr 2024 at 23:28, Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Sun, Apr 21, 2024 at 11:27:52PM -0700, Christoph Hellwig wrote:
> > > On Sat, Apr 20, 2024 at 06:19:01PM -0700, Marius Fleischer wrote:
> > > > Hi,
> > > >
> > > > We would like to report the following bug which has been found by our
> > > > modified version of syzkaller.
> > >
> > > For your reports to be useful please make sure your szybot actually
> > > provides the same features as the real one, that is link to the
> > > reproducer, mention the exact git commit reproducing it, provide a way
> > > to submit fixes.
> >
> > .. or just feed your modifications to the original one so that
> > everything just works..
> >
>
> Please note that the original email does have a reproducer and kernel config
> attached, and specifies the exact git commit of the kernel version on which we
> found this crash. I am happy to manually test any patch attempts. Unfortunately,
> I do not have the infrastructure to host an automated system similar to syzbot.
> Please let me know if there is any additional information in regards
> to this report
> that would be helpful for you!
>
> As of right now, we are not yet ready to approach the team around syzkaller
> to see if they are interested in our modifications as our work is still ongoing
> research. We are certainly hoping to do this at a later stage!
>
> Wishing you a nice start to the week!
>
> Best,
> Marius

