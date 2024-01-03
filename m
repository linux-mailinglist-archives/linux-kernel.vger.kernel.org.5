Return-Path: <linux-kernel+bounces-16052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 685B982377F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83EA0281860
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C201DA52;
	Wed,  3 Jan 2024 22:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5/I1PIp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0028D1DA2B;
	Wed,  3 Jan 2024 22:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0447AC433C8;
	Wed,  3 Jan 2024 22:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704319775;
	bh=6ljWwcMuOclalShz7xItPE1LxMgLaftfxHmnUv3zwQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t5/I1PIpxUdoWV28a/IV0bFPmk4b+1rKFQAkinmjP+UyOCAV+Lz+FNEdLTCSHwAqO
	 n2/RUdbmvRLe6ReURSNZIzMBShj61jEU3oHgCNItdjzYEEkc9upaVdE/J+xwPuYC4A
	 hcrrN+bXntXeHf+Uh7m0ZPaMGrmXDkk7ghE29QMjx5wBRihoreUJPTfaL/1hneZJBm
	 Vu5Xfpx1cua6A9glQCMgAqbu4RoEV3y9xb0j7PWJ+L1XF2TD5cYogb5K98Br+ukWlX
	 wjo1irToxruuubn8dcFh5PRAQPLIbOnzzyAbvfTXRYZIE8p0GT/etMen98msZpfEA6
	 EuAIcn1uQGygA==
Date: Wed, 3 Jan 2024 14:09:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas Lange <thomas@corelatus.se>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, jthinz@mailbox.tu-berlin.de,
 arnd@arndb.de, deepa.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net] net: Implement missing SO_TIMESTAMPING_NEW cmsg
 support
Message-ID: <20240103140934.2a6c6924@kernel.org>
In-Reply-To: <d1ce6aba-1b10-471c-ba60-10effa1dac10@corelatus.se>
References: <d1ce6aba-1b10-471c-ba60-10effa1dac10@corelatus.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jan 2024 22:13:50 +0100 Thomas Lange wrote:
> Commit 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW") added the new
> socket option SO_TIMESTAMPING_NEW. However, it was never implemented in
> __sock_cmsg_send thus breaking SO_TIMESTAMPING cmsg for platforms using
> SO_TIMESTAMPING_NEW.
> 
> Fixes: 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW")
> Link: https://lore.kernel.org/netdev/6a7281bf-bc4a-4f75-bb88-7011908ae471@app.fastmail.com/
> Signed-off-by: Thomas Lange <thomas@corelatus.se>

patch looks mangled, could you resend with git send-email?
There are multiple spaces at the start of the diff lines.
-- 
pw-bot: cr

