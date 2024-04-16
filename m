Return-Path: <linux-kernel+bounces-147256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C52D8A719A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D6F285DC7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D34412BF3E;
	Tue, 16 Apr 2024 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yp266Txg"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4355037165;
	Tue, 16 Apr 2024 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713285773; cv=none; b=S4j8V3/W+5WvDijSuGxDXaQWFxD2aZ2CIELNI7yKtWLptIK6HBcbXagWPcAC4zyL7LF7HSu0Bfy7p9P+X6GYYl027oimIzIP49Ksa5KixEykwbFqjUFvsPuRm17t9TYwCBFj8HBzVQ9wpBV+93YGv+Ko450buJ0deLnhi5rSKJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713285773; c=relaxed/simple;
	bh=CC0S305U35zIkJGtFTFCEqBoI2MVVEtglxslNlo1XDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGfZfVUB56pvJ2mtppa/4DloPGdTTV+tprDPaH5N3h69P/YxumdXAf+Z0RjYwn0D+tnewD/COozzIb7r8SzH7Hyg7K29uemKRKE1+OsEgaeoEfT0FIscLk4EQDix7ziW44c0EaMZ/K5NmfFOdj7hmmHi4eb5Jrga83MG9Rh0ndU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yp266Txg; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5701f175201so764486a12.1;
        Tue, 16 Apr 2024 09:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713285770; x=1713890570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2lUB89b6buZi5ejkVzKNCjr9hh4irgP4yDpViGhEGr8=;
        b=Yp266TxgU3EpaDQbqVaN2YNENq7CVsLaX7JWQfFFqY7+yuuG8cjJgUay/g+KWbfZN/
         wm/EVcu1SvB+HeLOUXeY8DlBtjj9WA+TW5TdISrIa2tpGdgrwwTO69NYgX+X+cW9Gaih
         s1DjjtGTDyQSXV/QMdD6uNXMrRZsuF/blPqd+6s1SKC20KBraS+EI0yF97RznmLUkhc7
         krf0bUzLYk84NfU/KU32eKk4lWfcaf3L5qiUmOVO80UiTO3tpdqbqjSauZ/schr1KKWJ
         fU0qM9gSSKzCxSMFopw03c8TuFwOM14C48nNsCXMDS5VxgLXGjwlrPkckyJP8GKOo97I
         FBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713285770; x=1713890570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lUB89b6buZi5ejkVzKNCjr9hh4irgP4yDpViGhEGr8=;
        b=ZQ18MPrlTEogNRmRyA5PImQL1fwa+bmOOHYx6IxV5cx3seAvzBVI+a4EbEM4lfuybu
         QRV/s9MJ0+mWAFTHL93ZDEkw7gS0wXvF5i4a9qQQVE/sej/45wOubCV+HBNvGVIeYh1P
         al1QVKUGrDlYwX/8b1gSQ/FKCS1IEQyPQkp0ni9WWp5DfXsr0Y1wx060UBCnYqwLudQp
         9w+2hcNabMmPLw2BP7Sszr8H5iD1KRx1/okb3jyZFU11a4MPwQ2cUYa6YQPWWl7VMCbY
         nxZq6N5ImWAg23ebXYh0M58ytFwh/RpuH6EYPa7wIuN29dFQmj1psGOM2pyP7Ttug4sC
         FzoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSLZ1mRONh4gDF/I8U3EPJT0Hp1nPo4CXQzY/Ql5OdEbzUPuv3ifL5TYJw11dMjt+mpr5IsoBDL3i6nQFc6/eQSPHvOd4JRptGj4o2PxkBKXMQwuWeFCZ6vcCbFO6xl5jiUmW0TDaE0g3qKVTSTHp6Oj73vi7s9uWbU97tF+Hg
X-Gm-Message-State: AOJu0YyBUgX9jbNoHUowt7LxOqtQbT7ZD4Gye7hBPCS6QbqOBo1q2GGS
	mKXg7qfp3aKF/p7bWXmB8/FkB0uBdFKhNMpUqdryYd1/2uIAt7ox
X-Google-Smtp-Source: AGHT+IGg52/TIeKf7RA3jDSqi7tmSPAqi8YvPA2XIxhyiS1sZwhSt3bySdswPNKlfSTBSOxRMvLSjA==
X-Received: by 2002:a50:9b1e:0:b0:56e:d54:6d63 with SMTP id o30-20020a509b1e000000b0056e0d546d63mr12897968edi.15.1713285770337;
        Tue, 16 Apr 2024 09:42:50 -0700 (PDT)
Received: from fedora (host-79-27-41-113.retail.telecomitalia.it. [79.27.41.113])
        by smtp.gmail.com with ESMTPSA id u12-20020a056402110c00b0056e51535a2esm6276502edv.82.2024.04.16.09.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 09:42:50 -0700 (PDT)
Date: Tue, 16 Apr 2024 18:42:48 +0200
From: Francesco Valla <valla.francesco@gmail.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <vincent.mailhol@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>, fabio@redaril.me
Subject: Re: [PATCH v2 1/1] Documentation: networking: document ISO
 15765-2:2016
Message-ID: <Zh6qiDwbEnaJtTvl@fedora>
References: <20240329133458.323041-2-valla.francesco@gmail.com>
 <20240329133458.323041-3-valla.francesco@gmail.com>
 <CAMZ6RqKLaYb+8EaeoFMHofcaBT5G2-qdqSb4do73xrgMvWMZaA@mail.gmail.com>
 <9f5ad308-f2a0-47be-85f3-d152bc98099a@hartkopp.net>
 <CAMZ6RqKGKcYd4hAM8AVV72t78H-Kt92NXowx6Q+YCw=AuSxKuw@mail.gmail.com>
 <64586257-3cf6-4c10-a30b-200b1ecc5e80@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64586257-3cf6-4c10-a30b-200b1ecc5e80@hartkopp.net>

On Sun, Apr 14, 2024 at 10:21:33PM +0200, Oliver Hartkopp wrote:
> 
> 
> On 14.04.24 06:03, Vincent Mailhol wrote:
> 
> > 
> > This doesn't remove the fact that I think that this naming convention
> > is stupid because of the RAS syndrome, but I acknowledge that CAN CC
> > is now the official denomination and thus, that we should adopt it in
> > our documentation as well.
> > 
> 
> ;-)
> 
>

I honestly did not knwow the new CAN in Automation naming scheme. Will
keep the CAN-CC here. Thanks!

> > > > Add a space between ISO and the number. Also, update the year:
> > > > 
> > > >     ISO 15765-2:2024
> > > > 
> > > 
> > > Interesting! Didn't know there's already a new version.
> > > 
> > > Will check this out whether we really support ISO 15765-2:2024 ...
> > > 
> > > Do you have the standard at hand right now or should we leave this as
> > > ISO15765-2:2016 until we know?
> > 
> > I have access to the newer revisions. But I never really invested time
> > into reading that standard (neither the 2016 nor the 2024 versions).
> > 
> > Regardless, here is a verbatim extract from the Foreworld section of
> > ISO 15765-2:2024
> > 
> >    This fourth edition cancels and replaces the third edition (ISO
> >    15765-2:2016), which has been technically revised.
> > 
> >    The main changes are as follows:
> > 
> >      - restructured the document to achieve compatibility with OSI
> >        7-layers model;
> > 
> >      - introduced T_Data abstract service primitive interface to
> >        achieve compatibility with ISO 14229-2;
> > 
> >      - moved all transport layer protocol-related information to Clause 9;
> > 
> >      - clarification and editorial corrections
> > 
> 
> Yes, I've checked the release notes on the ISO website too.
> This really looks like editorial stuff that has nothing to do with the data
> protocol and its segmentation.
> 

The :2016 suffix is cited both here and inside the Kconfig. We can:
- keep the :2016 here and then update both the documentation and the
  Kconfig once the standard has been checked
- move to :2024 both here and inside the Kconfig
- drop the :2016 from everywhere (leaving only ISO 15765) and move to
  ISO 15765:2024 only inside the "Specifications used" paragraph

What do you think? Shall the modifications to the Kconfig be done as part of
this series?


Best regards,
Francesco Valla


