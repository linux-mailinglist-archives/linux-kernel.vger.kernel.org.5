Return-Path: <linux-kernel+bounces-91383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AED871080
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56AEA1C21349
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BF67C088;
	Mon,  4 Mar 2024 22:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ChaaBxNw"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7EB7C08B;
	Mon,  4 Mar 2024 22:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592799; cv=none; b=GIuByzBcqx96SmBkdgXyBysAC0r8wbHU02VOy2+v2ZVxXbFetEKgAgoyoAiAg0K+Pds15Fx20Q4KlK08c1sG9bpr0NP3aenqApMWTUKO5SeCc5k69j7feMGLPKksJnJZfERChfF/v1906cS7NhvaJ6TEE7hbqiQUlEQLkl1YgJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592799; c=relaxed/simple;
	bh=4xijB9HkGEKukRdIt8mQVpeH7qWKignO13hJ3tn17Rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njY3z4FXic6lm+XGGFLjo0I9Q0yuYLPxKVzT/ouEffhjLgS5pVKKn672+YsmS/5HmVVtlH1+vrb/7jJputFKBaySox5yat6PlavBFdKsGBeSdITu5/uGGrQfSjtPSp3uD9UCe/kGxu8GaT8mOM+0jyfqErH6m5zJNOqL/47s9zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ChaaBxNw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=d4auX+yTOKHXRtkopQbSwlgiFKHW5QS/lFGUAcp7fwg=; b=ChaaBxNwWtTFG+T+tpbI++o9dA
	cA8sw/hjD7iuPsDl/7nKX1OGJbGnxTjq2zMSdEpv2fGOfVP1Oh8nZNfNQajErhSyJhiX0HUajTaxO
	kKnKsMqQBGccEUUQwfv9wFunlCUKMS6qWSaRez/tTKrWYs0p7+dorkzBe+PTmI+6FAwObVe3iJ8EM
	2c+iunapYECwt+Pu48gkTe0wFVR7JVYEXQU9yBFT0PeN6BS6MZ6BZkfdI7p2kZm6ENTLZbuEarjbm
	B476RVraaBNM76aAOfOA/P3UP7WgNvGRiEDPte3kwjN2/wTDvgn4MpC48+WV/aQ5ZwfL44QuYxN5g
	ZrS0OI7g==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhHBJ-0000000B0N9-3kiR;
	Mon, 04 Mar 2024 22:53:13 +0000
Message-ID: <aed28265-d677-491a-a045-24b351854b24@infradead.org>
Date: Mon, 4 Mar 2024 14:53:11 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: tpm_tis
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
 "Daniel P . Smith" <dpsmith@apertussolutions.com>,
 Lino Sanfilippo <l.sanfilippo@kunbus.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Peter Huewe <peterhuewe@gmx.de>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Alexander Steffen <Alexander.Steffen@infineon.com>,
 keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org
References: <20240304212734.43213-1-jarkko@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240304212734.43213-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/4/24 13:27, Jarkko Sakkinen wrote:
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
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  Documentation/security/tpm/index.rst   |  1 +
>  Documentation/security/tpm/tpm_tis.rst | 30 ++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
>  create mode 100644 Documentation/security/tpm/tpm_tis.rst
> 

> diff --git a/Documentation/security/tpm/tpm_tis.rst b/Documentation/security/tpm/tpm_tis.rst
> new file mode 100644
> index 000000000000..3cec0216a169
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
> +`tpm_tis_core` dependent drivers. The prefix "tis" is named after TPM
> +Interface Specification, which is the hardware interface specification for
> +TPM 1.x chips.
> +
> +Communication is based on a 5 KiB buffer shared by the TPM chip through a
> +hardware bus or memory map. The buffer is further split to five equal size
> +buffers, which provide equivalent sets of registers for communication
> +between CPU and TPM. The communication end points are called *localities*
> +in the TCG terminology.
> +
> +When a kernel wants to send a commands to the TPM chip, it first reserves
> +locality 0 by setting `requestUse` bit in `TPM_ACCESS` register. The bit is
> +cleared by the chip when the access is granted. Once completed its
> +communication, it sets `activeLocity` bit in the same register.

      Is that              activeLocality ?

> +
> +Pending localities are served in order by the chip descending orderm and
> +one at a time:
> +
> +- Locality 0 has the lowest priority.
> +- Locality 5 has the highest priotiy.

                                priority.

> +
> +Further information on purpose and meaning of the localities can be found
> +from section 3.2 of TCG PC Client Platform TPM Profile Specification.

-- 
#Randy

