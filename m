Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D216B75718B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 03:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjGRB7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 21:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjGRB7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 21:59:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D557E6F;
        Mon, 17 Jul 2023 18:59:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EB206137C;
        Tue, 18 Jul 2023 01:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A91DC433C8;
        Tue, 18 Jul 2023 01:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689645562;
        bh=aHdplcdMtBAJ468vhdNcbjiNXN7woPwz8Wety4Mnnlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HLXwaovj1bouynuG/zVj6QLPPiHpMqkWiBj787TnHpjYtq9xRvQLGV5TtvCBUTAaO
         StNnJIlONKUxRHAtwg/fPZ/4iMjLg3hm52tN9WHcZbbMQ9ubiXEhVytZnxocsyeLw4
         3TKJivUYYwGU5ykRrYUJU2vMuW10PlxgFDDFxIjTuH39QhBk0vbXwbqPsbZg3GM9f0
         G5Au4mbJZZYMfH8fjpXIxqo7oVFIwjqWQQE7/7fOdwzR0U3PagNEsiNh5XXcpZzCoV
         gBlG0UIFdFU4A7dXXMQfylUC8ml2UrZwO7o9WXrOgqg7ywyIFoaOGqC3h2I6ScwcyF
         nh6ncxdZjGrNg==
Date:   Tue, 18 Jul 2023 09:59:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <mwalle@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: sl28: fetch the ethernet addresses from its
 EEPROM
Message-ID: <20230718015912.GV9559@dragon>
References: <20230616-feature-sl28-vpd-dt-v1-0-c5458016ba85@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616-feature-sl28-vpd-dt-v1-0-c5458016ba85@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 01:11:20PM +0200, Michael Walle wrote:
> After years, NVMEM layouts finally made it into the kernel. The network
> devices on the Kontron sl28 boards can now fetch their MAC addresses by
> reading the onboard VPD EEPROM. Yay :)
> 
> First enable the layout driver (as a module) in the defconfig and then
> add the dt fragments.
> 
> The second commit was already applied once in commit b203e6f1e833
> ("arm64: dts: ls1028a: sl28: get MAC addresses from VPD") but had to be
> reverted in commit 916508c30e22 ("Revert "arm64: dts: ls1028a: sl28: get
> MAC addresses from VPD") because the NVMEM layouts series was dropped.
> NVMEM layouts will be included in v6.4, so we can now safely add the
> device tree fragments for v6.5.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
> Michael Walle (2):
>       arm64: defconfig: enable SL28VPD NVMEM layout
>       arm64: dts: ls1028a: sl28: get MAC addresses from VPD

Applied both, thanks!
