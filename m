Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE7F811A77
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbjLMRH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbjLMRHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:07:20 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3689EF3;
        Wed, 13 Dec 2023 09:07:25 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4A1CC40E0140;
        Wed, 13 Dec 2023 17:07:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pzzkre4G0Fdr; Wed, 13 Dec 2023 17:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1702487241; bh=tnalonuSvtbaHim52T8UmyOGCiGnMYIov7Q9CB01r1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vb2gH1War2cglpBafh8wb8dmFrEsaH+57kNAQeu1niWV3a2RMCEbPETfLXv8IhXpY
         7S0eNqsMOgi90MdnyjPAETDOjDyp7qQ4yjvFxY51H2k9hXwMYYdzoFxcufnxCm7iNk
         IrC4hTBTQCByCYWYSCSee4ix/bZce8fDxi9tP40sSUnNmMjrQkcAkw8oGXF8/34o8U
         H3jin395pLsfZdVdusONkidBQGT2fE2qjN/w5haMN191IjN1gi/EGuAsPw/Vc8lT5s
         tTFrk81rCIzccB5m7pZj8sOAT8sjqGMIiTnPrCW53MmlS8hyNM+icLPbo90CAe+mfl
         u4ArEvI5///jWTXp/ZX40OYVAvf9zaovAB7gTDtvFNNirMC2HmAs5mhlhQwXXu7hyc
         XnYsybTxIIgJ4qTww1lI6rL2ydHyqrxVOaukNR26DarFTD4MSfU7fNqCnVAefB28mr
         o4Rn8/qzpq8D9UM8J0f64HiGJFDp7VKwqllbIq+WhGBnNoUmyK6O9ircoT2xrLDTQG
         219nlS68HlgIsPtDqa3M/gTe7YksDR/kqUIgWfz6DLNlzrK3hKrtEeWPqMJmwOuTdp
         RoaERM9UtL0XBqeLsgc+oqdGISH1i6kVZnKNS2cU0qiTPFciRcCoguFOjudX6+GOFM
         5tLokxrXrdrwBB1Gl7Wh7gwY=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2AEF240E00CD;
        Wed, 13 Dec 2023 17:07:12 +0000 (UTC)
Date:   Wed, 13 Dec 2023 18:07:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
        john.allen@amd.com, william.roche@oracle.com,
        muralidhara.mk@amd.com
Subject: Re: [PATCH v3 1/3] RAS: Introduce AMD Address Translation Library
Message-ID: <20231213170706.GIZXnkumZOYAh2H+jx@fat_crate.local>
References: <20231210194932.43992-1-yazen.ghannam@amd.com>
 <20231210194932.43992-2-yazen.ghannam@amd.com>
 <20231211195739.GIZXdps9DNvOgCR5Xs@fat_crate.local>
 <295f3cc9-6140-4813-b107-8c8b60f8aaa1@amd.com>
 <20231212153449.GEZXh9mSJ5epD13Dp7@fat_crate.local>
 <b9beb435-30e4-44a3-b27d-0567a8e873bd@amd.com>
 <20231213164837.GHZXngZW3TYvBN41Ma@fat_crate.local>
 <58d1f6a6-458d-44d1-8bcb-adb90aab50a5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58d1f6a6-458d-44d1-8bcb-adb90aab50a5@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 12:04:04PM -0500, Yazen Ghannam wrote:
> We could also introduce another software feature bit for Data Fabrics "DF".
> And this could be set when we discover them, like in the AMD_NB code.

And a DF system is a Zen system and a SMCA one. Currently, at least.

Ok, let's leave it with the two feature bits for now. We can always do
the DF bit later, if really needed.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
