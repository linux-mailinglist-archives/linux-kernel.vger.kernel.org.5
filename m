Return-Path: <linux-kernel+bounces-78776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 161938618AF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E10B1C257E4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B08012CDB2;
	Fri, 23 Feb 2024 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dATURRsv"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8BA128834;
	Fri, 23 Feb 2024 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707733; cv=none; b=A/5SbOnPxzJtYim0BAhgThvWxNA9lZEIxL1NbJSRejM3pXkcH0QU1aWsqtOi4DIRRz1SnayWiQ7RoySU1X/SgNMcSDj0iQHqKZ4J74LMI5m8L9zmtO1PlUyUkUJuO9wr94mOh1tU3/w303vV4hZgVjDW90nGvHCsWodVEkYaWu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707733; c=relaxed/simple;
	bh=Qp1U8rgBnaMb4ZdsZ4KKsgLguvGHdJsb0qwKj9KW2bQ=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=JaZnwYbFjRaLwQyo0LxLcEGNmEOauN22gxHFNdsJUIcQBWsr+vAI5nDbAQezqGeDYFyaS9hdAQ58KK1ent2D9KcbpzZzH9kTwJ9Y0+cwo2cNwFLj3f0wM0Kgmzk2TgbMH7Yn03iqMOamtF2bbgct0UvQSMA7MOZemPpDvFCkVak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dATURRsv; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512cc3ea7a5so662832e87.3;
        Fri, 23 Feb 2024 09:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708707730; x=1709312530; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=Qp1U8rgBnaMb4ZdsZ4KKsgLguvGHdJsb0qwKj9KW2bQ=;
        b=dATURRsvy3KCJbbF8Qidp2a+DFQgQSLrDaDjILvSfzoEc5XiZpAC3Py8ha2qlc9NY3
         ZDWTmWUQImurx6zpqNbm/Habvqvxw20+VONKOdge8hbXI3s1p22meNa6aMcCQQyPRsWj
         F1Ln5uZ3L9yhr1T3N49BtJEI3EFgqw/0lad8+Ur4iD/ALb9Z31WXpg+G7rDNYOYhIg/O
         gLNuBFEwcBQyQEbGiXuR0X6QfQRti9UX0sBtswKTXTHWCsqWSf1qzmb8A7qJ/rAC7ddM
         c08SS0eXrOJJXNjOwyZDZfbUPf8nvwYAdfj1rk2TDLy4ud00MkFG3bSuDHE30U8zOHEB
         MbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708707730; x=1709312530;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qp1U8rgBnaMb4ZdsZ4KKsgLguvGHdJsb0qwKj9KW2bQ=;
        b=SdEA64PCcMVOMRJxkMRJcAQw9jh0+x2PeZBRu6HSOYdAY6hpb7Of6t7TacOLeJ8eBh
         n6dx47+1fJQTq4Qdt/9F8xBj0VUZiKoCOJI8gFLYtWaoeRn24pUfNTU5XAEOuoj/VrEj
         WMIJfdqpTA7MOsLviR92GpvCri2qj4zSfDvzZvDgcRO9eRNhK3yxG9zuLohe2bQtWwKf
         bza7PgAnJ0MfgPO7oZQcXe1V+pMCJ2RmUTr64TeRMdEgRTf84DyX6caBb3OxWaJe7sDW
         1XsYxD5W0OsC+gr5QHBrekeJBhHvM1wsMmXm67fHZvOSWz0aYXHavOlRowfkZ1GqZBVx
         kTiA==
X-Forwarded-Encrypted: i=1; AJvYcCWOckPTriksxpK0HLxKYJ8NdRFnvbh1esK/kUqCminLGRwY/GoXXzEJJLnatP38Ed3E7ASU9Vmd1j4gKEC9SpLMRLKTxdWGPtx0L74C
X-Gm-Message-State: AOJu0Yzm3nH3G3akPf9DyvI6w01yg/wUqr70eWWbxR6en0s+pZcudJvH
	x/m8Ax4ycb2wC+fW4vVLrMZOoEmsUf5x26lANg3lYEOcPQd0buLP
X-Google-Smtp-Source: AGHT+IFUpsG8qrL1QQgYd8GXsf8ZBOT8KoNOgh+eR11WdPx6tvzUHtL1wtbeWMgLnZnWccEJJSlmNg==
X-Received: by 2002:a05:6512:1094:b0:512:bc0f:2400 with SMTP id j20-20020a056512109400b00512bc0f2400mr335414lfg.50.1708707729961;
        Fri, 23 Feb 2024 09:02:09 -0800 (PST)
Received: from razdolb ([37.1.50.248])
        by smtp.gmail.com with ESMTPSA id z6-20020ac25de6000000b005119498ba1dsm2517298lfq.198.2024.02.23.09.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:02:09 -0800 (PST)
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
 <87o7c9q27c.fsf@gmail.com> <ZdhULRi3w4E5tQgR@kekkonen.localdomain>
 <Zdhan1Gzi6GD5QfP@kekkonen.localdomain>
User-agent: mu4e 1.10.8; emacs 29.2.50
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Jacopo Mondi
 <jacopo@jmondi.org>, Tommaso Merciai <tomm.merciai@gmail.com>, Christophe
 JAILLET <christophe.jaillet@wanadoo.fr>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>
Subject: Re: [PATCH v2 00/20] Omnivision OV4689 refactoring and improvements
Date: Fri, 23 Feb 2024 18:47:49 +0300
In-reply-to: <Zdhan1Gzi6GD5QfP@kekkonen.localdomain>
Message-ID: <87cysndsha.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Sakari,

On 2024-02-23 at 08:43 GMT, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> On Fri, Feb 23, 2024 at 08:15:41AM +0000, Sakari Ailus wrote:
>> Hi Mikhail,
>>
>> On Wed, Feb 21, 2024 at 06:02:15PM +0300, Mikhail Rudenko wrote:
>> >
>> > Hi,
>> >
>> > On 2023-12-18 at 20:40 +03, Mikhail Rudenko <mike.rudenko@gmail.com> wrote:
>> >
>> > > Hi,
>> > >
>> > > This series contains refactoring and new features implementation for
>> > > the Omnivision OV4689 sensor driver. Specifically, patches 1, 2, 3, 5,
>> > > 6, 10, 15, 16, 18, and 19 are refactorings, and are not supposed to
>> > > introduce any functional change. Patches 4 and 7 perform migration to
>> > > CCI helpers and subdevice active state respectively, and should not
>> > > introduce any hardware- and/or user-visible change either. Patch 8
>> > > fixes a possible race condition due to v4l2_async_register_subdev_sensor
>> > > being called too early in ov4689_probe, and patch 9 migrates power
>> > > management to PM autosuspend.
>> > >
>> > > Patches 11-14 expose more sensor controls to the userspace, such as
>> > > (read-write) HBLANK, VFLIP/HFLIP, digital gain, and color
>> > > balance. Patch 17 implements configurable analogue crop rectangle via
>> > > .set_selection callback. And finally, patch 20 enables 2x2 binning
>> > > option. It should be noted that publicly available sensor
>> > > documentation is lacking description of many registers and their value
>> > > ranges, so a lot of values had to be found by experimentation.
>> >
>> > Gentle ping on this series. Anything I can do to help getting it
>> > reviewed and merged? Maybe split patches 15-20 which implement cropping
>> > and binning and change the driver away from register list based model
>> > into a separate series? Anyone?
>>
>> Oops, my bad. I'll review these shortly. I can already tell there's not
>> much to do though.
>
> Done.

Thanks for the prompt review! I'll wait a few days to collect more
comments (especially on patches 17, 18, 20) and then post v3.


--
Best regards,
Mikhail Rudenko

