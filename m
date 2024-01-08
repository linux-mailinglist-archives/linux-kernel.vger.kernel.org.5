Return-Path: <linux-kernel+bounces-19679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BB68270C2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24D21C21F59
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321F74776B;
	Mon,  8 Jan 2024 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TsEp8ndB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE7547775
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a28d61ba65eso195577366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 06:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1704723014; x=1705327814; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sli6pHW4snD64U/PJNI9lNskueO/Odf6cbKyshVP46s=;
        b=TsEp8ndBUVW6hog1LyaiOEGzs2GCiqPdCMORE5AVtPd3Bi0NuvdOJk5w317si04RE1
         6zqk7oKIAbFaRThy5lmeOpeVgCzBzdx90AEjmhLWnXbUbEqLjmb+q6Jn0ICJjvN1MvRn
         kHgafDrKhzyQymxiHz3vfXt/HpWhJgrjPakHHTMYhurdMD9tLiACadRcgR5UjK3phRmR
         crhPXHMl8/ba7v5RK219/dUbtgUvr4uFzLXAl9746ymEltQGjGn1adKYRcVHbQ5kHFG8
         Sx/0p1TEXtEzyxwyQJKoh4bJHqBEbX4cOwMFAIKGzr1oFYRz+4F/DymL0AsFL9uv60wC
         F8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704723014; x=1705327814;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sli6pHW4snD64U/PJNI9lNskueO/Odf6cbKyshVP46s=;
        b=kc3mvRVYgK5s9q7QpyB+dgCc6HcVlcIdiOy/tgDNQ+SDchH6tYHu6ZXtGJp2STcVEy
         KATLDiPajDnBp6clA/miK0QMqDZUCQHVf6JiOf3C4c1x6rJ9FAsWN1DkyTsa7x1lrC/7
         wzN1wMArhg4W8Yo2tLENcqmQIUFk+wNzITwkMlp+2MTT3mlGTZJYbr6JetVNB+H03nmI
         E04AvkLhUUl2DP+WrNxQhj/ya2XuqFHMCYO5uAOfzrhTTuE7BMqU4QzhN7dg+eMmbuvA
         Ud1waqMG0NLOqnHTBXP/J2OpXuBH6f99BPEV1ccvGIAc4o8rXGHI5JJyKvlypDnNwg7V
         nGaQ==
X-Gm-Message-State: AOJu0YyQaDY9zVyb0Za+/g68P8Is0mrR0dTLEhwwp+ElVFFBQaskgc7o
	CFmvPL3xgMEvkKi8nMwcdzgyei47s6evdg==
X-Google-Smtp-Source: AGHT+IEc+ioqQCPkFv/0Qw/q3QTPky0In6mMez6POYkKj2fpR3ZXGVYyQe1Z8L4sJDJw2xb6XCq8Jw==
X-Received: by 2002:a17:907:77d5:b0:a28:c8bd:fbfc with SMTP id kz21-20020a17090777d500b00a28c8bdfbfcmr1079871ejc.215.1704723014062;
        Mon, 08 Jan 2024 06:10:14 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id fi5-20020a1709073ac500b00a29db9e8c84sm2654238ejc.220.2024.01.08.06.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:10:13 -0800 (PST)
Date: Mon, 8 Jan 2024 15:10:12 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Christoph =?utf-8?Q?M=C3=BCllner?= <christoph.muellner@vrull.eu>
Cc: Andrea Parri <parri.andrea@gmail.com>, 
	Heiko Stuebner <heiko@sntech.de>, linux-riscv@lists.infradead.org, palmer@dabbelt.com, 
	paul.walmsley@sifive.com, linux-kernel@vger.kernel.org, David.Laight@aculab.com, 
	Conor Dooley <conor@kernel.org>
Subject: Re: Re: Re: [PATCH v3 0/2] Add Zawrs support and use it for spinlocks
Message-ID: <20240108-2a146eb7def54f0ce0b0d930@orel>
References: <20230521114715.955823-1-heiko.stuebner@vrull.eu>
 <ZTE7eUyrb8+J+ORB@andrea>
 <CAEg0e7jkTOn1pjO=+GaiCZJ9_Yd2NcB1GMG=Q6m3-r0+Q0OjGQ@mail.gmail.com>
 <ZTJUOji+B+dDbMKh@andrea>
 <20240108-a56ba0dfd1779e4ab6893d16@orel>
 <CAEg0e7g34qXbtaGbQftqucRxopFKHvErm=DWx8N65kueDo2n4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEg0e7g34qXbtaGbQftqucRxopFKHvErm=DWx8N65kueDo2n4w@mail.gmail.com>

On Mon, Jan 08, 2024 at 03:00:29PM +0100, Christoph Müllner wrote:
> On Mon, Jan 8, 2024 at 12:35 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Fri, Oct 20, 2023 at 12:19:38PM +0200, Andrea Parri wrote:
> > > (Removing Heiko's @vrull address from Cc:, since it seemed to bounce, keeping
> > >  his @sntech address.)
> > >
> > > > I had a quick look at your changes, and they look good to me.
> > >
> > > Great.  Thank you for looking them over.
> > >
> > > > Did you agree with Palmer about testing requirements?
> > > > I.e., do we need to run this on hardware that implements Zawrs in a
> > > > non-trivial way?
> > >
> > > I didn't quite discuss such specific requirements or hardware implementations,
> > > but I agree that's a valid concern.  Not that I currently have access to such
> > > hardware; any further inputs/data will be appreciated.
> > >
> > > > I can try to raise the priority on this here, but can't promise anything.
> > > > For me it is also ok if you take over this patchset.
> > >
> > > Thanks.  Either way works for me.  No urgency from my side.  I'd say - let us
> > > leave this up to the community/other reviewers.  (IIUC, Palmer was recovering
> > > from a certain flu and might need more time than usual to get back here.)
> > >
> >
> > Hi everyone,
> >
> > I'm also interested in seeing this series resurrected and making progress
> > again. I'd be happy to help out in any way. It's not clear to me if it has
> > a current owner. If not, then I could start shepherding the patches with
> > their authorships intact.
> 
> Sounds good to me!
> Thanks for working on this!

Thanks for the quick replies! I'll try pull something together in the very
near future.

drew

> 
> >
> > I may be able to do some testing on an FPGA too.
> >
> > Thanks,
> > drew

