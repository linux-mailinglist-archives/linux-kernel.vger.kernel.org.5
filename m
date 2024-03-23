Return-Path: <linux-kernel+bounces-112285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 621908877EB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 11:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F991F21C6D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 10:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6E810A14;
	Sat, 23 Mar 2024 10:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fXH8aU6t"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B266DDC6
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711189148; cv=none; b=ceRhigxPEZlkhq2WsM9Fc3eAVLnfUY7HQva/2/9t55teYAdGU6wuwn0ifu0fw5+UMMXJLYNJ6MuWlmiRnYLl6LzfDbsbmJVKhYFlrTZYB+fesWmeKkT8jKACGCKAQIccEWxC5qBuU/lpZ5KECxb7tOHY7AnJmspHhVENORaPZg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711189148; c=relaxed/simple;
	bh=yWkds7nD2ZS519CEcHKNQhFmrIHYkW4kP2K1ilnU+Pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxC+h3Wgk6WC2ugrvx+apI6EE6kEMJWoUj5EW1D+gLcXYHhFFIYzsBnZSGqCVqrutpc8BvW3ImrYu630kVJ0wAT7TCBGScEv9KArTwWh+dMDm/rehGO52pSzZ5Oj+Bix3Pkfaho39reRTt7q+F1bm077LP6VygbmY0sxF+WNioQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fXH8aU6t; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56be32b9775so1844972a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 03:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711189145; x=1711793945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jsWVUzTZjb8sGoPxm2j46t2rbn6viTMSYqvI2Re5TR4=;
        b=fXH8aU6tsORX+8Hm9qgsWdOvAh/MUtiKcFNhR9OYAAVlkyrPMpXDiv5M1owlnJpFuw
         LeKbQfqdhbQOEw51iFRYvE1u5SCX1RqAUjf+Jbt9naU4NWjCt5/7a6XeO0Re5LVLxRA8
         VYfQP+WOY9dDuFpSTpiawcruJpj+AOpbEYutJVLhAFGcOaiX/WRdWqJEH+4c/Lwsnd+L
         X8ZhDU0y/iSGIG6n3wUuYdXzksaIGJc2VRbnplz27cNkFt7WY4xpeUUSAXkOUPklvsSH
         Ml4fK8TpvGJ78DTVct9x1/xTbbxCSYnEr8su3wEKG58q3ou4NEI9j1/9SECcBoupT/cb
         Y4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711189145; x=1711793945;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsWVUzTZjb8sGoPxm2j46t2rbn6viTMSYqvI2Re5TR4=;
        b=WQfbGR749mqJfafUkCT/ykghvrLPwwc5yQuidpjy5NoyqNLaq9Q3suxfZqa3UsnldD
         gC+H1GBb6GNQw0Mku+gGfYonAWgljCzi2H1ES9OIaTsg/wRqIN5ZXt9VZgHGlc0NqSlh
         AHluv+roYuKb9BSmk16ywQxldxLzT2uAHBerio974aBep5c3TgCfhhIqFHT9/qwxgzVt
         0hmlncUaygeW7u5ZeFoSEEzs4GBDp5smaw4gcKU3yhcWggJFBp2IlT+vNPjDczHlPZCM
         HqXfxktFSF+5GqUeHxaXi1qpjcrZPNPvIjsthxnuVJGkGe+RBmcqHk2EE64PYBejf54j
         /KhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW5IGffWZEz9BaOdZBN3Hq3uPmapd+lXeA4A0d/ShYMYfxOnXl9RzuI563V9J6SlVj9lLOEv9oll6CVbl4i9O8tO2iTOquI9K3eqzY
X-Gm-Message-State: AOJu0Yzwey8YXLBPGnaHlxvmalZqecM4pEHeQFfx6PZSDMpajOPFMICI
	VrSD7jX8/WWkqkqHNk2ulB5I3rJwvMEFKkZhdkSmznETVn3oBsJRCMvI9h2Lhc0=
X-Google-Smtp-Source: AGHT+IGQslGoKM0t42VsynDcdmkNlrLvqjsHEB56Do9omRsijDvuZnkqdoR90hWKpBnqiuSFScyYMQ==
X-Received: by 2002:a17:906:6bc3:b0:a45:ab61:7a47 with SMTP id t3-20020a1709066bc300b00a45ab617a47mr1315089ejs.16.1711189144821;
        Sat, 23 Mar 2024 03:19:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id le13-20020a170906ae0d00b00a47464a6ee4sm369968ejb.173.2024.03.23.03.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 03:19:04 -0700 (PDT)
Message-ID: <13fcafd7-2e10-485e-bd39-acf67288f07b@linaro.org>
Date: Sat, 23 Mar 2024 11:19:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] Setting live video input format for ZynqMP DPSUB
To: Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Michal Simek <michal.simek@amd.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-media@vger.kernel.org
References: <20240321-dp-live-fmt-v3-0-d5090d796b7e@amd.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240321-dp-live-fmt-v3-0-d5090d796b7e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/03/2024 21:43, Anatoliy Klymenko wrote:
> Implement live video input format setting for ZynqMP DPSUB.
> 
> ZynqMP DPSUB can operate in 2 modes: DMA-based and live.
> 
> In the live mode, DPSUB receives a live video signal from FPGA-based CRTC.
> DPSUB acts as a DRM encoder bridge in such a scenario. To properly tune
> into the incoming video signal, DPSUB should be programmed with the proper
> media bus format. This patch series addresses this task.
> 
> Patch 1/9: Set the DPSUB layer mode of operation prior to enabling the
> layer. Allows to use layer operational mode before its enablement.
> 
> Patch 2/9: Update some IP register defines.
> 
> Patch 3/9: Factor out some code into a helper function.
> 
> Patch 4/9: Announce supported input media bus formats via
> drm_bridge_funcs.atomic_get_input_bus_fmts callback.
> 
> Patch 5/9: Minimize usage of a global flag. Minor improvement.
> 
> Patch 6/9: Program DPSUB live video input format based on selected bus
> config in the new atomic bridge state.
> 
> Patch 7/9: New optional CRTC atomic helper proposal that will allow CRTC
> to participate in DRM bridge chain format negotiation and impose format
> restrictions. Incorporate this callback into the DRM bridge format
> negotiation process.
> 
> Patch 8/9: DT bindings documentation for Video Timing Controller and Test
> Pattern Generator IPs.
> 
> Patch 9/9: Reference FPGA CRTC driver based on AMD/Xilinx Test Pattern
> Generator (TPG) IP. Add driver for the AMD/Xilinx Video Timing Controller
> (VTC), which supplements TPG.

None of the last users of your API can be merged, therefore this API
should be considered as without users. We do not add API which does not
have any in-tree users.

Best regards,
Krzysztof


