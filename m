Return-Path: <linux-kernel+bounces-126096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA0789321E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A31C2B21180
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 15:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37143145344;
	Sun, 31 Mar 2024 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="13j2pjUx"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77294145331;
	Sun, 31 Mar 2024 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711900100; cv=none; b=FaqEZBbvviCrm5gV/wUJ1oBdJNn/I6aXqK2bU7XwilmDzToqPhjVwNc0wjTR9Y3i+nxUSBUu/53kWTtCtURZfbTah9lxFom4GOkkZ85fV9YVstAj3vmAw8tV1K+g67cVG6fdzWBqNi08kfmrBe6RBIiwaXQfwq8rdn8JRhrp3MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711900100; c=relaxed/simple;
	bh=kIoYpNMl6ThV7Ax1OXxjOMarTimy0oeDo5rBc/zFiRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f2Ykatf5Nib5cN0kACfau0tvKafB6uDiErh3qfWa4BZQW+SDGz6SLPIMEtxv1ywwZ/Vn8Ps+ySvcuxl3A6modGFjwsAuNdly6Vz+gUfzdwbV0a0tpXLOMJHiz6cCKncCbTdzHd6bhFnQrygoEaL6bySt+s51T2YyvFR0fcu4rTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=13j2pjUx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=0We0EDH7bWVlvsZhzNKb4VqCv/3NRjCwxypvLOl2OCY=; b=13j2pjUxZ2d3mmYgXB+0TqyLGy
	a735xKmsr+UNQvG4FCqP67fP3/Y0CWV3eyR46srJoG30VDLl1KFhPA61Ve7tJqNH/F+iSvHZtA/E4
	waG45kjNDCLXipXvs28H6Z9wSN1uUCXKSVKvtj9YsP7kejKuNlCM42vp4PpzD5TYMzqGXMnFC41Ec
	bPplfMlpmn5jPuA8DVsjag7GwbfHPdgondITllRHOEstPDfjV6GjN9goyUi75b/wFP1uiBSSsVZUm
	T7Rfo4zW93Hi9RvRk7WXDk4Qk8zywSr8UuDA+gROYvHdRMWN+Fq1rZ39zMr2KcnXjmUTPFpXPWSuS
	nkn2Ut5g==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqxPp-00000005dWK-2Xh7;
	Sun, 31 Mar 2024 15:48:13 +0000
Message-ID: <17e319ee-60dc-4d2b-8fd4-0b6960bfa3a7@infradead.org>
Date: Sun, 31 Mar 2024 08:48:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/14] Documentation/x86: Document Key Locker
Content-Language: en-US
To: "Chang S. Bae" <chang.seok.bae@intel.com>, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, dm-devel@redhat.com
Cc: ebiggers@kernel.org, luto@kernel.org, dave.hansen@linux.intel.com,
 tglx@linutronix.de, bp@alien8.de, mingo@kernel.org, x86@kernel.org,
 herbert@gondor.apana.org.au, ardb@kernel.org, elliott@hpe.com,
 dan.j.williams@intel.com, bernie.keany@intel.com,
 charishma1.gairuboyina@intel.com, Bagas Sanjaya <bagasdotme@gmail.com>
References: <20230603152227.12335-1-chang.seok.bae@intel.com>
 <20240329015346.635933-1-chang.seok.bae@intel.com>
 <20240329015346.635933-2-chang.seok.bae@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240329015346.635933-2-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,


On 3/28/24 18:53, Chang S. Bae wrote:
> Document the overview of the feature along with relevant consideration
> when provisioning dm-crypt volumes with AES-KL instead of AES-NI.
> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> ---
> Changes from v8:
> * Change wording of documentation slightly. (Randy Dunlap and Bagas
>   Sanjaya)
> 
> Changes from v6:
> * Rebase on the upstream -- commit ff61f0791ce9 ("docs: move x86
>   documentation into Documentation/arch/"). (Nathan Huckleberry)
> * Remove a duplicated sentence -- 'But there is no AES-KL instruction
>   to process a 192-bit key.'
> * Update the text for clarity and readability:
>   - Clarify the error code and exemplify the backup failure
>   - Use 'wrapping key' instead of less readable 'IWKey'
> 
> Changes from v5:
> * Fix a typo: 'feature feature' -> 'feature'
> 
> Changes from RFC v2:
> * Add as a new patch.
> 
> The preview is available here:
>   https://htmlpreview.github.io/?https://github.com/intel-staging/keylocker/kdoc/arch/x86/keylocker.html
> ---
>  Documentation/arch/x86/index.rst     |  1 +
>  Documentation/arch/x86/keylocker.rst | 96 ++++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+)
>  create mode 100644 Documentation/arch/x86/keylocker.rst
> 
> diff --git a/Documentation/arch/x86/index.rst b/Documentation/arch/x86/index.rst
> index 8ac64d7de4dc..669c239c009f 100644
> --- a/Documentation/arch/x86/index.rst
> +++ b/Documentation/arch/x86/index.rst
> @@ -43,3 +43,4 @@ x86-specific Documentation
>     features
>     elf_auxvec
>     xstate
> +   keylocker
> diff --git a/Documentation/arch/x86/keylocker.rst b/Documentation/arch/x86/keylocker.rst
> new file mode 100644
> index 000000000000..b28addb8eaf4
> --- /dev/null
> +++ b/Documentation/arch/x86/keylocker.rst
> @@ -0,0 +1,96 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==============
> +x86 Key Locker
> +==============
> +
> +Introduction
> +============
> +
> +Key Locker is a CPU feature to reduce key exfiltration opportunities
> +while maintaining a programming interface similar to AES-NI. It
> +converts the AES key into an encoded form, called the 'key handle'.
> +The key handle is a wrapped version of the clear-text key where the
> +wrapping key has limited exposure. Once converted, all subsequent data
> +encryption using new AES instructions (AES-KL) uses this key handle,
> +reducing the exposure of private key material in memory.
> +
> +CPU-internal Wrapping Key
> +=========================
> +
> +The CPU-internal wrapping key is an entity in a software-invisible CPU
> +state. On every system boot, a new key is loaded. So the key handle that
> +was encoded by the old wrapping key is no longer usable on system shutdown
> +or reboot.
> +
> +And the key may be lost on the following exceptional situation upon wakeup:
> +
> +Wrapping Key Restore Failure
> +----------------------------
> +
> +The CPU state is volatile with the ACPI S3/4 sleep states. When the system
> +supports those states, the key has to be backed up so that it is restored
> +on wake up. The kernel saves the key in non-volatile media.
> +
> +Upon the event of a wrapping key restore failure upon resume from suspend,
> +all established key handles become invalid. In flight dm-crypt operations

                                               In-flight

> +receive error results from pending operations. In the likely scenario that
> +dm-crypt is hosting the root filesystem the recovery is identical to if a
> +storage controller failed to resume from suspend or reboot. If the volume
> +impacted by a wrapping key restore failure is a data volume then it is
> +possible that I/O errors on that volume do not bring down the rest of the
> +system. However, a reboot is still required because the kernel will have
> +soft-disabled Key Locker. Upon the failure, the crypto library code will
> +return -ENODEV on every AES-KL function call. The Key Locker implementation
> +only loads a new wrapping key at initial boot, not any time after like
> +resume from suspend.
> +
> +Use Case and Non-use Cases
> +==========================
> +
> +Bare metal disk encryption is the only intended use case.
> +
> +Userspace usage is not supported because there is no ABI provided to
> +communicate and coordinate wrapping-key restore failure to userspace. For
> +now, key restore failures are only coordinated with kernel users. But the
> +kernel can not prevent userspace from using the feature's AES instructions
> +('AES-KL') when the feature has been enabled. So, the lack of userspace
> +support is only documented, not actively enforced.
> +
> +Key Locker is not expected to be advertised to guest VMs and the kernel
> +implementation ignores it even if the VMM enumerates the capability. The
> +expectation is that a guest VM wants private wrapping key state, but the
> +architecture does not provide that. An emulation of that capability, by
> +caching per-VM wrapping keys in memory, defeats the purpose of Key Locker.
> +The backup / restore facility is also not performant enough to be suitable
> +for guest VM context switches.
> +
> +AES Instruction Set
> +===================
> +
> +The feature accompanies a new AES instruction set. This instruction set is
> +analogous to AES-NI. A set of AES-NI instructions can be mapped to an
> +AES-KL instruction. For example, AESENC128KL is responsible for ten rounds
> +of transformation, which is equivalent to nine times AESENC and one
> +AESENCLAST in AES-NI.
> +
> +But they have some notable differences:
> +
> +* AES-KL provides a secure data transformation using an encrypted key.
> +
> +* If an invalid key handle is provided, e.g. a corrupted one or a handle
> +  restriction failure, the instruction fails with setting RFLAGS.ZF. The
> +  crypto library implementation includes the flag check to return -EINVAL.
> +  Note that this flag is also set if the wrapping key is changed, e.g.,
> +  because of the backup error.
> +
> +* AES-KL implements support for 128-bit and 256-bit keys, but there is no
> +  AES-KL instruction to process an 192-bit key. The AES-KL cipher
> +  implementation logs a warning message with a 192-bit key and then falls
> +  back to AES-NI. So, this 192-bit key-size limitation is only documented,
> +  not enforced. It means the key will remain in clear-text in memory. This
> +  is to meet Linux crypto-cipher expectation that each implementation must
> +  support all the AES-compliant key sizes.
> +
> +* Some AES-KL hardware implementation may have noticeable performance
> +  overhead when compared with AES-NI instructions.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
#Randy

