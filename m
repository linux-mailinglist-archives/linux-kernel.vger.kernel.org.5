Return-Path: <linux-kernel+bounces-142131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B01658A27E9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6528B1F22DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106D94B5CD;
	Fri, 12 Apr 2024 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="EX8HHya/"
Received: from smtpcmd0987.aruba.it (smtpcmd0987.aruba.it [62.149.156.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D628F5C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712906700; cv=none; b=Cn9pJFC5t+geTr/c7xMGtrmERYmD1NtYRqV5IVtvcB7YGGA2ZvX3oJEZi5DPZqIFGvPnEi6qvuupCaK5CelSf/FFcgJCIZiy9zvvGou7dTvwXzqh/iuGzBSNca8ARI4esXLHI/qx949fj8S0KUYjYg7jiHF04x64I2rThWftS1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712906700; c=relaxed/simple;
	bh=Adjbq9pqMceLYxsxh7gwyIE+w8QmTE97IidBS1qBgak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PloZsrSBWkvInLHo5QJi8L2tkKiTqmvJuOpsg+J77UoSAQQAxVX3hXXuma/KDHVIPuMqsdbOmosYXQch6e84doov8ifUokP/wEX+af/oG8tWVUw7jG5l5PpuvVVxNyTANb5LyO2xQNy1PS+nCIqN26f8BYXqI1XBIgZgpV3j2ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=EX8HHya/; arc=none smtp.client-ip=62.149.156.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam ([77.32.11.127])
	by Aruba Outgoing Smtp  with ESMTPSA
	id vBEIrWYlOjUFfvBEJrK5qW; Fri, 12 Apr 2024 09:21:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1712906507; bh=Adjbq9pqMceLYxsxh7gwyIE+w8QmTE97IidBS1qBgak=;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	b=EX8HHya/xj1Az3yI1wtxRyfvhSIW9e822ajFI0Lb9zH6Kf1NcoBqtJ1XEpO6INBku
	 1/TnLhwTiqYTafLn1P31t1wcWaP07OUTeE2q+nfEEiAvcGRG4cxmoUNnvuu8l1GGP5
	 E+bMLlalj/xPV9jqZLiGKcBh+4A69ZqAKa7slilVT6HgTRMOexukolQGwJqbf2AvEp
	 bp77keWfZ9c+/50Kpf1fkAh8iUstZMDTTqhofNZkPKQoqRqGVp7hPOBcVnXcFhGe49
	 jecubu5hQ+jCksD4aG6IdK4aUJzY8FSpCOu2ita3kDsLu/XYOhPyssogPB2mleuuy+
	 w3uvAYbbKnrYg==
Date: Fri, 12 Apr 2024 09:21:46 +0200
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Robin Gong <yibin.gong@nxp.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>
Subject: Re: [PATCH v3 1/2] regulator: dt-bindings: pca9450: add PMIC_RST_B
 warm reset property
Message-ID: <ZhjhCvVNezy9r7P4@engicam>
References: <20240411165801.143160-1-fabio.aiuto@engicam.com>
 <20240411165801.143160-2-fabio.aiuto@engicam.com>
 <e86812b3-a3aa-4bdb-9b32-a0339f0f76b5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e86812b3-a3aa-4bdb-9b32-a0339f0f76b5@kernel.org>
X-CMAE-Envelope: MS4xfKVA3PQbAv8+urcPHZqE0/UkF600nupPzGrfjmw8Jtownzu+YWWElrB9mNY1ZOFpf9cR7u+kDhS8ftgu4RpQxfk2ZlE4aZKRDZMnVbT56FfTDRPdfJTU
 Q46tPwA/jDIk004a1NO6fuARb+kgV6ARi2LjIwu4xvGyq+qqDlkeKqWMop/kbvXhx5/nubJl7rtvNXmpzKVsdeJmxjXBStyAqBjsqjylXmAE8SZ/VTWhjLVn
 jOPhymJTrt1WghAiyq1R4/ji0R6dYP4xPk4xTGAKw/jEQsqXBS8C6A+CV1dezhUe8Z+c5hUVb8vmfl5FPHCWCApVC+j+gDuYsx99w3NKkZmW0iIb3F+VWaCX
 nFtfdt+pE6rByxELHa3uEuXGC/1d7atcNr2998WjRb/MIwAzk4wxPNuCRILv1GYtaqDyRvTOVKUR35SKGFHkF8iwgkIWhWPMYq6PfRLigQJSOkRx0TNRMFft
 DIT2trTxnzc6biwt

Dear Krzysztof,

Il Thu, Apr 11, 2024 at 09:52:12PM +0200, Krzysztof Kozlowski ha scritto:
> On 11/04/2024 18:58, Fabio Aiuto wrote:
> > Add property to trigger warm reset on PMIC_RST_B assertion
> > 
> 
> That's rather vague and does not tell me much why this is supposed to be
> board level configuration. It sounds more like a debugging feature:
> during development you want to retain memory contents for pstore etc.
> Then I could imagine this should be turned runtime, e.g. via
> sysfs/debugfs, because for example you want to start inspecting a
> customer's device.

thanks, I spent too few time writing this commit log and I apologize
for that. I was thinking about something like:

    The default configuration of the PMIC behavior makes the PMIC
    power cycle most regulators on PMIC_RST_B assertion. This power
    cycling causes the memory contents of OCRAM to be lost.
    Some systems needs some memory that survives reset and
    reboot, therefore add a property to tell PMIC_RST_B is
    wired.

The actual configuration is made at probe time, anyway we need
to override the default behavior of the pmic to get a warm reset
everytime the PMIC_RST_B pin is asserted and this property tells
us that "something is wired to that pin" and "it has to behave
that way on pin assertion". Our use cases do not meet the need
of further runtime configuration change.

Maybe this patchset is a simple starting point...

kindly waiting for you reply before submitting v4.

best regards,

fabio

> 
> Best regards,
> Krzysztof
> 

