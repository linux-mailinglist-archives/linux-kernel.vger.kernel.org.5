Return-Path: <linux-kernel+bounces-18393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1B2825C7A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 23:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742EA1C22901
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F0D35F0E;
	Fri,  5 Jan 2024 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="HGJhooXB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0105D358A4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e36e29685so348125e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 14:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1704493224; x=1705098024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3fLNU4IFvkoiye/vHtsXYLTzA99vIHt7at6zRAMi1KA=;
        b=HGJhooXBiaFFDKK7F+3UuLz22n2K2N8Jqi99gPWyTWm7IwaHn5TbokR81+QP4s36LP
         P/MUZ95+y1SE7+Ymj5ZmeMcKlNwxabSyoZ+Ioibi5w3RWRqhsOvyus93S6igawLxbrKo
         YtfZjtD0ZT4V7KXVgCBiGzKzpbmqgbPEKxz358mooBQr6yimsbMk/yQyEMPxS4bB39a6
         bKinATKk0uGlJnmElfmS2inxzRKohTNkVoHRkD8gbSA4/K20QjLvp0LOSJ61mUyuWZAR
         V7f97jZWm/HxrVU/azh/pwaEGpTM8t4cOyRhVTa7z41Cz4ShbaPJ6rSotIuQ7PhHVZy5
         lfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704493224; x=1705098024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fLNU4IFvkoiye/vHtsXYLTzA99vIHt7at6zRAMi1KA=;
        b=DTZF8fsQ4b7Xe0+SVaiNaEUixt/0AP9iteGKDmdqpHXbK42lob4jWcBM8+JidMP2sj
         7nwSW2Ndw6jYRz4y4aO2kIJs1pAUhhBWDjHVNsC8Lm8QVltuE/eOzxtMQxygyw3J5v5m
         W58+bK7OW7S70f1KnuN2iz0JuivU7Rurt9K4HqiUR0PMj80GpjhcNj5l996TyCpC+6Zg
         DREx8f1LHINKtYSEs9icUPu92ICrNo0Zx3qEbQI+i01Zoa2EL10hGEhdQmnBsiLQv+1H
         Fjl5GiR5BtLg5yrNACnuFN8lmSNLCRl1BbPyhksqQg8dfUQ3Y/mITAlF8fjxTGIFxLKS
         dgGA==
X-Gm-Message-State: AOJu0YyPoF2LSibwViZGaEuXTLL03RMN5w7nnTBlGVN6tFGnnTh/hYoK
	cpXjK2LJAJMNOUP/7r+pF8VfOuWVlsEhCUkHnYX30fm1Fl0=
X-Google-Smtp-Source: AGHT+IFpgHF9tfTIHNw6slqizw4KWCLZswYcGkIPKkd33acwtpron0XZrZWEOuz0x4s4gu8tW2eCng==
X-Received: by 2002:a05:600c:a001:b0:40e:35cd:26c1 with SMTP id jg1-20020a05600ca00100b0040e35cd26c1mr71188wmb.188.1704493223864;
        Fri, 05 Jan 2024 14:20:23 -0800 (PST)
Received: from airbuntu.. (host109-154-238-212.range109-154.btcentralplus.com. [109.154.238.212])
        by smtp.gmail.com with ESMTPSA id q13-20020a05600c46cd00b0040d604dea3bsm2799022wmo.4.2024.01.05.14.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 14:20:23 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	"Pierre Gondois" <Pierre.Gondois@arm.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v4 0/2] sched: Don't trigger misfit if affinity is restricted
Date: Fri,  5 Jan 2024 22:20:12 +0000
Message-Id: <20240105222014.1025040-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v3:

	* Update commit message of patch 2 to be less verbose

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

v1 discussion: https://lore.kernel.org/lkml/20230820203429.568884-1-qyousef@layalina.io/
v2 discussion: https://lore.kernel.org/lkml/20231212154056.626978-1-qyousef@layalina.io/
v3 discussion: https://lore.kernel.org/lkml/20231231175218.510721-1-qyousef@layalina.io/

Food for thoughts:
------------------

Should misfit cause balance_interval to double? This patch will still be needed
if the answer is yes to avoid unnecessary misfit-lb to trigger repeatedly
anyway.

Should the doubling be made independent of tick value? As it stands 3 failures
for TICK = 1ms will increase it to 8ms. But for 4ms tick this will become 32ms
after 3 failures. Which I think is too high too soon.

Should the balance_interval be capped to something more reasonable? On systems
that require fast response (interactive Desktop for example);
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


