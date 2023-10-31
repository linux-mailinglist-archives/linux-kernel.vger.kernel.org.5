Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786AE7DC948
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343824AbjJaJTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343798AbjJaJTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:19:52 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E38C1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:19:50 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507e85ebf50so7560881e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698743988; x=1699348788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXhk8j7RgMYbDOudOHh/s7hOM+xUoPUnDadljYQRfhA=;
        b=TW56cz8GzAsWEJbTq25R1HfIkf0e/tIPCQLISTne8cbIm/82DlexIrMv0lfQ5nzNJX
         a6DeeFAb/tmhcHmQLUwhxZtQVKq9gula3IbGjPVq9y/B81+WUh1WbFXJ+oMyLLkZ7a3T
         TVErSHkZEwuF7NY9td7DBWrv4Zbk0j0MM2KWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698743988; x=1699348788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXhk8j7RgMYbDOudOHh/s7hOM+xUoPUnDadljYQRfhA=;
        b=B1FgT0k+/4IYEVZqkF5JefHf+shbPPxbzCAN4ku+5bMeq5cHFdohlkf250XC6sUTgt
         ZiL+5DV9Z5jDhhE/L7RSLoqD/GmjlKWLOg1QsKoF048XD3+y9K+mIW6ipnl/0BLzh66I
         kBVP/qJxEpQvUTU334ORVGlhxuWmIRpwIL7/PTek39f8xgoWjyFZ/dosLFA9ExwQ0Pxs
         aRWCcJudgW9jTChjP6SHh86XzhRdDTPYQG1TA2kF9cELl+v/bACBiMOjRxjy20OUUoDt
         k7iSW/alOWYv8mWXbT+cnumUfObtznKRcAsmCduwtxSZkWB3M43NHktlBXotx/bTzEtg
         lkCg==
X-Gm-Message-State: AOJu0YxQ6J1tuhb1Ycquj+bqqN0RhiwnF0PHmH8gn18RjaGXnZRhzR+r
        Mpe9Nc5fWU8nzUxNgIkWryMbEPqNdtJyt9xYV0d67Q==
X-Google-Smtp-Source: AGHT+IFn5yWC2uhLfXCKgv1dEdMIAEZF0taqktQ/pQKq4j66LgSHNMQAoiTD3AocqF86NDROFv5aLWYwvNc/v9aYlPM=
X-Received: by 2002:ac2:498e:0:b0:507:b935:9f60 with SMTP id
 f14-20020ac2498e000000b00507b9359f60mr9079538lfl.57.1698743988383; Tue, 31
 Oct 2023 02:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231030132523.86123-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231030132523.86123-1-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 31 Oct 2023 17:19:37 +0800
Message-ID: <CAGXv+5FWPZYjsXse58k5HyMijkrKBDYw0k4wpdfGv99ur8=5yg@mail.gmail.com>
Subject: Re: [PATCH 0/2] MT8195 Cherry: Assign MFG vregs for power saving
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 9:25=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> This series assigns the right regulators to MFG0 and MFG1, respectively
> VGPU (GPU Core) and VSRAM_OTHERS (GPU SRAM), and removes the property
> regulator-always-on from both.
>
> This allows to save power both during runtime suspend and during system
> sleep; specifically because:
>  1. The GPU SRAM regulator is switched off during runtime suspend
>  2. The GPU Core regulator is switched off during system sleep
>
> Of course, in order for those power saving actions to actually take
> place, it is required to also have the code in [1].
> Anyway, even without series [1], this will not introduce any unstability
> as the Vgpu regulator will simply not ever get turned off.
>
> [1]: https://lore.kernel.org/r/20231030132257.85379-1-angelogioacchino.de=
lregno@collabora.com
>
> AngeloGioacchino Del Regno (2):
>   arm64: dts: mediatek: mt8195-cherry: Add MFG0 domain supply
>   arm64: dts: mediatek: mt8195-cherry: Assign sram supply to MFG1 pd

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

on Tomato without the power saving patches. Regulators are correctly
requested and I can see the SRAM regulator get turned on and off with
GPU usage.
