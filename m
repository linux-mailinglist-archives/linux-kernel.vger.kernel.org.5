Return-Path: <linux-kernel+bounces-60860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B09D850A42
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 499FDB2250E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079665C5F5;
	Sun, 11 Feb 2024 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Bfxmdl8H"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CD75A780;
	Sun, 11 Feb 2024 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707668302; cv=none; b=h6QLoZkB1Bqxl3H0povKUe0vpXcCvx7A+ZSgKiKQE4C2r7abAizghutQekEZnhwQ//aw/lznY9PjGONvzK/Tl/wG9Z84C9jFcEtDHAJV8a4K0jGezX3GMnCbFGdd/L3TdgygNT1rL6Ew2oWlI5trVYka1DamBaSboD7N/gQHtFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707668302; c=relaxed/simple;
	bh=J7j/Ivo9sIipU2ImpsZSOUjvUcgH/hlBJb2ZxOXtPRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6HAucPFVc8yDTl1RcWultPWk7EveiUbG/ZD9gq4JLDsdUZTMJGhES/Ttq5y/utTMG/7SFSz5+vfuOTM7sPWrIkiM4m3/L5eB8bUF9JgFiTKK6qJdUe+QJ4PQYMA3BKNcNmeh4EqZEmPxmuT8KsbCOCMkX54v69JCeIOM62nNEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Bfxmdl8H; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 24FE120751;
	Sun, 11 Feb 2024 17:18:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1707668297;
	bh=J7j/Ivo9sIipU2ImpsZSOUjvUcgH/hlBJb2ZxOXtPRc=; h=From:To:Subject;
	b=Bfxmdl8H6cUu68zyzFPtIqq495DZme6vdTN2kO3YrgV/FHL/QukwEtGid/aFhyvIn
	 X13X3+chWo3oHMy9HZ9BWd3gcxaxB6t7QEJos7XbO+vZHeicIR74dfzS7RzFn7LAU7
	 brmng6XuwvU1iXrKt2jDE4NxcHh1iXAq6bE/90WGacB/JQbSFtkYkwOiUVQw+D+d7E
	 oItCGova13TD48rqkJFeLYu2ciM63MN8UKrvNUV38+o7ZnfZ+htU32bSkHc5PMiKbo
	 awPRoSJeTVz6cX0+RWoGyLdKHp4wwXSg9kjseLYD75K8b2FedZSAF7rvHuPnLfNkvk
	 Qnckht96DLQ+g==
Date: Sun, 11 Feb 2024 17:18:15 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Roger Quadros <rogerq@kernel.org>
Cc: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	r-gunasekaran@ti.com, b-liu@ti.com, afd@ti.com, nm@ti.com,
	srk@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: Re: [PATCH v2 5/5] usb: dwc3-am62: add workaround for Errata i2409
Message-ID: <20240211161815.GC4443@francesco-nb>
References: <20240205141221.56076-1-rogerq@kernel.org>
 <20240205141221.56076-6-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205141221.56076-6-rogerq@kernel.org>

On Mon, Feb 05, 2024 at 04:12:21PM +0200, Roger Quadros wrote:
> All AM62 devices have Errata i2409 [1] due to which
> USB2 PHY may lock up due to short suspend.

Is there any visible log trace when we have this phy lock up situation?
Eventually it would be nice to have this in the commit message.

Francesco



