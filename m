Return-Path: <linux-kernel+bounces-44659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F3E842599
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7DE1C24991
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AFF6BB22;
	Tue, 30 Jan 2024 12:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7vP0MFo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A421F4C66;
	Tue, 30 Jan 2024 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619437; cv=none; b=IagVBR+kBc5t5rgpWYABnlXRnIojrlZtKEFfkY44VPN4OzsMVe4p9s87DFyAc4u+IE0g4cWxEDplfLwlsJDOX8wSdlQPjY1Dt1cn+k9CkS2LJ0FWNmO6OwYVvRzWUgHu8iXhEC1zfriqbVmpxA+JJ5uYmGHpv8MOueAfevjLPEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619437; c=relaxed/simple;
	bh=RLq+PicEDTzjiLNQB2XRMMs5TR7fW5zSMDN54swDxCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poVhUQAlNucJ30Z+dEBdeYXhQPo7hmiobOAnm0tLnqBj0/DOqE/I0Gq+Vz25JAjkbxQ+lFL5FrLvsKApxtRVYfjJZqlp2I4gvwz3ZmKi3KCuORZglGdFI4RXCOhXIXJRR+GVuRseYUbzq91MP3n6IYSGefCD5S/scjUBQnsxDxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7vP0MFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB731C433C7;
	Tue, 30 Jan 2024 12:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706619437;
	bh=RLq+PicEDTzjiLNQB2XRMMs5TR7fW5zSMDN54swDxCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s7vP0MFoPuw4xlo8+GN2ohMGsCvXPn3HC4e1QRIlxPxROwzG3NrQmgHMgUvo+b7xg
	 7ofb3OWzi7o0p5zrfQghzNNsd8pkonH8yBs8J2DmzMbnxCrLF++D/FijNrqWpI6VMy
	 t8sifa+UKcdDUBTSg3FojXP8k2jKVC/AjScikAr8GbJa1xQXYiiafTCog6PgczmprS
	 bMMlt/kCRgWOjdlVeTHCjwRAKwXZDJY19M2tjzOnnKwcC8hNdKyBschxI9nQoSOUb1
	 uG4NtOdtWCrAAevU5Ab/5SfY4MBK/sdeOYXV8jDgvGsQIBF9KN5wt09hMgT9X6VD3t
	 nKEDJZVHdmeUA==
Date: Tue, 30 Jan 2024 12:57:08 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, Siddharth Vadapalli <s-vadapalli@ti.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Roger Quadros <rogerq@kernel.org>, dsahern@kernel.org,
	weiwan@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Alex Elder <elder@linaro.org>, Rob Herring <robh@kernel.org>,
	"open list:TI ETHERNET SWITCH DRIVER (CPSW)" <linux-omap@vger.kernel.org>
Subject: Re: [PATCH net 06/10] net: fill in MODULE_DESCRIPTION()s for
 cpsw-common
Message-ID: <20240130125708.GE351311@kernel.org>
References: <20240125193420.533604-1-leitao@debian.org>
 <20240125193420.533604-7-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125193420.533604-7-leitao@debian.org>

On Thu, Jan 25, 2024 at 11:34:16AM -0800, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the TI CPSW switch module.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


