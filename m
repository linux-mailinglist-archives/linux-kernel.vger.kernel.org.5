Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB437D819F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344776AbjJZLPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJZLPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:15:41 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26612191;
        Thu, 26 Oct 2023 04:15:35 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 91FBE40E018F;
        Thu, 26 Oct 2023 11:15:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aj2PygeIpYNP; Thu, 26 Oct 2023 11:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698318900; bh=6lLTxehzg5LTyCTg0BbwA8hoIYkdo1cZRHRyXi1xQXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jf59Te4NzBJ44tqUcej6MRL/BL2YhvMqfNHHRZwDlX3Qm//B5OdkoBNw0gi9Ro/dD
         ldwzFGvnp+pnkDwpvvSbXhN6lXt/Up335lc0HSHZDHy0BY5/ZzMnQY8JFrPJAEX/V2
         /U7280m79CSs2B3TmBAqLMXC2bj9XCrrLWc209OnieIPL9lV92KND3JR/KRmE8YIw/
         6wx0Y8pOPIqUqt1wdEMAfv7rCKxvr+x/BmejJyhiIOQMkCx/eYxKWgw1WJ9ptEHpXo
         FrwB8YjqRQTreX0WwSHt6Cioa+4wXyibYm6tWFXva0xEIokhHRArlfUsPrstedeoch
         Z5agIsd4rKRl0a9OSqXlD0fEa0FPgZfLCvGYArQL6vGwjWh4/tUiQlsHVr2HuE8JTL
         WKNadxDDe0Ir4wQuDTFt9kSa+Pwx0Jh6685/l9JkpUnCJ4jyXyzo04QWPYVmX0m1ga
         58mLCY11ZeoYNS7Z1N6YuVdUMF8fykwFOZDLsNRMd11TEkTpmNdgz6OxQZTzNP/Yx0
         JsrdRbN6hR44fISAmu3cG7DtI3TIzDcay75w73pnjk28CkY47Uutb8p8eO4tAXRt94
         zCo59n6r6BbyIFRuD3CZKpp6NhI74s5fvdjwwSw6+UAf/FgLsPV4THlYhClyfHmBhc
         SQbYp1Qj9YevI3jk1W/avXkg=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E9CF40E0171;
        Thu, 26 Oct 2023 11:14:54 +0000 (UTC)
Date:   Thu, 26 Oct 2023 13:14:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "M K, Muralidhara" <muralimk@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, Muralidhara M K <muralidhara.mk@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v2 1/4] EDAC/mce_amd: Remove SMCA Extended Error code
 descriptions
Message-ID: <20231026111448.GAZTpKKLI6LG1/COFE@fat_crate.local>
References: <20231025051455.101424-1-muralimk@amd.com>
 <20231025051455.101424-2-muralimk@amd.com>
 <20231025190818.GDZTlnomnaT8zxnbxX@fat_crate.local>
 <b3b21eaa-226f-e78f-14e3-09e2e02e38d6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b3b21eaa-226f-e78f-14e3-09e2e02e38d6@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 03:12:22PM +0530, M K, Muralidhara wrote:
> Executed rasdaemon:

How do I decode the error with rasdaemon when it wasn't running while
the error was triggered/logged?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
