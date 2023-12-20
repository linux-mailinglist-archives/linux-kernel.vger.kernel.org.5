Return-Path: <linux-kernel+bounces-7324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD78D81A5B5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D479B22DF2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB2147771;
	Wed, 20 Dec 2023 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7KVYkhe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0194D46544;
	Wed, 20 Dec 2023 16:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CE5C433C7;
	Wed, 20 Dec 2023 16:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703091240;
	bh=O34EsK513kFHp7fAXRySvU2fS0ZbVOxsvU6nxPXlp9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h7KVYkheDrV2GSmecwZmWYAqc5lBZ66M2CJLxIwyvK0yNk/ewCmbsFAvcxsuhdTHJ
	 s2CJsxwkFljgzBD91jpBlUAmbQgMmWjpCO5fvz0cEv3SAfdM4bCOZp5dfFQqy91f0g
	 nycICGdJZ3zyPkroCKIfudXfnOM8Aktd7QECdbfmcDkERiZ0bBIvr7ftJdgV27ZH1D
	 mcLMiSvloX9NDzkO8f/SbNHuVssWQgmQf3ZFUlzoLgieu9wUSRI+ND8Iph9qVzcHKB
	 AKq+upneolXlCOGj/bQBzugj1CUPSARyN4JDmxIruNpHgNdhKwAJWN9ufnA7QA8nGc
	 d52UJaY2+ogNA==
Date: Wed, 20 Dec 2023 17:53:52 +0100
From: Simon Horman <horms@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: roopa@nvidia.com, razor@blackwall.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horatiu.vultur@microchip.com, henrik.bjoernlund@microchip.com,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] bridge: cfm: fix enum typo in br_cc_ccm_tx_parse
Message-ID: <20231220165352.GO882741@kernel.org>
References: <20231220075914.2426376-1-linma@zju.edu.cn>
 <20231220161742.GM882741@kernel.org>
 <55cdc6e4.49734.18c880f5a2f.Coremail.linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55cdc6e4.49734.18c880f5a2f.Coremail.linma@zju.edu.cn>

On Thu, Dec 21, 2023 at 12:29:16AM +0800, Lin Ma wrote:
> Hello Simon,
> 
> > 
> > Thanks Lin Ma,
> > 
> > I agree with your analysis, that the problem was introduced in the
> > cited commit, and that it is resolved by your patch.
> > 
> 
> Thanks for the encouragement.
> 
> > However, as there is no user-visible bug I don't believe this reaches
> > the bar for a 'fix' for Networking code. Accordingly, I think that
> > the Fixes tag should be dropped. And, instead cited commit can be mentioned
> > using something like "This problem was introduced by commit ...".
> > 
> > Also, as I don't think it is a fix I think it should be targeted at the
> > net-next tree:
> > 
> > 	Subject: [PATCH net-next vX] ...
> > 
> 
> Copy that. Yeah, once the enum IFLA_BRIDGE_CFM_CC_RDI_INSTANCE and the
> IFLA_BRIDGE_CFM_CC_CCM_TX_INSTANCE keeps the value 1, everything should work
> as usual. I will resend the patch as told.

Thanks, much appreciated.
v2 looks good to me.

> 
> > The above nits notwithstanding,
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > 
> 
> Regards
> Lin

