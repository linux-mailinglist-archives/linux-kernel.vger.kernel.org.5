Return-Path: <linux-kernel+bounces-39763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED9E83D5D5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD3D6B25010
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671E51BDDC;
	Fri, 26 Jan 2024 08:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJ+R0qG+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A797C14292;
	Fri, 26 Jan 2024 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706257743; cv=none; b=oHePDbfHThl1KVNnJ3K/RJAFG/+478Em3ogGEPBF3duceCGrv88LWtsYWfoCmvlscAl1r4y96w9c2htbW2FMpTlg5lC6eqYj52IxLWkSyRTb2vk1QGXwcHwpEO9XjhdZoKRHNzmXbDXp5ecflgap2903ylT9URHe1Wf1jdYrOR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706257743; c=relaxed/simple;
	bh=e1f/lsZVVN1jspgIY3MuN0oqYhy8kIK09/ecCHYLBHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ljd+rM4krTGggK1bMlgcbRXLRKTOHR4m2vZypi8pp3o0IDnL1okrTEHwPtFGc1XNy7JdFjRqYnoy0hD/i0JmeSm2/Pg+kHVWeNNdHv/lW2xoxar0JFjKDXNv9wEASlVcjexciiWWQUGWsdJX96Othp65nyk4x5P2DzROyNOxUl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJ+R0qG+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F8AC433F1;
	Fri, 26 Jan 2024 08:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706257743;
	bh=e1f/lsZVVN1jspgIY3MuN0oqYhy8kIK09/ecCHYLBHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WJ+R0qG+r7f4g3y4mpEF8GPcwATgHHj8un5kN0jlrMp6T00eAd/tN5T4rrrRt8ERp
	 BiYOD75ybS6ZAr6ZF0Y4JoFdETrYJ7lbAIQdbebxKIzC1uiG/F9yzeCfzctBTR9nOK
	 wAm/woAa045cFdtOv99f1q4bp4XW94KxmGtaDNSEgazFQQYY/2JA3wrDRjig6rtaK5
	 eQyZjlOI3PX4rlDn+GHiH0skD8fBAOkAA1Buir+7xkgS8Er9SM07BFT1SCpLm4RTvi
	 kXJ+NWbGWUwIdzp3KFLDrx371y3E335vrdf1qsx7vwtUe364JllyXdeBz6GfkNR+uJ
	 wG0onCXxOvduw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rTHaL-000000002xF-3wHr;
	Fri, 26 Jan 2024 09:29:14 +0100
Date: Fri, 26 Jan 2024 09:29:13 +0100
From: Johan Hovold <johan@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] dt-bindings: spmi: clean up hisilicon binding
Message-ID: <ZbNtWWy1QaV9MRL0@hovoldconsulting.com>
References: <20231130173757.13011-1-johan+linaro@kernel.org>
 <ZYG8jA64drRFL-SW@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYG8jA64drRFL-SW@hovoldconsulting.com>

Hi Stephen,

On Tue, Dec 19, 2023 at 04:53:48PM +0100, Johan Hovold wrote:
> On Thu, Nov 30, 2023 at 06:37:55PM +0100, Johan Hovold wrote:
> > When reviewing the various SPMI PMIC bindings, I noticed that several
> > examples were incorrect and misleading and could also use some cleanup.
> > 
> > This series addresses the related hisilicon SPMI controller binding.
> 
> > Johan Hovold (2):
> >   dt-bindings: spmi: hisilicon,hisi-spmi-controller: fix binding
> >     references
> >   dt-bindings: spmi: hisilicon,hisi-spmi-controller: clean up example
> 
> I noticed that these are not yet in linux-next so sending a reminder.

This series never made it into 6.8, but could you pick it up for 6.9?

Johan

