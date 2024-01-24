Return-Path: <linux-kernel+bounces-36236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8980B839DC2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DBB41F24D92
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6152110F2;
	Wed, 24 Jan 2024 00:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MK9hIw4I"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0D17E9;
	Wed, 24 Jan 2024 00:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706057827; cv=none; b=cHGodxZRPkz4PVfDoot0UKL6R+0oVUrkuOD0BWp3rav5fhtC43MHmKgl+qD1lFb13XegKyvfcXM6wrAZ2jTRtGL8D1oJzcDPddCCrkj5v25ckHkydanpVv7hS+sqIPKzD9Vt3+91LILtFe8HlF5WLlp3vfD+oMlbhLxeeEfJkmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706057827; c=relaxed/simple;
	bh=WvbsvHt8oo25g8SY64KxzPgxK6HnJrkQ+C1iWvriFII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHD3c5aqOY9Fmpz66CN2mai8hT7d6LI1CtTpoj/SntIG2o8yGsTd+FGqDmow2AkrEnv6AR04vTf6LY4zFBGB8aLthWZ7e22Yx5WrED+eL5yuIF4visl65+ynXU/pSBdYnXpW9oCW/pKsNjh36jy4C79ZkDWGEnortfWq8E4/fH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MK9hIw4I; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Kgcvyz9APT4R78mS/vdiMBTmZBZEqUxJQE72qD/r2i0=; b=MK9hIw4IOZHQ3YiGrMkwb4gjrK
	301nmcIbjtGRLoqr3+sU/wTzaGyXzwWuuNxymWyWo9YyVugL4VVpJlM+66VRjRW3Gp89YqmBCkzAj
	sTOAUBjU4xJ6tTaXNlLgI1XZ9zAl72t74s+2pPg16elIjmBbgwdT1KMxE3tHQk1fguRvUkRsVauo6
	vps3AC5l6atvCsr8leQ8y3AR4ie8YUrZjFs6Ua99N7gOyiDQ1hongw4fNTRZho3BdVKN9iVmd+zEp
	PREyOc8p17gHyUhAdZkXCed5cD0YDscINfCBO960H28pFMSkVRdaqegafRbv/MdpNK05guat18+vR
	gAanNrOQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rSRZf-000x7Y-0P;
	Wed, 24 Jan 2024 00:57:03 +0000
Message-ID: <71285bc1-bf38-49ea-ab77-3258727339e3@infradead.org>
Date: Tue, 23 Jan 2024 16:57:02 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] Documentation: Move "core core" api into a separate
 file
Content-Language: en-US
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Clemens Ladisch <clemens@ladisch.de>,
 linux-doc@vger.kernel.org
References: <20240123164702.55612-1-anna-maria@linutronix.de>
 <20240123164702.55612-8-anna-maria@linutronix.de>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240123164702.55612-8-anna-maria@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/23/24 08:47, Anna-Maria Behnsen wrote:
> Some "core core" API as timer API is documented in driver-api. This is
> definitely the wrong place. As the subject description in
> core-api/index.rst mentions, is also core-api/kernel-api.rst a collection
> of leftovers. Therefore create a new core-api file and start to integrate
> timer api. As this contains a lot of functions, it is separated into a
> timer specific API file.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  Documentation/core-api/core-api.rst     | 14 ++++++
>  Documentation/core-api/index.rst        |  4 +-
>  Documentation/core-api/kernel-api.rst   | 12 +++--
>  Documentation/core-api/timers/api.rst   | 63 +++++++++++++++++++++++++
>  Documentation/core-api/timers/index.rst |  4 ++
>  Documentation/driver-api/basics.rst     | 24 ----------
>  6 files changed, 93 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/core-api/core-api.rst
>  create mode 100644 Documentation/core-api/timers/api.rst
> 
> diff --git a/Documentation/core-api/core-api.rst b/Documentation/core-api/core-api.rst
> new file mode 100644
> index 000000000000..4fe00d084dc7
> --- /dev/null
> +++ b/Documentation/core-api/core-api.rst
> @@ -0,0 +1,14 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=========================
> +The Linux Kernel Core API
> +=========================
> +
> +.. note:: Some Core API is still documented in :doc:`../driver-api/basic` and

I'm getting this warning from the line above:

linux-next-20240123/Documentation/core-api/core-api.rst:7: WARNING: unknown document: '../driver-api/basic'

Ah, it should be "basics".

> +          needs to be moved here. As this document will be huge when it contains
> +          the whole API, split the API for a special part into a separate file.
> +
> +Timers
> +======
> +
> +For timer related API, please refere to :doc:`timers/api`.


-- 
#Randy

