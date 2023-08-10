Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49161778039
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbjHJS0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjHJS0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:26:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50498128;
        Thu, 10 Aug 2023 11:26:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB91E64276;
        Thu, 10 Aug 2023 18:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E8CC433C7;
        Thu, 10 Aug 2023 18:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691691997;
        bh=4oyVmI20rJOuttCWlSmIM8jeN4eE8nnpUCg+MSdoISY=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=INZmfucqOCkyMJo1RDCPII2T9THuV2Y8L6gBSX5MDpw49bRZyjPQziUtRUzo4EhKH
         d1jZ3PrxdZCNyuGnrYQK2zK61cBE2VQv9pAkOGGpexfOja/7ep3rDGJp6WHXJA60kj
         Pk2pyfBaEwHnWkEgGQ9zlb01l8hUg46uI12F1wfM4NORaANpGa13U40N4DaJjeaMor
         cHXkHturJli5OsQVRsBTdzURcD9PRY9TvsHiXJVdEUJfA0MWLp7r4NTktMgbYbQKVM
         wAOm5v5NFrxAy7i0zpcI19fO8byEyRIYN/bUPhUj9Dr0f/ZYbT8uPZeFCDUXSyx/jt
         dT2E+IM5PsJLQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 21:26:32 +0300
Message-Id: <CUP2RGNHEZNL.28S24J3GQVAE1@suppilovahvero>
Cc:     "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm/tpm_tis: Disable interrupts for Lenovo Thinkpad E14
 Gen 2 and 13s-IML
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Takashi Iwai" <tiwai@suse.de>
X-Mailer: aerc 0.14.0
References: <20230807140125.18486-1-tiwai@suse.de>
 <CUMJWFCIG9EI.13F7LU8TYAUE1@seitikki> <87il9qhxjq.wl-tiwai@suse.de>
 <CUOYJI68K3KG.39YM92JXBEIQ9@wks-101042-mac.ad.tuni.fi>
 <87ttt7rkpq.wl-tiwai@suse.de> <CUP1O7LTI58J.1VQMCH1YS0EXR@suppilovahvero>
 <875y5mu6uh.wl-tiwai@suse.de>
In-Reply-To: <875y5mu6uh.wl-tiwai@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Aug 10, 2023 at 8:48 PM EEST, Takashi Iwai wrote:
> > I'll submit a patch asap, and cc you. I put the conclusions
> > to the description.
>
> Great, thanks!

It is out now:

https://lore.kernel.org/linux-integrity/20230810182433.518523-1-jarkko@kern=
el.org/T/#u

BR, Jarkko
