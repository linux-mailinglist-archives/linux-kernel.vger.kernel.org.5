Return-Path: <linux-kernel+bounces-131405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D47A3898733
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1019B1C2683B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0E2128363;
	Thu,  4 Apr 2024 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="CEQ+1Vah"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0A2127B40
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233235; cv=none; b=L3tt6wxck0bK0T5i1bJt4mYoJTEEOWOjHK1lZfUREdPVk+SpYJWb1FeK9xKCOfdyG8L9RU1IVp0qMyZgJjCxe1XqcGrs9V2pN7byPC+Iza1i7j+sVqezoxDIk6REXquT7EeRdHlYgwZhlwrEbrQNYL8yrxOKqcEXeIuKmx7DiR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233235; c=relaxed/simple;
	bh=H3f5IYJ1QWgMCxp8QqRnm74odB6YZNBaYMyZ5mE9B8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vADGXZAe8hrdA/odoBvNrLBCcEfCQarFzaMiua9/v6eISl+b/bdxd87JGHFyXP5hyzDrRYhBmZ1328RjS/wcLUXUrSFR6Jxz2SkHiu1IBpqIpxaKeUmh2XtfDke36wGkjWnDMXUFDwTu/I7XV33sXzRcbBwtTKgIBe3p/Sw4/BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=CEQ+1Vah; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516c97ddcc7so815218e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712233231; x=1712838031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUbfvRaTdYI6FJXs+PUDsLKnWz2I5THsnSsWjhmBFSg=;
        b=CEQ+1VahHY1lnHONUcj2WZxOs6Qkp/iF0KkGR/SZ1mL2VsVRudtZAR8laVgyetoym0
         uD4x4KSK59RSy8umCfC5v4WN4lqKep7557O3xU7+jsDSCMlgCNvAqjIGOsgEGh5o1jgT
         7Hx1eBySF4pWlM/uClIfHE/7pz2sGTgc5cQoh1y7adb9/tg6e5vh8fgc3fgpLNpPLR3H
         YAR9V8qqF/33Kcs/P63IWE7bFNjbH+EV9PQw6NnJdLuv1s82+rDJhhJNfPP92enfetXa
         mSfcaw6Ar4jcFjcBfnt+JEijmLotomS2JCLUDF8KYwkyKhdrGp/jKan2j9lhOUd2La0v
         vXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233231; x=1712838031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUbfvRaTdYI6FJXs+PUDsLKnWz2I5THsnSsWjhmBFSg=;
        b=Wu1Zo7akw1FSlfNVRh8HV31cVvcMIon4uzvSkXIgu5PwiLu6w4OImBj9pstBXBF1m+
         +IQfbH6tI3Mhr0Nip8l83Enb9ZU4LAKttZIiYEwJJeyUSYLBD6LXh1OKx+BzzXHL+T+6
         2AmnS67kyW2Wo1YFV1jhh+fsX/yH/VxCLYgYSkXhx/2UXDkYyFQOe6ZPLOZdpDrPUz4i
         BWqqCzwyEL8lRUStVeXtd+V6JC5Bk8j5S+gLxEdhhvAkl4N5HVjBXUHg8lr5W77KHTfI
         uyVYaCRfqKzvEVBllP1Kt1KFGaKuhMF1uPDAoomwx+nxZ6PuAkC+9410jJ3vpOGqRKup
         dP8A==
X-Gm-Message-State: AOJu0YxAJVEOG8vvptffg6qhXC9vabi7/byCvF6Pql50snq/xHhITsdP
	XEQEzBE+0vT1RpeYUWA+b5aSeWTU0O1I/C2pP9uFTP92blvXbxhnl1wIST7hPOA/aNbSXrNieD2
	P3yMrmg5a8ZhscxavznHdyYmbjsckFR+ObVWZXA==
X-Google-Smtp-Source: AGHT+IFXuY19yD67Vs0YeBOAYv5IS0ycYwSWTF9HWesGz64hK8qtn9PkV2yqkWQlXtSA4rvLO2hBr6dSTjjx6khY+oo=
X-Received: by 2002:a05:6512:60b:b0:515:d038:5548 with SMTP id
 b11-20020a056512060b00b00515d0385548mr1623137lfe.31.1712233231216; Thu, 04
 Apr 2024 05:20:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403131518.61392-1-warthog618@gmail.com> <20240403131518.61392-2-warthog618@gmail.com>
 <CAMRc=Mf0DPN1-npNPQA=3ivQd-PMhf_ZAa6eSFjmQ26Y8_Gv=g@mail.gmail.com> <20240404105912.GA94230@rigel>
In-Reply-To: <20240404105912.GA94230@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 4 Apr 2024 14:20:20 +0200
Message-ID: <CAMRc=MeOW6mcYFR6GL5c0hyfH_ZvqmLqKFSk50jKa-d+4aa4iQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: cdev: fix missed label sanitizing in debounce_setup()
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linus.walleij@linaro.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 12:59=E2=80=AFPM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Thu, Apr 04, 2024 at 10:20:29AM +0200, Bartosz Golaszewski wrote:
> >
> > Now that I look at the actual patch, I don't really like it. We
> > introduce a bug just to fix it a commit later. Such things have been
> > frowned upon in the past.
> >
> > Let me shuffle the code a bit, I'll try to make it a bit more correct.
> >
>
> The debounce_setup() oversight bug is the more severe, so it makes more
> sense to me to fix it first.  But then I my preferred solution would be
> to pull the original patch and submit a corrected patch that merges all
> three, so no bugs, but I assume that isn't an option.
>

Nah, let's not needlessly rebase it. Most I can do is merge the two
but they are really functionally separate so I'd keep it as is in v2.

Bart

