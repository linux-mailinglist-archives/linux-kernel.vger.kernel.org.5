Return-Path: <linux-kernel+bounces-1670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320A18151EC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3ABD286E80
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B642547F7E;
	Fri, 15 Dec 2023 21:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eSRi0qgc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6D03FE44
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 21:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2c9ea37ac87so14247021fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702675870; x=1703280670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oeurpi6f1dt89GCMIZpe52BTKf//uzB0betOyA87Xw=;
        b=eSRi0qgc43wGdQ5F9QFZNKscb2DgaZuxAQSLlzjVZQ3lvVQ4G+cR+g/muCC9UkkwUC
         ffU58cJlwP1iM5RvoodfM6ok8Lua4isB2W5yuhQXy0xJzZz+UucBzZKbEtWXQ00BzaoC
         feVekUjRVssM98ziQ1nZxQLJOOc0MUyb/H+pI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702675870; x=1703280670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oeurpi6f1dt89GCMIZpe52BTKf//uzB0betOyA87Xw=;
        b=fPFJ/HO2UBy6r6KUHQOoDv3JxhkUHgZgEPRKHP079PsXQ4Foru5KCNI+0OyVwOm3LU
         T60M2LnlvMpQ9k77YR2Ej0uxoduFb5SRQeUSi7zaTLZbxOj2ks/5VeY3TnhaKYaCtTgT
         FjmM1gCN2RbO3UWrD2wvAhZZnEYk2EQ12uHzgPlPi19NhcWQksTX230XWoINDVI2lu7v
         gDYbum1YjPgHWLN3d3FIbFrbQFcekgolhpOa5puCZfTzbokJToo1eOYhrsYhlIO8C1Rp
         GlLgEPkIBKbNtS85WGQb1Ggfeq5SN3vBnXpYxkS+iNfAzdvcZMa6NrGWIzK8BfGZtMJa
         zjPg==
X-Gm-Message-State: AOJu0Yw8R0dtXBf/RSzyQxmyeEWnYMAHZpTPqPo7ZOW5IW7KD6OrxiMB
	UjtwYoy8MI5rEi6Cfxbbwdwl1h6o/Zbc9sakr6UBPA==
X-Google-Smtp-Source: AGHT+IFxgZ/W9QhZJGq1gEFESSQDaQahakGZv83CTioXb6qxEBbCCqFXJDTAaIkDLGqnS8MQcFB+DA==
X-Received: by 2002:a05:651c:1186:b0:2cc:2adb:de58 with SMTP id w6-20020a05651c118600b002cc2adbde58mr2746924ljo.2.1702675870266;
        Fri, 15 Dec 2023 13:31:10 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id u16-20020a50c050000000b0054d486674d8sm8457894edd.45.2023.12.15.13.31.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 13:31:09 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40c3963f9fcso4145e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:31:09 -0800 (PST)
X-Received: by 2002:a05:600c:35c9:b0:405:320a:44f9 with SMTP id
 r9-20020a05600c35c900b00405320a44f9mr13760wmq.5.1702675869278; Fri, 15 Dec
 2023 13:31:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1701876771-10695-1-git-send-email-quic_mojha@quicinc.com>
In-Reply-To: <1701876771-10695-1-git-send-email-quic_mojha@quicinc.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 15 Dec 2023 13:30:52 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XA6nYCkpET9MQ4jbZBeM2fM8KF-pPAz=KdxOF0JxEzQw@mail.gmail.com>
Message-ID: <CAD=FV=XA6nYCkpET9MQ4jbZBeM2fM8KF-pPAz=KdxOF0JxEzQw@mail.gmail.com>
Subject: Re: [PATCH v2] soc: qcom: llcc: Fix dis_cap_alloc and retain_on_pc configuration
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Atul Dhudase <quic_adhudase@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 6, 2023 at 7:33=E2=80=AFAM Mukesh Ojha <quic_mojha@quicinc.com>=
 wrote:
>
> From: Atul Dhudase <quic_adhudase@quicinc.com>
>
> Commit c14e64b46944 ("soc: qcom: llcc: Support chipsets that can
>  write to llcc") add the support for chipset where capacity based
> allocation and retention through power collapse can be programmed
> based on content of SCT table mentioned in the llcc driver where
> the target like sdm845 where the entire programming related to it
> is controlled in firmware. However, the commit introduces a bug
> where capacity/retention register get overwritten each time it
> gets programmed for each slice and that results in misconfiguration
> of the register based on SCT table and that is not expected
> behaviour instead it should be read modify write to retain the
> configuration of other slices.
>
> This issue is totally caught from code review and programming test
> and not through any power/perf numbers so, it is not known what
> impact this could make if we don't have this change however,
> this feature are for these targets and they should have been
> programmed accordingly as per their configuration mentioned in
> SCT table like others bits information.
>
> This change brings one difference where it keeps capacity/retention
> bits of the slices that are not mentioned in SCT table in unknown
> state where as earlier it was initialized to zero.
>
> Fixes: c14e64b46944 ("soc: qcom: llcc: Support chipsets that can write to=
 llcc")
> Signed-off-by: Atul Dhudase <quic_adhudase@quicinc.com>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
> Changes in v2: https://lore.kernel.org/lkml/20231103105712.1159213-1-quic=
_adhudase@quicinc.com/
>  - Rewritten the commit text based on feedback in v1
>  - Aligned the lines in the code.
>
>  drivers/soc/qcom/llcc-qcom.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

The commit message is much more clear now, though I wish we actually
had more real details about what was in the other bits in the register
that aren't being cleared now and also if this has any effect on
power/performance. In any case, this still seems worthwhile to me to
land.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

