Return-Path: <linux-kernel+bounces-130498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D938978F5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B744284814
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689DA155308;
	Wed,  3 Apr 2024 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9ULuySu"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22027136E1B;
	Wed,  3 Apr 2024 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712172282; cv=none; b=gQeCZypTYnVb61sAJNPlZVOpVUTuMTvFevJ0qHk13ntm+wKbwj0qzK9+4zeHIuHV0KJv3zOR/qsmyP+swqslNCaMYQ8dpaLS4oIoL9BfnRREudsG4vHSXddkPm/5Cd2i1zBcOQJZVuKrlSbFOU6BD3JikeJQ34hjJXqL25yB25w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712172282; c=relaxed/simple;
	bh=tYe3kqym89ulkdecpeh5V6rEmc6lJYUIZBGwvcfL94k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCfAhVw8qOoKwBMYCblH/GvOABdylOkW+mVVvu2VJlWqMlUOSLAoTb5Wt7KdfwmI7JRnX2SxjIg2knG+kNgjr0yKdDXk4vx30uogFWo2MklYdLVL+4qAKJV7gKGwrBZ0kgjJlALSBNdUZEKQmJyhxsYqqLF8tlsIp+tfZkZmx18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9ULuySu; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d47a92cfefso2139571fa.1;
        Wed, 03 Apr 2024 12:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712172279; x=1712777079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jx7bktn8N7Q1SDcEbjMBpdWMvCbn6FmN44d8Qu+3fjE=;
        b=B9ULuySuN9QIcSYfj3/dYT7Zrw0lzMFKwJ61maCzTX7Hi0TxZpqk3pwc4DO0NEJl3P
         iZdwpUhp6Zu1YV4X/YzVhqsoL7B4iHjSgsElAyK3agR36l0jaYRH/KYIlW07xJQqIX/P
         T+fIwFLG4XbnR6nV/DYa0bZr9SIpd90Kow/ZsHyYEDaicFUtwcERKQsSEeOP2KdvkknP
         Mk5KVXWAxEvRN0G87M56OhtUISKazERx5Z/uX09PtKkbhpS0mWyAudO884av9hvlkDWV
         jbCikpBgIvUiOdBe7ZZ0WPaFV96xV8mEECqLj/F/iT5THciXAlFtRYbWPx5605S7ajzo
         HGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712172279; x=1712777079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jx7bktn8N7Q1SDcEbjMBpdWMvCbn6FmN44d8Qu+3fjE=;
        b=alqQrUwGIN34TFAsISZLzeLSzu4QhR5Ip2X6ZlrpfkM4NJSj1F7f7u9TkoWCUJ3LJQ
         PlmaWifbOoPsQ91MyPGLKxMRz6y8CVRLL0ej5AJ5oFEQnnACUGJSHx3bDmnSCkX1Opp+
         7sCdfdj25XHNX35+9IGBDzeHGN+U3vRclo/7bqf1qnL14w5WPIoDVywUxkBVqB/cRdlf
         AF4w5sB5Q2h+GPTRJzDQ1+b2BNK7i2+UKE3sWjO9+JCbIG2CKjzUjF0cEfpApPkjq/V+
         CfZYUK/uXN7y1s1/EohkKWR+1rGjToADM2VgC+oOvf92r6EUXezGJcwW/UkBfscqVy5i
         T9mg==
X-Forwarded-Encrypted: i=1; AJvYcCUkvNp2fSSSTQoO9AnathZcG5XAtCVFWxd135pEL05SEmEgf2BafEHTKiHr+W91u/GftGbv7W5LVh2TbJ1BQXpR+lP4mSCvr2CatPO6Ejm7vCmfSfhVYoN8FlvVxbDTfXQjYMuF14TfhPw=
X-Gm-Message-State: AOJu0Yz5m60mLVGmKT3AJNzQcOybBSOkUDtWcfwWxuWy6NZ4T/U6gNrV
	qKELTXqkH8TCi4CZwR8Idkq08r4MRXEUVqoc5zhTTH10BSAQr66RFcpTIwGZEjB7OKtUsmmcol2
	iT1LG3qvu4+IDIjXgnyoWNKSswFY=
X-Google-Smtp-Source: AGHT+IECRXcYbiYRJW38VouKRQGOkqp0BMFISD9MvArqTpnT+l62dvD6OK5u0lacYRdIWF/d9L4kZxMUuMx+PRHKquU=
X-Received: by 2002:a2e:8509:0:b0:2d4:a22e:d3b3 with SMTP id
 j9-20020a2e8509000000b002d4a22ed3b3mr357802lji.11.1712172278814; Wed, 03 Apr
 2024 12:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207163647.15792-1-max@enpas.org> <nycvar.YFH.7.76.2402271740260.21798@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2404032010320.5680@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2404032010320.5680@cbobk.fhfr.pm>
From: Roderick Colenbrander <thunderbird2k@gmail.com>
Date: Wed, 3 Apr 2024 12:24:26 -0700
Message-ID: <CAEc3jaBvM6zVAqecUaxbtwUOTni4yT0wum_5ab5N1DLVYvhOeQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] HID: playstation: DS4: LED bugfix, third-party
 gamepad support
To: Jiri Kosina <jikos@kernel.org>
Cc: Max Staudt <max@enpas.org>, Roderick Colenbrander <roderick.colenbrander@sony.com>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 11:11=E2=80=AFAM Jiri Kosina <jikos@kernel.org> wrot=
e:
>
> On Tue, 27 Feb 2024, Jiri Kosina wrote:
>
> > > Dear hid-playstation maintainers,
> > >
> > > Here is v2 of my patch series, with the discussed changes.
> > >
> > >
> > > Differences since v1:
> > >  - Dropped patch for 7545:0104 (SZ-MYPOWER controllers)
> > >  - Dropped patch for DS4 clones without a MAC address on USB
> > >  - Changed hid_err() to hid_warn() where things are no longer fatal
> > >  - Simplified goto as return in minimal report parsing
> > >
> > >
> > > I've included the patch to simplify the PID/VID mapping to controller
> > > types, since the previous discussion made it sound useful for future
> > > support of second-party controllers. Please feel free to drop it if y=
ou
> > > don't think it's relevant now.
> > >
> > >
> > > Thanks for your feedback!
> > >
> > > Max
> > >
> > >
> > > Patches in this series:
> > >   [PATCH v2 1/5] HID: playstation: DS4: Fix LED blinking
> > >   [PATCH v2 2/5] HID: playstation: DS4: Don't fail on FW/HW version
> > >   [PATCH v2 3/5] HID: playstation: DS4: Don't fail on calibration dat=
a
> > >   [PATCH v2 4/5] HID: playstation: DS4: Parse minimal report 0x01
> > >   [PATCH v2 5/5] HID: playstation: Simplify device type ID
> >
> > Roderick, any word on this series please?
>
> Roderick, please speak up now, or I'll queue this as-is for 6.10 in the
> coming few days. Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>

Hi Jiri,

Sorry for late reply, let's merge it. There are maybe 1-2 nitpicky
things I forgot to email about, but I can deal with those later if I
feel it is needed down the road.

Thanks,
Roderick

