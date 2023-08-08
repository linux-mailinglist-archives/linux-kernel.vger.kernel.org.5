Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E053774ACD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjHHUfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjHHUfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:35:36 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818731A776;
        Tue,  8 Aug 2023 10:06:13 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C086D40E01A2;
        Tue,  8 Aug 2023 14:37:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iOGadB4WTIeI; Tue,  8 Aug 2023 14:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691505464; bh=RnwN9On2kYCW9ShSPXeXJUgGMNKP19hlGSAZXu85hPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y4p2yn7OdX7hMDsJj4EtycNDY6a31nhcuq2+a4boa3uEI9pAGgLL+NRqzROGW7As2
         sCalnbdyOMBQSfGrgWpCpaPODC+vFyIfYZWv7Yb7vJXbEuBRxZewPSroaQVQ6+hDHi
         xUekxj+dT14iNrNH3slTZ3RidWswTCUmt5qTfu/eKQ35sm6YEDOpMgnJZS1Q7c5jra
         p7+VfswwxMwhXMwYxuXLObkGLFKGqxitXZtRFTQ0E+BLfp+UqwFpIsUlDYQX3MJWy0
         zd4SRELRdlLQvqoXXcrzITnDT9DmW98ISESR1MxY+5Vy7CbCx9yugzuS9FTFP/YkJe
         yWJOD872Uy5HnE+zxIawqIsUpdoIvpaAPD04AZAbDuimDEVVOQz0+xnVqya79Evp42
         LJv2p08WgoOy9X3lHzEx7IkR6M6Yjw+ugAmhyST4AC3SI7geotDbdIRv2ZwjZt5zGE
         mvobHNL8TkjiJwqzESJE1PyMsbuQbYzsFT2PnnYMVK2C+B/CrbLf3dsSmK6Lc3jePc
         DoMd6azNkmC7N7A6jqp9qKboRb5loWxnDMjrhJURRsy/kT4/CFSTB6yriWAKARC72X
         eitHrwaaRyFkJGKf4UkpvK28jzztjirgKMUUy4E/l203eTbUOBj9UuknVaY2HS5oJZ
         jkFgqKizq+zLbJ+iXexP0daY=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C5ABE40E01A3;
        Tue,  8 Aug 2023 14:37:35 +0000 (UTC)
Date:   Tue, 8 Aug 2023 16:37:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        linux-edac@vger.kernel.org, hdegoede@redhat.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        avadhut.naik@amd.com
Subject: Re: [PATCH 1/2] platform/x86/amd: Introduce AMD Address Translation
 Library
Message-ID: <20230808143735.GDZNJTL0DlJd3225db@fat_crate.local>
References: <20230802185504.606855-1-yazen.ghannam@amd.com>
 <20230802185504.606855-2-yazen.ghannam@amd.com>
 <58934edf-4fad-48e0-bc5d-62712b11e607@amd.com>
 <894b3737-1a0a-4139-9c73-686a95481795@amd.com>
 <B3BE6B56-FBAB-4878-A45D-E95AFAC86AB1@alien8.de>
 <f989cd56-a066-409a-8d82-40d0bc6ff89b@amd.com>
 <20230808142007.GCZNJPFy8PqTJgTAN5@fat_crate.local>
 <a62282e0-3784-4d96-b632-fdd6d2627ca3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a62282e0-3784-4d96-b632-fdd6d2627ca3@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 10:28:51AM -0400, Yazen Ghannam wrote:
> Because this isn't intended to be only for MCA errors. The translation code
> is related to the AMD Data Fabric. And it'll be a common back-end for memory
> errors coming from MCA and CXL.

But EDAC is not only about memory errors. Why not extend this into
something which does other RAS functionality instead of doing a second
one which is more or less related?

mce_amd is already loaded on the system, why add a second module if it
can be part of the first one just the same?

Strictly speaking, this all should've been drivers/ras/ from the very
beginning and all EDAC should move there but that's going to be madness
to do now.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
