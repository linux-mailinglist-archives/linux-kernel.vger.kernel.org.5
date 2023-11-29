Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2087FD418
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjK2K0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK2K0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:26:45 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EA0CE;
        Wed, 29 Nov 2023 02:26:52 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0FB7540E014B;
        Wed, 29 Nov 2023 10:26:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id J8iTi8UrJN3P; Wed, 29 Nov 2023 10:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701253608; bh=DHggPGZfBwgIBHzG+ag08C1/iwzJsSEUaetoMxEuSpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b0JJEz1LsNlNl26Nl6FFpprqeotEP+k5W3qHuGF9MKBCzNDR7ptwsLYudxfPQAUdp
         RRUdT4Rrj4a9hbX5j7fwGprfvlsVAfdrZw4T6BT4WIItS8Ov/b2HmcJwU6Av9uDEMb
         WZimq/eiterIy44RMaW21ds7lBsPPqkjxK+gUbr+mmnUGUxSGtC+jWkSMiNElIh6aP
         2fXLU9Tn8G5CZcAJmmVOWWV3/M0rkZ0a5FUwvO0yE8Pj+dvTmnZbr1RJsk7fQ3yNBc
         42Lb4uZ525EEOE2HK6+2JgI4LwEdw3hOV5nIakaHzZYJJHjMsuFo6IdTYGiQ/ietuF
         NpF9cI2C1iKTHibwb31CL+14SPW8apu5KCwSXTb/tS+gzwwE+Ef/izskim5jtF9CKr
         kisxUtoYdqtgMZCTCTqCCvZsgMkvT38VEVd741fDGvFf/Dd8X2Hs+ycPUMlidGaInu
         ezMQkfo3RXBp/Cli5zGGrPbnElvb0qotoLTb32HD0BsJTjiPEzYWcICBlMV2hOcLk7
         qV5FKBN89Pcb81aKRBOkgY5cjugRJ77GQOObaTdCBqq3I8qjZtO57zG+gtDI/JfuEX
         AwaaJY1gW0+y74Ff4VoPY5UspaIzzjhS7hx7lbauJupHzIe3Dj8X3AjL2BfK6HqC7U
         LhOon0ZgXaH96Sz4mGMsyojc=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 33D6F40E019F;
        Wed, 29 Nov 2023 10:26:44 +0000 (UTC)
Date:   Wed, 29 Nov 2023 11:26:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Muralidhara M K <muralimk@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Muralidhara M K <muralidhara.mk@amd.com>
Subject: Re: [PATCH v3 0/4] Few cleanups and AMD Family 19h Models 90h-9fh
 EDAC Support
Message-ID: <20231129102643.GUZWcR41I6YVcdM80Y@fat_crate.local>
References: <20231102114225.2006878-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231102114225.2006878-1-muralimk@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 11:42:21AM +0000, Muralidhara M K wrote:
> Muralidhara M K (4):
>   EDAC/mce_amd: Remove SMCA Extended Error code descriptions
>   x86/MCE/AMD: Add new MA_LLC, USR_DP, and USR_CP bank types
>   EDAC/mc: Add support for HBM3 memory type
>   EDAC/amd64: Add support for family 0x19, models 0x90-9f devices

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
