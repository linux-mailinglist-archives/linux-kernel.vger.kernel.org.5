Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E85F7BF55F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442643AbjJJIMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378097AbjJJIMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:12:00 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08158AC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:11:57 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E2EE440E0187;
        Tue, 10 Oct 2023 08:11:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1q3oJ-L2RmN6; Tue, 10 Oct 2023 08:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696925514; bh=37TX1AbiwBXfHBA1vQjyIgqzyHXSm+wB84YosIjsBNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h5Ch5RxWblHeIY5kJOdjd0ak51gqZWWFJe8dH76LjSFza+4ym/WzQhbNecF03hnl8
         61rpyX7GnBdF0WmtSmYY2cC4tJZa900hyVuSaMqX75JzttGpD2BRqdd3plN1rIUTTB
         6RsSa8p1pKcAquXqohQ/OlyJbCMG43+wXffC+q6ZBpacEtkMw/JH8LU6QUy1xlGSFX
         7ceHAo377/4+llPN1TNZL7YbN8cFAssj0XzyD/NQGXZ3+0cyNUfM+MhtKxZo3iweJM
         1zH68h1kk952k88gririuBmcLpgoBdxIDlxog6XbLoKDa96dy8B0SpAL9ZloUs/QcE
         eNEb0l+IYv07C/4Ms5CeqwHOaexdxRqKTiipsUG7Fq8XY56wYfVzc2gwxjW1vmvJKI
         04stvR+BGDdxstr6fqTVY0/7m+IUVwrMjEFl7O2Yy0rPhq/tGF67wO8AzJgYq4ZnXl
         fPouZ/ceLkUeWUnR4J1RBYB1T/yZyvUoFykH2di01eAVKXRopXW65RKAwG4KFQdGxo
         VrAajNFj4Nbwf/Gt14JnkAMp1mU9n8KTRA1TRSbvpq9RhQFYXOOPk7xs7/cki82yWx
         ZD2BUJSpx2rAKSLeR2O73kRmR4hr3VjbLBsJa5cPhH9SKzRQ/ZOSdBrKIk4auzMjk7
         1+I6t0f81M8TniReR97y3orM=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1A69040E01AA;
        Tue, 10 Oct 2023 08:11:47 +0000 (UTC)
Date:   Tue, 10 Oct 2023 10:11:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [patch V4 00/30] x86/microcode: Cleanup and late loading
 enhancements
Message-ID: <20231010081141.GAZSUHPQXt1F4FzNZ2@fat_crate.local>
References: <20231002115506.217091296@linutronix.de>
 <20231008085456.71646-1-qiuxu.zhuo@intel.com>
 <20231008130840.GCZSKp2NbHAOB3h69z@fat_crate.local>
 <CY8PR11MB713415003139D301D51824E789CDA@CY8PR11MB7134.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY8PR11MB713415003139D301D51824E789CDA@CY8PR11MB7134.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 08:00:27AM +0000, Zhuo, Qiuxu wrote:
> Test Result (same as ucode-v4)
> ------------------------------
>   Tested tip:x86/microcode (top commit 9975802d3f74) on an Intel Sapphire
>   Rapids server that both early load and late load worked well. For more
>   details, please refer to the test below:

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
