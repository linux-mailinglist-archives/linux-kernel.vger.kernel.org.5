Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199FB7D82CE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344958AbjJZMin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjJZMim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:38:42 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9B4C0;
        Thu, 26 Oct 2023 05:38:39 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B3E8840E0199;
        Thu, 26 Oct 2023 12:38:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2YTANyKn0Y5g; Thu, 26 Oct 2023 12:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698323885; bh=SSN5WlJwmWRCNIOEA0x5V1UMR/C6B8U/XdfqYRpooLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SLcSbs0TzE9mC7Bu1GMiQA6VntMTE+G8CSApcFS1uT9EGLMgngWmnQISUy0CXRBSr
         /giDxE3FWXe6bjhO5k83NbywEd+5s8L8dGj5cm2KtAthknAMorxJigoWEz4RLGmpeq
         /+iy0E+v7J0lxn94eZJIvq16X10TNMFveiOMK7CZaBH695IACe/955BxIxyBiq4x58
         5mrwu1MN7Rl1A9Zw8Ak/dvRpc+mpDi7Cm5S0LGWmgWdSf748XHI5aVVmqk5UiCnW+O
         z7CAbWQeo2SNYPYc8mQgvwsmjB9mXovei/iYWekK5bAu71kdenpx3w0NvCi31CLS9p
         WhBXSf+hBWkNgZJxJv1E9oe5rVaFLSEDyeFJLL5fefN4pK8MudfleklZVHcOfCwGV9
         GQju9Ccnaw3lJuos4zrpgC/9SAVgb0bALPRKe4Lxj8tGDJo2jGXlSGPOjJAMn/Gqxw
         XmWBsdm5FBWlG0peoVRpejcwNmNXEFfUXNLZkSSdRaAD6sdacwOP0KLq7ikZI4lPIy
         jNorpVzGCqd2nAvU4/U9iEaj9+0VOTqg4L4F5NqJjDMgeZXnBJQV/O5ZxZ/b7813qH
         AO824+Ovl28PZF/eXsM/SVIBKLP/Hw46DZ3GSm3Uyj39DBEphGd3yNtbpr+YnaRL1E
         1QXxxgGBTOtxEv2axNywXIKQ=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6066840E0173;
        Thu, 26 Oct 2023 12:37:59 +0000 (UTC)
Date:   Thu, 26 Oct 2023 14:37:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "M K, Muralidhara" <muralimk@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, Muralidhara M K <muralidhara.mk@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v2 1/4] EDAC/mce_amd: Remove SMCA Extended Error code
 descriptions
Message-ID: <20231026123754.GBZTpdojw+pNuZMyJy@fat_crate.local>
References: <20231025051455.101424-1-muralimk@amd.com>
 <20231025051455.101424-2-muralimk@amd.com>
 <20231025190818.GDZTlnomnaT8zxnbxX@fat_crate.local>
 <b3b21eaa-226f-e78f-14e3-09e2e02e38d6@amd.com>
 <20231026111448.GAZTpKKLI6LG1/COFE@fat_crate.local>
 <850a3e78-f663-c696-2141-7aefb043b6da@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <850a3e78-f663-c696-2141-7aefb043b6da@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 05:32:17PM +0530, M K, Muralidhara wrote:
> Not possible.  User has to check the kernel dmesg log and using "Ext.
> Error code" user has to refer the "error string" in the PPR for
> a particular Error code.

Let me paste from my previous email:

"If that is not possible with rasdaemon yet, then this patch should not
remove the error descriptions but limit them only to the families for
which they're valid.

Bottom line is, I don't want to have the situation mcelog is in where
decoding errors with it is a total disaster.

IOW, I'd like error decoding on AMD to always work and be trivially easy
to do."

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
