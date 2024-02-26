Return-Path: <linux-kernel+bounces-82322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2779B868261
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85DC128B6FE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF014131732;
	Mon, 26 Feb 2024 21:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4ARi3Yv"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9530130E5E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 21:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708981685; cv=none; b=UN2OQdr6j5jcr3v7ielLCgIeTwRnPZ5ILu7W9awKCVbwI57KpAMzBLCf7fmi22xSvaqoxWb1ECiqnpNmEOFd1XHzBQF9rXeoOZUX+wCUTqIFy+cjQXBCXHKvGE0gFd6LGtuDAR9wdJqtV8qk4t+2ZN5Vsd/WknqlWwVN1av2LA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708981685; c=relaxed/simple;
	bh=oDrzWAHxcooJxvMZZFCD1XqJRMr3oJ+1oim2kOM6/7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdMWT9yxGPDyQWM4ZIWvKAZ8el8QrLQRkXM4XI52kPvTDpEwTXEGvIBENmir4sng9+tGpnrSbZLXoPTYhMpSet02zMie0aXWfgc1jndKAVw29ibuRGs6qwTCoPx3CBynUpEorgJBisYqGFH6vgUypI2/mjV/3ZEATpg0tKcGGT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4ARi3Yv; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42e8a130ebcso6493481cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708981683; x=1709586483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oDrzWAHxcooJxvMZZFCD1XqJRMr3oJ+1oim2kOM6/7U=;
        b=f4ARi3YvHI2P9kdFlZwKk/vQxV47VnLghKhDqf16RKuxKFh29K8I5/uvdswlN+ZncE
         3Izr8g7ZvyH94GHdevvyohA6/0JKAgeGjzBY5xjE9vBX7sNe7qjIoSAUJfi4fBJ9IuTN
         TLANeYhJHFnFV6ouP1OwMXdCeSyolns1fRZRjhIpaw8/uHOtRLbyDB9OKHn3Hf66ncCb
         nT1iJ8D4YOadzeGnkbb6114KYZF4p5xQ5FshOmICbGTRnD9gJm/2c0WQM9TSgOyEEmEw
         Zla6SCZ4aVepp1ZMd53cYQUR67eieUZNLQZsSDdBu1U5MiaVZRE4/yojzxeC5/tN8pv6
         lKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708981683; x=1709586483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oDrzWAHxcooJxvMZZFCD1XqJRMr3oJ+1oim2kOM6/7U=;
        b=uDlH5OdsPTPSLwP84hEs+4vNLciIy0X3zFd7ybfQe+kgY+lEsuy97IucCRaVi6jbQX
         EoVuk5b59KYS4uSYQMUrprnZZBUmg3g+xxBFHL0k2uBhWX5ku4SpBDVVZ27ZaefF/XWG
         UMJZyoE1OvABuMd/Aoi7OE2T+1WWprEtbo1h1SNOTEXej1h9f9BupScafKiMlLpgKTZj
         by29hcVt02+G9Q/4iGyRyjMPGwgt5RAMOpnG3iBcadz8SSOwLXdOhAmhUD/08lMmoyB8
         UgW8bYotvcmwbAgN9a9wF+tgwvIPLY+BowkkOk5dCa2Lao+K3ErtZzHpQFbz58eP0ZS1
         6a4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIdP1pqLqGTHxGCuPg6p6dEKY8hh/zfZdpdMapMLduevl6qh26OFPmhnXUY9rPppMALD8te99DBThesQylvTVZ++RIHivqlKtRdLyX
X-Gm-Message-State: AOJu0YwYsuquDQbRaVm7OAxKdi/uhxX/TDGCkLUGU+sXTqefLG27A6ns
	nr7p/cdGhIIqOdWgHQbM269egPYBSzU1s/ZZywUP6vPK58oM8M9T/Hshjr/Uc8RBSnEl5dElgLV
	67k07KfEu3+a1LrmdaWOvE1D6BH0=
X-Google-Smtp-Source: AGHT+IFlN4ItjjN6NR/YI4BLc2TKtZEzzwcupnNvbqxO04IW1ZTulmrCk05RfKy5bEk5MnTp6NwR5SEq2dZThNQsP24=
X-Received: by 2002:ac8:5783:0:b0:42e:6b2f:e7 with SMTP id v3-20020ac85783000000b0042e6b2f00e7mr13310510qta.26.1708981682796;
 Mon, 26 Feb 2024 13:08:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226194642.47530-1-ppbuk5246@gmail.com> <CAJuCfpGgvxmjbiFVUE-ETXop1D329YRoyCZba9gzYDk0tmJJFw@mail.gmail.com>
In-Reply-To: <CAJuCfpGgvxmjbiFVUE-ETXop1D329YRoyCZba9gzYDk0tmJJFw@mail.gmail.com>
From: Yun Levi <ppbuk5246@gmail.com>
Date: Mon, 26 Feb 2024 21:07:51 +0000
Message-ID: <CAM7-yPRZ1vXAY1_=kdNrgmL7i206O_s6z0_92KwzM0ENED=pCA@mail.gmail.com>
Subject: Re: [PATCH] psi: Fix avg trigger being fired unexpectedly.
To: Suren Baghdasaryan <surenb@google.com>
Cc: hannes@cmpxchg.org, peterz@infradead.org, mingo@redhat.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Suren.

> s/accumlated/accumulated
>
> > But, for PSI_AVGS, win->value should be initialized with group->total[PSI_AVGS].
> > Moreover, to get exact initial value for win->value, it should be set
> > under each trigger lock to synchronize each rtpoll/avgs_works.
>
> That last "to synchronize each rtpoll/avgs_works." part I would
> replace with "to avoid concurrent changes to group->total[]."
>
> Other than these nits LGTM. After fixing them feel free to add:
>
> Acked-by: Suren Baghdasaryan <surenb@google.com>

Thanks. I'll fix my commit message ;)

