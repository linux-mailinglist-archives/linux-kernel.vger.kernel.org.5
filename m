Return-Path: <linux-kernel+bounces-13679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA4A820AEA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 10:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1AC01C21767
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 09:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100C933CF;
	Sun, 31 Dec 2023 09:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VntuFeP4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA388610A
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704016213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQwLyxRVqkJ+kYuszxuoBP5x10ugdyX648DqZogP1FM=;
	b=VntuFeP4MA9+QWlaxcRpFwsQGEqd58D+a689cPg1VzolTcM7J4pJHQd8UbFYKtgY9j7jUY
	IxdeCZlzBiyc3PNmsadDWJB/RjF3yHUH3AaaiYVrD2W99OE9gH7t5w++Aoa0E2vWwFwnZD
	vSZhTxCCVFG5u9HdIP3SZLCxcAwYlYc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-QBr9TnhSPgeRUSNsm2CY6w-1; Sun, 31 Dec 2023 04:50:12 -0500
X-MC-Unique: QBr9TnhSPgeRUSNsm2CY6w-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50e91f9d422so1395214e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 01:50:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704016211; x=1704621011;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QQwLyxRVqkJ+kYuszxuoBP5x10ugdyX648DqZogP1FM=;
        b=sk7ITRXWIpNXv+Qq7viE1sFGWPE9fgmPOg9gxBmJvI5WRTzViSI6U122Uk3JC/uHOa
         UmtfsO+TLWoPUbA7CuC/LRPkdzS0lSpC9O3jLekdysver2bVmf5Ur1HCGi7/pLUxgzDV
         z8phXw3+LuslVkm2a9Ao6u4L+KGznCeZzRBT/3kbPw71we2ouoOgcJZxmXNEDSPPrjyQ
         PaS9feHWV/T3zA8U2kmcEHgDd0TRuMj27OTGhdes8ABwwcbBmDQyb7etmxZBXmeDVVbg
         Tl9sMX+sypeTIODVp9Iew2E30m0lVUqVL9/NlhdjRMadVarwcx9kZ0QdADwPcOUgNq4y
         H0zw==
X-Gm-Message-State: AOJu0YwJqP/DeyL/lGoH4vIb531EWoIvaGjg8Eld0YIGhkolZeQ8rX6F
	xuoaKA4Fp7aDC6Ycz+CFLYnVAYsniL4TsDcmQlp7PIcIysAM26ofqZI2yvhzcvP/fRl4AT1DSpx
	oguuZvcYM6k/z8ZQIrBMwkZBl/WnGwgyT
X-Received: by 2002:a05:6512:60c:b0:50b:f7bb:4545 with SMTP id b12-20020a056512060c00b0050bf7bb4545mr5402832lfe.68.1704016210851;
        Sun, 31 Dec 2023 01:50:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGTXOS5OP/7s7cUFSpzRSVVhXB+zVNEwUzKcKkS6C7M/kHt9/vMcvTNZsWjUlh3SL2wFNvaw==
X-Received: by 2002:a05:6512:60c:b0:50b:f7bb:4545 with SMTP id b12-20020a056512060c00b0050bf7bb4545mr5402823lfe.68.1704016210671;
        Sun, 31 Dec 2023 01:50:10 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id p12-20020a05640243cc00b0055493aa8905sm9894390edc.63.2023.12.31.01.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Dec 2023 01:50:10 -0800 (PST)
Message-ID: <c66ced4c-3f42-4eb5-b247-f6abe75e5eb0@redhat.com>
Date: Sun, 31 Dec 2023 10:50:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: media/atomisp/pci/isp/kernels/macc/macc_1.0: Fix
 spelling mistakes in ia_css_macc_table.host.c
Content-Language: en-US, nl
To: Dipendra Khadka <kdipendra88@gmail.com>, mchehab@kernel.org,
 sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org, hpa@redhat.com
Cc: linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20231223081354.83318-1-kdipendra88@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231223081354.83318-1-kdipendra88@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/23/23 09:13, Dipendra Khadka wrote:
> codespell reported following spelling mistake
> in ia_css_macc_table.host.c below:
> 
> '''
> ./isp/kernels/macc/macc_1.0/ia_css_macc_table.host.c:22: matix ==> matrix
> ./isp/kernels/macc/macc_1.0/ia_css_macc_table.host.c:39: matix ==> matrix
> '''
> This patch fixes these spelling mistakes.
> 
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>

Thank you for your patch.

I have merged this in my media-atomisp branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git/log/?h=media-atomisp

And this patch will be included in my next
pull-request to Mauro (to media subsystem maintainer)

Regards,

Hans



> ---
>  .../pci/isp/kernels/macc/macc_1.0/ia_css_macc_table.host.c    | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/isp/kernels/macc/macc_1.0/ia_css_macc_table.host.c b/drivers/staging/media/atomisp/pci/isp/kernels/macc/macc_1.0/ia_css_macc_table.host.c
> index 946b074e8288..d25bf59273ba 100644
> --- a/drivers/staging/media/atomisp/pci/isp/kernels/macc/macc_1.0/ia_css_macc_table.host.c
> +++ b/drivers/staging/media/atomisp/pci/isp/kernels/macc/macc_1.0/ia_css_macc_table.host.c
> @@ -19,7 +19,7 @@
>  
>  /* Multi-Axes Color Correction table for ISP1.
>   *	64values = 2x2matrix for 16area, [s2.13]
> - *	ineffective: 16 of "identity 2x2 matix" {8192,0,0,8192}
> + *	ineffective: 16 of "identity 2x2 matrix" {8192,0,0,8192}
>   */
>  const struct ia_css_macc_table default_macc_table = {
>  	{
> @@ -36,7 +36,7 @@ const struct ia_css_macc_table default_macc_table = {
>  
>  /* Multi-Axes Color Correction table for ISP2.
>   *	64values = 2x2matrix for 16area, [s1.12]
> - *	ineffective: 16 of "identity 2x2 matix" {4096,0,0,4096}
> + *	ineffective: 16 of "identity 2x2 matrix" {4096,0,0,4096}
>   */
>  const struct ia_css_macc_table default_macc2_table = {
>  	{


