Return-Path: <linux-kernel+bounces-13770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F368C820C51
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 18:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5301C1F21B2D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 17:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAB88F6F;
	Sun, 31 Dec 2023 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="YE7Pqmd4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEB98F58
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3366ddd1eddso7950528f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 09:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1704045143; x=1704649943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cRsSsr7R/VxWT/+dNK06s48g6Xj0VD6fQXnvBL3N12Q=;
        b=YE7Pqmd4q+OIBA0EUpazwA8bCx1IabijrqIb0eNcJ7nJJbAkgbmWoxcZnEkmzGfb4Q
         ngOig5QCaTlHC2pfw/x3mW6MlolwZjUj51XIoutcmQV1ILyJ34AWOwXZA165GJq+QdWX
         AgsMDtt7ny1iTIlAZ4z5P6a3mfiFlJ1WRUBpJgZWopjYFCLVGWoQSWqpU4HkS/7/WkZ2
         euSLzKr/Uhw+2K+EYKE3Hm9kZCXiYEsbLRQaF32iCGCrK7ZrY6QZW46mEcutFLO0ETWc
         pt292j0aIEK6mWGomMICBuCq6spOCvhzAmu3EtxxXTKi9baVSwPQDUiRgi8hSTRN+Ww8
         twSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704045143; x=1704649943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRsSsr7R/VxWT/+dNK06s48g6Xj0VD6fQXnvBL3N12Q=;
        b=YBhb9MEIqtf+Ck2Q9Cu1tYzJvkz+HjV+04lEAHMnQQBRUCLlJ7pBVKHh7sWj5JCQRB
         VW+qrK7x3KAfFqFF8e/9CX0dZGYV/c/cOHhD62wMXSim737nTcRHoC6+gcOa/K6Ae6oT
         KbVtrTheX1K6D758bWZw6UYa++F+qPNYHpHEQgRESAKk5rBqDG7nx968M+ewMRF6KL2D
         fomCeKutuaC89C4quxsTlQBEJA4T7K3Jkfp7hr+MpEMoi2fs0vqKJWquDWeMvGYBRr6V
         4LfED7yQNqNYhHUFoBWBUH8aLO/HbzGv7p8zUzFkuA4v7QesUvKqnHbpz7bGWDvgMZbo
         iVxA==
X-Gm-Message-State: AOJu0YxwpPPpGinSbXRY+4uonu1BIAJAfC3FMT20FfiKEWIra0apM3qw
	Erc2fmglmg1A62UcJ9uIjq2TD4kdb3FL4Q==
X-Google-Smtp-Source: AGHT+IH04r4aAZp3KWo4R6oeLS2wOH3kOFKULoSXAYjBcCT3hI3Ljv0FWnbfikJORx8RkJCiSFgesQ==
X-Received: by 2002:a05:6000:1c1:b0:333:ef80:b3c6 with SMTP id t1-20020a05600001c100b00333ef80b3c6mr3808209wrx.61.1704045143230;
        Sun, 31 Dec 2023 09:52:23 -0800 (PST)
Received: from airbuntu.. (host109-154-238-212.range109-154.btcentralplus.com. [109.154.238.212])
        by smtp.gmail.com with ESMTPSA id h17-20020a5d4311000000b003373f723dcbsm1229120wrq.42.2023.12.31.09.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 09:52:22 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	"Pierre Gondois" <Pierre.Gondois@arm.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v3 0/2] sched: Don't trigger misfit if affinity is restricted
Date: Sun, 31 Dec 2023 17:52:16 +0000
Message-Id: <20231231175218.510721-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v2:

	* Convert access of asym_cap_list to be rcu protected
	* Add new patch to sort the list in descending order
	* Move some declarations inside affinity check block
	* Remove now redundant check against max_cpu_capacity in check_misfit_status()

(thanks Pierre!)

Changes since v1:

	* Use asym_cap_list (thanks Dietmar) to iterate instead of iterating
	  through every cpu which Vincent was concerned about.
	* Use uclamped util to compare with capacity instead of util_fits_cpu()
	  when iterating through capcities (Dietmar).
	* Update commit log with test results to better demonstrate the problem

v1 discussion: https://lore.kernel.org/lkml/20230820203429.568884-1-qyousef@layalina.io/#t
v2 discussion: https://lore.kernel.org/lkml/20231212154056.626978-1-qyousef@layalina.io/

Food for thoughts:
------------------

Should misfit cause balance_interval to double? This patch will still be needed
if the answer is yes to avoid unnecessary misfit-lb to trigger repeatedly
anyway.

Should the doubling be made independent of tick value? As it stands 3 failures
for TICK = 1ms will increase it to 8ms. But for 4ms tick this will become 32ms
after 3 failures. Which I think is too high too soon.

Should the balance_interval be capped to something more reasonable? On systems
that require fast response (interactive Desktop for example),
a balance_interval of 64ms and above seem too high.


Thanks!

--
Qais Yousef

Qais Yousef (2):
  sched/fair: Check a task has a fitting cpu when updating misfit
  sched/topology: Sort asym_cap_list in descending order

 kernel/sched/fair.c     | 65 ++++++++++++++++++++++++++++++++++-------
 kernel/sched/sched.h    | 14 +++++++++
 kernel/sched/topology.c | 43 +++++++++++++++------------
 3 files changed, 94 insertions(+), 28 deletions(-)

-- 
2.34.1


