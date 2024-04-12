Return-Path: <linux-kernel+bounces-142134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E928A27F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E581F22E86
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41E94D9F4;
	Fri, 12 Apr 2024 07:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARnuef2h"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14774AEEA;
	Fri, 12 Apr 2024 07:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712906739; cv=none; b=s0eb7CrmQljgpDtuRsZ6xsHsgXPSabxzCoMSNH1YJTa/TefPv7Zy73h/lEx9ChiONldymGSOcmTJbIeQzfC4HTcgT8a9FqNMlg++VEI+8OUEoYumhO0FsYPcGf9PjksQ2ZSpE8nQTCO7Dxlz4ZeKmFCKcl2HFPQfr2U6y/pLeK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712906739; c=relaxed/simple;
	bh=oDubb1ppiogfhyq6ErUyOdX2aBJDyuVyNUioKmDIWoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oa8Roun0UQbZm4lmtGguFTh9BIX0wRTle26pXFNhezGr7OJFrVSfdll9y0pCGOcuHu3uVe6VOen/P02Q38DXj0ketUAIv4I48MWqcPHiEey+vNtYeU/YYJ3m1dusB5mE2k/TT8/HZsxBQnjhkiqWf95Jj3F3SnCqy8vy1egXJ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARnuef2h; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7e66423aa72so252965241.3;
        Fri, 12 Apr 2024 00:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712906736; x=1713511536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fd3UUCc36L2NreCUvqYuyax02ribbEDEvMvCqOTX1e0=;
        b=ARnuef2hjd7gS0EAPKcVS48othZIK/cvI6BSs+dmNnD08R2kti58xiHPs9s0f/rKP7
         R6u/ZS0APLj1iv4c8WwAoQI7qTh3KPyszjasnPTl2YffDo93kefSqZr+ORtP8L3riAQ2
         5rKbZWpVLXMKb+xlNrx31d8eeFYsnw4s5CMGJKos4MucpCMWUSBmoulR3/z+mJi6sUeo
         82WqcfqPPvXBPZHcLJ/gK8xorbno0v6V8b6UQCAceUXHk4jr0BzJSNSfkbgN/y9/WANj
         /PBnxmLUc++XFDK4tzsvH+0HI01Ke3ay2wIenJNW4/sfxF11WS+QpaKSfxf6oT1gTULE
         Kidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712906736; x=1713511536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fd3UUCc36L2NreCUvqYuyax02ribbEDEvMvCqOTX1e0=;
        b=O7P9axCrkrkKAiQSr7PmHzXiRSfCLAXNnsmPUl4yj9EuMidxvWducV6ygxk/YrlF9v
         wSkCo9NS5uor5Y86+HK/ma8vmIIbHMGOK9mUufYpxs5umJ9uN0psVBORh9cvTgJScm+w
         RvfmyJxCvm8eIHWnTqdZp0Q37Sx5qIunZyy7KMY6n/ECnAhzfAx0ubHK6veeqWE/yj5S
         oiI+WR8NwnnkDcnjkE++SlCcfBI5gEvalmya45AgStAfrCWCW3sFpkB+Ye4dbWJTJu+Y
         A/9/FDswN1BVw+qaecPnilueHuwMYi8gE56tpsqVGPZ+hLAuDjbyQQKFkBoKH7PKlqPC
         IkRg==
X-Forwarded-Encrypted: i=1; AJvYcCUGlzB9PruSBOL6ZyEkv0kDOyKbsKcT56uK0PJeTDtAREscgABZAYdzmujRW2A5QLlZPlsc3n+UJjKplf0JYiIPsQo6LmfgPu9XDv+d2TenP9vTjPKhd3PNQF6E8EN+FeF+MYMAGO8IR2Y=
X-Gm-Message-State: AOJu0Yyl2RNBpBo0CAlEf8zS9wmglSEOlAU4/3m+pn8sBH/zCIEspUgh
	t8lYVXI7HN5SSg7Mwc/CfqxK9SmrBpL7bqFLjy/QqRSRb52iJBw/IBrvKVbMtkhhYuTUTP1QMVC
	AomkEraw6FDJX7HzeNPBy8T5QcMY=
X-Google-Smtp-Source: AGHT+IGSIcPQAaJxcGZtYPejMNL4S+H8D7E8W+nAVXyw6lcfHBPhAd+BBZjhibUZOgAc4AlivE+IOCr7fPDjmAK1O+M=
X-Received: by 2002:a05:6102:c93:b0:47a:41e5:2e29 with SMTP id
 f19-20020a0561020c9300b0047a41e52e29mr2105403vst.13.1712906736427; Fri, 12
 Apr 2024 00:25:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410101858.1149134-1-dongliang.cui@unisoc.com>
 <5a67c4f7-4794-45b4-838c-7b739372d3a5@kernel.dk> <5a83c1f7-3ab8-486a-b633-33b44858d290@kernel.org>
In-Reply-To: <5a83c1f7-3ab8-486a-b633-33b44858d290@kernel.org>
From: dongliang cui <cuidongliang390@gmail.com>
Date: Fri, 12 Apr 2024 15:25:25 +0800
Message-ID: <CAPqOJe1FsfA-sx4JXB-UyhUZ4ui3eagFJJ6Z6TfBUpp76ZSw9A@mail.gmail.com>
Subject: Re: [PATCH] block: add max_dispatch to sysfs
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Dongliang Cui <dongliang.cui@unisoc.com>, ke.wang@unisoc.com, 
	hongyu.jin.cn@gmail.com, niuzhiguo84@gmail.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 1:19=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> On 4/10/24 22:17, Jens Axboe wrote:
> > On 4/10/24 4:18 AM, Dongliang Cui wrote:
> >> The default configuration in the current code is that when the device
> >> is not busy, a single dispatch will attempt to pull 'nr_requests'
> >> requests out of the schedule queue.
> >>
> >> I tried to track the dispatch process:
> >>
> >> COMM            TYPE    SEC_START       IOPRIO       INDEX
> >> fio-17304       R    196798040       0x2005       0
> >> fio-17306       R    197060504       0x2005       1
> >> fio-17307       R    197346904       0x2005       2
> >> fio-17308       R    197609400       0x2005       3
> >> fio-17309       R    197873048       0x2005       4
> >> fio-17310       R    198134936       0x2005       5
> >> ...
> >> fio-17237       R    197122936         0x0       57
> >> fio-17238       R    197384984         0x0       58
> >> <...>-17239     R    197647128         0x0       59
> >> fio-17240       R    197909208         0x0       60
> >> fio-17241       R    198171320         0x0       61
> >> fio-17242       R    198433432         0x0       62
> >> fio-17300       R    195744088       0x2005       0
> >> fio-17301       R    196008504       0x2005       0
> >>
> >> The above data is calculated based on the block event trace, with each
> >> column containing: process name, request type, sector start address,
> >> IO priority.
> >>
> >> The INDEX represents the order in which the requests are extracted fro=
m
> >> the scheduler queue during a single dispatch process.
> >>
> >> Some low-speed devices cannot process these requests at once, and they=
 will
> >> be requeued to hctx->dispatch and wait for the next issuance.
> >>
> >> There will be a problem here, when the IO priority is enabled, if you =
try
> >> to dispatch "nr_request" requests at once, the IO priority will be ign=
ored
> >> from the scheduler queue and all requests will be extracted.
> >>
> >> In this scenario, if a high priority request is inserted into the sche=
duler
> >> queue, it needs to wait for the low priority request in the hctx->disp=
atch
> >> to be processed first.
> >>
> >> --------------------dispatch 1st----------------------
> >> fio-17241       R       198171320         0x0       61
> >> fio-17242       R       198433432         0x0       62
> >> --------------------dispatch 2nd----------------------
> >> fio-17300       R       195744088       0x2005       0
> >>
> >> In certain scenarios, we hope that requests can be processed in order =
of io
> >> priority as much as possible.
> >>
> >> Maybe max_dispatch should not be a fixed value, but can be adjusted
> >> according to device conditions.
> >>
> >> So we give a interface to control the maximum value of single dispatch
> >> so that users can configure it according to devices characteristics.
> >
> > I agree that pulling 'nr_requests' out of the scheduler will kind of
> > defeat the purpose of the scheduler to some extent. But rather than add
> > another knob that nobody knows about or ever will touch (and extra queu=
e
> > variables that just take up space), why not just default to something a
> > bit saner? Eg we could default to 1/8 or 1/4 of the scheduler depth
> > instead.
Current mechanism will try to pulling everything out of the scheduler,
regardless
of the priority of request. Perhaps reducing the queue depth does not solve=
 the
priority disorder scenario. Reducing depth may also weakens the role
of priorify.

>
> Why not default to pulling what can actually be executed, that is, up to =
the
> number of free hw tags / budget ? Anything more than that will be requeue=
d anyway.
The process of pulling the request out of schedule will try to obtain
the hw tags.
If hw tags are obtained, request will continue to be pulled out of schedule=
r.
However, for slow devices, the number of hw tags is generally greater than =
the
number of requests that the device can currently handle, and
unprocessed requests
may not be arranged in dispatch_list in order of priority.
And for budget, I found that the budget is set by the driver. Some
slow devices,
such as emmc, do not register this interface, unable to set budget.

> --
> Damien Le Moal
> Western Digital Research
>

