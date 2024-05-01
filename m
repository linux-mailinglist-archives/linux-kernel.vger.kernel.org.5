Return-Path: <linux-kernel+bounces-164871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DAB8B843E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF722830C8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 02:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C5D125B9;
	Wed,  1 May 2024 02:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDsNAgvz"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F17EEADB;
	Wed,  1 May 2024 02:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714529688; cv=none; b=IKsmzW3krW3Sp9lDKB/+3/TJ5+rt853thcZNRyzTUgEDwAaopqXjWVivjPZWRTMqAeigH+OZNfmzeqxGzezKpbATFKuld8d4OL5r5NvBwzZhZXVmxGTMZOPtu5tFNIDx+0B0hg33Nyh1eJA639VyJsMj41IiVB3QHz8F/Ejm8Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714529688; c=relaxed/simple;
	bh=4Ga4byRB5JzhOWhFbukEMd0FTYKkJjneqrc6tELT6Ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWMQLcSdB2twA6HMpBSl2yNh9uTHdaqsuVnC6ClSRE1DlKz+UmxDJKTMGPrVPQcvNK1xVeQAUW5tE8c3cYFQ1w3WsqamOmWHhwulICb9JA0S8Q3evv4VrIFedxQAwfztlbdE61zJ4QPDasrYC/WDFjZ+k3JZ/vIOp/6m4WeFfHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDsNAgvz; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4defa67bc32so760944e0c.1;
        Tue, 30 Apr 2024 19:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714529685; x=1715134485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGUCzWGwJDreMW+w/ahTCJ1HXWC5ZH4jSL81Igfy5Hg=;
        b=CDsNAgvzOZ2QA+08gKyToMGWCBAEMt94zvCAR/SF5gsjOrLH7WJSEfb8RyAu+1s8Ax
         iuL2/4eWLkeskSJ+NnAtZSaypFjyrFaEzKjpSQcHUi4Edmms01373tpoO9ID/eVuU1Jl
         6NAOQNBya4iXCeqlRzbc307EQh5udCfYEl4nsXW6Fj5thtRCchTplrBSVyMIHi5KiKD4
         YtCp1YRiATq/c+bL+CSil3t1Lmue3xlpdktC1yJxZhaFwX38bdWSnz9GqJOCNjTqAUZ6
         ez331AHCRrD1xYYr1asf1kBYxXhAxvTvK56sFu6ynCrmoYc1D4X18DEgSlHBGfmA37l3
         7o7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714529685; x=1715134485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGUCzWGwJDreMW+w/ahTCJ1HXWC5ZH4jSL81Igfy5Hg=;
        b=fUcfZpLzDDtMUfjW/evy+z3u6zwhI8kZQk9Nf40/JEhLNFaCtLrXiCHrq3Ovk+F/Xf
         HftmqXIKGMfMaL9xPfieUtMUUh9iXHliaQIyv8dj9EbP2IG3/wrzz5JPHiuTk1gCSr6S
         e453BJ0E8rXHzgnH1LtTEgULvfCddKg0JiAG3pUvm9ZIO9d75WeiTBeAE7VpWDzqnq5D
         pVU/BZeZF3QRtFByi+OzkgvxXS+2G57VCkUkbRiL3Fn26sVFCAzSe9b+3FVjYIDYBmaT
         cNCrUhgmDzhELgLMfNGT7EYIrooArHgXS2YmaVn4xX4SpNIG6Q2Ao16MygPD2MfZwjyb
         ds4A==
X-Forwarded-Encrypted: i=1; AJvYcCVVhZBCYJIPFynv4tKGbydc/c75Oq14I2ZE22i7I1YjqWwmcRiQ3pYBDqOj81BcCbQugDt7p72JS7Jz8BupfzgwTsgayLzKfGk0Al5ZSj3RnvnUfo8ijcaMxhqlDSahczy9htoe8PoxrxJw3ks/HYK63Dre3dcozQVfI0fJra38PbqGUPhrt2Q=
X-Gm-Message-State: AOJu0Yy1AlaABL7fInZJ9MmyES0LpJG/oDcgEwsA+Ci05F3NmWxf+SpJ
	oMTJ4u5piXViavDmeCkc31eTPOSKmNTnTW/VSXKIPr8FcxBEGsJCOwFC9e0Pt9KODlIvfvjwcsr
	W4t0KdgQkV4hzEP+MDtHEuI9VcmA=
X-Google-Smtp-Source: AGHT+IGPPfSTCD7g9ZFYa4QpVWKMONA41O4TTEwotbnATEOHxIa8YL1v5ol82Lg81C2j7nOjgSBg7d9LZogLXZCjTkc=
X-Received: by 2002:a05:6102:9a3:b0:47b:b9cb:c7e9 with SMTP id
 f3-20020a05610209a300b0047bb9cbc7e9mr1608127vsb.16.1714529684527; Tue, 30 Apr
 2024 19:14:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422164035.1045501-1-quic_sibis@quicinc.com> <20240422164035.1045501-3-quic_sibis@quicinc.com>
In-Reply-To: <20240422164035.1045501-3-quic_sibis@quicinc.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Tue, 30 Apr 2024 21:14:32 -0500
Message-ID: <CABb+yY2mjc0BmvdUxZvkEvFMS30g=h5F7aHEKogfH9=W0C1a2w@mail.gmail.com>
Subject: Re: [PATCH V4 2/5] mailbox: Add support for QTI CPUCP mailbox controller
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, andersson@kernel.org, 
	konrad.dybcio@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, dmitry.baryshkov@linaro.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, quic_rgottimu@quicinc.com, 
	quic_kshivnan@quicinc.com, conor+dt@kernel.org, quic_gkohli@quicinc.com, 
	quic_nkela@quicinc.com, quic_psodagud@quicinc.com, abel.vesa@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 11:41=E2=80=AFAM Sibi Sankar <quic_sibis@quicinc.co=
m> wrote:
>
> Add support for CPUSS Control Processor (CPUCP) mailbox controller,
> this driver enables communication between AP and CPUCP by acting as
> a doorbell between them.
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---

Do you want to add an entry in the MAINTAINERS ?

> diff --git a/drivers/mailbox/qcom-cpucp-mbox.c b/drivers/mailbox/qcom-cpu=
cp-mbox.c
 .....
> +static irqreturn_t qcom_cpucp_mbox_irq_fn(int irq, void *data)
> +{
> +       struct qcom_cpucp_mbox *cpucp =3D data;
> +       struct mbox_chan *chan;
> +       unsigned long flags;
> +       u64 status;
> +       u32 val;
> +       int i;
> +
The variables flags, val and chan are better inside the for loop below.

> +       status =3D readq(cpucp->rx_base + APSS_CPUCP_RX_MBOX_STAT);
> +
> +       for_each_set_bit(i, (unsigned long *)&status, APSS_CPUCP_IPC_CHAN=
_SUPPORTED) {
> +               val =3D readl(cpucp->rx_base + APSS_CPUCP_RX_MBOX_CMD(i) =
+ APSS_CPUCP_MBOX_CMD_OFF);
> +               chan =3D &cpucp->chans[i];
> +               /* Provide mutual exclusion with changes to chan->cl */
> +               spin_lock_irqsave(&chan->lock, flags);
> +               if (chan->cl)
> +                       mbox_chan_received_data(chan, &val);
> +               writeq(BIT(i), cpucp->rx_base + APSS_CPUCP_RX_MBOX_CLEAR)=
;
> +               spin_unlock_irqrestore(&chan->lock, flags);
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +

Thanks
Jassi

