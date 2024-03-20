Return-Path: <linux-kernel+bounces-109029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873C78813A9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC461C22538
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA98482C2;
	Wed, 20 Mar 2024 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih9Nofii"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DED39AE3
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710946107; cv=none; b=qm9M03bkTPCkSTX/Wq2IXFaNmzSOTxD8dCpue+6af5d1tDj46oeiKaLygg3kG9ogE2ppCoR24O7Zb9xHMDBO3DIN48h+oNY389sQF1qVRpVnJC6n7yH4QWL1VW+qO3FIL0uRQM/pg0LSavBfZ8uUEdhEmkZf4EmQLzX/PqOJiJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710946107; c=relaxed/simple;
	bh=/ltmvM0w70xtErdmc5CdiNk2BYEMlEM19F2i3B/Nu+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brqQlVLUWdgzHM5ukud1uh8Zb1rUc++5eqCDRsr/nD0C4f8BjMZsRR0+oAhVV5h/TOQ05ndvecb4T78NE8mCynHABetTcJ40sKtvRVgsOwsKao2+l2FsGXcX44JhFVDDH72jE6Vl7fyMjZg7aEgPGUXDNLkidekTlGj47I44Kwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ih9Nofii; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4d46c4e1578so910963e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710946104; x=1711550904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ltmvM0w70xtErdmc5CdiNk2BYEMlEM19F2i3B/Nu+0=;
        b=ih9Nofii8CTmBo6oWVu9uzFvWvjcgtG5y9vQZyJ/Ocw7kdOUtnuSsEFLN0Pbi9HMi8
         PGjJKyO2aawYeazndoht2s0AdtHQhOl3cb45yBEyj3AqakFH2BifqnD/flo84PENLzTt
         +Ppe8vXpF8flFq57LVyfDCuyzWV5h23Hc4CMUayvvJF/4BTuQSjfkamLujXH/PiuOV/E
         if+rHZCLXIuPA2xWWXfrsk9ldOepi8eIipkbYm5ibJdgWV/nd/Xbi5C+g6Ti/CU3/1M9
         APkBnx6IHWhinotu0FJ0+jjlqKAYHIuItoy/mKZaBVmZd+u1VDdY8zT/9JsPk5i2i4qp
         VW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710946104; x=1711550904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ltmvM0w70xtErdmc5CdiNk2BYEMlEM19F2i3B/Nu+0=;
        b=fzRHJ1WGiDfs4GZryd6arAORBhO1tN4TSA5aEGLSG0YeJN4L7I2GDoyQCwpT/MWuCO
         PSZDvOEtyEccXDW5HfaMPqI0TLZ+PwBqVgrqSAoCCQO8eOPm4+RhMg6yzc5FjW/GxYog
         3fxPS3mB+ch8JZ/a6NOWW6WklrDw/YVp84ZKKhTixaFbU9s+wDPY+K6saVWa+fT+y8aD
         QBaklaJBsnvrAezGydL9ljq20oPqP4N00+QSwcBM95Yh1lQqIo1T2sYNBhp+BnYoU/ml
         qlutp1zi6P+2ouR6dWqBZu6DCbAM4rFMyTAXUbIas7+fMyl6+ZxWTGNBWGp9ITb9JD6E
         VTWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSRUoPDeW4fUVHodZCqhQKjWrJPSFayNymDfUmHtperoW/54LdXNsa7pRn4+59DevzEPA3Z2rn9/LVWD/DFuFZIhmehBGDzc0slmLY
X-Gm-Message-State: AOJu0YwPMqLW8/tiPQvLhTiYEZQEdVCFib3qE1D1NwhELdq+uPJmzkhg
	x44hZmoXokOuZfLd7mikx3zw2bql5Kzz0kFu0ejcgI9Zw5+rgy0jqMK3ripX5p9EjJaLLWPzl8a
	h8ojSizzPcvbbKMZPc3aIJznM3rE=
X-Google-Smtp-Source: AGHT+IFITGGcejv2uDTIH2avPNV8ieyCB2ZuD2EEw8Fg6E+sCuFlLinZLiBr2qVxuFxdpYc2yF+Wx6NXvulopF1jqy4=
X-Received: by 2002:a05:6122:2514:b0:4c9:98f8:83db with SMTP id
 cl20-20020a056122251400b004c998f883dbmr18719446vkb.5.1710946104139; Wed, 20
 Mar 2024 07:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320020823.337644-1-yosryahmed@google.com> <20240320095053.GA294822@cmpxchg.org>
In-Reply-To: <20240320095053.GA294822@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 20 Mar 2024 07:48:13 -0700
Message-ID: <CAKEwX=ODDeetg_iv2kcds_DziJ5og2F6STsLSXE85qufYET=eg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: zswap: increase shrinking protection for zswap
 swapins only
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 2:51=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Wed, Mar 20, 2024 at 02:08:22AM +0000, Yosry Ahmed wrote:
> > Currently, the number of protected zswap entries corresponding to an
> > lruvec are incremented every time we swapin a page.
>
> Correct. This is the primary signal that the shrinker is being too
> aggressive in moving entries to disk and should slow down...?

Yup. Currently, there are two scenarios in which we increase zswap
protection area:

1. zswap lru movement - for instance, if a page for some reasons is
rotated in the LRU. When this happens, we increment the protection
size, so that the page at the tail end of the protected area does not
lose its protection because of (potentially) spurious LRU churnings.
2. swapin - when this happens, it is a signal that the shrinker is
being too... enthusiastic in its reclaiming action. We should be more
conservative, hence the increase in protection.

I think there's some confusion around this, because we use the
same-ish mechanism for two different events. Maybe I should have put
yet another fat comment at the callsites of zswap_folio_swapin() too
:)

>
> > This happens regardless of whether or not the page originated in
> > zswap. Hence, swapins from disk will lead to increasing protection
> > on potentially stale zswap entries. Furthermore, the increased

Hmmm my original thinking was that, had we protected the swapped-in
page back when it was still in zswap, we would have prevented this IO.
And since the pages in zswap are (at least conceptually) "warmer" than
the swapped in page, it is appropriate to increase the zswap
protection.

In fact, I was toying with the idea to max out the protection on
swap-in to temporarily cease all zswap shrinking, but that is perhaps
overkill :)

> > shrinking protection can lead to more pages skipping zswap and going

I think this can only happen when the protection is so strong that the
zswap pool is full, right?

In practice I have never seen this happen though. Did you observe it?
We have a fairly aggressive lru-size-based protection decaying as
well, so that should not happen...

Also technically the protection only applies to the dynamic shrinker -
the capacity-driven shrinking is not affected (although it's not very
effective - perhaps we can rework this?)

> > to disk, eventually leading to even more swapins from disk and
> > starting a vicious circle.
>
> How does shrinker protection affect zswap stores?
>
> On the contrary, I would expect this patch to create a runaway
> shrinker. The more aggressively it moves entries out to disk, the
> lower the rate of zswap loads, the more aggressively it moves more
> entries out to disk.
>
> > Instead, only increase the protection when pages are loaded from zswap.
> > This also has a nice side effect of removing zswap_folio_swapin() and
> > replacing it with a static helper that is only called from zswap_load()=
.
> >
> > No problems were observed in practice, this was found through code
> > inspection.
>
> This is missing test results :)

Yeah it'd be nice to see benchmark numbers :)

I mean all this protection is heuristics anyway, so maybe I'm just
being overly conservative. But only numbers can show this.

