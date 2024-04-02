Return-Path: <linux-kernel+bounces-127553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D86894D8E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F7528297A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A42A5674A;
	Tue,  2 Apr 2024 08:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9DaL+GN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD1C4501C;
	Tue,  2 Apr 2024 08:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712046731; cv=none; b=N77Byl0GPMCn7FHe+JfGQ+v3gdY/HStUTpuJmlU1i+ugTgaDlTz57dDTi5bk/K0yUd0xak/DcasVGNya39sfh5keMvFBMbGWd8Bn5lF+uvN4WfK8Dks24YfaxJsp2cRFQCDhdffYnyvR/9v2a6udVdnd6C3R21vUnBfuMJ+G8CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712046731; c=relaxed/simple;
	bh=VCFQQtKGkqB/GNt26hpiYiRY6xqOpxtr3hcnUnrfahk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAHk/9tA5cC3rpo5kwXgVF3hYDXz1fedWdwKohnSlX6jxbP+2mj4P0ZcnSxWHbjFkZ32sJnBp5U2GoBA7EnsnlFMqYcNHmoSoX8HWD9pkegz0WFS2JjUo8BdX4jphtvoRwAR3kqVHrQi/lUsbVRIU3OyFURudGohqwR2ihZi0nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9DaL+GN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DA1C433C7;
	Tue,  2 Apr 2024 08:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712046730;
	bh=VCFQQtKGkqB/GNt26hpiYiRY6xqOpxtr3hcnUnrfahk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d9DaL+GN+odX2cEp2VZ4k9DM8k+RtiaQ7G/D4TkpAqegkDQd/USkecNU11NrjDRAl
	 QJag9VHDaqXUEaeYuGJh+LiO+RPJf5ZNzq3KSwPvbuK3+uu6vzPy499bxWyZglorql
	 i5K3m+nfH73bslVj/CezmtwtVknbWXJwjyjlKXy4ICajA0RBN1BO9f9jeWFlkanRbe
	 an2d8I7/wbjCwudfqkdymvJIG4SSbqfiTVFu7Epd7rO2fVZhqHgAEkw2q+H7jT26jz
	 yxGdezRdDP5J7NembiVqnHybVRp2Ju6wrDmQuVQ3TH6Df8GtLANId5IRPm6ufygl+o
	 xNuNWLPBlkOyw==
Date: Tue, 2 Apr 2024 09:32:06 +0100
From: Simon Horman <horms@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/2] net: dsa: microchip: drop driver owner
 assignment
Message-ID: <20240402083206.GJ26556@kernel.org>
References: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>

On Sat, Mar 30, 2024 at 10:10:22PM +0100, Krzysztof Kozlowski wrote:
> Core in spi_register_driver() already sets the .owner, so driver
> does not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>

