Return-Path: <linux-kernel+bounces-63080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7057D852AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA6F28490E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5852A17C62;
	Tue, 13 Feb 2024 08:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="T5s4Qsoq"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DB41B263;
	Tue, 13 Feb 2024 08:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812154; cv=none; b=EPpvbCCMzBmnsACLDQzaVEhk4bSqUz17gH6Cu7loy9RATtiXkE7oARCQf0jN5U9lTNKoz5qftqjeUtlzi96UpkJuFnl1Fty4ombW4mTI0seckFjK6esXL6hvQsujzTkKcza7r+VpbzWvt0Crb/622MVIIuhzk0lxHK5Xd4oVxsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812154; c=relaxed/simple;
	bh=92DXHF71+7oeTsGWV/4lnuDoWyAgG+ypk3ikJNSrEJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjItLEyxVZRVA63QhrfQaXabMP4EDwf4sPGm3urR8c8rxV4STDcr15WhFG2OdPTl0D1FVeVsivoFzbRzFkE4qV6Uu7g+Pn5mBezi6QamqD8nLHHTIhWJRPCBg+maR+5L0XYC7Q7SkCl0duVRg7EkqQ5Er3sPnas8+T+l1NqZFZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=T5s4Qsoq; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (unknown [5.170.16.17])
	by mail11.truemail.it (Postfix) with ESMTPA id 59F491FDBE;
	Tue, 13 Feb 2024 09:15:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1707812148;
	bh=qa9g6JHYXRNvSH7o+p2aLOAnOYPsxZBPVhohALq2dRo=; h=From:To:Subject;
	b=T5s4QsoqMEC6Aya3tHWFNsxDZffu3zc3VgvZbXSnIYemxuARche6nYs2iCyb4x4bU
	 CgpQZ+DJxnw3A6AksOx9WFL5MAY5DoKL1cXlFFhpxFwtQCjCIjhqeDwSfNqwIFM3n5
	 WdCrp82SeFN8tHcp6Osi20/c4ROFqVTtMrjYZkbXbEdp7cuq3nzmYvjxDJTKwW89c2
	 +8NCJZ8zVrATox4a2nB/D7uEXOE15WmK6VD5VAIgDAohp8TqtGp3O2apSnksXw+y2h
	 QukkDvCJTBdUVWlPbeXJXnZxQZaEA/3dn/VV+nUEeWI/5UQ5wJ2CbjQx7icQmLX7NO
	 b+cpkVOc1v67w==
Date: Tue, 13 Feb 2024 09:15:43 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Judith Mendez <jm@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Wadim Egorov <w.egorov@phytec.de>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 6/9] arm64: dts: ti: k3-am6*: Remove DLL properties
 for soft PHYs
Message-ID: <20240213081543.GA3810@francesco-nb>
References: <20240213002416.1560357-1-jm@ti.com>
 <20240213002416.1560357-7-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213002416.1560357-7-jm@ti.com>

Judith, you asked for tests, but if this property does nothing
on AM62 there is no much to test, these changes will just have zero
effect given your explanation.

On Mon, Feb 12, 2024 at 06:24:13PM -0600, Judith Mendez wrote:
> Remove DLL properties which are not applicable for soft PHYs
> since these PHYs do not have a DLL to enable.
> 
> Signed-off-by: Judith Mendez <jm@ti.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com> # Verdin AM62


