Return-Path: <linux-kernel+bounces-20374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD463827DD5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C886FB22B40
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490156FD2;
	Tue,  9 Jan 2024 04:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCaOt8O0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0922907;
	Tue,  9 Jan 2024 04:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D5BC433F1;
	Tue,  9 Jan 2024 04:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704774372;
	bh=GWPRSMVrTIfaejeLXiQ3VtmTLpLVgn3fwHTcRjXc5cQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SCaOt8O0OOJypkFpR61MI0MWns1cypJUED72AdaD0wHnt7aRD9hqdB7F5SFrprpdM
	 KSnc5GxrTk6HKfSmu/RAhOVlY9SzoofJDshoHm3rdUc/nrQrFL+CCvILEzSUSvd70w
	 Nb5e0wYmUNTpjTXAlZ43rIQ2GDTTC7Sz7+uUud7y24woUmE4PWhP7rufbaOp9MRfcQ
	 gMiLDUuSTtgtORgbQXtCpUsedOndqqGiaR5QUUpkq1vn0RhafCjLHat7+rYanyUYhL
	 1engzUKjHE4H5rJR17kT/uEAHwLmZa8yhRcHloUal6ebN+UEpw7ejaGRpS6+v2C3EE
	 IjwC+Nz98Wf3A==
Received: (nullmailer pid 2647220 invoked by uid 1000);
	Tue, 09 Jan 2024 04:26:10 -0000
Date: Mon, 8 Jan 2024 21:26:10 -0700
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rafael@kernel.org>, kernel@collabora.com, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Conor Dooley <conor+dt@kernel.org>, Hector Yuan <hector.yuan@mediatek.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: cpufreq: Add big CPU supply
Message-ID: <20240109042610.GA2644078-robh@kernel.org>
References: <20231229212853.277334-1-nfraprado@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231229212853.277334-1-nfraprado@collabora.com>

On Fri, Dec 29, 2023 at 06:28:39PM -0300, Nícolas F. R. A. Prado wrote:
> The performance-controller hardware block on MediaTek SoCs is
> responsible for controlling the frequency of the CPUs. As such, it needs
> any CPU regulator to have been configured prior to initializing. Add a
> phandle in the binding so this dependency can be described.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> 
>  .../devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml        | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> index d0aecde2b89b..d75b01d04998 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> @@ -33,6 +33,8 @@ properties:
>        performance domains.
>      const: 1
>  
> +  big-cpus-supply: true
> +

A CPU's supply belongs in the respective CPU nodes.

Rob

