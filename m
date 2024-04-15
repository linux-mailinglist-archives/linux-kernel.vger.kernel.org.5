Return-Path: <linux-kernel+bounces-144966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7EB8A4D3C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAA5C28553C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7401A633FE;
	Mon, 15 Apr 2024 11:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="R6Cvq17v"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F1961699;
	Mon, 15 Apr 2024 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178999; cv=none; b=ERHT7zK9jGwkpXDmCTCOTcjlZEBsZ2nqI2FdUTy6nRDDKS5NsqtC3E4+whpJnT1eNJD6HKaMTL0QcPDcHgBNiq3ZuSRRjT6dALcKMBLRnAU1Zj71ylbLzlQlROUSqf4BZpDU1ueAEZLmUlfz93z3smOVUKiVxm06Pe7w8wGIWPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178999; c=relaxed/simple;
	bh=gl8Ddm6Szv95sQ0U0gi2SLbDcOhP+go6gJEhYJs/sfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+kr8AYoFGliTyqdnFUlW2ZwUKjDAbgr5UQ0dYf+YshrZpV7Vy87GL/G+dLvoq4KutdSbaZLlYPlPPRNUaxqcRNfgnv0EZ3QmPDz8e/peLrSnlM8oNJX1OCq3SZ5+DxwrI2lNCDb1U6OWnPoWKreO/+WWIfHUlP/XRW7mQY1Gyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=R6Cvq17v; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id EBF131F9B0;
	Mon, 15 Apr 2024 13:03:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1713178993;
	bh=MCukrtfROu1vw0L0AvPGbisZkMWMRRAdl3x8TPsc6bk=;
	h=Received:From:To:Subject;
	b=R6Cvq17vI8MeGKhGs6Q/LLpH99UMgmP0RnpzQ1PM8Gnny6uTlWNULAUeA+H2XNCO+
	 Q4ORFiEbTfPf/vgHbYpoB/vYlOMxc8VLm335P7Ve8yE+W84uIu7UMQ6lAiJKEI3u+C
	 GDNCDRxKWamrQC+8SV3QV6tA8o/sWRyrC8NiACdg9fZjXUMCNl1Uc7286+J87MolLT
	 r33LmUcODFsVT3P5+96Tmql7E3H+jw2e7uPn1xdiFTyxBVfYVgv6YhziYuQbaQKcQ5
	 gpvT+bItJ62467o/DwFERlt6jb0SPqSxRG+RXQsXZjhrsQS0qAgphqeG7QXDSHcbex
	 NzO/1V9GJy2Sg==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 9A3667FDA1; Mon, 15 Apr 2024 13:03:12 +0200 (CEST)
Date: Mon, 15 Apr 2024 13:03:12 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, francesco@dolcini.it, kristo@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-am69-sk: Fix UART pin type and
 macro type
Message-ID: <Zh0JcNlRL2QNkpf1@gaggiata.pivistrello.it>
References: <20240415095605.3547933-1-u-kumar1@ti.com>
 <20240415095605.3547933-3-u-kumar1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415095605.3547933-3-u-kumar1@ti.com>

On Mon, Apr 15, 2024 at 03:26:05PM +0530, Udit Kumar wrote:
> Along fixing wkup UART RTS and TX pins as OUTPUT instead of INPUT
> updating J784S4 macro for pin mux instead of J721S2.
> 
> Fixes: 45299dd1991b ("arm64: dts: ti: k3-am69-sk: Add mcu and wakeup uarts")
> Fixes: 08ae12b63750 ("arm64: dts: ti: k3-am69-sk: Enable wakeup_i2c0 and eeprom")
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


