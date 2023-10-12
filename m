Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D527C635A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376666AbjJLDli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbjJLDlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:41:35 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0936B7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 20:41:32 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50433d8385cso791251e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 20:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697082091; x=1697686891; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UqD/7t0pHiD/A1D+TVC0jVRhUdy6D5qb2bjFC/PdJc4=;
        b=LwybIaBfOMlqH2cXmb+Kx6ayznjb8Tf8zWvMsOeWUXSAKiDjsHxlRdjj7h8QH4H59U
         B6YaMwoP9cY2RF+BJoj4GW37lvjMmayX5dozcSHrNe2VpTMgmqrGW+gaCTjw+N80OH79
         Sq68cof+tgqI2k+7mI1E3UPK7eceJFq9rwWwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082091; x=1697686891;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UqD/7t0pHiD/A1D+TVC0jVRhUdy6D5qb2bjFC/PdJc4=;
        b=gxbo2HvcmjGveFV0RgLIUq/PDODWbHpVF1SQ2nq6dQ7SM2f4BmAqDNH8/zq4wBmH59
         9F64uB+IXT1+sBTBCPmqmJDLoiD+wKJ3xpx/d0V5BRq2LX77J9oqB+c2uGFjOjYjGvxQ
         piyKali84Q99Pwjo+rdfjVP41C5aqY+LBhLJgXRmtjN7zdUX52oSQt7CGJQLg0FHHFyh
         2NwajgIjA3QfkI9eBV3MKIrChN/x309Fac8eIpdcOvGFbcNfRAnS45P1uIiy+pf2bzNl
         KscU4YUm2q05NZ+KT6murCNrbIhn3tLCgqBodFqPYLjX17oFywD3Nn7NKpFCtSyXI99C
         cOmA==
X-Gm-Message-State: AOJu0YwHZldlwVHjqfyrHSSFIoUayToRsYBlBXDNTAdF2UKw8fECg6NW
        uMBiUMPim9dwCkxEbLpOjIN/uNxeeDGJh7ArhdeD4g==
X-Google-Smtp-Source: AGHT+IGjcdHHqUks4N3VBxCSI9q5rZhvus8FmGXhe4gZvXBEhWqxZiJ8sEB9S33VnjgEGWvOwy3ON0YBJKirqAyhjiM=
X-Received: by 2002:a19:a414:0:b0:502:a55b:c2d7 with SMTP id
 q20-20020a19a414000000b00502a55bc2d7mr19256311lfc.60.1697082090831; Wed, 11
 Oct 2023 20:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231009201005.1964794-1-sjg@chromium.org> <20231009201005.1964794-2-sjg@chromium.org>
 <169688631230.3255827.3268332902446136449.robh@kernel.org>
 <CAPnjgZ3-eX5r02K_499wz3dQOs8nOO5o16CL9w1xyNsTXL0L2A@mail.gmail.com> <20231010170600.GA1046256-robh@kernel.org>
In-Reply-To: <20231010170600.GA1046256-robh@kernel.org>
From:   Simon Glass <sjg@chromium.org>
Date:   Wed, 11 Oct 2023 20:40:58 -0700
Message-ID: <CAPnjgZ1dX9QUJ1cv4z8k1ptyWm2sk=ax_8vQzYUs5erA+VJ7bg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: mtd: binman-partition: Add binman compatibles
To:     Rob Herring <robh@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
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

On Tue, 10 Oct 2023 at 11:06, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Oct 09, 2023 at 04:02:40PM -0600, Simon Glass wrote:
> > Hi Rob,
> >
> > On Mon, 9 Oct 2023 at 15:18, Rob Herring <robh@kernel.org> wrote:
> > >
> > >
> > > On Mon, 09 Oct 2023 14:10:00 -0600, Simon Glass wrote:
> > > > Add two compatible for binman entries, as a starting point for the
> > > > schema.
> > > >
> > > > Note that, after discussion on v2, we decided to keep the existing
> > > > meaning of label so as not to require changes to existing userspace
> > > > software when moving to use binman nodes to specify the firmware
> > > > layout.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > Changes in v3:
> > > > - Drop fixed-partitions from the example
> > > > - Use compatible instead of label
> > > >
> > > > Changes in v2:
> > > > - Use plain partition@xxx for the node name
> > > >
> > > >  .../mtd/partitions/binman-partition.yaml      | 48 +++++++++++++++++++
> > > >  1 file changed, 48 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
> > > >
> > >
> > > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > >
> > > yamllint warnings/errors:
> > >
> > > dtschema/dtc warnings/errors:
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml: properties:compatible:items: {'enum': ['u-boot', 'atf-bl31']} is not of type 'array'
> > >         from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
> > >
> > > doc reference errors (make refcheckdocs):
> > >
> > > See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231009201005.1964794-2-sjg@chromium.org
> > >
> > > The base for the series is generally the latest rc1. A different dependency
> > > should be noted in *this* patch.
> > >
> > > If you already ran 'make dt_binding_check' and didn't see the above
> > > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > > date:
> > >
> > > pip3 install dtschema --upgrade
> > >
> > > Please check and re-submit after running the above command yourself. Note
> > > that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> > > your schema. However, it must be unset to test all examples with your schema.
> > >
> >
> > Oh dear, I didn't notice that output but I see it now. Could the check
> > return a non-zero exit code if something goes wrong?
>
> No, because things go wrong too often and then it breaks for everyone.
> It's better now, but only because of the above reports and 3
> maintainers.
>
> Also, it is not fatal. The schemas are checked against the DT
> meta-schema, but are used for validation if they pass just draft2019-09
> meta-schema. That allows new DT meta-schema checks to not start
> excluding previously used schema.

OK I see. Another suggestion would be to remove non-warning output.
Perhaps I can do that with make -s though.

Regards,
Simon
