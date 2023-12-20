Return-Path: <linux-kernel+bounces-7367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE77681A698
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB281F22F24
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF858481B0;
	Wed, 20 Dec 2023 17:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0ZwJTXD3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6B247A43
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 17:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40c3963f9fcso275e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 09:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703094916; x=1703699716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXBfEAuqKBSMS1c3GRv3ur+swt6j3InHmy9rp0ZP3us=;
        b=0ZwJTXD3Yl+expwUFvwXOJx4ZYg1UmIPK3MClewdBJqzeA9Sd0sUEUq+kPw7sxkh00
         pZI+KAXUCru/zg6YoqPImRgocVAHOLqSk5k2FVzZ3HlV3r/7dglUOqDht28WLZc/vnZc
         mWCRgskRZ8mpy51RxdF2pqaKNjEqVjMAi+BUCBqW41Ghdt7XarKu9eZ26hK7O0GkKKw0
         4tYWA1MzICBld5pyr5IIxpzl5OGs6VCy97CPpaMYSRkXtkCy2DBkN3Yvlalf0KQ2bvtE
         3EGHHilvPWIS+0zXbSsTQ58pz24JENqCrEZkIlQcziQTg6M/WIl6ap9Dbylps6zjybnA
         uStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703094916; x=1703699716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXBfEAuqKBSMS1c3GRv3ur+swt6j3InHmy9rp0ZP3us=;
        b=AMuDKgMHhfs+ARrKJOSt4r0hVdM11dqPrHBvzlYEBLcGRAEudKwIolgcMv1GgHamS1
         rdcFgt7qt7DZ0oWryjwzDjwQYpPjkT1OtK17n1Pj1/wYOZa8BlcDS/HAxewoNBjWkBE+
         8TrclxQhKxqlTXg8WKmJB/IL+JfF/JrcUxfpnjXKt3eBCWYcj89+zR42Km3qWRddyjaC
         Zem7x9RRVQ5eReSOhnkr75hfx5FEv65Ux4WzywM4lKCGu6DjMljpHnehJVnJtEdph/jz
         i1P1COb16N0EK8zPcipX9/74w65v+K20a2hRzGR+je9dlLOgmQmzq/zEEBCEd6YMc5z6
         sg4Q==
X-Gm-Message-State: AOJu0Yz/i9fGxQthb6fOPAkK2Ln0gj64wcxS5FHGJ6lD+WkkE3RtaoED
	Z1DvZ5utiFbKSPODeOVKpkQ9A5SZABwqghO7qcGoeig0Xnj2l8y68+3MzBsM6eGX
X-Google-Smtp-Source: AGHT+IHq8UHmJLiFOiMTsnij3nN2uawkD9E8P3p56H86OZir+aqGDEi/SFQXCqkznhc09wtdn2Bmjx7O0qVLrF3dxlU=
X-Received: by 2002:a05:600c:3b9d:b0:40d:1bcf:1abf with SMTP id
 n29-20020a05600c3b9d00b0040d1bcf1abfmr207456wms.6.1703094915775; Wed, 20 Dec
 2023 09:55:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220012123.2787-1-cuibixuan@vivo.com> <20231220012123.2787-3-cuibixuan@vivo.com>
In-Reply-To: <20231220012123.2787-3-cuibixuan@vivo.com>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 20 Dec 2023 10:54:37 -0700
Message-ID: <CAOUHufZjxjra9Cfw8YC2eA-xsikPw=K5=1ew55hKTdYhMwjUig@mail.gmail.com>
Subject: Re: [PATCH -next v4 2/2] mm: vmscan: add new event to trace shrink lru
To: Bixuan Cui <cuibixuan@vivo.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 6:22=E2=80=AFPM Bixuan Cui <cuibixuan@vivo.com> wro=
te:
>
> From: cuibixuan <cuibixuan@vivo.com>
>
> Add a new event to calculate the shrink_inactive_list()/shrink_active_lis=
t()
> execution time.
>
> Example of output:
>          kswapd0-103     [007] .....  1098.353020: mm_vmscan_lru_shrink_a=
ctive_start: nid=3D0
>          kswapd0-103     [007] .....  1098.353040: mm_vmscan_lru_shrink_a=
ctive_end: nid=3D0 nr_taken=3D32 nr_active=3D0 nr_deactivated=3D32 nr_refer=
enced=3D0 priority=3D6 flags=3DRECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>          kswapd0-103     [007] .....  1098.353040: mm_vmscan_lru_shrink_i=
nactive_start: nid=3D0
>          kswapd0-103     [007] .....  1098.353094: mm_vmscan_lru_shrink_i=
nactive_end: nid=3D0 nr_scanned=3D32 nr_reclaimed=3D0 nr_dirty=3D0 nr_write=
back=3D0 nr_congested=3D0 nr_immediate=3D0 nr_activate_anon=3D0 nr_activate=
_file=3D0 nr_ref_keep=3D32 nr_unmap_fail=3D0 priority=3D6 flags=3DRECLAIM_W=
B_ANON|RECLAIM_WB_ASYNC
>          kswapd0-103     [007] .....  1098.353094: mm_vmscan_lru_shrink_i=
nactive_start: nid=3D0
>          kswapd0-103     [007] .....  1098.353162: mm_vmscan_lru_shrink_i=
nactive_end: nid=3D0 nr_scanned=3D32 nr_reclaimed=3D21 nr_dirty=3D0 nr_writ=
eback=3D0 nr_congested=3D0 nr_immediate=3D0 nr_activate_anon=3D0 nr_activat=
e_file=3D0 nr_ref_keep=3D11 nr_unmap_fail=3D0 priority=3D6 flags=3DRECLAIM_=
WB_FILE|RECLAIM_WB_ASYNC
>
> Signed-off-by: Bixuan Cui <cuibixuan@vivo.com>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> v4: Add Reviewed-by and Changlog to every patch.

Where did Andrew provide his Reviewed-by?

> v2: Modify trace_mm_vmscan_lru_shrink_inactive() in evict_folios() at the=
 same time to fix build error.

The reason v3 was NAK'ed was not mentioned or fixed in v4.

So NAK again.

