Return-Path: <linux-kernel+bounces-85496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E381D86B6A1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DBF928B4BE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D541079B77;
	Wed, 28 Feb 2024 18:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMepQWly"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF3579B6A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143289; cv=none; b=HC1caYNUtyTWdgNsxZ0AXc9roq1ewlgy8amc9uH1pG2GWNU1dTyzxR/CugI/Oeia9rT+/jFMBF0MPAdGe7Gh2odW9xNJ2U5g7BvzxQeHA438r1wdTEM9wcI/XQjY9aPFcXP6AxXg/dxM+MhSMgEgmy3Rkw7rQrGMaXLAoiZl+Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143289; c=relaxed/simple;
	bh=e1PTXT1GU4o0xCBoFwb6a4yvV0RtfTescXppJND5wCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiRrn05F2q8MMBzdEReYmCUQ7v/tHS6rVmGsrZoSu9KIDO1+Hc79nqwKZAQWxhMnSOCM+SMeCNiULfQroKOBc/w0DeN3zJmdKuTxoAPpbf5fhr037SjV/rMC20C6zVv2sqFNxCkTjbHXLuVtd+HHZYbqGKCnM7UHS1XBDHoeZIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMepQWly; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e4899fa7f1so2635762a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 10:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709143287; x=1709748087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ytbhJgNkFd8QjDvd8YTnWIgeqegc6tPmFxKoXN1FKRY=;
        b=dMepQWlyEJ+r0hJCMC8ldpQF5MmlbLOZJ5ndvnPm2FYFlN6tkSvE/UFjexAy+optC9
         Xar1EYm1vEKvBWJYuWNrubhj1gwd4v8d+TKA+T+FmOcwv2dTc7sQlRNBg9bvmDzEryXj
         KApioB4wrXFBDlEzjSEHBCWWI+w+9aoQ74nZfTspJl9tgUyzsLkb4WGbxiz9YMO3N85f
         Bw6s5FBQ24fiW4/N7i0V57FLjreDuXQrCTyrRT2ehGfT4PTgNfYi7RzDJ42wMKwHOzHq
         J5CLN448BSAZaBlon4WfHLv+eraIlIWhvuT8KZWfv4yFSHpeCcOulIOgBpjDCo7+9peb
         ZKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143287; x=1709748087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytbhJgNkFd8QjDvd8YTnWIgeqegc6tPmFxKoXN1FKRY=;
        b=OSXw6W9je5iVjAnG3q/ltKf5Pc5BT5xflZTKPeR4Uvkdb/BhNA3ZwrzKYnrXJqG9H0
         3s8bDLQK4UVqWu+LIhzJw9m+BbLkP6huJHq27DzHhmm2oZweNDYIzBs8ne7ZXPvAL2HR
         IOuL0Ha/KN2QPwMflY6GVSL+tjN+EssIMBbuQ6r51+IjC28A665jiigCUZYlhz6UI4dF
         L4YGKhmKn1Kc+VgdUV2uzSLJmF+563KSRtVeE3SkvtD/hwbASKKzSe8FXZ9OWdoh9c+H
         rDabvxzN2tPyPDBS0R9lLuqnu9yxMcosaeb6Nm8kB9opApO1rpjz+twn1lTKkl9cUK+z
         xkCw==
X-Forwarded-Encrypted: i=1; AJvYcCUcpPf78Ev2T2oiQ546vGDktYfHna7H1vcrxRGtcuz+zHMeyQ3jrJeG3a01TgBM8oBc0fre79ZjvunI60jZvJ9Z6bsPK2pseHM7aWMg
X-Gm-Message-State: AOJu0YyR9NSQocdzuBPhH/9YJQoP8ACI6GI09fm2kgToY/n5u6g0gIgm
	whf187ezyYGD/bjZo0sZV6xKx+RME/vQQhiCLlsHhLAWd2Ec+MK8
X-Google-Smtp-Source: AGHT+IGxYdaJSzBfcLKBpii1Q2kIuNBHKEn6tkrKXKQ0Ek2AqKUMZ9QcLvuIYd0NsTakjZOD9vn8Zw==
X-Received: by 2002:a05:6830:18c9:b0:6e4:9602:a2d7 with SMTP id v9-20020a05683018c900b006e49602a2d7mr365990ote.5.1709143286781;
        Wed, 28 Feb 2024 10:01:26 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:8305])
        by smtp.gmail.com with ESMTPSA id s24-20020a056a00179800b006e56a4a2518sm1438597pfg.203.2024.02.28.10.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 10:01:26 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 28 Feb 2024 08:01:24 -1000
From: Tejun Heo <tj@kernel.org>
To: Allen <allen.lkml@gmail.com>
Cc: jiangshanlai@gmail.com, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	boqun.feng@gmail.com, tglx@linutronix.de, peterz@infradead.org,
	romain.perier@gmail.com, mingo@kernel.org
Subject: Re: [PATCH 6/6] r8152: Convert from tasklet to BH workqueue
Message-ID: <Zd909GwcelimJFFc@slm.duckdns.org>
References: <20240227172852.2386358-1-tj@kernel.org>
 <20240227172852.2386358-7-tj@kernel.org>
 <CAOMdWSLVDaN_XFD6Ov-=6VrH4wyBz-0wq_L3EzgdsJ5zJi47qQ@mail.gmail.com>
 <Zd9yNByiBMcPxWbU@slm.duckdns.org>
 <CAOMdWSJX43mqaSWaoVkNep9zJjr+v6OXup9YK9EuA_CWH+wThA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMdWSJX43mqaSWaoVkNep9zJjr+v6OXup9YK9EuA_CWH+wThA@mail.gmail.com>

On Wed, Feb 28, 2024 at 10:00:08AM -0800, Allen wrote:
> > > static inline bool enable_and_queue_work(struct workqueue_struct *wq,
> > > struct work_struct *work)
> > > {
> > >        if (enable_work(work))
> > >        {
> > >              queue_work(wq, work);
> > >              return true;
> > >        }
> > >        return false;
> > > }
> >
> > That said, this may still be nice to have.
> 
>  If the above is okay, I could send out a patch. Please let me know.

Yes, please.

Thanks.

-- 
tejun

