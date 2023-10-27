Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8F37D9B60
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346023AbjJ0O2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345952AbjJ0O2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:28:36 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4F3DE;
        Fri, 27 Oct 2023 07:28:34 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7CF4740E01A3;
        Fri, 27 Oct 2023 14:28:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id R8JJ8r0MP1Kj; Fri, 27 Oct 2023 14:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698416910; bh=2u//ozi/XXZR+GyRFZMcYbB1v/LhaSuUXqoK4ul8j3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S2CqvAkcOG1TI0v8svUhj35EyMyA0VY4Ri5dnCAyXagKLBGsPs5yWne3gFMILr8Rd
         K6xncEwnJsB8x1v6B8j/BLmKdvs/n0LNL7ICes3DIyuR5cVqtS7fD4BJ662LfwUno2
         S1uVKD56kmbj5UtEge3NWYHHMFaPEkGwBSlYNk/O0lJCxpry8ZIA6iEcBYypq1vq5q
         13INUZADVRpR9rBBpAUZHxr2Csu91JufG36NdKR1fwjQqsccDBBwP5WRpp2QmEce9G
         V4ggDM8LNDuJliwY2Fgp6rBX2PXAmpGcGKyFNqjPJecBwDToAbI7ox/oLsSvoVnAha
         90iIZDXrfuKcTAR5R+AQ8bvMeZ0BvfhA8UObXqnMvkElTjC+NII+md8P5Zn4XrFXgs
         tTg64FvXjrtJlU9hpsnksBmTPDfPyZFURvE6QoXNYWG8+CG5/ThpdtPdVuIUVrUh3J
         NNoQ1O5woC8Z3QC99t7YEwDQhVfiEfk4mozueEoz4pX2XlSH95HLLDFrT7y3LpaZ1G
         YFPf9+NZuHluU789ZsfJ/Ci+UN+9739fEXIjBMn44ye8b2sQQdsMPjd+GI5yCe4YSY
         QUMDlPgb925dsy5aKg/G1OsKGglfDwh3ObVP2RuKzxVmPZ/tSKDr7lbCHDtgBCq5wl
         CeXSn6xBwVWeBEhT3MokT6wY=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5F6B840E018F;
        Fri, 27 Oct 2023 14:28:23 +0000 (UTC)
Date:   Fri, 27 Oct 2023 16:28:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "M K, Muralidhara" <muralimk@amd.com>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        Muralidhara M K <muralidhara.mk@amd.com>,
        Avadhut Naik <Avadhut.Naik@amd.com>
Subject: Re: [PATCH v2 1/4] EDAC/mce_amd: Remove SMCA Extended Error code
 descriptions
Message-ID: <20231027142822.GFZTvJBnmAEWLUGbvQ@fat_crate.local>
References: <20231025051455.101424-1-muralimk@amd.com>
 <20231025051455.101424-2-muralimk@amd.com>
 <20231025190818.GDZTlnomnaT8zxnbxX@fat_crate.local>
 <b3b21eaa-226f-e78f-14e3-09e2e02e38d6@amd.com>
 <20231026111448.GAZTpKKLI6LG1/COFE@fat_crate.local>
 <850a3e78-f663-c696-2141-7aefb043b6da@amd.com>
 <20231026123754.GBZTpdojw+pNuZMyJy@fat_crate.local>
 <dd13363e-fd7e-4e88-8c23-91cfffe11dc3@amd.com>
 <20231026134016.GDZTpsQDYU4Ll6sAA3@fat_crate.local>
 <ba6eea97-116a-4678-7800-d24692c65cd6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba6eea97-116a-4678-7800-d24692c65cd6@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 10:35:33AM +0530, M K, Muralidhara wrote:
> Observed the error string as "mca: DRAM On Die ECC error. Ext Err Code: 0"

Good.

> Thanks for the inputs. I will add the steps in commit message and in
> Documentation as well.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
