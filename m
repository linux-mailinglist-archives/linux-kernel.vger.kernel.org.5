Return-Path: <linux-kernel+bounces-71057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F358C85A01F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C8E1F22C7B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B371524B2C;
	Mon, 19 Feb 2024 09:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gApwUOIe"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9804320DFD
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336099; cv=none; b=hlkZXKBJ9Pxn16x3u/1nClLs1tmY3HxQVOn5xpMzrUmI9D94iy2e3bOiim7gIsrKX/aQI0h3XAuyi2r0YFjvJVQdyS0BR583AZjND2pb1dCxLOT8eaEPn3DQE4DxSmO9ceTX9mqAoP41v8nEoOLdxKledVIyCSRAz/i5dTEzsTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336099; c=relaxed/simple;
	bh=/9u9EajaJ9Oc5108+x8+7zUM++/57HPGvjhZQ7Eg8dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZeegRw8IEQnO/8X1wv6MREQvaCGvDpkdO4a+7ftM9PUHS/Rm113So6EqHkCNBVK2TsDCVtGZJSzfttZCO/4KW/Hhpa0yVr2AVK+CsqQvpwAlzlm1DRvy8ZzwAez7CAStkwpjt03DnxAzQbeIQTHQf1UPfSsC6uOap7843RcriyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gApwUOIe; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42c7908fad8so6428011cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 01:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708336096; x=1708940896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9u9EajaJ9Oc5108+x8+7zUM++/57HPGvjhZQ7Eg8dc=;
        b=gApwUOIexkfkOshZvqDHpV3DjYAx5XYxX8MNiTWHFI3PzHHnlSYtIiDzTHQZOxXHwB
         lUbH0drdrnuq9YL9xy76Tm0Z1PoZdLv1D+mLZnNuI1hdOt8+xqsVLr6Nwwz31m8ftHlh
         B8RlHp4mHlFdJ/mpPraS2Hbh9ppb1j5EeKacorvuIC+7ROKFYgHgJZZ1Yuxak34/QA71
         i212joIHDE0DNSZJTXdN5Axmpj6EBP/jbqZ+8YdvB155b2yKWWaFJnfDpJndD6mm+KZE
         hoeg5wFDuL46MYGeoU+MVo/spdfL9/rSv4ktyIY1w+cede0kevznxlSeeafnMvMni449
         aJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708336096; x=1708940896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9u9EajaJ9Oc5108+x8+7zUM++/57HPGvjhZQ7Eg8dc=;
        b=DJVIBwRoJpaBwIpmWzS/gYFYNsGfk0QrU2CyCbcyCGYtbpQsFLZprJI8gUMHMqX1pp
         3GCPxXdIQzPoLd4xPobjSN6cKeHk/n4plrEKyUNmj+x/bhkwX1MMVEkBzvuv0vQXMOUJ
         /igyXYiQZlySyCiomf4J8bh/4aJxA3RbSoO/Wf2zhC9RZkrpPSbDG+1FjGFQWyGchAJI
         VndSpCD7cWytr1bROwJ3KVz8e3Y6vLZe7dGMcx6ZUnEiivtoJRnCBDHqecKaM9NeQEs+
         kfv1dbKNx+UY6qCKTpNSWCnWaEcfdRq9JIehwPVtfV2njsCeJr4qxI8yIB0Y5FN2ARmO
         8lmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwt8z2kKv1XujdayNeJ0x6kNjv0bElbL7BUmWrkrJXouGYkRs9kb1lzL9DyDQ9bF8Pv6C8uGz7w1ofnYONDMsv38TwKedSWxaU3KpL
X-Gm-Message-State: AOJu0YyYz8E5U3d8G5KR3Yn2OrhLQPKtD+v+0qSRdUF7upQW6X4BfucA
	6M0vTtykbY8vPFYkIvxpS0wRlOpioS+Rwju6yD9XzjGjnYskechl+fhm3B2axjuaXqAAKxePrs9
	fKIpqlvXQEU4SBdi6v4uWNBoshBg=
X-Google-Smtp-Source: AGHT+IELShw+1dGgRMqRRbzKynrXYu+xs7uvgXEgtIlInDUZx5cZpuLMBBRiHunbgqcNEZHWxUChAUNWxOu6RnVXI4g=
X-Received: by 2002:ad4:5cc5:0:b0:68f:3f86:c2d0 with SMTP id
 iu5-20020ad45cc5000000b0068f3f86c2d0mr8573860qvb.5.1708336096579; Mon, 19 Feb
 2024 01:48:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsOzpRPZGg23QqJAzKnqkZPKzvieeg=W7sgjgi3q0pBo0g@mail.gmail.com>
 <CANpmjNN-5PpSQ1A_9aM3u4ei74HuvCoThiLAHi=reXXQwer67A@mail.gmail.com>
 <CANpmjNM=92PcmODNPB4DrAhfLY=0mePCbyG9=8BGrQ4MC0xZ6w@mail.gmail.com>
 <CABXGCsM+9TxxY-bOUw6MyRV7CSZsyQpfDgvwgaBBKk9UONJkBw@mail.gmail.com>
 <CABXGCsOp3Djn5uQYb3f=4k1m9rY9y3Ext9SMavWAFRTcKwtNMA@mail.gmail.com>
 <CA+fCnZeNsUV4_92A9DMg=yqyS_y_JTABguyQyNMpm6JPKVxruw@mail.gmail.com>
 <CABXGCsPerqj=zXJ0pUCnZ29JGmZFSvH6DB22r2uKio61c1bVkw@mail.gmail.com>
 <CANpmjNMn+ULqbSGQ6uOa0JDhw=2my5TtBK4Y+xyBES_iaG_SEA@mail.gmail.com>
 <CABXGCsM9BSD+SYFkvkYxmcrZL+aUfUb_M-rjNJhzb2cYHQr5ww@mail.gmail.com>
 <CANpmjNNXKiM0j4mR-Rr2KALhgz87=QjCOomEymNMWjtos=Z3Ug@mail.gmail.com>
 <CANpmjNOnbNw2fRL3_depaAgt81p-VpHh5_O_26kyxofjECgsFQ@mail.gmail.com> <CABXGCsPB-KEbE+SfymVmqfiomFVngFL2Je81Qyhw1F5_aZX-TQ@mail.gmail.com>
In-Reply-To: <CABXGCsPB-KEbE+SfymVmqfiomFVngFL2Je81Qyhw1F5_aZX-TQ@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 19 Feb 2024 14:48:05 +0500
Message-ID: <CABXGCsO5dcEuorLAXR3CFzDVyAWNk4_YfqCh=UJddfzpWF7hNg@mail.gmail.com>
Subject: Re: regression/bisected commit 773688a6cb24b0b3c2ba40354d883348a2befa38
 make my system completely unusable under high load
To: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, glider@google.com, dvyukov@google.com, 
	eugenis@google.com, Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 3, 2024 at 1:14=E2=80=AFAM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> You are right.
> Thanks for digging into it!
>

This [2] revert is still not merged at least I checked on 4f5e5092fdbf.
Is there any plan to merge it or find another approach?

[2] https://lore.kernel.org/all/20240118110216.2539519-2-elver@google.com/

--=20
Best Regards,
Mike Gavrilov.

