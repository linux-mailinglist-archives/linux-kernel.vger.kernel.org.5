Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F20785E66
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbjHWRRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237761AbjHWRRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:17:36 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE2DE71
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 10:17:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c0290f0a8so742944366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 10:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692811050; x=1693415850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MS+TPc34qbEYEOTCakdAp1dhbKIZynKL3y59Y3CigWo=;
        b=WueiVPoMozMdknbeqgWLH3xZEo28P5yxES/Aa+dDp0TXnz4IGZOWdvLXalQ88prxKU
         nehXO+OC4lDaefVkhLN5B6EMiikX4J9wTiJnxGTPF+i0oGnghn/Ypu65emvtvV1Sab0g
         Z+HwzqUiVRE25vIiyjE2QzoKtw8m2r0XVOMCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692811050; x=1693415850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MS+TPc34qbEYEOTCakdAp1dhbKIZynKL3y59Y3CigWo=;
        b=EhPoSn5sscBUtW5osEclDHocpgX9MxDrL1NWyXnbJ5/P9/rnpoJ0rF3w0Ybm14OLy/
         ArAzZxRTLELHXHPhzdanJhn4Jbu3CUw+DFIiPV8wL4hnTfHkMN5h/6M4bt5TFFJuIklg
         52GzIaeIGwX2WNT/t4vVFbUkWxcqftFMImmKSiGjvuj1sr8biVOTBLsUObQ9XZhFO4hy
         Q2fkqIpQpcNBzH+Oj7RuE79wa4beukkH0ycrtn8yMxezGQFct1vzD12T25RjcaDYNHmC
         pObJxGPF0hyXoeJRyikhdeuig8n3dQIh/360YL82V4sGZbn3/ww1QYU8Zpxynmp0mOVB
         LZRw==
X-Gm-Message-State: AOJu0YyovYgZSWyltQFwtA2ZIfk6vZTlM0ARGL5jJ9X++hSudXGyU6QY
        4yFT6uxXvj3O9rsUQ2K1BjHQUyS0jmDT3ubvS7rpwtjL
X-Google-Smtp-Source: AGHT+IHZtT378tzVVXZnFYAxkVrFK8rOeJB2akkz35pq4E/2JUYoGQ9OVEqxC4THyMOIryG78W169w==
X-Received: by 2002:a17:906:15:b0:9a1:ce57:8e47 with SMTP id 21-20020a170906001500b009a1ce578e47mr2103396eja.68.1692811050251;
        Wed, 23 Aug 2023 10:17:30 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id ke4-20020a17090798e400b00993004239a4sm9910467ejc.215.2023.08.23.10.17.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 10:17:29 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-529fa243739so974a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 10:17:29 -0700 (PDT)
X-Received: by 2002:a50:9f4e:0:b0:523:b133:57fe with SMTP id
 b72-20020a509f4e000000b00523b13357femr275913edf.1.1692811048986; Wed, 23 Aug
 2023 10:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230822094414.123162-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20230822174101.v4.1.I26e017b00a341e7a5a2e94a83596923713408817@changeid> <20230823-raving-either-fb7bdb98b846@spud>
In-Reply-To: <20230823-raving-either-fb7bdb98b846@spud>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 23 Aug 2023 10:17:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U2kHPu2coSniUXfDJH8gYMV6115NKkyS7Rt4mEx4fzew@mail.gmail.com>
Message-ID: <CAD=FV=U2kHPu2coSniUXfDJH8gYMV6115NKkyS7Rt4mEx4fzew@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: qcom: add sc7180-lazor board bindings
To:     Conor Dooley <conor@kernel.org>
Cc:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 23, 2023 at 8:11=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Tue, Aug 22, 2023 at 05:44:13PM +0800, Sheng-Liang Pan wrote:
> > Introduce more sc7180-lazor sku and board version configuration,
> > add no-eSIM SKU 10 for Lazor, no-eSIM SKU 15 and 18 for Limozeen,
> > add new board version 10 for audio codec ALC5682i-VS.
> >
> > Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.goo=
gle.com>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Conor: any chance you could reply to v6 (instead of v4) and add your Ack?

https://lore.kernel.org/all/20230823151005.v6.1.I26e017b00a341e7a5a2e94a835=
96923713408817@changeid/

I _think_ the v6 patch series is in good shape so I don't expect
Sheng-Liang to have to send a v7. I'm worried that your Ack will be
lost if it's not sent in response to the v6 patch.

Thanks!

-Doug
