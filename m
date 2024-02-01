Return-Path: <linux-kernel+bounces-47751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFFE84525B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A068B1C25A34
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD380158D8D;
	Thu,  1 Feb 2024 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ES5zFr36"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AD785C7D;
	Thu,  1 Feb 2024 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706774812; cv=none; b=rVAq2PDd7m05gGA4vOnYv6DFIBJZiNHVJiFzrAeoY0Kh4T9ROjP5ymLdTprtPPVKIHMBX0HGwQWOFwZhQeuSXe+J5EuxqIKPGtBECnHfiRvIFwJNTCFCm8EGa7eShbpztocIh/++zp8pR8x8CtBD+FyCNHre3OTyN6Z/c+0AWFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706774812; c=relaxed/simple;
	bh=RWc7qs1DM19netaxDibaiGaRudn34fnK5CrPeU1wEsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+/XAOaRiYsxexPSq5imSiSFHaQ5t7gZbzQvftp+euNXyb2dsyqHHDKIuqECsiYME0NlVYG9aRZeTXwl6w+Tf/+juAkEBgCZRu0C9ik91q25/wkb6mfnLII63U0X6AolbZm85wEJfIZ3AubEhWGWPxJ0U7phCy1ZYisB8To9cGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ES5zFr36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A92C433C7;
	Thu,  1 Feb 2024 08:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706774811;
	bh=RWc7qs1DM19netaxDibaiGaRudn34fnK5CrPeU1wEsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ES5zFr36fd3EMtVKSSzhrWYzlZIw4DWNZkViT+MZ30Br2ryTtxNVJ1uuVOAR/QPnU
	 lTy320s93DXJWO5wT6F8aoVhJB2qOmNGE+MtL6xlY7h9NkBpLzxnDsXrJAbMfwVq/i
	 KoBDHA/jnBGjDPgtpqB/H4LcQqfPaR9nbb3Gd2aQ9u2hztbcU4ygru54zB+s/Zo1En
	 /r6EsUykvXzC5gA0xkDvm+9Z2T/leXuG7COQ3Z3sSNixAaMNwi5hKhwedmEAjJdadi
	 R35X+NliGn41icTu9lhVwgBwAQFUFS4M0vcG3wd8ZGTwG0AdAiPD5ZcEK+kRvbm+pN
	 pquBAJ3QW5uMg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rVS60-000000005iT-0PtX;
	Thu, 01 Feb 2024 09:06:52 +0100
Date: Thu, 1 Feb 2024 09:06:52 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Jiri Kosina <jikos@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 2/3] HID: i2c-hid-of: Remove comment about post-reset
 in DT binding
Message-ID: <ZbtRHAHsjfbp9p_a@hovoldconsulting.com>
References: <20240131-x13s-touchscreen-v4-0-39c0f9925d3c@quicinc.com>
 <20240131-x13s-touchscreen-v4-2-39c0f9925d3c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131-x13s-touchscreen-v4-2-39c0f9925d3c@quicinc.com>

On Wed, Jan 31, 2024 at 07:07:27PM -0800, Bjorn Andersson wrote:
> With the "post-reset-deassert-delay-ms" property added to the DeviceTree
> binding, the comment is no longer valid, remove it.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

