Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B277CC98D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbjJQRKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbjJQRKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:10:25 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C659AB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:10:21 -0700 (PDT)
Received: from [IPv6:::1] ([172.58.89.53])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 39HH9EBK4087569
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 17 Oct 2023 10:09:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 39HH9EBK4087569
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023101201; t=1697562573;
        bh=/v3M2x69Cr/SCf4Q5j/CgswfLfSC36REEd2JtW8+rsY=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=nt5K9f+n2RZ0ct4/NQNT/SUbkrZivO2I9s8PW339u6rORZa3AcFBVibLlKA1p0OMv
         QVZSTJw+97unO5TyUc4Moj9PmvdIk8zKQucF/+mAsLHf6jVvxxCbY99qkWjyHB2VR0
         dcHYB765eSFED01+Mndkw+ej8cEu2RHJNXdRorRt5AeeYMa62zDVTicP7ivEyUYYR5
         DOKF1xH0snkGtJLWjdSA9+YaGdj7LToAJ4LIveoqbMqhuUs77TvlnqTvIxlPHTZfxZ
         lti/5Z6a2/abF6iCffEuuF7ozA4CkRXdY7MwwbxKiNY8Hl4UVhaAWx2tzxdnTS+62I
         Ys90ifzIVPJLA==
Date:   Tue, 17 Oct 2023 09:34:41 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Hou Wenlong <houwenlong.hwl@antgroup.com>
CC:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_RFC_1/7=5D_x86/head/64=3A_Mark_star?= =?US-ASCII?Q?tup=5Fgdt_and_startup=5Fgdt=5Fdescr_as_=5F=5Finitdata?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZS6F46vJfca5f6f8@gmail.com>
References: <cover.1689130310.git.houwenlong.hwl@antgroup.com> <c85903a7cfad37d14a7e5a4df9fc7119a3669fb3.1689130310.git.houwenlong.hwl@antgroup.com> <ZS0lEmEpQOz4iQ4Q@gmail.com> <20231017072311.GA46993@k08j02272.eu95sqa> <ZS6F46vJfca5f6f8@gmail.com>
Message-ID: <77B66FD0-ED28-4D3F-8D28-467AC4FCD00D@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 17, 2023 6:02:27 AM PDT, Ingo Molnar <mingo@kernel=2Eorg> wrote:
>
>* Hou Wenlong <houwenlong=2Ehwl@antgroup=2Ecom> wrote:
>
>> Hi Ingo,
>>=20
>> I have sent patch #6 separately for x86=2E Do you have any ideas about=
=20
>> building the head code as PIE? Should I resend the patchset for the PIE=
=20
>> feature?
>
>So I had a brief look, and despite reading 0/43 it was unclear to me what=
=20
>the precise advantages of building as PIE are=2E
>
>Ie=2E could you please outline:
>
> - *Exactly* how much PIE based KASLR randomization would gain us in term=
s=20
>   of randomization granularity and effective number of randomization bit=
s,=20
>   compared to the current status quo?
>
> - How is code generation changed at the instruction level - how does=20
>   kernel size change and what are the micro-advantages/disadvantages?
>
> - Are there any other advantages/motivation than improving KASLR?
>
>Ie=2E before asking us to apply ~50 patches and add a whole new build mod=
e=20
>and the maintainance overhead to support it into infinity and beyond, cou=
ld=20
>you please offer a better list of pros and cons?
>
>Thanks,
>
>	Ingo

If the goal is better KASLR, then what we really should spend time on was =
Kristen Accardi's fgKASLR patches, which not only exponentially(!) increase=
s the randomization entrophy but also *actually* avoids the "one leak and i=
t's over" problem=2E

However, she gave up on it because she got no interest, despite working co=
de=2E
