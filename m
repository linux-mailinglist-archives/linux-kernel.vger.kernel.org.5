Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60D88111A2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378998AbjLMMuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378964AbjLMMtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:49:55 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288A3113
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:49:54 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D4CB540E00CB;
        Wed, 13 Dec 2023 12:49:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wLZBCQYyXgKT; Wed, 13 Dec 2023 12:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1702471790; bh=d6/WJ4YGI+jyt5pi/YBaJSCHvFgSbXE/GIoeVHXiKYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kUSDFGgys4sDCIa7PGsKyvy+gM1VsHPua6qqQO6CZuklDTqj8f+FHflztybGPYhTz
         Z1Td7xgUNxtJXkjsGD5chNmdPzvfn7uhs6PaO31TX37FEsr2pB2J0sfhAUIcRdP6L8
         FoOXmhMGSVphdfqaVRH7+/FbvlabU8laHNYSjScwaEb9aenV02MQKNIdIYvNslebgR
         4J5Q5L4ROJC1nkcXDTrt6O++b6otbmTYsYSafoJUz06+KpDudMDE0NII1gx8LV2AEK
         zZtnbGycpZH7LlLMBlztdfxvzZTUcGmAr52haEBHmCQ6Od7RkMuHQoVKkaM39ilN/1
         VIImH8Xol79PJq7Px833ca8RQtNMwq624WKcdn97x+2e2egfJb9Nmee4W8PYK4Aj64
         m2tJjKLqVub0XL5gFjbRyKxEn4uf++muJWwlRRCI59IB21lM3Fnoq8Kv443u+ePizS
         OAsqspqgR/6ZEqxoODVGKPh14+9/pZtxkZTgHwj4Y7NFDsN8l/rdqJcDE0GYHxpgYj
         +EJtmDPQCBJ1ylja+Kj9ddQkyfuJcbvO62gRjLohm49r3C0w8c8YAL0lL1gPbQYQ/K
         /fWd+009RVWkX2DHYPTRk+usjIUcm/bEuxJMmm41h5u6OJV3Rf3fqsd78xQdcURpLZ
         CblmCs2YpydqfZxwib/qX/1s=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B947740E0195;
        Wed, 13 Dec 2023 12:49:42 +0000 (UTC)
Date:   Wed, 13 Dec 2023 13:49:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Paul Dufresne <dufresnep@zoho.com>, Lyude Paul <lyude@redhat.com>,
        Danilo Krummrich <me@dakr.org>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: nouveau 0000:01:00.0: drm_WARN_ON(!found_head)
Message-ID: <20231213124936.GCZXmoYDq8nMRs75XM@fat_crate.local>
References: <20231111120323.GAZU9tiw8e0RSzCGB9@fat_crate.local>
 <20231212224037.GAZXjhZUDeoq50xKJ5@fat_crate.local>
 <18c613ec092.ae61cf7d6029.4389632938517239705@zoho.com>
 <20231213113936.GBZXmX+MKqX/qOnPn1@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231213113936.GBZXmX+MKqX/qOnPn1@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 12:39:36PM +0100, Borislav Petkov wrote:
> We're getting close to releasing so I guess we either debug this or shut
> up the WARN.

Not only that - panic_on_warn turns this into an explosion so you don't
want that in a released kernel.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
