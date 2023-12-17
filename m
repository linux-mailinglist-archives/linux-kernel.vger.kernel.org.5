Return-Path: <linux-kernel+bounces-2791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 324BF8161E9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7CE3282E4A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 20:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9A4481AA;
	Sun, 17 Dec 2023 20:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LU5092Tr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5388F481A0;
	Sun, 17 Dec 2023 20:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702843634; x=1734379634;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HWsybbn3Mhvmz/bcKdVSQYDm+V803OZ5xApTGIFX5OA=;
  b=LU5092TrgXFYkm3kZR5DnNnaCxrdJJINwBSAeWjhx9rQNzWkD/dzSwXk
   tOSA8fAPFuDozlgy5V62PaVM71h3X2aKekpqNftBMrzsT4/FmHGhLQeMV
   t2ycofCvD165yu5KdzJ3SlKMAB7JMCbCRc6sbLiszVzhZCQPf+E3tTEjm
   v1nyZ8+sV52I8A80Z4zIcZBVmKyjbBFzTwhsBwoAO3okFXhpxj9TQrITN
   GroIaHJ71mAUHtFV7ZsMX1b5hqcj+sRsQh1vQhPuZIPQWgXfef4ONCNYr
   yRaHR6x5VKuB8v0sVMuTTM3Z6znWdCmK2PPOG7AMZ249HXwOFAfcP5pt8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="398214898"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="398214898"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 12:07:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="1022539225"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="1022539225"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga006.fm.intel.com with ESMTP; 17 Dec 2023 12:07:12 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	lars@metafoo.de,
	Basavaraj.Natikar@amd.com
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/2] Fix regression in ALS
Date: Sun, 17 Dec 2023 12:07:01 -0800
Message-Id: <20231217200703.719876-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Addition of color temperature and chromaticity support breaks ALS sensor
on several platforms. Till we have a good solution, revert these commits
for 6.7 cycle.

Srinivas Pandruvada (2):
  Revert "iio: hid-sensor-als: Add light chromaticity support"
  Revert "iio: hid-sensor-als: Add light color temperature support"

 drivers/iio/light/hid-sensor-als.c | 100 +----------------------------
 include/linux/hid-sensor-ids.h     |   4 --
 2 files changed, 2 insertions(+), 102 deletions(-)

-- 
2.43.0


