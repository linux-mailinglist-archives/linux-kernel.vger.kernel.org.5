Return-Path: <linux-kernel+bounces-131711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 767C5898AF6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304472828D8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4579129E8D;
	Thu,  4 Apr 2024 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2J8lZEq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032FA1D543;
	Thu,  4 Apr 2024 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243974; cv=none; b=TQNIPIWDZqffO1US6wDjcZGfo9oz0I+l30Fr0Ro9UkVd9qoJmh4sq7nBeKd9++rddEj4N7BFjkf7DFgMB292ZM5BAR/YIrnngXouqE2AnKJYE84WWOuzMLvaHep8Q/qANcnQii1xRVDIAvJ6xxZ9J/zrUhHMpTwsqEueRvnnmXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243974; c=relaxed/simple;
	bh=N2aRhl/uUiX8E0fhGH4TUM+0DjdFPuShM7bPcgye5fk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CdN8B5SgjRCxUxaOMQubj4yHl7TUONq3rpL/W/ckltH6ADTkLD5G72y0PunqS01vSx/XdyCnv/bKM0cZpJHfua8wG3aADpGqSMFSBf6+S7mRp86B56utgAv5McbWTh8wHkbxBbQRdE5NPyYQ9LXitGByhrHY34FYdaiVByvMINQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2J8lZEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91596C433F1;
	Thu,  4 Apr 2024 15:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712243973;
	bh=N2aRhl/uUiX8E0fhGH4TUM+0DjdFPuShM7bPcgye5fk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=W2J8lZEqEBLgegQ8BtBuxH3JQtSUCrV+ALCGuv8PazmsEw5+lTArpWKeoGPWIYHSu
	 df0iUkEQLNtSl93snfVXqUAFntnTI5IQCtXI0S5AVgaH3K80vPmwFXlM1uGWwy7vlB
	 yCQVxQ6ukJo1zfm0X6Jpb57aLBhE6Fr9eN80ahJAOy4RKnXKepndIkMOY+eGu/1DV8
	 9Sbd3995gE2dIFBVt9CQE2I7Oq8VVYyHCq+L5dLcyFYxJ9D9VEGHxZ/zhjZpL3xA22
	 RIICNNaKoCbnnRkAnLo7kLRJNMwySq/vRYmjX83k6KdElPI6oxd7Mupv8E81ryfnER
	 06UwLHr8/ANdg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Apr 2024 18:19:31 +0300
Message-Id: <D0BFTX8EX1S9.IDOUIUSJ0W51@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, "Arnd Bergmann" <arnd@kernel.org>,
 "Heiko Carstens" <hca@linux.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] char: tpm: handle HAS_IOPORT dependencies
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Niklas Schnelle" <schnelle@linux.ibm.com>, "Peter Huewe"
 <peterhuewe@gmx.de>
X-Mailer: aerc 0.17.0
References: <20240404105840.3396821-1-schnelle@linux.ibm.com>
 <20240404105840.3396821-2-schnelle@linux.ibm.com>
In-Reply-To: <20240404105840.3396821-2-schnelle@linux.ibm.com>

On Thu Apr 4, 2024 at 1:58 PM EEST, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=3Dn will disable inb()/outb() and friends at
> compile time. We thus need to add this dependency and ifdef sections of
> code using inb()/outb() as alternative access methods.
>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> Note: This patch does not depend any not-yet-mainline HAS_IOPORT changes
> and may be merged via subsystem specific trees at your earliest
> convenience.

Thanks I applied it.

BR, Jarkko

