Return-Path: <linux-kernel+bounces-110798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 706C5886417
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FBDC1F21F70
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A488424B23;
	Thu, 21 Mar 2024 23:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjhjhBrt"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BAC1DDDB;
	Thu, 21 Mar 2024 23:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711064872; cv=none; b=beWWKdffOZNlisWUHxmykuWm1oh6aZ9i4ZtBnnNxpCwVwl5yDKGQhXdxn1Ong6Ay73cGjDJNsQJmceYcvb0+mu9RA1RUAt5Qs51muavs7sw+RSFcbNYJYAzQcWrXDlP2ljEyTvm+MLi7sdReYINXt6sVO77AQY4cewm+43zSVrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711064872; c=relaxed/simple;
	bh=faRVErYt8G5qNQLWd1m+LPMGBy4BwrP+Drj5J/gyN4w=;
	h=From:Date:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSEQ2hV4aP5bGhg5ssDupJFppV36YqMABB8TlrZ1aj5YMbDbB43y97zhrjNlrKe+wm72G48mJug3eskoznAXeeNpQHEjpEN4nSoUXuaLjL0Ax7RtZU0gzs7gUXEcPF8aWEJXkCXTgB4VoJ5CdVxGNaki2iHfXhpwC4gyFNsbcmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjhjhBrt; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-221816e3ab9so724613fac.2;
        Thu, 21 Mar 2024 16:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711064869; x=1711669669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ytKgvW58PsSJu3xpljogczDg2wQaBHBKuWrvcBzPeM=;
        b=HjhjhBrt7Ed7UtZBmQr3Ny/3mme6wTKFWNNltzfcK/puqQeXlvtXpJBqxNqy4tWgyx
         jeIclNnMEs3XHfw4UfCWUhr3f9AWbb4DT2DlAU9D9E3NccVc7tnFLWrAlTUFEF7Cm2MK
         gFqbcakzHV0cztoa94sONEQZ41zv/33knAgOqkLCG7rx9nig6Z+FKPp17cu8gJWGNkhh
         sqTdC50Jy5ngJcAWF8G2i17kOuRTizskeA/DXJ8StaQu7UM2Ta0Rc8aEltk13JgOtF2Z
         pbYMPdUUr8EjPOh456RBnOwKlsxxzAVya+UbIRTCbMvUfYVYry81523ez/VHJfzdFHii
         075w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711064869; x=1711669669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ytKgvW58PsSJu3xpljogczDg2wQaBHBKuWrvcBzPeM=;
        b=As5JNHKFGAHFBynByUDKAHCiRrqCMrCirxZjaHjoyYOwii37dAG+/mZhoj8keGyQB2
         PyBZNtKrN3hqrS8XemVr3wMXifgAf6QlmW6EwHWRPDyDmDG2bFmox5uvEtGIGKKYPiyh
         fno7yb1yS5xKv0AkGl3x9/Ppd62EhcyG/ULewKVtVwviu8LKAmPdYxcPkBpdvG2RK26s
         OsGj2LjMwgGK5xEM9riKxVK52YadnmQqGBf9R2VypA6aCiUi9GgN/GqbYaspEul4BXTw
         w2XqrEHsE2F5MGWv1AJ+0oy4gyFqk2y1Qc1sUvVOULZwl3J9z2FthX19XBUgPYT1RqW/
         dOcw==
X-Forwarded-Encrypted: i=1; AJvYcCXYGHdI4QrzVzwvG2hElzlTQt4QNIh9NtxB4rbedb+BTFbE4A04YPPRoY5aDGyea5TetQLRUgDo9Bs1CDZSFDVwQc1SSeiaQtggLksrN9k2+uy4sJVzuHMzNwXC6/HiopkyCfF9uup3TA==
X-Gm-Message-State: AOJu0Ywz1FVHG2Mif0PMcjajmN7vuUsW66JXzTDQSjl1Xc80U6aCpbbg
	g0drBt8Ds5H0It1dNQwZdUuQyXwb7Or+KNiLx63kZ3gxBIQEIL7Hzp4W8F58
X-Google-Smtp-Source: AGHT+IFgks42I/VWGJfBMCxEwZHDGNfOpG1w49iQQGKkprKCpyXNQzghz0QMgyV5Fy5/sbA741urZg==
X-Received: by 2002:a05:6a20:8f1a:b0:1a3:67cd:bed5 with SMTP id b26-20020a056a208f1a00b001a367cdbed5mr1307883pzk.36.1711064463180;
        Thu, 21 Mar 2024 16:41:03 -0700 (PDT)
Received: from localhost ([187.19.173.237])
        by smtp.gmail.com with ESMTPSA id a10-20020aa780ca000000b006e68b422850sm402876pfn.81.2024.03.21.16.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 16:41:02 -0700 (PDT)
From: arnaldo.melo@gmail.com
Date: Thu, 21 Mar 2024 20:40:59 -0300
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the perf tree
Message-ID: <ZfzFiyKWAZqTovT7@x1>
References: <20240322084131.2316eb8f@canb.auug.org.au>
 <ZfzAKMlYY7IkWXUg@x1>
 <20240322103636.020aa9d2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322103636.020aa9d2@canb.auug.org.au>

On Fri, Mar 22, 2024 at 10:36:36AM +1100, Stephen Rothwell wrote:
> Hi Arnaldo,
> 
> On Thu, 21 Mar 2024 20:18:00 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > Ok, maybe I opened perf-tools-next for the next merge window too early?
> 
> Yeah.

Ok, I'm rewinding perf-tools-next to the point where Linus merged
Namhyung's first, and only so far, pull request, sorry for the noise.
 
> > For this merge window I think Namhyung is switching to perf-tools,
> > right?
 
> Hopefully.  That branch is for bugs fixes, I think.

Right, that will start at rc1, ok.
 
> > From your reaction I think I made a mistake and should have opened
> > perf-tools-next for v6.10 stuff only when the v6.9-rc1 gets released...
> 
> The top of my daily linux-next release report says
> 
> "Please do not add any v6.10 material to your linux-next included branches
> until after v6.9-rc1 has been released."
> 
> (I did forget this message for few days this merge window, sorry).

Ok,

- Arnaldo

