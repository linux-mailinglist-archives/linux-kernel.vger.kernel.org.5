Return-Path: <linux-kernel+bounces-14977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D81A2822595
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E981C22B20
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8C417982;
	Tue,  2 Jan 2024 23:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqOgyMUV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BF517980;
	Tue,  2 Jan 2024 23:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A8FC433C8;
	Tue,  2 Jan 2024 23:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704238548;
	bh=hPu6xGK4IX3QhKTJdbUzW4NhfenDBEDddhD2itm8rE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BqOgyMUV8ZKFmw42r/kPMmuUgOGQrEkBFgDc8WE8vjdWmoeGdCAFRlCDEnwh+uZd9
	 7yc62NTPyEEf6s2JivYwkJjJXM9oGMS2Gm8m+cpIBzqtOYQ/ALCWJodPdiHT8TFbbc
	 JrDeeKVkq8KShE0hJ3fAPnkerYgtPAhbUheU0T0MgkuaOa7XK9FA1nMLdetrEputKk
	 L87ZymlWhxS3qBqTG/IVibNaI7PVK9AifnkHRSmLoewOHSgeNKKfL7gO7IdtOjG3yO
	 6IVDF+QIOmzAT49BhQL30M+CZfG/ccd4MCFTX3mwrtd/6dTkHnj0hmhQoGgPXePpa+
	 yw5vpFGfQNNGA==
Date: Tue, 2 Jan 2024 15:35:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: netdev@vger.kernel.org, linyunsheng@huawei.com, Jesper Dangaard Brouer
 <hawk@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] page_pool: Rename frag_users to
 pagecnt_bias
Message-ID: <20240102153547.58b23d35@kernel.org>
In-Reply-To: <20231220080147.740134-1-ilias.apalodimas@linaro.org>
References: <20231220080147.740134-1-ilias.apalodimas@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 10:01:46 +0200 Ilias Apalodimas wrote:
> -	long frag_users;
> +	long pagecnt_bias;

IDK :(

pagecnt to mean suggests this is related to page refcount,
not page pool specific refcount.

More importantly bias is the large number by which we increment.
This counter counts how many of the bias references we actually
consumed. So how about bias_consumed? bias_used? bias_issued?
frags_alloced?

