Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CE680C2CF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbjLKIMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 03:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbjLKIMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:12:19 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B809100
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:12:24 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54cb4fa667bso5967288a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1702282342; x=1702887142; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2VetfWENefg3NNH186dWhmbJJvG28uTk+9EusPe8Vs=;
        b=IWzoCn5QVb3w1w2lMSzZnMBn5t9TP5Aqik7RyQP14t/Wwf+c9Bs7mVgGR9UVhKFqLt
         metGWAbyRoK0ZwDTWwypTUttdtS8dRgGc87bqYfqc3aGdvjOX2oa3Ue77XQS86kMhtg8
         aX5OSVGUANn9JaA/rWKiLVAgTDPYTWzS1TwdLAM1f0LHMLioLoqeH+1NHJNno0IYKrzT
         m8siL/3r6XHkbPwJIrJGB4oE6QgSyLFj48fVAtsNaVBehXRwbJQBw8uNJ+znoFVZLMGo
         8OKVEHs4seK2wT7egtr2R+9qcgvNaWiv4eIEUQ2r/Ub2ThsxMDQ3t2ZWr4akCNGebAuv
         DMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702282342; x=1702887142;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i2VetfWENefg3NNH186dWhmbJJvG28uTk+9EusPe8Vs=;
        b=G8cIx9Cyfayajos6/ZKO5On1nfAZFufc/iRzHqv9Mwc2CBQqr1JSOBkOq8Fdh1N2s+
         wrRaoJ2zFsES0niZaISWFfvQ+59f4rR696MguG+5//zS2LgkbPDjDyBDtRVl1XyJI8GY
         rXaDZ46NOebc5NDLE8fuKFkcGoG/E9i+q9IBcqgXmZG35jk+tnOqzc/qWhZD/nC+/vO3
         aQRIeyKX41AhHOFLOJoGyniVQyqm6ApJyiAkFlKFUvetiSqYMismFxwM+3zEcCXD+xlT
         HLNqF2bzw35htx6Ex87BCYx7enq17WConphYSkLh5oZrj+IAoPG6E0gLhi0CEZDz1quK
         UnmA==
X-Gm-Message-State: AOJu0YztBLrHiDiGh4HduUwaXfVipXupDhX9uAnVbsnnWxN1L3VjOI/b
        RqU/K/AlIU5/NulZg8m5Vj4z3Q==
X-Google-Smtp-Source: AGHT+IG4I/qnppSWLttR4KLdZdwYth/8ysJQzdDaMQv6IkPfpXivrhMdOVuG36BLT3aWZ2Qa9tUkeA==
X-Received: by 2002:a50:ab5a:0:b0:54c:4837:8b72 with SMTP id t26-20020a50ab5a000000b0054c48378b72mr2555831edc.64.1702282342593;
        Mon, 11 Dec 2023 00:12:22 -0800 (PST)
Received: from localhost (dhcp-089-099-055-216.chello.nl. [89.99.55.216])
        by smtp.gmail.com with ESMTPSA id m27-20020a50d7db000000b0054c0264a7fasm3502968edj.64.2023.12.11.00.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 00:12:22 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 11 Dec 2023 09:12:21 +0100
Message-Id: <CXLCQ7VTPXN3.3SX0FHWBB1MQK@fairphone.com>
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] media: venus: core: Set up secure memory ranges
 for SC7280
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Luca Weiss" <luca.weiss@fairphone.com>,
        "Stanimir Varbanov" <stanimir.k.varbanov@gmail.com>,
        "Vikash Garodia" <quic_vgarodia@quicinc.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>
X-Mailer: aerc 0.15.2
References: <20231201-sc7280-venus-pas-v3-0-bc132dc5fc30@fairphone.com>
 <20231201-sc7280-venus-pas-v3-1-bc132dc5fc30@fairphone.com>
In-Reply-To: <20231201-sc7280-venus-pas-v3-1-bc132dc5fc30@fairphone.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Dec 1, 2023 at 10:33 AM CET, Luca Weiss wrote:
> Not all SC7280 devices ship with ChromeOS firmware. Other devices need
> PAS for image authentication. That requires the predefined virtual
> address ranges to be passed via scm calls. Define them to enable Venus
> on non-CrOS SC7280 devices.
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/media/platform/qcom/venus/core.c | 4 ++++
>  1 file changed, 4 insertions(+)

Hi Hans,

Is there anything missing for this to be applied or could you pick this
up for v6.8?

Regards
Luca

>
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/pla=
tform/qcom/venus/core.c
> index 9cffe975581b..a712dd4f02a5 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -881,6 +881,10 @@ static const struct venus_resources sc7280_res =3D {
>  	.vmem_size =3D 0,
>  	.vmem_addr =3D 0,
>  	.dma_mask =3D 0xe0000000 - 1,
> +	.cp_start =3D 0,
> +	.cp_size =3D 0x25800000,
> +	.cp_nonpixel_start =3D 0x1000000,
> +	.cp_nonpixel_size =3D 0x24800000,
>  	.fwname =3D "qcom/vpu-2.0/venus.mbn",
>  };
> =20

