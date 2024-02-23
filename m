Return-Path: <linux-kernel+bounces-79007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D759861C28
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE141C21192
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F32012AACB;
	Fri, 23 Feb 2024 18:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezUa7WaV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE2484FA7;
	Fri, 23 Feb 2024 18:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708714296; cv=none; b=BYNGmxfLyFHzXs3vkPH11Rhr4aLj/BamyNthqN7o2ZqVGnjawBdnSHE09seKjl3pY83w5YBt0ta+PFM4g21iEiRCKHN5FXNGxiY9Tn5L74egvrFr4aFly0QjNnCwkZ7Oh/hlj69Gf+56Qk5RBsR+YTc6P5ClXrg4iVt8jIPXiy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708714296; c=relaxed/simple;
	bh=FO7BdQ8U8hk1Y0sbXcP0MfCgm4tIizQxDb2XU/U2g4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJNeK5cpbvgIOqqY31AlydqhlKSnsHrHXBaVkL0TEenKkQRtp/11AUgp5OiRntJnlZLdpTWfGoY4L4sBsigxQgdUmxgfX9jcfg9mW7sq4ysjV4acOYxTkimqSrciavpbaPrdX/2r5ZVtYr3WwilqQyrvB5I9ZFpTzWH8fg0FAVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezUa7WaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6557C433F1;
	Fri, 23 Feb 2024 18:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708714296;
	bh=FO7BdQ8U8hk1Y0sbXcP0MfCgm4tIizQxDb2XU/U2g4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ezUa7WaVWWaEBWN4K67za3YyrYXeUmASX5LyFjacCmS+ub+3SXmzngSPhhuh00jGj
	 GGf3WcSfOgXD2wQOHB+kKn+7uIv1+ByU5MLkk5jq0Udl71uNjtuqhMSEq+0Ny88rdy
	 vu7eYxQW6IsuqaBBjmyCx78eYD3aW8EbYiT+7uEGTpHSJQToEPl00iqq+3PEngvwbh
	 WcCC44Ls7rMZBGW3Za3U9aJsKbnyI9nPluVuAxIXCKPWhF11BUBVHXgQJiFOy0C3qv
	 1709HCmYwxmCfINroI8cXo3ZNlsgfYi9ayQkobUGG1jB+MIXd5h0f5vwcB06hFsFJZ
	 IBhyY4YIPGUBA==
Date: Fri, 23 Feb 2024 18:51:31 +0000
From: Conor Dooley <conor@kernel.org>
To: Kelly =?utf-8?B?SHVuZyjmtKrlmInojokp?= <Kelly_Hung@asus.com>
Cc: Kelly Hung <ppighouse@gmail.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
	AllenYY =?utf-8?B?SHN1KOioseW5vOWysyk=?= <AllenYY_Hsu@asus.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: aspeed: add ASUS X4TF board
Message-ID: <20240223-sprang-rework-4b0fb07ccc98@spud>
References: <20240222085914.1218037-1-Kelly_Hung@asus.com>
 <20240222-getting-nebulizer-8f75ba8063b1@spud>
 <TYZPR04MB6596ED7F905CB53191F48A289D552@TYZPR04MB6596.apcprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ryaepkQT1Q7qbbw9"
Content-Disposition: inline
In-Reply-To: <TYZPR04MB6596ED7F905CB53191F48A289D552@TYZPR04MB6596.apcprd04.prod.outlook.com>


--ryaepkQT1Q7qbbw9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I have no idea what his email is meant to mean, it just looks like a
copy of your original patch. That said, you have a footer about the mail
contents of being confidential, so please fix that too.

Thanks,
Conor.

--ryaepkQT1Q7qbbw9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdjpMwAKCRB4tDGHoIJi
0qaFAQD5taRnu/02nJkNtw7fgfQfgtOsbXKXvPhgWUxdfZVWxAD+LF4RgECksW1C
QZifqbegVd+Ek4Jw/1lWJUwbT+vW+gM=
=dc6a
-----END PGP SIGNATURE-----

--ryaepkQT1Q7qbbw9--

