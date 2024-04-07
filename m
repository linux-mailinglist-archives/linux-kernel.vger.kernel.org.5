Return-Path: <linux-kernel+bounces-134640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BF889B3FF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 22:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B221C20D55
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 20:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F2938DED;
	Sun,  7 Apr 2024 20:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="swrue9iD"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B579848E
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 20:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712521920; cv=none; b=E0ii+8wuu3br+1MaPt/UdBtqquEIHLW6d+/UIj5IRz/TGcX6Cbo5gOApo6KyMhLOEkox4h9EaYCWxD1MCrckq8KlCPw3pVsjCxIk496ZuweoA2uu5ExdgOfln5wdXEBW7CXY2ovFntrgJu6gtI6xfO9eZDQ9sAV79iVL7IWW0BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712521920; c=relaxed/simple;
	bh=BuhRDogVus1zI9H0XqB1SzKqz+CmrY8+s3e5ZCTcX1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXt+Co3UQAjbiRGBbbo1j114VvNbu/Qcj/PNVSKbn8ayooqduC+8s1pAlPCZMRNO8NryFANkpuHmSWltwFYlk37FG/lfUMidLSoqQBNhDXCRlxqeVy6Y0Wn7BQ53BccgqJH4D5CJkNHZdtPZsv3nzxYrF9CRg9an6bxX0dud3kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=swrue9iD; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5171a529224so34668e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 13:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712521917; x=1713126717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BC/Vp9aTo7ncwzcGpzKoHrU+RFhFC5D/RE+BHxHMCVQ=;
        b=swrue9iDWmOREHB+bMw8mQ/3SElk9YzKXNf3GPTCJ++ZtJKZ36LwIOJHkjLwrkMdYj
         /ii/syRvRKigaGX0obQaB1EVj7DP1zJsMGo27V/XrWgvSTi7b4mDx28Hfa/uQqJYC/G+
         DOO6BBwK5SS4J/wkY/eZnhIzbdoy8KKYmNxFelX55fq51WMBLKPiEpkaONWumSU1K6ix
         FuNGHJDJUlAw4OVs8u0vAepNxJhYasPNQ7JKmr5YUcfnWcfFL2yRi4eYwIfbp4P7OI7C
         XU1HxuqqTmPxvQAFupw9zX/6Lh18EZ59HCZINgZvSvg/darWYjxyAZXN3g4RKzR/1uzE
         Uyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712521917; x=1713126717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BC/Vp9aTo7ncwzcGpzKoHrU+RFhFC5D/RE+BHxHMCVQ=;
        b=aZldJ0qj51UPrNzsltqmqgRnpe8k2RIeWe9Pxolq5PKz/HB7uTFlwsQJok4dZwaMBb
         vKeHC8F914Ot41z9TOX5KJbaRkkby1SRBIetWnjV95qBZ7jx1LA7JpGqDSPqIk3zRNnb
         CGD45C78yWNwVwCzc/i7mvK61nnm5bvs0Xmll73VIC8mnp+1iMtk2NR5UGVC+G7yi47E
         kHDTeA9UVNY9sz4WEbEwtL3QccZKIM7SHwTZZI1TNpe5v/wGeHXKD6tbG3JA13iI/4wZ
         S6B3uS2Ec7WbMFxnIa1TQe3car6GMKtdihTEnCmbXp5lqd//tHog9gdjVowOagWLd+Qo
         6h+g==
X-Gm-Message-State: AOJu0YxyvsHqTDDiF54o36Uu6E+e3i6PbFj8iE2ipq+E7B2Z5osxrFAG
	Hi0pSd8PgbOdfEx3olxNsVr1mbXNL/slvqLj4coC46vpBVEHr3/WL+8AQtESzAE=
X-Google-Smtp-Source: AGHT+IF4DMVCMB62tkqkfik57o48lX1JfihPhY8NVWkCpw1jpdJU/hGDdnCKUtnIerJssNTIq9AzTA==
X-Received: by 2002:ac2:53bb:0:b0:513:39a0:1fec with SMTP id j27-20020ac253bb000000b0051339a01fecmr3969120lfh.66.1712521916570;
        Sun, 07 Apr 2024 13:31:56 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzyjmhyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a00e:a300::227])
        by smtp.gmail.com with ESMTPSA id j29-20020ac2551d000000b00513a1fe7767sm919668lfk.209.2024.04.07.13.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 13:31:56 -0700 (PDT)
Date: Sun, 7 Apr 2024 23:31:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Alexandru Ardelean <alex@shruggie.ro>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, adrien.grassein@gmail.com, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, 
	jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, stefan.eichenberger@toradex.com, 
	francesco.dolcini@toradex.com, marius.muresan@mxt.ro, irina.muresan@mxt.ro
Subject: Re: [PATCH 2/2] dt-bindings: display: bridge: lt8912b: document
 'lontium, pn-swap' property
Message-ID: <dxm3js6qpcw3n4duid4vmhnkxacmzgq4rnvpbdx62pcn34ybzc@q57pst7lyumf>
References: <20240402105925.905144-1-alex@shruggie.ro>
 <20240402105925.905144-2-alex@shruggie.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402105925.905144-2-alex@shruggie.ro>

On Tue, Apr 02, 2024 at 01:59:25PM +0300, Alexandru Ardelean wrote:
> On some HW designs, it's easier for the layout if the P/N pins are swapped.
> The driver currently has a DT property to do that.
> 
> This change documents the 'lontium,pn-swap' property.
> 
> Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> ---
>  .../devicetree/bindings/display/bridge/lontium,lt8912b.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml
> index 2cef252157985..3a804926b288a 100644
> --- a/Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml
> @@ -24,6 +24,12 @@ properties:
>      maxItems: 1
>      description: GPIO connected to active high RESET pin.
>  
> +  lontium,pn-swap:
> +    description: Swap the polarities of the P/N pins in software.
> +      On some HW designs, the layout is simplified if the P/N pins
> +      are inverted.
> +    type: boolean
> +

I'd like to point out the standard `lane-polarities` property defined at
Documentation/devicetree/bindings/media/video-interfaces.yaml. You can
define and use it for the corresponding endpoint in the lt8912b schema.

>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>  
> -- 
> 2.44.0
> 

-- 
With best wishes
Dmitry

