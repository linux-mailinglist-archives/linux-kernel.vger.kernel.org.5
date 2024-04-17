Return-Path: <linux-kernel+bounces-149092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF588A8BBE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1011C21AA4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B491DFCB;
	Wed, 17 Apr 2024 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toJRqIXd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05D71D52C;
	Wed, 17 Apr 2024 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713380378; cv=none; b=Mqs7gPgFKvQi4ePYi3C9q/7ktwqdblU6pabfsjEW0awePsP5DzUEW52IchGh1kBn4JZJLrF/vnQx4mkZjRsnsE1KsIAP0uPQ803cbKdE92ejwINMfINGjzotY91K0wsynP2UO5UQBTJIJWShhcZoNZVHyaboxmL8+sQoQRrkB3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713380378; c=relaxed/simple;
	bh=NUBuYhI/tPwR/CQU1XXDvBmqFVJxYglVJpqZiT9wFys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAY1w0+n29qW/Qv2tt23JV+MomxO3+hK+J759qPYBxYpcfETIU6M96ohLzosieNta7idxi9lTk45st7xccEZ/se1uyhafKxwTVrq+AKQOCH5T1DijG3Owf5XJVJWHRiPeuUDj0BVUPxlzFMVsQcqv6pmqap+iFoAFYD61bjkrG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toJRqIXd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95676C072AA;
	Wed, 17 Apr 2024 18:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713380377;
	bh=NUBuYhI/tPwR/CQU1XXDvBmqFVJxYglVJpqZiT9wFys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=toJRqIXdNJxj/Dw8Gjp3I8h8A/CExTqMdayP8G1vftau+t1DGy0eho4sbVdPyuvu5
	 HDnuCOE1jQ8e1p72iWO9RlHkBYSyq4JjdqlmT/3WM7osuluz0Wo5diHWt8cjKzg9Ow
	 4Pilgf63oUyG43IzrTX99Thnjqo12E0estLi7WWr/5pD4W1J1EoT6DWy7X80yhYa3i
	 BUgYAYWise1MqfU46ROI6hjeGVvsPzExfEqGUMCg/fjdUZm4x1YoSXeiy8tqGi/dXj
	 TGDrjwXuZnihlh9G2qiXCBGuq8yT6Debu2gbcMcGgf/epzCWwPiVUSpm27jPTnjlrx
	 arFspLbzGEd5Q==
Date: Wed, 17 Apr 2024 13:59:35 -0500
From: Rob Herring <robh@kernel.org>
To: Herman van Hazendonk <github.com@herrie.org>
Cc: benwolsieffer@gmail.com, Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>, chris.chapuis@gmail.com,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: phy: qcom,usb-hs-phy: Add compatible
Message-ID: <171338035822.3093343.24902837393327860.robh@kernel.org>
References: <20240417065020.3599755-1-github.com@herrie.org>
 <20240417065454.3599824-1-github.com@herrie.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417065454.3599824-1-github.com@herrie.org>


On Wed, 17 Apr 2024 08:54:54 +0200, Herman van Hazendonk wrote:
> Adds qcom,usb-hs-phy-msm8660 compatible
> 
> Used by HP Touchpad (tenderloin) for example.
> 
> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


