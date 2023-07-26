Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51FE7637EA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbjGZNpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjGZNpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:45:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC5FA2;
        Wed, 26 Jul 2023 06:45:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 849F961AB8;
        Wed, 26 Jul 2023 13:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05A5C433CD;
        Wed, 26 Jul 2023 13:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690379138;
        bh=FOQK4XupUueLaNuwpuP0faSyRRZ9Ava/fzIG0kPjV6s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VQ1uGrM8ufwEpC/UFWp8UzjNmqbvFqIsLch0zqvicmfaxseB037IDLW7WoNqO32cu
         kg+Fhg8k4ilIfkc3JNyAWklI7ymMQjIXcURrst1dTdy6TIyqbwtPZcEaOrWk+/JY0/
         6XxCF4rVeYnmq7ozKou5MEmI4fVZe42/Gb/CJ2HeJqGs//iuGL9CF8HT+SkQNH80uM
         mlXwqFkXiDJKkvO6Z4jWQvX2LI3JUXrOAGI3Ji1nNGxUqXWxW9Xn6+hUaE4k6BvCUb
         hHNNqlR4O5BvW6Q+WdZglqJxYzONVdwAwqXrxTDTGzmfBel5S2+R6SxXX8y0S/IjMe
         cei8RgORE71QQ==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b93fba1f62so99636431fa.1;
        Wed, 26 Jul 2023 06:45:38 -0700 (PDT)
X-Gm-Message-State: ABy/qLacKGHI7dsLoTjbyyN3vh70sW3F/E+HmM8vvaVECFvF3iX3ToE0
        wpPuX8FbuCmOtRxz0Ste3cNcZxHuH43WzYLsbg==
X-Google-Smtp-Source: APBJJlHtGl5j2c/e/mnOniJPq+lRHYhMLejBouuRyKWw85jTV/364HGUPhNajn5iaUQM6XiYkevkAJ/FVEAJkjl8aT4=
X-Received: by 2002:a2e:3c09:0:b0:2b6:e625:ba55 with SMTP id
 j9-20020a2e3c09000000b002b6e625ba55mr1536023lja.41.1690379136685; Wed, 26 Jul
 2023 06:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230724223057.1208122-1-quic_eberman@quicinc.com>
 <20230724223057.1208122-4-quic_eberman@quicinc.com> <20230724232328.GA1101352-robh@kernel.org>
 <0e72a1a0-611c-9667-866e-a4a1f67f10f6@quicinc.com>
In-Reply-To: <0e72a1a0-611c-9667-866e-a4a1f67f10f6@quicinc.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 26 Jul 2023 07:45:24 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+wJbp7-xoUqorkoieLcxRVnEKDeFNYtdZQdBTg3gWSew@mail.gmail.com>
Message-ID: <CAL_Jsq+wJbp7-xoUqorkoieLcxRVnEKDeFNYtdZQdBTg3gWSew@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] dt-bindings: power: reset: Document arm,psci-vendor-reset
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@quicinc.com,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Prasad Sodagudi <quic_psodagud@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 12:01=E2=80=AFPM Elliot Berman <quic_eberman@quicin=
c.com> wrote:
>
>
>
> On 7/24/2023 4:23 PM, Rob Herring wrote:
> > On Mon, Jul 24, 2023 at 03:30:53PM -0700, Elliot Berman wrote:
> >> Add devicetree bindings for using PSCI SYSTEM_RESET2 with vendor reset=
  types.
> >>
> >> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> >> ---
> >>   .../power/reset/arm,psci-vendor-reset.yaml    | 35 +++++++++++++++++=
++
> >>   MAINTAINERS                                   |  1 +
> >>   2 files changed, 36 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/power/reset/arm=
,psci-vendor-reset.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/power/reset/arm,psci-ve=
ndor-reset.yaml b/Documentation/devicetree/bindings/power/reset/arm,psci-ve=
ndor-reset.yaml
> >> new file mode 100644
> >> index 000000000000..18b0b8c167a1
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/power/reset/arm,psci-vendor-re=
set.yaml
> >> @@ -0,0 +1,35 @@
> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >> +# Copyright 2023 Qualcomm Innovation Center, Inc. All Rights Reserved=
.
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/power/reset/arm,psci-vendor-reset.=
yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: PSCI SYSTEM_RESET2 Vendor Resets
> >> +
> >> +maintainers:
> >> +  - Elliot Berman <quic_eberman@quicinc.com>
> >> +
> >> +description: |
> >> +  PSCI SYSTEM_RESET2 supports vendor-defined reset types. This descri=
bes
> >> +  the conversion of reboot modes to the reset types.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: arm,psci-vendor-reset
> >> +
> >> +allOf:
> >> +  - $ref: reboot-mode.yaml#
> >> +
> >> +additionalProperties: false
> >> +
> >> +examples:
> >> +  - |
> >> +    firmware {
> >> +      psci-vendor-resets {
> >> +        compatible =3D "arm,psci-vendor-reset";
> >
> > We already have a node for PSCI, we don't need a second one. You can
> > have a separate driver without a separate node.
> >
>
> I could also place the reboot-mode functionality straight into
> drivers/firwmare/psci/? I thought that might be more controversial than
> separate driver, but maybe not?
>
> Mark/Loreno, do you have any concerns to add the reboot-mode driver
> functionality directly in drivers/firmware/psci/psci.c?

I'm talking about the binding. Why are you talking about driver
design? They are independent.

Rob
