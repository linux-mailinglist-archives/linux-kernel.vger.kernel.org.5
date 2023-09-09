Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23728799B76
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 23:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjIIViz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 17:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjIIViz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 17:38:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB5D197
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 14:38:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9532EC433C8;
        Sat,  9 Sep 2023 21:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694295530;
        bh=5fU1vfnX5/y7qCl6GytMi3XTMVYX9SNS1qWWCb3S6jQ=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=UcShGcp4uEqcsIQP42m5AMdjrR310GdEeuL11Bs7dKHpSk8EILB2LizO0pY63S2lG
         d6JVp/6Pox23jSzOAsgWCzcKJiAy/dwAK2N2Dbc5bObNiJ8KbNrqPpBOokEDzQveMG
         IaMcJRYZXda6CpgwWv85/vbhrRdLm7CGXYuQqUL3psVAhiM+xCT9tXwM0vaz5PQrql
         uUtyIRYnFw+slnClKYsTAucXrySRpEFXtRH3TPcxCDhw8n0GBiucRPzbl5GA0PItuV
         dvAAFHWn2amXa/lZPyz5xvPHLPGZnmm32WlBA71owojkJvibblI9/mbYSaad/IawgM
         8Nl/nOvtvqdYQ==
Date:   Sat, 09 Sep 2023 22:38:47 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Samuel Holland <samuel@sholland.org>,
        Jiexun Wang <wangjiexun@tinylab.org>
CC:     guoren@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, falcon@tinylab.org,
        jszhang@kernel.org, tglx@linutronix.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_RISC-V=3A_Fix_use_of_non_e?= =?US-ASCII?Q?xistent_CONFIG=5FHAVE=5FSOFTIRQ=5FON=5FOWN=5FSTACK?=
User-Agent: K-9 Mail for Android
In-Reply-To: <0e270067-cd2d-ecd0-512b-5dce4865fa4c@sholland.org>
References: <20230906123216.255932-1-wangjiexun@tinylab.org> <0e270067-cd2d-ecd0-512b-5dce4865fa4c@sholland.org>
Message-ID: <12294913-FC23-47F5-AB73-BDBD19F65C87@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9 September 2023 22:20:41 IST, Samuel Holland <samuel@sholland=2Eorg> w=
rote:
>Hi,
>
>The patch is correct, though the subject isn't quite accurate=2E
>CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK exists; it is defined in arch/Kconfig=2E
>It's just the wrong option to use to guard the function definition=2E

That's partially my fault, I suggested using something along these lines o=
n the previous
version=2E
I blame being supposed to be on holidays!
