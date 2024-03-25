Return-Path: <linux-kernel+bounces-117669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A5088AE45
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B011F65787
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF9F12A145;
	Mon, 25 Mar 2024 18:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fuub38Z7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28F711733;
	Mon, 25 Mar 2024 18:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389713; cv=none; b=M2Kxb9J8t+FZ+ifHqpnmMOc54CSog/Rhi8Ga6FFPobQkM8BlQUHMvTXO0xhlT8nLlPeL0Fqom46iBPAMgtCJDrTo8uqGyfMz3WBKzPsjS6TZ6qFhz48F08A4Cr0ARVEn3/kxKvrPq5a6hp8ZD7WAjRNr0pahaLfG6Pt0dTJlNYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389713; c=relaxed/simple;
	bh=S58idODoxnkE5LOOfSMX8H3rVspzTw9HYaosgXqnjqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOlF8Ye24Lu+Sq0sJg8A7LrvJ2bLedYGbIM/d7bSs6wTWZym1RXrl+SbxrZPOUoxniGGOuw9MLjFMeyg9YXhHrCBCAg33+bf2JOzlMv1BqIK2UdH/WvkdRHVdhUAoU3e1IMXzjO3bab+EoxtswL2FVx8+cux+aSCfBi14Wx5Fp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fuub38Z7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E444BC433F1;
	Mon, 25 Mar 2024 18:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711389713;
	bh=S58idODoxnkE5LOOfSMX8H3rVspzTw9HYaosgXqnjqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fuub38Z7iC5n0KTnoQEzggDjSLwyKbXYZB5PIYuTeVw3W+3L+4fHpe1gUptEvcIbR
	 xH1YquTPz3mSgJl0wjgLHj3Um3cdwOdXd1U8fUfnOIk7gFcBRWbU6SaW+kAaNJIULI
	 4WPXH6QRixXhFn69+u+64WmOmnqouqwnI8Y3/f0Y=
Date: Mon, 25 Mar 2024 19:01:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Tree Davies <tdavies@darkphysics.net>
Cc: philipp.g.hortmann@gmail.com, anjan@momi.ca,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] Staging: rtl8192e: Style guide Renames and Macros
Message-ID: <2024032534-return-edging-a2a2@gregkh>
References: <20240310235552.4217-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240310235552.4217-1-tdavies@darkphysics.net>

On Sun, Mar 10, 2024 at 04:55:41PM -0700, Tree Davies wrote:
> 10/11 patches in this series rename variables to fix camelCase style
> guide violations. The 11th patch implements the use of the BIT macro
> instead of regular bit shift operations.
> 
> MOTE: Because patch #11 changes DEFINEs the compiler issues 
> redefinition warnings. I don't know how to address these as part
> of this submission. 
> 
> All changes Tested on Hardware

This patch series blows up the build, as the kernel test bot says, so I
can't apply it, sorry.

greg k-h

