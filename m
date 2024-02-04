Return-Path: <linux-kernel+bounces-51660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A46848E04
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C8ED1C22E0D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62243224E3;
	Sun,  4 Feb 2024 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXbjzDrO"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205BD224DF;
	Sun,  4 Feb 2024 13:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707052541; cv=none; b=nned5PcfssR8lojXLZeb0MFNPh0oGzwOu5hC3WoVmq11UPrekP+WjQltowLMiGDPkUQzmpCfDvMPEzqE4QJyGCtuC/zwgKCyRTLXjWzyabaMAv51p3S54B1h8QCnznwU0I8SZ6fqwLwv1V3g+sAwEb65sU+oZ1FvKmPcPXLXq2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707052541; c=relaxed/simple;
	bh=g2jbrjV4YVKZArXjxv+hh0KopDOZiOf8xClOr5h8ezU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKPSAMjrBPQoLZgRvEILHBgb95x8PVpqTdiaEfbme+1Ef/FBtLbNuL3mX8NgiaE/Ic77LTCKTUXIFAkjpfwrUsicZeFU9zwYXhie0O9LhXMoZwkmu79aoZaoE6TtMLtB0j5N5wCB+d28piS/Som37s9p5Q4V1vzBG9+Mv7PRuRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXbjzDrO; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5602500d1a6so958262a12.3;
        Sun, 04 Feb 2024 05:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707052538; x=1707657338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2jbrjV4YVKZArXjxv+hh0KopDOZiOf8xClOr5h8ezU=;
        b=TXbjzDrOEI/T5vWzMZb8mTu0jTK7g2SoUj4DGPu6OoZQZeHweMw/dILqnrRdrnNE+K
         9gEbhme1uuqTuJ2W4QSf+tA9OZvYQM2tMw3R3eUAfGiRRwt8yMsJgbvMEp+MY9Tc2mR4
         Ub8gZ2GLbeSaaxY0pheDMj5lABEUEGvCpx9S/Wl7XHZnNx/RZKVIOncE0kQnH2P/4dAb
         /SCfVWK4JNbZLxmqqv7jUh+VxBhTnHO56K5kXyQMOYnq+9DOQFdx3J5d0WJDSc9fp48/
         E9AYWrHzPi2UJ73vqOIV5C0x6h5VT6lhV5LOkm05n6yTX6ucZJAgcleaCNAVjovgEsoe
         6ZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707052538; x=1707657338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2jbrjV4YVKZArXjxv+hh0KopDOZiOf8xClOr5h8ezU=;
        b=aZ9JXnema95GDUAl6OqE504tncQT9PKXCciaRWDEZkA27YnicLlJ037lzvA6ThBy02
         ztIv7KGtyTL32yfWWWS0YDZRfWuskRfrp6W7zA3a5HhHOmqL7ymTOboPioPwmIrl1qFv
         Orhob0NAbWJZxnjc4oOgqIcPF2l5ABlgzok+FlT3ZYZD8SIbBV1ZyhqTDcN3gDkrMKcJ
         7IG/CWyHLvU1NbHDFxXr4ez/i71KMMn1ZgBUGkyIJtQfWLE3AvqOH5ovMxdO7jWXMJ+q
         Nic8kbE5dbBjmPf28fdNV2Q9NTFz9HQO1HCEvQqr1HL68aypxLt36MsPvJwu+jqAUqeQ
         vQ+g==
X-Gm-Message-State: AOJu0YyK2kVllZMdCQbfWWBgsMZjAp8O3cDVBSgBtlLOn0iFqKCdoejc
	LO9L8r1emmYI8/m9IcJXXebzbgKajc6+MfghTQtIQa6hYreDtYa/ZshORjKAhb1zv4SkHs8CRMT
	Bm0RReQPIAaRTrLQQrSmMEeqRNsmPYETfnCP3UA==
X-Google-Smtp-Source: AGHT+IHwnbzWX8OqeCzfgxv7SL6rFDuMhCQ1TOfwaS9X1wRRAujfcitfhIecRDbDwfRkk9XJWOXziM7MJcGnfMG1nNU=
X-Received: by 2002:aa7:df14:0:b0:55e:e9f3:4f63 with SMTP id
 c20-20020aa7df14000000b0055ee9f34f63mr3341436edy.3.1707052538059; Sun, 04 Feb
 2024 05:15:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH37n11s_8qjBaDrao3PKct4FriCWNXHWBBHe-ddMYHSw4wK0Q@mail.gmail.com>
 <2024020410-bungee-number-f643@gregkh>
In-Reply-To: <2024020410-bungee-number-f643@gregkh>
From: =?UTF-8?B?0KHRgtCw0YEg0J3QuNGH0LjQv9C+0YDQvtCy0LjRhw==?= <stasn77@gmail.com>
Date: Sun, 4 Feb 2024 16:15:43 +0300
Message-ID: <CAH37n11rbpaxzmt03FXQpC0Ue=_J4W4eG12PxvF3ung+uLv8Qg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/326] 6.6.16-rc2 review
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

this issue also in 6.8-rc3 and 6.7.4-rc2 (

=D0=B2=D1=81, 4 =D1=84=D0=B5=D0=B2=D1=80. 2024=E2=80=AF=D0=B3. =D0=B2 15:49=
, Greg KH <gregkh@linuxfoundation.org>:
>
> On Sun, Feb 04, 2024 at 07:43:24AM +0300, =D0=A1=D1=82=D0=B0=D1=81 =D0=9D=
=D0=B8=D1=87=D0=B8=D0=BF=D0=BE=D1=80=D0=BE=D0=B2=D0=B8=D1=87 wrote:
> > After trying again to create the ipset with timeout option I get a kern=
el panic
> > # ipset create throttled-ips hash:ip family inet hashsize 1024 maxelem
> > 100000 timeout 600 bucketsize 12 initval 0x22b96e3a
> > ipset v7.20: Set cannot be created: set with the same name already exis=
ts
>
> Odd, is this also an issue in Linus's tree, or only this one branch?
>
> thanks,
>
> greg k-h

