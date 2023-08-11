Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E767788E6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 10:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbjHKI0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 04:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjHKI0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:26:16 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD302D44
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 01:26:16 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1bb7a1c2fe5so1433438fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 01:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691742375; x=1692347175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBQIAuWQU6VPdELzEaQY7DkA3Xxzq3XQUKE0Af0sgFU=;
        b=U/4jTxkiJq9iw1E/3p1qJY1ejTgsDYuwubhqrBwyrXULcAL8bzYgh6flXS9f8NafP1
         S09MWWuTxhrlLGlFaoTGBDaLr5KlVXfcIhfarJUxymQqcDhMf0erRpUlcBPqMuD753PO
         VNiQMv43xyeWv0EvkgtFjFZawq8ad3q34EGnqDXPvTaHviaTGo4gOewarEZppXXtnMwm
         VOLvBYietXyDZ/VeZy5uC/95IsBs20/xMCbHIRnufpklDYd2spRgSFbAAIGY4U8xPuh6
         3MVn+TMeM5p/LsR3SdR6Q1e39u5PcPwzVh/Kbkw7oPTeAgZPX9I3oDmPCz0H6Jk+4pve
         YewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691742375; x=1692347175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBQIAuWQU6VPdELzEaQY7DkA3Xxzq3XQUKE0Af0sgFU=;
        b=QP0LtNaBhrVXFxoTXopk4PKovP4wbFWDJostu/CRG5hr9CjYsj/e4uSCrIPSal+GDk
         sIht9NiXcUwEyu5+SZIgZ94oG00SxPKBbzXd3oBwmFr+zv9wd2GRalKAj8WRWn6FmR2G
         ADvB+G+vRKFYpjt0wkSN3sp9OafPpfV2iAefkt2CdcfzvNJavtXSCjopspkMAdccvsnp
         tTawo0lY5BDbV2RG8XPqszO+qKzJDxiqgLIwY+LwM4HZAxH0fD8ePpp+SHtNww8RWCtH
         XukExE4FEOfLnEwYEO5OF6LCGIsccVy+zD67PKTV4W4lTUv/ItXqKAO3IrOHjayYuI0Y
         jO5g==
X-Gm-Message-State: AOJu0Ywx1IJb0Ys30EtFwdeVadU9sab53GzaATu7Az+8K+pzZV+mEVeh
        jse9pUL9WM5jLE7x4hwixwLiiOfmj58QSzXtDswITg==
X-Google-Smtp-Source: AGHT+IEwTfHwRmtdOjy91QbWkO46QZF7tiagTNSfcA68wYXeZxgMHEc6juVY0lf78Z3/++xgg621xKZF1Tr1MP6FJEM=
X-Received: by 2002:a05:6871:5c8:b0:1be:f383:2c3d with SMTP id
 v8-20020a05687105c800b001bef3832c3dmr1337292oan.14.1691742375286; Fri, 11 Aug
 2023 01:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230802071947.1683318-1-yangcong5@huaqin.corp-partner.google.com>
 <20230802071947.1683318-2-yangcong5@huaqin.corp-partner.google.com> <8b47da4b-ec68-40f1-c3eb-939dcfa7550e@linaro.org>
In-Reply-To: <8b47da4b-ec68-40f1-c3eb-939dcfa7550e@linaro.org>
From:   cong yang <yangcong5@huaqin.corp-partner.google.com>
Date:   Fri, 11 Aug 2023 16:26:03 +0800
Message-ID: <CAHwB_NLn+dAgfJaEsO_9dBn0Gk+=frrm-f0t=9m3EPf2zUbT2A@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: input: i2c-hid: Introduce Ilitek ili9882t
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com,
        dianders@google.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, hsinyi@google.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,Krzysztof:

The changelog is on the cover letter. Thank you.





On Thu, Aug 3, 2023 at 7:12=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 02/08/2023 09:19, Cong Yang wrote:
> > The ili9882t touch screen chip same as Elan eKTH6915 controller
> > has a reset gpio. The difference is that ili9882t needs to use
> > vccio-supply instead of vcc33-supply. Doug's series[1] allows panels
> > and touchscreens to power on/off together, let's add a phandle for this=
.
> >
> > [1]: https://lore.kernel.org/r/20230607215224.2067679-1-dianders@chromi=
um.org
> >
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> > ---
> >  .../bindings/input/ilitek,ili9882t.yaml       | 67 +++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/ilitek,ili9=
882t.yaml
>
> It's v6 but this still misses the changelog.
>
> Best regards,
> Krzysztof
>
