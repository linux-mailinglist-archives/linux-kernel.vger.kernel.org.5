Return-Path: <linux-kernel+bounces-97414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CA7876A2B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469681F22918
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3BA3BBD2;
	Fri,  8 Mar 2024 17:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWfnL+V4"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9806A36D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 17:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709920192; cv=none; b=tl5PV3ggF505aeGVqZrztSDnLaz9wQIIg3mCZpPufffze3sxD/yqjMp28UfgDy3b2xIHIK/fP5CNtGBn30GAF9B1tRG96jC+6OhnOhmcXLJaX6DSOtSgXDllEum3mqRayr6HfResozvpVi79siJWbIMDaypiIX4E8eLPfsvdeX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709920192; c=relaxed/simple;
	bh=NTw5m8QSmuC8XRFb3K66IhdRGyQIJPdjQ/WpbkkdhwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFHp+wHxTO+yOVgP9wrVQJgMiBKFejP/r7z196BXGtugJaiWSaeUn7o8Qi5Xu7ZmYbtzEPTLFMLBb9ALgYbVWR4WIsQAuF2M1XsKH/hOTqQy9vMWLWjJ31fhGD4OPUK6cLQNZzvUAhpuzmKZQTxRHL/rcHm01xLtmP09NWZZDxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWfnL+V4; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51340e89df1so2534942e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 09:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709920189; x=1710524989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RVmtGOEyddruZt6xQ1RfZdJH7pbb7KXfKgWyAx5uUDQ=;
        b=YWfnL+V4j45sLmy3QZzqTtBdtdBHlFqfA7UAVXd0hzegSdOy2AapG2EntMJoJqaDYE
         qMXacLJ1Lrc3xeLY2H5o2h8upfIYdFJ4pfivyLiDv4reQI2ISpSijaAUQ3LMCb8uADHA
         Z7SkFXc6TAtsJSMKR+LlZg9pndHvxngtjFr8k35dCR7f5uaWfAe0lR6kHWok2pn9R2I9
         uEqq9A8Uy7Vx5bhvqjOlcMT946BVBe1/2vPJ62QT9Dgji2Ov8G3fH0CY+x/ztcK5VEj0
         YX8+2OiGWpZgxCvCZYISGib0aHKJFg45+F8rK79dTgAA8zOxb0S6xw1IImfv2fnNeemE
         FrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709920189; x=1710524989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVmtGOEyddruZt6xQ1RfZdJH7pbb7KXfKgWyAx5uUDQ=;
        b=TRQRJ4Be0uzG9n1wPQNeUZqAqRDuWO6K5B0+MbjVOBWL7UPwGOGVLkAlzXzHr/19hp
         efJHAhSolcmrS8jAgEjfi/d0jKK5o3Vl4y/jhLmrKyq1OgYnL9hmqsPi8uDPSPvOhgni
         0pnuqJGL9hTatj+ei6m7Vmiaq8l9lnAWOVUfQk2baGq6faCxFn5a/4gWs0LA6pr1Ih53
         0/b+h6KHN4IKQNGX/ULB7goM2R/KeJHjb2jtUz7U6bOIZsiJgC+iDAbF3bni/JgxmW+7
         D8S3a+Y1yZvBazl+ulKsCHmYgV+l/oH2DoUJTL3cwgUGpq/ciRisvDcuCKhEMrYFw3iL
         uM8g==
X-Gm-Message-State: AOJu0Yx3aaMs4AWm1Qzd6ZDu0/g+zrcRcZIgxurFn4zuKMTDtbnB4kn3
	YFqQSYs6tvy24wQliupxeFTzmRT4K2q/RdR3CNna3qt5Cx99b+HD
X-Google-Smtp-Source: AGHT+IHljeVg803lDBelaITeYO1VPSVJ6Uvq+MWi9caz/+htaUyyZyk7fFzg7gPoIof60mTczN6whw==
X-Received: by 2002:a05:6512:20c1:b0:512:fe1f:da5b with SMTP id u1-20020a05651220c100b00512fe1fda5bmr3355366lfr.57.1709920188236;
        Fri, 08 Mar 2024 09:49:48 -0800 (PST)
Received: from gmail.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id i20-20020a05600c355400b004131035d28csm6034473wmq.23.2024.03.08.09.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 09:49:47 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 8 Mar 2024 18:49:45 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH 07/13] sched/balancing: Rename find_src_rq() =>
 sched_balance_find_src_rq()
Message-ID: <ZetPub9pYESpcvms@gmail.com>
References: <20240308111819.1101550-1-mingo@kernel.org>
 <20240308111819.1101550-8-mingo@kernel.org>
 <CAKfTPtAdoZJEWB=ty-uNiPESCgk3wD_GR6mW+ABMGcWthAwNGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAdoZJEWB=ty-uNiPESCgk3wD_GR6mW+ABMGcWthAwNGQ@mail.gmail.com>


* Vincent Guittot <vincent.guittot@linaro.org> wrote:

> On Fri, 8 Mar 2024 at 12:18, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Standardize scheduler load-balancing function names on the
> > sched_balance_() prefix.
> 
> This patch renames the renaming done by the previous one. They could
> be merged in one
> 
> sched/balancing: Rename find_busiest_queue() => find_src_rq()
> sched/balancing: Rename find_src_rq() => sched_balance_find_src_rq()

Yeah - I already did that in the 00/13 summary description,
have done it in the series as well.

Thanks,

	Ingo

