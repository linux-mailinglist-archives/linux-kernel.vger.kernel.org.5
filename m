Return-Path: <linux-kernel+bounces-166411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1A48B9A49
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B8E828280E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2367D7441E;
	Thu,  2 May 2024 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nargAQa+"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E425EE97;
	Thu,  2 May 2024 11:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714650880; cv=none; b=IbQmuK5HGJyUB4UvNq9MfQ8PZXkeYFTzH0ZFFa8UTsmmXug6Xa/0VJG6GyLIjvHDIcxlHmACL4BD1xE9bPaoXLUOQIo4t2xtubMErSs7UWG6c3abC6zVKiIN+UqrLDGPfxIzZc8S7B9N2iKSdvsuhL+T2IxQUnAE7iAXUixBEnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714650880; c=relaxed/simple;
	bh=h5Tjw4TpoEBiJBYKY33r1OKSn5zBLW+fZFz/w2uhUUo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dA42XO5Bj6S9UDqVb3VnxEPS5eCRHDvCmuqq7FHJDVo8cAAYc41AT+dKia+/sy6zxwaQuR0/4U/cgWIbiFsm6+Q53g6NJoo+qso5jGz0m+5cSqDOPUoTNrv1RFBbLCHkQY6dhTFM0348x33cDWNnZbEdqY5ttBUT7LtVLd+7UZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nargAQa+; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a58e7628aeaso695002266b.2;
        Thu, 02 May 2024 04:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714650877; x=1715255677; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gy04nTbS8DPKi+ggEZTu+tH2YzPZBzEKhMnRh7OKLpM=;
        b=nargAQa+3ObsoSwPr7BRRfsubd2Eh78ZKAX6GOl4yCLhsOi7QlcGaJIwsOGoM8zoso
         acEh7RsPihx3ouk6Bkds73hCMZ7+WmhqmUbq26UnLxs0sisFvVTbR5M1sMi37v1U1EM8
         DcXVjwdI9DRZJbrkQQOsIC6OoL7tCX6Z7pfc9E0dDriyjbw33xKpSsBXzCIB2eBTIuUV
         huf2sSMp1nSXAZJousk2Zeo3vZOieBQ5kM1I9bX5v8oeGPcBWzv+eOb7U6df+GHbxBu7
         BtjNWqkq4j/kckCm8ikQZj2ZqUznW/yRzTmmTbig26/3N1KZk8nx+RJW8ANYmJQW6mj7
         Ssbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714650877; x=1715255677;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gy04nTbS8DPKi+ggEZTu+tH2YzPZBzEKhMnRh7OKLpM=;
        b=pkYUMTRWAgi10mlktx86KmO1gnr9SMP7vvzmcsqp1a52ZnImG7D4Cg9kbWZn6nVuft
         eszRFPyPyZaYMW1B4fSSqwtyhrw6Q+cYqLcBOThmzfE29MxyczGnVxlfs9HjyoN+V4vd
         Qt2G+KFm/zyTGRbSgwjQiIoTWu7zhq1UQ2UHLRzZMq90BuAvr/f2i7UdSd8n+4UhB53Q
         39VAsQudp1TkBrmNYl9U/ZFkfXXzJPyLe175x1vjJEQW8DgN7ee1Z8dw4XOlo6gQbP5u
         y8ohc/GKmicMTzxTNpmxvgFSzFWaocT+qGkB1Phuch0FLQ3Ovn82lITtRpas1/SndMlB
         V9BQ==
X-Forwarded-Encrypted: i=1; AJvYcCU02pdXmUh2rbl16TDsDQ0hPkCtC2P2xGs1X04xAjmv63IsMp/YZY92vX27/ttQkjcxV1H8KV2zI8yzBAJSMO/GmIO4RE8666dwwSqC1IbzqtEgO88evXqcMzAYHR5m8JS/DWhhxgqT
X-Gm-Message-State: AOJu0YyYE97uRts/u6EKWK1vg11xBLR/WzZQ8ZZd7whHyohLOy555I2x
	okdfVOfFyv5Ce34GQO50RpUU9W6u8qdt8jExkw08vOsgeKzV/4rM
X-Google-Smtp-Source: AGHT+IHcO7WIlEjaTRW6Ask29gFUE4F6UGpV6/Vbb0qyDrI3Nr58AjHI3uaaLi93S6Vb0F+/KM3YCA==
X-Received: by 2002:a50:d5d8:0:b0:572:9b20:fd with SMTP id g24-20020a50d5d8000000b005729b2000fdmr3903023edj.31.1714650876953;
        Thu, 02 May 2024 04:54:36 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id ek10-20020a056402370a00b00572033ec969sm443612edb.60.2024.05.02.04.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 04:54:36 -0700 (PDT)
Message-ID: <d827817909756e4b65a3bb5753d0243e344109de.camel@gmail.com>
Subject: Re: [PATCH v2 1/4] dev_printk: add new dev_err_probe() helpers
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, nuno.sa@analog.com
Cc: Petr Mladek <pmladek@suse.com>, Chris Down <chris@chrisdown.name>, John
 Ogness <john.ogness@linutronix.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Andi Shyti <andi.shyti@kernel.org>, Jyoti
 Bhayana <jbhayana@google.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Date: Thu, 02 May 2024 13:54:36 +0200
In-Reply-To: <ZifXmhyIQASs9UYZ@smile.fi.intel.com>
References: <20240423-dev-add_dev_errp_probe-v2-0-12f43c5d8b0d@analog.com>
	 <20240423-dev-add_dev_errp_probe-v2-1-12f43c5d8b0d@analog.com>
	 <ZifUSKFh2C4VG5QB@smile.fi.intel.com> <ZifXmhyIQASs9UYZ@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-23 at 18:45 +0300, Andy Shevchenko wrote:
> On Tue, Apr 23, 2024 at 06:31:20PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 23, 2024 at 05:20:30PM +0200, Nuno Sa via B4 Relay wrote:
> > > From: Nuno Sa <nuno.sa@analog.com>
>=20
> ...
>=20
> > > +#define dev_err_cast_probe(dev, ___err_ptr, fmt,
> > > ...)	({			\
> > > +	ERR_PTR(dev_err_probe(dev, PTR_ERR(___err_ptr), fmt,
> > > ##__VA_ARGS__));	\
> > > +})
>=20
> After looking into the next patch I think this should be rewritten to use=
 %pe,
> hence should be an exported function. Or dev_err_probe() should be split =
to
> a version that makes the difference between int and const void * (maybe u=
sing
> _Generic()).
>=20

I replied a bit in the other patch but I'm of the opinion that's likely jus=
t more
complicated than it needs to be (IMO). Why is the PTR_ERR(___err_ptr) that =
bad?=C2=A0If we
really want to have a version that takes pointer why not just:

#define dev_err_ptr_probe(dev, ___err, fmt, ...) \
	dev_err_probe(dev, PTR_ERR(__err), fmt, ##__VA_ARGS__)


(yes, while _Generic() could be fun I'm trying to avoid it. In this case, I=
 think
having explicit defines is more helpful)

- Nuno S=C3=A1

