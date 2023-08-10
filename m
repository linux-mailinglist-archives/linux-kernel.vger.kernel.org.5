Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EA7776F78
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjHJFTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHJFTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:19:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EF1E69;
        Wed,  9 Aug 2023 22:19:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F8F2641BD;
        Thu, 10 Aug 2023 05:19:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB0CC433C8;
        Thu, 10 Aug 2023 05:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691644791;
        bh=QFLn9h6VVqEtBTfV9feFjjdqKBnNT2qBS7HxC5a7oAQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=j9FVtT/Od5QMEUU2RYij7kdF6SSg0bLa4y/zzyk9p4ZDWPXUfVnBk5rYLSTMOv0s1
         5HIzz0ipQelpGnv6/J0+ovbk2GNKWuvyhymRavO9NN5jsZ9qW/kDrNFdgzFmGeppe1
         tupoAnTVk/pQ+1i239l5jtwTgDDCegP3L0q9HTwEIpPtHXVrsYTMgBttUGWPJpI1ft
         8ozeCWFTCOYxRp6gPyMJDQpbH4JDjZG0IjxKh3HDfxbzYmj983eNpi8nmz8qEqCaVz
         AUY3NtAePy7JFG4RVE2g4hvoMkisUXQwI/tgT1eZ8vJ7i1o35hw7wEimC5lR/3H4sW
         UNEov5PNJCcUA==
Received: (nullmailer pid 3706279 invoked by uid 1000);
        Thu, 10 Aug 2023 05:19:50 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20230810045314.2676833-2-vigneshr@ti.com>
References: <20230810045314.2676833-1-vigneshr@ti.com>
 <20230810045314.2676833-2-vigneshr@ti.com>
Message-Id: <169164479003.3706263.2577852836283634822.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: arm: ti: Add bindings for AM62P5 SoCs
Date:   Wed, 09 Aug 2023 23:19:50 -0600
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Aug 2023 10:23:12 +0530, Vignesh Raghavendra wrote:
> From: Bryan Brattlof <bb@ti.com>
> 
> Add bindings for TI's AM62P5 family of devices.
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230810045314.2676833-2-vigneshr@ti.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

