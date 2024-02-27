Return-Path: <linux-kernel+bounces-83361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1178694E3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6941C258C8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70B913DB9B;
	Tue, 27 Feb 2024 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/yGgRYl"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0C713B2AC;
	Tue, 27 Feb 2024 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042228; cv=none; b=gIYgS96WW/QfsA9n+qfpxTjeU37mIzLw5pqT3nN9S8+yzhgBdFPEpeCvrH3JEOs1LkZ/Z7EipLdt5WVoBMiQHtqgZsg2dLien1djWBmWd5hXL4elaC+fYELSV/DfLFKQpWlfDW+x8WS6/8u3pritDDikdoZ+0yU2+ZckPzoHfqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042228; c=relaxed/simple;
	bh=+RjOUgYjKnIUtG2s2YFwgRBlRVOcgqfyXjAz4yz0ezM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSNoejTTpRWndqijMEO3m0ymJflGcQ3E74xNdg+yQT0UpXNtHE4NXaFoa8aYoKgDQMY9VFkoNLXqL3kBMiu3Ne2RcvjAH5GRMIFHuHuxB3dhxUI/7EcTKa+8FJ9h6yXPB94RXH7VHkTV+sgNyyZKNoWG7hC7GIhYjZJyOO2iTUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/yGgRYl; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c0485fc8b8so2825730b6e.3;
        Tue, 27 Feb 2024 05:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709042225; x=1709647025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMYVBRfhTAHbrURmbpLRn/22okr8t995Gn/qPB8STJ0=;
        b=a/yGgRYl+aG1k0A0shrJNheYkygB4BVoF7JArVxNDDqrii5Yy0V1iqmbpxJqcLt51Z
         cjZCbx9MBIYRKSGq5tWAXAdEbbaSpWOlZwr93+87CxOqPYFRLfwvAzIhHhNX6sxGzjBU
         PnFyMkoIAOO0rsTpNa2Ci7OlCCqShvKTiQK1nW7hYMzH2B/EBXpl3EeUP4aSIoZBmI7S
         HPVJdYOm6/aWMRVzvs9E0KJEGuzbedJcPeJIJwqOTyQsmiM+v1BGIQqZPBGij29XFM2C
         zn4NX/PpPhgV5tKxBHVilnS+VqxyrQvgEZzwIa0E136+c5NGrcWkEwdmrKc+opKKGraP
         LExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709042225; x=1709647025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMYVBRfhTAHbrURmbpLRn/22okr8t995Gn/qPB8STJ0=;
        b=NBJoSD3NYH3tS9w/ce3BcLJS0c4vJuCHYPjiKF3LbXx9uFZ4CULi5up3prVY8utaiK
         pjp3cVt2MREragyiM9q1ZgcLGeLlWLx3hZk/guu5LSmGFyAfESez6jgHrksk+SHPp4q9
         jdvlogZj8CHuK83VdDNMJGWJlXU7QLvuP4qP9taKrF2ulIzZucSI1IXixhb6ps11v0CY
         c7SmBybGc+Il6I8aoDM6gCING6e8oAtqbBaZRZLo7OYhUkiNUuCvJGOYI1TkZkpvvzPf
         Fvy2jacz2WDuuLNa0aW3PzYsHVXPU+dNfRsZvYEgc+9EyAW4tRny2uaEHdIOkb/Z+sAk
         A6OA==
X-Forwarded-Encrypted: i=1; AJvYcCW7S1j/iw2ziUUJa9HYp8DJ7bVh7l4NJr7S6GIYDBsIqQUaIXgGVHspyLzGzJa3353CLAAnmBXTso3N9WtLwH0esOMCKecabOaxyvdubkCmjVDtC0ORBR2KKHMOEzFg2LbsrCFvEIB4IGLz3Q==
X-Gm-Message-State: AOJu0Yz+2Og17QdvvJ1aNCcTSITrHC2H1wIqr5cVurg8khPrEYl2FHhP
	mKE0kr2vG/g9bJyb7FtZiL64+X/Oytwd2jNi+uvDarQJOjOcaATfq0fHNih4E6XSq1jJcD1wuKc
	mbMbQvbccx3TY6ycM7VQepYCp7tZqqJyfZYk=
X-Google-Smtp-Source: AGHT+IHtPpA9qAPloqzzNWI0I87XEJ/ewCp6S0DGuTOBZYBkIpeJvopoik092bzY2yvlS43fu3orpQxnxCYVwCBk1os=
X-Received: by 2002:a05:6808:1889:b0:3c1:b09b:40aa with SMTP id
 bi9-20020a056808188900b003c1b09b40aamr1133771oib.6.1709042224626; Tue, 27 Feb
 2024 05:57:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202402260556.0rujs05e-lkp@intel.com>
In-Reply-To: <202402260556.0rujs05e-lkp@intel.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 27 Feb 2024 15:56:53 +0200
Message-ID: <CAOQ4uxj-PaBHNjYYVAVc=an3BZTt-C9p9etWAmhZc1udU7PN5A@mail.gmail.com>
Subject: Re: fs/overlayfs/copy_up.o: warning: objtool: ovl_copy_up_tmpfile()
 falls through to next function ovl_create_index.cold()
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	overlayfs <linux-unionfs@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 11:25=E2=80=AFPM kernel test robot <lkp@intel.com> =
wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   70ff1fe626a166dcaadb5a81bfe75e22c91f5dbf
> commit: 5b02bfc1e7e3811c5bf7f0fa626a0694d0dbbd77 ovl: do not encode lower=
 fh with upper sb_writers held
> date:   4 months ago
> config: x86_64-buildonly-randconfig-r001-20230616 (https://download.01.or=
g/0day-ci/archive/20240226/202402260556.0rujs05e-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240226/202402260556.0rujs05e-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202402260556.0rujs05e-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> fs/overlayfs/copy_up.o: warning: objtool: ovl_copy_up_tmpfile() falls =
through to next function ovl_create_index.cold()
>

I have no idea what this is about.
Does not seem related to the regressing commit.
This:
https://lore.kernel.org/lkml/caa4ec6c687931db805e692d4e4bf06cd87d33e6.14607=
29697.git.jpoimboe@redhat.com/
suggest that it might be a compiler bug?

Thanks,
Amir.

