Return-Path: <linux-kernel+bounces-20285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5485F827CDF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEFD2285604
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD81E28E8;
	Tue,  9 Jan 2024 02:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3OARUEU"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC60B4680;
	Tue,  9 Jan 2024 02:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-596175c0be0so1684613eaf.3;
        Mon, 08 Jan 2024 18:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704767231; x=1705372031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/b5QxT6/6syUsjtZnVefpjrdly7pCfUgvMakpuOn3IQ=;
        b=S3OARUEUoPb9UjS6dlocNtC7ih2rqL0O0HG33/ASswnaKXr53sITHAJFb9Vq3xRwiX
         UrwhAJ9LLhysbYy41n5t+rHCqLlAkHeijWQOtZosMXcv5uiCdm0F2uAOMLQ3siltz0pk
         ieq3Ff79WwbYoXDVPlf3KN1/wuOCWYZMUFbBHtRylI6ftMtcSvnzeF/6C127juRRZM/a
         FzeifmRkZzURJA1Op//36Z3+ePBOg87VVl6DgoVttSb8V5ssC23DepV5rOIQA3Wx8puk
         UR0DVwK4xyDK6MiNMP0cQ2Vh1ssW0j/uq+555X7zOxRYif55WoePmoMQy2ahpHhJhPSv
         mHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704767231; x=1705372031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/b5QxT6/6syUsjtZnVefpjrdly7pCfUgvMakpuOn3IQ=;
        b=m2mEBw7CGiPvh8syiAFcaEZIXjqZdueDidYKSwNXWqz2qwFRPT20vQyx+5xhN5m9zG
         UdfTJp3OTphc0W7Y3K/pDOgfPzG8NMErCkcDUZDef2p/RGT3bWNmFfsFJAIosG2toHd0
         ydZMmZLSVm9YBOZS4neVfmjx9wJw/Y8YuBU/cjJgPZHiYrjvawhpnERMVabPBeJKEuV6
         heIn0K0Clu73HwVnedwZlsVV2mcROMOV71lNFKOfJGx+rN8kLS43NkWC7USJgPjKdKVC
         KgGQDxgEnSAc/IU4cCnP/uHgbME6Gm7PRjfvedzxT67XVLQ/Y2nrjfqWN22Z/tgiJZtz
         vbtw==
X-Gm-Message-State: AOJu0YxnSSqdsNYT3eGavWw4qOxBLRcuyenu+LiWJhiCg7B9P9VtznQ7
	S5Jqf1pwgbdNbO9TERmcvkcp43jjvFYM80VWZMP2qT8DceKVPuFw
X-Google-Smtp-Source: AGHT+IFKuWrGoo84LoZFi/ctDsfndCTrRklUyKu2uFMkfPGykr82KTzkVyrpOki2oOspwCcTcoeTZezJvMSrIhka6qo=
X-Received: by 2002:a05:6820:1acc:b0:596:ab4:64ba with SMTP id
 bu12-20020a0568201acc00b005960ab464bamr3845492oob.7.1704767230517; Mon, 08
 Jan 2024 18:27:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108072253.30183-1-qiujingbao.dlmu@gmail.com>
 <20240108072253.30183-2-qiujingbao.dlmu@gmail.com> <cd4c5c26-fef9-44d8-a2fe-1cff0fc6fd03@linaro.org>
 <CAJRtX8TcXrP8aqr3ejvtDGR5Y-ogbLkvJvJkLh_MzpnK7wgLGw@mail.gmail.com>
 <7ceb8f61-6929-4ca0-83e0-c6534241ca5a@linaro.org> <CAJRtX8QSoS72rUj7vu3CLgthfneG-RudUygcZEsw-sBFKw99tw@mail.gmail.com>
 <086e568f-b9f2-417c-8f94-ebb97fbffbfe@linaro.org>
In-Reply-To: <086e568f-b9f2-417c-8f94-ebb97fbffbfe@linaro.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Tue, 9 Jan 2024 10:26:59 +0800
Message-ID: <CAJRtX8Ran+MuhtUXyxm0stQJrkzksPeNEnWViOQjfE2QgsCOmg@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] dt-bindings: rtc: sophgo: add RTC support for
 Sophgo CV1800 series SoC
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 11:24=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 08/01/2024 14:47, Jingbao Qiu wrote:
> >>> So I wrote the following in the changelog.
> >>>
> >>> - add syscon attribute to share registers
> >>>   with POR
> >>
> >> Where is this syscon attribute? Please point me to specific line in DT=
S
> >> and in the driver.
> >
> > I will explain in the next version of DTS.
> > Thank you again for your patient reply.
>
> You added some syscon attribute. What is this?
>

This RTC device has a POR submodule, which is explained in the description.
The corresponding driver of the POR submodule provides power off
restart function.
The driver of the POR submodule just uses reg to work.As you mentioned in y=
our
last comment.POR  is empty, so there is little point in having it as
subnode. we need
share the reg to POR. RTC driver and POR driver will access this
address simultaneously.
so,I added this syscon attribute.

Best regards,
Jingbao Qiu

