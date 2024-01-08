Return-Path: <linux-kernel+bounces-19775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEF3827379
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EAABB22E6E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E13E51039;
	Mon,  8 Jan 2024 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xw4uyfIo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211DF51037;
	Mon,  8 Jan 2024 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3376ead25e1so623632f8f.3;
        Mon, 08 Jan 2024 07:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704728101; x=1705332901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dSkJ2ZiJqHanlAP+HAK0y6zusm5LzCHKOPBAF01RGI=;
        b=Xw4uyfIoslfLqcwYTa5Fp5lyDdT6ZJ+ZvZO78hDXPQ5kjj8YNUt5mKPPG4iVdUO6Xe
         dEjjLm5gr8mgFUCzsMgoa1WxgCbq63B90vFpPse1Ag+KvOrT8YIcDhBUbutTJDpKAk7L
         NcL4pDRNZwm99wpRiGJyxLpHp4scVAk2s47HnHbx5pMr2yus9vtVXv5y35eZBQjkg3QD
         PCXobg/OffJNTbRkIRyj+kcfBVTSPSfpnYe3ZBYHwS+F3WeZ5Q6PB/hU+d3N0zclLNI6
         mobOT92LM2dmIez80EjOQ41xd3ZDgmzESYeb1mMrHNRHoruwdSXG92cC7Xs1Gk4uy/Pc
         vBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704728101; x=1705332901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dSkJ2ZiJqHanlAP+HAK0y6zusm5LzCHKOPBAF01RGI=;
        b=pto6BW95nCWoaA3MXBQbD5krY0UrsSrPNFqAeCFi9k4jWHJffjaQdug8BGrM+REGqn
         A1h8rcHGnQ4xmgHYG5mlWvTjm40kFfX9lVVQCwrjqi2TELiCWHq6xz3KSDSJAsS8d9m/
         4dUmOAVvyj7iGA+7Z2HWKgfwksW0ZVzv7n0bxbFhkwNfAxNiZ+6sQIG/mI+48RUQieZ5
         Tsjon/HNtZ+kGPiUAyMatQ1AEDmUFifOwL2JoRh9xsiG89EOXgKKi4kfs1o3kpoFX+3j
         ArQ/zqbl5UG+P3goiLd+4Rlaf4da3W43uxL/xXRe7nTo/+ematrHVTe7L9UCpugI6Dlv
         +v/w==
X-Gm-Message-State: AOJu0YyFA8pLD4q8tPOgOmfrRnl1y7bx2DoBfFwOvH12uSkFskUhk/cK
	LbMfYjQZHQCaaA4swuooRhNlwKFAt2iaAb6ps5w=
X-Google-Smtp-Source: AGHT+IEDyiUE/fCZgQ2fiflpohBhP714EYsyUDi/vkkXfWWGgss80RDHy8tK389zVkT20aui+pSoTQyf4TXc3l08ehI=
X-Received: by 2002:adf:f0d2:0:b0:337:4c69:d6b with SMTP id
 x18-20020adff0d2000000b003374c690d6bmr1755895wro.6.1704728101148; Mon, 08 Jan
 2024 07:35:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1700864395-1479-4-git-send-email-quic_mojha@quicinc.com>
 <20231225135542.1789-1-ruipengqi7@gmail.com> <520e377d-e990-c185-4a20-07806873e506@quicinc.com>
In-Reply-To: <520e377d-e990-c185-4a20-07806873e506@quicinc.com>
From: Ruipeng Qi <ruipengqi7@gmail.com>
Date: Mon, 8 Jan 2024 23:34:50 +0800
Message-ID: <CADHLONEn4oyRFrNWEbt2mxMczyc8FrDLMzaZ7fsijzm9Y8VTBA@mail.gmail.com>
Subject: Re: RESEND: Re: [Patch v6 03/12] docs: qcom: Add qualcomm minidump guide
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: agross@kernel.org, alim.akhtar@samsung.com, andersson@kernel.org, 
	bmasney@redhat.com, conor+dt@kernel.org, corbet@lwn.net, gpiccoli@igalia.com, 
	keescook@chromium.org, kernel@quicinc.com, kgene@kernel.org, 
	konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-remoteproc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	mathieu.poirier@linaro.org, matthias.bgg@gmail.com, nm@ti.com, 
	robh+dt@kernel.org, tony.luck@intel.com, vigneshr@ti.com, 
	qiruipeng@lixiang.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 11:27=E2=80=AFPM Mukesh Ojha <quic_mojha@quicinc.com=
> wrote:
>
>
> One more thing, kernel part of minidump, we are calling it APSS Minidump
> has limitation of no of entries so it will be difficult to dump
> non-continuous regions after a certain number of registration ~200. Howev=
er,
> we do have a solution in downstream kernel for it like to create a big
> CMA buffer and register this buffer with Minidump so that whatever gets
> dumped in that buffer gets captured during crash and fill up this buffer
> and create elf during panic. I think, similar thing you are also doing
> with your OS-minidump.
>
> I have just glanced into your implementation of OS-minidump, it
> more of relying on basic concept of RAM content preserved
> across boot and later reading it through procfs but this basic
> stuff is common to pstore(ram) as well and pstore has file system
> support why don't you make your driver as one of pstore record and that
> way Qualcomm minidump also gets benefited where entire OS-minidump
> record gets registered with Qualcomm minidump and we get this on panic
> and you get this via pstorefs.
>
Thanks Mukesh=EF=BC=81It is a good suggestion to move OS-minidump forward!
By the way, I have some questions here for which I need your assistance.

Firstly,I can reimplement OS-minidump as one of the pstore records to
dump data. The resulting dump file would contain thousands of
non-contiguous memory regions, each with only the virtual address and
size recorded. As far as I know, Qualcomm's minidump can handle
several memory regions, each with a physical address and size.
This seems to be a difference, and I'm curious as to how you deal with
data dumped by OS-minidump. I would really appreciate it if you could
provide more details on your approach.

Secondly, what tools do you use to analyze the dump data, and does it
support crash tool?

Lastly, is Qualcomm minidump compatible with non-Qualcomm SoCs,
and if so, how can one use it?

Best Regards
Ruipeng Qi

