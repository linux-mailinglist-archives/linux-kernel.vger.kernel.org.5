Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5B4755ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjGQI6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjGQI6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:58:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA11A1;
        Mon, 17 Jul 2023 01:58:48 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 349421EC0D07;
        Mon, 17 Jul 2023 10:58:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1689584327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kF/W+amDBG2o5DajPDMR3bUWIkTNTpEPwQF8fpDPL2g=;
        b=K1lvRZU0Q6joX1WxiVMc4KY3MOdNF5HV5lxyL0AyfPuMDm4VsWIlqUZLx1jNyIzw9IT0Gg
        1MuPMEUtULLxhWt/oMb7g9UblNK65mWSSzYY1yaikVD84HKJq8g7vINyJ/XbwKt5QAY3Wq
        XIuArlnvKtyl9P1asiinm+Twr9ng1fU=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bc0QwP2YFfnS; Mon, 17 Jul 2023 08:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1689584324; bh=kF/W+amDBG2o5DajPDMR3bUWIkTNTpEPwQF8fpDPL2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fR298Cre1+6wERBkTxJXDzLOUySa7lONCTAjiF1wD9KgiP9ggDJuSPjut8Vk+KAFo
         JRdEQV7dyNqvCf6/rn7pew9EgHSIa8MKVzBIjk21m52b7zJaL138hTAxi7TfHrvAix
         i6bnfpPhrEJSDpAKnuNF6EWwlRnWM7PwvOKJeswBtKmCSdl//6Iv+YFBkReuvQbk2X
         EjCnAzC1TQMEmnkSBmxfy5PZTRzNklOfNXCQejr3eavdSC4Qp5A7SJllDtCPxiUO93
         w4AkXWEqkZYQ5UduAaeNmYhZMThpJRf80ckur1C4IZPh/9mHVJK8MkJcn8NWKlCtJ6
         G6rxlcUm+Xyn3kdmotleU3nMHTik9HcnGfLeBXyLu2k7zd9e6L5vTSRaP+N8JvAMBG
         m09q5Zsa34QRkBWqHLJv/HIOBPXbvP9l/v04XQ4pY442ZV0vBDkah5dIFAV10XHEoU
         WvV/nzFPnnJfkFRUoTD7ZfCcuwo2nMlGTQlU+r1PSszoBej857GKEpOJ9xgfmw433z
         mMR33TC+t+OhJfQdMq2GXCIyoMEahXFe1y+QFPQ5p7HCwCgNvUulbY+RLFxI1E2jBZ
         pTBhx4SomIZeNBdkX8N+esbSjFBsl8TX/mT+mYEtpm1fBQl7DX4v8kbMfz0Z3R3irI
         KYopiexJa59hZaTUPZ1HdLco=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E50D40E0033;
        Mon, 17 Jul 2023 08:58:36 +0000 (UTC)
Date:   Mon, 17 Jul 2023 10:58:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v6 2/4] x86/mce: Add per-bank CMCI storm mitigation
Message-ID: <20230717085830.GAZLUCtnXOFyZONLXU@fat_crate.local>
References: <20230411173841.70491-1-tony.luck@intel.com>
 <20230616182744.17632-1-tony.luck@intel.com>
 <20230616182744.17632-3-tony.luck@intel.com>
 <20230623120904.GAZJWLYMP0XxIr5k7s@fat_crate.local>
 <SJ1PR11MB6083EA4CED8706C77622AAF2FC23A@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083EA4CED8706C77622AAF2FC23A@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 03:40:25PM +0000, Luck, Tony wrote:
> I'll wait for you to finish this analysis before I spin up v7 of the series.

You can go ahead and do the Intel side only:

https://lore.kernel.org/r/04c921ad-e651-e1fc-a3bd-8c40a77a4ea8@amd.com, at the end.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
