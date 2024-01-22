Return-Path: <linux-kernel+bounces-33843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3870836F61
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8E31F2DFDD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F7D679E1;
	Mon, 22 Jan 2024 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cdIuu2Ke"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E2F6774B;
	Mon, 22 Jan 2024 17:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945131; cv=none; b=blXJjEvt7Dy8CB4XmzgPUUEGt7wN0qerVqBvEHyHEqMH36WSI8XsgguWpRtDxn0RMgmjiLcjYy0BR7WIfSfaRb125v2Fh+d82W3bHJ8MUieGw8HzNC1OFupSSMjTKq7zS2QHyDzQC9F6cfYmRRjiuuu5UgMMoUP/5uuii7KnM1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945131; c=relaxed/simple;
	bh=osetr/RF0GGgGKW4GzsL+42PUCnQki874N2xFzDoVX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDuwIcRc15yh3VYwOQBJfm9nYFwScIXWTFz7oqcXq7nKL5CQ6F8w8cgNQlQzTWUmBDhXm68rx9JVI7ffxbJw14QspsasNHZSXdSdb93cBrWZgB8Ce+geDWPcyFLqkk9nELQXzuXfh+LvpqILlusukj0XvczmT6qZPWxMH4SBn04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cdIuu2Ke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2AEC43141;
	Mon, 22 Jan 2024 17:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705945130;
	bh=osetr/RF0GGgGKW4GzsL+42PUCnQki874N2xFzDoVX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cdIuu2KeuOP0JlY9XSvXRM6T/NOqxisF5vTDpqbVUKmaZgaOU3fk3dRilGNaDaZQM
	 Dk5WBHyLVAi06JTuOs/W/BFdagb9Y9CjZclScMQtCPODHU7R1QXM5AUJuvhIAGxXYr
	 usaMTe4tfjOVzmsEMIN+F4jgNXY+9JKzt/I3SzFo=
Date: Mon, 22 Jan 2024 09:38:48 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input - 88pm80x_onkey: add SPDX and drop GPL boilerplate
Message-ID: <2024012239-paddling-abdominal-3e68@gregkh>
References: <20240121-88pm80x-onkey-spdx-v1-1-b646d4749f5b@skole.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240121-88pm80x-onkey-spdx-v1-1-b646d4749f5b@skole.hr>

On Sun, Jan 21, 2024 at 10:11:00PM +0100, Duje Mihanović wrote:
> Add a SPDX-License-Identifier to the 88PM80x onkey driver and drop the
> GPL boilerplate in accordance with current kernel code guidelines.
> 
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
> ---
>  drivers/input/misc/88pm80x_onkey.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

