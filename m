Return-Path: <linux-kernel+bounces-81850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22663867C09
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB44BB27604
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6000A12C532;
	Mon, 26 Feb 2024 15:55:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6901292ED
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962935; cv=none; b=J8WjqqnDj9oG6Sn9HQvI0+IPhwr7HGvrgMmhh4hKRWVEEho4z/y3Gl5jHxtgFNbwkHhV2LL55vFPoHbecrlVkMUXyHgbBMAqxjTGbvfhnm27TAZfhRoIINKYgn7E3ShqPxKOutfVzUIu7gOOrpVF5zy6i1/1N6+GOiNLMDp+xOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962935; c=relaxed/simple;
	bh=JAGh+6SAZJZ4bHoJdqCYDeKiy0nGFDLvfvHpSdf64v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VU7eqJBBsDsxMTES5Hlcp3vV/uGKt4RkzSxM0NntXaAHQX4bFXdJ5SF70VfdoF0NkCWGy60RP04Ll6duxlD6dFCazV+IM3a4xWJxgv88bTG4anPSrvPfkLQdVQcQ/IkwY0dxwAPaUQUUup3J8ZHc+tQEudhOHUbkevubFU5bQuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 870F2DA7;
	Mon, 26 Feb 2024 07:56:11 -0800 (PST)
Received: from [10.57.49.227] (unknown [10.57.49.227])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18AD53F73F;
	Mon, 26 Feb 2024 07:55:31 -0800 (PST)
Message-ID: <02138784-d9fd-4331-bb34-fe1bd2fd043f@arm.com>
Date: Mon, 26 Feb 2024 15:55:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Correcting the spelling mistakes in
 "Documentation/ABI/testing/sysfs-bus-cxl" and
 "Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc"
Content-Language: en-GB
To: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>, mike.leach@linaro.org,
 james.clark@arm.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240220214212.10231-1-pvkumar5749404@gmail.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20240220214212.10231-1-pvkumar5749404@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Prabhav,


On 20/02/2024 21:42, Prabhav Kumar Vaish wrote:

Thanks for sending the patch. Please find some comments.

> Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>

Only one "Signed-off-by:" tag is required, the second one below
is at the desired location. So, please drop the above.


> 
> Changes:
> 	- "avaialble" corrected to "available" in "Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc"
> 	- "firwmare" corrected to "firmware" in "Documentation/ABI/testing/sysfs-bus-cxl"

It is advisable to split this patch into two, as they affect files
maintained by different subsystems. i.e., coresight and CXL. Since
they go via different maintainers, it is always better to split
the patch (especially when there is no functional dependency, like
this case).

Also, I see that you haven't copied any of the maintainers for the CXL 
subsystem. Running "scripts/get_maintainer.pl" on the affected file
or the patch should give you the email addresses for the concerned
maintainers/list.

e.g:

$ scripts/get_maintainer.pl Documentation/ABI/testing/sysfs-bus-cxl

So, please resend the patch after splitting, to the respective 
maintainers/reviewers/list.

Suzuki

> Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
> ---
>   Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc | 2 +-
>   Documentation/ABI/testing/sysfs-bus-cxl                   | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
> index 96aafa66b4a5..339cec3b2f1a 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
> @@ -97,7 +97,7 @@ Date:		August 2023
>   KernelVersion:	6.7
>   Contact:	Anshuman Khandual <anshuman.khandual@arm.com>
>   Description:	(Read) Shows all supported Coresight TMC-ETR buffer modes available
> -		for the users to configure explicitly. This file is avaialble only
> +		for the users to configure explicitly. This file is available only
>   		for TMC ETR devices.
>   
>   What:		/sys/bus/coresight/devices/<memory_map>.tmc/buf_mode_preferred
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index fff2581b8033..bbf6de5a4ca1 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -224,7 +224,7 @@ Description:
>   		decoding a Host Physical Address range. Note that this number
>   		may be elevated without any regionX objects active or even
>   		enumerated, as this may be due to decoders established by
> -		platform firwmare or a previous kernel (kexec).
> +		platform firmware or a previous kernel (kexec).
>   
>   
>   What:		/sys/bus/cxl/devices/decoderX.Y


