Return-Path: <linux-kernel+bounces-1612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 164B08150DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491811C215C1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC05E46529;
	Fri, 15 Dec 2023 20:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/gXs8jp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD194187A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 20:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dbce7338330so847181276.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 12:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702670680; x=1703275480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sv9VCvETPu14jWu+8ORlTIdAv5FRHZ72udV2gFKIYFA=;
        b=l/gXs8jp8Y6FhFAYSWywg33xX2cBCpAJ+ItRrvMBW8h/58VF2df5mhgTUVTA9sUfYk
         cC166NHOTGLOClQYFtcS7JXr8KIL0i27zSmLsWTFTwt+UbA+pFVvfpzm3x0Q+Wi+Yjva
         tpIqEQmIRlp7xaBTga0xQ62ml1J4yLZ25H/lRGxu+GpbcJp8XwUQaQMlDpJOpYTzKL+O
         JuRTp0nadWWS7uF6Ntor3zk4q1uUl/CY8cfpafgwvO7eocg0x9OfNjJR91vsfsgc3t0r
         8cbGDKXIUkAyMSKzSrdXg+KFdls7OaCX1FbTsKZV+nDZna5z8Q5XUfw7Ic5OM9BBBv/n
         OSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702670680; x=1703275480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sv9VCvETPu14jWu+8ORlTIdAv5FRHZ72udV2gFKIYFA=;
        b=nyA3bLXcAfTTZorrfsumj9lI9rzDDHcWnE8H490/zPgXfZyPC10x53qSZKLUlxWoRr
         Loeqkg25ZlqdnB/AgmLGSvIrJEB+Cv/d8IFyQSDJtbV9XArTZ87v72je2VTLaAHuR2FQ
         TfutIAL0vhCVr7aFRk1ReD8vsi4SvcOL/uyDBuvSh8dhb91LJK8G75WkRON2ngc8sdNE
         XtyDhGe7PfwMSDRMGrmGEVaPri6QYDQND9uMDeQeIXYUaIcrBQT779S0TUi/ixJlMlkj
         DjkJ8HDUsQJO/Uhio6CH8l/N35B2aNRDSgE2rjdXhhFDoR27f8Upm2lV7bcouhEVrZ+T
         nztw==
X-Gm-Message-State: AOJu0Yyq/4BlNWLrxZQhh+nQVhNIjCS/mU/0xehQZickk3GaA2lxYiFz
	ZU+EbLX0o5PcH1H7RFUraPXZasNYUDs=
X-Google-Smtp-Source: AGHT+IFxPV1zwwLxVkNzPtMnnldEckgshoje/WQ3mC5V2MgJoUN9pTVfp9WYCvutHKz8LLv4eScsYg==
X-Received: by 2002:a25:ad62:0:b0:dbc:d43e:8e71 with SMTP id l34-20020a25ad62000000b00dbcd43e8e71mr3819136ybe.25.1702670680577;
        Fri, 15 Dec 2023 12:04:40 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:ffe6:85e9:752c:601b])
        by smtp.gmail.com with ESMTPSA id x9-20020a25a009000000b00d9a36ded1besm5738258ybh.6.2023.12.15.12.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 12:04:40 -0800 (PST)
Date: Fri, 15 Dec 2023 12:04:38 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 0/2] bitmap-str: A couple of fixes
Message-ID: <ZXyxVguXbaUWupko@yury-ThinkPad>
References: <20231215184218.2005611-1-andriy.shevchenko@linux.intel.com>
 <ZXyieGvEDXLqHxhn@yury-ThinkPad>
 <ZXyliw1ougOO2Vha@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXyliw1ougOO2Vha@smile.fi.intel.com>

On Fri, Dec 15, 2023 at 09:14:19PM +0200, Andy Shevchenko wrote:
> On Fri, Dec 15, 2023 at 11:01:12AM -0800, Yury Norov wrote:
> > On Fri, Dec 15, 2023 at 08:41:07PM +0200, Andy Shevchenko wrote:
> > > Imtended to be folded into original code, hence no proper commit messages.
> > 
> > s/Imtended/Intended
> > 
> > Didn't understand why you didn't write commit messages. It breaks the
> > very basic rule. Can you elaborate?
> 
> I expected you to rebase your original commit.
> Or based on my understanding of your comments I can submit a revert, if you wish.
 
It's merged in v6.7-rc1. Can you send #1 as a proper patch? Regarding #2,
it's not needed because bitmap-str.h is a local header for bitmap.h.

Thanks,
        Yury

