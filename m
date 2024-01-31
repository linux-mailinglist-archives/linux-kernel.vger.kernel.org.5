Return-Path: <linux-kernel+bounces-47188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BDB844A4D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370D22834BC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2133E39ACD;
	Wed, 31 Jan 2024 21:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T2+/QC97"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D002C39FD8
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 21:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737450; cv=none; b=CGV0apYrCj4bW6JNnQwCZ0NAXLezxvcJrXIOMNzeITnb19bVJZZp1c4/2Dk2m9Jut3m6eT+s2Pfqs1rRhFPHqCwKop7DAOmqTMoDm0Rr0WtK9QvLZ05qwW6sD7K2shoqAMaRV+Y0F+BWOsQQVXK5fCTxVT3rn6QGXtLc21tpAgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737450; c=relaxed/simple;
	bh=W3hnffA755E5lXRy1TSbgGVVrB5K8VkGvdWEZ93F0G8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oIEIHPYL2LH5PuNPTFCtIa5IwDorCAg/LGD13PwoTX8ePYWDB8Gxz4QdyNMuCSlET8FS5yZYBSo7MJPGIA+NqpyWsQ1hMuQrd6J/OCFcoq58CKG4B8cSwhK7ZOF4gCmq6thIvJxGfDydTre0/HGOdyKNLrAuv+52JCQtFocFnak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T2+/QC97; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=ajIxbU0etqA5qgbkjrR4rFGK1ryMRtqBRtd1I9tiraw=; b=T2+/QC97gG5iFICAfxVxE4t8pc
	0HoNoMPqpVlL9CP0pBi+mJIhq3FOLIdJQgBbOUcDu5oYcXq3r2Nwafqen4YFB8N4D/eDQnFxsK3f0
	OWq6y/YTlHEgTvcl8fuOvH/Zagdt6Wgr3ZOZAAwVjJq5avs5dbMryZ5PFCYXJ+ngy0WkviEaC7YHe
	71g2M7M+Dp9xrXt+t1QRJ++QCqhX+8mlz34mN/gxgzXFWuoRhUTGewYm/mPXOh42eI3Ju8YrXCd19
	JyY1oxOv9SHi4mD6o5gDFNuX0tWmjOr3pN+7ZC7esiNf8j0/oqpsE7xvf4rtaW7tLYBu1cPwL1kAL
	z2RRbQQA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVINL-00000005ahM-1Wzy;
	Wed, 31 Jan 2024 21:44:07 +0000
Message-ID: <28b1d750-fa74-4279-b292-e36cea995e80@infradead.org>
Date: Wed, 31 Jan 2024 13:44:04 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/28] Fast kernel headers: reduce header dependencies
Content-Language: en-US
To: Max Kellermann <max.kellermann@ionos.com>, linux-kernel@vger.kernel.org
References: <20240131145008.1345531-1-max.kellermann@ionos.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240131145008.1345531-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Max,

On 1/31/24 06:49, Max Kellermann wrote:
> This patch set aims to reduce the dependencies between headers, in
> order to have cleaner code and speed up the build.  It continues
> previous efforts by other developers.
> 
> As a preparation, the first patch adds "#include" directives to source
> files that were missing previously, but due to indirect includes, this
> was never noticed.  After the cleanup, many missing directives would
> result in a compiler failure.
> 
> The second patch removes superfluous "#include" directives, some of
> which may be a leftover from refactoring patches.

[snip]

> Max Kellermann (28):
>   include: add missing includes
>   include: remove unnecessary #include directives

How were these (a) missing and (b) unnecessary includes
found or determined?
Did you use some tool for that? If so, which one?

thanks.
-- 
#Randy

