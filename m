Return-Path: <linux-kernel+bounces-80243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C15862C75
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 19:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C328D1C20A9A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9A2199B8;
	Sun, 25 Feb 2024 18:06:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858CE168DC
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708884415; cv=none; b=EpkojnL874qMcnvNsErBwiI4WkDzhlT0OJmaDlXpCjltFx9ph1EhQ8b9EeqtJXw+wz5FLRBMjzgsfsrRJj3d0OE0sQKdq3nXxHH9f0+/tjouifGNCy+82ogTYWYLF4qm4h9TkZZOAjDtFh6Nqn0nJbX5zw0MGbW/tq6rjvn654Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708884415; c=relaxed/simple;
	bh=1vwoCATb3cdYG8UGyYM3cXwTnSqkYCkh6VXnjTZ+2Ok=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z98bI6Ro+GQwUcRcLoeiGJKb0pShij7dAJCU94u3EWavRWj7yI9mGrENFgQImDbvyOBi8EFhWOfLqdnD0s1b33lzlyxt3ML8saZNd5zuPXJQEI/2cNQl8pMeU2u0ShRTvL+yb16i23+eKqlp40XJaAX9oSbVXMoTO3wuZvgJ8Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013C2C433F1;
	Sun, 25 Feb 2024 18:06:54 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 4618E1060D21; Sun, 25 Feb 2024 19:06:52 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Sebastian Reichel <sre@kernel.org>
In-Reply-To: <20240221064112.9155-1-rdunlap@infradead.org>
References: <20240221064112.9155-1-rdunlap@infradead.org>
Subject: Re: [PATCH] HSI: ssi_protocol: fix struct members kernel-doc
 warnings
Message-Id: <170888441226.1906169.9832690822155413202.b4-ty@collabora.com>
Date: Sun, 25 Feb 2024 19:06:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Tue, 20 Feb 2024 22:41:12 -0800, Randy Dunlap wrote:
> Fix a typo in one struct member's name and add the @work struct member
> to quieten kernel-doc warnings:
> 
> ssi_protocol.c:144: warning: Function parameter or struct member 'work' not described in 'ssi_protocol'
> ssi_protocol.c:144: warning: Function parameter or struct member 'tx_usecnt' not described in 'ssi_protocol'
> ssi_protocol.c:144: warning: Excess struct member 'tx_usecount' description in 'ssi_protocol'
> 
> [...]

Applied, thanks!

[1/1] HSI: ssi_protocol: fix struct members kernel-doc warnings
      commit: 3693760295e8c8a1a88cb3da5b178959b3cc7c75

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


