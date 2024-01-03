Return-Path: <linux-kernel+bounces-15002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 134DF8225FC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5CCB1F23556
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4017F2;
	Wed,  3 Jan 2024 00:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjFO8qqT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2761E10F1;
	Wed,  3 Jan 2024 00:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B830C433C8;
	Wed,  3 Jan 2024 00:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704241919;
	bh=QWNowa2oLua+8EbtoLNIa/jV3oGUNOpVr5rVsiDkrIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tjFO8qqTrEjFSCBWpC6TdPyJQtXnqZzUI6b2rDtfuOfryghXRL5gAt8cNWdUiCLKJ
	 pzDtR6ahEzoD9xYn6eBwIDmmVO7QH6NAlkRgYYPaPfQXb+CXAWK8hiJ4wAc0qj6CH+
	 QzXMua8c6qmX6wimgKmdmvpvgBJrdEYJYAC2YFiPmIeHIp6lZVyAuZwGpO8zZlwXZE
	 Ps4g39Jm75beo6bz6efm5cMq6p2lazxAdEk9/Nsb23NctbuZArNQrAZ50fcPM0WoA/
	 lXtGAFmAlaq7DAgp3DKe6g3R5+ORMgAJoZ5AJUIYTWyqKFg2nxu/zhkuu92Aqhqg20
	 06gekhnSPomzw==
Date: Tue, 2 Jan 2024 16:31:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mdio: get/put device node during
 (un)registration
Message-ID: <20240102163157.6148c2a4@kernel.org>
In-Reply-To: <CAJq09z61JRNOBy6zLJ+D2pOVP-FCkofLjNghHSOkFJ=5q=6utQ@mail.gmail.com>
References: <20231220045228.27079-2-luizluca@gmail.com>
	<ZZPtUIRerqTI2/yh@shell.armlinux.org.uk>
	<CAJq09z61JRNOBy6zLJ+D2pOVP-FCkofLjNghHSOkFJ=5q=6utQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jan 2024 18:57:35 -0300 Luiz Angelo Daros de Luca wrote:
> > I also notice that netdev have applied this without *any* review from
> > phylib maintainers. Grr.  
> 
> Some reviews are required. Should we revert it?

Reverted.

