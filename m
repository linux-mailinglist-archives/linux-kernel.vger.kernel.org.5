Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CCE7FE02E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 20:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjK2TQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 14:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjK2TQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 14:16:23 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B054D5E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 11:16:29 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1r8Q2o-0003uT-2z; Wed, 29 Nov 2023 20:16:22 +0100
Message-ID: <62e767da-5e4f-4b92-a5c9-5d523896d68e@pengutronix.de>
Date:   Wed, 29 Nov 2023 20:16:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] arm64: boot: Support Flat Image Tree
Content-Language: en-US
To:     Tom Rini <trini@konsulko.com>
Cc:     Simon Glass <sjg@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20231129172200.430674-1-sjg@chromium.org>
 <20231129172200.430674-3-sjg@chromium.org>
 <30f32467-51ea-47de-a272-38e074f4060b@pengutronix.de>
 <20231129190220.GN2513409@bill-the-cat>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20231129190220.GN2513409@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tom,

On 29.11.23 20:02, Tom Rini wrote:
> On Wed, Nov 29, 2023 at 07:59:00PM +0100, Ahmad Fatoum wrote:
>> Hi,
>>
>> a few more comments after decompiling the FIT image:
>>
>> On 29.11.23 18:21, Simon Glass wrote:
>>> +    with fsw.add_node('kernel'):
>>> +        fsw.property_string('description', args.name)
>>> +        fsw.property_string('type', 'kernel_noload')
>>
>> The specification only says no loading done, but doesn't explain what it
>> means for a bootloader to _not_ load an image. Looking into the U-Boot commit
>> b9b50e89d317 ("image: Implement IH_TYPE_KERNEL_NOLOAD") that introduces this,
>> apparently no loading means ignoring load and entry address?
>>
>> I presume missing load and entry is something older U-Boot versions
>> were unhappy about? Please let me know if the semantics are as I understood,
>> so I can prepare a barebox patch supporting it.
> 
> So the matching side for this series in U-Boot is:
> https://patchwork.ozlabs.org/project/uboot/list/?series=382849&state=*
> 
> And in short, for IH_TYPE_KERNEL_NOLOAD we do our best to use it
> in-place. For decompression we allocate some space to decompress to.

Thanks. I am still curious why "kernel" couldn't have been used back then
with missing entry and load address to arrive at the same result?

Thanks,
Ahmad


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

