Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3327BEDFF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378853AbjJIWDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378742AbjJIWDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:03:01 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F60E9E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 15:03:00 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9b2cee40de8so1088856866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 15:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696888978; x=1697493778; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rjq4mQ6ok9vbI4s2uRAhNlsstGCnbhA6GK5uk3ZBc6s=;
        b=NFeMzAoMSzzsP1enzdkmIpGu0Qse+EtYPLu7hlVLPxt02Bvxl+US8oTAZrjFQBnQOs
         A1vYYUWh181x+CgskiqIiyB4xifCziqGX6bQqTXvVkAKIZ5K2cwIV0CC5LCnHDg3b8Xz
         8wOEG8fRDLX1MQorBfKSXMsyQi9N+ks+GQN1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696888978; x=1697493778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rjq4mQ6ok9vbI4s2uRAhNlsstGCnbhA6GK5uk3ZBc6s=;
        b=qJLyRknkK3+DkNvLtcbexaGCX9u3J305s8gYDY2oadfYOViVfQu9FVBjUDXizu7edV
         gtrVW9h6PmHTC0fGMmBvZ0cEi8udAqH/w06DFHnEv2JWm1LhXcBLJk7llJCB7SlMQgqB
         zMEaCLfMg0mwsZ2pvUyS7dk2TqdBYzjA/yQjtpNLT3Nc3eUKJtcdbDdzIliyqcAYZkeQ
         Gp5i2co0L83g8dI/61mhH7tFxI3a+Y7q027adcwn5hZFf6hTLASWfqZmZw8Oug5lvJTA
         cjZbaPLFmPeozKIyP0Qn+zI16IsuOTYQdOCmeh43J7wuhkbAGAOznTDqdwfBaXXOPOxc
         dfXw==
X-Gm-Message-State: AOJu0YzGFeJCIf8VyNfqUhda6qJLdJtk6HSkXYqpv1OjrAU/vuCv2gY3
        s2o9sLQdnec8++zZgxkKo05ebgDSVP7e477L80fAYg==
X-Google-Smtp-Source: AGHT+IEtqWvxQ0Vgm+Jr6dpgRLt/9LzEMO9okKuLlajtYR50GrEGRE87hGyzUOZ2jPFoAGYSrwhOp2INK3c35n2NsdE=
X-Received: by 2002:a17:906:af10:b0:9ad:8a9e:23ee with SMTP id
 lx16-20020a170906af1000b009ad8a9e23eemr11254081ejb.13.1696888978460; Mon, 09
 Oct 2023 15:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231009201005.1964794-1-sjg@chromium.org> <20231009201005.1964794-2-sjg@chromium.org>
 <169688631230.3255827.3268332902446136449.robh@kernel.org>
In-Reply-To: <169688631230.3255827.3268332902446136449.robh@kernel.org>
From:   Simon Glass <sjg@chromium.org>
Date:   Mon, 9 Oct 2023 16:02:40 -0600
Message-ID: <CAPnjgZ3-eX5r02K_499wz3dQOs8nOO5o16CL9w1xyNsTXL0L2A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: mtd: binman-partition: Add binman compatibles
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, Michael Walle <mwalle@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, 9 Oct 2023 at 15:18, Rob Herring <robh@kernel.org> wrote:
>
>
> On Mon, 09 Oct 2023 14:10:00 -0600, Simon Glass wrote:
> > Add two compatible for binman entries, as a starting point for the
> > schema.
> >
> > Note that, after discussion on v2, we decided to keep the existing
> > meaning of label so as not to require changes to existing userspace
> > software when moving to use binman nodes to specify the firmware
> > layout.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Drop fixed-partitions from the example
> > - Use compatible instead of label
> >
> > Changes in v2:
> > - Use plain partition@xxx for the node name
> >
> >  .../mtd/partitions/binman-partition.yaml      | 48 +++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml: properties:compatible:items: {'enum': ['u-boot', 'atf-bl31']} is not of type 'array'
>         from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231009201005.1964794-2-sjg@chromium.org
>
> The base for the series is generally the latest rc1. A different dependency
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
> your schema. However, it must be unset to test all examples with your schema.
>

Oh dear, I didn't notice that output but I see it now. Could the check
return a non-zero exit code if something goes wrong?

Anyway, I'll send v4

Regards,
Simon
