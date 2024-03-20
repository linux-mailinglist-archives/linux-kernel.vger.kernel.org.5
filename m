Return-Path: <linux-kernel+bounces-109008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2535488134D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8EB81F2139C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BAB45958;
	Wed, 20 Mar 2024 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fLFDBs8w"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840B8481A0;
	Wed, 20 Mar 2024 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710944888; cv=none; b=UH/sPBRpBhXf1DM9XHCGF3c5OQuZi4SMxO7R7VidA4JofWJN0+ufADToCy5MoLsE+FVNT248SjvoSm4TsRk/l6PhXVXQu4T8Xl7c07TF7zlWqXxZNIlgDGtJQP1cRwPp/AWq9uScYLxjmHpaiTcfLHPRd75OMTdZwtXDKNNqgUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710944888; c=relaxed/simple;
	bh=6gGnkvQ8A2COzp2E7sFsQr6WlVhSguQXJNANqH+jlSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmCGtrMP957Nu2muhhHM80lmEM0Ozueu74K1keLAw5DRHgr/0tr2rn6GPdNlTF4f9eoZt9euLdMo7Uycqp3CNuJwt8DBgY+G9ouFibRQdMKCgh/vO4tfmNKe8vPJ2Qb1qOhBuKe99weLVg3XosuWQWHzOBXBQKmLgsg8Gupi61Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fLFDBs8w; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=QC7UpnziKdVGcCkCO2/9r9IHLlpWewda2Br4C2weMl4=; b=fLFDBs8w/irHfcXmClsgGb/Iyt
	Nw2D4zh8HqCN2lH/Bc1fq5++b7W16p2VHC4c4FatpM+niIZQJu3eClNEdRu5mxtJlqU4O2OWNR9m0
	2OQmjVEAOOxqV0jq2bU9LuniyklAMoSvxwGxpOZvEnqmsPT7ky5xmsbOfqS7VT+uCi8rSKsR5CPgf
	We8iELIjsLzuhxle6YwMQmBbYy3DG2Uk5KVtO/sRHmkEpXiCMDUrns7S2qvR99galwTLCBo0Zn2TJ
	w2v43QbW+Ptw/z2efN1MXr607mWpHq71B44t7tqMyP4uhcAM/oIw6wWxI1s7bXGuqVKKRnRzxc8KV
	am2xQLtA==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmwvC-0000000HRGR-26Ml;
	Wed, 20 Mar 2024 14:28:02 +0000
Message-ID: <4550b40f-658f-4795-a7e1-ac9100c657df@infradead.org>
Date: Wed, 20 Mar 2024 07:27:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation: tpm_tis
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
 "Daniel P . Smith" <dpsmith@apertussolutions.com>,
 Lino Sanfilippo <l.sanfilippo@kunbus.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Peter Huewe <peterhuewe@gmx.de>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Alexander Steffen <Alexander.Steffen@infineon.com>,
 keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240320085601.40450-1-jarkko@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240320085601.40450-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/20/24 01:56, Jarkko Sakkinen wrote:
> Based recent discussions on LKML, provide preliminary bits of tpm_tis_core
> dependent drivers. Includes only bare essentials but can be extended later
> on case by case. This way some people may even want to read it later on.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> CC: Daniel P. Smith <dpsmith@apertussolutions.com>
> Cc: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
> Cc: keyrings@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Makes sense to me. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> v2:
> - Fixed errors reported by Randy:
>   https://lore.kernel.org/all/aed28265-d677-491a-a045-24b351854b24@infradead.org/
> - Improved the text a bit to have a better presentation.
> ---
>  Documentation/security/tpm/index.rst   |  1 +
>  Documentation/security/tpm/tpm_tis.rst | 30 ++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
>  create mode 100644 Documentation/security/tpm/tpm_tis.rst
> 
> diff --git a/Documentation/security/tpm/index.rst b/Documentation/security/tpm/index.rst
> index fc40e9f23c85..f27a17f60a96 100644
> --- a/Documentation/security/tpm/index.rst
> +++ b/Documentation/security/tpm/index.rst
> @@ -5,6 +5,7 @@ Trusted Platform Module documentation
>  .. toctree::
>  
>     tpm_event_log
> +   tpm_tis
>     tpm_vtpm_proxy
>     xen-tpmfront
>     tpm_ftpm_tee
> diff --git a/Documentation/security/tpm/tpm_tis.rst b/Documentation/security/tpm/tpm_tis.rst
> new file mode 100644
> index 000000000000..b331813b3c45
> --- /dev/null
> +++ b/Documentation/security/tpm/tpm_tis.rst
> @@ -0,0 +1,30 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=========================
> +TPM FIFO interface Driver
> +=========================
> +
> +FIFO (First-In-First-Out) is the name of the hardware interface used by the
> +tpm_tis_core dependent drivers. The prefix "tis" comes from the TPM Interface
> +Specification, which is the hardware interface specification for TPM 1.x chips.
> +
> +Communication is based on a 5 KiB buffer shared by the TPM chip through a
> +hardware bus or memory map, depending on the physical wiring. The buffer is
> +further split into five equal-size buffers, which provide equivalent sets of
> +registers for communication between the CPU and TPM. These communication
> +endpoints are called localities in the TCG terminology.
> +
> +When the kernel wants to send commands to the TPM chip, it first reserves
> +locality 0 by setting the requestUse bit in the TPM_ACCESS register. The bit is
> +cleared by the chip when the access is granted. Once it completes its
> +communication, the kernel writes the TPM_ACCESS.activeLocality bit. This
> +informs the chip that the locality has been relinquished.
> +
> +Pending localities are served in order by the chip in descending order, one at
> +a time:
> +
> +- Locality 0 has the lowest priority.
> +- Locality 5 has the highest priority.
> +
> +Further information on the purpose and meaning of the localities can be found
> +in section 3.2 of the TCG PC Client Platform TPM Profile Specification.

-- 
#Randy

