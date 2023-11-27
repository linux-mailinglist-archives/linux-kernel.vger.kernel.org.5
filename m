Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBBB7F9E13
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjK0LBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjK0LBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:01:01 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445FE111;
        Mon, 27 Nov 2023 03:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1701082862;
        bh=EpDIq0TRM3BRRgVZPPMTRFEoR5Q/FkolWUXiEN2dtlk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QkIUe72qFjWBb4ulKtgfKRQnxT3Tey0HpxiczAVjNXpPGqJJFaTAEeJn4rvf++2x1
         VRqUd76cLw2f5MSiaVJXhHfUHjTi9KkEo88DF0oo1zJt0nNYVfGOBJkpEPMuPOB7aR
         3Quif89NCJOC440f8nwbsoO3Xem5s+NxIOlq0okj6JKYwn/UPMyObVgvl0m6NlZG+P
         /WoX0ZvIw8jMS7uqbA4/wrP/TtG2eNdibbHd5+WZWsBRFscJakr0mmewcVB1du4piz
         vx7lcG4MT6IiXJG8rs6iMEYTV2tkF/QENdTOPbvReVjY+Nir/TsP4GdhcSAOa03HmR
         om9Cs9V0kD3eQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sf2gx6D9rz4xFR;
        Mon, 27 Nov 2023 22:01:01 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>
Cc:     PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: linux-next: manual merge of the tty tree with the powerpc tree
In-Reply-To: <20231127114904.77f7efb6@canb.auug.org.au>
References: <20231127114904.77f7efb6@canb.auug.org.au>
Date:   Mon, 27 Nov 2023 22:00:58 +1100
Message-ID: <877cm34g0l.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> Hi all,
>
> Today's linux-next merge of the tty tree got a conflict in:
>
>   drivers/tty/hvc/hvc_console.h
>
> between commit:
>
>   c9e38dc90e1c ("tty: hvc: Make hvc_remove() return no value")
>
> from the powerpc tree and commit:
>
>   7f30c19caf94 ("tty: hvc: Make hvc_remove() return no value")
>
> from the tty tree.
>
> These are slightly different versions of the same patch.

I'll drop it from my tree.

cheers
