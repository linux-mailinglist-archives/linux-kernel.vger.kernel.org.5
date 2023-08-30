Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA89D78DB9C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239250AbjH3SkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243265AbjH3KfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:35:16 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3431BF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:35:12 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9a21b6d105cso696322466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1693391710; x=1693996510; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PakJOWM3f2X2lU1WdNU5BXfvb8MoSegIjT2fCvwDw80=;
        b=GixEsPqB2Th8dNC6y1A9NmVJ8DU68tCEFs3pbkeUL4NK6rr9DIqgUYW7J2xdZAeMD5
         n2GLwwRWMo+pBNZDev8GBEq1BVhRmHssjQ86kPyVIsifDM24qP2hQooWK0Db2yXkkCWE
         Uu8tCeqeOwFA0aW0j7DcTUHfpsqmZWg4zeLR7Rq/QUnw/Mv2hAcguwBpltqNt/ciknKd
         6mB94S6VsuyKyzdkYwGIxW66fqxcnALruf20ueO/+n47nuepdTKY3gPg3QjNUlPKdrAi
         ei1Aoab16YdrNxSuo0lNGAagk9+tx38EAPAcuL8yb/fewoei36LhKqorJqB5LJXyeqcB
         GzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693391710; x=1693996510;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PakJOWM3f2X2lU1WdNU5BXfvb8MoSegIjT2fCvwDw80=;
        b=X2eZFBT2MdgU34B4SM8s9/JR1hzwM2zZq9jISPNNq0DW9cwqjFy0YO6h/wegfEu7fl
         s3rWv2dOIREd/E9CAZdYqmoL2pNdezcetxDt8kSdn86ZMS6B1vABh8MMQG9MrrHGf2G+
         CXfJDMcCbk9W8MlScis4eqQBOVCj/WB00EuCh3nvbS7pqkG/dSFIc24RC10Ct3pLHAZW
         shySxj1qQP9YdvF3EsH+97U4l9IYMDzg6mt6qITG7QiLZ8z1b6tlZICIXndOnO4GX1/H
         vaMh0Qcon+no7y+1kZJnuPvXG5F/vw2gfb11hpf/BonprjvxkrADWv8rjcBjXgX48eRX
         N+qA==
X-Gm-Message-State: AOJu0YwAXdETQ2xlBz3emJO0gVQ3h9DiH4TOuiyB/0AAkXpOGizrdMH3
        KBRqC0m79/qTix4QzZQCem+01g==
X-Google-Smtp-Source: AGHT+IGXWivNh1ZlN/nqyhwxsykDuhrosQf2fDYTztx4ftyPi0mkO+YgqlM65aT3mHmdxazJFxUSiQ==
X-Received: by 2002:a17:906:3152:b0:994:1844:c7d1 with SMTP id e18-20020a170906315200b009941844c7d1mr1175949eje.13.1693391710514;
        Wed, 30 Aug 2023 03:35:10 -0700 (PDT)
Received: from localhost (5073ED84.static.ziggozakelijk.nl. [80.115.237.132])
        by smtp.gmail.com with ESMTPSA id gy25-20020a170906f25900b00985ed2f1584sm7066888ejb.187.2023.08.30.03.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 03:35:10 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 30 Aug 2023 12:35:09 +0200
Message-Id: <CV5T9FXMWOAT.2ZXS0CZ8S0EUM@otso>
To:     "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Viresh Kumar" <viresh.kumar@linaro.org>
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 01/11] arm64: dts: qcom: sc7280: Mark some nodes as
 'reserved'
From:   "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.15.2
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
 <20230830-fp5-initial-v1-1-5a954519bbad@fairphone.com>
 <160d6151-914b-4f2f-9f7c-d14cbb901619@linaro.org>
In-Reply-To: <160d6151-914b-4f2f-9f7c-d14cbb901619@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 30, 2023 at 12:08 PM CEST, Konrad Dybcio wrote:
> On 30.08.2023 11:58, Luca Weiss wrote:
> > With the standard Qualcomm TrustZone setup, components such as lpasscc,
> > pdc_reset and watchdog shouldn't be touched by Linux. Mark them with
> > the status 'reserved' and reeable them in the chrome-common dtsi.
> >=20
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> Could probably use /* Owned by ADSP firmware */ or /* Owned by Gunyah hyp=
 */

Do you know which one is more fitting for these nodes? I don't really
have a reference to if the ADSP or Gunyah (is this even used here?) owns
this.

Regards
Luca

>
> the change lgtm though
>
> Konrad

