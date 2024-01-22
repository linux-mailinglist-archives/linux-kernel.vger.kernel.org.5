Return-Path: <linux-kernel+bounces-32749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27285835FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7FE1C25443
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B621C3A8EE;
	Mon, 22 Jan 2024 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3ipDCBV1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7337A3A8C7;
	Mon, 22 Jan 2024 10:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705919237; cv=none; b=IBwGoOK5OnV8PD8H4KPGwseamiw4PJQrlhQhPEz9VXQc1P9zX0h4rqwxvHqYDUeeuLkKJ7juAnhjHJf0CKuncZ5kHg6Jn1B01rE4jmsLIVaO0zVKg+4ZkX6e8hVog3b3ZbccJYTMYI+6yjraTtJhx44+kTGTylnIXhFIpqlph3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705919237; c=relaxed/simple;
	bh=FY7Gp4Bm7Ak1n3UKFzuIDhZpSZ7yf3MtGEoBq1h4qog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BlRp6oAP2MxjhBywZtPpbn2FjUvN5JogThJeZBvnHUC0ql9PrSJZYi11XfqhnnFT/r/0qk5cTSdJ6IdIuBrWOzm7J+DZCBchJMAUMCZqhVbHRBOF0Qfqa6LlqGlh1JjUhHjgkgIwLdVG7C9zQSDeGycQ1OQNG/QT04Ge+MaHfA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3ipDCBV1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705919233;
	bh=FY7Gp4Bm7Ak1n3UKFzuIDhZpSZ7yf3MtGEoBq1h4qog=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=3ipDCBV1tGi+R57x5vNj70y1cbLC1IqLgywON8LSpS/kJiTvskpj1mqM3B6xogwW5
	 gudbyZeFgyUWu0X2rVXe+vWdTwhABaT63vlwVrpwGmWCy1PHmWMVqQOsbe1I7LWTQK
	 BKKXDLYDUEUxW6JTdLORZzK9kU7eVXtrOUsaD9V5RtYTNfqQbZqzuChRS3ZZfjHQ/T
	 VAYhTigFRb3nrOB83GVB7pWzUN72isGFkQ2/ndbC4oIy3vE9X19DxSgUIHAq1gMe9A
	 g9LXeur952anKfWqujvlxqVlqNGu5JyYCcvu/9tLCcCqhgstn8XXl9hyvP3zPKLiNV
	 wVj/nuwT9yGLA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6E147378045F;
	Mon, 22 Jan 2024 10:27:12 +0000 (UTC)
Message-ID: <9605c20a-12ad-49ad-8114-d59f2f772514@collabora.com>
Date: Mon, 22 Jan 2024 11:27:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Introduce ITE IT5205 Alt. Mode
 Passive MUX
To: Conor Dooley <conor@kernel.org>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 heikki.krogerus@linux.intel.com, matthias.bgg@gmail.com,
 dmitry.baryshkov@linaro.org, neil.armstrong@linaro.org,
 andersson@kernel.org, nathan@kernel.org, luca.weiss@fairphone.com,
 tianping.fang@mediatek.com, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20240119125812.239197-1-angelogioacchino.delregno@collabora.com>
 <20240119125812.239197-2-angelogioacchino.delregno@collabora.com>
 <20240119-remedial-unripe-2a3a46b4f117@spud>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240119-remedial-unripe-2a3a46b4f117@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/01/24 17:18, Conor Dooley ha scritto:
> On Fri, Jan 19, 2024 at 01:58:11PM +0100, AngeloGioacchino Del Regno wrote:
>> Introduce a binding for the ITE IT5205 Alternate Mode Passive MUX,
>> used for connecting, disconnecting and switching orientation and
>> control the SBU signals for alternate modes on USB Type-C ports.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../devicetree/bindings/usb/ite,it5205.yaml   | 72 +++++++++++++++++++
>>   1 file changed, 72 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/usb/ite,it5205.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/usb/ite,it5205.yaml b/Documentation/devicetree/bindings/usb/ite,it5205.yaml
>> new file mode 100644
>> index 000000000000..36ec4251b5f2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/ite,it5205.yaml
>> @@ -0,0 +1,72 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/usb/ite,it5205.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: ITE IT5202 Type-C USB Alternate Mode Passive MUX
>> +
>> +maintainers:
>> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> +  - Tianping Fang <tianping.fang@mediatek.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: ite,it5205
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  vcc-supply:
>> +    description: Power supply for VCC pin (3.3V)
>> +
>> +  mode-switch:
>> +    description: Flag the port as possible handle of altmode switching
>> +    type: boolean
>> +
>> +  orientation-switch:
>> +    description: Flag the port as possible handler of orientation switching
>> +    type: boolean
>> +
>> +  ite,ovp-enable:
>> +    description: Enable Over Voltage Protection functionality
>> +    type: boolean
> 
> Bitta devil's advocacy perhaps, but why is this DT property? Is it not
> known whether or not this is supported based on the compatible, and
> whether or not to enable it is a decision for the operating system to
> make?
> 
> 

AFAIK, not all board designs can use the OVP. On some, this may be unstable - the
use case where this can be safely enabled is when there's nothing in between the
mux and the controller, and between the mux and the port.

Cheers,
Angelo


