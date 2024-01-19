Return-Path: <linux-kernel+bounces-30800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5B2832476
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1EC284B75
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442878F56;
	Fri, 19 Jan 2024 05:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mBV7Pnf4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B89E6FA9;
	Fri, 19 Jan 2024 05:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705643808; cv=none; b=DA436hINmjL4A8GhsDrDENlLMb1T66f+F9WiVG7rqYBMIjj/ip+fcKSeMyncYWKFxWvPIcakl6kJMoPL8uJVhKxK4QNFiCxYs7L/AqX7UqHNYYaKafK3MA6VrbVElb7vw/cTyFLAzRrxdlknAYuoebPSCkHSP+jIb1VYM16nS58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705643808; c=relaxed/simple;
	bh=GHp/LVeYbNckA6glie6uml48GbDPdzeBCK7XIfWvSRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFMIKN65xNy0Bd6iPUQ0yj7ENUz2l7oipQT3v/BazeNDwy1D1EqlvxdPfs71K3+sraPxDQ8E9jC5xS6ES0/pRIyhRYdRn7BDiUsMs6ZHAcb/F65KBi86HQoj7QHb5e3PDuiLvyNexWyadxU1xSIa0fuafuFJ1STnP41RoisUMuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mBV7Pnf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D42C433F1;
	Fri, 19 Jan 2024 05:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705643808;
	bh=GHp/LVeYbNckA6glie6uml48GbDPdzeBCK7XIfWvSRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mBV7Pnf4Xqmd3kdC9VpjDcT/Kkzm4U36MZTwPSI4TZsIkTSAhl7rHGcK0n1JbEYZb
	 LlpEj01iCVO2wABWHlAvj5eD2ey9JuWMY4Oo13QmgoIPPQd9s2n2nTWbLtA+YkFa6m
	 muTp6jb1T+cPLggCIG92tP2XsOE1HAqafrcoSvAc=
Date: Fri, 19 Jan 2024 06:56:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jacob Lott <jklott.git@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: rts5208: Add more details to Kconfig help
Message-ID: <2024011908-devotion-default-d404@gregkh>
References: <20240118191425.88826-1-jklott.git@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118191425.88826-1-jklott.git@gmail.com>

On Thu, Jan 18, 2024 at 02:14:26PM -0500, Jacob Lott wrote:
> The current help text is short and triggers a
> warning from checkpatch.pl. This patch adds more
> details to the help text which should provide better
> information for whether or not to enable the driver.
> 
> Signed-off-by: Jacob Lott <jklott.git@gmail.com>
> ---
> v2 -> v3: Fixed spacing and newline in text
> v1 -> v2: Corrected line spacing based off feedback

I see multiple "v3" patches with this subject line, they can't all be
correct, right?

Please always increment the version and say what changed when you send a
new version, so please send v4.

thanks,

greg k-h

