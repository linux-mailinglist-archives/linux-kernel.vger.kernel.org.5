Return-Path: <linux-kernel+bounces-108224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D315880806
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C37A1F221E9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B06C5F870;
	Tue, 19 Mar 2024 23:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P9xdJew9"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EF457339
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 23:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710889345; cv=none; b=iOOQtIR34oJh7LRHi2/fWr7rJMktCrgNmXxVK0vFtZ8l773cVP6IDPlWo4AN6pxgP2n/M0OloaqnR2cbDuIadeJaYBdh0ZZeQCIOc9BCnoZFAL3Jiqy+zojLeW55feRp0nL7LEdH9qttzBrFRvYiIqIW9mkPwRLqjoVcDh9Gevs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710889345; c=relaxed/simple;
	bh=UK7nKI0Q5+/5MBvmfa6SJspSFHnFC6EvtYiNlYm7DD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hLgus8CVmnoyyPtPRhFY7ucS4FctzRgcYcicwNL8sMRZ0W/NeKsiqFNOsSqcxT26tf7DtyTGsB/suyqIhlQqceyVOvgOpPtLmpJu2sfl/cFvALQZ9jKCNeeKJ8+8ZaeRqKRIjoDFSwaLwPaLH0B3HvtRzBFdtJqntC7ZZXVRSo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P9xdJew9; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c5bc21b1-8725-4bd1-9125-16e59414fe4f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710889340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Yp8b77Z2QP7smP6uFFgzTr6GEMCJrRwCsu1CZUZOOY=;
	b=P9xdJew99zQ3RFsfgtUYwKwKaMLy497c+/b3oS9dKb1KTAZXVTCHB+yMqAX7UQikNp+E0I
	NEcMYnS1iHTY6m7IGqQbrUmkaZDjLRORjoDSSYla6B9f1aLhN88tAI7CQ6OaW4ORBqQpma
	5r7P69yqtKExGoOG+m00M+nFydPkdNc=
Date: Tue, 19 Mar 2024 19:02:15 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/8] drm: zynqmp_dp: Misc. patches and debugfs support
Content-Language: en-US
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Cc: Michal Simek <michal.simek@amd.com>, David Airlie <airlied@gmail.com>,
 linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 linux-arm-kernel@lists.infradead.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>
References: <20240319225122.3048400-1-sean.anderson@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240319225122.3048400-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/19/24 18:51, Sean Anderson wrote:
> This series adds debugfs support for the zynqmp_dp driver. The intent is
> to enable compliance testing or to help debug signal-integrity issues.
> 
> The first four patches are general improvements (and could be applied
> independently), while the last four add debugfs support.
> 
> Changes in v2:
> - Fix kerneldoc
> - Rearrange zynqmp_dp for better padding
> - Document hpd_irq_work
> - Split off the HPD IRQ work into another commit
> - Expand the commit message
> - Document debugfs files
> - Add ignore_aux_errors and ignore_hpd debugfs files to replace earlier
>   implicit functionality
> - Attempt to fix unreproducable, spurious build warning
> - Drop "Optionally ignore DPCD errors" in favor of a debugfs file
>   directly affecting zynqmp_dp_aux_transfer.
> 
> Sean Anderson (8):
>   drm: xlnx: Fix kerneldoc
>   drm: zynqmp_dp: Downgrade log level for aux retries message
>   drm: zynqmp_dp: Adjust training values per-lane
>   drm: zynqmp_dp: Rearrange zynqmp_dp for better padding
>   drm: zynqmp_dp: Don't retrain the link in our IRQ
>   drm: zynqmp_dp: Add locking
>   drm: zynqmp_dp: Split off several helper functions
>   drm: zynqmp_dp: Add debugfs interface for compliance testing
> 
>  Documentation/gpu/drivers.rst       |   1 +
>  Documentation/gpu/zynqmp.rst        | 149 +++++
>  MAINTAINERS                         |   1 +
>  drivers/gpu/drm/xlnx/zynqmp_disp.c  |   6 +-
>  drivers/gpu/drm/xlnx/zynqmp_dp.c    | 836 +++++++++++++++++++++++++---
>  drivers/gpu/drm/xlnx/zynqmp_dpsub.h |   1 +
>  drivers/gpu/drm/xlnx/zynqmp_kms.h   |   4 +-
>  7 files changed, 931 insertions(+), 67 deletions(-)
>  create mode 100644 Documentation/gpu/zynqmp.rst
> 

+CC Dmitry, Tomi, and Anatoliy who I forgot to CC

Let me know if you want to be taken off CC for future revisions

--Sean

