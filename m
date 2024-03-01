Return-Path: <linux-kernel+bounces-89144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A20286EB1D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF121F21692
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADC558129;
	Fri,  1 Mar 2024 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McJ0P1P1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D6C5810C;
	Fri,  1 Mar 2024 21:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709328399; cv=none; b=ZBgb7tfBDIp63wgZ0i5Majxa45U/ZAADE75Dozt1+7w4ulpLGipuXBNyn17Sk7QpnT11JOUTfEyrGAX3UUyptsS3VVZpKHtHihLBUDISSIS4c9f2ECJp6MgTV3KZLKMYZ9qH5NRkaDRib+gj4bgENnOhkV8SpQNYLE6qzyvm3uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709328399; c=relaxed/simple;
	bh=aM1m7Tc6gmh3QqrzFtLm2I/l6fRMcyxvti7AKcZMJdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMZ9IFLMYv7o2+2QZGUSMqLWXHXI9j9WpuSixlA4RHRXxs0ArCDLwD4FcgAr7tFQE8/4MA8gyh4o+OefbSJldunB1lYW7x3+VTstnUblY6N4RuQe37Sj09j7L8tWD07InKpA0RjqLZT20OIfyDb/AopQP0MhZvtAo3hu2AZLl+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McJ0P1P1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B54C433C7;
	Fri,  1 Mar 2024 21:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709328398;
	bh=aM1m7Tc6gmh3QqrzFtLm2I/l6fRMcyxvti7AKcZMJdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=McJ0P1P1Xqg6PtBhxAtmq+nxXisb0NL/qIAasGQTUBPz576osIqK+0rWGhBbOs5pE
	 ZfdXepJWU2r7wHbMT4iIqZ+P3f9rAG0j36VV7zyikslHmPNd3PxGby9VgHwvfScucE
	 V3bIG+notlUQK8qsDz6yJ+qNLOMb6Y1QjtdTPC203Tywmk1Jr6T8PgkKEl1KwB6zJP
	 q2DrEgVb5x+SthecxbX6JkDjLU1l2/GLljsg8nAyRTemDyF7crNGdePZi3EIUi/TCr
	 wrz719XdnqQKhFqUuoMY1pmUrggWzix+gGACs8CqyWwWZ6NCtDrht2uD0nEJysaWur
	 d54eNby07nrrA==
Date: Fri, 1 Mar 2024 15:26:35 -0600
From: Rob Herring <robh@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	mturquette@baylibre.com, claudiu.beznea@tuxon.dev,
	krzysztof.kozlowski+dt@linaro.org, alexandre.belloni@bootlin.com,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	robh+dt@kernel.org, nicolas.ferre@microchip.com,
	conor+dt@kernel.org, sboyd@kernel.org
Subject: Re: [PATCH v4 26/39] dt-bindings: clock: at91: Allow PLLs to be
 exported and referenced in DT
Message-ID: <170932839461.3066401.7560967756154066315.robh@kernel.org>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172822.672902-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223172822.672902-1-varshini.rajendran@microchip.com>


On Fri, 23 Feb 2024 22:58:22 +0530, Varshini Rajendran wrote:
> Allow PLLADIV2 and LVDSPLL to be referenced as a PMC_TYPE_CORE
> clock from phandle in DT for sam9x7 SoC family.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  include/dt-bindings/clock/at91.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


