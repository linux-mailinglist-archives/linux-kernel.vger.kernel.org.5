Return-Path: <linux-kernel+bounces-47386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BA9844D28
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994231F2233A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507233A264;
	Wed, 31 Jan 2024 23:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPdDSW85"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EC31E48B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744271; cv=none; b=RHZ8e1HMLl6ZOvAnnYYeG0v6mzMVyFk6ufUfCvmAn/bMc//jTXU2ih8nxw3nWWdraiTyJ7PI6mXTCEO32+/eMDyCDozcmUSQj8O1vicFV+N7kkJACTW69HIgqRGzlJbAD48ld2ZTv1eMgeLCJPKN0Ri7AO6G0aVGfXCUKBNORp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744271; c=relaxed/simple;
	bh=8L4jEua2PKYDRUm8Nwkw1/0a+FDetF9qtz2GcaOTMnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkX0gxgE6xlEQDH73bInZt+ztW3jE8TRqx/FGyO89plTDdEuS9vwdvTXjpejvy3rp+Gtaj7A8gbO8uxlp34zNHpVYfsj6kyr6nsQ0F2Dc49/T5WHszTb93QiFT+ctKMprkT6YBzduKRpAhGdJCv4NELln5MgNyfFhFxN2mTmSDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPdDSW85; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7bff28b2937so13917439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706744269; x=1707349069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8L4jEua2PKYDRUm8Nwkw1/0a+FDetF9qtz2GcaOTMnw=;
        b=YPdDSW85NsXCHrenOIOw26EK8nsuJaJT763w8t+E/syMgcTb97F8eRI9J2LYsCyb/L
         UhKUi4pWksRpm2KuegCrCr8C/ZmvbvXdTE0TwNhQNnnpJRbESQiXFeHHX6tf/RsgNZDZ
         6GG9uKn0JHimJrLRJbupykw9Dgi4JGdOD4fLmaz5GMhQk/U+qChcBAUztJZ9Mqt4HFJd
         PkCCXleLREcPvB2Er1EgrvmPGhz49CxTazJAlg1NBxIX13hZB2O92JeVwUKn1sLPJtTx
         MKKRBoug2PMKvp6B/qZTR5xjy/sfhWKwUAJnRTsJYwT0dLcq+xXgxnL/RA8YW7NieThe
         hxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706744269; x=1707349069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8L4jEua2PKYDRUm8Nwkw1/0a+FDetF9qtz2GcaOTMnw=;
        b=msEMvmsY7Jo0xkTozDCmfa4931ap5tlJe4jGb3mxhu3ZCs3hjPnHS9is5ndGCcy79h
         OjNelbM0SNFqmifRy5sRTU8l/RGymtEw9OpttJqkOr8zmPJZ80zuVQqozQu/M4x54pgF
         CIcnRYEI/vixdjObAAIp+znx7EO+DOAFrqhjPF5m1I3hJtlPzwGfllOmIwj3jaHyeO7p
         tqoIh0gOTv2Y30ZvfUApjjE7bLZJNg+jbd/Z0QbEVL/GxlkU5f8Zpps+rqx7PSe/C/Xz
         //Ig6BnpKNwRJLZVtBnTMHOoKMWCPxZzZYSMuW8Hg9HXArmtrU8qpIZHIeS4l5QpKLVb
         JFag==
X-Gm-Message-State: AOJu0YxEAnNPQi9RSX02yj5InCUDVKnVX4iTSO5TfOtYOn8QZ2WjFJ88
	seRSjzftrsAcqHmCFegiSYZDxfiDvVP72nZS1ha/IpTkw0UHDrVLQZrJKK8ArwEAAZUtECro3o7
	gZYoQROHk3fHepMXCh3DFPgSfvJQ=
X-Google-Smtp-Source: AGHT+IHWsZVmF3unvlCo18YQ6UwRfBNPRWU7C79GqqBOmTYFJjJhvLB47VXGpmDrUjGTvFrQiIWRPcYx4X/lGX97cww=
X-Received: by 2002:a5e:8304:0:b0:7bf:b56c:ac25 with SMTP id
 x4-20020a5e8304000000b007bfb56cac25mr572354iom.0.1706744269379; Wed, 31 Jan
 2024 15:37:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-21-hannes@cmpxchg.org>
In-Reply-To: <20240130014208.565554-21-hannes@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 31 Jan 2024 15:37:38 -0800
Message-ID: <CAKEwX=OfipHCDai192TABTeDu6qsR3AZBNU0GFv+D7tmx9qSuw@mail.gmail.com>
Subject: Re: [PATCH 20/20] mm: zswap: function ordering: shrink_memcg_cb
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 5:42=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> shrink_memcg_cb() is called by the shrinker and is based on
> zswap_writeback_entry(). Move it in between. Save one fwd decl.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

Nice! I just went through all the patches. LGTM.

