Return-Path: <linux-kernel+bounces-128195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3133F895766
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E051F21B13
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB42133405;
	Tue,  2 Apr 2024 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wQXjJLca"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BCE13175D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712069135; cv=none; b=hknTH+B/BsSoGmoDAu+K2pPHTIMSE+vrOWvc/vPuWZH8EOLNoJx2WVyvMo/vGqnD+VMDLKt9tb3wUKsXJIoKICBb8ty3WmaRMH+GgkThyla9GyzfQ460J+Xm3DfB40AJj6SlusVVezCIe6GKrJCwOxLRzTHa/9lgE15aoWlcmIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712069135; c=relaxed/simple;
	bh=dQyII7vmQHRtc0XgOTiHPMjkmRblHUUbSglUykBczkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UiKNOhsb3JdaHi82icqW5B8UBgOvx+jbuCk5pGBUwJaP/neqQLv7U9mkXKMoRtT1EEPFLxLuU3YgPJpJN9ch7VJmKIMTZyg2gr1nio0aR+/n/BlTudQgdP2eJdOaJw4AgUDrnVrMJdQogjkWjWzFVao0iou5Ic1F8aXwf7jP38A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wQXjJLca; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4da702e48e0so577552e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 07:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712069133; x=1712673933; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b3+dZ1fpYzh0cVc/i51+AzoQt474NVYKn1M7saZ5Kp0=;
        b=wQXjJLca0zDbzHxwNe1xofa+xPoemEFGD5kxOFB/zPsBoFzmOD4/SmpaFDEQueKDgF
         yEhlCXQUZcqHF1MG0YmziaZpi3dM4+QP7pSEGzEtd7tzJS5qc+jOSX7CPpfRYi/XvdHR
         CmfCIQqQunpVYv1dc1z1xioxmHaZUo3bunUf5bdmQkX5begFnifg/+c3R3Y95Li63BgI
         kbxm+GWgbT8dRVvKEYYSQ6Yrv0MwYb1tRD0Z3EWWSfbuIM9HSQmxP9NySQ/HYsMHzpCf
         OY5A3BYPyYgyeukj17WkGp6tapMmgIx05wkeHJxtaNE/vh6cEEzU0HS8pMEH8UF6txCC
         3vtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712069133; x=1712673933;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3+dZ1fpYzh0cVc/i51+AzoQt474NVYKn1M7saZ5Kp0=;
        b=bISq0pRe2yBskkkZsMKAWWc0t67nd2ZtfTpBO74ERCtySeKOFhoYBtZ2RN0idLfLwu
         BjTWlU3IL6cZHpppkYIBTHXDC41LJ8UMG3wjLOY5RvnnTwRUTQRUk3B1ctcU5Ldy9YQf
         /YncGBtXWVpW26Jk9KV3R/5wI14+fIeRpKNNxw5Cc+yoVMZhUMNVQ1awZUQLiO4R8Nh+
         esfu22ZzF5XzGJq9/6HE6rOA6QJllEUVgIV/qRGA+juYATl0/1ScXLNRsr6dBmelhjpb
         JfjT0miB5CITsdUp2vIKxvXmvtHrnnWPvMMDQw3sUFySxTWmv2RQw1D8xgv2Tc8mx6Rh
         avDg==
X-Forwarded-Encrypted: i=1; AJvYcCUo30pwSSqS1/dLD3fumKzjHOj0ryC4YYTLZ8x0J1c570dEgdR5YQajVden1V9iNL4vDj237Jm8/9sOa4e46YGwnoivJGe6jqd7Qng8
X-Gm-Message-State: AOJu0YzStTLZEvTztHnFCUsANFheEcbInyD/g5+3juOo23DTvofqje13
	n2VJj6zkRxGx5XJroHlERJVF4tDmn0/8GoqiJE7mid+yeFn8JoX6tZ6vUoQnrpcDANYNuep26Bs
	ihnQZK6tA6WH90yJoc0OkOfobM/lB+0X5Qv/viQ==
X-Google-Smtp-Source: AGHT+IE1jgEZcgPnB/hD8dZF0oJ3NImwHK9mE9wkjXMjSPzUxoTXJ6/YZxwewKzVuNrajM6LQ0QOegrYmBEtmBqomwI=
X-Received: by 2002:a1f:d5c4:0:b0:4d1:4e40:bd6f with SMTP id
 m187-20020a1fd5c4000000b004d14e40bd6fmr9290884vkg.10.1712069132468; Tue, 02
 Apr 2024 07:45:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401-ufs-icc-fix-v1-1-3bac41bdfa7a@linaro.org>
In-Reply-To: <20240401-ufs-icc-fix-v1-1-3bac41bdfa7a@linaro.org>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Tue, 2 Apr 2024 20:14:56 +0530
Message-ID: <CAMi1Hd2tLrP-Qm5tGSwjtYNjy6Di0PGMeW-j=scqj3jgM2RyjA@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: qcom: Add missing interconnect bandwidth
 values for Gear 5
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Apr 2024 at 20:39, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> These entries are necessary to scale the interconnect bandwidth while
> operating in Gear 5.

This fixes the UFS breakage we see on SM8550-HDK.

Tested-by: Amit Pundir <amit.pundir@linaro.org>

Regards,
Amit Pundir

>
> Cc: Amit Pundir <amit.pundir@linaro.org>
> Fixes: 03ce80a1bb86 ("scsi: ufs: qcom: Add support for scaling interconnects")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/ufs/host/ufs-qcom.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 8d68bd21ae73..696540ca835e 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -47,7 +47,7 @@ enum {
>         TSTBUS_MAX,
>  };
>
> -#define QCOM_UFS_MAX_GEAR 4
> +#define QCOM_UFS_MAX_GEAR 5
>  #define QCOM_UFS_MAX_LANE 2
>
>  enum {
> @@ -67,26 +67,32 @@ static const struct __ufs_qcom_bw_table {
>         [MODE_PWM][UFS_PWM_G2][UFS_LANE_1] = { 1844,            1000 },
>         [MODE_PWM][UFS_PWM_G3][UFS_LANE_1] = { 3688,            1000 },
>         [MODE_PWM][UFS_PWM_G4][UFS_LANE_1] = { 7376,            1000 },
> +       [MODE_PWM][UFS_PWM_G5][UFS_LANE_1] = { 14752,           1000 },
>         [MODE_PWM][UFS_PWM_G1][UFS_LANE_2] = { 1844,            1000 },
>         [MODE_PWM][UFS_PWM_G2][UFS_LANE_2] = { 3688,            1000 },
>         [MODE_PWM][UFS_PWM_G3][UFS_LANE_2] = { 7376,            1000 },
>         [MODE_PWM][UFS_PWM_G4][UFS_LANE_2] = { 14752,           1000 },
> +       [MODE_PWM][UFS_PWM_G5][UFS_LANE_2] = { 29504,           1000 },
>         [MODE_HS_RA][UFS_HS_G1][UFS_LANE_1] = { 127796,         1000 },
>         [MODE_HS_RA][UFS_HS_G2][UFS_LANE_1] = { 255591,         1000 },
>         [MODE_HS_RA][UFS_HS_G3][UFS_LANE_1] = { 1492582,        102400 },
>         [MODE_HS_RA][UFS_HS_G4][UFS_LANE_1] = { 2915200,        204800 },
> +       [MODE_HS_RA][UFS_HS_G5][UFS_LANE_1] = { 5836800,        409600 },
>         [MODE_HS_RA][UFS_HS_G1][UFS_LANE_2] = { 255591,         1000 },
>         [MODE_HS_RA][UFS_HS_G2][UFS_LANE_2] = { 511181,         1000 },
>         [MODE_HS_RA][UFS_HS_G3][UFS_LANE_2] = { 1492582,        204800 },
>         [MODE_HS_RA][UFS_HS_G4][UFS_LANE_2] = { 2915200,        409600 },
> +       [MODE_HS_RA][UFS_HS_G5][UFS_LANE_2] = { 5836800,        819200 },
>         [MODE_HS_RB][UFS_HS_G1][UFS_LANE_1] = { 149422,         1000 },
>         [MODE_HS_RB][UFS_HS_G2][UFS_LANE_1] = { 298189,         1000 },
>         [MODE_HS_RB][UFS_HS_G3][UFS_LANE_1] = { 1492582,        102400 },
>         [MODE_HS_RB][UFS_HS_G4][UFS_LANE_1] = { 2915200,        204800 },
> +       [MODE_HS_RB][UFS_HS_G5][UFS_LANE_1] = { 5836800,        409600 },
>         [MODE_HS_RB][UFS_HS_G1][UFS_LANE_2] = { 298189,         1000 },
>         [MODE_HS_RB][UFS_HS_G2][UFS_LANE_2] = { 596378,         1000 },
>         [MODE_HS_RB][UFS_HS_G3][UFS_LANE_2] = { 1492582,        204800 },
>         [MODE_HS_RB][UFS_HS_G4][UFS_LANE_2] = { 2915200,        409600 },
> +       [MODE_HS_RB][UFS_HS_G5][UFS_LANE_2] = { 5836800,        819200 },
>         [MODE_MAX][0][0]                    = { 7643136,        307200 },
>  };
>
>
> ---
> base-commit: 4cece764965020c22cff7665b18a012006359095
> change-id: 20240401-ufs-icc-fix-123c7ca1be45
>
> Best regards,
> --
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>

