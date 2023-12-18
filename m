Return-Path: <linux-kernel+bounces-3312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F307816AD1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584AC1C20A57
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D32713AE0;
	Mon, 18 Dec 2023 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ofYutk18"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2669313AC7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5deda822167so35266237b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 02:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702894701; x=1703499501; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u2zdG1wSvf3jzQ7L1xQYA0sLs4rw/6x1k6XeSgzTHNs=;
        b=ofYutk18LQy+dZJ/jq7uJapdG+S94JzSbouLimMuWj4yTAsG3a0GpedGO4vYq6Gh5b
         /UMY7KQDgzN5u0wVjrzyJGZPDSD48kXlE8aT52nFAS5wN29w5HcHf7BIV6hoUIYxPS0+
         1EZGmH6Lk+gzXLCqlXZ7R2hyTX4jDubOft5vsBkr2tiOeAqNUcnPU9uKVXy/J+81dDo9
         xD9hPs2oOyZBT/rVgdjH8kU33TMoOJEpsXpCLyLo+5JYtPVXSt1+XJO01zdFtlMS3AL4
         T0psEOxRuD2OxuZhbOunlFNeyrxy5x2ipsck1hK6dRt/bbc1QyQd2QMKYEbRKl34J+nz
         Fuaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702894701; x=1703499501;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u2zdG1wSvf3jzQ7L1xQYA0sLs4rw/6x1k6XeSgzTHNs=;
        b=jUqtMsRJRGg+uLYdvyiov8yu8UUQWmb8ogXhv5ot0k/sUR0b6csgpjoHJCuNZ9OZNU
         AU0fHWoCR19s/sR4JGAV/2TsYaO1WYLBvQOU/XR7Lx557M/Wqf7ry0laXl9RL9tLEHZS
         2sCc75GkjGUhMuQJt85Ob9slhOXRly0xOSepfpLlR1PHivCHHhL5jE0eD3Jfr1SfNUzg
         6qvjDNsWiqkfQwvn/G/0dQwKdA5oiW30x4uN7ebYexV7hnkr/KlqFkPLL6XhdrfPjmoP
         Gol6osxV+JeqftTHt2iZu47lvZGuqvTkwozKVeWJumJiY83o9obHdKPuOT55/t+7ceEL
         nlDw==
X-Gm-Message-State: AOJu0YzKtnWfPjtDvRUBPIyR7EUxdhOaYmZcxAP3AKEdgAY0iWymyLDa
	rSX/LxjZDM4oe2YhjVCe6uJmUvYQ7JE=
X-Google-Smtp-Source: AGHT+IETMC6/n0Jlm2pbTHM2YMgzYOdoUzc7zc82UCGLJUANJl2xEc0nAz+kQ7xzHIqJX3O0lTHGb1mytuM=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:6985:75c0:2be9:6bb6])
 (user=glider job=sendgmr) by 2002:a81:fe0b:0:b0:5e6:468e:fea0 with SMTP id
 j11-20020a81fe0b000000b005e6468efea0mr969936ywn.0.1702894701134; Mon, 18 Dec
 2023 02:18:21 -0800 (PST)
Date: Mon, 18 Dec 2023 11:18:16 +0100
In-Reply-To: <CANiq72m1E1=7yVz=jrDJWBtLZzDsi0ygFvZaHrOk_EbKdbf38A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CANiq72m1E1=7yVz=jrDJWBtLZzDsi0ygFvZaHrOk_EbKdbf38A@mail.gmail.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231218101816.508663-1-glider@google.com>
Subject: Re: [PATCH] .clang-format: update column limit
From: Alexander Potapenko <glider@google.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: christian.brauner@ubuntu.com, clang-built-linux@googlegroups.com, 
	joe@perches.com, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	Alexander Potapenko <glider@google.com>, Yury Norov <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"


Hi folks,

this came up in another code review
(https://lore.kernel.org/lkml/CAG_fn=WcrNqV4burBRPZZwoBLwgia7kerZ8g2vV5spzWF=houQ@mail.gmail.com/),
so I thought maybe it's time to revisit changing of ColumnLimit for clang-format?

I ran the script Joe provided, and there's a noticeable drift towards the longer lines in the past
three years:

 201789 78 87.16
 201579 79 87.77
 138155 80 88.19
  55886 81 88.35
  42656 82 88.48
  39539 83 88.60
  36490 84 88.71
  37856 85 88.83
  68131 86 89.03
  29352 87 89.12
  23277 88 89.19
  26902 89 89.27
  21405 90 89.34
  44506 91 89.47
  70788 92 89.69
  13416 93 89.73
  16650 94 89.78
  10872 95 89.81
   9786 96 89.84
  12170 97 89.88
   9139 98 89.90
   8516 99 89.93
   7008 100 89.95
   6058 101 89.97
   4692 102 89.98

At our team we try to run clang-format on all newly written code, which to great extent helps
to avoid style-related bikeshedding. I changed the local limit in my checkout and reflowed
mm/kmsan/*.c and mm/kfence/*.c, and they actually look better than before.

This is sure not enough to justify the 80->100 change, but as far as I can tell right now
reviewers are not actively paying attention at the lines that are shorter than 100 columns,
even if those exceed the 80-column limit. So even if all clang-format users switch to 100 columns
locally this wouldn't cause objections as long as checkpatch.pl is happy.
On the other hand, the readability of the code they produce is likely to increase.

Given that nothing changes for people who don't use clang-format, maybe having the limit conform
to what checkpatch.pl wants is not a bad idea after all?

