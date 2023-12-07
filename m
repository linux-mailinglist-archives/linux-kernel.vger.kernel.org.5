Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60018089BF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442726AbjLGOBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjLGOBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:01:47 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA94710C2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:01:53 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-58e28e0461bso361644eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 06:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701957712; x=1702562512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgofkDV1QE+maxkL3S2zjSbu6oUy+IWDuYDQrR9vz/Y=;
        b=bn5DxgBUnGSxosVGKf/1iQfI+3Fao4pQFZYZSwTiR3BlvgJxWaJQ4YW29MdieD60AZ
         JqGWwhfGKZiPrafKGq7o5jKklPgi/m0jVKbsU1ODXtMwojZ1izUmm/WfpeC5PXbgqeqa
         8vhGYMJIo4dobjnAA1a6sL3zMWD/HzKacYCBizpitBiyVbEWigOSwjLuBiCpohi04Iu2
         8H1FI431fPwq/Qv9QvZoEO5uwiBN7UELAZ8esHT4ASzt8zF6vIJRTDsrLcdJvMIvI2ob
         cDhLjWiFSlap+VB3dC00F5qwPUw8ykDCFqqdLuNZfFjsjhg+W+cyrxQA9oCKrF89NaoS
         7e7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957712; x=1702562512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgofkDV1QE+maxkL3S2zjSbu6oUy+IWDuYDQrR9vz/Y=;
        b=CLmEXUcC/YTVgvovkeFRB07OiatpFlijzvk/kqt2S5WMhxJUNWEm6m7Qctni12fF1I
         KmFcefmAe5cr1cPmyr5EY1OYBm0p249oqgHIz4hjkxZEuwfgwqiPQCxJMXcrWoO1d/Ww
         g63juFt3GP30TYYyDcGNxXJa0jspgYnLH1KoB8/hfItJKgCKHFki9SJfO6EdyDk3A2o4
         O84//sT6dy8y6lV6KHTOI9Tqen16fCwfyizjd6PHA1gkhVc719+wobU77rarJMZTnuIF
         YSFhNGpe39q/zw6Bku8oZDRh3tLMUXnh5aGvdCY6CBVsggGqGInEaNcRCXV8YHTfnZsZ
         KdDw==
X-Gm-Message-State: AOJu0Yx5UVmXymiBLtENy7uf8qnKb55/OEvwMsmybtJ1Lz3B9vlhX3Um
        dT/geoXJh9s+96cqWc4Vx2ENabPd94shyi72VQ5MFw==
X-Google-Smtp-Source: AGHT+IH4M1aBn/CT31gTrrwolpvSe2SEDODFou3tTJp1e3rmuWcBNBzkdyGi0z/PBvz1FAZx5dIKms1bMl6jOkL3qeU=
X-Received: by 2002:a05:6358:7201:b0:170:21b6:627f with SMTP id
 h1-20020a056358720100b0017021b6627fmr3209750rwa.14.1701957712079; Thu, 07 Dec
 2023 06:01:52 -0800 (PST)
MIME-Version: 1.0
References: <20231207091202.19231-1-brgl@bgdev.pl> <20231207091202.19231-3-brgl@bgdev.pl>
 <e58c7338-b01c-4327-9835-a3f4f8986a4e@kernel.org>
In-Reply-To: <e58c7338-b01c-4327-9835-a3f4f8986a4e@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 7 Dec 2023 15:01:40 +0100
Message-ID: <CAMRc=MfGzVODRmhxSjSc16TjwNrLSXS-WWgeSPTDkEkFo9mS4w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: net: bluetooth: qualcomm: add
 regulators for QCA6390
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 2:26=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 07/12/2023 10:12, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add regulator properties for QCA6390 that are missing from the bindings
> > and enforce required properties for this model as well.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
>
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time, thus I will skip this patch entirely till you follow
> the process allowing the patch to be tested.
>
> Please kindly resend and include all necessary To/Cc entries.
>
> Best regards,
> Krzysztof
>

Sorry, I just used the command I used last but this time there were
additional dt-bindings patches. Will resend it tomorrow.

Bart
