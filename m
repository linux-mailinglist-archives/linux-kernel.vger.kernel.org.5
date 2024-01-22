Return-Path: <linux-kernel+bounces-32760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D747B835FC7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8E11F28554
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF78B3A1C6;
	Mon, 22 Jan 2024 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XM0iSXbg"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A372AE90;
	Mon, 22 Jan 2024 10:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705919555; cv=none; b=MhhKaODsuD2cidn5QpzuZQhRBQtpnJ5sPM2dioUjBnb79anaKUhQueAMyrchjs/iIJiKJeVBQMqOFRQ+SYt7R2q0QIZ+OdljR3lQL7PUfv9EF2nkk1+4ew+CDgUL3t5W3MokgYLctdIrnQQANuWFC7/RwNaSy1PMQnS+49ua7g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705919555; c=relaxed/simple;
	bh=3bcuHEEJjol3ORfk+55aI9k34MFRZBBDcr1e/CQUF5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LatW/e2Gsu6llCYlyeBA5koNmjZDsDBEQQocdqkuZPjY+7pKKpsDZ/ADc31oYIF6TM5rwr1HqOUhFmPruDKsAkXUUIkkj9LMUlwoqGqcgY/EHknd5fLGPQ71If1ehGunr86aam9Vt1lCUFqLiyEZ/NiHvHBdd42i4M4/G5paFj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XM0iSXbg; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705919551;
	bh=3bcuHEEJjol3ORfk+55aI9k34MFRZBBDcr1e/CQUF5Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XM0iSXbg2Nziyyd6ztgNjUnTTcdenVcJcypAmL712TiILIukqJ3aBlQUai6mbImwM
	 01yzQ34o1C01otXnih1MZDJ8xauoAn5del8Yw0VRUD/aEzVr5IsnFLJ7BqIO4opzjG
	 ffsBvmy4fExNxhIyyuptoYDu/kJXljnGhfqHe1NOYOj32CHFX4XSjx6cCzGaSATVYF
	 6/Q6i7E402AIZGUgIa0PosgityNEQkFod+gRi86pRxsYZM7TZVGAuQHBf4qYuTXxWT
	 Eidj2wtfS/ggjRMp15YiZB6s9WL38sQy6f1sXgPUhwbPBvVF0ZI7dLUWgq4+rTBDve
	 eHLCzX4l2Ef8g==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B3598378045F;
	Mon, 22 Jan 2024 10:32:30 +0000 (UTC)
Message-ID: <12b7b339-498b-45c1-bc5e-05e07660aefa@collabora.com>
Date: Mon, 22 Jan 2024 11:32:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: mt6360-tcpc: Drop
 interrupt-names
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: chunfeng.yun@mediatek.com, gregkh@linuxfoundation.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, linux@roeck-us.net, heikki.krogerus@linux.intel.com,
 cy_huang@richtek.com, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240119094105.98312-1-angelogioacchino.delregno@collabora.com>
 <20240119-eldest-discharge-e2d3812be0a9@spud>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240119-eldest-discharge-e2d3812be0a9@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/01/24 17:32, Conor Dooley ha scritto:
> On Fri, Jan 19, 2024 at 10:41:04AM +0100, AngeloGioacchino Del Regno wrote:
>> This IP has only one interrupt, hence interrupt-names is not necessary
>> to have.
>> Since there is no user yet, simply remove interrupt-names.
> 
> I'm a bit confused chief. Patch 2 in this series removes a user of this
> property from a driver, so can you explain how this statement is true?
> 
> Maybe I need to drink a few cans of Monster and revisit this patchset?
> 

What I mean with "there is no user" is that there's no device tree with any
mt6360-tcpc node upstream yet, so there is no meaningful ABI breakage.
Different story would be if there was a device tree using this already, in
which case, you can make a required property optional but not remove it.

Anything wrong?! :-)

Cheers,
Angelo


> Thanks,
> Conor.
> 
>> ---
>>   .../devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml        | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
>> index 053264e60583..339bc9c00ac0 100644
>> --- a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
>> +++ b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
>> @@ -22,10 +22,6 @@ properties:
>>     interrupts:
>>       maxItems: 1
>>   
>> -  interrupt-names:
>> -    items:
>> -      - const: PD_IRQB
>> -
>>     connector:
>>       type: object
>>       $ref: ../connector/usb-connector.yaml#
>> @@ -58,7 +54,6 @@ examples:
>>           tcpc {
>>             compatible = "mediatek,mt6360-tcpc";
>>             interrupts-extended = <&gpio26 3 IRQ_TYPE_LEVEL_LOW>;
>> -          interrupt-names = "PD_IRQB";
>>   
>>             connector {
>>               compatible = "usb-c-connector";
>> -- 
>> 2.43.0
>>


