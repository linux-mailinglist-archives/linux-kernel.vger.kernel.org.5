Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCA575C48C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjGUKWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjGUKWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:22:23 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECC11BC6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 03:22:04 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9338e4695so26228931fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 03:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1689934922; x=1690539722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxVmtQm/ZVv5K9DrQOwOkHFTyBtIAYOXtvCWxUgjA74=;
        b=VYCNg3MWqBhV0rrnZ4eCqGKkdraSAGGfKAHtHrw1d1kk/fxMIQnRbFcNqZXCnRzhcc
         NFj8DvTJki85TS09fL+eXJnAp+q+eFJx6WCvJPjv++epMe4yZ7JWbSa3UWnR4PgnOrfP
         4TEtNDNfkJLFdogZZFTlwlUWzkWiJH2TS67aSMzR/ySgkhXRvs89z+oCy7eZumBazAxK
         l+o9a1UPCA9itUhpDMk5uk9CCvVwwjBnRDoWCyW9678ahsiNV+TKOz16es0ufmY2zINp
         ZyhyM3lK6rnPFBhujMMpbCX1F1xQFZ0ZUd4FMUgeBklLf6LbH93bzZMWbVo8QL0XLGCt
         mJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689934922; x=1690539722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxVmtQm/ZVv5K9DrQOwOkHFTyBtIAYOXtvCWxUgjA74=;
        b=ChIxHw1xNybZSjd1qEL8XpR6TDOeWdkZ/kURBn5yYn3+yLmfDO6MjQPslPFeRiHE9/
         23bVe6/UXnGVhXUOZSbXK1WxGwXuF7M7BwY8gLsUf9plXnzltHyR7ZWt1UJlqDy4ELWJ
         krreyf8tm/TllV85lAdHQeK7cIdvRLSR3Pv6yGhPwN15FA2UDvc6VpBTa9dMjcjxguXK
         CqCY89YpSN5h7J8IBZirCaXlbr7BRf2pZt5UujWfWqy6EhzYQlXhQ7P7Wp/ORU9CnbSI
         RmcpiSHopGAk2R4xI5olaYyICZRlsXnJ3lmu0mUuf8KIl4RPpYuJnycuPGWU0SZcO0E4
         d5TA==
X-Gm-Message-State: ABy/qLYlOiev+SH1YTPkeZFjvm1Onw5ny9NSf4EtKmSF4jOukLPsh5ea
        WBc9uqw5n7OBHh+aWe3q8GZYVYwUMkyJ8UBjIpTG9KCP5B832OR/y6Q=
X-Google-Smtp-Source: APBJJlEnfn2CyQE7RRECV1eet0UG+/RZjeI7wBnNU19WbWWj7JWS74AIW1DnxGzdG5eMrvNjAD0WdNJ6C4yr2hli6h8=
X-Received: by 2002:a2e:9650:0:b0:2b6:e536:a2a9 with SMTP id
 z16-20020a2e9650000000b002b6e536a2a9mr1425579ljh.47.1689934921889; Fri, 21
 Jul 2023 03:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230720135125.21240-1-eric.lin@sifive.com> <20230720135125.21240-2-eric.lin@sifive.com>
 <168986442455.2635362.6562546888592020035.robh@kernel.org>
In-Reply-To: <168986442455.2635362.6562546888592020035.robh@kernel.org>
From:   Eric Lin <eric.lin@sifive.com>
Date:   Fri, 21 Jul 2023 18:21:50 +0800
Message-ID: <CAPqJEFrcX08cjbmaRBtr5-vgeOmkknTDbx0-xG+0JO+qdhDCQg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: riscv: sifive: Add SiFive Private L2
 cache controller
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, Jul 20, 2023 at 10:47=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
>
> On Thu, 20 Jul 2023 21:51:19 +0800, Eric Lin wrote:
> > This add YAML DT binding documentation for SiFive Private L2
> > cache controller
> >
> > Signed-off-by: Eric Lin <eric.lin@sifive.com>
> > Reviewed-by: Zong Li <zong.li@sifive.com>
> > Reviewed-by: Nick Hu <nick.hu@sifive.com>
> > ---
> >  .../bindings/cache/sifive,pl2cache.yaml       | 62 +++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/cache/sifive,pl2c=
ache.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
ache/sifive,ccache0.example.dtb: cache-controller@2010000: compatible:0: 's=
ifive,pl2cache1' was expected
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
ache/sifive,ccache0.example.dtb: cache-controller@2010000: 'interrupts', 'm=
emory-region' do not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/o=
pp/opp-v2-kryo-cpu.example.dtb: l2-cache: compatible:0: 'sifive,pl2cache1' =
was expected
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/o=
pp/opp-v2-kryo-cpu.example.dtb: l2-cache: compatible: ['cache'] is too shor=
t
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/o=
pp/opp-v2-kryo-cpu.example.dtb: l2-cache: 'cache-block-size' is a required =
property
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/o=
pp/opp-v2-kryo-cpu.example.dtb: l2-cache: 'cache-sets' is a required proper=
ty
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/o=
pp/opp-v2-kryo-cpu.example.dtb: l2-cache: 'cache-size' is a required proper=
ty
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/o=
pp/opp-v2-kryo-cpu.example.dtb: l2-cache: 'reg' is a required property
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/o=
pp/opp-v2-kryo-cpu.example.dtb: l2-cache: compatible:0: 'sifive,pl2cache1' =
was expected
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/o=
pp/opp-v2-kryo-cpu.example.dtb: l2-cache: compatible: ['cache'] is too shor=
t
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/o=
pp/opp-v2-kryo-cpu.example.dtb: l2-cache: 'cache-block-size' is a required =
property
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/o=
pp/opp-v2-kryo-cpu.example.dtb: l2-cache: 'cache-sets' is a required proper=
ty
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/o=
pp/opp-v2-kryo-cpu.example.dtb: l2-cache: 'cache-size' is a required proper=
ty
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/o=
pp/opp-v2-kryo-cpu.example.dtb: l2-cache: 'reg' is a required property
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/t=
hermal/thermal-cooling-devices.example.dtb: l2-cache: compatible:0: 'sifive=
,pl2cache1' was expected
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/t=
hermal/thermal-cooling-devices.example.dtb: l2-cache: compatible: ['cache']=
 is too short
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/t=
hermal/thermal-cooling-devices.example.dtb: l2-cache: 'cache-block-size' is=
 a required property
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/t=
hermal/thermal-cooling-devices.example.dtb: l2-cache: 'cache-sets' is a req=
uired property
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/t=
hermal/thermal-cooling-devices.example.dtb: l2-cache: 'cache-size' is a req=
uired property
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/t=
hermal/thermal-cooling-devices.example.dtb: l2-cache: 'reg' is a required p=
roperty
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/t=
hermal/thermal-cooling-devices.example.dtb: l2-cache: 'l3-cache' does not m=
atch any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/t=
hermal/thermal-cooling-devices.example.dtb: l3-cache: compatible:0: 'sifive=
,pl2cache1' was expected
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/t=
hermal/thermal-cooling-devices.example.dtb: l3-cache: compatible: ['cache']=
 is too short
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/t=
hermal/thermal-cooling-devices.example.dtb: l3-cache: 'cache-block-size' is=
 a required property
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/t=
hermal/thermal-cooling-devices.example.dtb: l3-cache: 'cache-sets' is a req=
uired property
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/t=
hermal/thermal-cooling-devices.example.dtb: l3-cache: 'cache-size' is a req=
uired property
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/t=
hermal/thermal-cooling-devices.example.dtb: l3-cache: 'reg' is a required p=
roperty
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible:0: 'sifive,pl2cach=
e1' was expected
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible: ['cache'] is too =
short
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-block-size' is a requi=
red property
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-sets' is a required pr=
operty
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-size' is a required pr=
operty
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'reg' is a required property
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'l3-cache' does not match any=
 of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l3-cache: compatible:0: 'sifive,pl2cach=
e1' was expected
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l3-cache: compatible: ['cache'] is too =
short
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l3-cache: 'cache-block-size' is a requi=
red property
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l3-cache: 'cache-sets' is a required pr=
operty
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l3-cache: 'cache-size' is a required pr=
operty
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l3-cache: 'reg' is a required property
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible:0: 'sifive,pl2cach=
e1' was expected
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible: ['cache'] is too =
short
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-block-size' is a requi=
red property
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-sets' is a required pr=
operty
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-size' is a required pr=
operty
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'reg' is a required property
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible:0: 'sifive,pl2cach=
e1' was expected
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible: ['cache'] is too =
short
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-block-size' is a requi=
red property
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-sets' is a required pr=
operty
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-size' is a required pr=
operty
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'reg' is a required property
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible:0: 'sifive,pl2cach=
e1' was expected
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible: ['cache'] is too =
short
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-block-size' is a requi=
red property
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-sets' is a required pr=
operty
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-size' is a required pr=
operty
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'reg' is a required property
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible:0: 'sifive,pl2cach=
e1' was expected
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible: ['cache'] is too =
short
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-block-size' is a requi=
red property
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-sets' is a required pr=
operty
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-size' is a required pr=
operty
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'reg' is a required property
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible:0: 'sifive,pl2cach=
e1' was expected
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible: ['cache'] is too =
short
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-block-size' is a requi=
red property
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-sets' is a required pr=
operty
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-size' is a required pr=
operty
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'reg' is a required property
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible:0: 'sifive,pl2cach=
e1' was expected
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible: ['cache'] is too =
short
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-block-size' is a requi=
red property
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-sets' is a required pr=
operty
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-size' is a required pr=
operty
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'reg' is a required property
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible:0: 'sifive,pl2cach=
e1' was expected
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible: ['cache'] is too =
short
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-block-size' is a requi=
red property
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-sets' is a required pr=
operty
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-size' is a required pr=
operty
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/c=
pufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'reg' is a required property
>         from schema $id: http://devicetree.org/schemas/cache/sifive,pl2ca=
che.yaml#
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202307=
20135125.21240-2-eric.lin@sifive.com
>
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>

Sorry for the errors. I forgot to run `make dt_binding_check`.
I'll fix it in the next version. Thanks for the review.

Best regards,
Eric Lin
