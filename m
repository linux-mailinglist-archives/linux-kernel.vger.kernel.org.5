Return-Path: <linux-kernel+bounces-89003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3E986E951
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176A01C22979
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B454F3A1C2;
	Fri,  1 Mar 2024 19:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fVOVmw4q"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2970639FFE;
	Fri,  1 Mar 2024 19:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709320586; cv=none; b=LtYU2P34NCHoVRhM0RITh4HBlJ86wMfrppJtxo7agXm7jQoptUfuD44xPcpdQdVN/tw8+xg5CcTKQgIEJX1KwBUM/ZGV7Z+1HeoiuH0cwcikzX0w4NzpRWMXYLkwhqMSXRYHQNPc9bzDJvgMlarJ+gPtnogxZzgWaP1C0+uSK4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709320586; c=relaxed/simple;
	bh=1tH+/0HtvuQAYuoHuGNcArcs91C6bXXPjydLTO8LKKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHkiGeaOwfK7m3TgSvaGqLGNZD2Qen4edP2Wm8ygASyyPZjBC2BhLK7Rw8lQBx7UQCjY0YzX+2raq8VNj4UjHjCGY+m1KVPvb0YPgJDpnO5ClISNkkSSsiuFlKrDJebJyKsC2HolSmfoLReAVYCHKSj1CtGZnkFL/eOwpy1gvjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fVOVmw4q; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DDB1B40005;
	Fri,  1 Mar 2024 19:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709320582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z1FbQSUQ20nUcJFmh9wT7SYi4Z8ZAGbPrcTKTeQ4mz4=;
	b=fVOVmw4q96pErHwoxkMYx9eOLoW/MFjGLuDnWn/iDcjj3Ai1wN2URvY6h8DazCPgvNgqVt
	77TD5eYViLk2Iuc5emKKNJABI4PxxsoRbO5hROzKiLX7C32wX+T/Pz5T4szlWXZe1V7i3t
	ZO1lBu4gwxGDCLsyRoICsZmrmtB/7izgSFIoYE+QOp7XjRFxxtH9a2gItlKtBpB1qZkmMp
	liz6QrdHM9ncS/qhoBFkfa8PUm/WFBKcx6lLTuuyFsC+6rxalVij38CWD/C+jN80ZhDm1P
	PkgTPcYNoIKXWhDeRJmkE/6cVnq1ry1gYPfOHrXs9ivYzeQp71hlkjO8kUZhrg==
Date: Fri, 1 Mar 2024 20:16:18 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
	kernel@axis.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] rtc: Add driver for Epson RX8111
Message-ID: <2024030119161894871d18@mail.local>
References: <cover.1700491765.git.waqar.hameed@axis.com>
 <0c3e1b03f276da47b26ac50f5d0ddf5c67aabe5c.1700491765.git.waqar.hameed@axis.com>
 <pndcysep2d9.fsf@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pndcysep2d9.fsf@axis.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 01/03/2024 13:23:30+0100, Waqar Hameed wrote:
> On Mon, Nov 20, 2023 at 15:49 +0100 Waqar Hameed <waqar.hameed@axis.com> wrote:
> 
> > Epson RX8111 is an RTC with alarm, timer and timestamp functionality.
> > Add a basic driver with support for only reading/writing time (for now).
> 
> Friendly ping incoming!

Yes, this is definitely on my list of things to review before the end of
the week.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

