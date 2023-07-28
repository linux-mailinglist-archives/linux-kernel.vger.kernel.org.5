Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFCE7676E9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 22:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbjG1US5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 16:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbjG1USd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 16:18:33 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CFC4488
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 13:18:31 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 7DF69240105
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 22:18:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1690575509; bh=6HJgTambXSITA+0qKZ/a7dX11wgfCP5FR4Ajeth5TqA=;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Transfer-Encoding:From;
        b=HYpb5OZsWqejBHx8Mouc25bQRdrnzIKl5D+05DBTfevHatnKH+aY5yPhIvb8urEmu
         Lkj5mb4SRI/8e1Z3tKFLaaQt+Kxx6mWXTjI/3p/IldwtkAs5q6ADcFyrUzyeECqbFc
         SN0zfbEBpEcg19bVwP5m4Yg82nDCPO0cx0yiYzklTxAcsj6SkqDAU9FnuNo33isgMu
         SvPAhSSu+u6Tyk12IUWW7U0l+GrpamO3ZieRu74ep49aqmxrdnE91sJ8YsHcL0YdB/
         DMqvZJ0NnCE+x9ImGKlPz0lJdq2BXxVOE4W81eRfZ7QmOrTFp2Tj5HXK5fwfgG0GHP
         lW1uR51ZUDa/w==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4RCJqR3d5Yz9ryY;
        Fri, 28 Jul 2023 22:18:27 +0200 (CEST)
Date:   Fri, 28 Jul 2023 20:18:10 +0000
From:   Daniil Stas <daniil.stas@posteo.net>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>
Cc:     <mario.limonciello@amd.com>,
        <James.Bottomley@hansenpartnership.com>, <Jason@zx2c4.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <regressions@leemhuis.info>, <stable@vger.kernel.org>,
        <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
Message-ID: <20230728231810.48370d44@g14>
In-Reply-To: <CUE1Z76QDX0Z.2K0OU6TPMS50X@seitikki>
References: <20230214201955.7461-2-mario.limonciello@amd.com>
        <20230727183805.69c36d6e@g14>
        <CUE1Z76QDX0Z.2K0OU6TPMS50X@seitikki>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 19:30:18 +0000
"Jarkko Sakkinen" <jarkko@kernel.org> wrote:

> On Thu Jul 27, 2023 at 3:38 PM UTC, Daniil Stas wrote:
> > Hi,
> > I am still getting fTPM stutters with 6.4.3 kernel on Asus GA402RJ
> > laptop.
> > Compiling kernel without TPM support makes the stutters go away.
> > The fTPM firmware version is 0x3005700020005 on my machine.  
> 
> This is needs a bit more elaboration in order to be comprehended.
> 
> Do you mean by "stutter" unexpected delays and when do they happen?
> 
> BR, Jarkko

Yes, unexpected delays. They just happen randomly.
You can google "AMD fTPM stuttering", there are a lot of examples.
Here is one: https://www.youtube.com/watch?v=TYnRL-x6DVI
