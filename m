Return-Path: <linux-kernel+bounces-158434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B828B200C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ACE5B26358
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9388526B;
	Thu, 25 Apr 2024 11:14:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEE178C67;
	Thu, 25 Apr 2024 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714043692; cv=none; b=us73YEfVFLZDW2cjnJPKvvQLmt9r89w1wDMRgR9B+xPhOepigKfDA3sMTZH0IDf4GAGiGTFIUNNP4MJY0XC6LH0Wveo38loWLBylYLldBUeP5QgcX8EbmYeHIlH92C6EfYvoErJoWRGyrO+zLebeMHinfXYiDc/tXx8Ekd9+0JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714043692; c=relaxed/simple;
	bh=UgA8dMiala3oqxSvtPA3bGboHqIvR4pTUBZLP6CH08o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3I+PFMiZXQTbtBNcbyOormH+7azxEA+GatvSzZPodhCuc1M/HETdlROCOzxgFEz5R2u0ofqx0c+/iiIjzpYxOP9L+n0yRzh1BP3FbTFTMor0+CPVrmtS9+MAnDBLE6rb1hRGVdNidW6WROEtofG6G8WdUFP1+mZDDG3u8ebPFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4B211007;
	Thu, 25 Apr 2024 04:15:18 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C634E3F7BD;
	Thu, 25 Apr 2024 04:14:49 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_ffa: fix memory corruption in ffa_msg_send2()
Date: Thu, 25 Apr 2024 12:14:42 +0100
Message-ID: <171404365976.1369555.7389182143116745860.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cd5fb6b5-81fa-4a6d-b2b8-284ca704bbff@moroto.mountain>
References: <cd5fb6b5-81fa-4a6d-b2b8-284ca704bbff@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 24 Apr 2024 14:40:43 +0300, Dan Carpenter wrote:
> The "msg" pointer is a struct and msg->offset is the sizeof(*msg).  The
> pointer here math means the memcpy() will write outside the bounds.
> Cast "msg" to a u8 pointer to fix this.
>
Applied to sudeep.holla/linux (for-next/ffa/updates), thanks!

[1/1] firmware: arm_ffa: fix memory corruption in ffa_msg_send2()
      https://git.kernel.org/sudeep.holla/c/ddfade88f49d
--
Regards,
Sudeep


