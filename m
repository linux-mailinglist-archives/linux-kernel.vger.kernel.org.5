Return-Path: <linux-kernel+bounces-41399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D0783F028
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0692858F5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 21:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EE61AAA5;
	Sat, 27 Jan 2024 21:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkmGmag3"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715CC33EA;
	Sat, 27 Jan 2024 21:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706390185; cv=none; b=EZgWJlY1n5FQ7qK9UWsP87gObdHeBQ5FWUIVXBiQrd9HiCQW41IZAeBpK4+LBcLgzq9tb+CUG7FAlbgRhSF8/5Zdt2HhvkLc1WTPhvIXKIRBCna5nL6I5zo41LAte8axIn3gUcO4oi0pptA0RcE9HNfM85nCaMvLY2Whoi5T+LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706390185; c=relaxed/simple;
	bh=QqcUiUPT4/u28ziKSScYFC/4i3pLqr1y+9bN4jv/94Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WG8euztYW0lBk5MCpAIPYfVwdD99J8HOIf1G21sY+a5/0ARYgwStssT7iD8Bl1vImecbLlWVX3OMu4EakLWpgnjmRHP6/R5Rt2a1uKzTJquGDJ7/ApBPg8hDJlsKwLUtTh3Sb7oNdRZqzrMOvTD/VzIZoZX+QLpEMwpOeBgzVec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkmGmag3; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33ae3154cf8so654474f8f.3;
        Sat, 27 Jan 2024 13:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706390181; x=1706994981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fbv20FbQFRHjUkR6ITqiykdWs3tGKoYK+0Frik3admU=;
        b=GkmGmag3Jh/5kxOCFi6Kp1EIkG+X/MIRmrJ0v7+TZFfOGDNCFEYmwJrAnrLAIuMkUP
         Sx7nzMi3XDV5vRZ6g3z6xARZWr5/R304NZFgxEsJpWDcQPelKpgZ4hNv5sK5XAwr1OED
         e4eAn0w529ifiYZFHxcCtYDr2wuzACdAcQkNz7LrUto1oeXZesO3f9RC3PTuOSUoiNpo
         LvubBbCqIJALYmlsyvo+tGY8z3bgihCs8hhrTLXAd1GqVK9105Fb0G+T9cXy5YpHJn4Y
         PAbXi9mC5FLpI00dLCIc5S7va2yg/XciNeJrzNi/fJn/nybB0LGNxodrpYfsZrLjkNuB
         /dyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706390181; x=1706994981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fbv20FbQFRHjUkR6ITqiykdWs3tGKoYK+0Frik3admU=;
        b=YblaIqY1nAK/Vt3z901xPIneJ5PhEf61QfCMYnO/3HqCPYlIqaofgqgifVb3KKSEXr
         SwpGYpMY7tHaxHHfuiRy0wM7kxpAn+6Z35sge6JdIUADJ222iPD4RV66XQEY3ncdnVD9
         uVqnu2nwKZthMfd/MCO7nzUhOA4bjzWfiUsBzGNmVi33nFRtBzh9IwWI60AZ2aly03J8
         MsUZrytA3j5yU9xcvUeIb1Ic4E8czX3noUkV9Nd3R+R358jZcJlhPZjiMmf3MqwGWTEX
         z2rYcW6g0gCoYRPZwiYhtaLNy2/tKBO1JYus+GviZISR5oPqEXyWn+qHlhQ1s3a3mtmZ
         qIKA==
X-Gm-Message-State: AOJu0Yw643ONaSnJ5uYX3cRyyGfctGDq9dZqGndacNmaYwrhtaFWJwqZ
	27Y1TVGmPSHu0Ie4E09YeTRhsNEXT+R/h1HOiKOWZzAmi6qNQuzU
X-Google-Smtp-Source: AGHT+IHa/qn4F5qMBn/NJ6uHeE8EiCBCp9i8ZUBkWP08+mCtzaiTuR/WoV/n+57p2FH5YWq5CKdfUw==
X-Received: by 2002:adf:ea0b:0:b0:33a:e6dc:2e98 with SMTP id q11-20020adfea0b000000b0033ae6dc2e98mr776932wrm.5.1706390181476;
        Sat, 27 Jan 2024 13:16:21 -0800 (PST)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id bi19-20020a05600c3d9300b0040ee51f1025sm4529497wmb.43.2024.01.27.13.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 13:16:20 -0800 (PST)
Date: Sat, 27 Jan 2024 22:16:18 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno Sa <nuno.sa@analog.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Li peiyu <579lpy@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: humidity: hdc3020: fix temperature offset
Message-ID: <20240127211618.GA4012761@debian>
References: <20240126135226.3977904-1-dima.fedrau@gmail.com>
 <20240127144055.2e46c77d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127144055.2e46c77d@jic23-huawei>

Am Sat, Jan 27, 2024 at 02:40:55PM +0000 schrieb Jonathan Cameron:
> On Fri, 26 Jan 2024 14:52:26 +0100
> Dimitri Fedrau <dima.fedrau@gmail.com> wrote:
> 
> > The temperature offset should be negative according to the datasheet.
> > Adding a minus to the existing offset results in correct temperature
> > calculations.
> > 
> > Fixes: <c9180b8e39be> ("iio: humidity: Add driver for ti HDC302x humidity sensors")
> 
> <> are not part of the fixes tag syntax.  I guess you saw the
> one case of that which was in my tree earlier in the week and
> I've now fixed up?
>
Yes, picked up the only commit with <>. It is fixed now.
> I've fixed it up here as well.
> 
Thanks.

> Applied to the fixes-togreg branch of iio.git.
> 
> Jonathan
>
Dimitri

