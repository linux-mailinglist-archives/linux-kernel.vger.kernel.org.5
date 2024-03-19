Return-Path: <linux-kernel+bounces-107439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C890C87FC8E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8CF1F22EB3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7887E57A;
	Tue, 19 Mar 2024 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dag1HcYv"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E1B64CE8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 11:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710846572; cv=none; b=NHT9+hJsVHC+P9KxYTgYS4Nfsln+89BO/FnS5jZfKSPhc4CGmbJE9fQKev1q+OkHo11GsVIfgV0hssrSe/ZAc10fPMh69dVr+sayaEWL/Eulquq5vouZLXVb8mVv1Qei3/tiBF5emp508FuEGZRwLLTtRWNRJomY4n1yNY/3xUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710846572; c=relaxed/simple;
	bh=sBX9q9flXe4rDLLTikiy0lqMwDNq3tx8cV3867WS+2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bD1iLRDEedmq9zMvilggI1hj5KImh5IHUrwJ/x6R1UYkVKdo+jI0EF3bWS2luqTqlo9cwgjNxjrpw0GT3OHs2hLjuiHYndZY+Y9cJiW93YIZmkdtmpOvnC45vS3cy0y2s9SloT/qj0ViQ47gVk0MW3dncmXTt4uoRpwLuQ7s4Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dag1HcYv; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7de446125f7so871987241.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 04:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710846569; x=1711451369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFFMom5/ZZ+nxNfevDyTk4uvoxRGCKNnKvOL6LWtnZw=;
        b=dag1HcYvAseMPBFS15BOv0BkYUc2Es23OWwFIj0i15r1DaD9+2PfiAEI9p5REKz6Kg
         z07diI8q78/9Lka0ZYSYrburi4AQcNu9mG2NFEmd6juwdKsRRNQulVHPVV4fahVw1Y9A
         OpgyNtkbrqPqnpaOKa90D6kCRtw/jfYu5chzzszJGyf7a/G+9AEzVQ7fRTiPq0sd7Ge+
         Q6td3WhBp68muqgvjlZ9uj3vY8QUAj0v1Xib0t1Rc1UfvWTkZI1qvst5ecpvvBoYnJ3Q
         CWspdLBAHJ0plGtzOPf2ySbZPFFqftc2Zub6ZyYcjtz9RTPJ87hKFhH/1PRlHkrWNPrI
         f1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710846569; x=1711451369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFFMom5/ZZ+nxNfevDyTk4uvoxRGCKNnKvOL6LWtnZw=;
        b=IoeW2rSMuTDqIAmQg6vh9tonovxX2CXSGDwWcWhK9IgypbNCxa0nul0vd/Bv256mvr
         6D1LbpvfktYWJ40CaNNq4EPuydi0fUe/+33M6DVw2GJ2IznZmH86QEusSM3N60YIocz7
         AwE6Uc45EIGXfHSxE+HXIfeGINIjakPVDHVIwXsnOgADSOEvfqW5pVit6PSDcdkSZaKB
         r9WFdz0n5AzF24xAyJKYJz66cmka19uERzr5dAkXxHbgxWJ3KVGaGTHclle6FIy1MOGE
         SLhEWp5yuQppoORl5FgrhpnAlBYB4b8ABfG+FEz53i3uGfNXKpDKhutYPEHMtB78qywl
         WGYg==
X-Forwarded-Encrypted: i=1; AJvYcCV5VZoyhP9OvCN3vr+25b6hJMYMVd9NjIQkEyyx/R1kR++1x5JNz5amzFc5SuH9YvjKASp3QGXyfFRkOL2WbjnOn1zTXdZxCT0IMs3x
X-Gm-Message-State: AOJu0YxPnjf+q4fOzin/milOGosdu2LdVu5W/ZwlUlN/fc1UxxwxWoTk
	2nMprFfRYLeJQQn1pPPi0DfVaJwG9/r+vlpHiBylkuY21UyPvZHtzr6hZYoAymdCp57C+BccPqr
	vbtdTxQw89434411HCXNCqa4uAJA=
X-Google-Smtp-Source: AGHT+IHM4xyglbb5pffkcPfzACI/wBLHk//vDjZGT4FoVpHhmkFKx2NL+9FyUklB5eUGBbhXcbX0g7MwXMxUrkqaoD8=
X-Received: by 2002:a05:6102:3a0b:b0:474:cb65:d400 with SMTP id
 b11-20020a0561023a0b00b00474cb65d400mr1843847vsu.24.1710846569394; Tue, 19
 Mar 2024 04:09:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314141516.31747-1-liuhailong@oppo.com> <20240315081803.2223-1-liuhailong@oppo.com>
 <ZflTCY-Oaxm0U70u@tiehlicka>
In-Reply-To: <ZflTCY-Oaxm0U70u@tiehlicka>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 19 Mar 2024 19:09:18 +0800
Message-ID: <CAGsJ_4w0EHuAwvSFuqUsMO-bLjJwCmN_qjL6NuA043-4rgfgsQ@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "mm: skip CMA pages when they are not available"
To: Michal Hocko <mhocko@suse.com>, liuhailong@oppo.com
Cc: akpm@linux-foundation.org, nathan@kernel.org, ndesaulniers@google.com, 
	trix@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, surenb@google.com, zhaoyang.huang@unisoc.com, 
	quic_charante@quicinc.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 4:56=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Fri 15-03-24 16:18:03, liuhailong@oppo.com wrote:
> > From: "Hailong.Liu" <liuhailong@oppo.com>
> >
> > This reverts
> > commit b7108d66318a ("Multi-gen LRU: skip CMA pages when they are not e=
ligible")
> > commit 5da226dbfce3 ("mm: skip CMA pages when they are not available")
> >
> > skip_cma may cause system not responding. if cma pages is large in lru_=
list
> > and system is in lowmemory, many tasks would direct reclaim and waste
> > cpu time to isolate_lru_pages and return.
> >
> > Test this patch on android-5.15 8G device
> > reproducer:
> > - cma_declare_contiguous 3G pages
> > - set /proc/sys/vm/swappiness 0 to enable direct_reclaim reclaim file
> >   only.
> > - run a memleak process in userspace
>
> Does this represent a sane configuration? CMA memory is unusable for
> kernel allocations and memleak process is also hard to reclaim due to
> swap suppression. Isn't such a system doomed to struggle to reclaim any
> memory? Btw. how does the same setup behave with the regular LRU
> implementation? My guess would be that it would struggle as well.

I assume the regular LRU implementation you are talking about is the LRU
without skip_cma()?

I remember Hailong mentioned something like " it also trigger memory psi
event to allow admin do something to release memory" and " without
patch the devices would kill camera process".  So it seems the difference
is if a killing will occur.

Hailong, would you like to provide more detail?

> --
> Michal Hocko
> SUSE Labs
>

