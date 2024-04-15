Return-Path: <linux-kernel+bounces-146008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C7B8A5E50
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9927BB2232C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B055F15957B;
	Mon, 15 Apr 2024 23:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCWUd8az"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CC5158DDD;
	Mon, 15 Apr 2024 23:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713223872; cv=none; b=lqM2cStsfA5Tqajuy43YjzKRHkXBsg3tBBMfVzpA8kWVms3sT7aKwhoQzKtTW1qHQI4DLqCufGihNwnn0uKTYgAy0sGbRZXHWGRVkxqpI1qjLG2FFfaIpdRlOc6sT+/9GdL0PE2aYYho0wynlS6DwQNeIp8oer6A5bWU7DSP/iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713223872; c=relaxed/simple;
	bh=2ako3/VsGj0B0JAvKI2djip7wX7ZZIyY6plsqbNFJ6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWP44kAAU44iowKwcAAv5Ypy39kWDAdQAOh6kngOCUBEtyelNKxij7QK3yfOAoSHL6uw4BnOWwssRev+m07pq6nFaNTt/B/AJn0jmDmg6KfYgPybBmxjZctJVEkd3ynfokTJDJENayjSnzBFeyQxf1q5d7pGKe3pESpvIvqnla0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCWUd8az; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-343c7fae6e4so3138494f8f.1;
        Mon, 15 Apr 2024 16:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713223869; x=1713828669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIxRU79oSK//Uerme6kXym29Xbe+6F4+ro/QfQDfXsA=;
        b=QCWUd8azqwPTyNpfphvzLPoo4gqSfgEGbxTW7hKDz9KHlkkLv1qp4IvEhuwWAZ0tZh
         y6uerVvaZJwUGATUh2P70fOvJw6UxxXoisMfbtk0+4k655PBVI5z3Me0CPyFnEqIh9aa
         0lvTnMe+S6ucxBlk34vZzbA2JKtq1P3EzSCXp8O9sT2gj/a5lEKbTh8rjQDHgRR9Z0gH
         XxotTFEe6gQAvnkduWJHJOkZ+ENNVxGJ/pEY+Ctsdaiq9p/H+hu6FUXjU8l0dN9Aug7O
         o5vZ56s1CywVajgwW0XfSPZQFeThLnKKaLTEviLtgWhEToHQh76PZOG3duumQu1iwMcr
         GNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713223869; x=1713828669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIxRU79oSK//Uerme6kXym29Xbe+6F4+ro/QfQDfXsA=;
        b=qwA010qPwFlwsDW+Lst7sabQyKaiY8ZCQwsfAHCpUU4kas2P94k+iU05GA3t0gz/G2
         6tqtKI0gSijKhxTikoILn2LRuutT9C3bEXxo4iP+bYJQadcdD8MjZmBCmqazAIyttvuP
         zSrXZcRKJKBY4aTDevwnvlU6TgQ7E4paZEQsfVsO1wNbBmuwiA4LKhMuNqLlqmwMXnZ9
         mqieSctomNtdoeMmDpl7l3oO39+0MLnsBWcfE3+sjOi8q7eOH1pE8twjMkuh3VZn4Zpt
         NsPAQh5g1Z9Iv2QCIZQMmfPxGN2dUCqWK82QJ3EJbrCyKKsHCLP4BzKpDPY/kKvP+Qxd
         aK4w==
X-Forwarded-Encrypted: i=1; AJvYcCVWj0A1IXtrPzBkgXZN7TncFySvKnExTnHH/B7jypD+Z18nIP+iGLwZ4JluZsbhzBZGhhWDgurF/JAgeDkN6ykffrQbtXxokNfxtzvffdZXZwTcZT1gP/eojgR1YqSj0QGuPoNVZ3LSN9nsimQ=
X-Gm-Message-State: AOJu0YxknReNMTKJMWMNMn4JKj206So+uTlEFynqXbDBd4oI49zXTqPM
	2asddiNkaaxLbFB/pmzXfZbFsAODeX6oUIx+bHpRceSSxNah5oh3
X-Google-Smtp-Source: AGHT+IHtBAtR5aP/qBxhvoCn1aJ38IOOJvIXGK5uO3kqyaqbOl/8XVrUVWeApXqIl4fycQ7VP4mVvA==
X-Received: by 2002:a5d:6484:0:b0:346:47d6:5d17 with SMTP id o4-20020a5d6484000000b0034647d65d17mr9194707wri.57.1713223868408;
        Mon, 15 Apr 2024 16:31:08 -0700 (PDT)
Received: from lewis-nuc.. (0.8.5.0.4.e.2.b.b.7.e.1.3.e.2.b.2.5.b.3.a.b.d.1.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:1dba:3b52:b2e3:1e7b:b2e4:580])
        by smtp.googlemail.com with ESMTPSA id cg17-20020a5d5cd1000000b0033e7a102cfesm10402318wrb.64.2024.04.15.16.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 16:31:07 -0700 (PDT)
From: Lewis Robbins <lewis.robbins2@gmail.com>
To: kvalo@kernel.org
Cc: lewis.robbins2@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	pkshih@realtek.com
Subject: Re: [PATCH] wifi: rtw88: reduce failed to flush queue severity
Date: Tue, 16 Apr 2024 00:28:38 +0100
Message-ID: <20240415232837.388945-2-lewis.robbins2@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <87le5ey52e.fsf@kernel.org>
References: <87le5ey52e.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ping-Ke Shih <pkshih@realtek.com> writes:

> Lewis Robbins <lewis.robbins2@gmail.com> wrote:
>> 
>> Reduce the log message severity when we fail to flush device priority
>> queue. If a system has a lot of traffic, we may fail to flush the queue
>> in time. This generates a lot of messages in the kernel ring buffer. As
>> this is a common occurrence, we should use dev_info instead of dev_warn.
>> 
>> Signed-off-by: Lewis Robbins <lewis.robbins2@gmail.com>
>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
>
> I'd like to know situations of " If a system has a lot of traffic...". 
> Did you scan or do something during traffic?

So, after digging a bit more, it seems you're right this only happens during a
scan. The log message itself is repeated about 5-10x.

Kalle Valo <kvalo@kernel.org> writes:

> The driver shouldn't print any warnings in normal usage, even using info
> level. If this is expected scenario then maybe change it to debug print?
> Or if is this an actual bug then it's better try to investigate and fix
> it.

I have the stack-trace:

[23838.633664] rtw_8821ce 0000:02:00.0: timed out to flush queue 2
[23838.633685] CPU: 1 PID: 363059 Comm: kworker/u8:1 Tainted G 6.8.5
[23838.633698] Hardware name:  /, BIOS 5.26 09/26/2023
[23838.633704] Workqueue: events_unbound cfg80211_wiphy_work [cfg80211]
[23838.633881] Call Trace:
[23838.633889]  <TASK>
[23838.633898]  dump_stack_lvl+0x47/0x60
[23838.633918]  rtw_mac_flush_queues+0x148/0x190 [rtw88_core 0d7ad2d9d6116c633c0aab4e7bc6016d572d75d4]
[23838.633993]  rtw_ops_flush+0x5a/0x70 [rtw88_core 0d7ad2d9d6116c633c0aab4e7bc6016d572d75d4]
[23838.634056]  __ieee80211_flush_queues+0x10b/0x2e0 [mac80211 5d0b446baffe1290bc56d55aa496e941688b7b40]
[23838.634309]  ieee80211_scan_work+0x3e3/0x520 [mac80211 5d0b446baffe1290bc56d55aa496e941688b7b40]
[23838.634494]  cfg80211_wiphy_work+0xa7/0xe0 [cfg80211 b36d5437ba649ace42ea92e8f83a3ec499e0d5b7]
[23838.634646]  process_one_work+0x178/0x350
[23838.634660]  worker_thread+0x30f/0x450
[23838.634670]  ? __pfx_worker_thread+0x10/0x10
[23838.634678]  kthread+0xe5/0x120
[23838.634691]  ? __pfx_kthread+0x10/0x10
[23838.634702]  ret_from_fork+0x31/0x50
[23838.634714]  ? __pfx_kthread+0x10/0x10
[23838.634724]  ret_from_fork_asm+0x1b/0x30
[23838.634736]  </TASK>

I'm not sure as to the cause. If the flush operation takes a long time do we 
need to release any mutexes etc? And if this is just a hardware issue, then we
can do a debug print as you say.

BugZilla: https://bugzilla.kernel.org/show_bug.cgi?id=218697

