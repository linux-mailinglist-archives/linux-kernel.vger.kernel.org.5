Return-Path: <linux-kernel+bounces-149556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3053F8A92D9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF571F21BC4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3298C6A342;
	Thu, 18 Apr 2024 06:14:33 +0000 (UTC)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FBF60260;
	Thu, 18 Apr 2024 06:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713420872; cv=none; b=q+yTgaNiRixIepdFGviSdw8g7M/Gj3iWWRlgSg7O3B8IoNapk5ijHuNcNDIaiFIKPONg2QAxpRmlcf+/fCEBx42mXBr2yKBohMAC/HJq++SSb2tZACsWWBgq6EFNZmAoO5rx4yAn8f1aduhFeeLbEHrp61dNtkAQmzOnP0ZlLiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713420872; c=relaxed/simple;
	bh=3YTW1YqXYoumCOynPRD9UuIXLnp+hwGKvOmiBl56/vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=egXyiuR0PeFo6KO+vV1Tmn9/GNXPIEjAtxyXDKhhjp0/Gd+a2ejwvbbGuPrbD098DmLamEO3xBU8Siqu+Fo2mWoNVgew1/HFkyp/oxsxytNveM+mxNmkdkZ5AGWbfkChbBgELdo2pPELPOthFudkVhc80Y/a8xqWCz1nJwYGEq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: bizesmtpsz7t1713420800tgm1cll
X-QQ-Originating-IP: r/ejyZvgSRLvHsenLKM5xIQ9Ri/IXB9uPybLXv/mbNk=
Received: from [192.168.159.131] ( [106.150.157.243])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Apr 2024 14:13:17 +0800 (CST)
X-QQ-SSF: 01100000000000C0G000000A0000000
X-QQ-FEAT: r/cTxDoDoiH1Bc56LytD5jHVqtEDUAmA6aiMrRAEKAdMlrveYx4SbJi/4uT5M
	g6dLDzYLUNd4PDN/sm2r/upe7uy83xRpSvCeDnoXEFHNSQUBh8gziUn/kz9gG2oDqEwwwiO
	ipp/UUAE14D4yLjZUEvC3yWOc++7XxvvdhLGEoHBQKjm+qAvvItsnwVG1P5dkYtr2+DqPe6
	vmiJdwdaDK7OEYk/bg98ezjn5KA88NwIhvfB/tyUT4TogJK1lZhuxi1UuAXb0RQ5C5zbH3/
	I6Az/Ss/H9QhxmEoAQg/cskMU9bMK1d5b48ysLMoP20ukSsTStBKnsE1R+QwsO+T4zA+uKd
	OEKIjCa1rzvXcZRnmdrr75oYiy5RCzcBdXoXWWG7TIuH9YNqW54GQThHvQ4dv+qYVALU6nv
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2346405261263451864
Message-ID: <54A57FB24C5E1752+669a5f22-b9fc-4cb6-8df5-367331dc4658@radxa.com>
Date: Thu, 18 Apr 2024 15:13:17 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: add Radxa ROCK3 Model C
To: Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240416130010.379705-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20240416130010.379705-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:radxa.com:qybglogicsvrgz:qybglogicsvrgz6a-0

Hi,

On 4/16/24 22:00, Chukun Pan wrote:
> The Radxa ROCK3 Model C is a similar board to
> the Radxa ROCK3 Model A with the RK3566 SoC.
> Add devicetree binding documentation for it.
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>   Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 99bd5e2c76a0..dc3847bd67fe 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -777,6 +777,11 @@ properties:
>             - const: radxa,rock3a
>             - const: rockchip,rk3568
>   
> +      - description: Radxa ROCK3 Model C

please use "Radxa ROCK 3C" here too.

> +        items:
> +          - const: radxa,rock3c

and "rock-3c" here.

> +          - const: rockchip,rk3566
> +
>         - description: Radxa ROCK 5 Model A
>           items:
>             - const: radxa,rock-5a

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

