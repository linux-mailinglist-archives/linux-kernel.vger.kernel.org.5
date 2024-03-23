Return-Path: <linux-kernel+bounces-112143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5C6887636
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 01:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A924A1F2290C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1AE138A;
	Sat, 23 Mar 2024 00:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="EIcEU6Es"
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3E17F;
	Sat, 23 Mar 2024 00:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711154394; cv=pass; b=QbXIaI/40W7fUFS/0MBp2O+PWcQus29K8Vqt+qmtxz/zX1QnCvsCMnjxHq58QaMOsy4sz94UgXQ6UuAb3rKUbn4F0B6G3d782Y7acILRsPagB2TfX/43yZYDe7tkcd/1wSPArEzgwDE+2ZOidGsc8KoeNh+A7eLtgvVHorPhdiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711154394; c=relaxed/simple;
	bh=IZQstQMtLD3a/Oiu8dc2nBD7fX2kaYx9Q+6x+U1Cem4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kcd4x5diRSUeF26buqQf0rS4/ZoQMVaPHjIQZiI/aueMUplLzSf5gA8AUvQmBdyRKTF/9q6iyEA1hhNzlsD18YiYGpKETvZ4KJZCQbdb5e3dfcYPIPiu9SdGNNuwDLFwzSVkamEt4RhuN7sylSdMJk3VJLrYShRNpaCV7q4XEUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=EIcEU6Es; arc=pass smtp.client-ip=136.143.188.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1711154373; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=B9pYW7lj4Z+uzq8AVE59XgvOsa93f9twCyqtyoFPlzSbLQPHcEob7aJcECp3iXUZRB+gx+eTI0F/XAp+65/19mCrLmqKJlgNlP8Sd9p+FKSon3Kj0DZVO/vICX5U7+LpY3vKC1kULzQIw0a4FYiVLpbD/xJvCMF44D8am++9DrM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1711154373; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=v374hk794r7O7dlfZ3++1YAoZDq+f+3n63wl9EofYp0=; 
	b=K0RIUa0w8z+L0nW6SB3OHj2yC5QBPYG/c+AvaetYekQR+KKTKgSkeUtN7TqkinP9qLrMXVBdEpzpnX1BJ6AT8IVg69nKGT+8o12634DBBbmlDcTWhzdAlDemFA8A0MgENa9cPTEQQZvYbhZG5y9ErkKTcFjma7yj8/peHxfcibk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1711154373;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=v374hk794r7O7dlfZ3++1YAoZDq+f+3n63wl9EofYp0=;
	b=EIcEU6EsHgfVe0rfIb7aY73zggM+qzonYfbN78n82ngAO+DUOJuVyhWeWYtBS07/
	iP4EjUNBQp4jcl9eiDeP2Azf84Y/FPWdUqYTC5iyt1/X1O1Zgz1qRr63rW4qjEp1le7
	MtfAscIcWCZ/54N5Jr/5fFY/nzrWG8ZIWWWSVK/Y=
Received: from [10.10.1.138] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1711154370859958.6393373374815; Fri, 22 Mar 2024 17:39:30 -0700 (PDT)
Message-ID: <5a494de5-b004-440c-bcdf-7bdfa3a8c508@apertussolutions.com>
Date: Fri, 22 Mar 2024 20:39:28 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Documentation: tpm_tis
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
 Lino Sanfilippo <l.sanfilippo@kunbus.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Peter Huewe <peterhuewe@gmx.de>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Alexander Steffen <Alexander.Steffen@infineon.com>,
 keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Richard Cochran <richardcochran@gmail.com>,
 "open list:PTP HARDWARE CLOCK SUPPORT:Keyword:(?:b|_)ptp(?:b|_)"
 <netdev@vger.kernel.org>
References: <20240322123542.24158-1-jarkko@kernel.org>
Content-Language: en-US
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; keydata=
 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
In-Reply-To: <20240322123542.24158-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi Jarkko,

On 3/22/24 08:35, Jarkko Sakkinen wrote:
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
> ---
> v4:
> - Extended the text to address some of Stefan's concerns with v2.
> - Had to unfortunately remove Randy's reviewed-by because of this, given
>    the amount of text added.
> v3:
> - Fixed incorrect buffer size:
>    https://lore.kernel.org/linux-integrity/d957dbd3-4975-48d7-abc5-1a01c0959ea3@linux.ibm.com/
> v2:
> - Fixed errors reported by Randy:
>    https://lore.kernel.org/all/aed28265-d677-491a-a045-24b351854b24@infradead.org/
> - Improved the text a bit to have a better presentation.
> ---
>   Documentation/security/tpm/index.rst   |  1 +
>   Documentation/security/tpm/tpm_tis.rst | 46 ++++++++++++++++++++++++++
>   2 files changed, 47 insertions(+)
>   create mode 100644 Documentation/security/tpm/tpm_tis.rst
> 
> diff --git a/Documentation/security/tpm/index.rst b/Documentation/security/tpm/index.rst
> index fc40e9f23c85..f27a17f60a96 100644
> --- a/Documentation/security/tpm/index.rst
> +++ b/Documentation/security/tpm/index.rst
> @@ -5,6 +5,7 @@ Trusted Platform Module documentation
>   .. toctree::
>   
>      tpm_event_log
> +   tpm_tis
>      tpm_vtpm_proxy
>      xen-tpmfront
>      tpm_ftpm_tee
> diff --git a/Documentation/security/tpm/tpm_tis.rst b/Documentation/security/tpm/tpm_tis.rst
> new file mode 100644
> index 000000000000..b448ea3db71d
> --- /dev/null
> +++ b/Documentation/security/tpm/tpm_tis.rst
> @@ -0,0 +1,46 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=========================
> +TPM FIFO interface driver
> +=========================
> +
> +TCG PTP Specification defines two interface types: FIFO and CRB. The former is

I believe in the spec, the authors were specific to classify these as 
software interfaces. Not sure if you would want to carry that 
distinction into this document.

> +based on sequenced read and write operations,  and the latter is based on a
> +buffer containing the full command or response.
> +
> +FIFO (First-In-First-Out) interface is used by the tpm_tis_core dependent
> +drivers. Originally Linux had only a driver called tpm_tis, which covered
> +memory mapped (aka MMIO) interface but it was later on extended to cover other
> +physical interfaces supported by the TCG standard.

Would it be worth clarifying here that one of those interfaces is 
defined in the Mobile TPM specification, which also refers to its 
interface as the CRB interface. In the past, this has caused great 
confusion when working with individuals from the embedded community, 
e.g., Arm. The Mobile TPM CRB interface, which can also be found being 
used by some generations of AMD fTPM, is a doorbell style interface 
using general-purpose memory. I would also point out that the Mobile TPM 
CRB interface does not provide for the concept of localities.

In relation to the MMIO backed interfaces, I have heard comment that the 
software interfaces were not meant to require the physical interface be 
MMIO. In fact, in section 9.2, "Hardware Implementation of a TPM in a PC 
Client Platform", there is a comment about Locality 4 registers being 
accessible via an implementation specific mechanism other than MMIO. 
Additionally, there were some discussions about clarifying the PTP on 
how the software interfaces might be expected to work for a 
general-purpose memory backed implementation.

> +For legacy compliance the original MMIO driver is called tpm_tis and the
> +framework for FIFO drivers is named as tpm_tis_core. The postfix "tis" in
> +tpm_tis comes from the TPM Interface Specification, which is the hardware
> +interface specification for TPM 1.x chips.
> +
> +Communication is based on a 20 KiB buffer shared by the TPM chip through a
> +hardware bus or memory map, depending on the physical wiring. The buffer is
> +further split into five equal-size 4 KiB buffers, which provide equivalent
> +sets of registers for communication between the CPU and TPM. These
> +communication endpoints are called localities in the TCG terminology.
> +
> +When the kernel wants to send commands to the TPM chip, it first reserves
> +locality 0 by setting the requestUse bit in the TPM_ACCESS register. The bit is
> +cleared by the chip when the access is granted. Once it completes its
> +communication, the kernel writes the TPM_ACCESS.activeLocality bit. This
> +informs the chip that the locality has been relinquished.
> +
> +Pending localities are served in order by the chip in descending order, one at
> +a time:

I think I get what you are trying to say, but I find the wording here 
could be a bit misleading. Instead of saying they are served in order, I 
would suggest saying something to the extent that: there are five 
localities, more than one can be requested at a time, but only one will 
ever be active. Selection priority when multiple requests are pending is 
detailed in the Informative comment on locality priority in Section 
6.2.1, "TPM Locality Levels".

> +- Locality 0 has the lowest priority.
> +- Locality 5 has the highest priority.

Do you mean Locality 4?

> +Further information on the purpose and meaning of the localities can be found
> +in section 3.2 of the TCG PC Client Platform TPM Profile Specification.
> +
> +References
> +==========
> +
> +TCG PC Client Platform TPM Profile (PTP) Specification
> +https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/

