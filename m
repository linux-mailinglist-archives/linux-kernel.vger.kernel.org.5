Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65207F7601
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjKXOLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjKXOLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:11:54 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060581990;
        Fri, 24 Nov 2023 06:12:01 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2020C40E0258;
        Fri, 24 Nov 2023 14:11:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id H1sC0PzQz5CE; Fri, 24 Nov 2023 14:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700835116; bh=91nF7kqBaoUC/FMuQ+9T8ujOAEqcHl87UoZoCPLlSO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XXmLyt7RtiMmh6xeQ4NxGEBlxQzm6sBw8gchKdg/9bPXqSRzQeyECBf4rBBEee2dE
         h3h8G5dSQWQ0BLJUq8KaRRoCbB58TpASlhbhPwB0yZjMCJUyNuKzTYtKQcIl1gO7YG
         BzUiLByIM2SROPD7Cj16TmQd1raxEg2xnOUkRULjxCZjZRxuDniNBDz9CuY636lIRw
         x+VA6xCs2S48DM4F8UmkZqO1kragf+5KFcJtWPfrzSBTr09reMnjbe08cOQ1bEA85Y
         OzKnz+B5HoB9QY8WYZ2xX/lC5qTYeRQS4stBHKSMn2Eq7X+0AIbrvxStEzaP1cs4xG
         RJC7apcELpy6FjPG7Ged8/MDmffYCow1PK+NTdxRm3qSz8skw2uvx/AbCanJFVOyNG
         eNHuuT4lx4S9LhlwI7QkoaH010nCsrq2sydW+eLUwfYIT5tsq0IckmtRMFB5z9Hy+T
         65h6C03ES5Llf7p626UsA6Eib3ghb+Ab1IxEHD7bhd/bXTVHQD1VNg92bS8XiOBn0p
         WbrLZ2f3KJ8RqIwlRW0XF/fU7ggtIRVtU1wP05CQqTF+cWDtX4t/ILgtZNi2sHH7Am
         czFCrNGdGcLKzi8EyqSdbchFQ2fc1B85WbJNKPyMSu1T9XE3rXDYpWOVSgymNkO/ct
         tc/xkCOHxrFhN6iSUOj8sAis=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EB4B840E0195;
        Fri, 24 Nov 2023 14:11:48 +0000 (UTC)
Date:   Fri, 24 Nov 2023 15:11:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] EDAC: Use PCI_HEADER_TYPE_MASK instead of literals
Message-ID: <20231124141143.GDZWCvH51AEfym2gqt@fat_crate.local>
References: <20231124090919.23687-1-ilpo.jarvinen@linux.intel.com>
 <20231124090919.23687-5-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231124090919.23687-5-ilpo.jarvinen@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 11:09:17AM +0200, Ilpo J=C3=A4rvinen wrote:
> Replace literal 0x7f with PCI_HEADER_TYPE_MASK.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/edac/edac_pci_sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
