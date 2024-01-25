Return-Path: <linux-kernel+bounces-39224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1F483CD0C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8493728323B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE57135A66;
	Thu, 25 Jan 2024 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eVAl53H7"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8478073175;
	Thu, 25 Jan 2024 20:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212848; cv=none; b=LU/Kf3ZS+zMLXyPNRvIEImekz+FmTRqYfGxJt6v0CXIjY8sEAf2p1joq9YItVXw2lMSTqjisn2L4Gj7TiwL9QlvcVELRAE+kC9BYrR7yZBCUMHklL7OLk5DeB61OG8n2zZdfbXEHYixXr2SUyv/oYmTKai8a2fgnbgV4/aeCxMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212848; c=relaxed/simple;
	bh=wQCJG8XrSkewX3nDASD2zqENpUoEaBxBVuCdAZFcB4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cehgWeYQca6eX5fS6wbUlrE9lENAeGTajlSjsZxVToGzB+l+P+/rx4qVNTC7C4G8QkX6FhE1frGTcyPrciGyMnNNx1OwAlbGssLbmk6pWLGTtTdd0aCAX/leG07jmLpx8hOENFv9lpExwkoIpr0Hxen7H8KySkJ+KCi1KXCUc7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eVAl53H7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706212844;
	bh=wQCJG8XrSkewX3nDASD2zqENpUoEaBxBVuCdAZFcB4E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eVAl53H7crEget/5/q9d3K0nzEEORZfv5ZccKS0rAg3aVXWGufNsFCtKrNGInyf4I
	 iPOkMnufxDcv9yBv+HozfhXRSc2CFymDXpVqRwlBTq1BfHvDhWCv7z/CT+nkDvAt8a
	 ULA9iFLRojCcKIJqx2I0ItmzcLy4/LZnt/TVbU8+pyIFNX9jTXUqVQ4L48njnDDKQi
	 D3S8RUNQdpNNjwZLxsJ+FulKyKot3QkyQlTy/LvAqaSh9DNxVb+P7/3rY7X43lLPNr
	 RflTB+xeTYwGNnzH3okkbHMIo3hI4mhLzxcAKL+JdSv22If2HgW+otjxUiiTqOv35U
	 +0BTy5d8j8Zpw==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 96C193782021;
	Thu, 25 Jan 2024 20:00:43 +0000 (UTC)
Message-ID: <32ea6c65-212b-489b-a559-d49f9f7eeadf@collabora.com>
Date: Thu, 25 Jan 2024 22:00:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH 0/3] Add support for RK3588 HDMI/DP Combo PHY
Content-Language: en-US
To: Heiko Stuebner <heiko@sntech.de>, Johan Jonker <jbx6244@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Algea Cao <algea.cao@rock-chips.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Conor Dooley <conor+dt@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Andy Yan <andy.yan@rock-chips.com>, Vinod Koul <vkoul@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com, devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240119193806.1030214-1-cristian.ciocaltea@collabora.com>
 <170621254052.1850726.5970136297823229036.b4-ty@sntech.de>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <170621254052.1850726.5970136297823229036.b4-ty@sntech.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/24 21:56, Heiko Stuebner wrote:
> On Fri, 19 Jan 2024 21:38:00 +0200, Cristian Ciocaltea wrote:
>> Add driver and bindings to support the Rockchip HDMI/eDP TX Combo PHY
>> found on RK3588 SoC.
>>
>> The PHY is based on a Samsung IP block and supports HDMI 2.1 TMDS, FRL
>> and eDP links.
>>
>> The HDMI link has been tested on Rock 5B and EVB1 boards.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/3] dt-bindings: soc: rockchip: Add rk3588 hdptxphy syscon
>       commit: 738227ab42fe0c6047f932aef11b9fd647d203f9
> 
> I've grabbed this one already, to keep my GRFs together :-)

Great, thanks!

