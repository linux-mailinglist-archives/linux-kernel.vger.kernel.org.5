Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7534E80A7BD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574383AbjLHPmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbjLHPmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:42:21 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF0C173F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:42:27 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a1e2f34467aso219685366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 07:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702050145; x=1702654945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0smOkN0JwIYP/mQNjuHR8QDcn+P+VGLbn6lLRSQdlCM=;
        b=kqa8HPgP7MMq1PDWBh/OXA912HTgQ/lHGsgBOQ2T0xIeXsgLppcjJvuVN4l2HJh0bu
         gVB+F09MESkBDfE/guyUOVM5p8udc4cbSAfMAi3OE0rK3V3KvKNSjD3+eM4FYJGVwEba
         EYx5kRoW/4cPs4tXHVAbF8Fmun2cANiaA3U9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702050145; x=1702654945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0smOkN0JwIYP/mQNjuHR8QDcn+P+VGLbn6lLRSQdlCM=;
        b=Gcw19tRi/n64/89hLf9jvh97g0g/xhx2VXQrUu5Vq3WYI8MfUv2ADMgAi3alVY2Ncx
         Ce2398j4urglzT+TYk82xJ98s+XYqQCkYVaUWjJLtzf6Jg2FKHDL3nS8Gtk4LGqsPmay
         9Xxu2jEGuk4+ppbu/1GfKJe0E3ZpQnRKE47JCs2PYHzAM94trE7nadj05jYdx784LUL5
         SIIh5g6I8CtZ3VFHO4K1UTE0PitgIBnWMQsd8hgGh+mur3PcnVTovs2c9znBFipQfUAR
         HTnZ3q7YN3aAEZp3X4poQVauGCDQhmda65wnLj0LGat9OMAnITC79wns+28A/uMdUsNv
         Tb9g==
X-Gm-Message-State: AOJu0YzgZD8XyUKWch7qPurdHnx0RG17G5VjhYf2a5PCz/zcwwL4b419
        jgrSmXWCmjQ/ChPYjsHmSCta3jh5epIkzAtEf/vlGTCW
X-Google-Smtp-Source: AGHT+IG26+XkuB+ccljwC+cx9JM5oQeMY30OWH21YrWAAm5Wk4w8OZhEFPVP6ToRo7aaWu6mctFHmw==
X-Received: by 2002:a17:907:1a58:b0:a18:fa22:5df2 with SMTP id mf24-20020a1709071a5800b00a18fa225df2mr94335ejc.31.1702050145394;
        Fri, 08 Dec 2023 07:42:25 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id vb1-20020a170907d04100b00a1b7769f834sm1129757ejc.81.2023.12.08.07.42.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 07:42:25 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c32bea30dso54785e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 07:42:25 -0800 (PST)
X-Received: by 2002:a05:600c:b92:b0:40c:2399:d861 with SMTP id
 fl18-20020a05600c0b9200b0040c2399d861mr61604wmb.6.1702049685373; Fri, 08 Dec
 2023 07:34:45 -0800 (PST)
MIME-Version: 1.0
References: <20231106144335.v2.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
 <20231106144335.v2.9.Ie30c1d3f780666f6906fd2fd7c437632c229d987@changeid>
In-Reply-To: <20231106144335.v2.9.Ie30c1d3f780666f6906fd2fd7c437632c229d987@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 8 Dec 2023 07:34:28 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XsPGvNggpJPCpF=xhkm3dOHsStycZvuVttA=ZH6=EUmw@mail.gmail.com>
Message-ID: <CAD=FV=XsPGvNggpJPCpF=xhkm3dOHsStycZvuVttA=ZH6=EUmw@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] dt-bindings: watchdog: qcom-wdt: Make the
 interrupt example edge triggered
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     swboyd@chromium.org, linux-watchdog@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 6, 2023 at 2:44=E2=80=AFPM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> As described in the patch ("arm64: dts: qcom: sc7180: Make watchdog
> bark interrupt edge triggered"), the Qualcomm watchdog timer's bark
> interrupt should be configured as edge triggered.
>
> Update the example in the bindings.
>
> Fixes: 7c631cdff391 ("dt-bindings: watchdog: qcom-wdt: allow interrupts")
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> (no changes since v1)
>
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I saw Bjorn landed all of the dts patches from this series but it
looks like the bindings patch got left behind. Anyone want to claim it
for their tree, or Ack it saying that you'd prefer for it to go
through someone else's tree? I assume Krzysztof's Ack means he's not
intending for it to go through the DT tree and Bjorn doesn't seem to
intend for it to go through the Qualcomm tree. Guenter/Wim: it feels
like this could go in the watchdog tree?

Thanks!

-Doug
