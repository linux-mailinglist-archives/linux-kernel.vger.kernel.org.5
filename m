Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B757D83BD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345076AbjJZNke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjJZNkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:40:33 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8DCBD;
        Thu, 26 Oct 2023 06:40:28 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 12EAD40E0173;
        Thu, 26 Oct 2023 13:40:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RzOIqalLTNoT; Thu, 26 Oct 2023 13:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698327624; bh=sIsfuwJgDJcV/k4vTzcoZvNnZV1daWQEdSBGoijJNEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A8ZOE908YEMIJ6YwwxI39IPnCp8e5Fu/A/1QxuZ+SMc2i7aoaJkW7KhggYFcUfnZj
         lrnZVbQSlhoqOz4NLW3C4A1jaPGprtmIWIc6E21x65Db1f8BnkQrCeMNOMNmlYvE+i
         P82nVdjh/M9VJl7HTHf31n80SMOiROwACb3nZDv7rtVaaIG64C83JSgL5raXGBufK0
         7Cw3JlbKzAmpGHpILdYw4J5qmUoJU7bm8UlnQHr0fOf/swR3CNWrPCcvZ9uROuHrod
         e7Zlc4Mgj7EjYyNnAmDvTwoQuBeuGKssbMnx1TPCZjP+Bg6E1dY7gFkCj2l5rfiN2K
         NFznbpK+aFdZIp8h48mxUtHmxoUbN4UQbypDSjV4lq9cMgyRvE9ZQnhmpwL7o33Kvb
         VA3e1y8HmhUffTLpIIjRrGiUtZRjGQp6rNXLQjqGyhKF6h/CH9Z1uwDQqIMokI6/KU
         ycHwg8uZX4UTyu86OoBoJwvJvFH36eoYmsRvg2MlzMm+4sUMzWiDlSZtBy2meWwCkr
         yNRUjTvNbdl7BpV/B1PAT18Q7p/BV++3LqP5ec1EpIw9n+XUsYnWFvGI4SOFnT/HK1
         syGF78r7dMpfCzCEDxSSqIc4RXRg1XR+ga/fLoBytR1oErjwTqrGGw2AfOb0PXnBw5
         MfYg+8ysRKFHInAjqywNj2ms=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C8AE340E0171;
        Thu, 26 Oct 2023 13:40:17 +0000 (UTC)
Date:   Thu, 26 Oct 2023 15:40:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     "M K, Muralidhara" <muralimk@amd.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        Muralidhara M K <muralidhara.mk@amd.com>,
        Avadhut Naik <Avadhut.Naik@amd.com>
Subject: Re: [PATCH v2 1/4] EDAC/mce_amd: Remove SMCA Extended Error code
 descriptions
Message-ID: <20231026134016.GDZTpsQDYU4Ll6sAA3@fat_crate.local>
References: <20231025051455.101424-1-muralimk@amd.com>
 <20231025051455.101424-2-muralimk@amd.com>
 <20231025190818.GDZTlnomnaT8zxnbxX@fat_crate.local>
 <b3b21eaa-226f-e78f-14e3-09e2e02e38d6@amd.com>
 <20231026111448.GAZTpKKLI6LG1/COFE@fat_crate.local>
 <850a3e78-f663-c696-2141-7aefb043b6da@amd.com>
 <20231026123754.GBZTpdojw+pNuZMyJy@fat_crate.local>
 <dd13363e-fd7e-4e88-8c23-91cfffe11dc3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd13363e-fd7e-4e88-8c23-91cfffe11dc3@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 09:05:51AM -0400, Yazen Ghannam wrote:
> Post-processing is one of the features that Avadhut implemented.
> 
> https://github.com/mchehab/rasdaemon/commit/932118b04a04104dfac6b8536419803f236e6118

Yes, now try to decode the error with rasdaemon this way, by supplying
the fields.

Then explain step-by-step what you've done in the commit message and in
a documentation file in Documentation/ras/ so that people can find it
and can actually do the decoding themselves.

It needs to be absolutely easy to decode those errors. Not tell people:
"go look for the error description in the PPR".

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
