Return-Path: <linux-kernel+bounces-4443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90511817D2C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286531F23A98
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0273E74E23;
	Mon, 18 Dec 2023 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3JrBUef"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4071674E01;
	Mon, 18 Dec 2023 22:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6985FC433C7;
	Mon, 18 Dec 2023 22:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702937868;
	bh=t7Gmv5F71yGBolxJcSQzxF/nnRPNiebuTCV2lk+O0iU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H3JrBUefL+Sz3MA3XQLhUDrNrtGVSjk0YquAxZTs/k9ulxx3lzCbTQbR7/Hl3c/ok
	 FykVC/F98vK4XemHVuCt+OR7KMbE6a3sfHCw/Cp77lFFhg5lvLpNtBVBwKXNk4jxm+
	 QDYHotaGWfZJDgfMRNudEXnM7hh9Pmz7wqkhIsO4Ep0kY6BxU0VK2/UzJ8Pob5zJ7T
	 nlTwIVgjc0husSb5i1ovXd8BySRcljiNO1zz+4SCUI0eHJLOHhrqE7HPLbzGInRd5C
	 0+MpSlmmX48aMfG0PDaojQA9pdZqg6979IOOI9cSX8C4wuIq6zW9LOzFQTEwRIsZlz
	 4sjSMiIESK6+g==
Date: Mon, 18 Dec 2023 14:17:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12 net-next] qca_spi: collection of improvements
Message-ID: <20231218141747.2ea0105c@kernel.org>
In-Reply-To: <58b48448-2a6b-41bf-8b04-fdff3391aecd@gmx.net>
References: <20231214150944.55808-1-wahrenst@gmx.net>
	<20231215182518.081559ea@kernel.org>
	<58b48448-2a6b-41bf-8b04-fdff3391aecd@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Dec 2023 10:26:17 +0100 Stefan Wahren wrote:
> let me explain. This series shouldn't replace the already applied
> bugfixes. Before i submitted the bugfix patches, i prepared all these
> patches. Since the bugfixes had a much higher prio, i decided to split
> my patches into a bugfix and improvement series. The bugfixes has been
> applied and this series is the improvement part which based on current
> net-next including the bugfix series. Sorry for not making this clear.

It may be that you based this series on a tree which had the fixes
but the build bot got to it before the fixes propagated to net-next.
They have propagated now, please repost.

