Return-Path: <linux-kernel+bounces-33182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 989778365AE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9F6289F37
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F70C3DB9E;
	Mon, 22 Jan 2024 14:42:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C583DB85
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705934533; cv=none; b=XsNQSjN1JhFbSKoe4ZGAcKousqdH9Q31Sy3f8j/zCIvZ3UsF6AUEkRo5AEg1g1wIh1xlWw/XbE2JXa01VvVrS8YYLY1veBXLooLDJtJkR/uCQzls6ZO7iB4sYn33zF93vGPsVdW/iK8Ykb2AQfmDLzLElts/cMlZHpzRPBtlbLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705934533; c=relaxed/simple;
	bh=Cj6GJM0InkZHGv07MICwapOQ7GmJBLICQwC/gqk0CFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pPyLjVq8sUccMLlAC6NOTllyhFGytA5LsCMGm2M0A87gdV2QggnK+WD/8Q5im/pP5nWdt7EkB8hbdbXwpbw01AiX06MWVokl+GT410EvAJ5dFSZJlAiD87yu5aaAYoe+ILKe6d7CRqAzrDWDBkoCctBn3DB6AS4xuB8CVMFLyHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7FEB1FB;
	Mon, 22 Jan 2024 06:42:56 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0E6C23F73F;
	Mon, 22 Jan 2024 06:42:09 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH-next] firmware: arm_scmi: Fix Clock protocol supported version
Date: Mon, 22 Jan 2024 14:42:04 +0000
Message-ID: <170592349472.3508655.6776887689187790816.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109181716.2338636-1-cristian.marussi@arm.com>
References: <20240109181716.2338636-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 09 Jan 2024 18:17:16 +0000, Cristian Marussi wrote:
> Rollback currently supported Clock protocol version to v2.0 since some of
> the latest v3.0 features are indeed still not supported.
>

Applied to sudeep.holla/linux (for-next/scmi/fixes), thanks!

[1/1] firmware: arm_scmi: Fix Clock protocol supported version
      https://git.kernel.org/sudeep.holla/c/6bd1b3fede83
--
Regards,
Sudeep


