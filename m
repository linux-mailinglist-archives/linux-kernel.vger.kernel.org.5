Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4865277E9B5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 21:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345814AbjHPTdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 15:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345808AbjHPTco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:32:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09D026AD;
        Wed, 16 Aug 2023 12:32:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81D57614B1;
        Wed, 16 Aug 2023 19:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85027C433C8;
        Wed, 16 Aug 2023 19:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692214362;
        bh=3k/G1IdGTo/pFQOLtXJVP6vUz0LY403tsY7r3QyyxB4=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=AVK7Mds92wudrOp9BdQdh4RY7w429InTt/ODJw0e4Lo1rQn49iwbXMU1HFyP7OFrI
         2DpCw63WGeZebcNL24D1kD2WUn4gdxX8TOH2PmnbQCPig3p8AtSIHk4PE7O4N9me94
         TuLSJl8eiYDUesow+FPtq3E46gbjgxZAEfZsNR94Yc3YgwGacMnJz7dRXCFP3R5Ntn
         FIE/TdrMq7vZoUvydbpXVJ5Ta8CTMPI7NxCOghNw7LYbyg7Y88HttXy32jesfzt0ze
         xAgc+Okm1Xd9254MMjcM0RV3++fd5CwS455vsnC/fe7cXfSCL3RbFdkQkOt6Ub2oZm
         Mt9lrzKBMuEZw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 16 Aug 2023 22:32:39 +0300
Message-Id: <CUU7XCP53ERV.2SV3LEE31BZH9@suppilovahvero>
Subject: Re: [PATCH v2] s390/ipl: fix virtual vs physical address confusion
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Heiko Carstens" <hca@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc:     "Mimi Zohar" <zohar@linux.ibm.com>,
        "Vasily Gorbik" <gor@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230816132942.2540411-1-agordeev@linux.ibm.com>
 <20230816154419.29011-A-hca@linux.ibm.com>
In-Reply-To: <20230816154419.29011-A-hca@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 16, 2023 at 6:44 PM EEST, Heiko Carstens wrote:
> On Wed, Aug 16, 2023 at 03:29:42PM +0200, Alexander Gordeev wrote:
> > The value of ipl_cert_list_addr boot variable contains
> > a physical address, which is used directly. That works
> > because virtual and physical address spaces are currently
> > the same, but otherwise it is wrong.
> >=20
> > While at it, fix also a comment for the platform keyring.
> >=20
> > Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> > ---
> >  arch/s390/kernel/machine_kexec_file.c             | 4 ++--
> >  arch/s390/kernel/setup.c                          | 2 +-
> >  security/integrity/platform_certs/load_ipl_s390.c | 4 ++--
> >  3 files changed, 5 insertions(+), 5 deletions(-)
>
> Mimi, Jarkko, any objections from your side?
> I would take this via the s390 tree.

No objections.

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
