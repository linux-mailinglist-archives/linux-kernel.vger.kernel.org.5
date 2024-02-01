Return-Path: <linux-kernel+bounces-48694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF357845FD9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250A41F23E37
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66FF84FC5;
	Thu,  1 Feb 2024 18:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="hAzdaJWD"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D857E118;
	Thu,  1 Feb 2024 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811904; cv=none; b=TFu5DLki6kF+oBj+KVbGkky3I9YQSMhpco0CxwCXf2VQV+kcEcUEQnHFHWJ0bwWmekhDyK5JhVFajJincxVygVT2XT7H+M6EdfcHNp3Z6mVJVUHCjChZt6q8yGdArVd2iKOsbGeuld6anHb1TSq6uJ3DryOJOge3w48rk289efU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811904; c=relaxed/simple;
	bh=/R9DkbDmp4Tl/QovYyBD7frKHT8dWwGZkwDKQuI1NFA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=VYkDZtHhmjeLcTFgBI/2M4ovlO8yH8Xo/bdgfrCbqaBasFfeQ2w5eAqIGgwCA3M/rTvNRAn5DESdEnAr+FDxy3b9nf4awJCxFTsJoleat2M10QgM2E/FA8q9Ym6INC1paG5AvN3c7OaWepk1XidPInnjCrKVnZ6EP2zIWF8JO1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=hAzdaJWD; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0E55F9C33AF;
	Thu,  1 Feb 2024 13:24:54 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id ZNGdl7d-JH7h; Thu,  1 Feb 2024 13:24:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 202DF9C2C74;
	Thu,  1 Feb 2024 13:24:53 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 202DF9C2C74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1706811893; bh=WUJ0xiWlw9xRPJdK54m22egoVgIAQyxZK6o/wNJkTao=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=hAzdaJWDg2GDYPP84GxKXgMt+u9Q+eTH24HnnZ3OOfsteDUpEf1j770iBFYmQRhdv
	 plPutFLy/rr9ALL8PW7mOzRNDIVdEs9IfwTQ3eplvR2tnlmHb/hs6YKlqghAKdf9L9
	 rM6xdQX75PelHtlALlZmSwcQDSt2TGVYu7SyebPOxtV7IYKR0FUGdfVxi+gfCmYPYz
	 N6BkjRya3QqiVKmQuQdT6gBp01U5aOPPE2HUaEQC6MQaGPPjjdR/rWXS1139Ch/mrP
	 UB4lAJ/kZ3ecowl0OQ24FjQ7tpoE8KbxBhgP2KTyhtfMLBWaTI+znDdHSJLupakSD6
	 iRl+y5SV3vvpA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id jciq3CuDmZsX; Thu,  1 Feb 2024 13:24:53 -0500 (EST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D9CC89C2B7A;
	Thu,  1 Feb 2024 13:24:52 -0500 (EST)
Date: Thu, 1 Feb 2024 13:24:52 -0500 (EST)
From: Charles Perry <charles.perry@savoirfairelinux.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: mdf <mdf@kernel.org>, Allen VANDIVER <avandiver@markem-imaje.com>, 
	Brian CODY <bcody@markem-imaje.com>, hao wu <hao.wu@intel.com>, 
	yilun xu <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	krzysztof kozlowski+dt <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, 
	linux-fpga <linux-fpga@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel@lists.infradead.org
Message-ID: <1391244934.434321.1706811892834.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <d5fe1ec2-b647-4902-a599-fb866e96e9cf@linaro.org>
References: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com> <20240131230542.3993409-1-charles.perry@savoirfairelinux.com> <20240131230542.3993409-3-charles.perry@savoirfairelinux.com> <d5fe1ec2-b647-4902-a599-fb866e96e9cf@linaro.org>
Subject: Re: [PATCH 2/3] dt-bindings: fpga: xlnx,fpga-slave-selectmap: add
 DT schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4581 (ZimbraWebClient - FF120 (Linux)/8.8.15_GA_4581)
Thread-Topic: dt-bindings: fpga: xlnx,fpga-slave-selectmap: add DT schema
Thread-Index: aG2eE2gfRdKUBYCYyXilt6Ey1bVw9w==



----- On Feb 1, 2024, at 3:07 AM, Krzysztof Kozlowski krzysztof.kozlowski@linaro.org wrote:

> On 01/02/2024 00:05, Charles Perry wrote:
>> Document the slave SelectMAP interface of Xilinx 7 series FPGA.
>> 
>> Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
>> ---
>>  .../bindings/fpga/xlnx,fpga-selectmap.yaml    | 83 +++++++++++++++++++
>>  1 file changed, 83 insertions(+)
>>  create mode 100644
>>  Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>> b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>> new file mode 100644
>> index 0000000000000..c9a446b43cdd9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>> @@ -0,0 +1,83 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/fpga/xlnx,fpga-selectmap.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Xilinx SelectMAP FPGA interface
>> +
>> +maintainers:
>> +  - Charles Perry <charles.perry@savoirfairelinux.com>
>> +
>> +description: |
>> +  Xilinx 7 Series FPGAs support a method of loading the bitstream over a
>> +  parallel port named the SelectMAP interface in the documentation. Only
>> +  the x8 mode is supported where data is loaded at one byte per rising edge of
>> +  the clock, with the MSB of each byte presented to the D0 pin.
>> +
>> +  Datasheets:
>> +
>> https://www.xilinx.com/support/documentation/user_guides/ug470_7Series_Config.pdf
>> +
>> +allOf:
>> +  - $ref: /schemas/memory-controllers/mc-peripheral-props.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - xlnx,fpga-selectmap
> 
> Your description mentions "7 Series" which is not present in compatible
> and title. What is exactly the product here? Interface usually is not
> the final binding, so is this specific to some particular FPGA or SoC?
> 
> 
> Best regards,
> Krzysztof

This is specific to the FPGA, the 7 series encompass the following part
family:
 * Spartan-7 (XC7S6, XC7S15, ... XC7S100)
 * Artix-7 (XC7A12T, XC7A15T, ... XC7A200T)
 * Kintex-7 (XC7K70T, XC7K160T, ... XC7K480T)
 * Virtex-7 (XC7V585T, XC7V2000T, 
             XC7VX330T, XC7VX415T, ... XC7VX1140T,
             XC7VH580T, XC7VH870T)


The configuration guide of Xilinx [1] tells us that all those devices
share a common programming scheme.

I do agree that having a mention of "7 series" in the compatible name
would be beneficial as Xilinx has more FPGA than just the 7 series.
The name was inspired from "xlnx,fpga-slave-serial" which is the compatible
for the serial interface.

What about "xlnx,fpga-xc7-selectmap" ?

I'm also seeing that I missed some mention of the "slave" word in the
commit message, will fix.

Regards,
Charles

[1] https://www.xilinx.com/support/documentation/user_guides/ug470_7Series_Config.pdf



