Return-Path: <linux-kernel+bounces-95530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65155874EF1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970A81C24253
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE9712AADB;
	Thu,  7 Mar 2024 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLWngpDO"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3463F85295;
	Thu,  7 Mar 2024 12:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709814309; cv=none; b=Ih2e192+aTbEzi/cAZjaSz+MaXhgv1LujI0H5JIj2HGU/Az0dgcadxLLlOGooqeGCxMe1jQ7PVpz5vLhWs4mgqDiiqNZYYuzupma2DqhYhgwDmMsBZsNWz+nDyDb8EaOf1p97Lv9JtOkvqKDhRIa2F//IcURxWlEWBNRIzHeRVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709814309; c=relaxed/simple;
	bh=Ps2Pga0YHAnRUKtQulE0KfhMPOJNeNkZo3mZ3q7OlXk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRtssq/dyXl4VvQ6YZU71VHAhkv9KqNyZWwlddZKkrCW0DgfK0NBxnRt0Rk2th+ic/gg2x1YIXuYiVGUVSuV+OTdSIQCv4PbD6rPtn6SItMjo9cvHx0SSNBsZ+b/AFzA0TcFQ9cEqXrOSKUUTH4OiQpTwPfPA56ZZ2dQTd95+sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLWngpDO; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5131bec457eso669005e87.0;
        Thu, 07 Mar 2024 04:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709814306; x=1710419106; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pXzNaSKoAG/AcU8rFIblCw0pDMYBGob1pwocBdLoiyg=;
        b=DLWngpDOqDmBqMU1MJc0B6MetuMtIRZiEaTJ/hSYvCwX8jkfvAvtgPzmZn01VgpAZX
         kms3wD1+uBmI8wVTuTLBpG3TZxOocZk4BQ0QK5+KMObkekJOU98IdLR8LpvB37twMrjm
         ZN8QIE8ti8ddf/Ccn1oO4HpqEFxgR3jHNNDK6Pc6dQlvZvpYFmnw5QXJwm2vbqzhw12y
         +/a4qVXfl/Y6xUoF4dVl50KX34DrDiL9UZRZixDIozrCzRfNQwPXLWXka+ekemhApisc
         BPPWiwY5Ly1x/c90nL6KDVaVbGfAR0TRsiy+ZvoJyHY4ajwv+w189Bsu4jAYo+t2iOBg
         hraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709814306; x=1710419106;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pXzNaSKoAG/AcU8rFIblCw0pDMYBGob1pwocBdLoiyg=;
        b=dMUt0A0Wbos1mheXpk8Bh8FcTATVM78zYrU4alIrqk7GqCrKd+IPkeKkrqeE3gv3Gw
         8mXTOn54ulvvL+7bgB7D3ShcWqj0JZQ0zl0g91lvzFqjRwd3ZhzjXgufD1brBYHQfISi
         7NPk7TcSBeTzqNTy23fpWkL6J90pXULRIP6VpIexctzJZF07LUFupFFTwDdn67X8CHjg
         owxtHfF2/i5UAKPPe2sGkETsWDyGsBGLBPHiadReLlV1wVcwhWSkcVmf3aMnmgYJqrXH
         fDhlDymvufiDeuZ2bq8vha3/ydB0NxGwuJ69GzPemrQMQ0BfKvlzmPWmjmJrqHIjY5MN
         +20w==
X-Forwarded-Encrypted: i=1; AJvYcCXgo9Rp65NToFK4RwKQ2GBhCDK5MsD15QnG/9U8z2QRbEz/JZu194Ib4GioZoOOpc1tWaxnwsYn5//2MyY8SH6dgVayMsiaW9b2yhw/hnWeTLVYvXqwRRkTLIra3vMkTnHA
X-Gm-Message-State: AOJu0YwnddC2IWL11gV65eSJfsHNjanBTv0gBkrxH6gKRZ4ccJQUQ0Zr
	8Ix/yYLWReIMSqB0tvCUpnhPBwF6SyO5XZJPZV/l8wiKOI7fQM0V
X-Google-Smtp-Source: AGHT+IGPjfSJ6D9zevlKb4BfcULczielHsymiFu4fOT3qgLgethzzMcv6D9+j9rZGN3hNBqhQH9yHQ==
X-Received: by 2002:ac2:4478:0:b0:513:26bf:4ffe with SMTP id y24-20020ac24478000000b0051326bf4ffemr29133lfl.25.1709814306012;
        Thu, 07 Mar 2024 04:25:06 -0800 (PST)
Received: from pc636 (host-90-235-19-15.mobileonline.telia.com. [90.235.19.15])
        by smtp.gmail.com with ESMTPSA id o18-20020a05651205d200b005132f12ee7asm2697528lfo.174.2024.03.07.04.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 04:25:05 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 7 Mar 2024 13:25:03 +0100
To: Joel Fernandes <joel@joelfernandes.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 1/2] rcu: Do not release a wait-head from a GP kthread
Message-ID: <ZemyHxqjbiUrb9kf@pc636>
References: <20240305195720.42687-1-urezki@gmail.com>
 <a1faf101-c689-4530-a9a5-c7f95b8825d6@joelfernandes.org>
 <CAEXW_YTzMPxdm=UmMScppfP2WTqoyo6Z4c0p06HNgT-NAL2ciQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YTzMPxdm=UmMScppfP2WTqoyo6Z4c0p06HNgT-NAL2ciQ@mail.gmail.com>

On Wed, Mar 06, 2024 at 05:44:04PM -0500, Joel Fernandes wrote:
> On Wed, Mar 6, 2024 at 5:31 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> >
> >
> > On 3/5/2024 2:57 PM, Uladzislau Rezki (Sony) wrote:
> > > Fix a below race by not releasing a wait-head from the
> > > GP-kthread as it can lead for reusing it whereas a worker
> > > can still access it thus execute newly added callbacks too
> > > early.
> > >
> [...]
> > There might a way to prevent queuing new work as fast-path optimization, incase
> > the CBs per GP will always be < SR_MAX_USERS_WAKE_FROM_GP but I could not find a
> > workqueue API that helps there, and work_busy() has comments saying not to use that.
> 
> One way to do this would be to maintain a count of how many CBs are in
> flight via the worker route, and then fast-path-free the thing if the
> count is 0. Should I send a patch around something like that? It saves
> 1 more wakeup per synchronize_rcu() I think.
> 
We can release the last wait-head if we know that the worker is not
pending/running. Then we guarantee that Frederic's case is not possible.
From the other hand it will introduce again more mess because the idea
was, in the begging, to start with something really simple :)

--
Uladzislau Rezki

