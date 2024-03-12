Return-Path: <linux-kernel+bounces-100838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86378879DE7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EC9EB21BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B651143C7A;
	Tue, 12 Mar 2024 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="qdWLlB6b"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1E2143C6E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 21:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710280325; cv=none; b=LUGSCTtfBgHIrZcRGgxWs4TX9D56e+gNuH0elRrZuH5+J7LxcAuOAY8093kPmQt9GeWci3BWE2shy443SAmNtI+yWwENc+Ked04TwlGTqZ/+luVM0gzqDBlZ4zb5gqk71Un1tD+HWXhF+82UDWTPg345xVcVdgBaDPnd4oAnNQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710280325; c=relaxed/simple;
	bh=c25YjC2JUauATlLLXLNhbWOGSqRPC7E+MI4ezwvcdy0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=m5VDajZ32tCHRIWqpP5ERWvdh6USxSTBAGtmmFNr2FrmAHgjg99AqkT5NrS5YAw4TxEyXGABR1N6KgG+HSmdEdIyLVjzTr6vCVAsXVJb34n5FRG/7cAwi+npwY0khigQ4iQFzGSqWrKeopN3c0d/Bjgu5e+hu36M+jcKKqKZAkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=qdWLlB6b; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zjkimfvEnH+8h+KzI9S405xYFJIlma0xDcckDJKGofU=;
  b=qdWLlB6bJ3c/HeeTsjS1dBAwUtRQT+HCqUvyqO9P0xO9HxQifStQxjkg
   IVw2qqjIpcw9xRAQrgAauflAB8Ttud2sTLZOb7E3T/QC8xAYQRlx1Dqba
   PE6tE5ZO4WpAFoKgJMevYpT+nkVNnpgLJZG9xcavK+ImpWf8nyJDJdejh
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,119,1708383600"; 
   d="scan'208";a="156339789"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 22:52:00 +0100
Date: Tue, 12 Mar 2024 22:52:00 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Ayush Tiwari <ayushtiw0110@gmail.com>
cc: outreachy@lists.linux.dev, linux-staging@lists.linux.dev, 
    linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, 
    florian.c.schilhabel@googlemail.com, Larry.Finger@lwfinger.net
Subject: Re: [PATCH] staging: rtl8712: removing redundant paranthesis
 chk_fwhdr
In-Reply-To: <ZfDIF+6MrdrX79nd@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Message-ID: <alpine.DEB.2.22.394.2403122250390.3229@hadrien>
References: <ZfDIF+6MrdrX79nd@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 13 Mar 2024, Ayush Tiwari wrote:

> Removing redundant parentheses in 'if ((pfwhdr->signature != 0x8712) && (pfwhdr->signature != 0x8192))' in static u8 chk_fwhdr(struct fw_hdr *pfwhdr, u32 ulfilelength). This will ensure adherence to coding style guidelines

The log message should be limited to 70 characters per line.

>
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> ---
>  drivers/staging/rtl8712/hal_init.c |  2 +-
>  key.pem                            | 28 ++++++++++++++++++++++++++++
>  staging                            |  1 +
>  3 files changed, 30 insertions(+), 1 deletion(-)
>  create mode 100644 key.pem
>  create mode 120000 staging
>
> diff --git a/drivers/staging/rtl8712/hal_init.c b/drivers/staging/rtl8712/hal_init.c
> index 1148075f0cd6..9f41b2c086ca 100644
> --- a/drivers/staging/rtl8712/hal_init.c
> +++ b/drivers/staging/rtl8712/hal_init.c
> @@ -138,7 +138,7 @@ static u8 chk_fwhdr(struct fw_hdr *pfwhdr, u32 ulfilelength)
>  	u32	fwhdrsz, fw_sz;
>
>  	/* check signature */
> -	if ((pfwhdr->signature != 0x8712) && (pfwhdr->signature != 0x8192))
> +	if (pfwhdr->signature != 0x8712 && pfwhdr->signature != 0x8192)

Actually, the response to another proposed patch was that it was preferred
to keep such parentheses, regardless of the ceckpatch warning.

>  		return _FAIL;
>  	/* check fw_priv_sze & sizeof(struct fw_priv) */
>  	if (pfwhdr->fw_priv_sz != sizeof(struct fw_priv))
> diff --git a/key.pem b/key.pem
> new file mode 100644
> index 000000000000..ef912436e976
> --- /dev/null
> +++ b/key.pem

I don't think that this is supposed to be part of the patch?

julia

> @@ -0,0 +1,28 @@
> +-----BEGIN PRIVATE KEY-----
> +MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC8i/6L5h4wSbaP
> +tn9whe9BfKa0jpiiy+F9L0fJEWGKqUqxMUL3D48LJsqTgt8vP6ORMcSQmtQ1ijyv
> +f9s0N5/sNci9dYeiVhzArlcZi4IOEkfkn/lgRoz4WOsZ6NQzgsk6ctctavrlHUwB
> +e6RQHFyEC9BOmCq6PTPMtPTeTrQvjzm68gMiQfoNT86/uho+eKxABYBOZEN1DObt
> +Q2wEbJOhiZ+UfknJd5BuxLXFLLeutYNHT+jzymVETfH6Zqr5U+NS/68H8tVRSy5w
> +zwMZ38yQc5RI0fhI/u+6Lsikf0sJYV4sNaUkElclfzKFRE9RNc8McQcjbY8RUVvG
> +81qbKvDxAgMBAAECggEAB62YcpWu7LQmbpN10h0U1rEJpY2vB+Yklcal9jldJFqW
> +M5a4IuaBIpOe/ph+7Tt6tjrKxewVheP4v67bEYp4WpQAIOhXMH8Fkbp9H98Er1JY
> +QiZaRJeVkwwlRXtWn423vcfCcn409GftL0bxNIqgdod39qi6CLaIVFGZgoS9pWLD
> +lrrEnK8nlq8/4bs/bPyZqoiEIUXTC9IAHhlmmwL1diLYmTOTIFn0XN3kqxMwz50D
> +81Bh/pPZXXsL4f3an9v/68prsM4NgJMXvHh/qWGY8L75QyoPn69/6d4mETBDCSeL
> +BAA1Ac2z2UlC6uqlM5A4/F1IEilrtDIFMD6r3UMZDwKBgQD1Zbx3A3VV/HDlH2CN
> +Tzf/Er2xUPYbPHJCALbZVwEM8zNTeIysMM3LeqWXfbJ4JpfkU575QLCaAC1PdQJT
> +AjNLqo9eYzsir6pj18HqBN/MxIujhbLGA78oD5fYRTL+5sXl0m1xkJq+ngkWbx6Y
> +ByfZFZ/UIUMST8kU8nVlNuFN1wKBgQDEsXO0PH5f0RkdbRVBQvVIdj5kfR94bheW
> +s7apwU07uYvlLiLrikRgC3Q60a7K3H7tfxkP5rjKUr+CyH+rlsL+WL4gJjBi4D13
> +XQeFlNbZieNNrnOctFCnGPlUSmte4Ubd1QEplUkbYkfvh5XKIklAfLsQPf17FQr/
> +ZAE/2YIOdwKBgGfXCQ0DdZ9RFySdRmoFX5icAZEKxVl5FpA/ZSBK5LLqJonntP8Y
> +F71GxNN56Q9WpWeEyvyGFzTTZlj9FmKxx6r5HXm/W8KtuthM8E1qiplHgh9L7/5C
> +j50QHBz0C0Q5uvwpMw6fNhv7G7VWiAek34PI1r0Y5hzVji1C+9I8itI5AoGAYGsU
> +at/UmyenBhO4/ZrTHkhIYX4sdR6SlZ9XBXPqZkKYXyn0mD3ZMrOqsEKlSnA4EDfj
> +kzXok9VoZ7XdT8HBqGjcGmpeAbomp2KFE2hYwZ6kPCouJj0F5EOLxVQNuh74XDnU
> +LgwuICxXUwXF2aZg/immkVmx7inskDD3o9L9vBUCgYBhCpayQcy9hswdDVICOEst
> +U9VXwVAbwfdmPTLiKacRQdw44zhBcsBB0wi1dszvGvSlAlB+ChFM6MxALEdbvTln
> +Jxwsyxx9KXuoryhcTlHQikBOYxmrqPAhdrPh8H2tdiv2yX35x9g7E/XkRZZxMfkL
> +H7x8vakFgGNcX2NITZBM4Q==
> +-----END PRIVATE KEY-----
> diff --git a/staging b/staging
> new file mode 120000
> index 000000000000..ecd48e46fcb1
> --- /dev/null
> +++ b/staging
> @@ -0,0 +1 @@
> +/home/ayush/git/kernels/staging
> \ No newline at end of file
> --
> 2.40.1
>
>
>

