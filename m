Return-Path: <linux-kernel+bounces-63137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DDB852B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B201F23AE6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0401B593;
	Tue, 13 Feb 2024 08:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGCdbIvx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB3E1B273;
	Tue, 13 Feb 2024 08:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813824; cv=none; b=qqkjKzdHQk+6Zd1gxI+Y4GAYVmhLFVO/L5VH/D2Jygcct1XT0bSTPrhZWLAzWWSC1rmOuan10hfOw4+JTbEGOJcnGpHzR8LGzg2drAJTX8ycvy2eCdj/Hy7G7Fe4/771bj7Slu2i/+AXwBoe7kXy9cmVk3ba9lOvRxGcMrZDcKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813824; c=relaxed/simple;
	bh=t94qRvoG9XvZt4w8+pQ/h1zUY4fDFCFi3+W/4fbxLbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d56pt494CPPHKfxfxSMbZOjQOpkGnsgEWK4CL4TK0PZp9es7WMLvWO9IMFY+58Qt1KZVZ7CdlAbLCmfW5nyane7J6WgMdAtWxy64jMFq91OXc0SAFQ3gvisnL0xwklfLXP1LnTlzjeqOgHc0dweG3LoY82v8BrWT2UXD5NpGcHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGCdbIvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F48C433F1;
	Tue, 13 Feb 2024 08:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707813823;
	bh=t94qRvoG9XvZt4w8+pQ/h1zUY4fDFCFi3+W/4fbxLbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JGCdbIvxYqyVxQRggpOK4zccva+hcOr691mh1ljEtU2xVg5a5nqdhTTst6fywAA3S
	 O0p5+Y0wAu6i11zXAYmRdbNtP/+aegMAgwwkVxFmOPtjnv7qoZIWP44Fgm8i5m4VBd
	 e7cuqze0ZatK0V0FaqikevPuVE9fC8XmPqgcaWDM3IShkL+pR7vC/qSQ+xGXwLsSnp
	 pdY0ENdL+h2hn3hQJcgKizuYp4/HEZxk70lWkQ4iuD+ltDE8RQaJba21JG3vENkOi8
	 QhbYzfKL/Izfq/FddQdNkcG51Wdx6eMYI5haMBP4Zgo1IaWL0uzopWp1fjCuU3PMqN
	 Ugoa+55U2pckQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rZoOU-000000003tE-3yZT;
	Tue, 13 Feb 2024 09:43:59 +0100
Date: Tue, 13 Feb 2024 09:43:58 +0100
From: Johan Hovold <johan@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_ppratap@quicinc.com, quic_jackp@quicinc.com
Subject: Re: [PATCH v2 0/2] Add DT support for Multiport controller on
 SC8280XP
Message-ID: <Zcsrzr4RtH6CNB5l@hovoldconsulting.com>
References: <20240213082724.1789096-1-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213082724.1789096-1-quic_kriskura@quicinc.com>

On Tue, Feb 13, 2024 at 01:57:22PM +0530, Krishna Kurapati wrote:
> Series [1] introduces binding and driver support for DWC3 Multiport
> controllers. This series adds support for tertiary controller of SC8280
> and enabled multiport controller for SA8295P-ADP platform.
> 
> Till v13 the DT was pushed along with driver code. Separate the DT changes
> from driver update and pushing it as this series.

Then this is version 15, don't reset the version number and hide all the
work that has gone into getting where we are today (e.g. by removing the
changelog).

> Changes in v2:
> SA8540 Ride related code changes have been dropped and will pushed later
> due to unavailability of hardware with either Andrew or me for testing the
> gpio hog changes suggested in v1.
> Implemented vbus boost regulators as fixed regulators instead of modelling
> their enable pins as pinctrl nodes.
> 
> Link to v1:
> https://lore.kernel.org/all/20240206114745.1388491-1-quic_kriskura@quicinc.com/
> 
> [1]: https://lore.kernel.org/all/20240206051825.1038685-1-quic_kriskura@quicinc.com/

Also make sure to include reviewers that have spend time on your series
as I'm sure I've asked you before.

Please fix in a v16.

Johan

