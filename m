Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE42756A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjGQRYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjGQRYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:24:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAA4171B;
        Mon, 17 Jul 2023 10:24:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32E3661191;
        Mon, 17 Jul 2023 17:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147CEC433CB;
        Mon, 17 Jul 2023 17:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689614685;
        bh=eKvWRw2XtpYNOht9yXs2yAvYu/XhiCso30jY/pgjAAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cyGXct3/nL7GHmbWqrzVVaJI77QnQaJdq7XtmFJEA+rgr2JQxWB2fL5LuebsxeMpb
         L4Wukwc9i/Ga3xZ260o7a955/MdCcpZrxAqPRW5g87USog3u4jSi6qjZAAib02IoWD
         8FO/0AsNmy/wdH0ww+psl8KLwVtG2w7T/kZjImWE=
Date:   Mon, 17 Jul 2023 19:24:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 000/800] 6.4.4-rc1 review
Message-ID: <2023071736-fiber-recipient-61b0@gregkh>
References: <20230716194949.099592437@linuxfoundation.org>
 <6e31d62f-21b0-874b-a2e2-3c74a0b587c0@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e31d62f-21b0-874b-a2e2-3c74a0b587c0@roeck-us.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 06:37:37AM -0700, Guenter Roeck wrote:
> On 7/16/23 12:37, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.4.4 release.
> > There are 800 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Tue, 18 Jul 2023 19:48:07 +0000.
> > Anything received after that time might be too late.
> > 
> 
> As I had already reported:
> 
> Building mips:allmodconfig ... failed
> --------------
> Error log:
> arch/mips/boot/dts/ingenic/ci20.dts:242.19-247.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/DCDC1: Reference to non-existent node or label "vcc_33v"
> arch/mips/boot/dts/ingenic/ci20.dts:248.18-253.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/DCDC2: Reference to non-existent node or label "vcc_33v"
> arch/mips/boot/dts/ingenic/ci20.dts:254.18-259.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/DCDC3: Reference to non-existent node or label "vcc_33v"
> arch/mips/boot/dts/ingenic/ci20.dts:265.17-270.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO5: Reference to non-existent node or label "vcc_33v"
> arch/mips/boot/dts/ingenic/ci20.dts:271.18-276.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO6: Reference to non-existent node or label "vcc_33v"
> arch/mips/boot/dts/ingenic/ci20.dts:277.20-282.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO7: Reference to non-existent node or label "vcc_33v"
> arch/mips/boot/dts/ingenic/ci20.dts:283.20-288.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO8: Reference to non-existent node or label "vcc_33v"
> ERROR: Input tree has errors, aborting (use -f to force output)
> make[3]: [scripts/Makefile.lib:419: arch/mips/boot/dts/ingenic/ci20.dtb] Error 2 (ignored)
> arch/mips/boot/dts/ingenic/ci20.dts:242.19-247.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/DCDC1: Reference to non-existent node or label "vcc_33v"
> arch/mips/boot/dts/ingenic/ci20.dts:248.18-253.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/DCDC2: Reference to non-existent node or label "vcc_33v"
> arch/mips/boot/dts/ingenic/ci20.dts:254.18-259.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/DCDC3: Reference to non-existent node or label "vcc_33v"
> arch/mips/boot/dts/ingenic/ci20.dts:265.17-270.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO5: Reference to non-existent node or label "vcc_33v"
> arch/mips/boot/dts/ingenic/ci20.dts:271.18-276.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO6: Reference to non-existent node or label "vcc_33v"
> arch/mips/boot/dts/ingenic/ci20.dts:277.20-282.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO7: Reference to non-existent node or label "vcc_33v"
> arch/mips/boot/dts/ingenic/ci20.dts:283.20-288.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO8: Reference to non-existent node or label "vcc_33v"
> ERROR: Input tree has errors, aborting (use -f to force output)
> make[4]: [scripts/Makefile.lib:419: arch/mips/boot/dts/ingenic/ci20.dtb] Error 2 (ignored)
> 
> This is the same error as reported for 6.3.13-rc3, introduced with "MIPS: DTS:
> CI20: Add parent supplies to ACT8600 regulators" which uses vcc_33v without
> introducing it (it was introduced with commit c9f4b25272843).

Ah, ick, sorry, I tried to fix this up but I applied a different "fix".
I'll go drop this one, and the "fix up" patch as well and push out a
-rc2 soon.

thanks,

greg k-h
