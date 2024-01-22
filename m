Return-Path: <linux-kernel+bounces-33177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA258365A8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F731F21C72
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184C23D55C;
	Mon, 22 Jan 2024 14:41:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60723D553
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705934467; cv=none; b=Je361X76ySC1KAanwLHYro958mCiQn70MuRg/AIYtBZdwPE/Npvjg4SxZb3n4FMHtwLcAULvHSaFAzRC9iWRECqp748Vin5ZWuRBrByfXSmBUf+Cy5F6CowRLwHHTs128Ie5QhSPlIn2rbnkkLqz/wVOVudO8uvv4qVqXXgRJgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705934467; c=relaxed/simple;
	bh=JAL3dGI+v7oieSOvoXmN/5FVi3GFVXMIryNjCeeM+lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dj6v8ZPgizCcQLQ2hHutwaXFzWX255wxHWCcTcoSHPApXjmW4QcYqVpgbLwTlghGgRMe4A8Btr/wE4ime6zYSqfQTPbBBW0X8yzTqtHcyYaa+iwFNwmVlFzwAPBrVMy+4U/rhz40z4frzkdS9jVqPGwPqynkTt0BgnTPx8zXYjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 552971FB;
	Mon, 22 Jan 2024 06:41:51 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3DA423F73F;
	Mon, 22 Jan 2024 06:41:04 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	Tanzir Hasan <tanzhasanwork@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Nick Desaulniers <nnn@google.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] firmware: arm_scmi: removed asm-generic
Date: Mon, 22 Jan 2024 14:40:59 +0000
Message-ID: <170592358022.3509249.7214737356243485172.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226-shmem-v1-1-ea15ce81d8ba@google.com>
References: <20231226-shmem-v1-1-ea15ce81d8ba@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 26 Dec 2023 22:52:03 +0000, Tanzir Hasan wrote:
> asm-generic/bug.h can be replaced by linux/bug.h and the file will still
> build correctly. It is an asm-generic file which should be avoided if
> possible.
> 

Applied to sudeep.holla/linux (for-next/scmi/fixes), thanks!

[1/1] firmware: arm_scmi: removed asm-generic
      https://git.kernel.org/sudeep.holla/c/0726fcc8d4af
--
Regards,
Sudeep


