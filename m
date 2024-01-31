Return-Path: <linux-kernel+bounces-46133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58078843B0E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E571286392
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33D5664B1;
	Wed, 31 Jan 2024 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="T+igxPIZ"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350E669940
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706693239; cv=none; b=BbKQpw01VDpo3wo07fJ5WZShsdEybMztPobRf/lUCi4pHqA8Q5QAMOQ5gLjxZiESu+6An8hnAqeVtPaOvIM7q4d5e7lg5J7+oxMlmbnTQXMghxgyBmO0/jbJZLppz0DB1z0o15fO6JkNMyWH65JXYAhqZXaAVsWl6Y6cPadlgNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706693239; c=relaxed/simple;
	bh=Y8OInFyezrqdukb/GwASp6AxHMdhZSdbYSe2C0Yjdp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNlsdOjD2aJfeHtu0j3sNHqJdSm0+CeC8UzZkVRpqEWo7VIII3Er8r8Mp95HHVuC/eD2oHhAs7jYXI6j5M52eYe2VID6TbyfqgbhJrVX8NyB8+WZmlzKR6vjbJZn3wfxhnCG9x2kU3JPULCQdctCpF50i0QyvyBeQpQlcOsUy1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=T+igxPIZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40fb3e278adso3920365e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 01:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706693235; x=1707298035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8OInFyezrqdukb/GwASp6AxHMdhZSdbYSe2C0Yjdp4=;
        b=T+igxPIZCS+2/RSlqXuMACcm/EWkQnd56pzdIEKrrx/su2bTu8YVLHcFcb27DE662G
         jbxjMfoPJBe79SUkG0NzOaTgibUPI8q0Pq/R7fBV9ki0t5tUrO2czGrdfxv1X8J3n7Iq
         X2an1NzrQi7Dve/VBQ6GNQTccNyIRW/PJOnRGVmllj419AlZyR5JJutQUmeSVywx8tsW
         pm/I40AX7PexAJsHyOHIWd8StZ2kWl0YP6LQOBXZ2ppiihjFesyvGacYyXURVS8tQwqT
         zpcEZI/O6MCZkQPKFciWIqaD0eDu38pC5BFe0ED7LUc1HaLvHFXDhiMYgxLWeAOlrYOZ
         h3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706693235; x=1707298035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8OInFyezrqdukb/GwASp6AxHMdhZSdbYSe2C0Yjdp4=;
        b=gNHhrAWbWKJ9WzI2KbgtyFIiL7fGwbdJe2AbO3Qj++sLitIGnqhTmdNoz6EboKL1i+
         Pey3SpZInvbegru09YjVO8YhaWJqxV+QBT6sk6BEZUFk8IsQQAttgm1//OnvXCKgMeQ4
         X1dwExuOBjd8hwcvZixs5db44V2JmgPTORTDEOAFQr2li/fqgStcP8F1OhVpL0eiIplh
         HohKosipDIms0oU1HS1pAPbQJzA+jkC+sPDiGcCzm/efXMrPvWgzPMysO+naz6w9jsH5
         JjsviMuhuqGgIfYoGX9E8HkXnTYvONb/pyVHi38LWE06Z3Fyxf3dt5gqLihOHqwjT1Nd
         3gAw==
X-Gm-Message-State: AOJu0Yxx0aj6UbZJoV6onHCQs//LQXfbmlGAVZZn7REd+Nl+0zppl69d
	EheLo4oEWKRelZPQKG0e0eiqpOYNyj9/lb0zoEWJXbmm//qWjarkFQfigUHSaEM=
X-Google-Smtp-Source: AGHT+IFEk3sXmo/8nD37OajxhjHLoj3FvLxRBfdiUIX11PVK7l6akHuoOCda1RllApfdmRYPKnPpQA==
X-Received: by 2002:a05:600c:3b96:b0:40e:b17d:2f56 with SMTP id n22-20020a05600c3b9600b0040eb17d2f56mr726511wms.23.1706693235314;
        Wed, 31 Jan 2024 01:27:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU3tVoRf/Ilhag6NTF8xmvYPAjW7Ho+rPuOSGXzo2RiQEFRuGtN0xOmS+da8+LcJrxmdn5MKjeVtUW+ZnS+VLMbG3ZfPhW3u3Vu5L0BY0XM0aFTV7d0ySdY8fJ9TLTBlUpUmpPBCHhZOGL2Fc9eJuHE0ZolsRPLsT7e3HYJRzsgTBbUhpo1wUoKHLSgOqabOybMBJ6UVHYoquBpUlz0XBX3p4u0ZTPhgHGY9+1jO+DyTvn6KXFbv+W6yLabqTmTXTu9VoUcA2+6492GlezZpHV3yPQNwYqR1GvQWH5eL0bE75HEA6k5WtrE+bSB9R2XkIq2
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id bh23-20020a05600c3d1700b0040d5a9d6b68sm1018522wmb.6.2024.01.31.01.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 01:27:14 -0800 (PST)
Date: Wed, 31 Jan 2024 10:27:12 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: roopa@nvidia.com, razor@blackwall.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: bridge: Use KMEM_CACHE instead of
 kmem_cache_create
Message-ID: <ZboScAVsNwqwiLIg@nanopsycho>
References: <20240130092536.73623-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130092536.73623-1-chentao@kylinos.cn>

Tue, Jan 30, 2024 at 10:25:36AM CET, chentao@kylinos.cn wrote:
>commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
>introduces a new macro.
>Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
>to simplify the creation of SLAB caches.
>
>Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

