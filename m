Return-Path: <linux-kernel+bounces-97209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5970D8766FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2E21F236B1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594641DFF2;
	Fri,  8 Mar 2024 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdLo5CVM"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FB41D54D;
	Fri,  8 Mar 2024 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709910322; cv=none; b=j6nmN9Py+70iX2lB/u1l0BPnw2ZrV/RuwUyix5DOgA5AL054FOrDlaI0vKVkXsa2T+mCk76Ht1fqX+PFhE71klq3KOck63wwJRFIpyO5fbul26oGjqd2mdg3Riy9JK/jP6ZW6DzNp1lhwpZBzPjqFD9bx6czM2zJtKhFJ8iZ0Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709910322; c=relaxed/simple;
	bh=22+TL+g0R+mDpEkSxUftfZ3Jch3HXDCSUfWz772B9+Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u393/Y8obLnLLIlw9BCgNUU4j2yq/FFImXyG+ax9F/K+NJFeHqJrLEPK6Ccj7qIe7NQVGGKogQX2RCJiLVHdkIg1t91ESXkvbJsPkInEOoTgy5cUsh4BF717Sqnrai3q5WVEBzlFms995GeUrwDyZOgZbzWROwEKVw29jiYxpww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdLo5CVM; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d269dc3575so19823781fa.1;
        Fri, 08 Mar 2024 07:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709910319; x=1710515119; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QZ7RvVvOlckHBQMf9F2I+Mtrwc2yTclL5994XgQW8m4=;
        b=NdLo5CVM8S7tdi7GyXrwRdegmHwKQ2UUKxBIbFythdiaFIM7LupWG0ZR+uXgQvDHhW
         gFKVk4CnNCUDdMK5cmV0H768J6//m3RcUJ0jpkeTb9aPdImTIIOJE8NKWI+8lKn/nnr+
         7AMopPpXYIcuQcx8ozG9jcyl3P0csrTn/MRi5hQgtumbWI7JJJ5f3Ol+q8xpY1B8gDcC
         Z5Ol/edIKW2ESkBwHzw8hWfEWVNf5o84lfpTmNzFQzw/PEELc/+QDeW1Rpg76mzb503E
         poV7Ct/uD48+YVTFY3sGkWUCVckQLGkjKXhr1B/WbQ928m9HiEr7Xc5lSpjEDVRhlGNo
         9LPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709910319; x=1710515119;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZ7RvVvOlckHBQMf9F2I+Mtrwc2yTclL5994XgQW8m4=;
        b=RiSh1/qIEA6SDN9o9/yHbO4Hd2db6SeMUvAzYkRZf8JnnigcirDXippie5ZFYRVibb
         3+/XY/MQ+6OA3DiahBg4qXosKpX3PFYtvtbuKnmZEjkfuBjH5taQfxnMh2u2w8EPCzux
         gMchIaKwTNRGq4ZoqisGU1BJVH10ixIe5rbh59Rz6jwZ6myIZUwrc/vh11Hj/0ZY31j1
         Cb1QpYRyyi1KYq1DGIDeHF1AR/UR3H2snQNnk0TTEfCE3BXHSdYQUEhK+S0TmOMkA1hp
         FexZRafyRvyv+hOxXMLuLuZe/sWVH1V7i4M8xwyHP6I7O0HyT/WqjG1bmfYzL4BXHDST
         o/iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoQyg1z3aPvnczsqBHONvbagau68yrZaJS7xM55JAYC5ZQ+CVvVp2WfrsmibnRWUIDs8kOjBAWC77VjK6TZIeWADKMbi8KUHscMhRoSjvNpwvfwwyVREvfNlzJ/OX86Nm2
X-Gm-Message-State: AOJu0Yz2Uqt8nsicRotBR/tXSyMaOOPcBf0Y75eKtvSDhRmNAxvwIDT1
	oUiywvrHuA3mG36hF5eSrZERbp9HoYuffTPN40emsqAcXnJtUPvn
X-Google-Smtp-Source: AGHT+IHMGi72wvWIbU4KpdLraJkU3A2q5TOsLVdb7+bEZJEFPiDZS5P2L0xlcOweUxpOy4KMRoDI2w==
X-Received: by 2002:a2e:9b45:0:b0:2d2:b5cb:cc3f with SMTP id o5-20020a2e9b45000000b002d2b5cbcc3fmr216381ljj.2.1709910318810;
        Fri, 08 Mar 2024 07:05:18 -0800 (PST)
Received: from pc636 (host-90-235-19-15.mobileonline.telia.com. [90.235.19.15])
        by smtp.gmail.com with ESMTPSA id i18-20020a2e8652000000b002d21d8fa04bsm3478248ljj.122.2024.03.08.07.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 07:05:18 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 8 Mar 2024 16:05:15 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, linux-kernel@vger.kernel.org,
	frederic@kernel.org, boqun.feng@gmail.com, urezki@gmail.com,
	neeraj.iitr10@gmail.com, rcu@vger.kernel.org, rostedt@goodmis.org,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH] [RFC] rcu/tree: Reduce wake up for synchronize_rcu()
 common case
Message-ID: <ZespK0CrkVFCu6_p@pc636>
References: <20240307234852.2132637-1-joel@joelfernandes.org>
 <CAEXW_YQ-TZB-1gpxvf7v+QAZhHtzV5waBA1VemtgEwNktSp=ww@mail.gmail.com>
 <ccbdf4d4-6972-430c-a479-0d20b318213b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccbdf4d4-6972-430c-a479-0d20b318213b@paulmck-laptop>

On Thu, Mar 07, 2024 at 04:06:06PM -0800, Paul E. McKenney wrote:
> On Thu, Mar 07, 2024 at 06:52:14PM -0500, Joel Fernandes wrote:
> > On Thu, Mar 7, 2024 at 6:48 PM Joel Fernandes (Google)
> > <joel@joelfernandes.org> wrote:
> > >
> > > In the synchronize_rcu() common case, we will have less than
> > > SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kworker
> > > is pointless just to free the last injected wait head since at that point,
> > > all the users have already been awakened.
> > >
> > > Introduce a new counter to track this and prevent the wakeup in the
> > > common case.
> > >
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > 
> > Forgot to mention, this is based on the latest RCU -dev branch and
> > passes light rcutorture testing on all configs. Heavier rcutorture
> > testing (60 minutes) was performed on TREE03.
> 
> Very good, thank you!
> 
> Uladzislau, could you please pull this into the next series you send?
> I can then replace your commits in -rcu with the updated series.
> 
Absolutely. I will go through it and send out the next version!

--
Uladzislau Rezki

