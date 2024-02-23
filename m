Return-Path: <linux-kernel+bounces-77561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D79860786
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC48283323
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39AA633;
	Fri, 23 Feb 2024 00:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLNIvJ+E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001877F;
	Fri, 23 Feb 2024 00:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708647489; cv=none; b=rEQVBEIuJjR7IWul37hNx0VruPIjc2GlocU4uZyocl3ssoqMDkQgIJccBoi94a1YVEV61+ngzTPpFp5KG/nFZh+vpmAUXm3Ie33J4lK0iXjFwwlnunr2MjusF/dX+EgEUTqiWgmeYQpB93VLAFa95zeyAZf1IWRKXn4dzm2+f8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708647489; c=relaxed/simple;
	bh=Ks6S87lN3ZaIzK+Hds8ANCpr7U/DpNOOdaVwkmZI6Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIBnnxeYoDvwR6jIVOLrs68yddeiZOBlMbDAB3yvsTSMIC+hJBgKUxHF/YFdbQyPAG5CsSQP7ooNSAxf2WSSl30B5F3RRSx/ENE0SgBH0t0u9272JclZeXVHXoUxOcizvPPEowqhQAWn+5nIhLUbHtwYuiTO3HdApkvc6JMdk2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLNIvJ+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2754DC433C7;
	Fri, 23 Feb 2024 00:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708647488;
	bh=Ks6S87lN3ZaIzK+Hds8ANCpr7U/DpNOOdaVwkmZI6Is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qLNIvJ+E3dTX3iuAgItNjbCkp/RlALOa0ROQFpMb2mySw+F+vXcrl+GqZcoYe8Jib
	 gMzDizVlF4stykMFl/GJjt+v5K5hkRca5+MKROKK3GAJP6DSrR+TR/Atxp+z8y+M2u
	 R1EEgVDiZiX5+Sl1HnWn8N4Pzp30ZOAeu65XvMtNiHaRh/n6enLuXe4K9SBKstMoqp
	 Gx9YsC6pd+TsVWamvTJFirYYEmpZEFtPh5BUpMpNb0agtZ0RWNvcPFsjLwmLQTkZ7s
	 A8njZGI+kEzXhcVEUsaZZPBBOjdrSeh/W1Gt/excoFfK6XgHT/BSR6OHPvZMZSGDTY
	 uAmUcg3vKwzjw==
Date: Thu, 22 Feb 2024 17:17:59 -0700
From: Rob Herring <robh@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: robh+dt@kernel.org, richardcochran@gmail.com, linux-clk@vger.kernel.org,
	guoren@kernel.org, aou@eecs.berkeley.edu, palmer@dabbelt.com,
	chao.wei@sophgo.com, jszhang@kernel.org, haijiao.liu@sophgo.com,
	linux-riscv@lists.infradead.org, samuel.holland@sifive.com,
	paul.walmsley@sifive.com, devicetree@vger.kernel.org,
	Chen Wang <unicorn_wang@outlook.com>,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org,
	xiaoguang.xing@sophgo.com, inochiama@outlook.com, conor@kernel.org
Subject: Re: [PATCH v11 2/5] dt-bindings: clock: sophgo: add RP gate clocks
 for SG2042
Message-ID: <170864747893.3863853.16417888208319440708.robh@kernel.org>
References: <cover.1708397315.git.unicorn_wang@outlook.com>
 <49faf8ff209673e27338d4b83948ade86b3c66e4.1708397315.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49faf8ff209673e27338d4b83948ade86b3c66e4.1708397315.git.unicorn_wang@outlook.com>


On Tue, 20 Feb 2024 11:08:59 +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add bindings for the gate clocks of RP subsystem for Sophgo SG2042.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  .../bindings/clock/sophgo,sg2042-rpgate.yaml  | 43 ++++++++++++++
>  .../dt-bindings/clock/sophgo,sg2042-rpgate.h  | 58 +++++++++++++++++++
>  2 files changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
>  create mode 100644 include/dt-bindings/clock/sophgo,sg2042-rpgate.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>


