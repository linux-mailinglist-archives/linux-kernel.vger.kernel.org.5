Return-Path: <linux-kernel+bounces-134008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2F589AC0F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 18:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB2C2822C6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC613EA86;
	Sat,  6 Apr 2024 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfh/CeSH"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901BC23767;
	Sat,  6 Apr 2024 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712421428; cv=none; b=kD2x2dT4KKXbulDQhFJjMEJmrU9XGsp6ibRko3yQ1CL60Of6sgyPf7J77dixU9SoRXB3jQOUqIzHpmgoQgGNU0ln/VOOxchvKQOI9RzFLKgRHufAPnKHTM5k32Mz7JRopUGpD1/85Q0NUQJQiC5be7FrUAG7bBBhpn7+VFf/+4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712421428; c=relaxed/simple;
	bh=IVZOvWt13E9Lx86BnX84AptZo1iJ452Y32Rg9sDc6Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZyIHs01cOnui473yaAL6cHvX0Xl5A1wtKv2gb6c23LAv9myp8+VTf1zWE5+p+jM0UAIWmgwR9X9iYpCK3vZ3teucQD7KNkqRjGtiDR9zLlmBR5s+T5lsGsEnrcoce8HM8ZjGfUAETZ1jd0QG5LucrjNh7CPOtZIYwy5LMf1dcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfh/CeSH; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso3207617a12.3;
        Sat, 06 Apr 2024 09:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712421425; x=1713026225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVZOvWt13E9Lx86BnX84AptZo1iJ452Y32Rg9sDc6Xk=;
        b=mfh/CeSHttxe1sW9mNsalIVrkBJ+65uQsWM0WspgrtwSBYNmueMEzbx189snB3gLuv
         bq6VHp4hgr9HpPUMbGi/dXw1cyMTHr4OI/SbwfNRCzTvFVHWE0oO0IpJkzr5pxymNRAm
         Zc7SaWzaHsLqz8iGVw1Niq909zJzEJegTmgA67N3r+DYpIFIIDZPuRb5Jmz4920Gql7x
         na/4jvZDkppX1o1zextJKwhCjxhb5Z/oiZGJanI1QJZdCn0JRKC245j/wkf42RkVNJ6o
         RFZBte+qQCUO7T1AktefK3m5oTY+rvBMNthj606B7lhPRzxxQS6OZ6uc73ZPXjwVC8Lr
         duxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712421425; x=1713026225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVZOvWt13E9Lx86BnX84AptZo1iJ452Y32Rg9sDc6Xk=;
        b=ZkY69gNi3wQgQoq/aV7036WaHdfYmd2osnR+duu1zUWEERFKo3k3W9MnJx121X2IAa
         7Tzig3pDliw57128Q5/zk1ud1DgCHLk2RSOKHJvPbeoOWjYZ94XzYKhWwpn0u06Kv+Oz
         sIOcPuS0VvhQ13LZ6glAveP+/0206nIcIITWfxmNMyWiklW6/YfFmzLPzjidkrOzijNy
         BWufnJ5PU9Cvok9E1F6RNVsAvSX7KkVq0IfNUGevs5JerIHY+Sl0taeDrMeqKDR0j/ff
         7TiUcTtTGbXDfzVLachAtUSo5wAGBG56mAQ680UyLdK6ki9vyetNPykOc9qax5w7m3BP
         FFzg==
X-Forwarded-Encrypted: i=1; AJvYcCU0VGbt8RCOTs9oqaa4M5bunuMdyse0e9Egj2TTzbgIahhr+OFNB7wMNGX06RTb5s8+aUvs6Zyc0wq+6u1JZVvZ2sVYGbQ5/L1L2J3rLVO39MPdV2qVz4m7jB8wdub4HaLX61fATSfH
X-Gm-Message-State: AOJu0YyC2QU4avyYFSydpe2Wbf+gXJDi47Uw+kYgdgdWXIeDh28aDfE0
	qNlL5ESTj84XNVS2mwgbAJtqYl+0kIwMB+c9etMG2exWrxb0jTUjNTmRP0K+Qao=
X-Google-Smtp-Source: AGHT+IHZEJLBi3HD+0r+1gQuKhpDc4VxsgZdHo1RqWOWN8e7o6EyKSVWgWzYQt8+VRQNDlrr87qJAA==
X-Received: by 2002:a17:906:c288:b0:a4e:982e:7766 with SMTP id r8-20020a170906c28800b00a4e982e7766mr2957196ejz.70.1712421424622;
        Sat, 06 Apr 2024 09:37:04 -0700 (PDT)
Received: from foxbook (acgm220.neoplus.adsl.tpnet.pl. [83.9.240.220])
        by smtp.gmail.com with ESMTPSA id g7-20020a170906198700b00a5180d5b31asm2144268ejd.32.2024.04.06.09.37.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 06 Apr 2024 09:37:04 -0700 (PDT)
Date: Sat, 6 Apr 2024 18:36:59 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Mathias Nyman <mathias.nyman@intel.com>, LKML
 <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
Subject: Re: xhci_hcd 0000:00:14.0: ERROR Transfer event TRB DMA ptr not
 part of current TD ep_index 1 comp_code 1
Message-ID: <20240406183659.3daf4fa0@foxbook>
In-Reply-To: <7090d3af-18ce-40e1-8ac2-bf18152e5c4a@molgen.mpg.de>
References: <58bca6f2-797a-4e20-a476-2294309afdd5@molgen.mpg.de>
	<20240405113247.743e34b2@foxbook>
	<7090d3af-18ce-40e1-8ac2-bf18152e5c4a@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> > Is there any kernel version known to be free of this problem?
>=20
> Unfortunately no. It is reproducible with Debian=E2=80=99s Linux kernel
> 6.7.9-2. But in the available logs I found a 6.8+ (=E2=80=9C6.9-rc0=E2=80=
=9D) boot
> with no such error messages, but I forgot to save them between
> reboots now, and lost them. Sorry.

Maybe it's a random error which doesn't occur on every disconnection.

Case in point, it didn't happen when you recorded the log today.
Please try again until you catch it happening, then post the log
showing "ERROR Transfer event blah blah" and the debug messages.

