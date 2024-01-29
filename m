Return-Path: <linux-kernel+bounces-43478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABC8841467
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF111F24417
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C999D157E7C;
	Mon, 29 Jan 2024 20:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ahyxeyn2"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0EC157E66;
	Mon, 29 Jan 2024 20:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560607; cv=none; b=sQ4b1twM0A6SH1OqrxVLqhVZ7kLfqoo5LQAvzYFcM6EwfW1HZm+CWO9B/V9QnHQvySkFWp9nBJnFMXUGhmOD8vCmGZnTT4/OtCuwN6clW/ibl52K+rCVx/ELWH2VZCzZeEG2ph1mApqAcJ4Ks0V0TwpwTtEC+CdGM7lTfGaLAqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560607; c=relaxed/simple;
	bh=GMLHhzeeoMbsVJnO8eUGF9Kg4igfMzZgqAvzXEAYxTo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9HJWKfRvPrjwEaWo5Nl9XHmuPUzvyNcvgafXMshq89B0gDlaA2ZDyeptQjcDrAaor9TJyEggDsJZXrk0ucMd00oW3g5n5TNcmcUIMGdeE64Rnv6s3GqTlHxEfH5wglOdTKR2DX7TY5eiskUy5R1zm8EEh6qo3C8FvnN9LGSJYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ahyxeyn2; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-510221ab3ebso4277965e87.1;
        Mon, 29 Jan 2024 12:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706560603; x=1707165403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FmpumCLh7uX/HdOlHuODXjs5jYDB27UWUUlcEeNU+sM=;
        b=Ahyxeyn2uyH9mLt5t6Pe/hhTnyJDUbxDMfcefIE942SNKE6hkrycQt6dLkRZTtm/4X
         HxCwLoHnbvxu4inWFgFGRE6o9Su4VqnfqjUmjGXsbkua1gMX6NTeKVXu2PT7jaia1/TL
         B4pC9gEkVy/jmznMnErVxelPkyqydYxPxfr0AR6IvgpNBmEFdtIJi/XWlLnQqgO52GMg
         zjbEsbZN7zxjv1nMT/w/uwBcPQaWc9fL+mFrtUQNpOJAtFR9U8jjJC/V4Beo35zGfx9P
         mBGs9AVCyBR7OJPjo1QZEYv+QWt055NyW7dHMqYqu+mn4FYMQeY0+9E9zxYRx3b1PXmG
         A+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706560603; x=1707165403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmpumCLh7uX/HdOlHuODXjs5jYDB27UWUUlcEeNU+sM=;
        b=YzhIGz147poaLKU4PmQsG6279rdMS4J1gw+YepcFLo8oHj9tgSmwxvlxZzi6cd4puh
         zcIcYBViLAA9VG2G0SLWTxS5be661xjRGyIuvB2c/uQ/KzqFKYbH7UupZRumwLD8gaJy
         T2qDMqfxFAQaW519LltnWPd/NKaePQ2Eq/OROqRtjwDtsIJYVnmvyTKDQ67C8wHJ9+Um
         7ja3cSJU2UL9fngonF6wexYQChVQarMTqak7s5FA5ERAUXsUqRQpJOEieLoFZ5UFyyy1
         MvbZCGPmY/8nhX3pkhrbjn9icCm4YlCVmtHdzUsUWergwfhdxf7ohyeEgEsEI2KEPm2d
         n0Cg==
X-Gm-Message-State: AOJu0YxQjrrWiaZxyUWIpHrjjzW7fTecqHUPXyc0pKHb4AsCIC6kOE6x
	bI9RySlkE2msRVM9FWzQSh8xxFuX1cuSreh0uRnCB+APyGd2/Whb
X-Google-Smtp-Source: AGHT+IG92gsE08T9oz1FCAOmq5Cjrq8PKd6HOERnTK2/QfqSyC36jCzgLEOzGKCmP89mOdD44GJz+A==
X-Received: by 2002:a19:5f12:0:b0:50e:d3dc:2245 with SMTP id t18-20020a195f12000000b0050ed3dc2245mr4383104lfb.58.1706560603115;
        Mon, 29 Jan 2024 12:36:43 -0800 (PST)
Received: from pc636 (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id s15-20020a19770f000000b005102473541asm1227797lfc.301.2024.01.29.12.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 12:36:42 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 29 Jan 2024 21:36:40 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v4 0/4] Reduce synchronize_rcu() latency(v4)
Message-ID: <ZbgMWGmG3g-IvOw6@pc636>
References: <20240104162510.72773-1-urezki@gmail.com>
 <620b475d-eef8-4396-9d3a-d3dcf1d70f9a@paulmck-laptop>
 <ZbfQ5cOkeReti7J0@pc636>
 <adb813a3-e24e-4fb3-b1cf-fad5a571fe9a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb813a3-e24e-4fb3-b1cf-fad5a571fe9a@paulmck-laptop>

On Mon, Jan 29, 2024 at 11:43:43AM -0800, Paul E. McKenney wrote:
> On Mon, Jan 29, 2024 at 05:23:01PM +0100, Uladzislau Rezki wrote:
> > On Fri, Jan 26, 2024 at 11:07:18PM -0800, Paul E. McKenney wrote:
> > > On Thu, Jan 04, 2024 at 05:25:06PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > This is a v4 that tends to improve synchronize_rcu() call. To be more
> > > > specific it is about reducing a waiting time(especially worst cases)
> > > > of caller that blocks until a grace period is elapsed. 
> > > > 
> > > > In general, this series separates synchronize_rcu() callers from other
> > > > callbacks. We keep a dedicated an independent queue, thus the processing
> > > > of it starts as soon as grace period is over, so there is no need to wait
> > > > until other callbacks are processed one by one. Please note, a number of
> > > > callbacks can be 10K, 20K, 60K and so on. That is why this series maintain
> > > > a separate track for this call that blocks a context.
> > > 
> > > And before I forget (again), a possible follow-on to this work is to
> > > reduce cond_synchronize_rcu() and cond_synchronize_rcu_full() latency.
> > > Right now, these wait for a full additional grace period (and maybe
> > > more) when the required grace period has not elapsed.  In contrast,
> > > this work might enable waiting only for the needed portion of a grace
> > > period to elapse.
> > > 
> > Thanks. I see it. Probably we also need to move "sync" related
> > functionality out of tree.c file to the sync.c or something similar
> > to that name. IMO. 
> 
> I would prioritize moving the kfree_rcu() code out of tree.c quite
> a ways over moving out the synchronous-wait code.  ;-)
> 
Indeed. But i am not about priority :)

--
Uladzislau Rezki

