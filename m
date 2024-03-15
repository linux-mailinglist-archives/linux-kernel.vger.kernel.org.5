Return-Path: <linux-kernel+bounces-104133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D94087C989
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDAE128366D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB71614AB8;
	Fri, 15 Mar 2024 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7coXQ5b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24E71426E;
	Fri, 15 Mar 2024 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710489693; cv=none; b=fQgRtM5UmxWovovs9zwsLVH1JDX5xeKDa0urhSg3uEX381BNeO1iSFMOA/8eszQEe8uPvJ9Y50gmYRwp2slmQRgQ9iV2efni+sGwtH3dBrtrT10sV6yNzVLDrMT7yuvChSVblqud4iEeE7leHE+NwkeqcezoyoI65Lfaw2PPhGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710489693; c=relaxed/simple;
	bh=PbfTZHsdENp14D3ovvidJYfMH17kDutf9n4cQyx8ox0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrzZ5Hf3LScACMXBGaOUoKC/hbtLbGy39PCGlb71zZ+0xt+oWgBfd7SXG1X/1Lvn1wLvOeOmvNOUV8L3pG0EpVVQ0Tmx06QHq0nvF9XLU3Iwl/B7Lh+G3/I/YeluH13Ms1/TCyTziWIXSvpST0xMISh2d6JQ4JBsttxQ4uiGZbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7coXQ5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68149C433F1;
	Fri, 15 Mar 2024 08:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710489692;
	bh=PbfTZHsdENp14D3ovvidJYfMH17kDutf9n4cQyx8ox0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G7coXQ5b54VgdvnYDcpTmho63RMgSvh+gH59wZrrzZ9+h4CZl36BS63F8qZc/s/lg
	 NAhNDnIKCI8xPyXd6Xo6zku/rT8xaQSC911N22l78wLy5ErP1kFSq4kmujJzRwSguJ
	 RMaV7PCBdqwsfD7C84m08pZD2kZfMCfMnzWkhBbDqRuK+Qv4TAlP7VsMXCZ+SWEFn8
	 KiJ/c19OkKwNvBB9gmNh+J+jikwPr8RtfWgT5vscVNmpfcMhBJxlZj9qwy1EzfBPEL
	 mMqm/wb28HHMKR1zl9PDjy4rRRrVpTvGKUWKbFRaVQKCc70d9tPJhQ0yxRqrMmba3N
	 5LTPjSjVqQzWA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rl2VZ-000000006XA-0BOB;
	Fri, 15 Mar 2024 09:01:41 +0100
Date: Fri, 15 Mar 2024 09:01:41 +0100
From: Johan Hovold <johan@kernel.org>
To: Cameron Williams <cang1@live.co.uk>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CH341 RTS/CTS flow control disabled in driver?
Message-ID: <ZfQAZdMwQENJ_yMC@hovoldconsulting.com>
References: <DU0PR02MB7899EC8515D8FF35B4D01465C4292@DU0PR02MB7899.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR02MB7899EC8515D8FF35B4D01465C4292@DU0PR02MB7899.eurprd02.prod.outlook.com>

On Thu, Mar 14, 2024 at 10:13:03PM +0000, Cameron Williams wrote:

> I am wondering if anyone knows anything regarding the RTS/CTS lines on
> the CH341 (maybe CH340 though I have no chip example).

> From my tests, neither of them seem to have RTS/CTS respected, and I
> don't believe they are fake?

> Is this intended behaviour? Looking through the source I can see
> RTS/DTR should be supported, but it just doesn't seem to work.

The driver does not implement hardware flow control (CRTSCTS) so this is
expected behaviour.

Johan

