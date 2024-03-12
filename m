Return-Path: <linux-kernel+bounces-100224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4808793B2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3C11C212DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAA3811F8;
	Tue, 12 Mar 2024 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="TTdCiPqk"
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FAC80BF5;
	Tue, 12 Mar 2024 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244843; cv=none; b=fduS2/KeOwsvqN90GG5tup7VYWAfnNZv+uhkUqcGeQaaRc3h8UDAGK5qaFKQXoWyK1Oqi8lODRm28T2ni0oaA60YjZDbuwEFBI14ND8FcPTjSbVNRYxICZ7YYuyyfV0ZV15yUI2QJOk4vQEKAr9TNB/uGZNjU36awQwT/4r00m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244843; c=relaxed/simple;
	bh=ECvTdEoAjK3wzw4q4k0AY533HkqELBjzkJcJlUf2zXU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=czoqGZvV6MgnIGhGP8Zz22Es2PlIJ9fg/1AzEEXdkEXYSBw9PbQ5zK0MiPOa7z1xITTPkxqI4bPbosHeTOeO3WZyN6XyYi7p6BvwNkizxREjzp0ef985YSCcjuTZESymAbopUxJmJVaLlmgLrBfFp5GJPhRdjJ0GEEgaufxr4aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=TTdCiPqk; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 5375941AAD;
	Tue, 12 Mar 2024 17:00:29 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1710244836; bh=ECvTdEoAjK3wzw4q4k0AY533HkqELBjzkJcJlUf2zXU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TTdCiPqkNVqozm0hSc+6i6uFw+Sjn2QQpT2Ye3bNmXBdN1kf+MNKQZ51ECrUxOJQ8
	 JX67cn7Qc5XQrEE9F3rJGRQaOaodFzw+pkNzaEoowt9z/VNfnnvtzTOkxM+qsgX2q2
	 Gpzqv7ZziNWPpQPDar/LMHbIn7pURNDp6TY6KMnpglKYG+aJ+EiS7NUqMcR3RH6KBS
	 B7Gw+wfYnEvw8e/y/x90YDnXePJpVJUGYjrdmGiGDQ8ftbIMPbboZYCAKX8wxmg3Q1
	 TIivPIRjPt6t4b+9Vr34bcwzE3qa67RyewEbnr5YvCN+x8hx5OWZli5sAN7oqObklK
	 AXARBiikrYrBg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 12 Mar 2024 17:00:23 +0500
From: Nikita Travkin <nikita@trvn.ru>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Sebastian Reichel <sre@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 cros-qcom-dts-watchers@chromium.org, Andy Gross <agross@kernel.org>, Bjorn
 Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 2/4] platform: Add ARM64 platform directory
In-Reply-To: <4b65793d-0196-0118-6304-b078eaacd482@linux.intel.com>
References: <20240312-aspire1-ec-v4-0-bd8e3eea212f@trvn.ru>
 <20240312-aspire1-ec-v4-2-bd8e3eea212f@trvn.ru>
 <4b65793d-0196-0118-6304-b078eaacd482@linux.intel.com>
Message-ID: <73b554ac76f404a485d2bb3b34dca962@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Ilpo Järvinen писал(а) 12.03.2024 16:40:
> On Tue, 12 Mar 2024, Nikita Travkin wrote:
> 
>> Some ARM64 based laptops and computers require vendor/board specific
>> drivers for their embedded controllers. Even though usually the most
>> important functionality of those devices is implemented inside ACPI,
>> unfortunately Linux doesn't currently have great support for ACPI on
>> platforms like Qualcomm Snapdragon that are used in most ARM64 laptops
>> today. Instead Linux relies on Device Tree for Qualcomm based devices
>> and it's significantly easier to reimplement the EC functionality in
>> a dedicated driver than to make use of ACPI code.
>>
>> This commit introduces a new platform/arm64 subdirectory to give a
>> place to such drivers for EC-like devices.
>>
>> A new MAINTAINERS entry is added for this directory. Patches to files in
>> this directory will be taken up by the platform-drivers-x86 team (i.e.
>> Hans de Goede and Mark Gross).
> 
> Mark -> me.

Oops, copied without noticing that, sorry, will reword.

> 
>> +ARM64 PLATFORM DRIVERS
>> +M:	Hans de Goede <hdegoede@redhat.com>
>> +M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> +L:	platform-driver-x86@vger.kernel.org
>> +S:	Maintained
>> +Q:	https://patchwork.kernel.org/project/platform-driver-x86/list/
>> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
>> +F:	drivers/platform/arm64/
> 
> Is some ARM64 person going to pay attention to these patches (you or 
> perhaps somebody else)?
> 
> It's perfectly fine to have some ARM64 person(s) listed as an additional 
> maintainer there even if the patches themselves are routed through Hans 
> and me (and pdx86 tree). With Mellanox and Surface platform drivers which 
> are also routed through pdx86 tree, we have Hans + me + 3rd person listed 
> as maintainers.
> 
> (This is not to force anything on anyone but it could be beneficial if 
> somebody more familiar with ARM64 is in the loop.)

I've just replied to Bryan with my thoughts on this, but if you think
explicit arm list would be good here, we could indeed add linux-arm-msm
for now as Bryan suggested.

Nikita

