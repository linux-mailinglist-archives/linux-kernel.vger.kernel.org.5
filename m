Return-Path: <linux-kernel+bounces-1466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 254A3814F33
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553FC1C246E8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A5630123;
	Fri, 15 Dec 2023 17:48:32 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACD83010D;
	Fri, 15 Dec 2023 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3b9fd7b14cdso870180b6e.0;
        Fri, 15 Dec 2023 09:48:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702662508; x=1703267308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pm/gpkQ1YGAavxKNC+pdEshVFcIOLkmf7mOBxigLrOk=;
        b=VE0EaXjJQcv3ljGrrbgRSf6DgfZ2au302M/hK8e4ay5858MQSy2hhFFgH9rLvNNGo3
         DYJtJdg6z3O7c66I9j9GOqK8bpRLGgcNZlhr92BjdWNAyCORFW0q+xSfTPYeqx4dVRgy
         7sJTeOJm2s8bb/u6DEC/AFRaLKdzxhICFdUMKnq8jqjuLv0D+9dhvAcjCQ60HWFMTdSg
         mOXv9nVN/xTFXypPPY6na/e9cqHM5OE2xNRY7yfFB/gLVQCqttGqXRJNUqw6ArFB4D6O
         vc3lesjK3y7yJN1dkKVPR7iCQMmc/aT6DLyTkJJWrkWhdCxOEp5ubC6YtZVbbdbYvtCV
         YXmw==
X-Gm-Message-State: AOJu0YyGWub41m4KvBbRDPPlzO5qsIhre0rYt3xNDLKK7SgkQycAvxt4
	jdSrjy56xvGD8yLFH2C4CA==
X-Google-Smtp-Source: AGHT+IEZLXJyqXyPRgWYWbfmviLO9Q74kt/U8wStSaiATFLHpZQMquwLAHUQQTfppTSVgC00iNsCNw==
X-Received: by 2002:a05:6808:140f:b0:3b9:d6ca:2ff4 with SMTP id w15-20020a056808140f00b003b9d6ca2ff4mr6592541oiv.3.1702662508215;
        Fri, 15 Dec 2023 09:48:28 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ct7-20020a056808360700b003b9fd2af1f1sm3215689oib.32.2023.12.15.09.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 09:48:27 -0800 (PST)
Received: (nullmailer pid 57648 invoked by uid 1000);
	Fri, 15 Dec 2023 17:48:26 -0000
Date: Fri, 15 Dec 2023 11:48:26 -0600
From: Rob Herring <robh@kernel.org>
To: Elad Nachman <enachman@marvell.com>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, gregory.clement@bootlin.com, chris.packham@alliedtelesis.co.nz, andrew@lunn.ch, fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com, al.stone@linaro.org, timur@codeaurora.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, cyuval@marvell.com
Subject: Re: [PATCH 0/3] watchdog: sbsa_gwdt: add support for Marvell ac5
Message-ID: <20231215174826.GA52386-robh@kernel.org>
References: <20231214150414.1849058-1-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214150414.1849058-1-enachman@marvell.com>

On Thu, Dec 14, 2023 at 05:04:11PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Add support for Marvell ac5/x variant of the ARM
> sbsa global watchdog. This watchdog deviates from
> the standard driver by the following items:
> 
> 1. Registers reside in secure register section.
>    hence access is only possible via SMC calls to ATF.

Oops.

> 2. There are couple more registers which reside in
>    other register areas, which needs to be configured
>    in order for the watchdog to properly generate
>    reset through the SOC.

Your firmware should configure these.

> 
>    The new Marvell compatibility string differentiates between
>    the original sbsa mode of operation and the Marvell mode of
>    operation.
> 
> 
> Elad Nachman (3):
>   dt-bindings: watchdog: add Marvell AC5 watchdog
>   arm64: dts: ac5: add watchdog nodes
>   watchdog: sbsa_gwdt: add support for Marvell ac5
> 
>  .../bindings/watchdog/arm,sbsa-gwdt.yaml      |  52 +++-
>  arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi |  14 +
>  arch/arm64/boot/dts/marvell/ac5-98dx35xx.dtsi |   8 +
>  drivers/watchdog/sbsa_gwdt.c                  | 247 ++++++++++++++++--
>  4 files changed, 298 insertions(+), 23 deletions(-)
> 
> -- 
> 2.25.1
> 

