Return-Path: <linux-kernel+bounces-109625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EA1881B8C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC86283B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348E379E1;
	Thu, 21 Mar 2024 03:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdEMFpPo"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CA828E7;
	Thu, 21 Mar 2024 03:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710991866; cv=none; b=szIbJajE+phXnnaFgYWnsWN5m7vh6kNSWlIqN7Bq9CihCWVPjDmm1adTrbeBRxizg7PXnD/q7/StwHmSE5BSUZHofNepfHPyO55469kvL483mKNdCf+PQP1vkrgMLWJRbTF1ScZV/jET6J+1yK1Z5jVnVso8ugimID6UDS+ScGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710991866; c=relaxed/simple;
	bh=K7ACct98TIwxrqMdk+AxZSWhzr/d3sKhj06HGb1TgHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AC+bCQptjklwOE/4URbifeo0xQiPe5y2Kkf8LBE2V3P79M+R4Ng7J0ghKarYeKSrIjZrErkUJsytMG6kFzeIpptoK6a44dC1y+aIwAcHbZIleEgGoLuWvmVnhNGnzH2ndQ4iTpEQ73GNpWWjJIY5aJT4nNt8TZSBrCgzq1Ko+/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdEMFpPo; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3684bee9ddfso2693765ab.1;
        Wed, 20 Mar 2024 20:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710991861; x=1711596661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkcCPZV2rPe2mAIICfSKEdznaBH5x94qD30ycxtS6yw=;
        b=gdEMFpPoio8IpFnNTJuAKRgQlSsv00mDpXI+YctvbkxCgVdY4s+wKI2UErg7sta+rA
         toocQPgtW6jqbLOTF0lX2DbX9jLvJNgZyLwmbEw2a93p05F26k0erMwqcTmI51RYR7yM
         +UdMrwAB4S2lCFdZstSjMY9BWQqLxVLGTP7UQOZJiguG7Ou7YfeEtgJsz4WvJj4Pt/Xh
         ABqWDFtxFgy0X9Ydy028N/raUGFwQtE9bcJJD8rDV8p2g6/DYw/+MdAXHRcYx0xAEm2e
         DdqIjFE4duFS5BBVM0iQiHWlAVZUZB8MAdhpCohwu19In/7yj3WVF5LFPG1zpSTf/IEp
         8Slw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710991861; x=1711596661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkcCPZV2rPe2mAIICfSKEdznaBH5x94qD30ycxtS6yw=;
        b=HHtoN/XBbKyO46G9MAal9KtxH6goVeX63biggcZz08DshYKxnWCf82lnPD0dSpdmQN
         2Ft49xBnoxR8wSyBK3i4zkNZ1/72fEEpW8kWeKPCYYiQ435vKvdXknLw6u6r/MOny/2N
         AzjLFYQZzKXQkg4KWRtkonTccC7dvrQUUvMqoweDi5efZw0Yx1NevdzO6ycCnUBSoZkO
         TT8pJPfLIaYad2cyvbDqd5rRNS5hihgDz653YptU+4RUdv/a0suaecoFTeg4281t9rUY
         pgQ2ytGaaB3b8pwEENBpNO+EYYPA5of8qH2jOyNltVxVuyZMU1Ow28BI5bYD8fTESUCT
         rtwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuYssO4djbUtUqDfDYY/AFcS3nPd+/P3MGb/euBvRn0yc+5NvM92ekoSa6V0MHPyWIUwVpYaiQqo244CMaT149Vr+6ixVaKUFOd88/6gSbprh0gxXZYJWm3O444oeIM9TZNa/oz+5iIWw=
X-Gm-Message-State: AOJu0Yz1RO4qGs2ayJPaUY3sdG+fCISUgu7cFhH/L2iNwkGbaxR34pDZ
	baIDRWN6CDS4Ein3BRgU5dVIle/sy6Ywo9LT70iKDNSwRs7yGhaeMCHDiMJ7eP2gBdoHA1BXXoC
	FpVREV6PY4PndLT6pLnhJUQrV7jw=
X-Google-Smtp-Source: AGHT+IFIZlapfD6kquVxMjP6vNIkczhJV1lbowblT0uRu6rB6UIdztD13JlWALUuzaKkGcAhpgwoNBsxh+aHMUBnGiE=
X-Received: by 2002:a92:c90f:0:b0:366:9220:821f with SMTP id
 t15-20020a92c90f000000b003669220821fmr7596072ilp.7.1710991861315; Wed, 20 Mar
 2024 20:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314141642.2943605-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20240314141642.2943605-1-alexander.stein@ew.tq-group.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 21 Mar 2024 11:30:50 +0800
Message-ID: <CAA+D8APwNH2wf4p9DzZCy3b6xC8K-FPpMGw2V4kRMsX7U3=3Jg@mail.gmail.com>
Subject: Re: [PATCH 1/1] ASoC: fsl: fsl_ssi: Add dev_err_probe if PCM DMA init fails
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
	Nicolin Chen <nicoleotsuka@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 10:16=E2=80=AFPM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> This happens especially if this driver is built-in, but SDMA driver
> is configured as module.
>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best Regards
Shengjiu Wang
> ---
>  sound/soc/fsl/fsl_ssi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index ab6ec1974807..4ca3a16f7ac0 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -1401,8 +1401,10 @@ static int fsl_ssi_imx_probe(struct platform_devic=
e *pdev,
>                         goto error_pcm;
>         } else {
>                 ret =3D imx_pcm_dma_init(pdev);
> -               if (ret)
> +               if (ret) {
> +                       dev_err_probe(dev, ret, "Failed to init PCM DMA\n=
");
>                         goto error_pcm;
> +               }
>         }
>
>         return 0;
> --
> 2.34.1
>

