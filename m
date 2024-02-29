Return-Path: <linux-kernel+bounces-87566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B4386D5FA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8237B1C23F1B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F3316FF40;
	Thu, 29 Feb 2024 21:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="w7POS9lx"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FAE16FF31
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 21:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709241303; cv=none; b=T76NG7TUxVYpesy02IedhVVlcnv8Ex3LKSAxqAvOmxZJSaLKZ9s2PYk8lM2l6ZmjTpfrmh1A7uF24Ndo7kYghYPgkV/Q2v6fhO6OYKuqqoKx0pmX7FXcraZwfWdH+4l9hvY25f5wrDhIyStFop36r08oAotjaQXe01dABdZJdmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709241303; c=relaxed/simple;
	bh=X5fnAUTNVB5E1nS/HE+h4eWD5PRl4JvDW+rjzkoREhU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VYNggKf9SXXk7BoW9tTeb91IXz1hh4AvOF53DUNs3FJnc1MQ0lzFLLjDcDJ2uL5gPHC+NOsEFrBHoHJiQZq/tltGL2g1eCmKcmlMs4pZfycxwmYHMdT3dGYhVVrwZXYA3myrQPcigBM14WBmsgjEfqpToRSK2GIxh/G4vQyoknI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=w7POS9lx; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3d484a58f6so231284966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1709241300; x=1709846100; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5fnAUTNVB5E1nS/HE+h4eWD5PRl4JvDW+rjzkoREhU=;
        b=w7POS9lxcR7lOEtxqCepB0Qx/npBzbYs+roIXsRqn4t2BYtKJZ/wpFHxNhKlQ5pBk9
         Xq8t5ennb11yzPwinVyl1eagOqglCn+o+j2JcGc12mcMznKB0XKvmhKfQtbnOwGxi+G3
         aKUt334ifu/qban7UihCjbRuW1+heC3nU8vdD7suOkYcwBfNk3OhOKB2YgxBusNzEFdA
         ZFFfQUhD8cSI4amHCfkx2KuDuvwKI7HBtA8kW04719LlOe1CyzOurpqMgXtE9hhoMSF/
         LT60HPXm+DwCldwIYvYZds5HcfbycyB1BXUucHFhBtCFCejAVhf3ITy9aeCVdzFAjblF
         +W0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709241300; x=1709846100;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5fnAUTNVB5E1nS/HE+h4eWD5PRl4JvDW+rjzkoREhU=;
        b=Z8ioXMt0BmE2yTNWvR/ONeYCvZ9WvgWOWpqBvg33XDsCEKuqqo2NiaH+jz2g3ePR3i
         +54WR31m81nnJyAAI9MyL6CwvwvikLPl/p/rVvym0DUK4kUUOe/zslCCg4KHbR/B/zyM
         L84f8n/3PeXi4DRs92RlNZOfFNf6yl9BFN6CndsCfsD39XUhcKJjgoHCQg9jI9jtA/uY
         i+RrBDSStTbWHIHpyHDrQbsIkRHBaBkMwnWvpp+fNwI67naKBFPz9tN3691xU1+78tDQ
         Fn/TN0FA/UWbayn6xt9HB8vE0upp91+wXBOWHziaTeBSgnjTgiMyifrQ1pfjOgg+EF4h
         m61Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/j3o6YJ5ibOsjkJ4mjbkE1lgqnKdzvS8J1P3EBWFeOTrq/yKdRo9VQtZ+/L9zZra873tn8YV4zHzRZgn28sEpLSmyCxWRiYP8/Dzc
X-Gm-Message-State: AOJu0YziqHza42WulOSt1LGv5FdJGJaek6LfEbBIn4NfREvFQu6O6ARE
	hzAxIs2pnz4tJq0MAblN4vRYMC5ROcvmAEZFzSmJ15xZ2NEgSicCDhXWwqj/r6a0mtmzBqjS7nz
	4
X-Google-Smtp-Source: AGHT+IHbRqbb3QQhTbSEnTrcrs34FIveCIS4tXNzk2mvYxkOuYflsMH8fhz9wWnJlAbyijS6zEK1JA==
X-Received: by 2002:a17:906:c2d7:b0:a3f:3c26:b250 with SMTP id ch23-20020a170906c2d700b00a3f3c26b250mr92460ejb.40.1709241300274;
        Thu, 29 Feb 2024 13:15:00 -0800 (PST)
Received: from smtpclient.apple ([2001:a61:1069:f701:6c1a:d05d:ad7c:b80d])
        by smtp.gmail.com with ESMTPSA id jg29-20020a170907971d00b00a4412406741sm1032579ejc.131.2024.02.29.13.14.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Feb 2024 13:15:00 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH] nilfs2: Use div64_ul() instead of do_div()
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <BFEA2A31-3147-49EF-A9BE-592C90E783DD@toblux.com>
Date: Thu, 29 Feb 2024 22:14:48 +0100
Cc: linux-nilfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <215C3176-D6E5-47CF-BC48-7A75CF75CE3F@toblux.com>
References: <20240229121650.33983-1-thorsten.blum@toblux.com>
 <CAKFNMomtp7ZwB0gmxoemp_ums4rqOSbfF2BMS6kX+LwtKYtvCg@mail.gmail.com>
 <19910196-DFF3-4F94-B6D3-B9BF722DF8B8@toblux.com>
 <BFEA2A31-3147-49EF-A9BE-592C90E783DD@toblux.com>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
X-Mailer: Apple Mail (2.3774.400.31)


> On Feb 29, 2024, at 21:40, Thorsten Blum <thorsten.blum@toblux.com> =
wrote:
>=20
>> On Feb 29, 2024, at 20:41, Thorsten Blum <thorsten.blum@toblux.com> =
wrote:
>>=20
>>> On Feb 29, 2024, at 19:45, Ryusuke Konishi =
<konishi.ryusuke@gmail.com> wrote:
>>>=20
>>> All of the fixes in this patch seem to be correct, but this doesn't
>>> cover nilfs_resize_fs(), nilfs_max_segment_count(), and
>>> nilfs_sb2_bad_offset(), which also have do_div() that doesn't use =
the
>>> return value.
>>=20
>> For nilfs_sb2_bad_offset(), where the dividend is u64 and the divisor =
is u32, we
>> would need a dedicated function like div64_u32() that doesn't =
calculate the
>> remainder, which doesn't seem to exist. What do you think?
>=20
> Never mind, there is div_u64(u64, u32). I'll submit a v2 shortly.

I left nilfs_sb2_bad_offset() unchanged in v2 because div_u64() still =
calculates
the remainder.

Thorsten=

