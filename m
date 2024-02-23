Return-Path: <linux-kernel+bounces-78616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA638615EE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 507212855BC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5084B82C7E;
	Fri, 23 Feb 2024 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bWNEASGw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8894C81ACB;
	Fri, 23 Feb 2024 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702503; cv=none; b=sDqSm11VVT67STmoU+ttQpnwbBx/1PUbQ0khIybPzROD6EL+RxUSvOiG9smIQfgUi9MmvJe95X0ykzx/Z4Pq00vAaFZI755fCCaymYi/hVC9fdDTBlkvbW6x8Bi1PUUOjQTcFGLYH7kmRzFpfBn9eZW/92EYxTlHRcSm36UgCk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702503; c=relaxed/simple;
	bh=Y+IkG0oiTeitHrrVat8SqxL9FETJ/7QtxTWEM/mFQ3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hY0N7/9ZxDFk2GRxv3ysBzk1+ot7Kwi79xGsoCxEIV2kK1JwJEnkJm+3oFxpwXmC7eqa5Ps3HNBMnNq/8UKcN/GrQfkJvMnk/wEqd8ZWXOzsEFX6SC/rf41+bDZxqChOfQ7E8uueSN3vupVjtsdbI3CNzojPCIuGq6d99QjiynE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bWNEASGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5788C433F1;
	Fri, 23 Feb 2024 15:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708702503;
	bh=Y+IkG0oiTeitHrrVat8SqxL9FETJ/7QtxTWEM/mFQ3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bWNEASGwot/R2tSucLAD+VgTaf8BomIh2XCTAD2ha+SWbNxdp4CEH7QfL75TRgELR
	 aQuD4yxIBW5ZzSJbg9YVz+/AsXBTwQPycDv5JoCu05/nJsM6F78/uLgFWO7rqd8LgA
	 +ybBWDZEMVP1XLKoMGvZqvR16zVj55rNY8COqvd0=
Date: Fri, 23 Feb 2024 16:35:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Please pick up 3a9626c816db90 ("drm/amd: Stop evicting resources
 on APUs in suspend") for linux-6.7.y
Message-ID: <2024022353-drinking-gala-7ca2@gregkh>
References: <b743d91f-5e7d-4701-b515-5c2a84ebd291@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b743d91f-5e7d-4701-b515-5c2a84ebd291@leemhuis.info>

On Thu, Feb 22, 2024 at 10:04:15AM +0100, Thorsten Leemhuis wrote:
> Hi Greg! Could you please pick up 3a9626c816db90 ("drm/amd: Stop
> evicting resources on APUs in suspend") for the earliest convenient
> linux-6.7.y release? It together with another commit (91636168531909
> ("Revert "drm/amd: flush any delayed gfxoff on suspend entry"")) that is
> also queued for 6.7.6 fixes suspend problems that apparently bother
> quite a few people:
> https://gitlab.freedesktop.org/drm/amd/-/issues/3132
> 
> Both come from the same series (note, patch 3 of that series was deferred):
> https://lore.kernel.org/all/20240208055256.130917-1-mario.limonciello@amd.com/
> 
> Mario, who authored 3a9626c816db90, forgot to add a stable tag and ask
> me to send this mail:
> https://gitlab.freedesktop.org/drm/amd/-/issues/3132#note_2292543

Now queued up, thanks.

greg k-h

