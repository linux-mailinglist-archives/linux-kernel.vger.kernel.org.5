Return-Path: <linux-kernel+bounces-48783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7EB846138
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE971C2493F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BE085297;
	Thu,  1 Feb 2024 19:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOSadR/a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202DA127B47;
	Thu,  1 Feb 2024 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706816602; cv=none; b=Xvl9tnSIixqW/3HcPzjULS6UHp99IddQNTtUlwJVqkT+uM0iddyjwLUhiXSYHuBHQrYckT/cGosX13FJF7vdtDSIVf4VCcVqc8Wzw/uWf3Q2Wx2lBgTlmRsac8vDbRl3WEFB9onyMZtQlOZsB30yLIIJ0VB9Iwx9733vf91Fk+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706816602; c=relaxed/simple;
	bh=R4rK6MPXPx93cZ0GZWk0zlDLWoZA1p29HyxEOOWznxc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pi+FIbqb3ndSjVSUMmkogjayCTU2GwpNWtN8nd+tEN7z2gZQunoOstzSKZou3p6Uj80bsOHcIugkhGQoDwat8FZkpEUronYOUS5/KfP2oOrB4Y0v+XImTovR1RlfbiEn5vfU2AkWp1ihGtTp3ItUpGx0T2n5AS5cNTcJWoGap70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOSadR/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD1EC433C7;
	Thu,  1 Feb 2024 19:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706816601;
	bh=R4rK6MPXPx93cZ0GZWk0zlDLWoZA1p29HyxEOOWznxc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fOSadR/a/KN2UhE9P8pfXfAyXB/48blVSXd9TT6IB9BGZBMccTh5gsa4BMTvAg9aC
	 HRbB9bav3P2ZMHHMZW/bAkMqkfskZgPyAR8SZxBUafssKVhMrWQINCussyUC9ISiRk
	 0zdNgbV+TMNc8LC1BzGtoitTFQTepSNj21EThRebSHzChs6IZDdB0VyWHyi2PrY7RL
	 Y801DoBQH86Ov3GxkTT0bI4gbv1un7ANCCF9GTWffiV8WqiS8zZ8HcwGApzyjLyhes
	 Qztw06uECzZsU2/SU76BKBl0xkZOUOrpfxLkM0r1r+8EY/jcbmEUmAGEIeTSEdwKWe
	 JrSb/El2YNO4g==
Date: Thu, 1 Feb 2024 11:43:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] net: dqs: NIC stall detector
Message-ID: <20240201114318.72eb52e1@kernel.org>
In-Reply-To: <ZbvnTNT28EpoGSdU@gmail.com>
References: <20240131102150.728960-1-leitao@debian.org>
	<20240201081432.3fa70c6c@kernel.org>
	<ZbvnTNT28EpoGSdU@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Feb 2024 10:47:40 -0800 Breno Leitao wrote:
> > Let me take this on in, but the other one is not a fix,
> > so it has to go to net-next.  
> 
> Sure. I didn't know how to split the dependencies. Maybe I should have
> sent both of them to net-next, and you would cherry-pick the fix to net?
> Is this a better approach for next time?

You gotta send the net part and then wait until Thu afternoon Pacific
time when Linus pulls from us. We then pull net (and Linus's tree into
net-next).

