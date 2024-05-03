Return-Path: <linux-kernel+bounces-167976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 038498BB1C6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A081C2337A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596FB157E98;
	Fri,  3 May 2024 17:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="O7b4jx1c"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D635629401
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714757166; cv=none; b=TUCtzCmpBDPsVt/d6Go0scj5jpKNVwaxr6iJh7nA20+xKHMLPuwBWYOf0M2ehniW0ytCBEJ6MesYPDX1T1gkhKIGpa8G7Wni6wSkC6mPFORrkrqYSCuPva205Rb71cHoeOmuuHU//POeu22///Gy51d/Wy0shtlaaLcdDn27cCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714757166; c=relaxed/simple;
	bh=D3RFx57xyuLVJqpsMJ8kEzc1L3aXJ+bsrmn0X9GhCAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ok/Qi8Q81EY4U+4l1LaOX+tHkOYJqyH7otYR5bOK82FEC6POsaB5gKUV3h55djwR1vW6WmjYddoNCj0vY2oyv6uvF2WKpSaoyeKGxOsYzjHZaLb6uK0D3gqLVA9MvFO6zDxx6dyOGPaa/THhR0sPsUpHfd1l+vkvGebRF0+RFhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=O7b4jx1c; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-152-88-126.elisa-laajakaista.fi [91.152.88.126])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 049E9593;
	Fri,  3 May 2024 19:24:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1714757095;
	bh=D3RFx57xyuLVJqpsMJ8kEzc1L3aXJ+bsrmn0X9GhCAY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O7b4jx1cVQpBOagkeORtDpsW0mtX4C+pWa5vONAkqPjUSHZpUVXvTNpzaK5JLd6EN
	 f3WjlNde+JzVsU/fzad2T7G41t8sbmuZh6SmkBysIYcELBQdqTDI3jSwvijqUn6+sW
	 XblhlqZhvniin4tIjSpmaGhW1WBav1Eg8bqg4GSI=
Message-ID: <2002d2b4-ab0c-4c35-9693-c2b82054262c@ideasonboard.com>
Date: Fri, 3 May 2024 20:25:49 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Fix Kernel CI issues
To: Nathan Chancellor <nathan@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>
Cc: Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Michal Simek <michal.simek@amd.com>
References: <20240426-dp-live-fmt-fix-v3-0-e904b5ae51d7@amd.com>
 <2a14d8ff-a8f5-4ebe-9f0e-a5554b417f0c@ideasonboard.com>
 <20240503162733.GA4136865@thelio-3990X>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 xsFNBE6ms0cBEACyizowecZqXfMZtnBniOieTuFdErHAUyxVgtmr0f5ZfIi9Z4l+uUN4Zdw2
 wCEZjx3o0Z34diXBaMRJ3rAk9yB90UJAnLtb8A97Oq64DskLF81GCYB2P1i0qrG7UjpASgCA
 Ru0lVvxsWyIwSfoYoLrazbT1wkWRs8YBkkXQFfL7Mn3ZMoGPcpfwYH9O7bV1NslbmyJzRCMO
 eYV258gjCcwYlrkyIratlHCek4GrwV8Z9NQcjD5iLzrONjfafrWPwj6yn2RlL0mQEwt1lOvn
 LnI7QRtB3zxA3yB+FLsT1hx0va6xCHpX3QO2gBsyHCyVafFMrg3c/7IIWkDLngJxFgz6DLiA
 G4ld1QK/jsYqfP2GIMH1mFdjY+iagG4DqOsjip479HCWAptpNxSOCL6z3qxCU8MCz8iNOtZk
 DYXQWVscM5qgYSn+fmMM2qN+eoWlnCGVURZZLDjg387S2E1jT/dNTOsM/IqQj+ZROUZuRcF7
 0RTtuU5q1HnbRNwy+23xeoSGuwmLQ2UsUk7Q5CnrjYfiPo3wHze8avK95JBoSd+WIRmV3uoO
 rXCoYOIRlDhg9XJTrbnQ3Ot5zOa0Y9c4IpyAlut6mDtxtKXr4+8OzjSVFww7tIwadTK3wDQv
 Bus4jxHjS6dz1g2ypT65qnHen6mUUH63lhzewqO9peAHJ0SLrQARAQABzTBUb21pIFZhbGtl
 aW5lbiA8dG9taS52YWxrZWluZW5AaWRlYXNvbmJvYXJkLmNvbT7CwY4EEwEIADgWIQTEOAw+
 ll79gQef86f6PaqMvJYe9QUCX/HruAIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRD6
 PaqMvJYe9WmFD/99NGoD5lBJhlFDHMZvO+Op8vCwnIRZdTsyrtGl72rVh9xRfcSgYPZUvBuT
 VDxE53mY9HaZyu1eGMccYRBaTLJSfCXl/g317CrMNdY0k40b9YeIX10feiRYEWoDIPQ3tMmA
 0nHDygzcnuPiPT68JYZ6tUOvAt7r6OX/litM+m2/E9mtp8xCoWOo/kYO4mOAIoMNvLB8vufi
 uBB4e/AvAjtny4ScuNV5c5q8MkfNIiOyag9QCiQ/JfoAqzXRjVb4VZG72AKaElwipiKCWEcU
 R4+Bu5Qbaxj7Cd36M/bI54OrbWWETJkVVSV1i0tghCd6HHyquTdFl7wYcz6cL1hn/6byVnD+
 sR3BLvSBHYp8WSwv0TCuf6tLiNgHAO1hWiQ1pOoXyMEsxZlgPXT+wb4dbNVunckwqFjGxRbl
 Rz7apFT/ZRwbazEzEzNyrBOfB55xdipG/2+SmFn0oMFqFOBEszXLQVslh64lI0CMJm2OYYe3
 PxHqYaztyeXsx13Bfnq9+bUynAQ4uW1P5DJ3OIRZWKmbQd/Me3Fq6TU57LsvwRgE0Le9PFQs
 dcP2071rMTpqTUteEgODJS4VDf4lXJfY91u32BJkiqM7/62Cqatcz5UWWHq5xeF03MIUTqdE
 qHWk3RJEoWHWQRzQfcx6Fn2fDAUKhAddvoopfcjAHfpAWJ+ENc7BTQROprNHARAAx0aat8GU
 hsusCLc4MIxOQwidecCTRc9Dz/7U2goUwhw2O5j9TPqLtp57VITmHILnvZf6q3QAho2QMQyE
 DDvHubrdtEoqaaSKxKkFie1uhWNNvXPhwkKLYieyL9m2JdU+b88HaDnpzdyTTR4uH7wk0bBa
 KbTSgIFDDe5lXInypewPO30TmYNkFSexnnM3n1PBCqiJXsJahE4ZQ+WnV5FbPUj8T2zXS2xk
 0LZ0+DwKmZ0ZDovvdEWRWrz3UzJ8DLHb7blPpGhmqj3ANXQXC7mb9qJ6J/VSl61GbxIO2Dwb
 xPNkHk8fwnxlUBCOyBti/uD2uSTgKHNdabhVm2dgFNVuS1y3bBHbI/qjC3J7rWE0WiaHWEqy
 UVPk8rsph4rqITsj2RiY70vEW0SKePrChvET7D8P1UPqmveBNNtSS7In+DdZ5kUqLV7rJnM9
 /4cwy+uZUt8cuCZlcA5u8IsBCNJudxEqBG10GHg1B6h1RZIz9Q9XfiBdaqa5+CjyFs8ua01c
 9HmyfkuhXG2OLjfQuK+Ygd56mV3lq0aFdwbaX16DG22c6flkkBSjyWXYepFtHz9KsBS0DaZb
 4IkLmZwEXpZcIOQjQ71fqlpiXkXSIaQ6YMEs8WjBbpP81h7QxWIfWtp+VnwNGc6nq5IQDESH
 mvQcsFS7d3eGVI6eyjCFdcAO8eMAEQEAAcLBXwQYAQIACQUCTqazRwIbDAAKCRD6PaqMvJYe
 9fA7EACS6exUedsBKmt4pT7nqXBcRsqm6YzT6DeCM8PWMTeaVGHiR4TnNFiT3otD5UpYQI7S
 suYxoTdHrrrBzdlKe5rUWpzoZkVK6p0s9OIvGzLT0lrb0HC9iNDWT3JgpYDnk4Z2mFi6tTbq
 xKMtpVFRA6FjviGDRsfkfoURZI51nf2RSAk/A8BEDDZ7lgJHskYoklSpwyrXhkp9FHGMaYII
 m9EKuUTX9JPDG2FTthCBrdsgWYPdJQvM+zscq09vFMQ9Fykbx5N8z/oFEUy3ACyPqW2oyfvU
 CH5WDpWBG0s5BALp1gBJPytIAd/pY/5ZdNoi0Cx3+Z7jaBFEyYJdWy1hGddpkgnMjyOfLI7B
 CFrdecTZbR5upjNSDvQ7RG85SnpYJTIin+SAUazAeA2nS6gTZzumgtdw8XmVXZwdBfF+ICof
 92UkbYcYNbzWO/GHgsNT1WnM4sa9lwCSWH8Fw1o/3bX1VVPEsnESOfxkNdu+gAF5S6+I6n3a
 ueeIlwJl5CpT5l8RpoZXEOVtXYn8zzOJ7oGZYINRV9Pf8qKGLf3Dft7zKBP832I3PQjeok7F
 yjt+9S+KgSFSHP3Pa4E7lsSdWhSlHYNdG/czhoUkSCN09C0rEK93wxACx3vtxPLjXu6RptBw
 3dRq7n+mQChEB1am0BueV1JZaBboIL0AGlSJkm23kw==
In-Reply-To: <20240503162733.GA4136865@thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/05/2024 19:27, Nathan Chancellor wrote:
> Hi Tomi,
> 
> On Sat, Apr 27, 2024 at 10:48:16AM +0300, Tomi Valkeinen wrote:
>> On 26/04/2024 22:27, Anatoliy Klymenko wrote:
>>> Fix number of CI reported W=1 build issues.
>>>
>>> Patch 1/2: Fix function arguments description.
>>> Closes: https://lore.kernel.org/oe-kbuild-all/202404260616.KFGDpCDN-lkp@intel.com/
>>>
>>> Patch 2/2: Fix clang compilation error.
>>> Closes: https://lore.kernel.org/oe-kbuild-all/202404260946.4oZXvHD2-lkp@intel.com/
>>>
>>> Signed-off-by: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
>>> ---
>>> Changes in v3:
>>> - Add Signed-off-by tag.
>>>
>>> - Link to v2: https://lore.kernel.org/r/20240425-dp-live-fmt-fix-v2-0-6048e81211de@amd.com
>>>
>>> Changes in v2:
>>> - Compilation error fix added.
>>>
>>> - Link to v1: https://lore.kernel.org/r/20240425-dp-live-fmt-fix-v1-1-405f352d3485@amd.com
>>>
>>> ---
>>> Anatoliy Klymenko (2):
>>>         drm: xlnx: zynqmp_dpsub: Fix few function comments
>>>         drm: xlnx: zynqmp_dpsub: Fix compilation error
>>>
>>>    drivers/gpu/drm/xlnx/zynqmp_disp.c | 6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>> ---
>>> base-commit: 2bdb481bf7a93c22b9fea8daefa2834aab23a70f
>>> change-id: 20240425-dp-live-fmt-fix-a10bf7973596
>>>
>>> Best regards,
>>
>> Thanks, pushed to drm-misc-next.
> 
> I think the second patch also needs to go to drm-misc-next-fixes? The
> clang warning fixed by it has returned in next-20240503 because it
> appears that for-linux-next was switch from drm-misc-next to
> drm-misc-next-fixes, as I see for-linux-next was pointing to commit
> 235e60653f8d ("drm/debugfs: Drop conditionals around of_node pointers")
> on drm-misc-next in next-20240502 but it is now pointing to commit
> be3f3042391d ("drm: zynqmp_dpsub: Always register bridge") on
> drm-misc-next-fixes in next-20240503.

Oh. Hmm, did I just hit the feature-freeze point with the fixes...

Now I'm unsure where I should push these (if anywhere), as they already 
are in drm-misc-next.

DRM Misc maintainers, can you give me a hint? =)

  Tomi


