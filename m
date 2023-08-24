Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E39A786CE8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 12:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240345AbjHXKjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 06:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240878AbjHXKjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 06:39:17 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9F819B6;
        Thu, 24 Aug 2023 03:38:59 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d6b1025fc7aso6040776276.3;
        Thu, 24 Aug 2023 03:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692873538; x=1693478338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ku30yGR4fsIAVCtmRwOtJYE7C4zQBYo4YJCwft/LQ/M=;
        b=dimZI7NLJY2HQ1/qZ7BKTpu4u9yGwKhafQCY3K6zD1b0kbjvwFDzFnZpZtRLjGUVdI
         XkXW+3jg+a/uJu0dPdpLXWge4OgH6yaly8/3thpU9gZeGGY/T0XhRi3jTov4EldI56i7
         rSi9FyKFIqPw3d7ZcXzzzYJbTOCyW01eApO5Y5f+yaXjgYxJoNuG0bGW2PhmT9BCT7aQ
         iwl/uOp7rgx96TZO+tsfjbjbqi9GhAbWLKnVtIBdMK65iVkmJFrYJWTgnV5XJ9DfRyz3
         MHmABmClsz8qxb99GSgC3E1cpr9oP+AKghUlR+AvV5QbE8QidovT/aZYXwW7OKnkrZ7F
         /vqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692873538; x=1693478338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ku30yGR4fsIAVCtmRwOtJYE7C4zQBYo4YJCwft/LQ/M=;
        b=hWb7KeHN4e1IBSrDlLxT8Q4vklyEfaE+OYamEYLVAr/0Bz7Bc64tEhxTu5UoujVZT8
         8ArAA3RJVK1DPROOXkQz69nTf1yOeDgDw2PjJjtCobjsjaK0WUsJAgug12aPEEPbnrgB
         f8UYwy8rNCWrCEWrONYgbPO2Ftoff6zj73yaPTaUlNMd/xBdMwxcGoR0jdWz+caE+Wd3
         yk0RQqbKzqF5h1E06bq7gfzmpdfhMs9DJv1JnL1DyKKcGBsj9T8MKS60YHLia4DRACWH
         bFC+B9/JbDR5xQPKmAh8P4wuYZRM4/MWy/EnZblF6BZ31A7/U2/oePJudeVbVLJvyPIL
         /9gw==
X-Gm-Message-State: AOJu0Yx2GG9wgn2ncJ1H0b5CS9IDwgVyURwnGl014J7WkUo7PjCDDaoU
        mud/SU0w1bOJQXUEpeFSqDgP53ywTC3oG4c8ZaCNRxriHj+e2Szq
X-Google-Smtp-Source: AGHT+IHy0ZBnflfuFgKSkYkYtritFVAMG3KoOaW8jzLLo68VUseS23HYJcxULEi6DpiFPJZhEVYWbkVINdPfVS8NUPM=
X-Received: by 2002:a25:6412:0:b0:d77:a0a5:e1a3 with SMTP id
 y18-20020a256412000000b00d77a0a5e1a3mr5838002ybb.33.1692873538363; Thu, 24
 Aug 2023 03:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230824091737.75813-1-davidwronek@gmail.com> <9db02015-2c41-40d6-bf35-69ef277e9ce4@linaro.org>
In-Reply-To: <9db02015-2c41-40d6-bf35-69ef277e9ce4@linaro.org>
From:   David Wronek <davidwronek@gmail.com>
Date:   Thu, 24 Aug 2023 12:38:47 +0200
Message-ID: <CAEoe_eUJWAG71VcYCfLWC5KCamRBjUZ+V3j4ZrSjBunh35s6Rw@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Add initial support for SM7125 and Xiaomi SM7125 platform
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 11:53=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linar=
o.org> wrote:
>
> On 24.08.2023 11:15, David Wronek wrote:
> > This series introduces support for the Qualcomm SM7125 SoC and the
> > Xiaomi SM7125 platform.
> >
> > Signed-off-by: David Wronek <davidwronek@gmail.com>
> > ---
> Would your device boot if you:
>
> - removed qcom,board-id and qcom,msm-id
> - created the image like this:
>
> mkbootimg \
> --kernel arch/arm64/boot/Image.gz \
> --dtb arch/arm64/boot/dts/qcom/blahblah.dtb \
> --ramdisk blah.img \
> --pagesize 4096 \
> --base 0x0 \
> --kernel_offset 0x8000 \
> --ramdisk_offset 0x1000000 \
> --tags_offset 0x100 \
> --cmdline "foobarbaz" \
> --dtb_offset 0x1f00000 \
> --header_version 2 \
> -o boot.img
>
> ?
>
> Konrad

Seems like my device needs those properties, it does not boot without
msm-id and board-id and the command you sent.

Sincerely,
David
