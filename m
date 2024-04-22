Return-Path: <linux-kernel+bounces-152970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB258AC6DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9891F2108F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20AE50281;
	Mon, 22 Apr 2024 08:24:56 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7D4482CA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713774296; cv=none; b=q6M0/sb0vzXd3d8PohvcJcQGOU8Wx2Pxs2+H8D854rI1vZLsXO1xvQAEcvmBxYY1TDWzpJxxM5tDj5fhHnkUsMqJ2xSCYWNSKxanNIiVBIFP3dUGTiD+XYpUynxTm6CqTt9Q+AlPah0rx7bJkml+WhC2jx1iC/6pkoC7wdfPeNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713774296; c=relaxed/simple;
	bh=ipo8Tkh/OO1bi5/uYHqgJEwHcimyAW/pZY1OW6jfzvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fa7BqiR4rPmX3KdVjplXlliuNtvmZcvlQquVH+unL4ekb5S2Uuzr8hoF1Z1JcmX3jj4rRaJKgJkKRQN/l9KV2ZvpQ8x6j3HnLxWEeP40Lu89LR5vnHHzTM8vYEhpW+NihFsSXfw+yG0aMtDyc6y6zYtBlSa2d9Gzgyyt0tJX0Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <h.assmann@pengutronix.de>)
	id 1ryoyk-0006hP-10; Mon, 22 Apr 2024 10:24:46 +0200
Message-ID: <f70d53d2-0494-461d-9cbb-086077324e03@pengutronix.de>
Date: Mon, 22 Apr 2024 10:24:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: regulator: pca9450: add restart handler
 priority
To: Krzysztof Kozlowski <krzk@kernel.org>, lgirdwood@gmail.com,
 broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, yibin.gong@nxp.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20240419083104.3329252-1-h.assmann@pengutronix.de>
 <20240419083104.3329252-3-h.assmann@pengutronix.de>
 <5c1c8632-3d8f-41b1-8027-54129d8cd62c@kernel.org>
From: Holger Assmann <h.assmann@pengutronix.de>
Content-Language: en-US, de-DE, de-LI
In-Reply-To: <5c1c8632-3d8f-41b1-8027-54129d8cd62c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: h.assmann@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello Krzysztof,

also thanks for the feedback on this one.

Am 19.04.24 um 15:39 schrieb Krzysztof Kozlowski:
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.

Short note: I did that prior submitting, but I did it directly for the
yaml-file and not for the directory - Those do not look the same
regarding their prefix scheme.

I will change it for my v2 and use a subject like for the directory.


> 
>> ---
>>  .../devicetree/bindings/regulator/nxp,pca9450-regulator.yaml   | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
>> index 3d469b8e97748..7cc2d6636cf52 100644
>> --- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
>> +++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
>> @@ -35,6 +35,9 @@ properties:
>>    interrupts:
>>      maxItems: 1
>>  
>> +  priority:
>> +    $ref: /schemas/power/reset/restart-handler.yaml#
> 
> You defined object, which is not explained in commit msg. This code does
> not look correct or it does not implement what you said.
> 
> Please look at existing code - do you see anything like this? No, there
> is no such code and this should raise question.

I am a bit lost on that one to be honest.

The only other instances where a "priority" for restart handling is
described are "gpio-poweroff.yaml" and "syscon-reboot.yaml". These files
are dedicated documentation for the reset bindings, so I tried to
transfer the respective entry over for my commit.

Do you suggest I should replace

+  priority:
+    $ref: /schemas/power/reset/restart-handler.yaml#

with

+allOf:
+  - $ref: /schemas/power/reset/restart-handler.yaml#

in order to properly include the context for the restart handling?
Running dt_binding_check does not indicate an issue with any of those two.


> 
> You probably want to annotate that device is a restart handler?

You mean by adding to the "description" part of the file?


Kind regards,
Holger

-- 
Pengutronix e.K.                         | Holger Assmann              |
Steuerwalder Str. 21                     | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686         | Fax:   +49-5121-206917-5555 |

