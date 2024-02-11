Return-Path: <linux-kernel+bounces-60857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D818B850A33
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755F81F23EB0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F675B681;
	Sun, 11 Feb 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="0PDtzN8h"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E4C5B67B;
	Sun, 11 Feb 2024 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707667358; cv=none; b=lCtZbjTfwx6GFR8+RoCtg3bfjgxiRgRdKaHqdjWX62iA8ftpHU8IAtiVB5KRmgvTOPUDGKkXFWOv/SwhHp5LAJo0aJBWFySBAaXtymWDECfG5yrDvMFbF3kp12OgarTZyL8qeogSkIQmMtwSRsbfrz+tDmY1lkNy1FwIDdZxNxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707667358; c=relaxed/simple;
	bh=UYLtdzaChFcMjmrCbtDNRRHeggY/w+wvLYIXluBloIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlIMwIgo+5PKAZ1XT+0k+hgB3BD40Ylm8xS2JZfUac9K9APgnR1I9iDH+3puQOEhAxoLZ7GLRscFq30qE8uGNv+iSfeZJjtfPndlb2ZhKUpK1H2Qm56TjI9Nxo2XiVDO9QZ0L1i4PXn7JuPTvMFqCkvdmrDK3ORp1Rb+pZKQVGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=0PDtzN8h; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 3A5DD20751;
	Sun, 11 Feb 2024 17:02:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1707667354;
	bh=UYLtdzaChFcMjmrCbtDNRRHeggY/w+wvLYIXluBloIc=; h=From:To:Subject;
	b=0PDtzN8haFo1bKwIWsoAE19kYjWvw7KQcuKVR5EblvTglh5K9HzaQOUWEMQvf0WQb
	 oswL5BMuEmgSeQrxrd/So4XyWLSBXLxFk4g5zlzgHQgDngFNymxaUm/BgWjaHCy1Pz
	 uKun5NqJ8LZ3jYqIucb/zUsXVumAlIuc0e+4SU43/y/wojXLx2ityBJNZyCLe3/jd5
	 qFwjMEynNNm0+PXFEsCwj+XCwFFCO9vMePlpeM2vvH9QGE6hmQySQywst48W9XWUSG
	 zsduorbI/3T0eU0EFikfI+KqQyB/sQvK2xp67AtHB+w9wn6DG10/5TmJZguP7vG1XZ
	 4lSlbXeFApFZQ==
Date: Sun, 11 Feb 2024 17:02:32 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Judith Mendez <jm@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Add tuning algorithm for delay chain
Message-ID: <20240211160232.GB4443@francesco-nb>
References: <20240207011520.3128382-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207011520.3128382-1-jm@ti.com>

On Tue, Feb 06, 2024 at 07:15:13PM -0600, Judith Mendez wrote:
> This patch series introduces a new tuning algorithm for
> mmc. The new algorithm should be used when delay chain is
> enabled. The ITAPDLY is selected from the largest passing
> window and the buffer is not viewed as a circular buffer.
> The new tuning algorithm is implemented as per the paper
> published here [0] and has been tested on the following

Where is this `[0]`?

> platforms: AM62x SK, AM62A SK, AM62p SK, AM64x SK, and AM64x
> EVM.

In the other patches you link some document, but I was not able to find
anything related to AM62, can you provide some reference on this
specific SOC?

Francesco


