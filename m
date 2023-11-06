Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E457E2392
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjKFNMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjKFNMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:12:52 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58DA10B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 05:12:48 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a84204e7aeso51765737b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 05:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699276368; x=1699881168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxpPF2PaBL3CNmfmQemDqBdiN737CxFp3aHV5kAbiR8=;
        b=TtkLGhSTEltoS3Bv5fxtYantLwI7UJ+S2h2ei0zBl1TG1h8CsdGSofiTGBa1nfhu4z
         gCJ/PY9xP5J1XOK6t4OlLcHIxhKqVt/kXLMnRin1JVPbdZQFGcrOtCj+f68pyhVZuJ+J
         B5E5pJYKorUC9QygwPRpXvjUltvymzRGy7gfAeg6fFC43dk6AU1DDFaE0re/0ox33TeB
         ghYGO4wLa9mYCk8jU/KO7yvXQxvLSVGipSMy6Wh71WCK//17+YcBCGGoOGAWj+ULZ5Rq
         mmy+kUOk6azSrHyvAAzI0Ndg6W1tm/hBwlYmQlONHHC99fQIKYY3C3xnQ+MbSkHiMyWk
         ycxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699276368; x=1699881168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxpPF2PaBL3CNmfmQemDqBdiN737CxFp3aHV5kAbiR8=;
        b=HsVTTFpWg6I5l/xGPzOwYcgJbNW0vahveI3d2BezovWYAepzwbFw0HptKXKlHnIj0q
         +kBghjwN+wIOjEmsN0kNwqF4h2e/OE8DyNcv83RmLyMbqP1jnZ7UpGl95iyW5Mbh55X7
         aXy3vkX3N9najdJQ5J7J1YEc7ebUgU5HHhlxj/DyQi11q63HSAUVpdi2LcRbJCnRCZsY
         24cdXEjg91sl6aQuRmyoPfKJv1djRsNi4QF0CkK70NWaMSLpcdwWy8smC++WiqO/xZ7y
         PtO2YTTUhNbfGuf15HrX0u5FoPQymscRqOGZ4AdYxFeLiau/5+quafeUIck63mvcm0r/
         eSLg==
X-Gm-Message-State: AOJu0YyE5pSqnHocQuU4WNeR981pBfQ20+BdJC9n/A0C2TouyVSfkmGI
        p+k4hky9ITTgh/O5BKgeAfTB8Tl3EAGc/mCxWiLoJA==
X-Google-Smtp-Source: AGHT+IEFyhcttwC2AVcJ6l458vobu3PLKnKPb9gZbnAPMBAItuOH18+eViIXYZ8jDfE6HXw27sxS5z1tCCF8lr3YnKk=
X-Received: by 2002:a81:838e:0:b0:577:51cd:1b4a with SMTP id
 t136-20020a81838e000000b0057751cd1b4amr11212499ywf.41.1699276367940; Mon, 06
 Nov 2023 05:12:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1698353854.git.oleksii_moisieiev@epam.com> <e9285b4377242e4d888391be987cbb99caf8c573.1698353854.git.oleksii_moisieiev@epam.com>
In-Reply-To: <e9285b4377242e4d888391be987cbb99caf8c573.1698353854.git.oleksii_moisieiev@epam.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Nov 2023 14:12:36 +0100
Message-ID: <CACRpkdYW-xmejyOo9H9XSkcabvYgBqPvpjppvNe_RF6RLxyxKA@mail.gmail.com>
Subject: Re: [RFC v5 5/5] dt-bindings: firmware: arm,scmi: Add support for
 pinctrl protocol
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Takahiro Akashi <takahiro.akashi@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 8:28=E2=80=AFAM Oleksii Moisieiev
<Oleksii_Moisieiev@epam.com> wrote:

> +                keys_pins: keys-pins {
> +                    pins =3D "GP_5_17", "GP_5_20", "GP_5_22", "GP_2_1";
> +                    bias-pull-up;
> +                };

This is kind of interesting and relates to my question about naming groups =
and
functions of GPIO pins.

Here we see four pins suspiciously named "GP_*" which I read as
"generic purpose"
and they are not muxed to *any* function, yes pulled up.

I would have expected something like:

keys_pins: keys-pins {
  groups =3D "GP_5_17_grp", "GP_5_20_grp", "GP_5_22_grp", "GP_2_1_grp";
  function =3D "gpio";
  pins =3D "GP_5_17", "GP_5_20", "GP_5_22", "GP_2_1";
  bias-pull-up;
};

I hope this illustrates what I see as a problem in not designing in
GPIO as an explicit
function, I get the impression that these pins are GPIO because it is hardw=
are
default.

Yours,
Linus Walleij
