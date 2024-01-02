Return-Path: <linux-kernel+bounces-14612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B587821FA3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8911C216F8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B7F14F9A;
	Tue,  2 Jan 2024 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7Yj3Lp5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1791914F83;
	Tue,  2 Jan 2024 16:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013BBC433C8;
	Tue,  2 Jan 2024 16:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704213785;
	bh=g7wHRyWwJkr3NEQCvhHzxxKyjX6X4R5nqKlvMKpRH3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o7Yj3Lp5wAW/2RccH39yN4dCX0GZmNG5YUfYaKtA2TfR3aiOY81ofEqB9U2UCx1nj
	 YHW3sYOgXfIeW7UU/4Gi1HrUmQbPj+5KMHJq5vhv/2xwu4iJt3IYbOu3H/2dcFV0qE
	 IwNshNqG3P9JySMI77GlgHqDVEgTHHuzyQAmf2a8Vb7UbQPUMBnnuGO/taa4xOhG+a
	 JbXPK96gN3SsyMEvL12zTCu6G0IgqdzDDsIPxxnGMwLWF677tK8Ze3/tI8r0oymL6m
	 KGCyK+5pJxrguhE/9Z42pOc/6iXjreOBxZSDkfjINEzCEIe/srxrHZK2ZY52SknkHP
	 5majKLuPIh6pA==
Received: (nullmailer pid 2980110 invoked by uid 1000);
	Tue, 02 Jan 2024 16:39:21 -0000
Date: Tue, 2 Jan 2024 09:39:21 -0700
From: Rob Herring <robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Aakarsh Jain <aakarsh.jain@samsung.com>, linux-media@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2] media: dt-bindings: samsung,s5p-mfc: Fix iommu
 properties schemas
Message-ID: <170421310662.2970284.2901924887435555463.robh@kernel.org>
References: <20231214195553.862920-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214195553.862920-1-robh@kernel.org>


On Thu, 14 Dec 2023 13:55:52 -0600, Rob Herring wrote:
> The iommus and iommu-names property schemas have several issues. First,
> 'iommus-names' in the if/then schemas is the wrong name. As all the names
> are the same, they can be defined at the top level instead. Then the
> if/then schemas just need to define how many entries. The iommus if/then
> schemas are also redundant. Best I can tell, the desire was to require 2
> entries for "samsung,exynos5433-mfc", "samsung,mfc-v5", "samsung,mfc-v6",
> and "samsung,mfc-v8".
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  - Fix some more cases of iommus-names
> ---
>  .../bindings/media/samsung,s5p-mfc.yaml       | 33 ++++++++-----------
>  1 file changed, 13 insertions(+), 20 deletions(-)
> 

Applied, thanks!


