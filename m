Return-Path: <linux-kernel+bounces-9788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA2981CB78
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7741F22F31
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F2823750;
	Fri, 22 Dec 2023 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbXjkuss"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B997B22F04;
	Fri, 22 Dec 2023 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ccae380df2so4886101fa.1;
        Fri, 22 Dec 2023 06:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703256302; x=1703861102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yGdflJjpqTzGgrTpB9z3udClEdTa0y2wd5bxJETyASg=;
        b=CbXjkuss0JXiAm6ZeQOZ4QYG1YKHykCR9PluzsYQBvwoD72tnrKY2//UpjuuwPywfo
         K0xYO32frS6d1B1AfV+FOSBjjlvS+Z0JCn3XDmnv5uUdTN38x4Sz7NIZAhJ+pZjPejdZ
         7KDZzlqcsf736KQgCNMxolOtoVtD2N8wlNKd81UJsAjgyOftnVRMArhwJScn/8dp5Owz
         XeVVXY7OX4BG04rT+HafufhEbltl5c/jGI+hhiVVXAISZN8jlKJH8ISqrLX65kqSkFgi
         6Fxlt4rhtSgvFp075yrlghJwgO2v011/bt+Egn+HwsPvLgGMdFlmPbvi4YsPiuq5V/AY
         fjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703256302; x=1703861102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGdflJjpqTzGgrTpB9z3udClEdTa0y2wd5bxJETyASg=;
        b=LQl9LNmqOPbHoMa3YsBf9L04LN/02ZsYZrfCgVqW7ImCXKcqUQG5csj1aXArdAt6Wl
         KcyZWzTX8zsW074uvmAOp/EU6FRh9mAHsUJF9FjRPo6I4j9erq7YqcRK0TRpxmFbvl43
         igupZPCe6AbMTnpP8J4dVXpN9DoBILkEstYomdj4jn5KHtBgHo5QGF01idAmbAzihNi/
         sSagz+gGJxatvtzOpE6lf8/MQIqHJiKLggfFZ4W0XFNLvXhgSLKmZj9QRAWjnA5Q+xiQ
         T4q//tlIiy5RrJwMLyaonOX9tETOnvQyF76CVb3Rjmkk8eBlkbsLBxRRcgCdyLnDFZqk
         BEpg==
X-Gm-Message-State: AOJu0Yyg4wYksSeeNkitL9eGOvpX7378KJ8GvqjFTf6e4g0gKXw0lCRB
	mnSjM1nYVr6kKte5Uuhucck=
X-Google-Smtp-Source: AGHT+IFQ7bVzkfn7UHoPdtCntTVZBHNA/6WaE0c0joJuTXolxhHj6vDvJOSq0tamCojdPZB333Wu0g==
X-Received: by 2002:a2e:8742:0:b0:2cc:620e:873 with SMTP id q2-20020a2e8742000000b002cc620e0873mr665971ljj.15.1703256301472;
        Fri, 22 Dec 2023 06:45:01 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id d18-20020a2eb052000000b002cc6c35aa5bsm616191ljl.128.2023.12.22.06.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 06:45:01 -0800 (PST)
Date: Fri, 22 Dec 2023 17:44:58 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Leong Ching Swee <leong.ching.swee@intel.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v1 0/4] net: stmmac: Enable Per DMA Channel
 interrupt
Message-ID: <kmmjm4sf5geudch54nmehl3ibkpwvlgbhpf7y6quhqy3gnqg32@gcvwlvzec6pn>
References: <20231222054451.2683242-1-leong.ching.swee@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222054451.2683242-1-leong.ching.swee@intel.com>

Hi Leong

On Fri, Dec 22, 2023 at 01:44:47PM +0800, Leong Ching Swee wrote:
> From: Swee Leong Ching <leong.ching.swee@intel.com>
> 
> Hi,
> Add Per DMA Channel interrupt feature for DWXGMAC IP.
>  
> Patchset (link below) contains per DMA channel interrupt, But it was 
> achieved.
> https://lore.kernel.org/lkml/20230821203328.GA2197059-
> robh@kernel.org/t/#m849b529a642e1bff89c05a07efc25d6a94c8bfb4
>  
> Some of the changes in this patchset are based on reviewer comment on 
> patchset mentioned beforehand.

Thanks for resubmitting the patches. At some point in the past they
saved me some time in fixing the DW XGMAC on my platform.

-Serge(y)

> 
> Swee Leong Ching (4):
>   dt-bindings: net: snps,dwmac: per channel irq
>   net: stmmac: Make MSI interrupt routine generic
>   net: stmmac: Add support for TX/RX channel interrupt
>   net: stmmac: Use interrupt mode INTM=1 for per channel irq
> 
>  .../devicetree/bindings/net/snps,dwmac.yaml   | 24 ++++++++++----
>  .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  4 +--
>  .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |  2 +-
>  .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  3 ++
>  .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 32 +++++++++++--------
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 29 +++++++++--------
>  .../ethernet/stmicro/stmmac/stmmac_platform.c | 24 ++++++++++++++
>  include/linux/stmmac.h                        |  4 +--
>  8 files changed, 84 insertions(+), 38 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

