Return-Path: <linux-kernel+bounces-66987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3325A85647E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663DA1C23B84
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D360E131E26;
	Thu, 15 Feb 2024 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8Knt5BN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D275131758;
	Thu, 15 Feb 2024 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003966; cv=none; b=feeUKn2IwkseALSMqC++FeTheFAxLm8+A0cpwuaTTAA5/PaoYFDCDHh37+3yinuuLhqoybfgt70cIwWAURbBXEi+E6RcPdyhPlgSQUqM7GT8MoLKDMmtw7I6ttykcH5oukzlB2SY+99XcZ1GvyRI2jCjH61u7GekDysSTYni47M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003966; c=relaxed/simple;
	bh=l6UbhlvBDguzcecxNWH0NioHT//VyUfHe+IomwW/Qsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoyB7Phqn3UvLHnpsxgWovUqbHQ8pTG7C5Wqs9rfGLgrzMKHPwxALsI6WR6Rkeoq/izIJq5dh2aOYheodqm5zLlWbG+pWKBGirVPKXGWzEeLb6m/uGxsJzdtnrR2Xuij6Sc0ACljmtAYpfQ8qnBWpphWfGLV73T4UKUGxvh95Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8Knt5BN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC57C43142;
	Thu, 15 Feb 2024 13:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708003965;
	bh=l6UbhlvBDguzcecxNWH0NioHT//VyUfHe+IomwW/Qsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f8Knt5BNYogWcdqNIPz/Bgp+7JQEoMcboiYGWsn9KZ7f5KQ4/v1Vv/h3sX6cB8UVr
	 kOceYWcEcdI4QpeUh5jbWhGoyudLavYgyEithPNaOXZVIBUSl8CclAU1s1DFMT58Bs
	 RUlf0dvoeFMy1ygrCEfqAQUSfA1R+sDCQq/del2z2b3Gqk7PycQAJDGC3c/gpTmY7U
	 J2E+U+4IifU/hsFScZ+rhPIEwWlq8QmMrdZHQsSZOj+xhobndyvTqJj52DGh31jg/P
	 8G9itDhywufK4+/rpReZrjIYr2cvO+LlTg6MH0CLR09TeVlYxzuxZe+0XzqTs/MEUD
	 ADJcqfOPPP9Hg==
Date: Thu, 15 Feb 2024 07:32:40 -0600
From: Rob Herring <robh@kernel.org>
To: Charles Perry <charles.perry@savoirfairelinux.com>
Cc: mdf@kernel.org, avandiver@markem-imaje.com, bcody@markem-imaje.com,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	kishore Manne <nava.kishore.manne@amd.com>,
	linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/5] dt-bindings: fpga: xlnx,fpga-slave-serial: rename
 gpios
Message-ID: <20240215133240.GA4061942-robh@kernel.org>
References: <20240207180142.79625-1-charles.perry@savoirfairelinux.com>
 <20240207180142.79625-3-charles.perry@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207180142.79625-3-charles.perry@savoirfairelinux.com>

On Wed, Feb 07, 2024 at 01:01:25PM -0500, Charles Perry wrote:
> By convention, gpio consumer names should not contain underscores
> (prog_b here) and shouldn't contain active low suffixes (-b here).

Yes, that is the preference, but we are stuck with supporting the old 
name. It is not worth it to carry both in the binding and kernel.

Rob

