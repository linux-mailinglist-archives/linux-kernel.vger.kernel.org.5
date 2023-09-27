Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0B97B0355
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjI0LuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjI0LuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:50:17 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B02FC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:50:16 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9EE8C40E014B;
        Wed, 27 Sep 2023 11:50:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0riOTFrn8l0L; Wed, 27 Sep 2023 11:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695815412; bh=IMkSWjwCZ0AEwZ/ESSb06K1/xR3QElwFkAAeun7UW0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J20HGBS9gAldoeyYQyMfdiykgS8ER3YZBMBn5TczuaAtJ2DkbE9baz+f+k2vyP/D2
         ldS3PUvW4jvSZNh2RIiKlS1e8aQE1NvNwerEJYn8v1TG2ObrJcfhd9yF6tr0XBqmCw
         JCUFSc/1RPClV25RuelXeqlnSZJp4M1CMCnDelqWk/8Inx+jofgdBlAz82G/fpCTJE
         LZ+vA+6zcm5d2veAbVWCnS1lfFeDZR1M58BZUCdwOQo1uLrraC7BmXC3tbyi4dmiYk
         d7XFGeblvsQLmsjHpI6/WsUa+AlDB/LUzrKgTbHmQiEh6yS5YdRpvFLpJdmtfFkRuX
         M5NuCUMibLqwL+6AysyBWL/DaiH7OSxa92uvev+FQk09VGWBXZUX78MqG5awpuN0dO
         8wTdOhjvyH3HmP+7L23W2bzUbPR8AlP2ymmUjCVtx7JN1pw5vPvl6FUpm4T6Cz8Qsq
         1jQ2wAGRsHK4lJHlVVcoqZg1vmTsSYGLvKIzAKj2mL/+URasIf39Mm83vFFWqcMrhk
         pmDo3jdI42+7tE5HTcMAirDPpqvBRwU9QTvM/W2O99Zro79W4NJeYtZz/s4jKynovh
         UApqzsBVfqDChey51EKVQIjoWAwO6Z9PpQUcOTVbKcNWpKd/1eKBuvdc3ybxtRHzUd
         Prn7y4dPFg8v+/ZMi/zpfKtA=
Received: from nazgul.tnic (unknown [2.247.249.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 67F5840E00B3;
        Wed, 27 Sep 2023 11:50:06 +0000 (UTC)
Date:   Wed, 27 Sep 2023 13:50:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 23/30] x86/microcode: Provide new control functions
Message-ID: <20230927115000.GDZRQW6LLQlUvxzRW1@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065502.202675936@linutronix.de>
 <20230924065824.GNZQ/eEKAO8IaCcUJU@fat_crate.local>
 <87pm25feyr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pm25feyr.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 11:42:20AM +0200, Thomas Gleixner wrote:
> No. That's two different things. The write above stores the information
> fir the current CPU, while this conditional constructs the command for
> the siblings.

Aha, I was simply pointing out that you're not checking whether the
primary got updated but writing unconditionally SCTRL_DONE for it but
you check ret to know what to do for the *secondaries*.

The actual check whether the primary got updated is the
ucode_ctrl.result check later.

Yeah, that's ok.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
