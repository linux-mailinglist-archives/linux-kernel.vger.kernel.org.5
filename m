Return-Path: <linux-kernel+bounces-19291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34109826AF6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8046282916
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885DB13AEC;
	Mon,  8 Jan 2024 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mruc7iiz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E665134BF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a28d25253d2so157937566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 01:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704706985; x=1705311785; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/BD8kquA47jLX7SODSn2opTNOHJtU+WiILD1uwW8nYY=;
        b=mruc7iizIYbnxhB4Pc5LTdj322UadJE3AA6zZOJELRuD3dA41NQlaiE/iVUFlD6MER
         1HiLQxrZOvaM8qPidSXVEwttNlRVclmUMCjZX2jxvMn5Mp37vQDaI/Mw1G3/OFLVoLhB
         scwSTpTT6XoMTddXLCrMT6H5RbJZTj/9FvQ1RC4gzxzZA0taIXJCYeQB0mGrr6WTAzfI
         cpOQ8seCF9ciVw0UHELHda+YT22afBR1sLGgOZiwNr8prbT8CTaJLdfbixpl4boyn8Oi
         v90jYz/W0KNJYtEfAFOLfhWdE4flNDOublwY4C4Nya4PcYxzUeXQ6UY5PknACNM6zJcH
         vPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704706985; x=1705311785;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/BD8kquA47jLX7SODSn2opTNOHJtU+WiILD1uwW8nYY=;
        b=SlB1YjgDNCyPzfnsW+FAijR8mkl4FHEOSPgZQ6mTI685ppNWUp5CQ2la4NY/qmb1Vf
         gSo7CohrFJ9evTsrI5N9FvY1undk2O6Y4c1XdLMSxa0Nd8cGv4o8VzZE0y9NLgkK3NDm
         rc5nXw76fNXkHpGB4JUhYjE5WAGgb22pfTnkD7wkO0OviMtZ6nyvejLJq8cRSPM3SOM9
         6uK/kHM0gLvrLSabfrkqxkYYJL/p2smJ5geVg6Kjv8XkUFjoyLJwHSFgS36T85ZJzxB8
         AW4zz53js1fROG8mgtixa8uKQDVTmHOZLIzzbWoyvEJ/XEd3qszxCVxhhb9rnSI77Av2
         O/LQ==
X-Gm-Message-State: AOJu0YzVuGDa94zm5ePN25Hmw8ypemm9XdqCFtfGnPW1ZWekb9Z7J/48
	zWpfvxqDab40XCpm2oIdtTY=
X-Google-Smtp-Source: AGHT+IFL+ldMNkERab7od2dampRLPVKnreE15pq/wZdJb+FSOrmlaAORbLbIqYjOESdBEMPZc1Wnow==
X-Received: by 2002:a17:907:9343:b0:a28:d83e:ceb4 with SMTP id bv3-20020a170907934300b00a28d83eceb4mr1456905ejc.139.1704706985552;
        Mon, 08 Jan 2024 01:43:05 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id r25-20020a170906351900b00a1f738318a5sm3733745eja.155.2024.01.08.01.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:43:05 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 8 Jan 2024 10:43:03 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: [GIT PULL] debugobjects changes for v6.8
Message-ID: <ZZvDp8TCJRBe8wM6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest core/debugobjects git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2024-01-08

   # HEAD: 9bb6362652f3f4d74a87d572a91ee1b38e673ef6 debugobjects: Stop accessing objects after releasing hash bucket lock

Debugobject changes for v6.8:

 - Make tracking object use more robust: it's not safe to access a
   tracking object after releasing the hashbucket lock. Create a
   persistent copy for debug printouts instead.

 Thanks,

	Ingo

------------------>
Andrzej Hajda (1):
      debugobjects: Stop accessing objects after releasing hash bucket lock


 lib/debugobjects.c | 204 +++++++++++++++++++++--------------------------------
 1 file changed, 80 insertions(+), 124 deletions(-)

