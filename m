Return-Path: <linux-kernel+bounces-14746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E202482216F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 760452811F5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179A415ADD;
	Tue,  2 Jan 2024 18:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KC1iyssy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED1615ACE;
	Tue,  2 Jan 2024 18:54:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FB8C433C7;
	Tue,  2 Jan 2024 18:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704221681;
	bh=xX4Lln/6UdI6zrqWnFMmp4/+v7+YVcoSF10ZkFApq7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KC1iyssykDPzsGGG8MaQUfQHFqPp9xFvFt+UGJ3NoER5V7DLBYHHKxQE5/NTsvEtp
	 lAcAe9lD/iqfAocAh/G1TQrqI37A5b7whMAF9n16lm1A70c1gsXLhmN5dsE4QQl0xR
	 knYlcbH36heVUUc+OCtO+a9ycpfGU4DH44zi+oxqZlFQ2ECWjMA0zydn5+dAYbAp0E
	 VaBucANI9tpayWfHX6peiWGA8IKD77Cuxrmlv+kEfsfJ4Lt4pBNpCQMZOClBv+Lvny
	 sYb56s7uBk9Ss0gCpfBzXtDAwkdrxiNQn2+rpnwhO4McBCLAUM9G6XGKk29XfyILlx
	 CMik/wcA9IcRg==
Received: (nullmailer pid 3374826 invoked by uid 1000);
	Tue, 02 Jan 2024 18:54:39 -0000
Date: Tue, 2 Jan 2024 11:54:39 -0700
From: Rob Herring <robh@kernel.org>
To: Alex Bee <knaerzche@gmail.com>
Cc: linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Daniel Vetter <daniel@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Sandy Huang <hjc@rock-chips.com>, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, Maxime Ripard <mripard@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 01/29] dt-bindings: display: rockchip,inno-hdmi:
 Document RK3128 compatible
Message-ID: <170422164796.3374067.13785716763431704594.robh@kernel.org>
References: <20231222174220.55249-1-knaerzche@gmail.com>
 <20231222174220.55249-2-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222174220.55249-2-knaerzche@gmail.com>


On Fri, 22 Dec 2023 18:41:52 +0100, Alex Bee wrote:
> The integration for this SoC is different from the currently existing: It
> needs it's PHY's reference clock rate to calculate the DDC bus frequency
> correctly. The controller is also part of a powerdomain, so this gets added
> as an mandatory property for this variant.
> 
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> changes in v2:
>  - clarify that the controller itself is part of the powerdomain
>  - simplify clock-names
>  - made power-domains property only allowed (and required) for new variant
> 
> changes in v3:
>  - collect RB
> 
> changes in v4:
>  - none
> 
>  .../display/rockchip/rockchip,inno-hdmi.yaml  | 40 ++++++++++++++++++-
>  1 file changed, 38 insertions(+), 2 deletions(-)
> 

Since I applied the conversion I applied this one, thanks!


