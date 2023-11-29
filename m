Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11797FDEE1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjK2Rwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK2Rwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:52:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C6EB9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:52:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45D4C433C7;
        Wed, 29 Nov 2023 17:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701280370;
        bh=TeE0Isi9YwAMtl8bMXbwMjaH/0PAcKg5AcG0AGcQ/Cs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N6KR6NWdBUe9tFdkDnztYFJVQdBZoJJa6mOyRiTbpm75dRLI9Uk5z6eNybJC7AbhB
         I5Zj+goISMxczvQrXgusYiBAoqocLGMKcrn4iXReG6CD9y46AvCfWdkADF4wV10Yc8
         ZulJSUFPkpmXCw2hlEfL+8N4TjPmygDBBvncdyQ4eyrvEMyw0L4Iz6HyO38uQY6OEV
         qQ14V87JJrcSD1aOvDlguDGvKq5DuA5SjPS7+Tdqjv9/18T4b1CnpIi51giOcRaboi
         VAOWvNGh5Xq8bXDopmM2n1i97ykPx7ll6tAyknluxiKV5dETsCec6j3rRU/XuZiId0
         48ie20a2MtSpg==
Date:   Wed, 29 Nov 2023 09:52:48 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     Min Li <lnimi@hotmail.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "lee@kernel.org" <lee@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] ptp: introduce PTP_CLOCK_EXTOFF event for
 the measured external offset
Message-ID: <20231129095248.557d37ca@kernel.org>
In-Reply-To: <OS3PR01MB65932F46E55E38E3DDB938C9BA83A@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <PH7PR03MB706497752B942B2C33C45E58A0BDA@PH7PR03MB7064.namprd03.prod.outlook.com>
        <20231128195811.06bd301d@kernel.org>
        <OS3PR01MB65932F46E55E38E3DDB938C9BA83A@OS3PR01MB6593.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 16:59:38 +0000 Min Li wrote:
> But the driver that I submitted is a brand new PHC driver. So I don't
> know if it is appropriate to separate them to net and net-next?
> Because the driver change depends on the this patch.

What's in your tree? What I'm saying is that the diff context does not
match net-next:

$ git checkout net-next/main
$ git pw series apply 804642
Applying: ptp: introduce PTP_CLOCK_EXTOFF event for the measured external offset
Using index info to reconstruct a base tree...
M	drivers/ptp/ptp_clock.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/ptp/ptp_clock.c
Applying: ptp: add FemtoClock3 Wireless as ptp hardware clock


Do you have any intermediate commits in your local branch? 
Or perhaps the patches are based on some other tree, not net-next?
