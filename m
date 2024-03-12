Return-Path: <linux-kernel+bounces-99995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1216879073
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338532830B6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3F978283;
	Tue, 12 Mar 2024 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oja9u+Kv"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CD278263
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710234972; cv=none; b=KZe7QbIF8YouejRQDnwmJ2YU10qZI/FyYMCnA/S2Pddp19+RgJFCUe5KJpcRrZ8zxXfjPfw+1BiUaGgoebRMu17zr6bhHpnPJ1rQ5OINxp+Zjda9rK6qiNq2OPGGsnLABmkHH4N6+MH1kKjh5+E6B/JdTWmuX7P+PN1Gq6wjHRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710234972; c=relaxed/simple;
	bh=u1LhooOkaCvIZNrr1IoLbE6SPEISjan+MlGKvYRJFXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9RKdbO+wq/TtLk51DN6qi7BetrRm4/0Ae6jZD4NLZCuiwx2ujKN8WlTnH/0dw9E1jrl4iH/hyDUqKydxc8XhJhMFGjiR/mp4XX7WQFhKMWX7Zdf69CyIoJ4I3sc1xuIYVBHW1LyGis6q5fFAWDORzo21mqMOXOLstZen4qqn94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oja9u+Kv; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7dae66def19so2614813241.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710234970; x=1710839770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1LhooOkaCvIZNrr1IoLbE6SPEISjan+MlGKvYRJFXw=;
        b=Oja9u+Kv/HoF07ZK2+qV5hcXPWzg3L4BE+O+48OlQ36cLxdCtEahenyTDBHqwAwzcb
         FFOKMKOAtTtKNolbHJpQpkizw5fq3jpMzRAbdG7ssRS5DWtyFCqy17wuJ2z3739RWfcS
         nkGIpkvxBkiH/f96YhsFtRHe6AJ20y6segYlCvyTVPzI4isOtOx9UrwPhC4MAgt8lqNa
         L7RDvoGnFvmLSycSMoumfAiUm9wX8tT/h4yjZsV/TZ7BX70kQ5Vq8z9wYXvseLPMgAcu
         HmqaYfQ42W/I5EqHevUcTDH3/ioJkEkUgQwllR920dgoCXpB7QHxtzXz+ok79pBQIMnr
         ynPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710234970; x=1710839770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1LhooOkaCvIZNrr1IoLbE6SPEISjan+MlGKvYRJFXw=;
        b=HM+QR+lqYizM+zhwrxD5RoXvwx7Q99xcEzYBr73asHrbWtWvpZfZw1p8r19YhiNtLw
         P4JeQDRnqAm9w2dxJNAnmyzLbYvJEbisDJnZsFkwrjb1f7ImTNSewTyfM22yhbrDv487
         1PLcls/yG6+qvgmRMeXOFEKObryWUwMgTl6pamh9pP6nqwBi5LSmMvHyooBYcQdO0hGN
         qlBbYIa3cUh6N8Hudfmf9ixhBMK9Yl4C7ritLyu7qF6os1bXXs2IfvMquE3LTr2Y7p6z
         VvBIy7Rhnm362eWp4O7mpqMWc52mX5x3WvDTfPleU1RLjAqzbp1BLB3M6noDb6yQD0wL
         p7rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSWqU7r2eapbtT7AHkXks8i3YF612zfN+5dJ5nfv10fNjpnBRkzaE10Jb82ks4YafxSvedcpesSi1NxvBfmmFivm2AJFOeQzMMLFzo
X-Gm-Message-State: AOJu0YzIHTZKDmC9yUyJ/DC6XkAojIfzrpeVgz0wW1Qdt0HBtGXiZqHn
	afi0jask51A1vNsYtF8P7n+W2+1XeU+32UzSJfsh5GYIZ1qs4Fz3miWN3VkI1Tp9ZEiJ/WyISAD
	JQIYiJgtDXT10+g+/iSxVCv/uHf0=
X-Google-Smtp-Source: AGHT+IE13ow3SzIYq9Jyh9M6e4iD59Hwun5NbfXRVTcyWWC7tYozz4d8LF3u3PWI9sNtPpl1timDaksABzUJvMhyFNI=
X-Received: by 2002:a67:fd56:0:b0:473:2034:1cd9 with SMTP id
 g22-20020a67fd56000000b0047320341cd9mr6355127vsr.13.1710234969754; Tue, 12
 Mar 2024 02:16:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311161214.1145168-1-hannes@cmpxchg.org> <20240311161214.1145168-2-hannes@cmpxchg.org>
In-Reply-To: <20240311161214.1145168-2-hannes@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 12 Mar 2024 16:15:58 +0700
Message-ID: <CAKEwX=N+h4OvNQG_=gBmu7ZF9YMY_9tffcPOMAASotSoaK8PHg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zpool: return pool size in pages
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 11:12=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> All zswap backends track their pool sizes in pages. Currently they
> multiply by PAGE_SIZE for zswap, only for zswap to divide again in
> order to do limit math. Report pages directly.

I've always found this to be weird. Perhaps the original author of
this API wants to support more fine-grained memory consumption
tracking?

>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Anyway, let's just work with realities, rather than hypotheticals :)
With the renaming fixlet:
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

