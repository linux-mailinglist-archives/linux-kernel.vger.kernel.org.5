Return-Path: <linux-kernel+bounces-46999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD86B8447BA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E4528505B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3E1374CF;
	Wed, 31 Jan 2024 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wg35BRhC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE3838DD1;
	Wed, 31 Jan 2024 19:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706727794; cv=none; b=cXTGD8bwQarfpJ48J6Am0VBWKn5rXp3aWzPJhFMhQfwdXzLP15WWIBulRAeFtbKfZNoEg13Su2U+Z9DivL8m38MrtOzTdMcb34GkAP6fQCb0s8mlYhHD3yI0Jotz6Pjzn0jQHy0+YgX0NimMQewY/yDLW4boSPfMUn5peQyl6HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706727794; c=relaxed/simple;
	bh=WKMU0Z5OzqnsIcqS/IBWHJPpY6kqQUrZAznF1ycmrqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2GuzWx6RAeGXFqs13duMkiDAEhziwuBPUxBkjXgzTPVI16cWgDMT8Rot80cUCRTPtN8n6PzhML9SaXzXpoDLCfIOkns94KYbT3QkVbVA5r76uRQmq+X+969WEigH9kv3pXIzWjFwddTDO9Y6TahXJYKPpEqQ0orG0Bm+SL5hsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wg35BRhC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AECCC433F1;
	Wed, 31 Jan 2024 19:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706727793;
	bh=WKMU0Z5OzqnsIcqS/IBWHJPpY6kqQUrZAznF1ycmrqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wg35BRhCQKJAef7IJr58v5VouJ5fEQSpFeg4mDoveVwkeWvNalXAMTQiK+2cSv6IO
	 Qz3OuwZp/aqjiNlk+b4ALWGUbqHmCo5Ui9k2k0vmF1iWwg54UFpjH6a1HZfBMaFxMb
	 Tu/1VGO4laZZQlC/FyWPg/P+DMUbxNsT2hy5AZk5YNXW7Zipi9RedPaFaM8DigJtm/
	 PxWDS+ogkmuodtD/AuaSXRvC3fOr5rmhgmtMa5suI/rG/4ZKYNJtSyMcQAYw4eyhNQ
	 WtcDYHVD5Wdgj1bRHXeOPzTc8GEDnBtj80oLCt+d1+vsr6HM5qb4eF2OlyG34OatLl
	 ohBcSWM1EMDjw==
Date: Wed, 31 Jan 2024 13:03:11 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Andy Gross <andy.gross@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Avri Altman <avri.altman@wdc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-scsi@vger.kernel.org, Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: ufs: qcom: Make reset properties as
 required
Message-ID: <170672779030.2119109.999859641415132765.robh@kernel.org>
References: <20240129-ufs-core-reset-fix-v1-0-7ac628aa735f@linaro.org>
 <20240129-ufs-core-reset-fix-v1-1-7ac628aa735f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129-ufs-core-reset-fix-v1-1-7ac628aa735f@linaro.org>


On Mon, 29 Jan 2024 13:22:04 +0530, Manivannan Sadhasivam wrote:
> Apart from the legacy UFS controllers that were not supported in upstream,
> rest of the controllers do require reset property to reset the UFS host
> controller. So mark them as required.
> 
> Even though this is an ABI break, the bindings should reflect the
> capabilities of the hardware.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


