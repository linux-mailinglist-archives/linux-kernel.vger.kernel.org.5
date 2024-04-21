Return-Path: <linux-kernel+bounces-152468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9C28ABEE0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 11:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0C48B20B9A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 09:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C669A101CE;
	Sun, 21 Apr 2024 09:31:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BCA3232;
	Sun, 21 Apr 2024 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713691915; cv=none; b=OIOHvsetvmtsYceWDs1nfes16WDFMvN3AgXTlOM6MEBXsAtrCOgKBzsqsuN+CdHUy7P4wUV4dYctzxx3h/XbwsC3V50Fpcq9l5I+1gwl+ODY3Q8W86s8QaaNu2g7BSJrmTBPBM7HyXM6hT+DLurJFSJh4SKknFDAnPE917h7OU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713691915; c=relaxed/simple;
	bh=KKW2RTp1B3WeXO3e6hwdWWI5bnAKqUwrrDyXZbIeMvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvXWxD0W/lW2akvk998i5ORFNpIyfmUBPAT68ZjDPEkspVOGNSYfsh0CHaOalrTnpbDsDcSaBNro4KxqJVhdo9UiIjmy5ehWAs/uXPTmYEnpAPbwUQfUSigt3VrO1lobzSYCH6/X8btLJ65QpACF6bJJr+dDgw37cgdSaBjO2NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23FA9339;
	Sun, 21 Apr 2024 02:32:20 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8FBA3F792;
	Sun, 21 Apr 2024 02:31:48 -0700 (PDT)
Date: Sun, 21 Apr 2024 10:31:41 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Stephen Boyd <sboyd@kernel.org>, sudeep.holla@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	quic_nkela@quicinc.com, souvik.chakravarty@arm.com,
	mturquette@baylibre.com
Subject: Re: [PATCH v3 0/5] Rework SCMI Clock driver clk_ops setup procedure
Message-ID: <ZiTc_Rbh81eFUTw1@pluto>
References: <20240415163649.895268-1-cristian.marussi@arm.com>
 <6b8e12767fdfaf1ba819896fbd610733.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b8e12767fdfaf1ba819896fbd610733.sboyd@kernel.org>

On Fri, Apr 19, 2024 at 07:08:54PM -0700, Stephen Boyd wrote:
> Quoting Cristian Marussi (2024-04-15 09:36:44)
> > Hi,
> > 
> > a small series to review how the SCMI Clock driver chooses and sets up the
> > CLK operations to associate to a clock when registering with CLK framework.
> 
> Did you want me to merge this through clk tree?

Up to @Sudeep really...

Thanks for the reviewing this series.
Cristian

