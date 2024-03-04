Return-Path: <linux-kernel+bounces-90272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4016386FCB0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F201C21E86
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2651B5BB;
	Mon,  4 Mar 2024 09:05:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4417B1947D;
	Mon,  4 Mar 2024 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543155; cv=none; b=D1sRWdwQWK/5RHeyB5ERC5WevHXl1KtbRC5goX9w0wrjZ2LxnppX3VlaaJa1SUaIllvpnB409hDGwAYiCYQkZw1HJW9iXsQ4u152XDiVVaQxdTtIUllSvXHZos2kWuN6GFOkVKkhx3scaKhja+j5UXmkd+XlCNc8++ALa1qxVfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543155; c=relaxed/simple;
	bh=oBSQ2BaP6ONlD26Oi/FiYU4Y0o8yj3TOaconIxJdkWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gLNDs9KwfA2I5+rOm3x4EyTwlIZR5DameyZj6x9UQrY3fEOrLXiU6alIjHjlPZpJroyOGfUJikTdvWqbyeMMGJcMhgiEn1RKerLrkg9Nuoi6N346YfEjG/L+TGcQCsKxDdhqrQXzRgWse4dboiubD5he8ELwtdrtm+26En/bIRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 917181FB;
	Mon,  4 Mar 2024 01:06:30 -0800 (PST)
Received: from [10.37.129.2] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1497E3F762;
	Mon,  4 Mar 2024 01:05:51 -0800 (PST)
From: Balint Dobszay <balint.dobszay@arm.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: op-tee@lists.trustedfirmware.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 jens.wiklander@linaro.org, corbet@lwn.net, sudeep.holla@arm.com,
 rdunlap@infradead.org, krzk@kernel.org, gyorgy.szing@arm.com
Subject: Re: [PATCH v2 3/3] Documentation: tee: Add TS-TEE driver
Date: Mon, 04 Mar 2024 10:05:50 +0100
X-Mailer: MailMate (1.14r5937)
Message-ID: <96D25150-1FBC-4DEA-A202-CA85E718FAA7@arm.com>
In-Reply-To: <CAFA6WYP4WVv2H4_2PAn_BOUpYYbG1SDcWL0Gmd6c0ECiH62c_w@mail.gmail.com>
References: <20240223095133.109046-1-balint.dobszay@arm.com>
 <20240223095133.109046-4-balint.dobszay@arm.com>
 <CAFA6WYP4WVv2H4_2PAn_BOUpYYbG1SDcWL0Gmd6c0ECiH62c_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 27 Feb 2024, at 8:14, Sumit Garg wrote:

> On Fri, 23 Feb 2024 at 15:23, Balint Dobszay <balint.dobszay@arm.com> w=
rote:
>>
>> Add documentation for the Trusted Services TEE driver.
>>
>> Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
>> ---
>>  Documentation/tee/index.rst  |  1 +
>>  Documentation/tee/ts-tee.rst | 71 +++++++++++++++++++++++++++++++++++=
+
>>  2 files changed, 72 insertions(+)
>>  create mode 100644 Documentation/tee/ts-tee.rst
>>
>
> Acked-by: Sumit Garg <sumit.garg@linaro.org>
>
> -Sumit

Thanks, I'll apply the tag in the next version.

Regards,
Balint

>> diff --git a/Documentation/tee/index.rst b/Documentation/tee/index.rst=

>> index a23bd08847e5..4be6e69d7837 100644
>> --- a/Documentation/tee/index.rst
>> +++ b/Documentation/tee/index.rst
>> @@ -10,6 +10,7 @@ TEE Subsystem
>>     tee
>>     op-tee
>>     amd-tee
>> +   ts-tee
>>
>>  .. only::  subproject and html
>>
>> diff --git a/Documentation/tee/ts-tee.rst b/Documentation/tee/ts-tee.r=
st
>> new file mode 100644
>> index 000000000000..843e34422648
>> --- /dev/null
>> +++ b/Documentation/tee/ts-tee.rst
>> @@ -0,0 +1,71 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +TS-TEE (Trusted Services project)
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +This driver provides access to secure services implemented by Trusted=
 Services.
>> +
>> +Trusted Services [1] is a TrustedFirmware.org project that provides a=
 framework
>> +for developing and deploying device Root of Trust services in FF-A [2=
] S-EL0
>> +Secure Partitions. The project hosts the reference implementation of =
the Arm
>> +Platform Security Architecture [3] for Arm A-profile devices.
>> +
>> +The FF-A Secure Partitions (SP) are accessible through the FF-A drive=
r [4] which
>> +provides the low level communication for this driver. On top of that =
the Trusted
>> +Services RPC protocol is used [5]. To use the driver from user space =
a reference
>> +implementation is provided at [6], which is part of the Trusted Servi=
ces client
>> +library called libts [7].
>> +
>> +All Trusted Services (TS) SPs have the same FF-A UUID; it identifies =
the TS RPC
>> +protocol. A TS SP can host one or more services (e.g. PSA Crypto, PSA=
 ITS, etc).
>> +A service is identified by its service UUID; the same type of service=
 cannot be
>> +present twice in the same SP. During SP boot each service in the SP i=
s assigned
>> +an "interface ID". This is just a short ID to simplify message addres=
sing.
>> +
>> +The generic TEE design is to share memory at once with the Trusted OS=
, which can
>> +then be reused to communicate with multiple applications running on t=
he Trusted
>> +OS. However, in case of FF-A, memory sharing works on an endpoint lev=
el, i.e.
>> +memory is shared with a specific SP. User space has to be able to sep=
arately
>> +share memory with each SP based on its endpoint ID; therefore a separ=
ate TEE
>> +device is registered for each discovered TS SP. Opening the SP corres=
ponds to
>> +opening the TEE device and creating a TEE context. A TS SP hosts one =
or more
>> +services. Opening a service corresponds to opening a session in the g=
iven
>> +tee_context.
>> +
>> +Overview of a system with Trusted Services components::
>> +
>> +   User space                  Kernel space                   Secure =
world
>> +   ~~~~~~~~~~                  ~~~~~~~~~~~~                   ~~~~~~~=
~~~~~
>> +   +--------+                                               +--------=
-----+
>> +   | Client |                                               | Trusted=
     |
>> +   +--------+                                               | Service=
s SP |
>> +      /\                                                    +--------=
-----+
>> +      ||                                                          /\
>> +      ||                                                          ||
>> +      ||                                                          ||
>> +      \/                                                          \/
>> +   +-------+                +----------+--------+           +--------=
-----+
>> +   | libts |                |  TEE     | TS-TEE |           |  FF-A S=
PMC  |
>> +   |       |                |  subsys  | driver |           |   + SPM=
D    |
>> +   +-------+----------------+----+-----+--------+-----------+--------=
-----+
>> +   |      Generic TEE API        |     |  FF-A  |     TS RPC protocol=
     |
>> +   |      IOCTL (TEE_IOC_*)      |     | driver |        over FF-A   =
     |
>> +   +-----------------------------+     +--------+--------------------=
-----+
>> +
>> +References
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +[1] https://www.trustedfirmware.org/projects/trusted-services/
>> +
>> +[2] https://developer.arm.com/documentation/den0077/
>> +
>> +[3] https://www.arm.com/architecture/security-features/platform-secur=
ity
>> +
>> +[4] drivers/firmware/arm_ffa/
>> +
>> +[5] https://trusted-services.readthedocs.io/en/v1.0.0/developer/servi=
ce-access-protocols.html#abi
>> +
>> +[6] https://git.trustedfirmware.org/TS/trusted-services.git/tree/comp=
onents/rpc/ts_rpc/caller/linux/ts_rpc_caller_linux.c?h=3Dv1.0.0
>> +
>> +[7] https://git.trustedfirmware.org/TS/trusted-services.git/tree/depl=
oyments/libts/arm-linux/CMakeLists.txt?h=3Dv1.0.0
>> --
>> 2.34.1
>>

