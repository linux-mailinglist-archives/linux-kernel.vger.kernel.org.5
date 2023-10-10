Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2267C0238
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbjJJRGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjJJRG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:06:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F1211B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:06:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EF4C433C7;
        Tue, 10 Oct 2023 17:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696957563;
        bh=fQxhBhW+tBsI74bpxoq2WhIg3iV6j9PgVFhC0vGwcw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DyA6xxGAjMcq+pqRbop6Hl9L/a7izNrQx+URxcKHk4934m/rfCpF63VFp05pP7x8t
         oYV5j5bsLcXaK5nEP1CSnbk8TEubM0pjGVGBuDee6xu5DV7Gr21jNks+xxnIEDqSbN
         l5lHI+PA3HtR260Migd0jbiU0L+XaziHQezq21xNdTpiHcMtB3twWogwuHGGwxauBz
         ApJxqcjeKTyfLyunkMYYurP+MRGg5Wp2VzbZJ7GiNVpHXbGE4ZtWm9gV3JbmtWAdKA
         nH7/wVJ1I0ZR8LQfvdlzZ7oxPNQaj38l9ZwSPll8kUSuuy9a1ggijHyDW3aSUBW7x2
         666ToubamQsOw==
Received: (nullmailer pid 1059527 invoked by uid 1000);
        Tue, 10 Oct 2023 17:06:00 -0000
Date:   Tue, 10 Oct 2023 12:06:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Simon Glass <sjg@chromium.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, Michael Walle <mwalle@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: mtd: binman-partition: Add binman
 compatibles
Message-ID: <20231010170600.GA1046256-robh@kernel.org>
References: <20231009201005.1964794-1-sjg@chromium.org>
 <20231009201005.1964794-2-sjg@chromium.org>
 <169688631230.3255827.3268332902446136449.robh@kernel.org>
 <CAPnjgZ3-eX5r02K_499wz3dQOs8nOO5o16CL9w1xyNsTXL0L2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3-eX5r02K_499wz3dQOs8nOO5o16CL9w1xyNsTXL0L2A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 04:02:40PM -0600, Simon Glass wrote:
> Hi Rob,
> 
> On Mon, 9 Oct 2023 at 15:18, Rob Herring <robh@kernel.org> wrote:
> >
> >
> > On Mon, 09 Oct 2023 14:10:00 -0600, Simon Glass wrote:
> > > Add two compatible for binman entries, as a starting point for the
> > > schema.
> > >
> > > Note that, after discussion on v2, we decided to keep the existing
> > > meaning of label so as not to require changes to existing userspace
> > > software when moving to use binman nodes to specify the firmware
> > > layout.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v3:
> > > - Drop fixed-partitions from the example
> > > - Use compatible instead of label
> > >
> > > Changes in v2:
> > > - Use plain partition@xxx for the node name
> > >
> > >  .../mtd/partitions/binman-partition.yaml      | 48 +++++++++++++++++++
> > >  1 file changed, 48 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
> > >
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml: properties:compatible:items: {'enum': ['u-boot', 'atf-bl31']} is not of type 'array'
> >         from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
> >
> > doc reference errors (make refcheckdocs):
> >
> > See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231009201005.1964794-2-sjg@chromium.org
> >
> > The base for the series is generally the latest rc1. A different dependency
> > should be noted in *this* patch.
> >
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> >
> > pip3 install dtschema --upgrade
> >
> > Please check and re-submit after running the above command yourself. Note
> > that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> > your schema. However, it must be unset to test all examples with your schema.
> >
> 
> Oh dear, I didn't notice that output but I see it now. Could the check
> return a non-zero exit code if something goes wrong?

No, because things go wrong too often and then it breaks for everyone. 
It's better now, but only because of the above reports and 3 
maintainers.

Also, it is not fatal. The schemas are checked against the DT 
meta-schema, but are used for validation if they pass just draft2019-09 
meta-schema. That allows new DT meta-schema checks to not start 
excluding previously used schema.

Rob
