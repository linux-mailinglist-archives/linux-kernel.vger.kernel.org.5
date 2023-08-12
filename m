Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822C0779BE6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 02:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbjHLA3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 20:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjHLA3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 20:29:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7CD2686;
        Fri, 11 Aug 2023 17:29:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B2C0611D3;
        Sat, 12 Aug 2023 00:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E34C433C9;
        Sat, 12 Aug 2023 00:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691800142;
        bh=I8hERrAH8cW+KrNV4sDzXJt/LjxKNjbuIPllNEZCu2o=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=kbs55H4Gqw7NUCJQVHDBa+2rtt2NPOdo/O6OHvy5pNB+a3KqWTb7KUwLbIdZftnla
         RJ1wijNkj/Nx7YNai+QQoA8cqtrBXjgZqGV/AHslONmsMc1w5sYsbhey4d+3szCDIh
         MI1nBnTjz6PJf7GkQwNGFnXZ7PyX0gCA3ZaxmsRHjzQi256GKsaPvnOQ/lzccGeAl6
         LmAYBEJ+QPhICawR/wE+ftirF7Az/zgBDRofYzuym7N8JTrtEXozWXkC62IYlpgqeb
         PKFYMj04taZ3591gMtV5SNIkbX6Qjlp9aay9gjPVTFiLkybZjsVyVMeOSJyGZMzGOF
         bUhmxhNcMe4Iw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 12 Aug 2023 03:28:57 +0300
Message-Id: <CUQ53HZJ7A8M.1GXKBQ7Q2F52D@suppilovahvero>
Cc:     "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "David Howells" <dhowells@redhat.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <keyrings@vger.kernel.org>,
        "Lino Sanfilippo" <l.sanfilippo@kunbus.com>
Subject: Re: [GIT PULL] tpmdd changes for v6.5-rc7
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.14.0
References: <20230812000440.2663553-1-jarkko@kernel.org>
In-Reply-To: <20230812000440.2663553-1-jarkko@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Aug 12, 2023 at 3:04 AM EEST, Jarkko Sakkinen wrote:
>   Merge tag 'mm-hotfixes-stable-2023-08-11-13-44' of git://git.kernel.org=
/pub/scm/linux/kernel/git/akpm/mm (2023-08-11 14:19:20 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git ta=
gs/tpmdd-v6.5-rc7
>
> for you to fetch changes up to 6aaf663ee04a80b445f8f5abff53cb92cb583c88:
>
>   tpm_tis: Opt-in interrupts (2023-08-12 02:36:28 +0300)
>
> ----------------------------------------------------------------
> Hi,
>
> These change the probing and enabling of interrupts advertised by the
> platform firmware (i.e. ACPI, Device Tree) to tpm_tis as an opt-in,
> which can be set from the kernel command-line.

I would add that tpm_tis represents the MMIO path to a TPM chip, and is
only one of the drivers using tpm_tis_core.

Opt-in does not concern any other drivers using IRQs, namely tpm_tis_spi
and synquacer, meaning that Lino's changes are still for profit without
question. They were just scoped wrong.

MMIO is the "PC" thing where it matters least whether you poll or use
irqs.

BR, Jarkko
