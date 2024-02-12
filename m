Return-Path: <linux-kernel+bounces-61427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E15851237
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94CA01C20433
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEA138FA9;
	Mon, 12 Feb 2024 11:28:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B51838DE1
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707737281; cv=none; b=eMmwu/E7jo93Silma1pGsicaX78t4ZmkOVpQ4ck5nbwGUmd3BnBwwSfaAKn3w1DaOAroZ2wqy/aa90gGiS8EZMziThObyY+O2T1Bn94XQC7SJeYUNteSIOaIHT9n7hSLM39iBrhgITh3k400UB7HC7yELt+3SszIVnRn++vX5VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707737281; c=relaxed/simple;
	bh=wy3A377S/sfHk7aN9TsYPhCDU3v7Y0hmPzS1F036OVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2UDLUe+2+TmFlfiHb63tJQCL0J9Q2QKivAzgM2wuxLJCQjAJi43zA72EF/GEqu7P0iDF5At32U7F+WBLfdjSX2IsEJrHVtGel2rncKIFPCnh/26alKZt4rlTm206fTtz+h2gP+ww3DyXmLkBw92Jpmm9Uk22H48ojKeU7rd9z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CE29FEC;
	Mon, 12 Feb 2024 03:28:40 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9C9E73F762;
	Mon, 12 Feb 2024 03:27:57 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: coresight@lists.linaro.org,
	James Clark <james.clark@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v2 00/12] coresight: Separate sysfs and Perf usage and some other cleanups
Date: Mon, 12 Feb 2024 11:27:51 +0000
Message-Id: <170773625002.2157180.12698644436434425979.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129154050.569566-1-james.clark@arm.com>
References: <20240129154050.569566-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 29 Jan 2024 15:40:31 +0000, James Clark wrote:
> Changes since V1:
> 
>   * Clarify further "the selected sink" in _coresight_build_path()
>   * Move etm4x's mode to coresight device which was missing from V1
>   * Use explicit initialisers in coresight_dev_type
>   * Create functions for handling mode changes
> 
> [...]

Applied, thanks!

[01/12] coresight: Fix issue where a source device's helpers aren't disabled
        https://git.kernel.org/coresight/c/f68bbe4dcfa3
[02/12] coresight: Make language around "activated" sinks consistent
        https://git.kernel.org/coresight/c/a0fef3f05cf3
[03/12] coresight: Remove ops callback checks
        https://git.kernel.org/coresight/c/a11ebe138b8d
[04/12] coresight: Move mode to struct coresight_device
        https://git.kernel.org/coresight/c/9cae77cf23e3
[05/12] coresight: Remove the 'enable' field.
        https://git.kernel.org/coresight/c/d5e83f97eb56
[06/12] coresight: Move all sysfs code to sysfs file
        https://git.kernel.org/coresight/c/1f5149c7751c
[07/12] coresight: Remove atomic type from refcnt
        https://git.kernel.org/coresight/c/4545b38ef004
[08/12] coresight: Remove unused stubs
        https://git.kernel.org/coresight/c/053ad9ad1d13
[09/12] coresight: Add explicit member initializers to coresight_dev_type
        https://git.kernel.org/coresight/c/812265e26ed3
[10/12] coresight: Add helper for atomically taking the device
        https://git.kernel.org/coresight/c/d724f65218b9
[11/12] coresight: Add a helper for getting csdev->mode
        https://git.kernel.org/coresight/c/c95c2733e5fe
[12/12] coresight: Add helper for setting csdev->mode
        https://git.kernel.org/coresight/c/bcaabb95f0c9

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

