Return-Path: <linux-kernel+bounces-166403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAAD8B9A1E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0FA9B21589
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6531CD39;
	Thu,  2 May 2024 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWjgS55v"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5D040BF5;
	Thu,  2 May 2024 11:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714649667; cv=none; b=TXfB6Y4A1n8DIDy561VX2l79h+w0sditc1CRBkjva3cL78+0Ub0mMwR9EEtj503SmXOQU9DYwsimqXibyysQ6ahKoWE6QDxLbAJ3Yda0s+x/s100oR/xBtqtXlMqMQeSy0F6RkUE1Cm7eiiGjlRSLu0/rpw/VJr+wX94Xw+kXOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714649667; c=relaxed/simple;
	bh=LLM2SlrfDRWTvhCWGcc06HwcVM5HMmAS92IM6a+kZV0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hrGNWi2rSy2i/B3XmFAUOEdsa44ocDUq7u8KKJKb2M+k8fIjIjJ3QZx/CKywtqmzGVMabApjyHB8gov3yHTXFlMJ0ofmLwdX5cOBo+X3mCR7cp6wFMzFDbVpwPOSkvDS7y+/BgPdqlpC2i7N+mx2YcX7GujmKqvLTqM2L1KdFg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWjgS55v; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a5557e3ebcaso303684566b.1;
        Thu, 02 May 2024 04:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714649664; x=1715254464; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8BAqZao+EofNOvzcPYtilC6m8qhoNRXQjI+XlEZy7b0=;
        b=kWjgS55vo6kkYjnxtXptMMpIioDc6AHKHweiwXgdtwzSldhbdbkLhNMssiWGjK8QKL
         aGrOhCASzYLeIEmOBTzrL/4+aWRNulSDPbk9w0NAAfvG8KnZZkYk9Q6jpv+JREhGg4O0
         X9Q6ocH0vipWKirM6UgpkhCT9BE9n0aaq1oZ2rRyTba4fCPMFxVdBts+lKBBuN7Sre9/
         Ws87EyAtAdor/tffPJQDXgU7myE6iYU0D52Pcugm9+/bW1+bNKYnPVa5K9Uf2mLanfnq
         eue6KOxIY7UlL1SyZkGJFMRw30yeRtJiM0EG7l//G8GdUhnWvs+Vz71GKhV0cbxxOZRc
         RJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714649664; x=1715254464;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8BAqZao+EofNOvzcPYtilC6m8qhoNRXQjI+XlEZy7b0=;
        b=WwFlsCPQ+CNvwH2xeWzZE4HjaEnCPCG2Pq6SNEn6jGAUvVNt7TJ8eTt4QowRa/5VQK
         sQKIadVZilTplEVla/B0nKZSh5Fe9t46VnVzDCpeXHGcDE8OzUGmvsUJZE+IQ4csUSJA
         RGVgQLxtDFcupEcBrdXW9eqwS/KRy6uyXKWBd+rhSSqGtf4SK69dKyYr/LwzkFtSZBAp
         K9oFkkq2ePWXMMq4fv+uIgTGZrbjxt2a6lQrcNFCJkzlbXnCKB43Ht+VUP85MypMdi1P
         Y6n0XeAYccCpaBmM7Fs5rMZm1iqjcacXpQVtei8aPNx0ezYC3LbglggnZ/jX8iaKjNS7
         HPig==
X-Forwarded-Encrypted: i=1; AJvYcCVRQ4K6SeHb2fti1HruRZ7HhJY5+Tl9Vz8wSBQ0AYdlAsl3uINYKJEksuD6E0FM8x5z/p3NN9OVx+c5ufOf1zbH58la1vEdj4l7r6Cva+tEkMrafIyTznGGvF4DXgsDRGSJIX14dsCB
X-Gm-Message-State: AOJu0YzjT/yHb24qTP8WlorOoVK8UEj2Nbs8bWajRZcYBx2XmW/I/CS4
	l2Txezk73Hx5y2++jIF8QflowKtEI9fyMUK41QH/YK8IvykiMDoJ
X-Google-Smtp-Source: AGHT+IFp+kjl1k6hQgwvrkECAnNXuet9mc9nV3gF3egWXJC8q6uwh5HxzKhb/HzVfSWPvoyLuW6WKQ==
X-Received: by 2002:a17:906:4751:b0:a52:71d6:d605 with SMTP id j17-20020a170906475100b00a5271d6d605mr1937777ejs.23.1714649664029;
        Thu, 02 May 2024 04:34:24 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id l1-20020a17090615c100b00a522f867697sm451456ejd.132.2024.05.02.04.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 04:34:23 -0700 (PDT)
Message-ID: <4a8bf342ecd988f4c3cdeebb6f16da61a60c4454.camel@gmail.com>
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
Date: Thu, 02 May 2024 13:34:23 +0200
In-Reply-To: <ZifUSKFh2C4VG5QB@smile.fi.intel.com>
References: <20240423-dev-add_dev_errp_probe-v2-0-12f43c5d8b0d@analog.com>
	 <20240423-dev-add_dev_errp_probe-v2-1-12f43c5d8b0d@analog.com>
	 <ZifUSKFh2C4VG5QB@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-23 at 18:31 +0300, Andy Shevchenko wrote:
> On Tue, Apr 23, 2024 at 05:20:30PM +0200, Nuno Sa via B4 Relay wrote:
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > This is similar to dev_err_probe() but for cases where an ERR_PTR() or
> > ERR_CAST() is to be returned simplifying patterns like:
> >=20
> > 	dev_err_probe(dev, ret, ...);
> > 	return ERR_PTR(ret)
> > or
> > 	dev_err_probe(dev, PTR_ERR(ptr), ...);
> > 	return ERR_CAST(ptr)
>=20
> ...
>=20
> > +/* Simple helper for dev_err_probe() when ERR_PTR() is to be returned.=
 */
> > +#define dev_err_ptr_probe(dev, ___err, fmt, ...)	({		\
> > +	ERR_PTR(dev_err_probe(dev, ___err, fmt, ##__VA_ARGS__));	\
> > +})
>=20
> Why ; and hence why ({}) ?
>=20
> I even believe the compiler may warn if you have double ;; in some cases.
>=20

Oh yes, no need for any of those...

- Nuno S=C3=A1


