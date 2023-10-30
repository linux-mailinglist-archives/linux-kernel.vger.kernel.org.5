Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D5E7DC22D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjJ3Vz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjJ3Vz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:55:27 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A999F9E
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:55:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so8468131a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698702921; x=1699307721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqyNfPUEzQcC86GGtCQWWD8Oa22hZLdjLYhI8L84gmY=;
        b=Z+TZIdGnee1piytDqsY41R1RIdmPMgLYRTVpjoSsCrtHnILekgQ4N15jH0Urqd9LJF
         SDTlTCKZP1ODgjqNn2XZP2rVabzDu27CHMM+TXPWTTprByzOcfvxS64LA70As498Wm/3
         O2KqVj4n6rUfVFBtwnEn+9uFpUtqn+audgbCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698702921; x=1699307721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqyNfPUEzQcC86GGtCQWWD8Oa22hZLdjLYhI8L84gmY=;
        b=maE9TokI9GccA27g9vEwtrKkzcxKDxfTSfqhGmNptIMW4xctUIZYeozptdX/whGUoJ
         kuVkFlcZq3SlMnQrrGDHbQZUsb9I6NGJnzyY9vr8Z80N0MIFFLz3VXbzqyviup7RBO/u
         wXdZXA0E5fQwKCL/FEafSIpFQTMun9OGJedkT03l1Ft3pA7//PZzNr0n9M81JDekbOny
         pIOklFdtc6ecQKr86PkM4F9Mcc3VeC9afbAgMhc7hSm46r28gN4p8FGjeLhQiyPVWNhI
         H/E7OCIJ/e8WRbk3OO5VYkgEP07jowdqXoCSe628Rr5nLW+XVSjm3s2iWX9sWpJABPUr
         /Uvw==
X-Gm-Message-State: AOJu0Yxub5qDx++NzydrBEt+/3JZWUE4xpskdXP3qAFm8zI1lcagEwZt
        omKKoNmssfg8nduAXE54ytdAdMpFgMAk+u1xN7z0o9QI
X-Google-Smtp-Source: AGHT+IGCk43py80P9mXUF/4Ntw14oq5TgHtq6dJP5/wUAWrwbNpfP1KsXlcxdAMz4rjLab68Um1Pcg==
X-Received: by 2002:a50:ab55:0:b0:543:fa0:b4b6 with SMTP id t21-20020a50ab55000000b005430fa0b4b6mr1794265edc.33.1698702921673;
        Mon, 30 Oct 2023 14:55:21 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id r5-20020aa7cb85000000b00543597cd190sm46304edt.47.2023.10.30.14.55.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 14:55:21 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-408c6ec1fd1so6735e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:55:20 -0700 (PDT)
X-Received: by 2002:a05:600c:3c9b:b0:3f7:3e85:36a with SMTP id
 bg27-20020a05600c3c9b00b003f73e85036amr20721wmb.7.1698702920586; Mon, 30 Oct
 2023 14:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231027-aspire1-sound-v1-0-5ff3cf8b5701@trvn.ru>
 <20231027-aspire1-sound-v1-1-5ff3cf8b5701@trvn.ru> <d6b63a3c-d171-4b6b-b222-8c619d90f51b@linaro.org>
In-Reply-To: <d6b63a3c-d171-4b6b-b222-8c619d90f51b@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 30 Oct 2023 14:55:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UigovpD_s89j6V7MhCXOVHVVXLRtH3XGEHtcHKbwVgBA@mail.gmail.com>
Message-ID: <CAD=FV=UigovpD_s89j6V7MhCXOVHVVXLRtH3XGEHtcHKbwVgBA@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: qcom: acer-aspire1: Enable RTC
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Nikita Travkin <nikita@trvn.ru>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 30, 2023 at 2:47=E2=80=AFPM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
> On 27.10.2023 16:42, Nikita Travkin wrote:
> > pm6150 has a read-only RTC that can be used to keep the time with some
> > extra userspace tools. Enable it.
> >
> > Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> > ---
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>
> kinda unsure why it'd ever be disabled
>
> Konrad

FWIW we don't use the PMIC RTC in Chrome boards. I can't quite
remember why, but I _think_ that the power lines aren't hooked up to
the PMIC to keep power on for the board's lowest power states.
Instead we use the RTC that's on the EC (Embedded Controller).

-Doug
