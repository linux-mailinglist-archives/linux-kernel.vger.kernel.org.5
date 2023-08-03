Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9459E76E3E5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbjHCJDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbjHCJDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:03:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F749E46;
        Thu,  3 Aug 2023 02:03:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14E8E61CF2;
        Thu,  3 Aug 2023 09:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EF0C433C7;
        Thu,  3 Aug 2023 09:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691053414;
        bh=vq00O6OTzWsYAl1WpA69up/YHt7XiTCS1t7wLwL/VBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vLmMULYPu3jmpw9j0rqFbyVn8e8PvYc7CFLq1VMCEZLAY5JVuB9NVr1Zz8D4L2Ntp
         NkyBG6Lky5iR6HkI25AhjICO5+rNU7gmwYpqFC4ApyrjukflykHOzdamakwPcP7L3S
         Vg9fp5UTN0zAl9MWoEOu4XkRZWHHiqdSyeV2tmSyCjrWI2Ev4eQS/zn2ip7q+SxPhc
         FVZiWdkKR15oVrN9HhUX0kzxfRr0H8ihrLVBUWYZvjwpKhvukYt6Yiw0adx2V7MbWh
         JDhsE3rhrZMbnqpvQwFirWAKriBUpQzwZqLLmr7AFGjPTURbHiahnmv3dkpO2CM6Kb
         g+3UuiulE/7Qg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 03 Aug 2023 12:03:15 +0300
Message-Id: <CUISED4NBEZP.1AFVEMEVNIVOU@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Paul Menzel" <pmenzel@molgen.mpg.de>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Cc:     <peterhuewe@gmx.de>, <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <Jason@zx2c4.com>,
        <dragonn@op.pl>
Subject: Re: [PATCH 3/3] tpm: Drop CONFIG_HW_RANDOM_TPM
X-Mailer: aerc 0.14.0
References: <20230803015015.915-1-mario.limonciello@amd.com>
 <20230803015015.915-4-mario.limonciello@amd.com>
 <dcbf7a17-67e3-d97d-bd18-9b0bd917a6cf@molgen.mpg.de>
In-Reply-To: <dcbf7a17-67e3-d97d-bd18-9b0bd917a6cf@molgen.mpg.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Aug 3, 2023 at 10:22 AM EEST, Paul Menzel wrote:
> Dear Mario,
>
>
> Thank you for the patch.
>
> Am 03.08.23 um 03:50 schrieb Mario Limonciello:
> > As the behavior of whether a TPM is registered for hwrng can be control=
led
> > by command line, drop the kernel configuration option.
>
> Shouldn=E2=80=99t this be left in to be able to set the default without h=
aving=20
> to change the Linux kernel command line?

Even if it made sense it is completely urelated to the real-world
issues at hand.

BR, Jarkko
