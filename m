Return-Path: <linux-kernel+bounces-45552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BE584324A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C071C24EA6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E482DA2A;
	Wed, 31 Jan 2024 00:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iv1hKx+s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE8D363;
	Wed, 31 Jan 2024 00:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706662510; cv=none; b=J7JXEhyfBiV/rDVgpdgV+DRAMQRHqMlZS4cdQtLR1cUvDF911yqpKEcH0Hmg/s+767boRB6KB8gSVP9ZVC/F2ySOXEh9jMZ8hJYsk3K6LR277Fod+3Y7joj8VVDSC6/BPh2nLRDaSlKOJlQu84+9QVgAUl/nBG57x4qtCAsFyZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706662510; c=relaxed/simple;
	bh=78tiHemZiSA+aMBr76TtZYvrQGw/LWB7nLfaC/AriSM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QbMrR/je6ecv95fJgW+vMGfuOrZN5nF4Zkyb4cCqBVKwc5lDgVZ+lsyiGOHlwiz65W8FPNfdrvxTtcjOuDRPp4ATEfi0big8tVoisQeioFfVkTxtyyu1dRbnYQ2fOfVQWYOsicRPNIJB+7siU5rJVrm4gUZa2hCfrafNl39Ifdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iv1hKx+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4D1C433F1;
	Wed, 31 Jan 2024 00:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706662509;
	bh=78tiHemZiSA+aMBr76TtZYvrQGw/LWB7nLfaC/AriSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iv1hKx+sqeCBfJJZzCrcsJeCMxaMKP5ymWUDhn9wupVviYotaNb7h+WUromHrzyLH
	 I+YHypZnI/kg7JcdiIl4fvAhpxNk22HpdEgrn43Vrb3uvODbWZ8h4xuLxiWJ9wopa+
	 lNVaJk6R5XfecoBKouw8VtotrV+Tm2S0ND7kmiif5yZLAsAnP5Tw5QRmHkl0B5s1UV
	 AGBT726SaK0tImKfW07zj8RTVZZENf2SdaYr3C7rLy5vslmCK596ip/H6gS4ejXpK7
	 VTBVp2mnaTz/AohHgQpAFVmB9RpAlDn6BWdIWIbGCSTM0h00M2rTmBhbE+5jWyE/xJ
	 QzWC76uhedEjA==
Date: Tue, 30 Jan 2024 16:55:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: wangkeqi <wangkeqi_chris@163.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, fw@strlen.de,
 wangkeqi <wangkeqiwang@didiglobal.com>, kernel test robot
 <oliver.sang@intel.com>, fengwei.yin@intel.com
Subject: Re: [PATCH net v3] connector: cn_netlink_has_listeners replaces
 proc_event_num_listeners
Message-ID: <20240130165505.446bd37f@kernel.org>
In-Reply-To: <20240124114437.160930-1-wangkeqi_chris@163.com>
References: <20240124114437.160930-1-wangkeqi_chris@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 19:44:37 +0800 wangkeqi wrote:
> Fixes: c46bfba133 ("connector: Fix proc_event_num_listeners count not cleared")

The fixes tag should have 12 chars of the commit id, could you fix 
and repost?

