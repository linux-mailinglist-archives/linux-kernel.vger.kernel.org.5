Return-Path: <linux-kernel+bounces-64369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FC4853D89
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FAB2B2B002
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9C26280D;
	Tue, 13 Feb 2024 21:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t/imcYkn"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFEB62802;
	Tue, 13 Feb 2024 21:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860691; cv=none; b=IKtyhCWekWngX8rw1Lsv12X6IJhp6lHaMhjn3MACaTxMZXbvGR9UaCND+MS2pG8ndFZ+fNQmYBPxsnzIiPZWOyg8dLgt//kuppGYoNUxLoMRmGF9Pvxo3Apidr/OSKUP2KaNvlAI89/thNf7xMtoeRUF0fTHWZUs1p+ZVHcHkLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860691; c=relaxed/simple;
	bh=jNCmy3seRohNE9yt+CHrLJFiWauY6GxcQwgs5KLJKSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iIzsOtR9NnvAM38rphDZKhJ/yRIFY7IUqJFTVJcNZ9m22c5kAAxk2uphSpgzcNSS66YfZXjZvjXqHodv9w/83pw0+g4UtLd7OAq+XGxXYCWW3GYpjMTtk/rl+LN8c6SlcqZ6N1czGxdGVZONBBiTfIDFg0ueG7Z+00dg/obprFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t/imcYkn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=5miLhE/iEo3nra3fkXw4P1c6eaX/GQReZ4c9vV6/hlo=; b=t/imcYknduAzHipiM3CczsIWfw
	rvy7D7+WxrPq2SJeNb8CIWSpJs9e5DFVK0FIJBMkfDBqECAOyWvouLoYOPCBtFVWjvB6T7AqBDL9E
	V4MJurV1jvV+PFWc/VBjEn7V+E6bvlGCMK5vr+CYc90M7gg38FtCYtiK7dme82OkC6vPxA1XOPN2p
	agpiObPL8sMmjX8oTCV2g70JJILp0P4VxEbfsxGk9cgT2hj2hWB5mc2CqUaEnw6UZLsMH1aiL5/Fs
	b/aFXtfH0cfUN03698FMCL49UuM8GUaz5kghTzfGi7uGgsCrsIO2MYkC9mVPYHuPOyCINaudRX7cd
	xl7tMXtg==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ra0a5-0000000Asby-3mjG;
	Tue, 13 Feb 2024 21:44:45 +0000
Message-ID: <bbb40718-9bfa-4431-a3b0-c09d068fd6cc@infradead.org>
Date: Tue, 13 Feb 2024 13:44:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] Documentation: tee: Add TS-TEE driver
Content-Language: en-US
To: Balint Dobszay <balint.dobszay@arm.com>,
 op-tee@lists.trustedfirmware.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: jens.wiklander@linaro.org, sumit.garg@linaro.org, corbet@lwn.net,
 sudeep.holla@arm.com, gyorgy.szing@arm.com
References: <20240213145239.379875-1-balint.dobszay@arm.com>
 <20240213145239.379875-4-balint.dobszay@arm.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240213145239.379875-4-balint.dobszay@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 2/13/24 06:52, Balint Dobszay wrote:
> Add documentation for the Trusted Services TEE driver.
> 
> Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
> ---
>  Documentation/tee/index.rst  |  1 +
>  Documentation/tee/ts-tee.rst | 70 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+)
>  create mode 100644 Documentation/tee/ts-tee.rst
> 

> diff --git a/Documentation/tee/ts-tee.rst b/Documentation/tee/ts-tee.rst
> new file mode 100644
> index 000000000000..e121ebbbfab7
> --- /dev/null
> +++ b/Documentation/tee/ts-tee.rst
> @@ -0,0 +1,70 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================================
> +TS-TEE (Trusted Services project)
> +=================================
> +
> +This driver provides access to secure services implemented by Trusted Services.
> +
> +Trusted Services [1] is a TrustedFirmware.org project that provides a framework
> +for developing and deploying device Root of Trust services in FF-A [2] S-EL0
> +Secure Partitions. The project hosts the reference implementation of the Arm
> +Platform Security Architecture [3] for Arm A-profile devices.
> +
> +The FF-A Secure Partitions (SP) are accessible through the FF-A driver [4] which
> +provides the low level communication for this driver. On top of that the Trusted
> +Services RPC protocol is used [5]. To use the driver from user space a reference
> +implementation is provided at [6], which is part of the Trusted Services client
> +library called libts [7].
> +

Fix run-on sentences:

> +All Trusted Services (TS) SPs have the same FF-A UUID, it identifies the TS RPC

                                                    UUID. It
or
                                                    UUIT; it

> +protocol. A TS SP can host one or more services (e.g. PSA Crypto, PSA ITS, etc).
> +A service is identified by its service UUID, the same type of service cannot be

                                          UUID;

> +present twice in the same SP. During SP boot each service in the SP is assigned
> +an "interface ID", this is just a short ID to simplify message addressing.

      "interface ID." This

> +
> +The generic TEE design is to share memory at once with the TEE implementation,
> +which can then be reused to communicate with multiple TAs. However, in case of

"TA" is not defined.

> +FF-A, memory sharing works on an endpoint level, i.e. memory is shared with a
> +specific SP. User space has to be able to separately share memory with each SP
> +based on its endpoint ID, therefore a separate TEE device is registered for each

                         ID; therefore

> +discovered TS SP. Opening the SP corresponds to opening the TEE device and
> +creating a TEE context. A TS SP hosts one or more services, opening a service

                                                     services. Opening

> +corresponds to opening a session in the given tee_context.
> +
> +Overview of a system with Trusted Services components::
> +
> +   User space                  Kernel space                   Secure world
> +   ~~~~~~~~~~                  ~~~~~~~~~~~~                   ~~~~~~~~~~~~
> +   +--------+                                               +-------------+
> +   | Client |                                               | Trusted     |
> +   +--------+                                               | Services SP |
> +      /\                                                    +-------------+
> +      ||                                                          /\
> +      ||                                                          ||
> +      ||                                                          ||
> +      \/                                                          \/
> +   +-------+                +----------+--------+           +-------------+
> +   | libts |                |  TEE     | TS-TEE |           |  FF-A SPMC  |
> +   |       |                |  subsys  | driver |           |   + SPMD    |
> +   +-------+----------------+----+-----+--------+-----------+-------------+
> +   |      Generic TEE API        |     |  FF-A  |     TS RPC protocol     |
> +   |      IOCTL (TEE_IOC_*)      |     | driver |        over FF-A        |
> +   +-----------------------------+     +--------+-------------------------+
> +
> +References
> +==========
> +
> +[1] https://www.trustedfirmware.org/projects/trusted-services/
> +
> +[2] https://developer.arm.com/documentation/den0077/
> +
> +[3] https://www.arm.com/architecture/security-features/platform-security
> +
> +[4] drivers/firmware/arm_ffa/
> +
> +[5] https://trusted-services.readthedocs.io/en/v1.0.0/developer/service-access-protocols.html#abi
> +
> +[6] https://git.trustedfirmware.org/TS/trusted-services.git/tree/components/rpc/ts_rpc/caller/linux/ts_rpc_caller_linux.c?h=v1.0.0
> +
> +[7] https://git.trustedfirmware.org/TS/trusted-services.git/tree/deployments/libts/arm-linux/CMakeLists.txt?h=v1.0.0

-- 
#Randy

