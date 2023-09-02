Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2AE7908C9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 19:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbjIBREt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 13:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjIBREs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 13:04:48 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F51CE42
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 10:04:44 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 62C8240E019F;
        Sat,  2 Sep 2023 17:04:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Fdo6mSPMLQpN; Sat,  2 Sep 2023 17:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1693674279; bh=jYtFkfhGqhwzALUImcabSG2ADuFzFJKQRBvmYqOXSow=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=QyH/A8/PeuTRT1lUmVkJhbYzfDoUU/2eOCj+cwA9ijoropRI1g2RYJFQ9zzxc4U9A
         81RkETJe4Ohe92RerKyMH2nx4+EOzs7/O86V42EcUB+3xxHAdcWK+qHv+f4bxq5inv
         +vB/uRgHIaf9uBG2Uv/wQixaDls7dSj3SYZQu+imSWkQXo3iZ++vOEqereaEvFMfHZ
         WpxrEdwBXwD4ua0Cjh0mLirhV0re2Z1epD28rQjlfcMwWURQIghwtNKFTh/n2nAbG6
         eVcRCQpq2sikp6YW5w+1LtH4ZpVj2aHW9DML8WGMo/pkkDlVmE3UT7p4zyjK4KU6J8
         TU5HoAkHMQMJ/LcI4HQYbC+/i5S++EtY0DvXlb8k9uFeBLZWgvL/HSOzOD8XWD+m5W
         WSLu1J6mQRc65LkSUWckF8/HFiArwafb76PXMB5NvCRc6ZsRWLR2s+4aKQtd4JGJgz
         3EtWhG2+v1C8zp7kuyf9S1NueIZB0TlQl5YTlAGauhWYYdfOc31Bdu6kD2LaH7m1x8
         ymNaiZDQlQk7ElmAatztJ38VLOOVgtiDvpq7EU0aMt3YKDtwWgCx+29bV66pCCShE0
         0MN8tHXBg5XaXRvkdXSIMcx1SeJOW+X2hzrxgG7SuGkiHhVLXvdBzkaWkIVlX/HB9b
         40rLbpG9bPAXL8+mT0jBHgQg=
Received: from [127.0.0.1] (unknown [46.114.142.117])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5606940E0198;
        Sat,  2 Sep 2023 17:04:34 +0000 (UTC)
Date:   Sat, 02 Sep 2023 20:04:07 +0300
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
CC:     Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-tip-commits@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Btip=3A_x86/bugs=5D_x86/srso=3A_Fix_vulne?= =?US-ASCII?Q?rability_reporting_for_missing_microcode?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZPMSbabIw5ZtTqbo@gmail.com>
References: <65556eeb1bf7cb9bd7db8662ef115dd73191db84.1692919072.git.jpoimboe@kernel.org> <169295877252.27769.17888941552572030723.tip-bot2@tip-bot2> <20230901094053.GDZPGxpcG56GwE0LyG@fat_crate.local> <ZPMSbabIw5ZtTqbo@gmail.com>
Message-ID: <5D92E1C0-EB00-4D24-AA4F-A616244C32D5@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On September 2, 2023 1:46:05 PM GMT+03:00, Ingo Molnar <mingo@kernel=2Eorg>=
 wrote:
>Since these are fixes that are supposed to be fully correct,
>I'd suggest we rebase it=2E
>
>Josh, mind sending a v3 SRSO series, as a replacement for x86/bugs,
>with Boris's review & testing feedback addressed?
>
>[ Feel free to send it as a delta series against v2 in x86/bugs and I'll=
=20
>  backmerge it all=2E ]

Ok, sounds good=2E Give  me a while to go through the rest first=2E I'll l=
et you guys know=2E Reviewing with a slow, ancient laptop is not the easies=
t thing in the world=2E=2E=2E

Thx=2E

--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 
