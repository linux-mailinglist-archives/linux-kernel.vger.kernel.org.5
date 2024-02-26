Return-Path: <linux-kernel+bounces-80594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB54E866A22
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F9A1F22EF3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71F71B951;
	Mon, 26 Feb 2024 06:36:12 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DDB18E27;
	Mon, 26 Feb 2024 06:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708929372; cv=none; b=LRoSxJauem+KqXh7LCjyF2g7XHJiZfcOQuQwg3yTOtWbqyu9NrTAbECatUAgyksRqGJcdNT2ebbB1DwrORSNl/I6cUy8J9fQ9FxMhiNUbf7hQpjbuvGuRVB/+O5g1XLwPnaFTBJHmcdjOWuIITuqeGhkvKGTyt/8CP6cP9KDLSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708929372; c=relaxed/simple;
	bh=eVoqiLULb9MrqguQSk5SHcG7GfJKA9J4K28XObqcAUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=on96DraMQVfHZyS9gjNWecZBkS30aPHW0Tq37GWBoFoTUC4O55rMF1oRafyUdvHuJbfZEpDSQkRwqms2SAjJkFqxNTNVwTSFCcEWDW7uNK1aE+7HkxI24aUB9w42PfoZAubqFZCRUFp6EmK3aL3FamIgRBVDzFAjH2SFiDm6Y2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.6] (ip5f5af3a7.dynamic.kabel-deutschland.de [95.90.243.167])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 818CF61E5FE04;
	Mon, 26 Feb 2024 07:35:38 +0100 (CET)
Message-ID: <1ab10318-5e3d-417c-9984-7b17f4e386e3@molgen.mpg.de>
Date: Mon, 26 Feb 2024 07:35:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update W's for KEYS/KEYRINGS_INTEGRITY and
 TPM DEVICE RIVER
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Mimi Zohar <zohar@linux.ibm.com>,
 Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240226062245.2279635-1-jarkko@kernel.org>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240226062245.2279635-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Jarkko,


Thank you for your patch. Two nits:

s/RIVER/DRIVER/

Am 26.02.24 um 07:22 schrieb Jarkko Sakkinen:
> Add TPM driver test suite URL to the MAINTAINERS files and move the wiki

s/files/file/

> URL to more appropriate location.

(Two commits would make the commit message shorter.)

> Link: https://gitlab.com/jarkkojs/linux-tpmdd-test
> Link: https://kernsec.org/wiki/index.php/Linux_Kernel_Integrity
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: linux-integrity@vger.kernel.org
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>   MAINTAINERS | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bf77be03fb2b..6380c1109b86 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11947,6 +11947,7 @@ M:	Mimi Zohar <zohar@linux.ibm.com>
>   L:	linux-integrity@vger.kernel.org
>   L:	keyrings@vger.kernel.org
>   S:	Supported
> +W:	https://kernsec.org/wiki/index.php/inux_Kernel_Integrity
>   F:	security/integrity/platform_certs
>   
>   KFENCE
> @@ -22278,7 +22279,7 @@ M:	Jarkko Sakkinen <jarkko@kernel.org>
>   R:	Jason Gunthorpe <jgg@ziepe.ca>
>   L:	linux-integrity@vger.kernel.org
>   S:	Maintained
> -W:	https://kernsec.org/wiki/index.php/Linux_Kernel_Integrity
> +W:	https://gitlab.com/jarkkojs/linux-tpmdd-test
>   Q:	https://patchwork.kernel.org/project/linux-integrity/list/
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
>   F:	drivers/char/tpm/

Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

