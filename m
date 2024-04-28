Return-Path: <linux-kernel+bounces-161326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 096508B4AB5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2AD1C20AEA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 08:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A90535CF;
	Sun, 28 Apr 2024 08:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEBYThVa"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07525338F
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 08:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714292686; cv=none; b=St8IoYDO+Zf3QWQQ3P3M7JBgTcMn/8AcCFePEK+3Rc5lpVj/aKhRw2FNxuTzxl81h0Za4Jf1oCRG4gJaZ/5dvl5ffIHRz5RMBehls9eF2Rqf5b4pmhtXpfiq13iCmgWoD9Nsp8bWGlzz3dc1fhW/lY20Usn8xzTI0gil2Q3cMog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714292686; c=relaxed/simple;
	bh=0Aw59y47qzDUbQvbyl5IOzBQ7mhF633TSRGR0f4L8Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mRN/nzXVp4BLBk3k0eOuh1KWNHhxwvRKg9lOdantN6b1oux2GfrUzhBbXgqHNgWwhF63O8x9urmeXddBFFxMXfFLnjHmSXfDtsGO0dKvEHHpdeOAVcRsRDh6ZZ8Bfvl/618owq7A65mCXv7DKA3UZg9AwOnV5Fe7j/HglzhjRGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEBYThVa; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34ce52fb920so327999f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 01:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714292683; x=1714897483; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=TeptuDyfF35vpwxj9pUJ1DxCRy/MrbqRDkpf9T2tDDw=;
        b=HEBYThVaMA6pJVP4O65197BWoQOHN5bK4armborEal1Ixeer+N9JMuQjFjduXXiubh
         Fskbhnop3ohJ4Ka5et/R1TDrDcljoaBb3LOc8ZqtDIhO+lVlTiYOXnSuHJNcYsMNtVow
         B561H4ykIKmrOFH6n0ALU2JPqx8UyhBNoe2g/wXmiId21WUwGZZu3YEoZrb6p2g2f9Nf
         3TIuChCoabJdkKB3fwgO05+OepIF8nr7YmbG8LvR34rkiOFQSsxfjMi/n/CjVHV2juAg
         vS4KPtbmpEu0/PDSNeZCWfSMKloobwwytfEKaKxAY+zoiK3NqagN0OigUWkfxXp78746
         1LCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714292683; x=1714897483;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TeptuDyfF35vpwxj9pUJ1DxCRy/MrbqRDkpf9T2tDDw=;
        b=FfnTcgG3y0UpEh9txid1gBCJacf0B/XnKJEfsbtUTyongpZzgX5sovJn4H6nYJ4MUD
         kGo2PRJiHMKV9Qr7l6K/+su+gvi6UYAUKL8Udaw/PE3MAeistiY0oj7MZaPduvghoA7O
         FgTNiLEgD7+EpYfawDQnQDnoTg1Vkdnknt74LugZvJf8MOUfhgyoZjh75CARmFa2e/Wy
         mFcPHb9SH43vBnCUMRnDi5fePCHyPszaIInd8S4kkh4RpJKRFyWTMqKOEwEQwkaPFpq8
         KsJGZizYiFYvfdDbdx9u8bMN+sV+q53/KwptwkTjE3nZNiQBECmlc9q3FwdscUtEgMlM
         OY4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdvOFKH3E7IMnzVkA8/IFpwh6Le2GToYTljsKErNYRJefhzAFqLqluULot9AU8f5BZzJTHLPBGPBUgCvdNP7hIUjAQDLPldHuTrAyu
X-Gm-Message-State: AOJu0YwrJ+j1lIU8LwmO/KNioR4WhHHYdS7qs144RBBU2QoNdWLrQClq
	YWKuRWOMnaAd4n1y99Ml5AfnabM/z7d2j42ta5FMuKoWResVQa+BvoXDTe1z
X-Google-Smtp-Source: AGHT+IFk6khu/qvYscv6oRb8A71pUw0XsTnLajUaHfQf0t9Wi/t4b4nNGf46nhdNW0sHspqP7swUbA==
X-Received: by 2002:a5d:64e8:0:b0:34c:bb79:452b with SMTP id g8-20020a5d64e8000000b0034cbb79452bmr2249676wri.52.1714292682632;
        Sun, 28 Apr 2024 01:24:42 -0700 (PDT)
Received: from gmail.com (1F2EF175.nat.pool.telekom.hu. [31.46.241.117])
        by smtp.gmail.com with ESMTPSA id w14-20020adfee4e000000b00343d6c7240fsm26569320wro.35.2024.04.28.01.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 01:24:42 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 28 Apr 2024 10:24:40 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [GIT PULL] scheduler fixes
Message-ID: <Zi4HyMFJBwm+JIKZ@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest sched/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2024-04-28

   # HEAD: 257bf89d84121280904800acd25cc2c444c717ae sched/isolation: Fix boot crash when maxcpus < first housekeeping CPU

Misc fixes:

 - Fix EEVDF corner cases

 - Fix two nohz_full= related bugs that can cause boot crashes
   and warnings.

 Thanks,

	Ingo

------------------>
Oleg Nesterov (2):
      sched/isolation: Prevent boot crash when the boot CPU is nohz_full
      sched/isolation: Fix boot crash when maxcpus < first housekeeping CPU

Tianchen Ding (2):
      sched/eevdf: Always update V if se->on_rq when reweighting
      sched/eevdf: Fix miscalculation in reweight_entity() when se is not curr

Xuewen Yan (1):
      sched/eevdf: Prevent vlag from going out of bounds in reweight_eevdf()

