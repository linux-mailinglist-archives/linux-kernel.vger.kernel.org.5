Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95805767658
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbjG1TaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjG1TaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEC0268B;
        Fri, 28 Jul 2023 12:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 586F7621E2;
        Fri, 28 Jul 2023 19:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03259C433C7;
        Fri, 28 Jul 2023 19:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690572621;
        bh=ZUKB9yxNaWjmEQHRW9zG7qjbeHoA2GNdjk2jXmgn1vs=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=fVxA+CTpbQ1tc+ivlNQNyHGhmtpBUiCrwkq+VM0NxAcg99HwxnIDtd1ULhW31ToiB
         6I1gPMvhRQ6b9d5B0+4wwSZNkBAjccVWXdfJxBB4AI6uGi9NLOSWvOAMF+QmPdtO4s
         0YbXKVefi7C8Pvo9ABuwHaxF2RatyezAGAMsR14Mebhp13noLVUSKNSYiGzyIqrzvx
         2t1Q2jPGyk5jKJksdxl6w/vODmFgTzsbPTY7GeszVmZy9uz6AZpDCU7L+5+ME/n8Rp
         JGN2Y3/i/kt6OFIFtQ2hxcKbWCjOqGfB2NJ8DMK0LI+7vcGySrmC1SjdWbpIgHPUYh
         N0l1NNHVu5H9A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jul 2023 19:30:18 +0000
Message-Id: <CUE1Z76QDX0Z.2K0OU6TPMS50X@seitikki>
Cc:     <James.Bottomley@hansenpartnership.com>, <Jason@zx2c4.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <regressions@leemhuis.info>, <stable@vger.kernel.org>,
        <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Daniil Stas" <daniil.stas@posteo.net>, <mario.limonciello@amd.com>
X-Mailer: aerc 0.14.0
References: <20230214201955.7461-2-mario.limonciello@amd.com>
 <20230727183805.69c36d6e@g14>
In-Reply-To: <20230727183805.69c36d6e@g14>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Jul 27, 2023 at 3:38 PM UTC, Daniil Stas wrote:
> Hi,
> I am still getting fTPM stutters with 6.4.3 kernel on Asus GA402RJ
> laptop.
> Compiling kernel without TPM support makes the stutters go away.
> The fTPM firmware version is 0x3005700020005 on my machine.

This is needs a bit more elaboration in order to be comprehended.

Do you mean by "stutter" unexpected delays and when do they happen?

BR, Jarkko
