Return-Path: <linux-kernel+bounces-7703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA7B81ABC1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F04FBB2566B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAC764C;
	Thu, 21 Dec 2023 00:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ow8eCw1R"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35DF646
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 00:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dbd73ac40ecso228253276.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 16:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703118499; x=1703723299; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5sMbFiggIUmpWXZnrREwNxuVRfp3qHTdWSSj+2QBgxQ=;
        b=Ow8eCw1R88bJd64R3tLV0RS4CGnNFiqum9RVlbpD748bZR7iKrm+oYkEmE77cOlJjC
         3KRRnvtZT0TfhXpv9WLltiNDFq6p0WdembXMQJGkupl3wErFPLFBxqBRn1F8cQ44FzCN
         8sOjOQfulMpaoirnzL3gLThWUa7GcWxTMZU96yFBkeLk97yrEeFilEeJ4IdVe26wzCnj
         mmtusxZUcaYVwgGsdE9TwRaz1MP3ju2DOA22obDfoTGPbBqOKjkr2Zj4kyur8WoCIsbP
         gQ/i2QRM2vRNqt3eeRSiMIkv06bNzV2FFi5D5PSPewpeG3KKpJAsM6h0dfwDlZpgpIF1
         2mLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703118499; x=1703723299;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5sMbFiggIUmpWXZnrREwNxuVRfp3qHTdWSSj+2QBgxQ=;
        b=in4s3xg68ESx0Xwd2+Zp1baPt2r4UYdfFhyjAZTlW+qEom3H4b4mwiSOVU8iJlzT61
         KADdAPRlRX+FiOmmulu6L/tE1AwovQLn5TdWHdWeJF6dWy+1IsbmyPYqHFAbbqCkbJZe
         xEAaBa6LiVoB4fNjxfP0FpHU2AjNbGeFTYy/IwusKBSIlVzgnOH8sPayOpdl/5Ga0myy
         2ghq+ogO+TXIYklMC5Vo634OvzNaprCqRQgPrNVcrpREMZhkSVaSDLFjMpAh+yNyZCjm
         iKA4nCmzfj1gWu1KkphkZa9H/NXhhh+bCDtIqOKtrcKveRoHKz46fqL+tTrltA2LwmC7
         uxmA==
X-Gm-Message-State: AOJu0Yy0bj+FY6CH8m6cYPCfUmMXd9AUhpQdKAXhnDzzOnsEeyFaOu4p
	zXSbsVIwKAjocXiSGFxphdvq9whtBr6M/dkNwtu6KA==
X-Google-Smtp-Source: AGHT+IEXA5o0utbapRU0+vSEAQxdKOvIWZZnqGp+XkTJgxSCokGvW5Qw4aB0oXschndT2a3KehjpQUnEbq8jzosLp4w=
X-Received: by 2002:a25:2d11:0:b0:dbc:e3cf:5763 with SMTP id
 t17-20020a252d11000000b00dbce3cf5763mr552348ybt.57.1703118499654; Wed, 20 Dec
 2023 16:28:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220133808.5654-1-quic_bibekkum@quicinc.com> <20231220133808.5654-3-quic_bibekkum@quicinc.com>
In-Reply-To: <20231220133808.5654-3-quic_bibekkum@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 21 Dec 2023 02:28:08 +0200
Message-ID: <CAA8EJpoh_jsA6UrH1aEaJ4cufBTKENvG1zqjciy7WSTEh9nmnQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] iommu/arm-smmu: refactor qcom_smmu structure to
 include single pointer
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	konrad.dybcio@linaro.org, jsnitsel@redhat.com, quic_bjorande@quicinc.com, 
	mani@kernel.org, quic_eberman@quicinc.com, robdclark@chromium.org, 
	u.kleine-koenig@pengutronix.de, robh@kernel.org, vladimir.oltean@nxp.com, 
	quic_pkondeti@quicinc.com, quic_molvera@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	qipl.kernel.upstream@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Dec 2023 at 15:38, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
> qcom_smmu_match_data is static and constant so refactor qcom_smmu
> to store single pointer to qcom_smmu_match_data instead of
> replicating multiple child members of the same and handle the further
> dereferences in the places that want them.
>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c | 2 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c       | 2 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h       | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

