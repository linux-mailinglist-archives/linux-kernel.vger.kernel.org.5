Return-Path: <linux-kernel+bounces-93100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF019872B0E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20EB328185F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4E012D219;
	Tue,  5 Mar 2024 23:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YP1o164F"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB7D12D20E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 23:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681475; cv=none; b=VVh2OebKH75sVVkx6jNYXPoRgF+HGDw7shczHoJo0/jVWYdwwkpnzobyFAvSaKbeqpbOvaLLlJqk0P/4XDree/9IJut8PESnZrcxrWjy/PDe8xOlBlOVj8yDM0zq9qwoDerzgWaFi27oclbWAyLd6mUhwwhxRyJwr+ccMukguSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681475; c=relaxed/simple;
	bh=IGM6i6GgvShorJtiGgulwyEDo+6DhMvbktJqOF3PGls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxViWBOblh67Xbe8Q81m/VlWrP55eLHCl2fkTyj4rO6HTYkj9zDEE7RrtCaCpQ2t8tHz82u09Rg5EEMK9TERo+fPoY9XmldmEA/ExZfJLxfcHrJdDOWf1T+lWL7YIwE9edgBxdtjkBcIz8wbsWGyf2xgNbMhzFhOyPeg3OBr56Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YP1o164F; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e6092a84f4so2508209b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 15:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709681473; x=1710286273; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IeWN+y8hzDjoL2lW91XHHFhLxiQLLm1CjcAWiQRSBT0=;
        b=YP1o164F2HcapLmpYFXpxtKGZV6kxJkqwh4SD7bkqG2qWJbNxoSrC7wU1QnDfsADX3
         iYRZ+lufTjHyjNHfdaJ3EQyCcz6hjtNSnc4K5cmSPTDRvzEhwSE9MLFPxMISlGUrd7rk
         MNu4oMUVw177ctGxl43nBcnk+3QDjM2M5YMQYaS5xCIL2C/TzaUzHEwCR+QVyO9Gl4ZE
         hsZUJYtwRcITvMN6QehxASdqlerPj8+rt18wZ6yEL+RmDarxhDpU2c5zchtQ+Qu02YAR
         DvNMOcKtPFLgyW+80XHHWNIAp1sbNq6bXGr8FfJycNUbMzyLv6CZJVFVwCi2Gr/Jqm6n
         7Jaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709681473; x=1710286273;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IeWN+y8hzDjoL2lW91XHHFhLxiQLLm1CjcAWiQRSBT0=;
        b=cpk3E/MiAsj9WddaAzKF/3FIjJk31toq1SvFsoD3BRHgZyX4B/rwDnQtDsgc9ILK/A
         pJm1gNhkmyPLNVxlMTV+lDX9CC1u79PkQM6JGFYHizU8MnTNg51wUqLnR5aOFJlM5cfk
         943YGugYG4qBmiu2Xj62960ylKe+hNpi0ikHEKV2q/DIhzBeiJ47C4iQYe544MB8AO2T
         2561g3ixIwjWiNVlYV9zVr2kha3743w3o5ThvVGXEFBnNeOCfur8ypAxiaLVDt0NHDL2
         n2f0blO28vdd5rrNfq6WdzVVqtS/U229et/Rx/uMgSP8Lloc6oMm6r0FmcXw0hG2++JY
         u8Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUutcqTBC/FS1YZj4flR97YB0ztFeqEDA+VUB3lJHGiryPRLXAc+gU0+1/guR3gw6bDnA/hBbrSh8dQwgEUY6Q99ZDEztVcFpCZrfc0
X-Gm-Message-State: AOJu0YzGKR60qX+R60LPnqBT7ErcHaefYiVjWOlKt/VKxdGbd2R31IsP
	IOMcGJK6I2lrpcqY6v9tB7VHoSHqw2JfxGHcaLx7ABdOYxffec4Z08wIayce9eA=
X-Google-Smtp-Source: AGHT+IH6l7SgvPlwnEAvb3B1Nw3MuQSM1ObEk9Sj5K4yQCwkP4CpZ0MFTmOvs9B9fyoV59rRWXYXRg==
X-Received: by 2002:a05:6a00:cc5:b0:6e1:482b:8c8e with SMTP id b5-20020a056a000cc500b006e1482b8c8emr14132097pfv.17.1709681472638;
        Tue, 05 Mar 2024 15:31:12 -0800 (PST)
Received: from ghost ([50.213.54.97])
        by smtp.gmail.com with ESMTPSA id m19-20020aa78a13000000b006e509762bc2sm9541617pfa.26.2024.03.05.15.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 15:31:12 -0800 (PST)
Date: Tue, 5 Mar 2024 15:31:09 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Christoph =?iso-8859-1?Q?M=FCllner?= <christoph.muellner@vrull.eu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-riscv@lists.infradead.org,
	palmer@dabbelt.com, paul.walmsley@sifive.com,
	linux-kernel@vger.kernel.org, David.Laight@aculab.com,
	Conor Dooley <conor@kernel.org>
Subject: Re: Re: Re: [PATCH v3 0/2] Add Zawrs support and use it for spinlocks
Message-ID: <ZeerPVB5c7gvgWCw@ghost>
References: <20230521114715.955823-1-heiko.stuebner@vrull.eu>
 <ZTE7eUyrb8+J+ORB@andrea>
 <CAEg0e7jkTOn1pjO=+GaiCZJ9_Yd2NcB1GMG=Q6m3-r0+Q0OjGQ@mail.gmail.com>
 <ZTJUOji+B+dDbMKh@andrea>
 <20240108-a56ba0dfd1779e4ab6893d16@orel>
 <CAEg0e7g34qXbtaGbQftqucRxopFKHvErm=DWx8N65kueDo2n4w@mail.gmail.com>
 <20240108-2a146eb7def54f0ce0b0d930@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240108-2a146eb7def54f0ce0b0d930@orel>

On Mon, Jan 08, 2024 at 03:10:12PM +0100, Andrew Jones wrote:
> On Mon, Jan 08, 2024 at 03:00:29PM +0100, Christoph Müllner wrote:
> > On Mon, Jan 8, 2024 at 12:35 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> > >
> > > On Fri, Oct 20, 2023 at 12:19:38PM +0200, Andrea Parri wrote:
> > > > (Removing Heiko's @vrull address from Cc:, since it seemed to bounce, keeping
> > > >  his @sntech address.)
> > > >
> > > > > I had a quick look at your changes, and they look good to me.
> > > >
> > > > Great.  Thank you for looking them over.
> > > >
> > > > > Did you agree with Palmer about testing requirements?
> > > > > I.e., do we need to run this on hardware that implements Zawrs in a
> > > > > non-trivial way?
> > > >
> > > > I didn't quite discuss such specific requirements or hardware implementations,
> > > > but I agree that's a valid concern.  Not that I currently have access to such
> > > > hardware; any further inputs/data will be appreciated.
> > > >
> > > > > I can try to raise the priority on this here, but can't promise anything.
> > > > > For me it is also ok if you take over this patchset.
> > > >
> > > > Thanks.  Either way works for me.  No urgency from my side.  I'd say - let us
> > > > leave this up to the community/other reviewers.  (IIUC, Palmer was recovering
> > > > from a certain flu and might need more time than usual to get back here.)
> > > >
> > >
> > > Hi everyone,
> > >
> > > I'm also interested in seeing this series resurrected and making progress
> > > again. I'd be happy to help out in any way. It's not clear to me if it has
> > > a current owner. If not, then I could start shepherding the patches with
> > > their authorships intact.
> > 
> > Sounds good to me!
> > Thanks for working on this!
> 
> Thanks for the quick replies! I'll try pull something together in the very
> near future.
> 
> drew

I am interested in this as well, please copy me when you send out the
patch Drew!

- Charlie

> 
> > 
> > >
> > > I may be able to do some testing on an FPGA too.
> > >
> > > Thanks,
> > > drew
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

