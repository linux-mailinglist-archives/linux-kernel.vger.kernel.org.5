Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45A575B39B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjGTPzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjGTPzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:55:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385FD1734;
        Thu, 20 Jul 2023 08:55:47 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9AEB11EC0A91;
        Thu, 20 Jul 2023 17:55:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1689868545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PmNbUxyEE0l8Z9YYKaE3k/0qpfJpr5hMoskcLrvm7zc=;
        b=ICiSdZSBoO/DByWJtVET1EfrKxhw7Wn38YoXWNI2c9Zu6gdOJKfQRB1QystE/OHEfqLfku
        +8ogBZuOt9KVbCO/dqi9DiMd97w79l68SJ73dWw1Um4cR3+0QkMVn7TuvEkx76PqirfGRi
        I4QvI1YgBPCuPkmpZnqjwNWrLltVY+Y=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9wutOKxgZUeM; Thu, 20 Jul 2023 15:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1689868543; bh=PmNbUxyEE0l8Z9YYKaE3k/0qpfJpr5hMoskcLrvm7zc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KMfzzMP6eU7l+/JBybIe8nV6z1zbtlyQHjd4d5ur23PeKfIFlHreojSTSFwlCtvY+
         4C+kUaknQ8d78jsDVajE9LmLLMGLeg++24CtbQVC3gfhTR9rK/i96Dx0GP5Oi2A/Pk
         YlWU0DmLB4vXFLDkF7htwpKSnuKhE2snyv0U6d2kp6cIuXHowCZfG5AbriXfITlvfc
         tEwwPYDwIIgyRavWrBS2CLYOH8KEEQofMRNYhHZls02PMtgGc+bi/lOSrwDNSrZXYb
         eNJp5fP0k52a1KSAJw8QuGgKLpVqjIKBMNTv/D/t/P54GfwkjTRDvWXOpjlcdiFQv3
         jfhR1XjJDSfb5mGPHBY8H1Yi89aomM0D83Rb7moD+PNwIE4fHwsFP0zWA+58npXNFJ
         +/8ZyDRXKNV18vLSLyarXlsG7O++oha5lsNiQpF4pj8OQGk0yTAlxaAK1DCRRNB0AW
         jy4KXXLkgQSVC2TIlG5Gn/3uCFpaXHwWvll+U29s1CTsoHb8f4a7OID5cBR74NGulW
         jyLsZ4bCfMvlWTh4IAhQvrK8ixf9pbtDwxGGDP3AdlWU3h5fDoGuvXT88s9Ik5PgIH
         GhV/8rzGtr4Guy6Ee0PMyydR5dKlFrWsLp+uGQDJBmiZL9vNWOV+ukV13FDA7Lca2/
         hGwJYzgGKBkmgeOfyW63NYcg=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 32A7040E01EB;
        Thu, 20 Jul 2023 15:55:34 +0000 (UTC)
Date:   Thu, 20 Jul 2023 17:55:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "M K, Muralidhara" <muralimk@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        nchatrad@amd.com, yazen.ghannam@amd.com,
        Muralidhara M K <muralidhara.mk@amd.com>
Subject: Re: [PATCH 2/7] EDAC/mce_amd: Remove SMCA Extended Error code
 descriptions
Message-ID: <20230720155533.GBZLlY9cgqIZb2kd5J@fat_crate.local>
References: <20230720125425.3735538-1-muralimk@amd.com>
 <20230720125425.3735538-3-muralimk@amd.com>
 <20230720135950.GHZLk91jGbX7l+7AMz@fat_crate.local>
 <b70fa364-2f68-1336-8d1c-7687f5c4f1b4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b70fa364-2f68-1336-8d1c-7687f5c4f1b4@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 08:55:01PM +0530, M K, Muralidhara wrote:
> Pull request created in rasdaemon for the same.
> https://github.com/mchehab/rasdaemon/pull/106/commits/09026653864305b7a91dcb3604b91a9c0c0d74f3

I'd like to see a single error, once decoded with rasdaemon, after those
are applied, and once with the kernel, before this change.

Then add that info to the commit message so that people know what to do
when they see an error and how to go about decoding it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
