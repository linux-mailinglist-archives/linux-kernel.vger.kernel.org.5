Return-Path: <linux-kernel+bounces-134670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A70489B4AD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7941428229E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 23:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BD344C7B;
	Sun,  7 Apr 2024 23:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhKXL9sF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2C53BBFE;
	Sun,  7 Apr 2024 23:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712533726; cv=none; b=LnHIrWg1C0Dr+h/KNVX/DMgBVExzNJtprtZU9ddJufoiY1KwnB/GPtIn2ysWk4CImW4+W4potDrDzYPiXi7cZ5NTlocYlDlltQHDUMV2lTXJVKKZp46B2SeW+vwCtdo5GBjCdCgmQKZ8hgqa5gV3YLglKdcMXbIESU6aW4PLPMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712533726; c=relaxed/simple;
	bh=JIrH3QsMT/5WGDUR8zfqWVuCSjEhK7gh8q5viWx6UEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAKg7AK8v6p/EnZcSygP/hEmdgG4vBA0UC4MFvj0YJ3HT3+Hk+6mM+/R+shSRpeIphPdiDlYHeyw7XZQXgfFYXSp4Ob784SJg3VkRhGlhMgqmdiSZuJiqCgZd6s0MfqbcwvUxsdbwk5eaLIywMJk5y/jwK9V6awlCL3MxX9227M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhKXL9sF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251CDC433F1;
	Sun,  7 Apr 2024 23:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712533726;
	bh=JIrH3QsMT/5WGDUR8zfqWVuCSjEhK7gh8q5viWx6UEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FhKXL9sFQo+5bfApgbfZdE7MSjQTZHQjlN1uNH0tDYsGQ+NyFjdgRWjgtmvXQZyPr
	 mUe7CesVOmRJh2fgA2+MXXM3cr1k2xez/LJXjGJDUwJei85jxyGD3fm2JXlhHy7t6J
	 LQeiXbmOt6s1WRl6ToLDQmY5QOf4E3bIGrQdf9YLXY9ynApXQGdUu4fcTODt9G3IvQ
	 4YkcNk8ep8uGd6XfRc033x568sdK+Pb4TmZMdgHvY7RBHCkbNshIpobPRQ62tKfdjz
	 hEZb7FEBZrJuFa/yJsJriUMXp/W7Q2VruxXs/Wvfi9Si9DTHW8DiFL9RA8S4g/8TVt
	 dHcWiMFhhh2uQ==
Date: Sun, 7 Apr 2024 19:48:45 -0400
From: Sasha Levin <sashal@kernel.org>
To: Karel Balej <balejk@matfyz.cz>
Cc: Markuss Broks <markuss.broks@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, duje.mihanovic@skole.hr,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.8 78/98] input/touchscreen: imagis: add support
 for IST3032C
Message-ID: <ZhMw3fwiSrbw9r6P@sashalap>
References: <20240329123919.3087149-1-sashal@kernel.org>
 <20240329123919.3087149-78-sashal@kernel.org>
 <D06ZCKKYTQM5.3OJ6HCLHW3DZ9@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <D06ZCKKYTQM5.3OJ6HCLHW3DZ9@matfyz.cz>

On Sat, Mar 30, 2024 at 10:33:53AM +0100, Karel Balej wrote:
>Sasha,
>
>Sasha Levin, 2024-03-29T08:37:49-04:00:
>> From: Karel Balej <balejk@matfyz.cz>
>>
>> [ Upstream commit 90cb57a6c5717b83a110c0da720a03ee32ed255e ]
>>
>> IST3032C is a touchscreen chip used for instance in the
>> samsung,coreprimevelte smartphone, with which this was tested. Add the
>> chip specific information to the driver.
>>
>> Reviewed-by: Markuss Broks <markuss.broks@gmail.com>
>> Signed-off-by: Karel Balej <balejk@matfyz.cz>
>> Link: https://lore.kernel.org/r/20240301164659.13240-6-karelb@gimli.ms.mff.cuni.cz
>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  drivers/input/touchscreen/imagis.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
>> index 9af8a6332ae67..e1fafa561ee38 100644
>> --- a/drivers/input/touchscreen/imagis.c
>> +++ b/drivers/input/touchscreen/imagis.c
>> @@ -11,6 +11,8 @@
>>  #include <linux/property.h>
>>  #include <linux/regulator/consumer.h>
>>
>> +#define IST3032C_WHOAMI			0x32c
>> +
>>  #define IST3038B_REG_STATUS		0x20
>>  #define IST3038B_REG_CHIPID		0x30
>>  #define IST3038B_WHOAMI			0x30380b
>> @@ -363,6 +365,13 @@ static int imagis_resume(struct device *dev)
>>
>>  static DEFINE_SIMPLE_DEV_PM_OPS(imagis_pm_ops, imagis_suspend, imagis_resume);
>>
>> +static const struct imagis_properties imagis_3032c_data = {
>> +	.interrupt_msg_cmd = IST3038C_REG_INTR_MESSAGE,
>> +	.touch_coord_cmd = IST3038C_REG_TOUCH_COORD,
>> +	.whoami_cmd = IST3038C_REG_CHIPID,
>> +	.whoami_val = IST3032C_WHOAMI,
>> +};
>> +
>>  static const struct imagis_properties imagis_3038b_data = {
>>  	.interrupt_msg_cmd = IST3038B_REG_STATUS,
>>  	.touch_coord_cmd = IST3038B_REG_STATUS,
>> @@ -380,6 +389,7 @@ static const struct imagis_properties imagis_3038c_data = {
>>
>>  #ifdef CONFIG_OF
>>  static const struct of_device_id imagis_of_match[] = {
>> +	{ .compatible = "imagis,ist3032c", .data = &imagis_3032c_data },
>>  	{ .compatible = "imagis,ist3038b", .data = &imagis_3038b_data },
>>  	{ .compatible = "imagis,ist3038c", .data = &imagis_3038c_data },
>>  	{ },
>> --
>> 2.43.0
>
>sorry if I'm missing something, but I don't see why this should be
>backported: it doesn't fix anything, it's just adding support for new
>hardware.
>
>I can see that adding a device ID is permitted for -stable [1], but I
>thought it still has to bear some signs of a fix, such as maybe here
>[2].

It does not need to be a fix, it could just be plain device enablement.

-- 
Thanks,
Sasha

