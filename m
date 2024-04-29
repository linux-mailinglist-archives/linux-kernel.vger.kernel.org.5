Return-Path: <linux-kernel+bounces-161875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5A58B5292
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F8C1F2188D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C6A15E85;
	Mon, 29 Apr 2024 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VlvZq9PS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E40A13AC5;
	Mon, 29 Apr 2024 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714376978; cv=none; b=Qmbyb46QA6QGmg81hAMPAR+z7Pg9O1GZ9G3fxQY/KMrB5IfW2VS8X2wmg7FdnDX6THVuR3IQbwnU/PIcmkDlValDY4QE6NMIDIM3nfv+RC/hVduEBM0YsRkIk8mSM1gSFVbCJHMMgq8fnAssuV+uIAyJDjbwfuO64VKgpmELq64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714376978; c=relaxed/simple;
	bh=gEosSce1MTpVL0/P/pH+7d6wYVTwCsLQEfjzImosiUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9QLmJKKrjaNrBw+b23RCgFHHqD20buKLze4RXXVIWU/UC8Ayk9ex9xaAkMRX4kIz+1Sk9K6o8q+qMKw8coZqV3Ked8E0/mhn+Xs2Fqs37pi5ZM6zWfx62RT2g0GjrcKIWwVipeXGooSk4RZXUEZ6d5ScJy4/DzcCZv/cjq9E5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VlvZq9PS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8A3C113CD;
	Mon, 29 Apr 2024 07:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714376977;
	bh=gEosSce1MTpVL0/P/pH+7d6wYVTwCsLQEfjzImosiUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VlvZq9PSU5XtqUpmkpl2VJ8DaeHmZCmER6FjQm15komfPMEX0F3d5Ez7CgesNAXMe
	 a9GEsGGx+C3cvEEOqf2RN87Crt6+QWJQHiE39ih0MZ49YNGyYYhfCRLpJo8fdBYQA+
	 As7wwgnUQRmE9Lw96lQMaLf3r8sTsPtjg2tF8dR0=
Date: Mon, 29 Apr 2024 09:49:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] docs: stable-kernel-rules: remove code-labels
 tags and a indention level
Message-ID: <2024042929-tabloid-slot-db77@gregkh>
References: <cover.1714367921.git.linux@leemhuis.info>
 <755afbeafc8e1457154cb4b30ff4397f34326679.1714367921.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <755afbeafc8e1457154cb4b30ff4397f34326679.1714367921.git.linux@leemhuis.info>

On Mon, Apr 29, 2024 at 09:18:28AM +0200, Thorsten Leemhuis wrote:
> Remove the 'code-block:: none' labels and switch to the shorter '::' to
> reduce noise.
> 
> Remove a unneeded level of indentation, as that reduces the chance that
> readers have to scroll sideways in some of the code blocks.
> 
> No text changes. Rendered html output looks like before, except for the
> different level of indentation.
> 
> CC: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

