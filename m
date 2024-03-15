Return-Path: <linux-kernel+bounces-104381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047A787CD0F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 356161C217FA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E7F1C29B;
	Fri, 15 Mar 2024 12:11:27 +0000 (UTC)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3F11AAD0;
	Fri, 15 Mar 2024 12:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710504686; cv=none; b=kKWu0YNQ05XDGvRXFMg658h8ozR9nm0n9Kh3G5uo0cU+nEN07/vCi12kP9fStgTsZ+2Prh6OH38B7Fd0XSqlgEODjrRMhQsy+7odN/ZVSQ5ABONXf1SAZqZ64s8Q+nHyHuiSDBhusKbotrbMZgE6K1s5bTzwrWxKU+qCeOxpgCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710504686; c=relaxed/simple;
	bh=Wfc9oP0R64W5zCTmqNzrzXKvNhkgw76Rey6GJ7FbITw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+A/sMp41eRdl8utARqahH2opp0TA6vkcmYEQpltyQ2ND5J83d5LKqoaO4/STJlPdq9sYuBIwb7Q5Y+/DX4jtTuR4IzndlUHkJLCHLf3+VJkX+je96UNAgRnYwalzjajlPnTgjwx6BddenQ0/39k8bgszUZIUB9ITgm4V0sPdGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e677ec9508so105979a34.1;
        Fri, 15 Mar 2024 05:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710504684; x=1711109484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wfc9oP0R64W5zCTmqNzrzXKvNhkgw76Rey6GJ7FbITw=;
        b=Ro/K4vJNUP9A9LcaioIl9wSHgdwSHq9Ma9vrLza1vQc1JDr4TLEa5IPdohwaQRYjCO
         5ATqpu1tLXdMgLzbxIE8fLtmDEI4ZGLKG3stcDzQ8Ns9hmnggEMNW0Ksvzv+p8SnBrQu
         SK0+Zg5LV8YWCUfEllWa4EYqw9iEBd2tz/RQcJPMPmzry7Iws7yFpJ31I3ohUPGvfmhs
         l7IdIYvC2kRQTJXFjy10HCM9+rRN2sZcCL0kaFN/IzfY7WmdaZo7aW/6wGfkoT2IUvlR
         e9zhUkFy2sHmSgHeB+giF2ZL4x3Hs0+/85BU+ROw+F06UvgejLbrzFPdhUWHeK8h0OSj
         PgwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSHWTY8CbTEFyHqvu/KAAAOLewiNrXlfGtibOoeTkpXzex2PMq01/zWxbEHclTOyyjd+kp+5IUaGKy03K6mjr0ydQKtDkkvxOp3YHBQw5UazY5G9kkJi58ktoVHODdq931P6rzisE=
X-Gm-Message-State: AOJu0Yxyl5rR9AkYZd+u+BP3HamnPEdYDL6PqA9CQ74sHMUAZr0JZ76s
	VyV9sth+yP2n2r6r1ThhOweHoVCCvg3n7pZGPD2mmkOWz7AiwaOyjbnu7lWGef6/MNh/LReho+s
	xG/ccQtRkzkOfvufOqWRDvd1P/9c=
X-Google-Smtp-Source: AGHT+IHrL8H9SwN9jXgTuYfrExgOVrNcC3Bt0Zm4s+VN3I18sBdqrTjq+NUAfpZkvB8k2ddt4TZR9nTK++wk+D70UPg=
X-Received: by 2002:a05:6871:b28:b0:222:8a9d:d935 with SMTP id
 fq40-20020a0568710b2800b002228a9dd935mr1213647oab.3.1710504683918; Fri, 15
 Mar 2024 05:11:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314075429.1164810-1-d-gole@ti.com> <CAJZ5v0iUt+tudMV-rJ80GR6iNQVv06+054h0UyNgpEOUF6QLRQ@mail.gmail.com>
 <20240314151846.u3r3eaklrl3hf7pi@dhruva> <CAJZ5v0gwkKa+AYgOwydzsKjo=_M56t88PwVo7R+fe-53abAdVw@mail.gmail.com>
 <20240315051828.su2qx57ecyhv3up3@dhruva>
In-Reply-To: <20240315051828.su2qx57ecyhv3up3@dhruva>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 15 Mar 2024 13:11:11 +0100
Message-ID: <CAJZ5v0jbHwiZemtNAoM-jmgB_58VqmKUkqv4P7qrPkxWzBzMyQ@mail.gmail.com>
Subject: Re: [PATCH] PM: wakeup: Add a missing return case in init_wakeup
To: Dhruva Gole <d-gole@ti.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Tony Lindgren <tony@atomide.com>, theo.lebrun@bootlin.com, 
	Sibi Sankar <quic_sibis@quicinc.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 6:18=E2=80=AFAM Dhruva Gole <d-gole@ti.com> wrote:
>
> On Mar 14, 2024 at 16:29:36 +0100, Rafael J. Wysocki wrote:
> > On Thu, Mar 14, 2024 at 4:18=E2=80=AFPM Dhruva Gole <d-gole@ti.com> wro=
te:
> > >
> > > Hi,
> > >
> > > On Mar 14, 2024 at 15:01:36 +0100, Rafael J. Wysocki wrote:
> > > > On Thu, Mar 14, 2024 at 8:55=E2=80=AFAM Dhruva Gole <d-gole@ti.com>=
 wrote:
> > > > >
> > > > > The device_wakeup_disable call can return an error if no dev exis=
ts
> > > > > however this was being ignored. Catch this return value and propa=
gate it
> > > > > onward in device_init_wakeup.
> > > >
> > > > Why does this matter to the callers of device_init_wakeup()?
> > >
> > > If atall !dev->power.can_wakeup then the caller should know something=
 is
> > > funny right?
> >
> > What would the caller do with this information?
> >
> > They attempted to disable wakeup on a device that doesn't exist or is
> > not wake-capable, and so what?
>
> Using drivers/char/hw_random/xgene-rng.c as an example, we can atleast
> print a warning or something to make the user aware of an unclean state.
>
> Is the argument here that if the caller can't do anything meaningful
> then what's the point of returning any error?
>
> If so, then my preference would be just to propagate as much information
> upward from the stack whether the caller can make use of that error and
> in what way is upto the caller, if nothing else then even a warn or
> error print is still useful piece of information.

I'm not making a general argument, just talking about this particular case.

The only error code returned by device_wakeup_disable() is -EINVAL and
it is returned when nothing had to be done because it was not
applicable to the argument passed by the caller.

Quite frankly, I don't see why any caller of device_init_wakeup()
passing false as its second argument would be interested in handling
that error.

> However if it's useless to return anything from device_wakeup_disable
> then we might as well make that function a void or something and avoid
> any confusion as to if there's any point in returning error at that
> point.

That would work for me.

