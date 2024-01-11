Return-Path: <linux-kernel+bounces-23677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8068782AFED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163FB1F21DF8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8EF32C7F;
	Thu, 11 Jan 2024 13:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KR2PdDhf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0082328386;
	Thu, 11 Jan 2024 13:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D41C433C7;
	Thu, 11 Jan 2024 13:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704980839;
	bh=JZZxwbADt4SAYqk+/B42llcSHjjre9lpVmBkx5gIPgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KR2PdDhf7NQ0h402rrdyMOkfpRxPtX0zGqA/biqBAxErIi0kO9Rj1anHl/G+OP6EU
	 F408OHT++2c2FNR6EHhnTYJMVSL9Rx3cLhSQP3JTB6X3Rs5/LIWPdrzmAFKu3i9Wki
	 T+NeDYqNDzNlMo2WW0aufLyTm6PXwI60+2mERybBUAngCu5dC7H7IikbxuIXxXp1lN
	 8rsWIdmCdKgYrjaVE+RSOH8X6vG1YdhiXM+smLoYWAeXPbyDZo8GQSTqOOCtl5zVIP
	 nqH8DNXImXaqFu6DMg7GHcs9NfPbsa7uZxK25HEMiS/uKp8QhHF178sX7POVS9EzhS
	 V/+OGDXtqps2A==
Date: Thu, 11 Jan 2024 13:47:14 +0000
From: Simon Horman <horms@kernel.org>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kunwu Chan <kunwu.chan@hotmail.com>
Subject: Re: [PATCH v2] net: dsa: vsc73xx: Add null pointer check to
 vsc73xx_gpio_probe
Message-ID: <20240111134714.GA49298@kernel.org>
References: <20240111072018.75971-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111072018.75971-1-chentao@kylinos.cn>

On Thu, Jan 11, 2024 at 03:20:18PM +0800, Kunwu Chan wrote:
> devm_kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
> 
> Cc: Kunwu Chan <kunwu.chan@hotmail.com>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>

Hi Kunwu,

This seems to be a bug fix. If so it should have a fixes tag.
Perhaps this one is correct?

	Fixes: 05bd97fc559d ("net: dsa: Add Vitesse VSC73xx DSA router driver")

And, be targeted against net (as opposed to net-next)

	Subject: [PATCH net v2] ...

It is probably not necessary to repost to address these minor issues,
but please keep this in mind in future.

The above notwithstanding,

Reviewed-by: Simon Horman <horms@kernel.org>

