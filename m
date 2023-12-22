Return-Path: <linux-kernel+bounces-9987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F08281CE2A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18231C2093C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0312C186;
	Fri, 22 Dec 2023 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqDdkfuM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD3028E0A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d532e4f6d6so1347640b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 09:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703267636; x=1703872436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wMwI3JiFhCatZ6GKdsA7T1QzqYPoMqXvmXSq18TGbUU=;
        b=HqDdkfuMflQDGrLYWQPPSENeQ/7lXMiQTHGWRvkQCa71uGObQMOhbbyd3z9kMwDJ6S
         xSqznl6mRvvI50ZdZIH0YIQEGyhqgRIBEObe+TloIzcUKw6StQiBmtM4kmgSG4Z5aHtn
         nsJpgmn7x/CkJ18KuiDtxE089dWs8wxK5SM7+z7JK9CtA2SwiVdKZkgvHC/NTHPf5VMB
         Dp4xLzSBLfbkLIfeek1uNCcD+IYCNaPCz7RZr6cZKKn9jfIFRnyce0XZdPPL5mHqEhqV
         QT30kKWHCwL0f063udz8jtcG8nEgKmQc1GDujxzA8WMTtJ2Alld7ZQazXIhgJNotT+GD
         63VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703267636; x=1703872436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMwI3JiFhCatZ6GKdsA7T1QzqYPoMqXvmXSq18TGbUU=;
        b=Qc4FXz9REMS61ClTgorSP9oJZErODRWBle/2r3i1PFxUnUG2h9ZLISpQv6YLCC7WwL
         aIDcs69x4Uv9IwZoD4hvgurwzHvNbjVMgOx9HlpJAcurWX9g3sEoTG9QWtuugJ1nzXov
         l+Kb9UT/2c4blxIZAhbzJ7rOpcwEEQqsz3cpRl+yqr/89a49Kta/yvPLEgz0ESvxQe11
         LiCBozyQRxK+q3rtwXe9Rx36ckNbk65yHn0VAY8WxG8upfzbx+zX3APVyIA9Tap2lXKt
         aRpKSqOzvLuirFhv1J/TOllcq0z65Et+74vtcrjdO1a/KCgCnVyI9JT+a+yJEmntZKXx
         3LwA==
X-Gm-Message-State: AOJu0YwClk0qxXk+sIlxze9CAPwm7+tSGWdaBMtMpIrkFYtCkt4ZUO2D
	Zs1isMMmqvkoyLoDQkjBI4E=
X-Google-Smtp-Source: AGHT+IFOaEGfQXr6296bEd4kRhFXYdIGTHFStsbbHF5ORt9QvsDecEXUMwpnshp0Mm0clmU1npWWyw==
X-Received: by 2002:a05:6a00:23c5:b0:6d8:aa4a:8315 with SMTP id g5-20020a056a0023c500b006d8aa4a8315mr1590144pfc.47.1703267635859;
        Fri, 22 Dec 2023 09:53:55 -0800 (PST)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id x12-20020aa793ac000000b006d980fa11e9sm2184980pff.51.2023.12.22.09.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:53:55 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sat, 23 Dec 2023 02:53:52 +0900
From: Tejun Heo <tj@kernel.org>
To: Audra Mitchell <aubaker@redhat.com>
Cc: Audra Mitchell <audra@redhat.com>, linux-kernel@vger.kernel.org,
	raquini@redhat.com, jiangshanlai@gmail.com,
	hirokazu.yamauchi.hk@hitachi.com,
	Laurence Oberman <loberman@redhat.com>,
	Donald Douwsma <ddouwsma@redhat.com>
Subject: Re: [PATCH] workqueue.c: Change workqueue to accept variable length
 name
Message-ID: <ZYXNMEXBnuumL3D6@mac.lan>
References: <20231215193954.1785069-1-audra@redhat.com>
 <ZYSwieA7FeYLh5Ey@mtj.duckdns.org>
 <CA+bDH-v6T5vvyOwsphseHwgihdGQta7TZ9tOtt-Fnij92kvU6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+bDH-v6T5vvyOwsphseHwgihdGQta7TZ9tOtt-Fnij92kvU6A@mail.gmail.com>

Hello,

On Fri, Dec 22, 2023 at 10:35:03AM -0500, Audra Mitchell wrote:
> We have one concrete example from a Hitachi block device driver (notice the
> 47a1/47a2 gets
> cut off with the workqueue name):
> 
> Device                              Workqueue Name (24char zero terminated)
> /dev/sd0279b080047a1   xfs-blockgc/sd0279b0800
> /dev/sd0279b080047a2   xfs-blockgc/sd0279b0800

I see, so it's a combination of somewhat lengthy device names and then xfs
adding a prefix to them. Neither is particularly long but the combination
is.

> I can also imagine this issue being present with nvme devices, but the
> request came from Hitachi.
> I believe it would be up to the device driver to determine if the name can
> be shortened and I've
> included Hitachi requester on this email thread.
> 
> Alternatively, we could increase the size of the WQ_NAME_LEN, but it seems
> highly likely we are
> going to butt against the static size again in the future. We previously
> had variable length names
> and it seems (to me) to be the best long term path forward.

Can we just bump the length to 32 and trigger a warning if the requested
name overruns? I want to provide some pressure to limit the length of the
name so that it doesn't get too long over time. If folks bump into it and
can't find a different way to deal with it, we can get bring back the
subject.

Thanks.

-- 
tejun

