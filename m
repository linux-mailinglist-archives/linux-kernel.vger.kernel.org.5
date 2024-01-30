Return-Path: <linux-kernel+bounces-45328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61130842E8E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1571B1F26B59
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FEF762E0;
	Tue, 30 Jan 2024 21:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGBEtF2Z"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8A2762C3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 21:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649386; cv=none; b=SL+dCxKDQx+DEHPICt01ozet+BN8/au5naMdqnQV3LQ3oOjHo1UIGWOdak2oNDRYea9q3xMNOyaHvdU804WrSb+HyVOC4Bh847mr/Dfz8orNi1RwnVg4TnYIjEjEsYkYIx+uGTD8IZfkNmj46da8Ho4U1XwVaGCpjFWaFAq45DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649386; c=relaxed/simple;
	bh=4qNVoAGvWK5NIblqK9Nxmb1qaF3BJJyZ1GoPLywHJh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6BHsMEZP+4mwZpggkCg/t68A6RYSiWMv8rptRJt5yTn/CqogeV7Fj+oE2zCeg4iDtk+I6XKAgHo7Yi/+gho4YBegNiccoT5kIxO+ayboUtgLRMOHjH2xGFjImnDdXRaeRPD4tF6h4u5z8tNkQCq4h/b7d2JdTVQzMFijV8q2PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGBEtF2Z; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7c00128de31so68381139f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706649383; x=1707254183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qNVoAGvWK5NIblqK9Nxmb1qaF3BJJyZ1GoPLywHJh0=;
        b=VGBEtF2ZUsjkZNmPuMEnSJ7ChCRf9wER6Y9ChUplM3CDF4f7XMey7AAsAYZc/2Tdod
         2pm4DEH5en7QKv89xH1tmTpxh2fwwNyIi78Y1kj4cfiajg/PYjJW3mkmMOHobzGWQJ95
         DuoKVkao9fVtuD7A6Ir+2qRyZCJGi3VNysPXgY/cIM9iNDA2IlWDaKXumzKyhWZGoWra
         046ALeTZiouYoppKuZmP2Agss2ULuV9+RJ3yIZ1rbvWWzixsAebEJKk3W7gYS4mE6V0m
         dTCdUt0a/AKohUsHPn16fV7B0O0zG2/kk8ZESPePHOdhcGGnnzJ56vdenlEK6RLjY3z3
         jwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706649383; x=1707254183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qNVoAGvWK5NIblqK9Nxmb1qaF3BJJyZ1GoPLywHJh0=;
        b=Q64Fm1Z+kN6nsal6h59nEhjE8gbQ0bM8Z0VczSLXwxojjTwZ9cdzbc+6Sf7zZF1UV2
         QGEbfGxPss/ZDjL5zPgOWYZIo9YHuYU7Pp2Pxt3Hal3ZTvhG+xAIHh7TEmbLvwNCZewY
         lv4V2okiQ/7NnijvPeWGUr7NWRzYVYp49NaNjFkoU+y74xDjKo7qaZH/rB+ILj5sPu0i
         wtqBv6tNn0MBxqsaLE6WBy8O0uMuMYOAA5K/KV0s8WpUsglv/a+JkzzybjryiWB7VFzw
         ZEFriZb0NZWCvhPhY/qIMQsb1mw19f6BWglW/hnQ/eEQc6MV6a4r7jvYRKt3K4akx9e/
         vBRg==
X-Gm-Message-State: AOJu0Yy+iRbzY5bsPc4Zw2YclgD6r9uIkaJzJD9KjhR6Oed83TV7CcQn
	VySqw8aOF4l/pNskBxbSNWDTNemNDI7FpkpSqxk/ml9KZlrRfNPuZamqhjv87PEBYt7lDeub0Nj
	bnbM2XR0/PPHbX49JXe0ug9hT/h0=
X-Google-Smtp-Source: AGHT+IEJ6YTNfG8xHfQzar3n1gyjUJak9OgUXaR07S/k0dEo88fiq5Yx/Tab5LWwRqzFz0LGe53OwsBHjKxXy9bCB/s=
X-Received: by 2002:a6b:c808:0:b0:7bf:d5f1:faaf with SMTP id
 y8-20020a6bc808000000b007bfd5f1faafmr10241230iof.21.1706649382771; Tue, 30
 Jan 2024 13:16:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-13-hannes@cmpxchg.org>
In-Reply-To: <20240130014208.565554-13-hannes@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 30 Jan 2024 13:16:11 -0800
Message-ID: <CAKEwX=P14PXOxYb6XFgNHMouP3s8UK=Lb=JbErz==xmDoYpDOw@mail.gmail.com>
Subject: Re: [PATCH 12/20] mm: zswap: function ordering: zswap_pools
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 5:42=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> Move the operations against the global zswap_pools list (current pool,
> last, find) to the pool section.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

