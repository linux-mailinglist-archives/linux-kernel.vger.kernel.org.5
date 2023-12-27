Return-Path: <linux-kernel+bounces-12032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB97181EF1D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 558AEB20DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 13:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D8245023;
	Wed, 27 Dec 2023 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fY+uziUA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C41A446C6;
	Wed, 27 Dec 2023 13:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A0F4C433C7;
	Wed, 27 Dec 2023 13:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703682625;
	bh=/jsWEPfzeo0DxCOUj3q2rwi1CbPQUhzjHOz5xIFG8uY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fY+uziUA8JOkaA3P+LSDCmuJMy4n5M6CSiVFeQ+2ojamq24ltnqdg8+T/u9hGug2n
	 snhuNv/hVbA6w8tbeAjbcklbptVdwuZWkgnwm+4zkrWRvTXSuVMhiKmnv8vIYgywtd
	 wNQ6LCJRJP4d1ZRsJH+gPfvxj3TNuBfQXgwIlaHp12B318o9a5Zbubv6l9fc6gJdGD
	 OeDdRMZcmJ0E/ZkBmgf/vx6u0SfE86R3NJ7Gm0xm2+jBQMvpKpajFujVXSyQc4hc87
	 d4p1KxRSyCj4f1peOZH4UPfTq5IATm6D3GCEK4G3R9nyR9TOXMc3lV+Tk/bvW4fH6M
	 NKj3d332WxRfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65DD6E333D9;
	Wed, 27 Dec 2023 13:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 0/9] Add MACsec support for TJA11XX C45 PHYs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170368262541.3726.479057551410543516.git-patchwork-notify@kernel.org>
Date: Wed, 27 Dec 2023 13:10:25 +0000
References: <20231219145333.240323-1-radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <20231219145333.240323-1-radu-nicolae.pirea@oss.nxp.com>
To: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Cc: sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, richardcochran@gmail.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 sebastian.tobuschat@oss.nxp.com, andrei.botila@oss.nxp.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Dec 2023 16:53:24 +0200 you wrote:
> This is the MACsec support for TJA11XX PHYs. The MACsec block encrypts
> the ethernet frames on the fly and has no buffering. This operation will
> grow the frames by 32 bytes. If the frames are sent back to back, the
> MACsec block will not have enough room to insert the SecTAG and the ICV
> and the frames will be dropped.
> 
> To mitigate this, the PHY can parse a specific ethertype with some
> padding bytes and replace them with the SecTAG and ICV. These padding
> bytes might be dummy or might contain information about TX SC that must
> be used to encrypt the frame.
> 
> [...]

Here is the summary with links:
  - [net-next,v9,1/9] net: rename dsa_realloc_skb to skb_ensure_writable_head_tail
    https://git.kernel.org/netdev/net-next/c/90abde49ea85
  - [net-next,v9,2/9] net: macsec: use skb_ensure_writable_head_tail to expand the skb
    https://git.kernel.org/netdev/net-next/c/b34ab3527b96
  - [net-next,v9,3/9] net: macsec: move sci_to_cpu to macsec header
    https://git.kernel.org/netdev/net-next/c/b1c036e835b6
  - [net-next,v9,4/9] net: macsec: documentation for macsec_context and macsec_ops
    https://git.kernel.org/netdev/net-next/c/eb97b9bd38f9
  - [net-next,v9,5/9] net: macsec: revert the MAC address if mdo_upd_secy fails
    https://git.kernel.org/netdev/net-next/c/25a00d0cd691
  - [net-next,v9,6/9] net: macsec: introduce mdo_insert_tx_tag
    https://git.kernel.org/netdev/net-next/c/a73d8779d61a
  - [net-next,v9,7/9] net: phy: nxp-c45-tja11xx: add MACsec support
    https://git.kernel.org/netdev/net-next/c/a868b486cb88
  - [net-next,v9,8/9] net: phy: nxp-c45-tja11xx: add MACsec statistics
    https://git.kernel.org/netdev/net-next/c/31a99fc06b0b
  - [net-next,v9,9/9] net: phy: nxp-c45-tja11xx: implement mdo_insert_tx_tag
    https://git.kernel.org/netdev/net-next/c/dc1a00380aa6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



