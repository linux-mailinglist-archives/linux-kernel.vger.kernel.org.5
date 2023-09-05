Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56BE792BD6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241142AbjIERBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354896AbjIEPfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 11:35:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6BB133;
        Tue,  5 Sep 2023 08:35:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A72660A1D;
        Tue,  5 Sep 2023 15:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D84C433C7;
        Tue,  5 Sep 2023 15:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693928130;
        bh=xOSL6yYjiLcHcyG/8cCVGMIG/NpsWnq3fQuWh4NECP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BRLubsjzzO3t7dANy45kF0GwDU0fizq/mRFrtJYJX+vh2UkxKzPmUpG3Xcg2oGbLn
         b7pK4K3YO6Jgrn7Ei+VLwlp4wmBaP2PPF/pXOnK/XSf5hnA4jvWo/IXFerSpXkysA/
         O+Pfgtxe3PVy79GaLtZ5PxWUOArAEKZqoWyxro+11S81thKzaSVaFvc4jOVv2TYqhe
         5shVS6Rk1/daJZ0ygMbsDFuGjGvhjeasp8jxt+XoTaxfblZCP2b0gS7HjHVFrecIfN
         LDM0i0pBxa8BrPrbD8nbpeQA6KdEF8CDtuPsZh7bcqeCMOpp+vhn7sgbh7Yb8pUqYB
         LiYztYNUw1+/w==
Received: (nullmailer pid 3432654 invoked by uid 1000);
        Tue, 05 Sep 2023 15:35:28 -0000
Date:   Tue, 5 Sep 2023 10:35:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Linu Cherian <lcherian@marvell.com>, mike.leach@linaro.org,
        james.clark@arm.com, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        sgoutham@marvell.com, gcherian@marvell.com
Subject: Re: [RFC PATCH v3 1/7] dt-bindings: arm: coresight-tmc: Add
 "memory-region" property
Message-ID: <20230905153528.GA3428758-robh@kernel.org>
References: <20230904050548.28047-1-lcherian@marvell.com>
 <20230904050548.28047-2-lcherian@marvell.com>
 <59bf237d-1645-8c44-94f2-72a0cf229595@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59bf237d-1645-8c44-94f2-72a0cf229595@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 09:26:49AM +0100, Suzuki K Poulose wrote:
> On 04/09/2023 06:05, Linu Cherian wrote:
> > memory-region 0: Reserved trace buffer memory
> > 
> >    TMC ETR: When available, use this reserved memory region for
> >    trace data capture. Same region is used for trace data
> >    retention after a panic or watchdog reset.
> > 
> >    TMC ETF: When available, use this reserved memory region for
> >    trace data retention synced from internal SRAM after a panic or
> >    watchdog reset.
> > 
> > memory-region 1: Reserved meta data memory
> > 
> >    TMC ETR, ETF: When available, use this memory for register
> >    snapshot retention synced from hardware registers after a panic
> >    or watchdog reset.
> 
> Instead of having to use a number to map the memory regions, could
> we use
> 
> memory-region-names property to describe the index ? That way it
> is much easier to read and is less error prone.

You can, but the order should still be defined.

> Names could be something like:
> 
> tmc-reserved-trace
> tmc-reserved-metadata

Names are local to the binding. So 'tmc' is redundant. And everything is 
a reserved region for 'memory-region', so that's redundant too.

Rob
