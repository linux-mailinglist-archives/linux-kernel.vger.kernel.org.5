Return-Path: <linux-kernel+bounces-161876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FB48B5294
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693A61F21686
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495CC15E85;
	Mon, 29 Apr 2024 07:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="FarfbKJu"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06B814A8D;
	Mon, 29 Apr 2024 07:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714377062; cv=none; b=bHUh8h5xyIHKAv5iTXvBbRQE5+CtqXYTHYSym2dsVdpKEXya3Fau7hZNjCAB2TLEvaCl0LWgYGPPeQGmDmnAD3g5DUC/EGtgSKI9m44z0vURuunaYFntCaMbbHz+xBxzrYU+PmcsldzQLXst5ZzX+2nZ1AgzU8hOSb0aCYdo1IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714377062; c=relaxed/simple;
	bh=o3lSfrItv9/X+b/XFKMfQD5nbXMPoTZ50KGLPNc6OGE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=l1nB9geywAR8I+qIyWvFgVngyFR4fyHMD6O/X6Fmir6W/kbUh9kAEZ7XSUomDlIVTMQmBVeRUNNP5Al9OiR9/E/xK1zzJtBaOxoqvOnY/QozpE05QKSX8ukD9WWrvIwr+HLoDFOpeDTaj1hvKRymRfoYC5pnkXKo9vYaadfv794=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FarfbKJu; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714377037; x=1714981837; i=markus.elfring@web.de;
	bh=PwgbfZv/QKuas8oXbIWGJWatANQIrG/1UIMV8+ZSv1Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FarfbKJupRCGXP0R8oQtmIYHvwMhx4ft5+v3MVRfBpzzZRKVotKNsM51gJc/YwVR
	 ltfcT19nSkWwmVDrl2Xw90bxilKSxjrvGBLh9Ji3zZNPolljUaSb5egBp9jNCiGBx
	 N43VQ87a6YmUxVGoiGTg+s8nJf4qOIVFFpFdW8irUvQZ7Dzp33SSFEZ4Szspca9Lb
	 0WzGnlJqJVq7J1zaiZue3riFEwJQWmPLZvO8jpfguvfLNJgfyjkqOZ0+EreLGT63W
	 OFg7hSK3Yom0IWqyiZqaJVAMWw9Mcor/4f9H+SKMmGCBxnKs0nyKxXQWezHV5jVKD
	 MPMhSbuV1uA3T/KeIg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mo6Nt-1sTHxG36eB-00q8PB; Mon, 29
 Apr 2024 09:50:37 +0200
Message-ID: <1df4e8d4-733f-43d9-a9d7-3764b6df7ed7@web.de>
Date: Mon, 29 Apr 2024 09:50:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Zhijian <lizhijian@fujitsu.com>, linux-cxl@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Alison Schofield <alison.schofield@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240429013154.368118-1-lizhijian@fujitsu.com>
Subject: Re: [PATCH 1/2] cxl/region: Fix potential invalid pointer dereference
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240429013154.368118-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/YgV0cA6lKGixm8+QuV2vBOSOM230psviYgQtCMgXsfzK+y0HVv
 NNnrBJriTCJRUoGnKcQNOEpO22Xg1cEfBZn6TbygF+fAexxqK8urnbC2mylPaocWLIH1tAk
 s6OWYF+JCmlEp8Z1E1RuSfGXj2xDbxySCoGip+a/p0YSfXzoELdoChrdTZa5lMbvaSifT2i
 Kkm1t/RtAiLLjl6OgNC3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5AUYALFlqcs=;5IN+RQpPqc6kRVvvKWiU6Ggjxpw
 Tks4v5dEKYql2S9K/LSiubnVjaA89gOJRCsQ3CxVSMec1F157wgvZl8gcdH1g01WV8fGrDWp8
 19kKNVKyhUxA0vZT7+mtOuOSPMLVaSFwlJz+2Q1mryG9tTyBtUaSG7ibhOCCc7a9uOkP9gUyc
 GKjOP4DeNBtmVBPHuG+HGCRUoXt1DNEPlL6YaSunFi8jodUF8L/L69lUG/xBr0avRkyUyQBLz
 MvGe3jzGef4UzPKwB+J9U7Hn7UsSczgkTQcv64VQdV7A1+vOWNCUgaIEgj3F6SVDV27QHYsXh
 +FjoJDUqLPO41CtGlRX3Eh1dQnLWoY/SlTIkmSWlNcSZX+9IAoeS2RMuDoefbLzEVt6+g2nqC
 lPDCcZ3xNENYMxnIlILc25WCD9pFRjXJ2olx2/f5fgHAYIl1n/+ijAfDKq5o6kXqUqL6x+1a/
 aJ+4hl+dUH3u9zFr7FNQAFR+03ecBpythDE2/h4DEtRxVa+NghOHnW0BOuF7WvcqLit90d7V5
 R2V8cEu2rg7zWJv1bRAV76rZfhQYafkGtjWWK190Ovc74eg7SM6G4MmgDqWxxuWJj4cYpHq6L
 6W6cJUpJ02EvgvPXPGV3qtUYGJHXflpv+pIfnlAILVXycrqOUkdHr9PHWHKD2GzIUzV0/P+00
 RfKNoWmiQWqFTdwbzOf6b0eW4JIHBetHCOk0Crd0Y/NeYcmk5oPX9BvhAxXsNgo5RvpgZ6LAH
 rh413SXfTRHE+XbNxs66eRGroq7Z0JJ9ykeG6WbEr90BeYyTYUBECnWZfTr9c/qG7EuLPIh2K
 UlShrw0Ppg93zthB4oCI4xecmzODj6/fZ3cnho8qIe6Z0=

I would usually expect a corresponding cover letter for patch series.


> construct_region() could return a PTR_ERR() which cannot be derefernced.

I hope that a typo will be avoided in the last word of this sentence.


> Moving the dereference behind the error checking to make sure the
> pointer is valid.

Please choose an imperative wording for an improved change description.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc5#n94


=E2=80=A6
> +++ b/drivers/cxl/core/region.c
> @@ -3086,10 +3086,9 @@ int cxl_add_to_region(struct cxl_port *root, stru=
ct cxl_endpoint_decoder *cxled)
>  	mutex_lock(&cxlrd->range_lock);
>  	region_dev =3D device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
>  				       match_region_by_range);
> -	if (!region_dev) {
> +	if (!region_dev)
>  		cxlr =3D construct_region(cxlrd, cxled);
> -		region_dev =3D &cxlr->dev;
> -	} else
> +	else
>  		cxlr =3D to_cxl_region(region_dev);
>  	mutex_unlock(&cxlrd->range_lock);

I suggest to simplify such source code by using a conditional operator exp=
ression.

Regards,
Markus

