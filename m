Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B1A7842AF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236245AbjHVOAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbjHVOAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:00:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF9C1B2;
        Tue, 22 Aug 2023 07:00:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A96D620CE;
        Tue, 22 Aug 2023 14:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C28C433C7;
        Tue, 22 Aug 2023 14:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692712834;
        bh=KG71owANqSesNO82K0N9nUBO6sbhbJvKlfuv2Xu5edA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cWS3xjnTFzROLA2uYcq92WOMLwSlCK7YF99VUTC/C6k7I5uzOgUCqLSwGaWevLmUI
         s7SGSeMikCUE1Z0gWTCe8SKe+rajTV/tHKdmgA+S4hwWb9QscqKuQGWYpivhoh0R9c
         8z48Vtt+7CqWJbCOwCTWnz3u0EKdue+Yj0MBHAXIY4GXixkgE2hATgHaZRwwlZyzqb
         Q+SPezaiTJ7AfprjjceXygSRJxqjoKJdmMpRKAKckYAW4aTdVUrFqg6s8odVlszgGe
         3OlFF8Pk3Vi9MVzhOEKrVFm+XXRWNA7R87Dt8C9l+MUQTibA2oZ5nOf+x/uG6CeHaB
         HkROzJLzDSwQQ==
Date:   Tue, 22 Aug 2023 19:30:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the phy-next tree
Message-ID: <ZOS/fnjCOxoOBmHg@matsya>
References: <20230818154044.33b443a1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818154044.33b443a1@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-08-23, 15:40, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the phy-next tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/phy/qualcomm/phy-qcom-qmp-pcie.c:2378:38: error: redefinition of 'qmp_pcie_offsets_v5_20'
>  2378 | static const struct qmp_pcie_offsets qmp_pcie_offsets_v5_20 = {
>       |                                      ^~~~~~~~~~~~~~~~~~~~~~
> drivers/phy/qualcomm/phy-qcom-qmp-pcie.c:2357:38: note: previous definition of 'qmp_pcie_offsets_v5_20' with type 'const struct qmp_pcie_offsets'
>  2357 | static const struct qmp_pcie_offsets qmp_pcie_offsets_v5_20 = {
>       |                                      ^~~~~~~~~~~~~~~~~~~~~~
> 
> Caused by commits
> 
>   a05b6d5135ec ("phy: qcom-qmp-pcie: add support for sa8775p")
>   64adc0bf06ad ("phy: qcom-qmp-pcie: populate offsets configuration")

It is fixed now, (commits dropped), sorry for the delay though

-- 
~Vinod
