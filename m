Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDB77B216D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjI1PeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjI1PeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:34:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B968AC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:34:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42B9C433C7;
        Thu, 28 Sep 2023 15:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695915248;
        bh=yA76syt11xoVYZH5ZXAc4jjHZzjxXGFWQox/+TwdtGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e7++/EvD/zl1p9E3yKa04t1fUV4yLxO8C7UxcnHrByAekjaUi9bu7YZhTGHfM7luN
         g3AIv91+AP9cYAfxv31DNVdiUsJDO1ThGJ0r9eXoIFKr4v337a5i3emODm+FumyudW
         BGM+dxJAWWZDgrmWycs7SL4Ml1i9QBKmJvRIcgt0xrcsXK7Oqv39qTXwlPA9exXok5
         w2kkteeMEwr/xTwJQ7ST45SJcnRWsx+RkKiEi/m+JYlVgps1iEDXLs+kjLyEj4eff/
         3O2dZ43XosV1NY3nMmgVVjZE9t5Re7Psm9O42wShXzfXl4MzXi5SnyjDloHnQJvdWL
         fuh+gVtYnqwXQ==
Received: (nullmailer pid 550608 invoked by uid 1000);
        Thu, 28 Sep 2023 15:34:05 -0000
Date:   Thu, 28 Sep 2023 10:34:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH] dt-bindings: arm,psci: Add missing unevaluatedProperties
 on child node schemas
Message-ID: <169591524261.550509.6355253200951423376.robh@kernel.org>
References: <20230926164553.102914-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926164553.102914-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 26 Sep 2023 11:45:44 -0500, Rob Herring wrote:
> Just as unevaluatedProperties or additionalProperties are required at
> the top level of schemas, they should (and will) also be required for
> child node schemas. That ensures only documented properties are
> present for any node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/psci.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!

