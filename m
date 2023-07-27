Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C965B765107
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjG0KZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbjG0KZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:25:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F432726;
        Thu, 27 Jul 2023 03:25:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DD1061DF7;
        Thu, 27 Jul 2023 10:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB852C433C8;
        Thu, 27 Jul 2023 10:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690453505;
        bh=R8krPfSKTiP+fZ6h8cW7bvgjz3LQoVz5UVKDFLuUGqs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=i+08kTNdICfOHkXpJS8Dnt78vDILN63pwVErn0O9THCO6qIZuIJcr6ckPCwpL7nFG
         F2wwiOdvzItDNQdAdTLTDXfK/VmwvBOBe7QcdHqUHH+FXb+/JWTLTqt5YX2/WgEVK2
         Joav6J63eMVpMVODxlXyzJfajgXkHaIE9iv2VgEfSeQP4pTeDMRSR1sxwmeM6TBuMh
         LLvMw2Qp6PhAucJ+0kNvil0DFxHvvc0P3wad3CHSvUxt+oqXQfxAXuuhlMkToFrOif
         mbDlETKXqsZtfaxwlNNSNf/R5GInD3dcfWUBHaGtSGnIulp2/OaczqNYEI3C4Dgrdc
         uQxsEawrBlmiQ==
Message-ID: <e348b705-9522-93b6-4dd9-ab62fd1a1a98@kernel.org>
Date:   Thu, 27 Jul 2023 19:25:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Scsi_bus_resume+0x0/0x90 returns -5 when resuming from s3 sleep
Content-Language: en-US
To:     TW <dalzot@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     regressions@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bart Van Assche <bvanassche@acm.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
References: <0e272abe-292d-d58f-cf80-55868e793abc@gmail.com>
 <6b66dd9a-8bd5-2882-9168-8e6e0848c454@leemhuis.info>
 <c70caa9e-164c-fee5-8f85-67f6d02373ab@kernel.org>
 <b0ed86e0-3e4a-d4d1-7b9d-c57f20538a80@gmail.com>
 <86435987-734e-c6c1-a857-1ba80da709fe@gmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <86435987-734e-c6c1-a857-1ba80da709fe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/23 19:22, TW wrote:
> I managed to fix the patch file, guess the formatting messed up a bit. So will
> try with those patches installed.

Please do not top post.

Again, I sent you a single patch. What other patches are you talking about ?

> 
> On 7/27/23 04:06, TW wrote:
>> I retried on 6.5 rc3 without the Nvidia drivers and still received the same
>> error and going to try for the patch next but got a malformed patch error on
>> line 6 for the first patch for libata-scsi.c. The other two seem to go
>> through just fine however.

-- 
Damien Le Moal
Western Digital Research

