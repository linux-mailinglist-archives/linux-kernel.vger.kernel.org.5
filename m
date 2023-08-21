Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2A1782F75
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbjHURb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjHURb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:31:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9652102;
        Mon, 21 Aug 2023 10:31:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 561266349A;
        Mon, 21 Aug 2023 17:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA5AC433C7;
        Mon, 21 Aug 2023 17:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692639084;
        bh=h20Kkl5UnPX7qAyLV9K3yW7xdsP/ZAcy7V8OZ5SeLEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZLvhkTSUncZ/bD8I/q4eCrfRw0ElcvysAb0wVtfvPIRt5Hhwm8m2mH50uIl7AwQao
         NPAj4HxoCBw216Ug2JMTsUydXHuAw096mCXLPHQe+Lld2np/zhZu64wP/SqC8WVqsB
         mslia/bHKMgDJReVCvatiIeFXXBBpJ6GkzZPpzk+anUr5yG1jDep2DtRDWQs0yl/74
         Uxi27CM0ds8gfvRiizbaQPQRCNDc+M72diw5VgzElBvRhpZ52oXq8DGqr0+J0lyVKH
         8Jp9c9d3JJA8GVM5dtZmLbA/XszwkNUNs5rNYkxt5GxIc/e4l6m1vQzdcDpeOfXVDz
         HshgJrHoyRIjw==
Received: (nullmailer pid 2000677 invoked by uid 1000);
        Mon, 21 Aug 2023 17:31:22 -0000
Date:   Mon, 21 Aug 2023 12:31:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/8] dt-bindings: mtd: add basic bindings for UBI
Message-ID: <169263908218.2000617.16931192155432403196.robh@kernel.org>
References: <cover.1691717480.git.daniel@makrotopia.org>
 <a640bb10e6fbaeef96efdb9e8b666ca39e993589.1691717480.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a640bb10e6fbaeef96efdb9e8b666ca39e993589.1691717480.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Aug 2023 02:36:37 +0100, Daniel Golle wrote:
> Add basic bindings for UBI devices and volumes.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../bindings/mtd/partitions/linux,ubi.yaml    | 65 +++++++++++++++++++
>  .../bindings/mtd/partitions/ubi-volume.yaml   | 36 ++++++++++
>  2 files changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/linux,ubi.yaml
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

