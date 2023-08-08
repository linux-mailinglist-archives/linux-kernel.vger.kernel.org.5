Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6525774A3A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjHHUXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjHHUWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:22:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4201CCDC;
        Tue,  8 Aug 2023 12:31:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2859B62AD0;
        Tue,  8 Aug 2023 19:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CF7C433C8;
        Tue,  8 Aug 2023 19:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691523062;
        bh=J7RrIowQ/RhLdZr79lNCXj2Xv8FU5WymsyiVAl5loJM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DmxbfSKUiCSyowjkmO3Qw37R4UyDsbZ7icgbNoPkhZPh+ldKpBVzJZ5hWqt5YNkL+
         jxLxhwjmAyzN5I/Qn7V2jC5AYjLQ2STSeqYvTsXygafWyM/kR1wXCnvclZ4E4IYVOK
         hBG2pSOEQrRUjZg/dZoE2TB4cwfFhQ8OY/ksD35ofITWbH6UtSNAJsVs3VLdrcz56D
         DNqTuclzIOR5ILsIx+By9hmkVrLjKResPKJFA3AGEGMyosST1+LHQSOITOLNl+sQ19
         lbb8/fN/hx5Jca20iOBJLw5eeN8Pp9x7DeJaGixeiYOcIwTSt+k3MR0nNHWBQI0YgG
         N9ut5WPzV8H3g==
Received: (nullmailer pid 4099639 invoked by uid 1000);
        Tue, 08 Aug 2023 19:31:00 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
In-Reply-To: <094e68da59bbd9efea1469b122f34f5dcf156f0f.1691510312.git.daniel@makrotopia.org>
References: <cover.1691510312.git.daniel@makrotopia.org>
 <094e68da59bbd9efea1469b122f34f5dcf156f0f.1691510312.git.daniel@makrotopia.org>
Message-Id: <169152306059.4099622.15085616978235620512.robh@kernel.org>
Subject: Re: [PATCH v3 1/8] dt-bindings: mtd: add basic bindings for UBI
Date:   Tue, 08 Aug 2023 13:31:00 -0600
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 08 Aug 2023 17:03:19 +0100, Daniel Golle wrote:
> Add basic bindings for UBI devices and volumes.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../bindings/mtd/partitions/linux,ubi.yaml    | 65 +++++++++++++++++++
>  .../bindings/mtd/partitions/ubi-volume.yaml   | 35 ++++++++++
>  2 files changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/linux,ubi.yaml
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml:29:5: [warning] wrong indentation: expected 6 but found 4 (indentation)
./Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml:32:5: [warning] wrong indentation: expected 6 but found 4 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/094e68da59bbd9efea1469b122f34f5dcf156f0f.1691510312.git.daniel@makrotopia.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

