Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FCC791C9E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbjIDSPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjIDSPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:15:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE5D12A;
        Mon,  4 Sep 2023 11:15:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C9F5617D0;
        Mon,  4 Sep 2023 18:15:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E9EC433C7;
        Mon,  4 Sep 2023 18:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693851307;
        bh=6a8lsQgtCxVeccLFu8tTPqZSN1RxP55BzIRicrrSk7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ku6y6OX4bW9FNb2QPR7RhqsTqMwqZE9TpmMwL4Nx4Gk9NAOFbiw5KrQzGAFO8fEMH
         tHnUmIbdNKpoK0hLQP0mOr8oVowPsILnMqU5tfNOIKUEILPSeOQEs+XsXTpfoqXWqV
         YtRPjHeyL8QPPAjWPH2V9987pz0M0S5MFlcKb8HxiZZW/e4U23e1IJOtQdDsMqtdCm
         dDdWei0io/qUXomgAIddTVOsDF5t0MgdOdM66obSjH87SqvPjTFJ3ApE0wgwsI0Ilw
         zjO21NumAOIw21q6mqlCPvCk64+1JIxBshMRC5V+sf754ns4Q6DqbaXBlQQcWlPEwU
         IzyeHb3Pvt1BA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 04 Sep 2023 21:15:04 +0300
Message-Id: <CVAC6ASBH8W5.B7SB98LQT87B@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Dusty Mabe" <dusty@dustymabe.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Cc:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Thorsten Leemhuis" <regressions@leemhuis.info>,
        <charles.d.prestopine@intel.com>, <rafael.j.wysocki@intel.com>,
        <len.brown@intel.com>, <stable@vger.kernel.org>,
        "Todd Brandt" <todd.e.brandt@intel.com>
Subject: Re: [PATCH] tpm: Don't make vendor check required for probe
X-Mailer: aerc 0.14.0
References: <20230818181516.19167-1-mario.limonciello@amd.com>
 <7eaf0f76-5820-e404-905e-892610eaed36@dustymabe.com>
In-Reply-To: <7eaf0f76-5820-e404-905e-892610eaed36@dustymabe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Aug 28, 2023 at 6:47 PM EEST, Dusty Mabe wrote:
>
>
> On 8/18/23 14:15, Mario Limonciello wrote:
> > The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG f=
or
> > all AMD fTPMs") doesn't work properly on Intel fTPM.  The TPM doesn't r=
eply
> > at bootup and returns back the command code.
> >=20
> > As this isn't crucial for anything but AMD fTPM and AMD fTPM works, thr=
ow
> > away the error code to let Intel fTPM continue to work.
> >=20
>
> FWIW there is a Fedora bug where several people are reporting similar iss=
ues:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D2232888
>
> Dusty

I just sent v4 with reported-by's added despite:

1. checkpatch.pl complaining about them
2. no mention of the bugzilla in the kernel documentation at least not
   in the sections describing the process handling the patches

BR, Jarkko
