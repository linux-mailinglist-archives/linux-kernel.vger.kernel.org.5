Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155677B6104
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 08:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjJCGvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 02:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJCGvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 02:51:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D92FB0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 23:51:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AF4C433C7;
        Tue,  3 Oct 2023 06:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696315873;
        bh=JlKz8TnjKZB3qADozNp3jxhS6lFpcAtZkkpuPxyVPAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dsB1b3ReOL2s0+k/5c4ftz8IQrp5C0DPi6B96/rPdrtzF3aEnfvABRIYnXQdo75un
         ZmYp1Fq27VVjh63hY8aGkVZ7HwR/WmSLbpv6LqKiXgieOyZIgTafH2SJjQaHLvfEkw
         8Dbt2E3vhlFM1x0uv3UdNqxol45aCztkCKx/Zk8w=
Date:   Tue, 3 Oct 2023 08:50:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     peter.chen@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, xu.yang_2@nxp.com,
        peng.fan@nxp.com, avifishman70@gmail.com, tali.perry1@gmail.com,
        joel@jms.id.au, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, j.neuschaefer@gmx.net,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND v3 0/3] usb: ChipIdea: add Nuvoton NPCM UDC support
Message-ID: <2023100323-reunite-upfront-8922@gregkh>
References: <20231002161350.64229-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002161350.64229-1-tmaimon77@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 07:13:47PM +0300, Tomer Maimon wrote:
> This patch set add USB device controller for the NPCM Baseboard
> Management Controllers (BMC).
> 
> NPCM UDC driver is a part of the USB ChipIdea driver.
> 
> Adding CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS flag to modify the vbus_active
> parameter to active in case the ChipIdea USB IP role is device-only and
> there is no otgsc register.
> 
> BMC NPCM7XX and BMC NPCM8XX has ten identical NPCM UDC modules,
> 
> The NPCM UDC were tested on NPCM845 evaluation board.
> 
> Addressed comments from:
>  - Krzysztof Kozlowski : https://www.spinics.net/lists/kernel/msg4951321.html

Why is this a RESEND?

