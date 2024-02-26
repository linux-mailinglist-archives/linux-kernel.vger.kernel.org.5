Return-Path: <linux-kernel+bounces-81465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D3F86764E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3339DB21914
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285DA128360;
	Mon, 26 Feb 2024 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLb5ucUB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1731C6B0;
	Mon, 26 Feb 2024 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953551; cv=none; b=bhjn9O9RmW/qhmfaGnycLsRZdrcnBrYCE7TTy8tKXhwels8t4hLp9Cv8x5fkG3yWzuq7RBE7ZZklJnRWMI4vI8YyHBEct3DJAwPg5+/l1U5JFpWgp0CCg9NxDAenNpJoeAJn098i1FW/b0UKZxBniHrj8nOEoky7ZEtKZEm4sWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953551; c=relaxed/simple;
	bh=HBsVccxSNxv26lBX/VuGdylXD0W8SDHVP7TBViLLh1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VV0yBcZlxBj9HO6bIX0k4jSUnxBsLLMyuI91HuAWHtnAfLIOw83o4UJFcs+C7BTdipjaTV1eG6iY8A4EKd025+ID/yA2XV30MvPenWd81Lo7BLoDmINFodCD1hfA9yPJn7mNraFpi7ZVhA8K6y4oCayfXhHCS0L5aQEQxcHEdfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLb5ucUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFA3C433C7;
	Mon, 26 Feb 2024 13:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708953550;
	bh=HBsVccxSNxv26lBX/VuGdylXD0W8SDHVP7TBViLLh1U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hLb5ucUBiTfbxjjr2QmBkznJfek11WH5eQYPxJpMIcxvOvaBwZTV3vpqnMVUMYcR3
	 yozacW65Mb9/3Gt0CJnieXcJTAk8088rHIS8r/UUBgilgciaT2dgFYnU5SnpgrV9Aw
	 VluPV/mH2bn5nlRF5phXoIQeBlLrnHOFpL+VKvpzQk6GCrs4lvCKP6JyciMPCRk+2U
	 NGQ/AYJ1Bt9vcn4glsQOHyP9Br28iRb60S+kwPtSWCHqdKfSHIbP9jXsskfA/R7pXU
	 xlJkdZOyVAjH56bBA2GBFhAplOvAuvdpSDAMy8iEOzNRPsRBge4UeywevtAW9Ailj7
	 DrDdPzGND2sZA==
Message-ID: <9554348e-2269-4f7d-a06a-9dcaac7b4301@kernel.org>
Date: Mon, 26 Feb 2024 15:19:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] usb: dwc3-am62: fix error on module removal
Content-Language: en-US
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, "nm@ti.com" <nm@ti.com>,
 "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>, "afd@ti.com" <afd@ti.com>,
 "b-liu@ti.com" <b-liu@ti.com>, "srk@ti.com" <srk@ti.com>,
 "francesco@dolcini.it" <francesco@dolcini.it>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20240214-for-v6-9-am62-usb-errata-3-0-v3-0-147ec5eae18c@kernel.org>
 <20240214-for-v6-9-am62-usb-errata-3-0-v3-2-147ec5eae18c@kernel.org>
 <20240223223118.3awhuee5kgoebngy@synopsys.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240223223118.3awhuee5kgoebngy@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 24/02/2024 00:31, Thinh Nguyen wrote:
> On Wed, Feb 14, 2024, Roger Quadros wrote:
>> As runtime PM is enabled, the module can be runtime
>> suspended when .remove() is called.
>>
>> Do a pm_runtime_get_sync() to make sure module is active
>> before doing any register operations.
>>
>> Doing a pm_runtime_put_sync() should disable the refclk
>> so no need to disable it again.
>>
>> Fixes the below warning at module removel.
>>
>> [   39.705310] ------------[ cut here ]------------
>> [   39.710004] clk:162:3 already disabled
>> [   39.713941] WARNING: CPU: 0 PID: 921 at drivers/clk/clk.c:1090 clk_core_disable+0xb0/0xb8
>>
> 
> Actually, it will be better to have a fixes tag and separate this from
> this series series. You can retain my Acked-by if you resend it with the
> Fixes tag and Cc stable.

OK I will resend. please see below.
> 
> BR,
> Thinh
> 
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>> Changelog:
>>
>> v3: no change
>>
>> v2: no change
>> 	https://urldefense.com/v3/__https://lore.kernel.org/all/20240205141221.56076-3-rogerq@kernel.org/__;!!A4F2R9G_pg!b7_3vmJpNLOFy3g_wExMQSAzi949O4PoID3e4rNEvAsbgCvxxkj0DiSDFJxF7857DZM7qy9DMkH6Q5BPD-jX$ 
>>
>> v1: https://urldefense.com/v3/__https://lore.kernel.org/all/20240201121220.5523-3-rogerq@kernel.org/__;!!A4F2R9G_pg!b7_3vmJpNLOFy3g_wExMQSAzi949O4PoID3e4rNEvAsbgCvxxkj0DiSDFJxF7857DZM7qy9DMkH6Q1CciylE$ 
>> ---
>>  drivers/usb/dwc3/dwc3-am62.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
>> index 1bfc9e67614f..600ba9cfefea 100644
>> --- a/drivers/usb/dwc3/dwc3-am62.c
>> +++ b/drivers/usb/dwc3/dwc3-am62.c
>> @@ -273,6 +273,11 @@ static void dwc3_ti_remove(struct platform_device *pdev)
>>  	struct dwc3_am62 *am62 = platform_get_drvdata(pdev);
>>  	u32 reg;
>>  
>> +	pm_runtime_get_sync(dev);
>> +
>> +	device_wakeup_disable(dev);
>> +	device_set_wakeup_capable(dev, false);
>> +

I'll split the wakeup disable changes to a separate patch, so there are less dependencies.

>>  	of_platform_depopulate(dev);
>>  
>>  	/* Clear mode valid bit */
>> @@ -281,7 +286,6 @@ static void dwc3_ti_remove(struct platform_device *pdev)
>>  	dwc3_ti_writel(am62, USBSS_MODE_CONTROL, reg);
>>  
>>  	pm_runtime_put_sync(dev);
>> -	clk_disable_unprepare(am62->usb2_refclk);
>>  	pm_runtime_disable(dev);
>>  	pm_runtime_set_suspended(dev);
>>  }
>>
>> -- 
>> 2.34.1
>>

-- 
cheers,
-roger

