Return-Path: <linux-kernel+bounces-133039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4227E899DE7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0BD0B228C8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A176516D330;
	Fri,  5 Apr 2024 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ltlx3w2v"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2344516ABFA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 13:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712322256; cv=none; b=eTm+gM2QAI5yZWfA/qbCHtjMoUyc+wmC9OD7ofr9giGjACuwjvqCfOPkibIxT2MpBXpB/SfRgTOzokBZ/kBaui1ulvaAgfuxam/NTrmXrezYxbpjEfDsKggrsnUvI0N9vCL9UN8y+WeIecIxes5NCdKgaeArxNTFwOZ8LWnOdBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712322256; c=relaxed/simple;
	bh=Y7FhNkty0RG4vAetdYjkiZPH7ajVjh25aWBa4yvu+aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qALDvCKZtq4yycTMabSWB2CLEU1yt9xEjnVOB47kk8TZwsONXE2xlioiRPPdgLnXmRgQmHi6Rj3YM53WkV2s772qGKeWeKETwKB8Aqs+X2ch+T6AnNSgYAiVPjCw4AbxHbSs6FAZflFcqfhxdrm3nrebJuQ7c1XoTf1Emh0k36k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ltlx3w2v; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 14ACD2027B;
	Fri,  5 Apr 2024 15:04:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1712322244;
	bh=l7CqLckDLbgqOsa5j//MSRXiFTqbO5DRUoXwQ6kAxls=; h=From:To:Subject;
	b=ltlx3w2vw3Y+QWe1kOtgzo7BfRzUla8vaHq4YMv9qw2AUtt6fmMGbdFvqOK8LDRyi
	 T58fmgOad+HwY0S1XAOFI9b0EawRz6A40OTrTGbdMzqkSwAchh1KzxdG/db3r7Qvfl
	 /W9DSR+fTbtnEEfPo8koKpoHoKZZvY2EVd6flsP5lD5xW2RNbSNH8uVmQGQUm1QGe7
	 1GPGAHek+s3BFLEoPTfM0M0zDnSuQeGo4w8fe1Imo53XOx/zEGoJ0E+M0vJ5tyHWUf
	 Q0BZ2o5vbnZVs91k2Xkau32pQKhQ9NS4RUPVsHBIiLIn3eOUvjIAgkLoXWUdXtWMlx
	 nGO9TVFcS9+Wg==
Date: Fri, 5 Apr 2024 15:03:59 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Flavio Suligoi <f.suligoi@asem.it>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mtd: spi-nor: everspin: add em004lxb entry
Message-ID: <20240405130359.GA308940@francesco-nb>
References: <20240405100104.480779-1-f.suligoi@asem.it>
 <20240405100104.480779-2-f.suligoi@asem.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405100104.480779-2-f.suligoi@asem.it>

Hello Flavio, thanks for your patch.

On Fri, Apr 05, 2024 at 12:01:04PM +0200, Flavio Suligoi wrote:
> Add the Everspin EM0004LXB 4Mb (512KB) Industrial STT-MRAM Persistent
> Memory.
> This device is JEDEC compatible (JESD251 and JESD251-1), but it is not
> able to provide SFDP information.
> 
> Link: https://www.everspin.com/file/158244/download
> 
No empty lines in-between tags

> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>

Francesco

