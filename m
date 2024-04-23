Return-Path: <linux-kernel+bounces-154971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D07258AE3C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22A4BB21C6E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD557E10B;
	Tue, 23 Apr 2024 11:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeMrtA/d"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230BEE576
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871384; cv=none; b=M7GwmdLBIijUjQT/Rc8L47OF79T/qRL7QvwbYvPyCBB3/hZvD0zM31OqxBUDPpZ3fMB8DqCVCSnq3qEquTxTycp/utez5dHE5lu0agxSXrbxX73B1+55CQEDaVRkOqJA/ZOMs4IFC/2dyrfNiAPYQBzFzV/VUjqAb187a/m3Xj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871384; c=relaxed/simple;
	bh=obOctvhGEIuk1UNtkz6Iwi+t7WMEzW7Fgp1pbQVcO28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSZbUX/NEQ+7KQuTMEKylruRhYF6/uZLD1sFHKhXAqjRtcG22UX0ASasZspDCrSOSCXOJDtQiYtgZOuPVkhPF+bxh6vYbL9zRD8zkIWLtn5fdBJLQj4n32X5/+lPEpICXTCh4qUtgPf57kn+kS4CFEclXFT6e3QtFEgDLuQDi3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeMrtA/d; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d87660d5c9so58451971fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713871381; x=1714476181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCS8fRpekX+YjGc4xeW0Y4W18c0mRC7QxqGPnQI7/MY=;
        b=NeMrtA/dFTWIp1gFOmL1Gqgza8j7UkWp5+30BeB5lRd44kUeLLB0dglp5TbNL/TS9R
         b+drmvMCYxV+8OuQE1DhwzbG4gZI6bNh6UyknZep9ll6GBXvqO0cBUU6RQuJRnE+JzJc
         bdROKzl1vatoi8UrUXO/PKsSq842kb44HJsrBBRtX2VwHYvb+JWZjOr47jQ2LFFRs9kV
         2QJalAZqdglMcPvTThKJPW46lBwyF+3FYTIPb8MhWcpNRaEs9agPyjDHmTLNo3+MN3g5
         bjSQlxUECjayqlzuVzTorxx9q7HIT33wbQvzxgR9fYVeIfVkmKDQX3xsHkngeAU9sZq0
         //Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713871381; x=1714476181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCS8fRpekX+YjGc4xeW0Y4W18c0mRC7QxqGPnQI7/MY=;
        b=hSIkDTssP5MFn24RA3VACV7bOOWWy0+XiWBI6FQTTnCo9bIBmtSV04FFe6Y2/Te1UJ
         2qI8aOfRXsAxJfp4NWeZTfPu7UuxhVLuRLP4HJaPBXOH/A+HbpH8gYDRw/wsIzUtb7it
         gCP2HwM51CoRSKmTCUwu6UbIFDqgYzOynauxdy9pvAwrk28K1lhM6g5sbgZc7UEIAjOu
         RGJPZipe+Df5GqA9aL6S4xKzyNyPJzw51pBg0FoGbx0Lu1rvkdMLEtOzmwjzWpQ7uavc
         iBl6Ok34E1oOI1Hg6/L3ujWN1ox1EGPIOQYiSYwZinbwGy3f9+hFIMmhQzAG6GYk2JF3
         5XzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNpaMHdqe/EKWaeSpkO8MW0B6ki5xtvjKdw3/3pETs4OpgJTYVbUEVuFLkl152GXDjLFJG0gpfnqpKQro8QstvTNQ/wNf4462qgyLE
X-Gm-Message-State: AOJu0YyhiB8Pu3JveZQmQEGIm0wJESTP1NaKH0cIsA0MQ1ejOVysH6WH
	KTu4h5fa8cH/dSBAZj9lMGnah0xJlo6uCkZ2r6CS51nAi2BJNXTt5jqdNuq8DR9R1BbgciGStHS
	YkoPlfhWk1pxq2DoyYRu5I8LRW1c=
X-Google-Smtp-Source: AGHT+IEptF7f9vlsWD2ILIzAzjyiVckh16z2OC4n86wIy6ypqE8GC37e2aq2P8kglf7szapoznI38oYU8YB4klIQlps=
X-Received: by 2002:a2e:9e45:0:b0:2da:b1fc:7b8f with SMTP id
 g5-20020a2e9e45000000b002dab1fc7b8fmr10732453ljk.9.1713871381053; Tue, 23 Apr
 2024 04:23:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGsJ_4xu4iL5pv7T1chyzGC2Vp9q1GwOp3wxb=bYMW-T-pj4dA@mail.gmail.com>
 <20240423094502.4080-1-ioworker0@gmail.com>
In-Reply-To: <20240423094502.4080-1-ioworker0@gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 23 Apr 2024 19:22:47 +0800
Message-ID: <CAK1f24nS9mJ4xU+Z7uzNZxAAgAoqx4-z_v888eRqs98cFb3cpg@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] mm: shmem: add anonymous share mTHP counters
To: baolin.wang@linux.alibaba.com
Cc: 21cnbao@gmail.com, akpm@linux-foundation.org, david@redhat.com, 
	hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	ryan.roberts@arm.com, shy828301@gmail.com, wangkefeng.wang@huawei.com, 
	willy@infradead.org, ying.huang@intel.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 5:46=E2=80=AFPM Lance Yang <ioworker0@gmail.com> wr=
ote:
>
> On 2024/4/23 09:17, Barry Song wrote:
> [...]
> >> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >> index 26b6fa98d8ac..67b9c1acad31 100644
> >> --- a/include/linux/huge_mm.h
> >> +++ b/include/linux/huge_mm.h
> >> @@ -270,6 +270,8 @@ enum mthp_stat_item {
> >>          MTHP_STAT_ANON_SWPOUT,
> >>          MTHP_STAT_ANON_SWPOUT_FALLBACK,
> >>          MTHP_STAT_ANON_SWPIN_REFAULT,
> >> +       MTHP_STAT_SHMEM_ANON_ALLOC,
> >> +       MTHP_STAT_SHMEM_ANON_ALLOC_FALLBACK,

Seems like you forgot to add the FILE_FALLBACK_CHARGE counter
in this patch :)

IIUC, you've excluded the THP_FILE_FALLBACK_CHARGE counter
for PTE-mapped mTHP that size < PMD in patch3.

Thanks,
Lance

