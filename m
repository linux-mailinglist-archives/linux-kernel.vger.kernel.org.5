Return-Path: <linux-kernel+bounces-18988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FF2826613
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 22:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FFF0281AFC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 21:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A30711C84;
	Sun,  7 Jan 2024 21:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fg+do+RN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE086125C1;
	Sun,  7 Jan 2024 21:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cd3f7e2aa1so12685521fa.3;
        Sun, 07 Jan 2024 13:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704662667; x=1705267467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XFnIRrpkSbC/64HOL4C9Wb0js1kawE+Mq2O/pxg8xmk=;
        b=fg+do+RNHgPpGIYi3ECbYkhq0RBbitQaYfPfYR2Xhn6KupiSCHDk8JiDtyWN1yWOtn
         FbSN1ALTk9D7pBnlkk86Wm7E3os6JS3G0WEm88R+GBTwwhCWDULukE27+qKzOc2Shz9S
         m+/18lho7XMgJuxQXfvw4R9+PnvkE986AupZM8+uiaQlmGa+y9pHm+hAqfeCl8qrnjyo
         faNp0BxfAQz2+ziMJM1Y6mwNYUC3/olOmhGsdpAJxZ+HwSry/epO2RbO8L1WO02VTP17
         luEqLfm8ig7fqArY/4HhPAlEUWFN52QVNjBJbTETIYJYFiGb1ObSe59/zNKg32v6dXD7
         6mQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704662667; x=1705267467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFnIRrpkSbC/64HOL4C9Wb0js1kawE+Mq2O/pxg8xmk=;
        b=YkvCGPjV9a8zjTh9Xz9zL7MjO0NlT33UFpxLeMLUocSJqvyUwVkEXT2i+x5jbVh9vm
         peMNKwg3q76hFKMUGUP0XkaAklvaaEmTQi59RX90c6QhWyYjPWJ0kHDiIYCCdfis1aI4
         qF8VdWobqjYvfDK+qQJ236DdAEfQZ/pocjfdYg/WMrqVwIque627k1Q2pye14L3epu4G
         pOsQa610pJpQqs+vUJiPuUiDKypuDiRzsLl7EtYCXheTiLn9QZ4ypRFw9tPCjyDc1KkI
         Ghk+XEt/i/0tBmpSjWXCa1tMSim9vTNUjKeB07Uy1CsIcqUr4H78az1+8xPgAgHy2FY3
         YNcA==
X-Gm-Message-State: AOJu0Yw/m6d32/avkoSiETL4cQzRoRVXGQmr0hmlEGx0nT+OqU+WUh1b
	FgAvXDf5SH4wQbHMdhhQzs8=
X-Google-Smtp-Source: AGHT+IER9MaKT2qvx1MI99o0WSTaPtwEj5cDYIJcz4ctg0ZfI0flzoX8d2s4lIT+IDI+w9kt9A4HVQ==
X-Received: by 2002:a2e:9d13:0:b0:2cd:c15:1b6e with SMTP id t19-20020a2e9d13000000b002cd0c151b6emr1038169lji.22.1704662667456;
        Sun, 07 Jan 2024 13:24:27 -0800 (PST)
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id u20-20020a05651c141400b002ccd8e66dd1sm1301962lje.138.2024.01.07.13.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 13:24:26 -0800 (PST)
Date: Mon, 8 Jan 2024 00:24:24 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Leong Ching Swee <leong.ching.swee@intel.com>, "David S. Miller" <davem@davemloft.net>
Cc: patchwork-bot+netdevbpf@kernel.org, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, peppe.cavallaro@st.com, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] net: stmmac: Enable Per DMA Channel
 interrupt
Message-ID: <px2f336zjgibl43utjnnljzjweypu5jxovhgthc4xruidvpl3q@yobulxczk7vh>
References: <20240105070925.2948871-1-leong.ching.swee@intel.com>
 <170464562363.18664.8264531122295136817.git-patchwork-notify@kernel.org>
 <2df9fe3e-7971-4aa2-89a9-0e085b3b00d7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2df9fe3e-7971-4aa2-89a9-0e085b3b00d7@linaro.org>

On Sun, Jan 07, 2024 at 08:06:55PM +0100, Krzysztof Kozlowski wrote:
> On 07/01/2024 17:40, patchwork-bot+netdevbpf@kernel.org wrote:
> > Hello:
> > 
> > This series was applied to netdev/net-next.git (main)
> > by David S. Miller <davem@davemloft.net>:
> > 
> > On Fri,  5 Jan 2024 15:09:21 +0800 you wrote:
> >> From: Swee Leong Ching <leong.ching.swee@intel.com>
> >>
> >> Hi,
> >> Add Per DMA Channel interrupt feature for DWXGMAC IP.
> >>
> >> Patchset (link below) contains per DMA channel interrupt, But it was
> >> achieved.
> >> https://lore.kernel.org/lkml/20230821203328.GA2197059-
> >> robh@kernel.org/t/#m849b529a642e1bff89c05a07efc25d6a94c8bfb4
> >>
> >> [...]
> > 
> > Here is the summary with links:
> >   - [net-next,v2,1/4] dt-bindings: net: snps,dwmac: per channel irq
> >     https://git.kernel.org/netdev/net-next/c/67d47c8ada0f
> 
> Please wait for DT bindings review a bit more than one working day (I
> don't count Saturday and Sunday, because we all have some life...).

+1. Would be very nice to have some more time to review the rest of
the bits too. This would be specifically important for the STMMAC
driver which doesn't currently have active maintainer. What about 5-10
work days to make sure that no comment would be submitted? Besides I
thought that no features were supposed to be submitted during the
merge window. Are we over the merge window already? (I might have lost
track of time on the holidays.)

Leong, next time before re-submitting your patchsets please wait for
some more time than just two days. I waited for your response for
almost two weeks.

-Serge(y)

> 
> Best regards,
> Krzysztof
> 
> 

