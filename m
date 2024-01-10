Return-Path: <linux-kernel+bounces-22452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4101D829DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6766F1C226F4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE184C3DB;
	Wed, 10 Jan 2024 15:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="WhD/6MP6"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DF74C3AF
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2adc52f213so358908366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 07:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1704901656; x=1705506456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioFiiBHR52hjIdzvcsREnH6I97Ku4C9Wv6P6MdH9Wh4=;
        b=WhD/6MP6mAbxASjPHCVpdFAwzdaL2RMmbxDXaVIOPghfujPQW87Cqa0q/PTXbgxDjI
         kq7qh3Nr49HBasmSahg6487pThiN1C2UdhuBjKmSFDS84kJcsM1Ofzp5t1Er4PX55/yr
         yVRaZbK2tNekr7JKe7Jvn3OMArSF3zyHT/DA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704901656; x=1705506456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioFiiBHR52hjIdzvcsREnH6I97Ku4C9Wv6P6MdH9Wh4=;
        b=fKdeuOtX2o0eZcVF50F1zAb7FiPohVNmV0PWKBP/q5GpFhmkVoFUlzxYjjL94T8s51
         Mfr/2RAk1/VLSmt5SFUQC+h5wdhrp1Msd66zPjLIB1si32++T1/nR75vsCZlO/4uQtfx
         NblFn7cFfzP9sTTPrRpsp1G7DqOt/tb0u+SvXdGHsXv9YvT936tMFJytwv2qiklkkedR
         bqFghM3brjB8AyVePWxPUwI1WjoT5d3us94DZpyjLl1Lv4hGppyEe0+ZrGaZ7UZx1ygP
         ktAxhQjZimb/H/Hti1JBG0RCoduy2HJAcfJ2YrMKkV92uobFgS0E+RZBMz4buzha05qP
         O3YQ==
X-Gm-Message-State: AOJu0YzOq6Hs3vtR/rHgZSeVIuMqU0PM5RkHp94jMuaamYbp7P1gyVyY
	HX5QINcMLqwrY4kwpYENZD7sFTHw3wmtwzTWc9hftvy19EGNUg==
X-Google-Smtp-Source: AGHT+IHA+OuPYsC1tzBqWdoxLHVwHiWSsYMXS2IR9ogBlapWDdJ3nk3Ig2HJ+z1HcTjDmTh0nn25aP29soAg7wAC96c=
X-Received: by 2002:a17:906:7d18:b0:a28:d163:ea39 with SMTP id
 u24-20020a1709067d1800b00a28d163ea39mr713908ejo.108.1704901655434; Wed, 10
 Jan 2024 07:47:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
 <9b5cd13bc9e9c570978ec25b25ba5e4081b3d56b.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
 <CAJfpegugS1y4Lwznju+qD2K-kBEctxU5ABCnaE2eOGhtFFZUYg@mail.gmail.com> <2wob4ovppjywxmpl5rvuzpktltdlyto5czpglb5il5cehkel6m@tarta.nabijaczleweli.xyz>
In-Reply-To: <2wob4ovppjywxmpl5rvuzpktltdlyto5czpglb5il5cehkel6m@tarta.nabijaczleweli.xyz>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 10 Jan 2024 16:47:23 +0100
Message-ID: <CAJfpeguE6E=s_t8WFVrJcXUar9ifr5+rhsmoJZYW5xWrTzRbMw@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] fuse: file: limit splice_read to virtiofs
To: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jan 2024 at 16:19, Ahelenia Ziemia=C5=84ska
<nabijaczleweli@nabijaczleweli.xyz> wrote:

> > We need to find an alternative to refusing splice, since this is not
> > going to fly, IMO.
> The alternative is to not hold the lock. See the references in the
> cover letter for why this wasn't done. IMO a potential slight perf
> hit flies more than a total exclusion on the pipe.

IDGI.  This will make splice(2) return EINVAL for unprivileged fuse
files, right?

That would be a regression, not a perf hit, if the application is not
falling back to plain read; a reasonable scenario, considering splice
from files (including fuse) has worked on linux for a *long* time.

Thanks,
Mikos

