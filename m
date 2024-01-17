Return-Path: <linux-kernel+bounces-29463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E288830E99
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29F91F2678D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A7628699;
	Wed, 17 Jan 2024 21:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BGG+EdFE"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2716B2557E;
	Wed, 17 Jan 2024 21:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705526665; cv=none; b=rpN1WFLBa3Z/qMzHXDLWm2icTYNvkackySp4IjX4EygP8CGUP3R9Y0QUz8dGjuDg9NdvNHbML9XF66CjVNsDMDt81l65nXgMJl1NjmRTv2i+AC4Tg3K07XxMBxApnvuNmKU1EeycqYH3oQApfj+7HOFOiBDcKC08jMw8iXFlyc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705526665; c=relaxed/simple;
	bh=rr/O9OnzgwSihYNKoOt11Ezoi6TqX6d/sDWn041aOvs=;
	h=DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:To:Cc:References:Subject:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Provags-ID:X-Spam-Flag:UI-OutboundReport; b=FkdD4ASWocptS/NXd+I++UCOThhYG9aa2go5UhowvFWqpu6P4OOJlKYzseho0lrwLV8TT+F6bIlLTH9/KoOcGIGVs/UtShhDzpnt/WMiEv+rIt9ncG1K3uf0DC1iSqVzVo92EjEVxDDTVCDiBlK44WxgvTkLAgazBHAPqXS96Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BGG+EdFE; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705526647; x=1706131447; i=markus.elfring@web.de;
	bh=rr/O9OnzgwSihYNKoOt11Ezoi6TqX6d/sDWn041aOvs=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=BGG+EdFEdB8o5/ex2syX84gzb69X81Shks8euCQc0X9v9MbRC1vbOpTOiaPnyuxC
	 cZjBGrpCqia9b7VjGAGIfUFjkK9jBPv/C2I3oGBlHmPk8nB6+t8D2tP8sPiGMD92j
	 LAlsLDfxgOiICCRVl9wFFsDY9hsmLimWFvkK3xH/TMbTDM3MSj+pts6rrCCsLOMSY
	 hjXh+K59ayhfuXnXyw6avRCCLqg3RWLaOpjXQxQXUq+TZkuAuaqrFHPBUSw8vv//C
	 0bHZ7Yg8Ah5P6j3+9yXE47rFzSRVKgNZsKFKPZJh/aG/vMJcKKHTgBtDG+otqtnSb
	 6ZY2icE3bNgfh3o1ug==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8Bw1-1rVSRo2gIV-005OhR; Wed, 17
 Jan 2024 22:24:07 +0100
Message-ID: <4934093b-86c0-4889-a5e9-0f9d63fd528c@web.de>
Date: Wed, 17 Jan 2024 22:24:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kunwu Chan <chentao@kylinos.cn>, linux-scsi@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "James E. J. Bottomley"
 <jejb@linux.ibm.com>, "Manoj N. Kumar" <manoj@linux.ibm.com>,
 "Matthew R. Ochs" <mrochs@linux.ibm.com>,
 Uma Krishnan <ukrishn@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Kunwu Chan <kunwu.chan@hotmail.com>
References: <20231127025127.1545877-1-chentao@kylinos.cn>
Subject: Re: [PATCH] scsi: cxlflash: Fix null pointer dereference in
 ocxlflash_get_fd
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20231127025127.1545877-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iqDmz8NJdlIeTl5UAA2WHvmAFHU+jenQ98f6n/XdkUaFyhUHwsC
 82FLB4xRI0gLxyUZOIVJvbwzbZtUe/ml/htrM4aPHr/VJ3hgKb8/Tp4b4qJLNOtyLQWKz3b
 20kMtwa7IcmJOcYEcjxI8G0NFWkGHCyLjOeU0EmAaRw5Dj71S+U8njmuZW7Al/9sF0rgY53
 EiCBtnbiK/VfOl1+fD5rw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PBqwc8dxBqM=;FLyDzZb62/ebRUi/Ah3sVBl6gCB
 gNk1emMMlYhJdlu6UjSnn2UOrPQfVSM4HqQPqYQn2UqpHObhR+Y2UEidTb3K8WHSXfEK6JWjz
 zeJKTDjK8hlG+IVoZGBHbP1fXJXH1u/edn0U5LKlFiK8Ci2rXXUIsay3Mcwhc39gWIv5XgQjD
 JaTiyX4FXaR3dkp9R+B5cCH+GwuO//2Aunw69FURHE/jbKlpJxj0UDi6NGsqq3d/rYn0RNYcD
 v5NBH4ks6kVfEOcrpXMyjmH6MLh0I6LE3EZID/hboIkhqM8Mcwv0fQBSamLX4j9kSCuqdBC3/
 TOzvDOTuGSIxSvMS5oZmRvoA9cMK4wgWDabX/U3m6pPnzXJmpwcXwUn6VHNZWfYi/REdXGjU2
 w+mCR5LRTZ2YseYWR44FuVzxcnAiqGCaH9RoZAp6eWMAMcb7PeDQzM45dgZqBw+EhWPNmblQX
 RKipQz96zxASADZ9tnAjOHOZPm8YEGhOvjt7vILrFzovnmmgNEGjpCZyT/rlSHLyVAG4e7eq8
 03LeiH46gF/ZhEfD6P/FJsIxk65LIOqIsxkU+aGORXUK27mWF7Iv8CIplAI9PmJrUKZWzJkd2
 aCnix+Qq0eoyl57ic3woBwRlDaKo6nxkqNrUsrzc4sPaRkFP+sAUpE1YX0T0CnPbwHQj9ZVv0
 60SoAP59bbB58k9ohrd3j1CXA3Qn/PC4P2oxiVN/BWFoyDIGSMIIQp3g95+XWZn6G2vpfPYUZ
 JF7sTKCFUhO2AcDqYr0jZ5vDnPuc7kkfEjfYOZ3J5H9kSBlUQXyvUNW6ZfHu6Djwc8TKCdVQf
 ch1LxZd5dQWU9QjPYM0FptNYTYKvThVGWEi3mLnfZcHCMYEkROxpz+ahlx9A6APBSSrvZ7hwJ
 mO2hEafkniq95XSGJc+kE4JyV4fqc+a6On98usyFTx+9zgc8Tq8XjXkfdCR9apa+qmthYde41
 x0md6w==

> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
=E2=80=A6
> +++ b/drivers/scsi/cxlflash/ocxl_hw.c
> @@ -1231,6 +1231,11 @@ static struct file *ocxlflash_get_fd(void *ctx_co=
okie,
>  		fops =3D (struct file_operations *)&ocxl_afu_fops;
>
>  	name =3D kasprintf(GFP_KERNEL, "ocxlflash:%d", ctx->pe);
> +	if (!name) {
> +		rc =3D -ENOMEM;
> +		dev_err(dev, "%s: kasprintf allocation failed\n", __func__);
> +		goto err2;
> +	}
=E2=80=A6

How do you think about to omit the extra error message?

Regards,
Markus

