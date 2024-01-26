Return-Path: <linux-kernel+bounces-40032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AECDC83D91D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4026328FB7D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E59C1428E;
	Fri, 26 Jan 2024 11:13:40 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB39114265;
	Fri, 26 Jan 2024 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706267620; cv=none; b=m71psqQfJvnpc2bZCLUcx3qbCRBvBOF22u/dLxqpFBd8ecc9yVHK4xSfem1NsNLeaoMum7vQoSnR1aTpWLrpaSMrvaf3QTgOHR11Yk0H/JsBQgBWmHzbAenXdxsvT5GlUUKNMDX+22nsW+9VTdal8PJPktb+tiQguzY2LPAYBj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706267620; c=relaxed/simple;
	bh=jGDy/ExQ9KXSD8GVgrenJ6ULnNeyrgvAd+WtjdyqmR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P4eRaHvjCoLtAwKStYiKLFINCD77E8lEuCvBOp2bt7tTV2a00hRwuQ4fbzxDFPjnDv+pjSRw69RQ3sYPJ8gL/Eo7cSULc0jULfANZF7q4i/rOxCXay9J4eY4JrCm34PVTkfmcYCaOQujpD13m/AGzVcwyGIWYHcEu0J5UzJ8II8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1597761E5FE05;
	Fri, 26 Jan 2024 12:12:34 +0100 (CET)
Message-ID: <fb90ae9c-1f83-424c-878a-8b7e472bb6f0@molgen.mpg.de>
Date: Fri, 26 Jan 2024 12:12:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v3] ethtool: ice: Support for
 RSS settings to GTP from ethtool
Content-Language: en-US
To: Takeru Hayasaka <hayatake396@gmail.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 vladimir.oltean@nxp.com, linux-kernel@vger.kernel.org, laforge@gnumonks.org,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 mailhol.vincent@wanadoo.fr
References: <20240126045220.861125-1-hayatake396@gmail.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240126045220.861125-1-hayatake396@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Takeru,


This patch was sent at least four(?) times to the mailing list. Could 
you please sent a patch tagged with [RESENT] or a v4, so there won’t be 
several replies to different threads.

One nit below:

Am 26.01.24 um 05:52 schrieb Takeru Hayasaka:
> This is a patch that enables RSS functionality for GTP packets using
> ethtool.
> A user can include her TEID and make RSS work for GTP-U over IPv4 by
> doing the following:
> `ethtool -N ens3 rx-flow-hash gtpu4 sde`
> In addition to gtpu(4|6), we now support gtpc(4|6),gtpc(4|6)t,gtpu(4|6)e,
> gtpu(4|6)u, and gtpu(4|6)d.

Should you sent another iteration, please do not break lines, just 
because a sentence ends, and please add a blank line between paragraphs.

[…]


Kind regards,

Paul

