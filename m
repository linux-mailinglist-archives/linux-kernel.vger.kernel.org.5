Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FD67747F9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbjHHTWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbjHHTWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:22:01 -0400
X-Greylist: delayed 2978 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Aug 2023 09:45:44 PDT
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707E810E9D1;
        Tue,  8 Aug 2023 09:45:44 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E14CA40E0195;
        Tue,  8 Aug 2023 14:20:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HuT5X_6YHG5g; Tue,  8 Aug 2023 14:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691504421; bh=Ja/4Je+eQgflIPt0xBBlPFb2JkS0+HhGaeLu0Idap6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U1SjwFKpQtDG5Qh7oIa3iME7IroVA+8T10PvQZHUUqAtxqdnLOVc2MQDG4JB1jpZT
         gKykGZhQn2JZ9G/0Ncw8EfTy5rYEyUSznPl7lrOc4IJ1bfEBAdsSZ06aCgTcf8xKBr
         scvAmXm96mihB3D0klClpiJHyYCPkiErUjBOansPrh+DBDFi+YqLVbk/wyIvhLqzYp
         hLNtH0wimamG0TVvOWOL5tjPoAMUVLstyfzLjuCXNdF1P3R2bxgxtAN4sCUHp+6b0D
         qotyPf84fVzrKhUiX0MivWmUGgB1PnMPtuRpMHzeEzPg88cVerUb9cAomVUoZoOeoF
         u59MsfV241sDqEYUrkXatwWEr4KrBhxEvV7gP0Nl+wjveRve69qa4XOffEmbPPnuc6
         4LZY7U60JwXokXFhkGyV26ypAHMMyRKgL2+sytv7InAhg81GavOCpvFziYfmbhCYss
         0mtmBwpE+CE9p4EuPmHRBsvTHCb4JKlTLBc6fggqvHVvanIM6rUH76+BNwDS4mQ+bN
         gXqMFohgHGEzHnbKsay1bRGfggNsPY97AO9qqRXiewZEZRpJPoba2S6cs0v5rvrOKk
         uuxNk0e8pYKcr0m4wrX/OkueOQCCa/7YzGhidZ1WJXtroJwS6FyBxnZ4IE0X6rSU7R
         m6n1b+yARY+iSUe2ebx8/YP4=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E3C2940E01A2;
        Tue,  8 Aug 2023 14:20:11 +0000 (UTC)
Date:   Tue, 8 Aug 2023 16:20:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        linux-edac@vger.kernel.org, hdegoede@redhat.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        avadhut.naik@amd.com
Subject: Re: [PATCH 1/2] platform/x86/amd: Introduce AMD Address Translation
 Library
Message-ID: <20230808142007.GCZNJPFy8PqTJgTAN5@fat_crate.local>
References: <20230802185504.606855-1-yazen.ghannam@amd.com>
 <20230802185504.606855-2-yazen.ghannam@amd.com>
 <58934edf-4fad-48e0-bc5d-62712b11e607@amd.com>
 <894b3737-1a0a-4139-9c73-686a95481795@amd.com>
 <B3BE6B56-FBAB-4878-A45D-E95AFAC86AB1@alien8.de>
 <f989cd56-a066-409a-8d82-40d0bc6ff89b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f989cd56-a066-409a-8d82-40d0bc6ff89b@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 10:07:19AM -0400, Yazen Ghannam wrote:
> But just because there's existing vendor-specific code in arch/x86 doesn't
> necessarily mean we should keep adding to it. So is this okay?

I'd say since it is not so close to the arch/ part, drivers/ras/ is more
fitting IMO. Just like mce_amd is in drivers/edac/.

Which reminds me: why aren't you adding it to

drivers/edac/mce_amd.c

?

That is an MCE decoder *already*.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
