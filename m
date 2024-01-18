Return-Path: <linux-kernel+bounces-30365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A238831DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D080F289CBB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C5B2C68C;
	Thu, 18 Jan 2024 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="aIBCk5pW"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6172C194
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705596524; cv=none; b=KfAG02N7lATXYLvx7l7UgPZwLawySaABLCLiCFgS5nHro0MlG4wpD26T0/Vd+eV7GygfdoVV+Ev9mGxVgGrAeyrvc/abwAd5Qsq8+qh02i6nsl8U+EmGHVq3kUin9y4hOPHKB2MaqscGH177hSzvb2mDkcpa5TDe8TsyHaXtb3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705596524; c=relaxed/simple;
	bh=862VKph4bbmdzmlZvWrDeY/1vndYQiDXUJA4Eh8P7pY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=pawxJ5LvDwC7H5e8tyzF9bIjaH87sopyb8iA+h7M1dJxrDLCwGCN1F3QkgZiTqRjdcb4nM3uL1nSZ97f9Oo5MRB2F5IDYasjLRkxc0zwUWxudMqd5VQs69AcuB/UrC7IuB1KN/qXc2baJ0byHq4m27WwIwNd+irIfDS7DIEhHZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=aIBCk5pW; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6818aa08a33so6762726d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 08:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1705596521; x=1706201321; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XD9Z4iDc/R0mEeH0NbCgxONlq7q9LhFIWJoJohbUbXU=;
        b=aIBCk5pW2toLqNlugM+IfADPIyxOAtHATu8yJg0MeKERdMvkM2ed61qMDyHGnmksep
         kYvpk7u/eJF45+K9/X+nyevkPBa0/z+mqGrvTof0bbNTvdcJs4ohlvuypZeJSVwx95Nq
         2KRR+068DstO002o8n216S5pwbwgG1R0MZ+fpGIhWV+93Vgv/quyNTDnm+bIaxThyYei
         bUU3bFyrHbDB7B/oQ5/VAN7byjHk51SQjIGQfuhQm9SKDnO1JdDH++dKeGiugTqosucD
         0nN/ZA/H1MWXJ9nU0Du2voNDxk6zmn5WpiLEgEsTSXuOTh0WM9qKei71M3f+hOoUQqNT
         dt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705596521; x=1706201321;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XD9Z4iDc/R0mEeH0NbCgxONlq7q9LhFIWJoJohbUbXU=;
        b=vK9iMswTTlkkkxahIl878RJ5XV/5k0gvkjTf5VmcOGc8zhFA4s2UO+/ZAe2437tV7T
         FM/xH77AKfhTF/oxyHIvM4PQ9S7TRCBkg1PrfKVhW68QehRnwVoapKAmTcq3u+IoKSII
         4gvTqSDDnPgWbK5k4Oz2BGywrqxW6gIu37FeeOS5vrwqp8xOV2WbGX4rORSA8J8lOndi
         xvJ6McwHWG8dqfh36gXf0JemdXtmQK6ompQF7beM02GbkusX8Ilcp4zqGFjokurX9zGI
         oL8idceDJCpelJJDI26xhm0B3PvIS0a9m/tI9qr4xTnYI9hM08FliVxrJaIHpCqhL3wE
         Pnig==
X-Gm-Message-State: AOJu0YxaIeMLsrUj68OEou72k9dYVEwuH5WsNdI29uHC6FdOc9J+CE9b
	Te4ZV8NGd8yZ5h9gQ/C3KEKZJuokod+Yi31d6lf9FU/7R2ypIrbW9ZSuxeM+taM=
X-Google-Smtp-Source: AGHT+IFqQfxFfy+aahl8OgO7TmHJynpWPnHeQEB//FJPLZ9dNRqdYeQeJsbM1ucuuMBCED3mlJT/KA==
X-Received: by 2002:a05:6214:d0c:b0:681:8c12:bdf1 with SMTP id 12-20020a0562140d0c00b006818c12bdf1mr1885590qvh.21.1705596520839;
        Thu, 18 Jan 2024 08:48:40 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:83d0])
        by smtp.gmail.com with ESMTPSA id oj7-20020a056214440700b00681998c8330sm231043qvb.42.2024.01.18.08.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 08:48:40 -0800 (PST)
Date: Thu, 18 Jan 2024 11:48:39 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Ronald Monthero <debug.penguin32@gmail.com>, sjenning@redhat.com,
	ddstreet@ieee.org, vitaly.wool@konsulko.com,
	akpm@linux-foundation.org, chrisl@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/zswap: Improve with alloc_workqueue() call
Message-ID: <20240118164839.GK939255@cmpxchg.org>
References: <CAKEwX=NLe-N6dLvOVErPSL3Vfw6wqHgcUBQoNRLeWkN6chdvLQ@mail.gmail.com>
 <20240116133145.12454-1-debug.penguin32@gmail.com>
 <CAKEwX=PjraCg_NjP4Tnkbv8uqnVw8yJGh-mbuZC02Gp6HMcDBw@mail.gmail.com>
 <CAJD7tkb_uC_K7+C3GjVqg1rDRCmUkbHcEw950CkUHG66yokbcg@mail.gmail.com>
 <20240118161601.GJ939255@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240118161601.GJ939255@cmpxchg.org>

On Thu, Jan 18, 2024 at 11:16:08AM -0500, Johannes Weiner wrote:
> > > On Tue, Jan 16, 2024 at 5:32 AM Ronald Monthero
> > > > @@ -1620,7 +1620,8 @@ static int zswap_setup(void)
> > > >                 zswap_enabled = false;
> > > >         }
> > > >
> > > > -       shrink_wq = create_workqueue("zswap-shrink");
> > > > +       shrink_wq = alloc_workqueue("zswap-shrink",
> > > > +                       WQ_UNBOUND|WQ_MEM_RECLAIM, 1);

> What could make a difference though is the increased concurrency by
> switching max_active from 1 to 0. This could cause a higher rate of
> shrinker runs, which might increase lock contention and reclaim
> volume. That part would be good to double check with the shrinker
> benchmarks.

Nevermind, I clearly can't read.

Could still be worthwhile testing with the default 0, but it's not a
concern in the patch as-is.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>


