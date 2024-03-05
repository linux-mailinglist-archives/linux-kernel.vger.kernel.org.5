Return-Path: <linux-kernel+bounces-92774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7370A8725C4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064C7283443
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8E217581;
	Tue,  5 Mar 2024 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGyatJBw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E88E14286;
	Tue,  5 Mar 2024 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709660075; cv=none; b=h7BYWRLj7ATnOAOIGHkc8gxUDrELTkayeXIWzhPhygAPSg9dglMsQHn0lBvSC5Qeu88b+8zNUKP7PZdlwKp9oETKKnpwcDebTO3UMDz1zB+ACcbGbgqrXfgx00umlx7KbjuO9Hh8iKk5S/zSW3U4k0KDaz3V5pRLRbpI2YifWR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709660075; c=relaxed/simple;
	bh=ZsPxSyuYc9vaW5VTKLQu311nwctIAVH8PB6NJydYnxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrBdTeEdeH0U3IvHIySvOViHHrIbTs+0AWW6mnYDxRPVLV2/GUnJhthwonqrOxwwLwyzjre7+zDekl6f+5iT8QtPR11/KKx2MaI/rW+LBvl8gyXDtkBSxlt5rmTTKhLO4R2zRWG8nZTPfElhxchW7DeH/DpT4PwAaTHGAiCSJ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGyatJBw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1961C433F1;
	Tue,  5 Mar 2024 17:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709660075;
	bh=ZsPxSyuYc9vaW5VTKLQu311nwctIAVH8PB6NJydYnxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hGyatJBwpm4Etuumvf0FowW9lW/GOTz7awkUXlKbpNrpXrxbMxJYgeag1IYuCtIqm
	 NatuINcV3U8V2xwXfEbC/Oc7DNe5w+AwVFulv/lT4KuMl+v0d8/YRekHPwHSg/LTLq
	 6/6MGguQuttEEltDriifRz2L6r9eNzLHvuKZfwfKQLBBsIo2feanZ7SFeFgSSen/Wj
	 c0Refj6C0uLdGG++wgtX9T1xNp5roW8LWDsl4eDiSltu4MyUaz6b9UKMlwXJk2miTy
	 Q0CcqU1Noh2+nwOfvpRUdILbCM8cHbxh/RMxYZBGYBgCXmvgOOiSzymCmyDQqR8aaU
	 f9WNHZ5viWEZg==
Date: Tue, 5 Mar 2024 11:34:32 -0600
From: Rob Herring <robh@kernel.org>
To: Sebastian Reichel <sre@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v5 0/6] UNI-T UTi260B support
Message-ID: <20240305173432.GA3745196-robh@kernel.org>
References: <20240226212740.2019837-1-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226212740.2019837-1-sre@kernel.org>

On Mon, Feb 26, 2024 at 10:26:22PM +0100, Sebastian Reichel wrote:
> From: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> Hi,
> 
> This adds adds support for the UNI-T UTi260B thermal camera, which is based
> on i.MX6ULL. The series first updates DT bindings, so that CHECK_DTBS no
> longer reports any errors for i.MX6ULL (i.e. for an empty board). They are
> not specific to the UTi260B and in fact that machine has most of the IP
> handled by these patches marked as disabled. The last patch adds the actual
> thermal camera DT.

I imagine that this has missed 6.9 for arm-soc, so I've applied the 
binding patches. The anatop binding in particular fixes a warning in 
dt_binding_check.

Rob

