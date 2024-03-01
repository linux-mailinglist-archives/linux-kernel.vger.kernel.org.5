Return-Path: <linux-kernel+bounces-89156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0632986EB51
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9681F1F25463
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D7858AA7;
	Fri,  1 Mar 2024 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6hlLE5P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA857322;
	Fri,  1 Mar 2024 21:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329245; cv=none; b=WBpgq7uAVr1JjiXU+RDzqBAFU+rHbmQqJhoSVU0IbLOlIKdwLUe8A2mhPCfz3PVLcJlTDPwAxmioPK7VaGeLcenceRYP+UYEpYGDrHVp17oYnjE9ANcvSRKZh0kro2CRUanLQcTp8sGAIo/JkFKk2sNiKcaoeIojaPSjopRHnfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329245; c=relaxed/simple;
	bh=OPt9YrG608K2PQV++2Xf4keOzrbh3bwdN+8dBbJmau4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GV4zfIpPDp17ZTaveaJcbubwWpTyKwYEY7zOdu0Hzkh9Hgh0kEz7z1KkLV6wFHWTJ0AhQvC5HWBg8cBdJCFdhGWI9yG8cKMG+N+Jj0YFNB5p9T9rmhH0nhXpvr9eVg77nsaMk8qmoBrSRSw/WP3qjbfxJcVsH5qe+uSqXEXAl/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6hlLE5P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAAFC433F1;
	Fri,  1 Mar 2024 21:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709329244;
	bh=OPt9YrG608K2PQV++2Xf4keOzrbh3bwdN+8dBbJmau4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t6hlLE5PDnXjx11h+2nyJKwGscKjBwsosUtarO/URJs3680HGsTunNklcC4I1kntr
	 TVAdr4Ela2sGRssCB4P6+k35abFydeSLLtmbPdog13G1l1OvinsrQCezHppl9f98KK
	 Co3368z0OiHo6Jr3kVdiJOR1xr7dqY3MEBg30loPwzE8cYIfADqHIfjC77VG76saRV
	 RVXumgXgn2oIfxbfbgr19K0+l3ixk7lvlfmwBb5CHmQ6LEG78rpmqkC2+ENlFuvjpU
	 WGrGX6jHFGjt4pzRt7K0prQjcPYj0IMOxo79JDiG1/CWzBxX0t2L078zRv2WKM/jAj
	 SJIaQnxstde0Q==
Date: Fri, 1 Mar 2024 15:40:42 -0600
From: Rob Herring <robh@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: bcm-kernel-feedback-list@broadcom.com, Rob Herring <robh+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-rpi-kernel@lists.infradead.org,
	Guenter Roeck <linux@roeck-us.net>, Ray Jui <rjui@broadcom.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH] dt-bindings: watchdog: drop obsolete brcm,bcm2835-pm-wdt
 bindings
Message-ID: <170932923974.3089013.6309801588871599823.robh@kernel.org>
References: <ZdC/624d1c8O3NRG@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdC/624d1c8O3NRG@standask-GA-A55M-S2HP>


On Sat, 17 Feb 2024 15:17:15 +0100, Stanislav Jakubek wrote:
> These bindings are already (better) described in soc/bcm/brcm,bcm2835-pm.
> Drop these obsolete bindings.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
>  .../bindings/watchdog/brcm,bcm2835-pm-wdog.txt | 18 ------------------
>  1 file changed, 18 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/brcm,bcm2835-pm-wdog.txt
> 

Applied, thanks!


