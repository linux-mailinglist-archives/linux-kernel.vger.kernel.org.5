Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3DA777B88
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbjHJPDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235970AbjHJPDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:03:52 -0400
Received: from sonic301-27.consmr.mail.gq1.yahoo.com (sonic301-27.consmr.mail.gq1.yahoo.com [98.137.64.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B102B26B2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1691679831; bh=zhoCJQT9Qmg3Wf19HGU++TwhWSaUfUvLaRDncboCYr8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=krQp2EKT/dNxonW/SmI/lhC9l8+FlUOMwhJVsk758fuOEAeOle+ynbVW5q7dMex7iplm35bhGlieZkcMa0IviGWcDOixQJ7NM+KCUHYWKKKkK75tKU/vSFWJnImKveUSFvRvagxWEQtox8vuLurvHLJ9hFYQ8SIQgTvWIFbV3qincfgfzBIcW0vUhZI3bAuKRwJsFhhuOEDqofDml4SRHeSvVpZpVk2FlhiKxK6u/PZDPOFHyD/vy8HDjpqllGzpt5HWiKiQTrB7RuLV4iQgOUA1YtCOJncd4lzPPSHdjjUDkPxCSTXe0qvrUxNiLrsDdk+TRfdI0aEjTOUGyqi+Gg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1691679831; bh=+/sZ968PKK47bDAhlU61csAslOE4Cr/GBdxM0sy3BB7=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Q8tTYncGr6CGuVEVpyTa8Shtthzx15E/1sMboy3/ZEjoMWJDKXRFDiyU51hds6o6rEITBeVopM0LEjriyieCWsjsa6vLdA3tZLuKY8VMS7tFmCMpfCoG01vm/oppRBHtES/XW/ruTbkjtSF+dDR1AYImSPBaP0R2uLvGOeh9MLATbelwA35GSdcz66F8C4bTnhOTGSRk2qARCaQGb/KtAQU2qLsOVyENT3tMDwshlcMBI0ypf5dG5c/oMqD+XqzUK9NTFPSyhgLJ2rVy8b9b1PNlit+EQSGHCu8fpc0fSy2TQ+Fv33FjqN/ye1kC11+9eszXIUBhL/V49N/0WWLATg==
X-YMail-OSG: e_tJsy8VM1nXS12k0YIEcuKsmXK2yMqZKa2h5Jl3mC4uQjjshYFkDT40dQQ9drZ
 G8m_0GH3ikRTDUfwDMhaPZ9Z1KlBnssZ2JXWCShounHNrlPG_YIPNVRdF5JC3hutGka0ZJVkaWtv
 B39GDJPNCAONl31oJFJuq5wk.jy1cah7Y5p4OcComVkLQWyyr4P9htUeG5epXDZl73CnRSg62hDP
 hj3Vp1nNqPP0_lc4xXmi7i17Jz9v7TZ8pNWcXF41Q9hf6okc1UYiL_QvuMQJTfdvj0eqpZOz1Wzr
 MrMszgZ0qqswsRmq3PEAjNdbjm63WtyYy3qRSRozQNk7npZ162yuwRGQt1m0ZlAID9Z7k2RcfiVo
 8D8XX095onGvNb8cAWEYsPWqh4tncZTa.gkWzzTb4P1drU4UGIN8zGORu5_x4KCeMejWu9TVL00g
 lk56YPQmEZes1TciNppLz8IdoStH7en8jeyVxlVjF5sV9PUPz2686.be_a0tuAn22rvoa3nppOFe
 FK4.JY0ZyJ2QajnoeTeI6UrDDfjhBCLLQYzGK3PMSFRY79iV8W5LQhrumv_VKcW109gqwHwvUu19
 p_ZuzJlSIsIUICUECD5eLui2tn9Qem.1RU82kE0360jRB9vMQLqEwYV2uHEkXbV9m1dbVlnEbAGw
 oQA6hKelENWl1dapB8Ux8PwfefW.txh0zeeVXRlF7zYO4swP9WhhrYvvtUl1StRLkK2YCsjdu9d1
 H8Rxqx7mpKwjI5XK8U7z9FQurUYrYVWpo7J9_dh5s9ShG79ZZLy3YylYwFxe9gTXPaqc7HtxVl5Z
 BvO1p2vw11c4jZSd4i9ugO6Saz8x8TElgwUHwllSED4Q3j5vf7O014nGF65etudI4MkN4DKOkBZC
 p98X1.LcF8dnzYPq7JP6_7vDQ0S4ArGkz0hW3clwsRmrwcv.FdknhqwlpzbNj7g_ZdtzuGuTJdet
 iyoDz8x7Qtg9jH2tYHgm3.dVSL9En1SLBWVswsQS6ArT.kHvopCcorEyPlZ1NOFtVnI0EY4npgYg
 ystu0Z__bSQ4OnkzIvQAC4_.PYaxH2jBSaXGtXhDLMlNwnBMGUSFjeO_xaQJmlp9sTGfx5sIvpjY
 W4BENzGR07Q6JMVwWqOHnimVkBSZHDLNAoEHHPtXT1fTMNxVdnKn3mVT3dYnbFDx5Zdwe0LF6t8Q
 SFI1U6AdjJOleY8pu8VfBdePhGNpK2Gpxrlh9LU5p2XxKapVdAn2BWpKHv6k7D4CYTJkoUXdRF25
 Irwx7d.llTe5F3TnQ10UIctv.O_nBnX4Ub78H3CVMUKopziUT5tWZ.x5..Wal4QA6ilgEzpBsVHi
 7Umg9N8XLqEJdPERl3QB6ZNC5msBkzwQzci9yIaCPKIpYMsxaIC2n4dSDBYtd0tdUjE7n9Yc7wZZ
 E0uYK7JTHgCBN5qg.5Eem1xQbVtbZ6nAvB5ekobv5W9fK58npH.8paV4n6lgp2GSkCIl.FLiP0vC
 j4zZbif0cjpVNEVegAZkZcNrWPSAPzFaBIXdMMI5NaYUPU0iLESXMeJKa9nRtuj1uklnFiv9HiSw
 RkEgdntXw3tOiVmNATWFwwbr9tEaR94LZpF2Bv.fmAqkKinwFfJZu0LISGmpcW4MK.AgTK9VV72w
 VKhXkwbBo.xS0EUg5dHjT2e.MCbN4qV3dRavZNpB_4mhziiQJIj5obJaRmRqLlFvgRjkeYZfjR8b
 FDhkP4.jWvq1Wz.IwX9SMSxlJgtpmzD.RLvsLqG2g_vMNnuCkPT9yV_86DOm7ESudscbv5WwKoge
 i3XOQRg2BGtvbe_oVEYld2tP06Kci85T6PyVX7MmrzUdRK72uaV_Aho81mi6Vr.K872SkC0pBNFU
 4xjmTd05uORSkSPsFZhvX6JF1BCbR7e54oKi17OnMcXpgm9JDCDZUhfX71odsNLSyaltgvNnkcpq
 zmIRjF0YMPho.OsFOqsAt9M2vCZHH9fPD00Ftswy6MKVRBp7.e7eODm2oIcWurHdNrkX.EBYRt0v
 s_3HUQXXvIb7P1U5V1kwIab9a7RsKYHo8Ni.xmYwJlDsGlPSnyXBEmorPivKX9ewncEKQOgrENza
 ErFHehT50pNvAuDjbVQ9pxL1o0iVQugJT_FDE4283hog5Ek4sP2M_63z9Dl2cLBYSLeBbqcmPorH
 KAkRD4q_T2LrX5OrKadkieR.zJuxIy_cmnHkrVjGCjBA0NUBK3ScO6REISlvfLwWY6ZGrbzk4jGC
 U_8ZvzlSrLRKW7aAtx7DebMmrGVMxJwrHxGgueP5lzgbZaZHrTZxf1DiG3uektpSqDV5i761M8j9
 LHnZp
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: fcde6869-b663-4f24-b248-6644ee6c9aaf
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Thu, 10 Aug 2023 15:03:51 +0000
Received: by hermes--production-bf1-865889d799-r6v2w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 629af4ac62a1c1a43bd03fd01ea22778;
          Thu, 10 Aug 2023 15:03:46 +0000 (UTC)
Message-ID: <fbfd9d4d-d62e-8535-3f3a-c37a3840544b@schaufler-ca.com>
Date:   Thu, 10 Aug 2023 08:03:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 04/13] Add TSEM master header file.
Content-Language: en-US
To:     "Dr. Greg" <greg@enjellic.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230710102319.19716-1-greg@enjellic.com>
 <20230710102319.19716-5-greg@enjellic.com>
 <77075160-cee8-8eb2-ca0a-c0db53db3800@schaufler-ca.com>
 <20230810025755.GA19781@wind.enjellic.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230810025755.GA19781@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21695 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/2023 7:57 PM, Dr. Greg wrote:
> On Mon, Aug 07, 2023 at 01:39:22PM -0700, Casey Schaufler wrote:
>
> Hi Casey, thank you for the review comments.
>
>> On 7/10/2023 3:23 AM, Dr. Greg wrote:
>>> TSEM is designed, from a functional perspective, to be contained
>>> entirely in its own directory.
>>>
>>> The tsem.h header file defines the enumeration types, structure
>>> definitions and externally visiable functions that are referenced
>>> by all of the compilation units of the TSEM LSM implementation in
>>> that directory.
>> Extensive documentation notwithstanding, it's impossible to review
>> the data structures and constants without the code that goes along
>> with them.
> ...
>
> We may have missed it but I don't see anything in the kernel
> developers guide with respect best practices for introducing blocks of
> entire sub-system code.
>
> Recommendations welcome.

You've broken the code into progressive units. Include the data structure
definitions as required in those progressive units. Include the .h's as
they are needed by the .c's.

>
>>> The structure and enumeration types are extensively documented
>>> and are the recommended starting point for understanding TSEM
>>> implementation and functionality.
>>>
>>> Signed-off-by: Greg Wettstein <greg@enjellic.com>
>>> ---
>>>  security/tsem/tsem.h | 1516 ++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 1516 insertions(+)
>>>  create mode 100644 security/tsem/tsem.h
>>>
>>> diff --git a/security/tsem/tsem.h b/security/tsem/tsem.h
>>> new file mode 100644
>>> index 000000000000..03915f47529b
>>> --- /dev/null
>>> +++ b/security/tsem/tsem.h
>>> @@ -0,0 +1,1516 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +
>>> +/*
>>> + * Copyright (C) 2023 Enjellic Systems Development, LLC
>>> + * Author: Dr. Greg Wettstein <greg@enjellic.com>
>>> + *
>>> + * This is the single include file that documents all of the externally
>>> + * visible types and functions that are used by TSEM.  This file is
>>> + * currently organized into four major sections in the following order;
>>> + *
>>> + * includes used by all compilation units
>>> + * CPP definitions
>>> + * enumeration types
>>> + * structure definitions
>>> + * function declarations
>>> + * inline encapsulation functions.
>>> + *
>>> + * Include files that are referenced by more than a single compilation
>>> + * should be included in this file.  Includes that are needed to
>>> + * satisfy compilation requirements for only a single file should be
>>> + * included in the file needing that include.
>>> + *
>>> + * Understanding the overall implementation and architecture of TSEM
>>> + * will be facilitated by reviewing the documentation in this file.
>>> + */
>>> +
>>> +#include <uapi/linux/in.h>
>>> +#include <uapi/linux/in6.h>
>>> +#include <linux/wait.h>
>>> +#include <linux/kref.h>
>>> +#include <linux/lsm_hooks.h>
>>> +#include <linux/capability.h>
>>> +#include <crypto/hash.h>
>>> +#include <crypto/hash_info.h>
>>> +#include <net/af_unix.h>
>>> +
>>> +/* The capability needed to manage TSEM. */
>>> +#define TSEM_CONTROL_CAPABILITY CAP_ML
>> Why would you do this? You gave the capability a name that even you
>> don't want to use.
> A simple placeholder that allows the capability used to control
> security modeling to be set in one place, and one place only, until
> the debate over the capability issue is settled.
>
> We never envisioned this define lasting beyond the initial reviews.

Intentional obfuscation is never going to make the review process
easier. I have enough trouble following clear and obvious code. I'm
going to search for CAP_ during a review. You just made that harder. 

> ...
>
> +
> +/**
> + * enum tsem_task_trust - Ordinal value describing task trust status.
> + * @TSEM_TASK_TRUSTED: This ordinal value indicates that the task has
> + *		       not executed a security event that has resulted
> + *		       in a security behavior not described by the
> + *		       security model the task is being governed by.
> + * @TSEM_TASK_UNTRUSTED: This ordinal value indicates that the task
> + *		          has requested the execution of a security event
> + *		          that resulted in a security behavior not
> + *		          permitted by the security model the task is
> + *		          being governed by.
> + * @TSEM_TASK_TRUST_PENDING: This ordinal value indicates that the setting
> + *			     of the task trust status is pending a response
> + *		             from an external TMA.
> + *
> + * This enumeration type is used to specify the three different trust
> + * states that a task can be in.  The trust status of a task is
> + * regulated by the trust_status member of struct tsem_task.  A task
> + * carrying the status of TSEM_TASK_TRUSTED means that it has
> + * not requested the execution of any security events that are
> + * inconsistent with the security model that the task is running in.
> + *
> + * If a task requests execution of a security event that is
> + * inconsistent with the security model it is operating in, and the
> + * domain is running in 'sealed' mode, the task trust status is set to
> + * TSEM_TASK_UNTRUSTED.  This value is 'sticky' in that it will be
> + * propagated to any child tasks that are spawned from an untrusted
> + * task.
> + *
> + * In the case of an externally modeled security domain/namespace, the
> + * task trust status cannot be determined until the modeling of the
> + * security event has been completed.  The tsem_export_event()
> + * function sets the trust status TSEM_TASK_TRUST_PENDING and then
> + * places the task into an interruptible sleep state.
> + *
> + * Only two events will cause the task to be removed from sleep state.
> + * Either the task is killed or a control message is written to the
> + * TSEM control file that specifies the trust status of the task.  See
> + * the description of the TSEM_CONTROL_TRUSTED and
> + * TSEM_CONTROL_UNTRUSTED enumeration types.
> + */
> +enum tsem_task_trust {
> +	TSEM_TASK_TRUSTED = 1,
> +	TSEM_TASK_UNTRUSTED = 2,
> +	TSEM_TASK_TRUST_PENDING = 4
>> What happened to 3?
> The enumerations represent bit values used in the 'trust_status'
> member of the tsem_task structure.

Someone can correct me if I'm wrong, but I think that's a misuse
of enum. 

>
> If a task thinks that it has a trust status value of three it would
> indicate the task needs massive doses of chlorpromazine.

If you're not using logical operations (&, |) why do you care if
they're "bit values"?

> ...
>
> + *
> + * Each task that is created in a non-root security modeling namespace
> + * increments the reference count maintained in the kref member of
> + * this structure in the tsem_task_alloc() function.  The
> + * tsem_task_free() function decrements this reference count.  When
> + * the reference count expires, ie. when the last task using the
> + * modeling namespace exits, an asynchronous workqueue request is
> + * dispatched to dispose of the context.  The work member of this
> + * structure is used to reference that workqueue request.
> + */
> +struct tsem_context {
> +	struct kref kref;
> +	struct work_struct work;
> +
> +	u64 id;
> +	bool sealed;
> +	bool use_current_ns;
> +
> +	enum tsem_action_type actions[TSEM_EVENT_CNT];
> +
> +	char *digestname;
> +	u8 zero_digest[HASH_MAX_DIGESTSIZE];
> +	struct crypto_shash *tfm;
> +
> +	unsigned int magazine_size;
> +	spinlock_t magazine_lock;
> +	unsigned long *magazine_index;
> +	struct tsem_work *ws;
> +	struct tsem_event **magazine;
> +
> +	struct tsem_model *model;
> +	struct tsem_external *external;
> +};
>> Odd use of whitespace in the structure definition.
> It is a carry over from our userspace coding style.  As a team we have
> found it helpful to visually segregate members of a structure that
> have a common and distinct purpose.
>
> FWIW, it would seem that include/linux/sched.h seems to embrace
> a similar concept for 'struct task_struct'.

I'm not formally objecting to it, but there's no obvious reason for it.

>
> [ ... rest of tsem.h trimmed ... ]
>
> As always,
> Dr. Greg
>
> The Quixote Project - Flailing at the Travails of Cybersecurity
