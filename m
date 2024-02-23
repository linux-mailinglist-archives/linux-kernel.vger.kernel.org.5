Return-Path: <linux-kernel+bounces-77563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AA686078D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD02283727
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D91BA20;
	Fri, 23 Feb 2024 00:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTkJisuB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB64D7F;
	Fri, 23 Feb 2024 00:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708647530; cv=none; b=MtseD2JJoPr0FNXyPjtswkT6ojrJjXZd7941DyZUgBgMeK7I3Nxm1pT41iDevWjbkv4LEeVyIHTknH9tLxyku1rSPjSMeJxrjok3wBIl2Jhf2l9PH8i21hPt2Kc9xxilrGqHyh+2YXSpac5rE9YhFV5Cu9QLP8Ca+JZ4zo1CUbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708647530; c=relaxed/simple;
	bh=0VXV7QQc4huFHcQS4+UMq0GJKqEi8Bz47SvrUUhEKF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7EN7j/HnUmoyYuKinxlmTjr038NkuvqIodwKwPE7lMcbsgYV7iRuhVOYFIJMgLhOY9h3iJG7xFbDAUiTGGvrVvt/EpW70xUmQDb3e8yl3MLRkfMgZ05sn6ew+M3Cv1tczhG+OXQxmSBKHlLPu3qU9FDWLZ/njUOC8YIDDWr6pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTkJisuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFDCC433C7;
	Fri, 23 Feb 2024 00:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708647529;
	bh=0VXV7QQc4huFHcQS4+UMq0GJKqEi8Bz47SvrUUhEKF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MTkJisuB618warovcVt0Nks5rSatRQHBHUfLBZCF7gA+SfQIYasBo8KYYwvPwNNVR
	 2sKgGGDwnvxbiRfJB3a1iHJc4HLhUE+peNh7j4F4b5jmBhppNYEqd6/tigqpfEtU74
	 NoVJfgXeE6yp2jierWIuq8zSOkC7a/BmE9ApwkAJNrkkcLnzB55cTVXVXNZ+RrTKra
	 F/Gb75tg0+N1cbcW0dS+HxiySpMMqTwqsT6SDeE+hyViB9jynHz19wRPFr1c7uvElz
	 uUL4lnqmTTBihKgqjEsi7b2NnuD+K5TmruAIyQauv3ZseeIhTOey1GbwKk/6i4psM5
	 xcybcWrCUCGjw==
Date: Thu, 22 Feb 2024 17:18:40 -0700
From: Rob Herring <robh@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: samuel.holland@sifive.com, inochiama@outlook.com, robh+dt@kernel.org,
	linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
	guoren@kernel.org, jszhang@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	xiaoguang.xing@sophgo.com, conor@kernel.org, haijiao.liu@sophgo.com,
	devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
	mturquette@baylibre.com, sboyd@kernel.org,
	Chen Wang <unicorn_wang@outlook.com>, paul.walmsley@sifive.com,
	chao.wei@sophgo.com, palmer@dabbelt.com, richardcochran@gmail.com
Subject: Re: [PATCH v11 3/5] dt-bindings: clock: sophgo: add clkgen for SG2042
Message-ID: <170864751924.3865395.4075439052302524683.robh@kernel.org>
References: <cover.1708397315.git.unicorn_wang@outlook.com>
 <cebef63e3e704db58658b5eae3f1fc4dfd1a587e.1708397315.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cebef63e3e704db58658b5eae3f1fc4dfd1a587e.1708397315.git.unicorn_wang@outlook.com>


On Tue, 20 Feb 2024 11:09:18 +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add bindings for the clock generator of divider/mux and gates working
> for other subsystem than RP subsystem for Sophgo SG2042.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  .../bindings/clock/sophgo,sg2042-clkgen.yaml  |  49 ++++++++
>  .../dt-bindings/clock/sophgo,sg2042-clkgen.h  | 111 ++++++++++++++++++
>  2 files changed, 160 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
>  create mode 100644 include/dt-bindings/clock/sophgo,sg2042-clkgen.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>


