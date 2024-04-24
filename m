Return-Path: <linux-kernel+bounces-157250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 932308B0F1A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B24C1C21186
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50CC15FD01;
	Wed, 24 Apr 2024 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ta301A7l"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F8B1422AF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973954; cv=none; b=a6kbeUkZywrRmVJkpXi6mx9LCi0Lt1hHmPqsVwE6tvGnEQwvTl2TCNGg4o31rs/kZlZZ+FEe+BFcpfmxe75Rjd2mE0+gy+ebR5QRFPjMrMKCjPm2ViZP0yT0BIEzoRvthpnsUGYVgEkAu6lKtN8JQfUXdixFITni5bXL/WjIZ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973954; c=relaxed/simple;
	bh=oo33Ekn8sNMAj8kE0HDHgjQpsSxVRvX5+mLw4VDaKTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWVCbcjDuNkQUV/T1OZvTVn4PbHWJpudOKed051DCG9d0ACPl9ewsQ8Ogvr9LJ+kfVTH9w4F7oPE2WmdcKx7oCodOy6khwHjyVkJ36XFXPG1YhVNqMj6RL2uo5DcZtI6jUd2lrXmt7Z8q5fklg3XUL/S1bHQzUiNROWe1/yL6Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ta301A7l; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so3936a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713973952; x=1714578752; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rrg8wwpA92kjivH0TKg4TZtfTIvVrn3ddePAYWoa0qw=;
        b=Ta301A7lDHfvZhNn8Yvri60QGrwM8ArewiyTL97NuO2+HFRd/C8sqIa8hjjVCfcbLL
         Qy2x+qrOnhXkI6qRV4zRcXkewFzl/YnNRqdryHXU3UHFwk91OaVmmZtr5PKwosMQfc0r
         rxxj07ddwo6TsJLJlZOwgdK+624PZOWgjxhWSEZ/FXlcsBdg1N8MraZsact/UTT/bJ6r
         slf3RhcKS7tT4U3DZfUN7OJow46+Vd/4v5YUvL47uKv0N3u3xKTAJYoUTwvcZGky9RoQ
         eueOoaWIwNaSO+C14JsLPbPPzG9fl5iWPabYkasUmHj1AFSbaq83bhNl7xa1wzKdy3eD
         vcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713973952; x=1714578752;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rrg8wwpA92kjivH0TKg4TZtfTIvVrn3ddePAYWoa0qw=;
        b=DzC9IQTyRF8KQ29xKj9SZRWo0/eRQZ/l0gZzR+Gsk6uRYWlhvo/XRQoUr2jmATvAxv
         25PbFKbM8T2FyVuQeKSn3vyRsUQ7lgV3YPjQFgW+M9vJZ6b50Zq6Qr5zKZ9bBSypwFr0
         w9cl3lNvAVZUBHRYFnGzEYg+vvD5LAPlYYc77eQP57GT8V8Xthf0yROOArPo9/Jxsxhv
         FbKg2Qpe7+tcgHQ9J49R20rsz4gUFHbJ147SNnDvcsZGP1ExPIyGKTpSo02t6JjRr4rZ
         p4tMUQYq1ZlVJWMtfS/v1K4yfqe1ev8HGwJApQSkU8ckhbP/XMx/zLXK8WBkqJwuweZ6
         a4nA==
X-Forwarded-Encrypted: i=1; AJvYcCVE+OILettJ0HE89NQzsMK3/x+Q9MpVHSa8pxet72cBOsZ/azyd3OOB31lCwHQMkYFKYhWBji0u123hVT0yfWkbmfgMhsl3tCeS4C3i
X-Gm-Message-State: AOJu0Yy8WOlLC45DJTWtqOK8rZ3Zxsh1H09Ema1rjGut/Ra+LoF4cujL
	TIQIJix0o2nm9RFM4JenLq4pDUGdhK8oL2gwSVLWEe6t4wx1Gd2HqUaKPU2CCxc=
X-Google-Smtp-Source: AGHT+IFJz2davFxl/umAykqWCqyRrrGNTJwfxgAOiKqEZ16/Hd7Gt5Q+2HCcbgUlPTtL3ULXGxROYQ==
X-Received: by 2002:a05:6a21:33a0:b0:1aa:6167:b6d6 with SMTP id yy32-20020a056a2133a000b001aa6167b6d6mr3249147pzb.42.1713973951946;
        Wed, 24 Apr 2024 08:52:31 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:e523:8f5:a4a3:fdaf])
        by smtp.gmail.com with ESMTPSA id v22-20020aa78516000000b006f03a06314esm11614021pfn.195.2024.04.24.08.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 08:52:31 -0700 (PDT)
Date: Wed, 24 Apr 2024 09:52:28 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Olivia Wen <olivia.wen@mediatek.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Tinghan Shen <tinghan.shen@mediatek.com>,
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	jason-ch.chen@mediatek.com, yaya.chang@mediatek.com,
	teddy.chen@mediatek.com
Subject: Re: [PATCH v3 4/4] media: mediatek: imgsys: Support image processing
Message-ID: <ZikqvOwh5aHi6iug@p14s>
References: <20240424030351.5294-1-olivia.wen@mediatek.com>
 <20240424030351.5294-5-olivia.wen@mediatek.com>
 <ba25cb7b-ff93-4fcb-b943-154e960d45a0@collabora.com>
 <fd24398f-a915-4e9a-9c19-4eb644178987@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd24398f-a915-4e9a-9c19-4eb644178987@collabora.com>

On Wed, Apr 24, 2024 at 12:04:54PM +0200, AngeloGioacchino Del Regno wrote:
> Il 24/04/24 12:02, AngeloGioacchino Del Regno ha scritto:
> > Il 24/04/24 05:03, Olivia Wen ha scritto:
> > > Integrate the imgsys core architecture driver for image processing on
> > > the MT8188 platform.
> > > 
> > > Signed-off-by: Olivia Wen <olivia.wen@mediatek.com>
> > 
> > This should be reordered before introducing the 8188 scp core 1 support commit,
> > but let's check with Mathieu before sending a v4.
> > 

I don't have a strong preference.

> > With that reordered,
> > 
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Wait, no. Sorry. I just noticed that the commit message is totally wrong.
> 
> This is not a media commit, but remoteproc, and you're not adding support for
> image processing with this commit - not in media at least.
> Also, you're not adding any imgsys core architecture driver.
> 
> Please fix both commit description and title.
> 

I agree.

> Regards,
> Angelo
> 
> > 
> > > ---
> > >   include/linux/remoteproc/mtk_scp.h | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/include/linux/remoteproc/mtk_scp.h b/include/linux/remoteproc/mtk_scp.h
> > > index 7c2b7cc9..344ff41 100644
> > > --- a/include/linux/remoteproc/mtk_scp.h
> > > +++ b/include/linux/remoteproc/mtk_scp.h
> > > @@ -43,6 +43,7 @@ enum scp_ipi_id {
> > >       SCP_IPI_CROS_HOST_CMD,
> > >       SCP_IPI_VDEC_LAT,
> > >       SCP_IPI_VDEC_CORE,
> > > +    SCP_IPI_IMGSYS_CMD,
> > >       SCP_IPI_NS_SERVICE = 0xFF,
> > >       SCP_IPI_MAX = 0x100,
> > >   };
> > 
> 

