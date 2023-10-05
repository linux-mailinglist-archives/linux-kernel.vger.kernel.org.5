Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B01B7BA2B4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjJEPpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbjJEPpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:45:00 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCA765A9
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:32:14 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 97E2340E0177;
        Thu,  5 Oct 2023 14:32:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iSRuRWp6bIbw; Thu,  5 Oct 2023 14:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696516330; bh=W8ijLfP/dWraJu6jTU1jtlOh7n+kMPxe2wyR63bLRRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XktgFavMHcxTPqD1OiBexg87RU5b08+sfXCLHfPcXBQKX7mEoJhC7fk1PRFc+acpJ
         QemObipRUDzTn+OHPnsJB6X7bI+0CApoa2oFrHAIuIQ92u8JtKSDd5I6MqTHnvBFIa
         foeASfpnXuTGN40JyflOIY73LzgfCuCWsS0Ee14872gWzTwAvTHacUj44FrS7JF9XG
         3xN5GAfbNJO+nhoZF4oWxcUhiRGwyBmNikUoV8MG0bq1X3iUfF5zuMOvkNVLPvlf3J
         0tsexyCILZQrBFJXijy7cD2CsU2ZjGp1aPmFRvzyx3cHAuJP0VIKg5wGEiOWKb0qRV
         D7yPk1DP672K5OM+MOzQpn/nDuzrqucQ7q0NXrN5l208jpMlU4qRhXNGJ4bXNeIUOF
         96gyyv0j356HltYYZpC127zlZJQBeaTN0sr5IyPvZsoL2v7aDTal4ETgaCXXurvqyP
         WOOPj1Ti2sgpmJFm31QxWQxe4p/aZkDka15sz5j1vip1tCU3wqM5lJJlzs0mgAOIfE
         mwjyRjD7ildA9+3cZAlz7tXPMETQErWdoCS+EQ37qM+bb6U6u/B53hVpTSdOo8yOCp
         XYwIqtenCNXiM9MEbCfBQuGYMJT/DeJvjrEw/nHUAF/LfEi36U593GwJkR56k2e5be
         eVNrbTryFgoJ+iHP01DMqRLo=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C617040E014B;
        Thu,  5 Oct 2023 14:32:02 +0000 (UTC)
Date:   Thu, 5 Oct 2023 16:32:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Nikunj A. Dadhania" <nikunj@amd.com>
Cc:     thomas.lendacky@amd.com, x86@kernel.org, dionnaglaze@google.com,
        pgonda@google.com, seanjc@google.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/14] Add Secure TSC support for SNP guests
Message-ID: <20231005143201.GDZR7I4WHnkuKF2ddl@fat_crate.local>
References: <20230814055222.1056404-1-nikunj@amd.com>
 <f200403b-c460-5ebb-fec5-c5caf0cdb006@amd.com>
 <9a6af215-e696-5091-69fa-1cbebe772471@amd.com>
 <20231004070100.GAZR0NrFSIDKPSQIjA@fat_crate.local>
 <1f740bdd-666b-4686-8d04-1c28da9917bd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1f740bdd-666b-4686-8d04-1c28da9917bd@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 07:27:43PM +0530, Nikunj A. Dadhania wrote:
> That is a good idea and I wasn't aware that this may work as a good bribe [1] :-)

Whatever it takes to get you folks to review each other's patches and
get more involved in the community.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
