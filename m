Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC867A11E7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 01:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjINXhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 19:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjINXhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 19:37:52 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293631FE5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 16:37:48 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-529fb2c6583so1873120a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 16:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694734665; x=1695339465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUQ7K1Uj3M2Ku8c5LZFJY/v14ESPAzqXsk3sQ7d9n6g=;
        b=GoIzRtGfQuh1LB1IL86nKXB2nOyl1/5BFtCWCMCli++2yiWxwWmrWfSCDmGZ4iEm4a
         hTR+2pJIZVA21FhWAumgLDowIufe0I50b8CTejUsAYwyF/5KDvf9vvgbQJr6XVyDuof9
         RAVlCgoIQ/EDbfF6+dOnB7uxEc3n38wrERnlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694734665; x=1695339465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUQ7K1Uj3M2Ku8c5LZFJY/v14ESPAzqXsk3sQ7d9n6g=;
        b=CRhufYdLhjEF70e9q+AjAPB9TzpGA79LFiO7NVpUt0DgYHrPvqKKkxNk+cn5ZQXtJO
         CYJ+lLgKR7gFlwDDwk2od65RP/bM2+dC04YQ4sKY1Q/sSKBzy6SODQz3KPvwJNVj7pTf
         KPVtZE8XMUnQ4vpDMdutRp3wpd8Yo3Gyjfb95dpz3t+YBYdmBNXRUt+kiNsNkw9hFrtJ
         bss7LakXgc9tve86Dd3bNj4iA9Nzm4NbHUPlL7OZcj535DFfyHw7FZ7vyEyK+c8T6fQT
         Bj6w0Pfbm5MAeWsXz1SX8A8RxoPZaIZgDjRJv8brmXkA331GDg8XOnrwbl2AHP/TNjTc
         BjXg==
X-Gm-Message-State: AOJu0YzQlHzlSBAvtpTzphoVil3KMmTfH61rIVGpX8EAh+01ZN4QZHc1
        0ZEQPm8tpUYpy2vC7hjPFAzyeOZDs0LExQTXaBwgJw==
X-Google-Smtp-Source: AGHT+IGxZU3U1LfWcbKdHfWM1lxrKXEeSqt4q+8IFZ/OjlVZrV6f9sqMuSasd5JRS9POfXYtL6HHXQ==
X-Received: by 2002:a05:6402:5141:b0:523:102f:3ce1 with SMTP id n1-20020a056402514100b00523102f3ce1mr19836edd.10.1694734665585;
        Thu, 14 Sep 2023 16:37:45 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id t18-20020a056402021200b0052fdfd8870bsm1501337edv.89.2023.09.14.16.37.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 16:37:45 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4047c6ec21dso895e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 16:37:45 -0700 (PDT)
X-Received: by 2002:a05:600c:6027:b0:3fe:eb42:7ec with SMTP id
 az39-20020a05600c602700b003feeb4207ecmr35638wmb.1.1694734664702; Thu, 14 Sep
 2023 16:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230816112143.1.I7227efd47e0dc42b6ff243bd22aa1a3e01923220@changeid>
In-Reply-To: <20230816112143.1.I7227efd47e0dc42b6ff243bd22aa1a3e01923220@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 14 Sep 2023 16:37:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U4jmFcZRP0HoyOFbsBwahvsC8xiTkgQX6FhisVw8ubNg@mail.gmail.com>
Message-ID: <CAD=FV=U4jmFcZRP0HoyOFbsBwahvsC8xiTkgQX6FhisVw8ubNg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sc7180: Move trogdor rt5682s bits
 to a fragment
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Wed, Aug 16, 2023 at 11:23=E2=80=AFAM Douglas Anderson <dianders@chromiu=
m.org> wrote:
>
> Several trogdor boards have moved from the older rt5862i to the newer
> rt5862s, at least on newer revisions of boards. Let's get rid of the
> dts duplication across boards and promote this to a fragment.
>
> Note: The old boards used to override the "compatible" in the "sound"
> node with the exact same thing that was in "sc7180-trogdor.dtsi"
> ("google,sc7180-trogdor"). I got rid of that.
>
> This is validated to produce the same result when taking the dtbs
> generated by the kernel build and then doing:
>
>   for dtb in *trogdor*.dtb; do
>     dtc -I dtb -O dts $dtb -o out/$dtb.dts;
>   done
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  .../boot/dts/qcom/sc7180-trogdor-kingoftown.dts | 13 +------------
>  .../dts/qcom/sc7180-trogdor-pazquel360.dtsi     | 13 +------------
>  .../dts/qcom/sc7180-trogdor-rt5682s-sku.dtsi    | 17 +++++++++++++++++
>  ...180-trogdor-wormdingler-rev1-boe-rt5682s.dts | 13 +------------
>  ...180-trogdor-wormdingler-rev1-inx-rt5682s.dts | 13 +------------
>  5 files changed, 21 insertions(+), 48 deletions(-)

If you agree, it would be a wonderful time to land this patch now.
Please let me know if there is anything outstanding you want me to
change.

NOTE: if it were me, I'd land _just_ patch #1 in this series (AKA
${SUBJECT} patch) and skip patch #2. I don't mattery a ton either way,
but it seemed like Konrad agreed with me that the benefits of patch #2
were questionable and, unless someone loves it, I vote for less churn
instead of more churn. :-P

-Doug
