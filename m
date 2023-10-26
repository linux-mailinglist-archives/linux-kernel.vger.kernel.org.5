Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B21B7D7E59
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344229AbjJZITd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjJZITa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:19:30 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885DA18D;
        Thu, 26 Oct 2023 01:19:28 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AFA6D40E0193;
        Thu, 26 Oct 2023 08:19:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id miETeyDNecaP; Thu, 26 Oct 2023 08:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698308365; bh=FLyi6K3NlpurWfjpb6E1lsCEGhT/XD+cFeN9++oscSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=asXgmWGFIDJqPQGUFXGR+Ue8NsYgX/whplw1kBJqDOBMHooOAyUkvEyZjTtTCllyZ
         sg0dRmsIld6q46y2Own+deM7Q+LnbEtogjjKUShAWHSFID8JX9PAhHHz+n+4zgbnUh
         PCepMj4lTlr1rwI3hIwNqCOtXBni66oumSR0yoohcWeopJZ7pCi9ywbJNj3RJMayKr
         wRiI2H9VDImpfFCEx6Kn2LWo+RBIJMYNmOMOntbQKqzGh9m45I21no3mdQmJzhgZM7
         s41gm/NPKpsllGU3Vr6nMmu/3mzs3sWzhtkpSNhbSk2lUZOBdMdItFHPsk8NLjTe4c
         qzJUddm1POaS3d+egTstdLVIDoVcUFltP1Rph7yurT1ItEIQ33zlTz3klnPBUu8Its
         8fcQkMcnGtVpEpFkAywpza8oET8k50p8vVw/0sBkwQPqwf/n8GtQMm14TRa4xrrojO
         teIbnMGcVWgzRoXif39Yzau7EK4/5hB6vyBIun1a0UX2Oo1ktc2D3RMrvMn/VcT5yG
         ifDqwnCmttwmIHxJKmvcTGoYLvuts3Jd62CK9efpY0O87ySLdXrD5gGoz2JG16d5+U
         PXDlB1z8Ni0i1TbdnH8J5cb+SYWOYoHA5bj7q5vsL4ptkyU/y46czgo4w1bV+BG5Gp
         vjV+TLqAHCeCY1QLJo9jZqTI=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DF21640E01A3;
        Thu, 26 Oct 2023 08:19:19 +0000 (UTC)
Date:   Thu, 26 Oct 2023 10:19:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Muralidhara M K <muralimk@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, Muralidhara M K <muralidhara.mk@amd.com>
Subject: Re: [PATCH v2 2/4] x86/MCE/AMD: Add new MA_LLC, USR_DP, and USR_CP
 bank types
Message-ID: <20231026081911.GEZTog/4+zbd2wRK6u@fat_crate.local>
References: <20231025051455.101424-1-muralimk@amd.com>
 <20231025051455.101424-3-muralimk@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231025051455.101424-3-muralimk@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 05:14:53AM +0000, Muralidhara M K wrote:
> @@ -119,6 +120,8 @@ static struct smca_bank_name smca_names[] = {
>  	[SMCA_SHUB]			= { "shub",		"System Hub Unit" },
>  	[SMCA_SATA]			= { "sata",		"SATA Unit" },
>  	[SMCA_USB]			= { "usb",		"USB Unit" },
> +	[SMCA_USR_DP]			= { "usr_dp_pcs",	"Ultra Short Reach Data Plane Controller" },
> +	[SMCA_USR_CP]			= { "usr_cp_pcs",	"Ultra Short Reach Control Plane Controller" },

Why aren't those strings "usr_dp" and "usr_cp" too?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
