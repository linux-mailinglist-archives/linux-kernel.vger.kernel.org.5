Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285CF75EE59
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjGXIvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjGXIvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:51:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938281B0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:51:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15E2560FF1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2940C433C8;
        Mon, 24 Jul 2023 08:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690188673;
        bh=MDKeWmEo7Cb2kOxilFtjo4psxE97rkpQgLOP32VHaXU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=j7iqUH56oJu3Y/Yj2vum7mPbjF8WsGhJ1gWV74s3jySMpL8189aLR9D6hHMgVatv4
         tsG8w4mEnxosVcR/x9fv9ky9F52r/txmRB+Uq10DvAZyE4Ao3T8+ugGjan7itiMrr5
         vcWq1a36FZkTQ0bcy2Odikipj3LfzOMtJa4iSCUu1qSP5AVS4xqC2/HXixwgxlljic
         LhVD8io9b5qZzKBEUFzg+yuHf9ncv1PO6ShchN0SiUDOzB4ZThrhKHgGAXxksNwwUC
         FcHp4O1uh3a1TdAwSeFH0B0R9pJw82PcrUH8TzO2PippeVr/nwGxx62jKF5+kyJ8NB
         9aQ7nlOhDGDxQ==
Message-ID: <505c355e-a658-93bb-c981-8a6722b02522@kernel.org>
Date:   Mon, 24 Jul 2023 10:51:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 09/10] dt-bindings: power: fsl,scu-pd: support i.MX8DXL
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
References: <20230724014711.2048958-1-peng.fan@oss.nxp.com>
 <20230724014711.2048958-10-peng.fan@oss.nxp.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230724014711.2048958-10-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2023 03:47, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add compatible string for i.MX8DXL
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested by
automated tooling. Performing review on untested code might be a waste
of time, thus I will skip this patch entirely till you follow the
process allowing the patch to be tested.

Please kindly resend and include all necessary To/Cc entries.

Best regards,
Krzysztof

