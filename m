Return-Path: <linux-kernel+bounces-54843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D3F84B45B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 643131F21996
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F2412E1DD;
	Tue,  6 Feb 2024 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GtTxLIMz"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D632A12EBED
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 11:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707220789; cv=none; b=nUr+fgydio3A+yLK7qepi5SRqbK3ATqlgmfSwcQ6Fewofz6SZn34hrjM7TgdJwunP0VJqU/IOsRET2NjsjDq6esdKP+J9x3t5ZvGEVRoFeHdPEUH5Ytar+6yU62/D/uNCHo588jde157rqJcp8Rir8InQCIearsdmfr+orQ+ncw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707220789; c=relaxed/simple;
	bh=EtsT4PQhPQG5JWztb0+mi4R2d7ka72NiRj+QIgwDG5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fao5B3m1di7B80KUD4Q42Jyq6bXf1QmglIb3+iy/57GbyBL68e4cvuPUoM5Jw9S6SQ8+TmU9pkhxhhDrZCdFNiD7pQ6Hs15I96oEGTsdbvRhWI4xUTNF8fZlza1MkuXQBu64ys5PZfguzEvCu8tExZlBIvRXLHVXNcciYbGP+ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GtTxLIMz; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-60412f65124so50730687b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 03:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707220787; x=1707825587; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CNhycZjEYpR/VohePuZrM34Prmw23zgM6uVQKrTP5kw=;
        b=GtTxLIMzLdlaDjq/Bw5H46F0QD6Zysg6LeAx7+TINdOecjHhufuiBCKu3WYEAEL1tS
         nbkE8nZT83JydFmCmwha0ZT3mKKDxDs2fYVBjlaHbbomFJc/QPbZjoKMd5Zra4gl72+K
         +sTlNTtcj9sHUnkMFgwXqw+zaPRrx6/nSWpp54I5LwKF3pbvnAIXEeWfdIusrOX/777U
         8WnOa1J0b3dZO4NhnqUbdaIwRPNEHsVpM6CEtfXrlI9zizyxVOxIriBnS4irdjrIpPc2
         bpgaqOy+ZSO7+KY2pHW0112AITamvma9DRzckOjtpq1Ig3BxB/ywNJWx/1AkeXNu1HDH
         qEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707220787; x=1707825587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNhycZjEYpR/VohePuZrM34Prmw23zgM6uVQKrTP5kw=;
        b=M4h5A93y39GDzAADECnXud4rrMEFqH58uJ9ECl9j7WQfMWsQDgS8SCd3NG+hVBECJ3
         3eeKj5mcRJDC8GhVFK20aK6+FzOW7p5AaLP+lQvz6XXyK8d65S2gtUz+fWZ6Dq9R+h0o
         Bm2FJqESMtxqDlfkJ/iPmQwif5Z4QKvCvoSLnqKiD85XWiZ5IC+30b6X2JOdjInGOtOZ
         9kJTJSdI+QnPqNjx5U7g72ue/xGUw3zxuXi3rhain2DxHi/SNAJ0skRAZFVngsJXtWR6
         9m9OJNm69yl0o7CZwL2WZBEFoF/x2MdLtNzSp5psvECxEA22YqMrJdrjjIP6X78KQH7P
         vSIg==
X-Gm-Message-State: AOJu0YzureOdDj8d+8NBRMm3uBqGdObjpoFj5ELluHn5/CHqliAM4uE1
	N8kpgrk/383qJEOq9xhhuA/I6dHKHsIgt+C/vxlHgokzHKYfsca8IsUgPmIEx1qG/97vfOU7Mnz
	6GiEZiUD9GbUlwwBX9dZ4Qt3l5IIrVFL0BmdxIQ==
X-Google-Smtp-Source: AGHT+IGp4zSfVN0bhdWn/BNXPVm1N0DQtGd+SBJSrjS/zOeOsHkJO47hbNHRq2jlyZogmxAAIrtYFkDNTHHiPQLWpKw=
X-Received: by 2002:a81:b3c7:0:b0:603:bc00:b469 with SMTP id
 r190-20020a81b3c7000000b00603bc00b469mr1635531ywh.11.1707220786825; Tue, 06
 Feb 2024 03:59:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127232436.2632187-1-quic_gaurkash@quicinc.com> <20240127232436.2632187-4-quic_gaurkash@quicinc.com>
In-Reply-To: <20240127232436.2632187-4-quic_gaurkash@quicinc.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 6 Feb 2024 12:59:36 +0100
Message-ID: <CACMJSetM_JQ+1bTEszc4EtaUwb2iKkbg3WFWVTsXa14KD_VKCA@mail.gmail.com>
Subject: Re: [PATCH v4 03/15] qcom_scm: scm call for create, prepare and
 import keys
To: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, 
	andersson@kernel.org, ebiggers@google.com, neil.armstrong@linaro.org, 
	srinivas.kandagatla@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, kernel@quicinc.com, linux-crypto@vger.kernel.org, 
	devicetree@vger.kernel.org, quic_omprsing@quicinc.com, 
	quic_nguyenb@quicinc.com, konrad.dybcio@linaro.org, ulf.hansson@linaro.org, 
	jejb@linux.ibm.com, martin.petersen@oracle.com, mani@kernel.org, 
	davem@davemloft.net, herbert@gondor.apana.org.au
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jan 2024 at 00:26, Gaurav Kashyap <quic_gaurkash@quicinc.com> wrote:
>
> Storage encryption has two IOCTLs for creating, importing
> and preparing keys for encryption. For wrapped keys, these
> IOCTLs need to interface with Qualcomm's Trustzone, which
> require these SCM calls.
>
> generate_key: This is used to generate and return a longterm
>               wrapped key. Trustzone achieves this by generating
>               a key and then wrapping it using hwkm, returning
>               a wrapped keyblob.
> import_key:   The functionality is similar to generate, but here,
>               a raw key is imported into hwkm and a longterm wrapped
>               keyblob is returned.
> prepare_key:  The longterm wrapped key from import or generate
>               is made further secure by rewrapping it with a per-boot
>               ephemeral wrapped key before installing it to the linux
>               kernel for programming to ICE.
>
> Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/firmware/qcom/qcom_scm.c       | 182 +++++++++++++++++++++++++
>  drivers/firmware/qcom/qcom_scm.h       |   3 +
>  include/linux/firmware/qcom/qcom_scm.h |   5 +
>  3 files changed, 190 insertions(+)
>
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 4882f8a36453..20dbab765c8e 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1285,6 +1285,188 @@ int qcom_scm_derive_sw_secret(const u8 *wkey, size_t wkey_size,
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_derive_sw_secret);
>
> +/**
> + * qcom_scm_generate_ice_key() - Generate a wrapped key for encryption.
> + * @lt_key: the wrapped key returned after key generation
> + * @lt_key_size: size of the wrapped key to be returned.
> + *
> + * Qualcomm wrapped keys need to be generated in a trusted environment.
> + * A generate key IOCTL call is used to achieve this. These are longterm
> + * in nature as they need to be generated and wrapped only once per
> + * requirement.
> + *
> + * Adds support for the create key IOCTL to interface
> + * with the secure environment to generate and return a wrapped key..
> + *
> + * Return: longterm key size on success; -errno on failure.
> + */
> +int qcom_scm_generate_ice_key(u8 *lt_key, size_t lt_key_size)
> +{
> +       struct qcom_scm_desc desc = {
> +               .svc = QCOM_SCM_SVC_ES,
> +               .cmd =  QCOM_SCM_ES_GENERATE_ICE_KEY,
> +               .arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_RW, QCOM_SCM_VAL),
> +               .args[1] = lt_key_size,
> +               .owner = ARM_SMCCC_OWNER_SIP,
> +       };
> +
> +       void *lt_key_buf;
> +       int ret;
> +
> +       lt_key_buf = qcom_tzmem_alloc(__scm->mempool, lt_key_size, GFP_KERNEL);

Please use __free(qcom_tzmem) everywhere in this series. You can take
a look at the calls I converted in the series adding this allocator.
It's really useful - especially if the buffer is surely freed within
the same scope.

Bart

[snip]

