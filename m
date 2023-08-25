Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95140788E60
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjHYSPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbjHYSOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:14:51 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154842706
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1692987262; bh=zgxFzEwt+VhUWEvsZyRymTsuacibGHktWPWMIzPmD8Q=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ct4Ms1G7NQpWzmktqt0vmDCcCTfQxbdQL23KzI869JXON+2EouOQA3UPa2WjBKuqFl+rxDAVQQeDpEnuI44X6EPqLHKN4J8bP0xDQC7wQxBE+GOASsBcxTORNyQv0nn2rLlWBFJhu7gD09JHB2MU6A1d8c4HEIwbOtB2MbA7zlNGPaBm8N2xWt3cls6Mm6DuP6x4FKraL+nlKxuAKWtgHbsa7zNHrwaX2okdzB9KLkw3NaJ5QFv5iqsfE3WCdivPy+V6TzfsqukB/6sy1o7iBMi4X4EHiX1itiEnUZxec6qgr6YiyCgkaFaDRUoJ/QDEAYE+N1QIsGgalkM8U16Dkg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1692987262; bh=OyUoETvIwfPWH4eFUZLbxkw1RslQPD2X9ACvXGBKGmr=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=cCbr3UrBCFMDDmVKWlKQ5GLox0TKIwNv301hDqmUFyWJVtufndjYpNQZ+Nq9nZHRIcZ2pF4njYnT+P+Yhg6wH0llaAa9CCAbs9bT+HY+XfE11TnNk5k6fWjVe1Ci+Dz90QP2Fk3IzMt+ihzJZNYhPPJLZJkjPsdAttKsYbzO5k+7bTEXDuVVq4zUowdOyV2Jya41Rmk3phiVdKLPIdshWf35IYTn/VHvOMJDIpvr2cADpDXXUIxON0QNJ/F52QMMGeGRK8DO+6uCaL3I11KvqtGWtAwyzlQxtqssqYQlV6bYWwrYrCXdGZzQvq7Z14KgHAum1WTv8GROIgR8NXNp3g==
X-YMail-OSG: 7SvZxUIVM1kPVaPNjSLTjPiA5bhFuIaJ7Pt8DRy5aC5PqZnGn7o6q74kawRDSxd
 YegdddUzaHCvy3._TMn.1yaOP0tiS7LrO8VATylBfuViXsuNLNHgc6fGWO.gEP_cFX2j8q3kR9Mg
 AoIOSsLbLlhKQ7VRW5KShiNO3Va0TAPn2Oa6MF.4FjGjcVWX3ovIlzGAZfptMlelhEaLT.6uMs70
 GKGoINiINa0TXRJq3ttKZGifwWg2Ux4eKoW5og9LeoMy3XuGR4FrqR5NRgPAxbK2LOuu_Q2uXeTA
 q_ri4JlCs17UQ8X62MABrKAZkQF6CMTYAeGMcDUnzb.4H6FG0vLXVBb8_15QBzefT0vVuE7STPTN
 NKaM2R8UNYKRE4m4GZSJKMzjfmzmO8AsTdjZrF4DtUjVN.O4QHNLjm0i0dqLnSBc3UmubaybaTcp
 9oga3rS6PGh2fn0jifwY.shCPYv.tDnVYmZrwOgK1pDYOXYsZEFR6P8gkGHHl1EsvCGdzb2m4BWn
 YWleyj2Hvzz8BfOZPLr0SV4PaXRUvGRU2ujaVtiBGBGALvctH916jkJI0KjsfZUT5_JYnwqJpeVw
 W.YzvVsWGLdMDUpREDwao6e8VM4hkbTw2gRCXuCWw9dfBXE6sUPNenyhFBRR2EGobTJPPcRkBq9D
 Ejlxz2YiCn.JOpyyF2iUWzk9BY0wdIYmdy9SBwXeZUfCVPYc7AInhxgfcYKtjP54qWLKR8H0rf0T
 Ylr5jlHB9O.9MZLfx929h7RzXNh7EwqWaYqm_XnrfmNvwvwBGF9GhhNufBEJEQgf3AvhtnGoJhGY
 YZc_fDHqrpC4Jg0_KvMUH4hJPVCAMvQFPw5rVU723iXj6BGDwMPB94si1hnf9nqynoXNwD3WYRZl
 2u9nxqNQJYmFIPM3owi2lYCAPzfyjGMR4rcJPtgGy36uLrNzHVVCbcVnFfFIVvgkCBSXLaXlRfJm
 3CKnmcHtZrZlJzsvVBIAk3eAM91XuV3bOlUiss3yzqB5vqlHMpA5yHQt9N2wYPX6P0m2SvpyI3n9
 djxoLX5BlQBqnqE3IyeqKl8.uyglqdXKkjKrDRds19sMlVRsVNXjM5E0QaUK1PYsoQzgZ.jghpTg
 9oX29yJQOy2DrvzSW4zut6k7mxyUgJ0UPhlxoAXRwKKJi3O04aOROX6IPnXDzWnAWXBAwIuyzaOJ
 eM20t40.gO_Kqe7sUITs0BXnEHQ7Bx2_C7j_D0suPe37o3pQl1UFXlBRCT5RIzIGO4cnKHFt2UO4
 LUGUD.iPfb8xNMmD_vlw.cA.ODqUO34kmo2GgVzd03D2WgttuauoosMHCW.uJCkRH25JgTvC4sKZ
 ycNUSxRFtmfR9XrANJ.Cos9pIPmfQOaXo8Cky7s8yfSl5NeeRHJo1yBc_DtWYHqlwanhsnDz5fZc
 OYAlq2BmtA1cmyhZJ.C8fp5gCj93sIk_UIjBMPFU3V.i5J7jHDa6JlpOTiZot4CvkJusk9aVjRdQ
 4eIwaakJyvmfYhlDY7POJbdjCyedlnq3akNI78fhVZkKOegF6K5Qn8_wZopGLP0D4oO1nF8SIGYY
 R.TirwwylFRH.mJXsjCtnLFkdxtTiZBq5El0mVGrvCLk5hGI7RZU_Gqya635zC6EZfVCdnUgk9Wg
 RVeQa9Rxmji0PjpcsGCM8Oy9HHB_1MeVdiuOZxMddM_0T4nZesJoOJYtGH9NYDOXPWLPxxjaHssN
 C79A8lnqpAM5VezTofZKRX.NScLlXAtBrOvtzCFWLOXgUSYDvDtuD0l.Ywvunag8xqTdzyRH7KR7
 oZQWiadMfPis1tUhH5_hB70MmPIFCC7Qb4b.sxsA4V.xA1vjoMAsv_siWxFNGvvrhq0sIiknw2fR
 nj6zSCH4fJ9Q3Slrh9YjWCZWqqu4cMAPG1Szei5.jU3ppnfVeB6k2SQDOetYS_Cv0OZ_Ee1vo61f
 lD_mBIBrgPcohVpCs3ItxcCepDeUPBBrgAC1xLvCqWiOiU9WO_0XbQhqQgsZIGTTm2.4roHS6E1L
 ZhrvJ1YDtpXj8x7byei6RsHkFj84O8L0kuSmqBYofA7P5BY0ya3QZwpSZh8gAa4xrgncRixGyKMQ
 jIHGJU8VwLFLMcOlnGKDou8WBgM.G5JJiruF2.xkKXIfG16nJIPTWTmk3glzlbzM8jfLutVX6hFY
 p9bSPC4Ce89mTp5I_osbTpAqW3huwm6bwvBE8EAi3.raSFVws9eQkO_ZkR.yPORhbRFZaFukUVft
 mXFNlPJvPJHB4KDWRJ5hzsG3ymhaUpw8yUb4wTLIOjDma3hNlMKfYkvrxwpSqIfWjo8kz7g1irg-
 -
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f61f1efb-b783-42b2-82f1-ba85b049db2f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 25 Aug 2023 18:14:22 +0000
Received: by hermes--production-bf1-865889d799-r6v2w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d891f7071272a2e3a919fa0de812b59a;
          Fri, 25 Aug 2023 18:14:19 +0000 (UTC)
Message-ID: <9537cf00-575c-b57e-29ca-0b49be6617b9@schaufler-ca.com>
Date:   Fri, 25 Aug 2023 11:14:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v13 11/11] LSM: selftests for Linux Security Module
 syscalls
Content-Language: en-US
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20230802174435.11928-1-casey@schaufler-ca.com>
 <20230802174435.11928-12-casey@schaufler-ca.com>
 <20230825.OokahF6aezae@digikod.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230825.OokahF6aezae@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21763 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/2023 8:01 AM, Mickaël Salaün wrote:
> These tests look good!
>
> I suggested other tests to add in my previous emails.

Some of the tests you've suggested will be very difficult to implement
in the face of varying LSM configurations. I need to defer them until a
later date.

> I'd suggest to re-run clang-format -i on them though.

I assume you're recommending a set of options to clang-format
beyond just "-i". The result of clang-format -i by itself is
horrific. 

>
> On Wed, Aug 02, 2023 at 10:44:34AM -0700, Casey Schaufler wrote:
>> Add selftests for the three system calls supporting the LSM
>> infrastructure. This set of tests is limited by the differences
>> in access policy enforced by the existing security modules.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  MAINTAINERS                                   |   1 +
>>  tools/testing/selftests/Makefile              |   1 +
>>  tools/testing/selftests/lsm/Makefile          |  19 ++
>>  tools/testing/selftests/lsm/common.c          |  81 ++++++
>>  tools/testing/selftests/lsm/common.h          |  33 +++
>>  tools/testing/selftests/lsm/config            |   3 +
>>  .../selftests/lsm/lsm_get_self_attr_test.c    | 240 ++++++++++++++++++
>>  .../selftests/lsm/lsm_list_modules_test.c     | 140 ++++++++++
>>  .../selftests/lsm/lsm_set_self_attr_test.c    |  74 ++++++
>>  9 files changed, 592 insertions(+)
>>  create mode 100644 tools/testing/selftests/lsm/Makefile
>>  create mode 100644 tools/testing/selftests/lsm/common.c
>>  create mode 100644 tools/testing/selftests/lsm/common.h
>>  create mode 100644 tools/testing/selftests/lsm/config
>>  create mode 100644 tools/testing/selftests/lsm/lsm_get_self_attr_test.c
>>  create mode 100644 tools/testing/selftests/lsm/lsm_list_modules_test.c
>>  create mode 100644 tools/testing/selftests/lsm/lsm_set_self_attr_test.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index aca4db11dd02..c96f1c388d22 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19158,6 +19158,7 @@ W:	http://kernsec.org/
>>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
>>  F:	include/uapi/linux/lsm.h
>>  F:	security/
>> +F:	tools/testing/selftests/lsm/
>>  X:	security/selinux/
>>  
>>  SELINUX SECURITY MODULE
>> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
>> index 666b56f22a41..bde7c217b23f 100644
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -39,6 +39,7 @@ TARGETS += landlock
>>  TARGETS += lib
>>  TARGETS += livepatch
>>  TARGETS += lkdtm
>> +TARGETS += lsm
>>  TARGETS += membarrier
>>  TARGETS += memfd
>>  TARGETS += memory-hotplug
>> diff --git a/tools/testing/selftests/lsm/Makefile b/tools/testing/selftests/lsm/Makefile
>> new file mode 100644
>> index 000000000000..bae6c1e3bba4
>> --- /dev/null
>> +++ b/tools/testing/selftests/lsm/Makefile
>> @@ -0,0 +1,19 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# First run: make -C ../../../.. headers_install
>> +
>> +CFLAGS += -Wall -O2 $(KHDR_INCLUDES)
>> +LOCAL_HDRS += common.h
>> +
>> +TEST_GEN_PROGS := lsm_get_self_attr_test lsm_list_modules_test \
>> +		  lsm_set_self_attr_test
>> +
>> +include ../lib.mk
>> +
>> +$(TEST_GEN_PROGS):
> This target can be removed.
>
>> +
>> +$(OUTPUT)/lsm_get_self_attr_test: lsm_get_self_attr_test.c common.c
>> +$(OUTPUT)/lsm_set_self_attr_test: lsm_set_self_attr_test.c common.c
>> +$(OUTPUT)/lsm_list_modules_test: lsm_list_modules_test.c common.c
>> +
>> +EXTRA_CLEAN = $(OUTPUT)/common.o
