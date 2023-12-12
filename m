Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DE580F9AB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377579AbjLLVqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377571AbjLLVqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:46:32 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C10B0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:46:39 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 41E6E40E00CC;
        Tue, 12 Dec 2023 21:46:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5OLpYQ0Fegld; Tue, 12 Dec 2023 21:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1702417593; bh=kID6XEZVJ5WdI6iDkAqV9iTzJ5DB/DCJdjzBL4bp4HY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e97tb7KH9xOJRQoMoYbJqsC4BwJRZ0d/od08zGTCQGqcp2TgWL/ydg20O6KT5lix8
         USva3x1RWRaXCgQbHJwoO/WOmtpcQ6YzwVSjP/99hB+iJ0cxSDWG+Hcj+gX2/oWDNq
         J7bwGRv0kpFl36rC38EsZzGdM7qejeRbx34J2B47kOzpY9LIVFvbJMpPFpj8OBtzkG
         G1L/XNqWB5Ue9C4GPjeCDvWn1yqqkfzWF4WX9a2XuYm5EGvPmg22VgOVw0mi+2czZc
         Uq2m/4y18WRQphdFYYds79c5hwgl/Q0tWcFl0CBEeKEzfRMPZZ/86vUOnx/Ra3cjjW
         a5w+dUaRsEVnjNTIwD5du7h71dGxlIsk9+BBnW7qDhYzXA4r+pPHEs8ohAkFOnIakN
         ZBknbnoJ5BsWJZL5EFP6Ob6KSVuhzCqO/booYPxEILFt2YXEI3Hp0ovD3/k1nAXFm3
         vxPvXuhERZACVYt8h/EV2rNbbvwBweILIljG0ZVzCFqwknGo9l9B/Ych/lO9OnDiWY
         ZE/c70ALbk6U+wf4CSXfzP/mbnBfiArdnDh3k1CxM2zAbupY22PgXN31ShJcqsEtHN
         SjehOVBFUtppW2clrLZ7h8uW12RckK8cmzuxXC0rNiSfcONeJMxFsbg3I0XmKjq/MQ
         Yczic+wbHuk6NNA+MHa1dh/g=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 26F4640E0140;
        Tue, 12 Dec 2023 21:46:18 +0000 (UTC)
Date:   Tue, 12 Dec 2023 22:46:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Yuan Yao <yuan.yao@intel.com>, Kai Huang <kai.huang@intel.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: tdx: hide unused tdx_dump_mce_info()
Message-ID: <20231212214612.GHZXjUpBFa1IwVMTI7@fat_crate.local>
References: <20231212213701.4174806-1-arnd@kernel.org>
 <39cf0ad5-bbef-4fb9-81a3-9d2891cc7450@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39cf0ad5-bbef-4fb9-81a3-9d2891cc7450@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 01:42:09PM -0800, Dave Hansen wrote:
> On 12/12/23 13:36, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > When TDX is enabled but MCE is not, the tdx_dump_mce_info() function
> > fails to link:
> 
> Thanks for the report, Arnd.
> 
> The only way that TDX has to report integrity errors is an MCE.  I'm not
> sure it even makes sense to have TDX support but not MCE support.  Maybe
> we should just make TDX host support depend on MCE.

... or provide an empty stub of tdx_dump_mce_info() for the !CONFIG_X86_MCE
case.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
