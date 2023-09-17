Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0404D7A369A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 18:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbjIQQjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 12:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjIQQjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 12:39:10 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C10ED
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 09:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694968744; bh=4do8MxIlT/SZxX5v5ZH60RwNAe7SLM1KZKwNKjL3HTg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=rDf4TXo2SrXhi7SJ+MZ7Xdp13eUHpwxYBOlRjzxyetImqGWIfYX3buCHNk3lTEhSS9A6KzhlB9RNOhLfsA/C9tx6fB+p1GKd79chjb9L3Mgo3LaOxgLiShJBjRl9bHq5NW+mZ9B93bEGF1gYJHEGStyUACsNX7uWS3H51lGhESX1XawFK2UE/CgFg4z21fcYD7SmZ7hKYf7U6WCJb4BTa72lKHHeSX7tZ8P+dWEAEm/mVroWPyLTJK6LHHbRnIQbLSJ6O/9Wjk+BwO1JZhtKvQBZCVf6xpw7OJn0Rc9YnGlmVfiVcDPl874Xn6McOiIbDQ5uJZ+nsxbdK6akekIHCA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694968744; bh=f2IuB7VsEW3oG5oCN6d/0IbbsCQ7OPUIuEnhnDE1fDc=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=cnzvxQFu4+PZ7yECw8URlPgR1N59n5pgTA75jca5YnX+U48IyFARWjXRHOYf7ObcATbj4otCz8BkZqfdn5Awetqgx5XFtATJ5tNGsc4U5IamwdzuBhXwj10y/r1nUBEmSEREMifCJUFMrMpr+8PlQVUA3NZYUuXIZZVvqNI6cIuRGZoFWXALDdZ36/u+5mQzW/1ekK1T6MLe/+gu5JVSRN+JNE37jAKZkbcPQHsaiimNZ6FkGsg2voMmkxg9AlgQr+llqodu4qZ/zCrN4QmK7Ci/8y/aeYTD2ezPwvkHhiBnwNpKVEaBP7lDAA6l1hz5pDdg6mAc+3YHbr62ZETupw==
X-YMail-OSG: hKmnuugVM1nTqeTYE9629iBsxBmWWo2_Sprv4QSgQHhxNXpsayCe0lil.BjDXgH
 g8c79hWYWsjx4S2tl1e2X1iGeD8dpy7E53MVG4jp31BZ_j1VSX5PkjOl.BJPsiDFLii2szd7Vg6h
 8N9.jGmtc5k0VBJvDQXc7ZA4rOoU3bwz1dp0YrU18IvX7fyVnbB8H5FYDKWwShwiA0aiJrB_3nKd
 nQS63p0uVl6oQdPZ3DWtEzrtOBaDd_ht6x4WSl509YB2.NagjJtsG7Lv3VaAGbGecBBYlAORaYd5
 a87SZL8y8mfzcZDZd6YKD33q0r84H881s1Mpq2atkb.DWNkZDX9VLB9vWKByPaJEguGJ_1saAm.H
 0nt2uWj0Mbyxc1pkQMVk3clb0R55wCNwjU9ZXVVJAkibOF3k5d49qX7yI27yxX6.o76DYHmNkZ9l
 isblcjJOnWHPzJZnpejy9hEp35v4lWeC01bc6LGVj7WeL3I9QPpN4DOOERjgwrWK9oqZSR7mdgWE
 IjvD_rrzQLetYjmkkPohKOlDBP7NYq3ZHdEFC98M.OHc3Ko4kZRnTvdUaSs5c2GpaLtyaurwE.wF
 65S1ADAGGYCy0U9cD1qI78qxDYPPjHCz.1guPUJeM3d57pfYmRETrFjYnW9VySAeqeaHc5E38pbG
 FinLx4BXEwn7cMqAEl1k9aqGhYMIV5zHIMhSvyot89g4keqzeqKKgoO4hmr1GjSQiQtXixzNvwFx
 ODABBaTSVeCM3uC15TYRrOhYsbKiGPtT7xUJVFhFNiWEfDnZvQ69chgayXIufax4k9Z_yhCPWqYQ
 1FJhkrzmxdGBlCzcjErTu6IaLbYEkSIV0Yhk_gZk5AAl0.3TqDK4GgAkOmUCj6phtM2YnSNeBxlh
 kYHxdxTicjM9vDSm2pg01ivlry0lu3m3wwgu9NA3NkTgi80JYdvBTTtbpWPLmiWSbw5g1j20yS.H
 j8WJYiU4RaQuPesumpVkEv5qyM3_kt_48QlSWTWpfhvPwvvFjJYysuKXtyiA_REk1OIa9S1Yfrq.
 2y.VE5lm6uej55FPMqQS1CzAgWr8bb8Jt5pS3IfB2EoPE837Nhigj_PqIXVwuLN803VRwW5_.jhq
 64lkW0mz1I8vWR9vPduKBrfz4Rz1uJqAulqlHcPX9asgau_ZJ_CzkoYDJSVu1Qjc8km3pWyQlbYe
 6sodp5Wl1Em4ITw205dmPbNMGW8uGkX5xlrnLeXbieQkxqkOpCGfciXVxYmuE9Qra8iaQZ98nE5z
 VrNkcyv1P3nbEfcUiUtlivTqQRGjNOx9lydCUaPThqQm64ABgEHPhuoTZZGG9xMhhGEEoUG2PGqU
 iqQrmULX5jecIcwMOI63nZbcUOBM9eNe447MOUuBO8JdF6yND0VDMwSPKCnsUvmat8.ROyvp8oN2
 WMjKnnC44GklOZXJ7bBS7i2NTgMl7rvRSWhk2yX9HU0o0reHx.jxwGl176ccGa9d8H_joScyShFY
 cvB1.t.2Cqlr71H2BB4Jr0Oe6QGO57e0oAe3oWdn1wA75fAjkILW_IfMUAbcopy.Q.L3D3sqsc0X
 eUdGjwE1b_6LYY4acadrQ2BIwYHCVXU3TBKHppVQwP0JK6B5U3gqmnadozc2qt49o9H4Mqzy3ojV
 W9KDCIzk_fByyvjYjPo.gvODiSM1EQIz4ElX_ewFiDVSeOvVUkWaG_g0PZ7UJ27AE5ylb7QvHfH2
 vuDZ_nzCyOpH1vQzx3nntZqh6OAQ1A3UQMluvkwz48wJhimc1agEZlzHxh1uXV_2tZpp.eQMdEzY
 AL_1BmizhUtMDjdpcGcA4ifM9veshm.00QgZ1jJIvdx38AWbhMmr8Ad7JWDTCGRySxHpAPMCT.U7
 cgFPavC68_mc6eTqOhQBz1csUmp172F59W9VRZULL5gxq_W81dOmT2wVfklaRGmONHx95bnv6ooO
 n.vmfqbGQ9kNi3N2h8g4xFpZveOr2.nnw2jgwAjQF.OwkNK04VALAEmF7AfRSeGTbdiDev.VGMJW
 C5BZBJOGHWFUNvkqRTFszeY0oKYklgIqbgCBpBd40ilgm82qgDIam7z9r35LQmCF_O25QBlfJc9d
 SRZpoEUttegdCYQuLFw4ym.A011D7Un_d9ios_Q3S_XshMefNw0oijmLnGMHGewB2Jp0gbg_puX0
 iUQnwh.5dZX7NEc2jFyijFnEnxIQgneBk_C.TJ5MFr6SVYOVS3S9ER_5apzHeUZHN_lGbHI2Hbc.
 3YkeEVQscEhuN7O.wGe65hXMZ4OGGOw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 01272459-c848-4ef1-bdd4-c708e273ff64
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Sun, 17 Sep 2023 16:39:04 +0000
Received: by hermes--production-bf1-678f64c47b-rmjq8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1688bea468bd698e36240950404d6b5b;
          Sun, 17 Sep 2023 16:38:59 +0000 (UTC)
Message-ID: <6df9f8b8-5653-09a5-ae0a-6526016abaff@schaufler-ca.com>
Date:   Sun, 17 Sep 2023 09:38:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v15 01/11] LSM: Identify modules by more than name
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        paul@paul-moore.com, linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net, Casey Schaufler <casey@schaufler-ca.com>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
 <20230912205658.3432-2-casey@schaufler-ca.com>
 <1f5e725d-58b6-eca2-97dc-d7c1209ff167@I-love.SAKURA.ne.jp>
 <568c0730-b458-04b4-dbfa-77da1758aa05@schaufler-ca.com>
 <94743c22-bc76-e741-e577-3e0845423f69@I-love.SAKURA.ne.jp>
Content-Language: en-US
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <94743c22-bc76-e741-e577-3e0845423f69@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/2023 11:32 PM, Tetsuo Handa wrote:
> On 2023/09/16 2:53, Casey Schaufler wrote:
>> I *could* respond with:
>>
>> -#define LSM_ID_TOMOYO	103
>>
>> but I won't. I won't make a difference because TOMOYO doesn't present
>> any attributes. I understand your objections, but don't believe that
>> they can't be worked around. The argument that a LSM ID will prevent
>> new LSM development is rebuffed by the exact same situation with system
>> calls, PRCTL and IOCTL values. The argument that it somehow prevents
>> out-of-tree modules falls on deaf ears. The argument that it prevents
>> dynamic security modules is subsumed by the other issues surrounding
>> dynamic security modules, and does nothing to decrease the likelihood
>> of that facility going upstream. Especially since, to the best of my
>> knowledge, no one is working on it.
> +/**
> + * struct lsm_id - Identify a Linux Security Module.
> + * @lsm: name of the LSM, must be approved by the LSM maintainers
>
> Why can't you understand that "approved by the LSM maintainers" is a horrible
> requirement for LSM modules which cannot become one of in-tree LSMs?
>
> One of reasons for not every proposed LSM module can become in-tree is out of
> the LSM community's resources for reviewing/maintaining (or failure to acquire
> attention from the LSM community enough to get reviewed).
>
> + * @id: LSM ID number from uapi/linux/lsm.h
>
> Since the LSM community cannot accept all of proposed LSMs due to limited resources,
> the LSM community is responsible for allowing whatever proposed LSMs (effectively any
> publicly available LSMs) to live as out-of-tree LSMs, by approving the LSM name and
> assigning a permanent LSM ID number.
>
> The only exception the LSM community can refuse to approve/assign would be that the name
> is not appropriate (e.g. a LSM module named "FuckYou") or the name is misleading (e.g.
> "selinux+", "smock", "tomato", "apparmour"). Otherwise, no matter how many times you repeat
> "we don't care out-of-tree LSMs" or "I do not intentionally plan to make life difficult for
> the out-of-tree LSMs", this patch is intended to lock out out-of-tree LSMs.

That is a false statement. There is a huge difference between apathy and malice. 

>
> + *
> + * Contains the information that identifies the LSM.
> + */
> +struct lsm_id {
> +	const char	*name;
> +	u64		id;
> +};
>
> Therefore, unless you change the policy for assigning LSM ID, I keep NACK on this change.
>
