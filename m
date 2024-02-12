Return-Path: <linux-kernel+bounces-61430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB48F851242
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2CD1F21A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5413D39859;
	Mon, 12 Feb 2024 11:30:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032A239843
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707737453; cv=none; b=mQCldMYaY8md8X4rFK1CuBO/hMpG8Hh6oFIVzgJaOPqGhqgu4ty/pGjusoIBIYRu1ctoW42Yk4Ma8q4fPCVpm2SCiSUrmNRUC7x7n8ZUvua1v22PRF2SSCP2KJxib8WPpk5tMiSGmJ3iz3PEsYj4u/nA1XPjA6373Nnn5x03QkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707737453; c=relaxed/simple;
	bh=l2JkugK8wKAju8OpWnXtfWhGZhjlf4ClIwybJ3U7LN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=irEXJ+qy11RJ2bOboTHx1TXNL8I+GzMlZhBNAScSStHhZZ9pQ97WU1mm432d9B0d6No++icRNQgAFdfJlUlJyAW2pi/KUzyK745/nKMOzz6X7hb9ykm/RDlm5dePMD+GQeHtBHS9azz5nThA6uAdJw1HCePmt3ty4eh3qJxwaak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FD68DA7;
	Mon, 12 Feb 2024 03:31:33 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2F2133F762;
	Mon, 12 Feb 2024 03:30:50 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: coresight@lists.linaro.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	James Clark <james.clark@arm.com>,
	linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Leo Yan <leo.yan@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH] coresight: make coresight_bustype const
Date: Mon, 12 Feb 2024 11:30:44 +0000
Message-Id: <170773625003.2157180.18291020574566263083.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024010531-tinfoil-avert-4a57@gregkh>
References: <2024010531-tinfoil-avert-4a57@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 5 Jan 2024 13:33:32 +0100, Greg Kroah-Hartman wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the coresight_bustype variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> 

Moved to next, thanks!

[1/1] coresight: make coresight_bustype const
      https://git.kernel.org/coresight/c/dd95255d44c0

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

