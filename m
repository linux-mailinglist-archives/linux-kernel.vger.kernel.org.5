Return-Path: <linux-kernel+bounces-135085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A48D89BAEB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F3ABB21FEE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C6E3D3BA;
	Mon,  8 Apr 2024 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K464V8ZJ"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFB13A1CF;
	Mon,  8 Apr 2024 08:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712566413; cv=none; b=Xe9pIBk5JM4npTW6cJgAbKQja3k4E65EMu/GNdgs6UtUcGFK52dmEojkCg5WWqBE/6ONXDPm0cSUZTiNtLdvmyzap2ri4PwhPiLTV0k+Cu2RsWpz1DVn/TLeNl+tGXL4fczezc3gQhnezlY2mWsOHDKJb3TkfQuFFXAtacJoczc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712566413; c=relaxed/simple;
	bh=a7LF604e+4hmNrL5catfHm3kSLy8ZWHDYu3j/rUYFeU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fw9LZAos//bznnPNkM2cXlL4L53ZW4mcsJphCBvyl8J10t+6Y9kYH1LoP7xREGUMqvPSJbNO8prrYGI7jExbayhCYLuNOqm0yC8qOXI2yIJuH2tcU2zrWRgDGl9KfcHnR62QMhiNotf2PBS0geIWGZOVmbRvuiHWJPMba5nvJrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K464V8ZJ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a46a7208eedso610574266b.0;
        Mon, 08 Apr 2024 01:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712566410; x=1713171210; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Awkwoea29RMtqJqGnNUMzoUB24pkT0CE3c1C+yMH/hw=;
        b=K464V8ZJJvGhd9sakgD4kwjxqyRHE1J7pZe2hA96bHixabY8uoOYcFuMpInPc7pyUC
         KVD2cfRxuQSSJ+gOXWTwMBwgPiL7AbSbBb/YQ4Wb8k2/ItSjRMsqKAwVwqwQicHtpPn2
         wcD/csyXwn362n7mwYailB6HjGlfsOyr7+2hj6EWSHBN7cgiYMNHVL2rayHZPI/OIH2s
         Spr2m3LQE/EOumW3ckuYUNfI9DP2GTGLGPR338ovhHjo2miIi3B6ScI6ZApFF1Xaqp6e
         5ObX8+2RozippPVNePSYZ7YCGkm8iLX/zS8yiTkOkq1LaSU8856qM9PCTbcSM8NQOJ9J
         pK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712566410; x=1713171210;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Awkwoea29RMtqJqGnNUMzoUB24pkT0CE3c1C+yMH/hw=;
        b=r5V3V0ls+S7xoTkEcmcI+q6ZHNi2x1nQi0McnSebI98ri9BKqWB0ZpmGHJQvzCM3By
         IwIhnLAZz2L3i8qM68NIZh0/ZznsFmC2vFJ3tImaMWFOrPExnygQKzkvQRUUGoQWp1UP
         TrB5rYjmcXyVbZcao1xoBXtFIUoJdmzJuzweXhNj+WvoFLZYD6I3Z27X0akZJ4gIOZsL
         GUVO9hETHKECJakkyLh7Pyp53dJsO3L8M6YuaYy2nepAeJtVdo+gR/Iqtfpv30/5lXOw
         Bq2uT4DwGsiCceNfqXGbx1dCl2WSU/SaC/lmFI/SPHcs+FOfKuqrso8WVYZSgOAEOpXt
         TVBw==
X-Forwarded-Encrypted: i=1; AJvYcCVMYLKeya0+g+KGwOb/TC1YYB0fLQgvYnsArrVo/xBxSg59WDHAPCndasyF13roDyL9/8jXPl/OOL40HPYy7rNhl25sHQx0GfXNKSkvfzixK4KJ2Wm0byIHEOAMQYn/H7H3cz5Iwj9H
X-Gm-Message-State: AOJu0YxhXpd3L3xDi01USkZO+2EJst9Q40qQokac9u2Z9fTF+q6y4WGn
	3NCjESRrerRvdUI6wtjHElcMPPmL6Gs+WHAExcqZSYk9vc0WXiGQ
X-Google-Smtp-Source: AGHT+IHJL/CYDQQRtL0JdSS3jv/On97DV882M0J5RJxo4BMr9UHxiQxxrGSIM+xAHMcXyXlMD2F4uw==
X-Received: by 2002:a17:907:7293:b0:a51:aebf:7e4c with SMTP id dt19-20020a170907729300b00a51aebf7e4cmr5711487ejc.9.1712566409885;
        Mon, 08 Apr 2024 01:53:29 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id g15-20020a170906198f00b00a4e2bf2f743sm4141159ejd.184.2024.04.08.01.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 01:53:29 -0700 (PDT)
Message-ID: <a13678652cf7f06bb40d78182b02c1398ef06119.camel@gmail.com>
Subject: Re: [PATCH 1/4] dev_printk: add new dev_errp_probe() helper
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: Petr Mladek <pmladek@suse.com>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Jyoti Bhayana <jbhayana@google.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,  Chris Down
 <chris@chrisdown.name>, John Ogness <john.ogness@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org
Date: Mon, 08 Apr 2024 10:57:02 +0200
In-Reply-To: <42sw4ugekugyqzjylsci6tvw5zfxlwz6ypnetnau6dyqnrqfiq@5jde2w4etpfh>
References: <20240404-dev-add_dev_errp_probe-v1-0-d18e3eb7ec3f@analog.com>
	 <20240404-dev-add_dev_errp_probe-v1-1-d18e3eb7ec3f@analog.com>
	 <42sw4ugekugyqzjylsci6tvw5zfxlwz6ypnetnau6dyqnrqfiq@5jde2w4etpfh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-04-06 at 20:35 +0200, Andi Shyti wrote:
> Hi Nuno,
>=20
> ...
>=20
> > +/* Simple helper for dev_err_probe() when ERR_PTR() is to be returned.=
 */
> > +#define dev_errp_probe(dev, ___err, fmt, ...)	({		\
> > +	ERR_PTR(dev_err_probe(dev, ___err, fmt, ##__VA_ARGS__));	\
> > +})
>=20
> I have a whole series adding a set of error oriente printk's. But
> for the time being this looks OK.
>=20
> I just don't like the name, the 'p' is an important detail, but
> a bit hidden... how about dev_err_ptr_probe(...)?
>=20

Agreed, not a very good name indeed.

- Nuno S=C3=A1


