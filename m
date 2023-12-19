Return-Path: <linux-kernel+bounces-5746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59877818F02
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9D11F29049
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987CA38F84;
	Tue, 19 Dec 2023 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcnZ9NKY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF8B4B13D;
	Tue, 19 Dec 2023 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3ac28ae81so24310195ad.0;
        Tue, 19 Dec 2023 09:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703008351; x=1703613151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GWs5/78iGYXOgAy2HmBDe2CVxDcBUmbJSBwHK3emws8=;
        b=PcnZ9NKYFLcRS+G8/5U2RrQ4Vg/rxckSC3ugHwB3kJkaczrRj/Mj+e33+KNscS7cq9
         kxrJHFJwRc+EhdqSiEL/x/Xo51N5lUQ6VvTj9tpooJyURwWIkXyrUeVO3rTCUIoHd1OC
         Jy2N1Efnwo957VFrnt5ccJJau7RScOKk+Mo04RAFkqQdwUCJxkUEsbhlQSBfo3OaxFcG
         AB7gSBi3LtYNRXbA4Kwx9iMg1pov3iq63gRQ04YoLnwpyolVhs1+iEY4R9It711YB9dJ
         /aPL3I29zAdyMbUwUZWdxhPLlm19XhQFAxANTR1xYnguRRlYEVdR8/sz3ym2s1vZ+n9k
         FIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703008351; x=1703613151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWs5/78iGYXOgAy2HmBDe2CVxDcBUmbJSBwHK3emws8=;
        b=bOxjzz3jBM2cu02fc4dNIFwfeuz82qFWE8T7JOLJdPTg8ISr4z4hBMdB/wiqwEG4RX
         x+mSVnBMsDZjVDDYppir0qvvclCl/88CosZw+q45PlKKFe8ksBTGkvLQMwnlIRi6YsxG
         Bs50kRKve8k5R841K97eumVCd8ASI9RfY904Cr8TVCHWaLdKGNRJyZerCLxfjZw1ICVV
         6F8X3h3BmyAw8fdIHcrTbRdj9JVFzsnK3WT9dRiUqk/mug1ywE4JhHU110ldckK6sCA6
         ol48wKKRBCNS6ZQhVFC+FvsGmm0aFWjOjnZ137Mdc5WHoUmX125xgKUpWGIFX7EJtGAw
         Xi8g==
X-Gm-Message-State: AOJu0Yz6wVYDIa80KpnC0zNJjB4bc0vFgcLtwHeBwzuQpZYh8/L8izSS
	geXpAl3eRfiYbLoAFIleclA=
X-Google-Smtp-Source: AGHT+IHrWmanCY0G9LlI5KHOyhIrjYu37wOFzz3+pj1aAiO/1gzkIjpvml6BIlC6xl0SmPasWzOGKQ==
X-Received: by 2002:a17:903:2cc:b0:1d3:488e:a4b7 with SMTP id s12-20020a17090302cc00b001d3488ea4b7mr17195075plk.128.1703008351003;
        Tue, 19 Dec 2023 09:52:31 -0800 (PST)
Received: from debian ([177.240.14.150])
        by smtp.gmail.com with ESMTPSA id a17-20020a170902ee9100b001cfc1764fa7sm4277198pld.1.2023.12.19.09.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:52:30 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 19 Dec 2023 09:52:27 -0800
To: Ira Weiny <ira.weiny@intel.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Fan Ni <nifan.cxl@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
Subject: Re: [PATCH v2 2/2] cxl/cdat: Fix header sum value in CDAT checksum
Message-ID: <ZYHYW-kaYLNPHXpj@debian>
References: <20231117-fix-cdat-cs-v2-0-715399976d4d@intel.com>
 <20231117-fix-cdat-cs-v2-2-715399976d4d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117-fix-cdat-cs-v2-2-715399976d4d@intel.com>

On Wed, Nov 29, 2023 at 05:33:04PM -0800, Ira Weiny wrote:
> The addition of the DCD support for CXL type-3 devices extended the CDAT
> table large enough that the checksum being returned was incorrect.[1]
> 
> This was because the checksum value was using the header length field
> rather than each of the 4 bytes of the length field.  This was
> previously not seen because the length of the CDAT data was less than
> 256 thus resulting in an equivalent checksum value.
> 
> Properly calculate the checksum for the CDAT header.
> 
> [1] https://lore.kernel.org/all/20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com/
> 
> Fixes: aba578bdace5 ("hw/cxl/cdat: CXL CDAT Data Object Exchange implementation")
> Cc: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V1:
> [djiang: Remove do {} while (0);]
> ---
>  hw/cxl/cxl-cdat.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
> index 24829cf2428d..67e44a4f992a 100644
> --- a/hw/cxl/cxl-cdat.c
> +++ b/hw/cxl/cxl-cdat.c
> @@ -49,6 +49,7 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
>      g_autofree CDATTableHeader *cdat_header = NULL;
>      g_autofree CDATEntry *cdat_st = NULL;
>      uint8_t sum = 0;
> +    uint8_t *buf;
>      int ent, i;
>  
>      /* Use default table if fopen == NULL */
> @@ -95,8 +96,12 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
>      /* For now, no runtime updates */
>      cdat_header->sequence = 0;
>      cdat_header->length += sizeof(CDATTableHeader);
> -    sum += cdat_header->revision + cdat_header->sequence +
> -        cdat_header->length;
> +
> +    buf = (uint8_t *)cdat_header;
> +    for (i = 0; i < sizeof(*cdat_header); i++) {
> +        sum += buf[i];
> +    }
> +
>      /* Sum of all bytes including checksum must be 0 */
>      cdat_header->checksum = ~sum + 1;
>  
> 

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> -- 
> 2.42.0
> 

