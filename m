Return-Path: <linux-kernel+bounces-35461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2889C83918D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD771F28CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3645026D;
	Tue, 23 Jan 2024 14:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="NaXfEi4h"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B18512E5F;
	Tue, 23 Jan 2024 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020744; cv=none; b=LBJnNMqpC6QDPC4LqJ5ToKu072jIwZZeWWLtGkVujsW1r6QdwIlRQdcfBUas6vpqQZyVbekwT8BPXYav5vwt+on99io4MPHPL6aWYG49NmngaY8+7gZyVBApckBxN7E4Cq1llCzzV1hBCp6BJJnCMnfzEvgXQQP+thxZhfy5Nzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020744; c=relaxed/simple;
	bh=K6zg6vTCzrzTf1j6vmjQm/wVXkYSEHPStAwuKV9vcXM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ks88iDBdxACBSPUH8/7QU+g5ttXHm7UIOGM8goiZJGW4h7alwO1y+2mxDBQqpPs9W5xwcxO9XLlMK+ta/5pycQFbOk1YFWY5cPUw9+DpGhhi1KGRpgZWiH43DahgnDJP/E308nSpNxdn4NvudKZ1D2sQGfmmFFa6NDXTW1nXhrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=NaXfEi4h; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (c-98-53-138-11.hsd1.co.comcast.net [98.53.138.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id AB4C64A2;
	Tue, 23 Jan 2024 14:39:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AB4C64A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1706020741; bh=xhekjE4E+jF0d+dUTemSZHRd8Hc34nR/x1C+V1iVp3M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NaXfEi4hV/rjpmbTbBmC38fJh7E+r4XxjxZ98rDuDSQeuFrSV1mlGN2Mo2iN3heku
	 NKRcBXljfgBH0kPmij393qvXu6RPrRkteunV8T9bsvipFp9R1Xj0mLtVtGe9MVZjpr
	 Lb+SQm4iyZf8MKChccqv1b60iTlSvlsn8n/Ha2SMLlp3lz5+BCvwxuifCApV9rn7cI
	 LIZE6YEgfILwPJ5qtdAd97wNo1plwowgtB+6KnAoIyhy6HCdVl7z+gYA7yQNVRw04y
	 kLAv3i78bRo8izxjVd314b6xbZkhOb2VPosLjYH/kC3rcEscQe7z1WVdk+4cDHt+2r
	 IR7zCaOZSAbeg==
From: Jonathan Corbet <corbet@lwn.net>
To: Ramona Gradinariu <ramona.gradinariu@analog.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org,
 nuno.sa@analog.com, linux-iio@vger.kernel.org
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: Re: [PATCH 0/1] adis16475 driver documentation
In-Reply-To: <20240123104548.136201-1-ramona.gradinariu@analog.com>
References: <20240123104548.136201-1-ramona.gradinariu@analog.com>
Date: Tue, 23 Jan 2024 07:39:00 -0700
Message-ID: <87le8gm7wb.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramona Gradinariu <ramona.gradinariu@analog.com> writes:

> Add documentation for adis16475 driver which describes
> the driver device files and shows how the user may use the
> ABI for various scenarios (configuration, measurement, etc.).
>
> Ramona Gradinariu (1):
>   docs: iio: add documentation for adis16475 driver
>
>  Documentation/iio/adis16475.rst | 327 ++++++++++++++++++++++++++++++++
>  1 file changed, 327 insertions(+)
>  create mode 100644 Documentation/iio/adis16475.rst

Thanks for working to improve our documentation!

You do, however, need to add this new file to the index.rst file in that
directory or it won't be pulled into the documentation build.

Thanks,

jon

