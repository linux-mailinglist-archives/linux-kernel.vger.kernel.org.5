Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201917A2535
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbjIORyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236008AbjIORyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:54:03 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F39199
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694800438; bh=7CeoxyV9Je0v6YCP7m8+43pzfhDq589+0ANYOmJ9zQc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Y5hsVTx7qf0xmk+LkGH5Qi9A4fY9UIGESUZquhAASvAk2/IxqOE2dF60Mo1KYqpwPvPcGCYT+oe/0g94d/Zz3JOhx2a4g1gTLJaKslsFKoE5GDsWtF/Wv1IGlm4kP4Wgcdwrxx7t1+tU7xN2M0vCfPiortl4iF70bR6SBqwWoxNlKxgczHQEmu+T2Ed3MUIzYKkbWzI3wtOkgNEGOSTdWZtzMXD7UvBZk7UO/TR2w7JAMdtRiXoFNDXoPz7/JwUkbF3f7dfoQQ6HR0lsTraQnuT3bTMkRWhc+YdkIe9SsoPCq62n1dEIzm+kARQDlhW7OeOYf2sS50uZmEEIsQx9cw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694800438; bh=NoLJfb80Q53qBZvMdUrHIgQ3FXzWvxl3U+sQtL1/FrB=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=A5sPlQIe/7TfqlV3qeQDZv1BwSIPBDcf2Xh79E4e3iMfql13GXhyWrgiZ3C8sfRzShZxg80cvAqotOjkFIIrsApXFnkz+p1bOKAhya1N5I1qzi31xAbSrenaIlvCjvElUSX21TCfEbERna/UiTwKLp397s189tBbpNtoJNE6YXuCubhjS941skevat9IMci6RYl9h71ijGFHScFTdjf0Mh//WTmakp4aJETf8rDZjmbW/LmUlyFiwLWOQyIaVYQ7yqEwjTBNlrWI0tuDYMhkFNLQs19jSw4jrhOrc3aEmc53Sioh2IHrskPW7F2K/hNDsjWMqcd6VwSuurtvTJw15w==
X-YMail-OSG: a9qvje4VM1k2Q7cUR0Jmlowrx5XAdMT88.WlCPMA.K7BS0ubgNKgy63frLEomv_
 uBDE3Me_MX6bD5DAcfSOhlf9.uRbg9vm8JT.c3gZgrvZc5L.IKshNkrjYwds_1K5WWhATgZ5ZCcc
 p4y3uBZtWs5QnTZkWW7Vtfinix0cqn_4dXUViSMLPcwfFK0lXGgEjuRiJEo8n1_4p9ziXcYcqsHQ
 pXGEvg2sa5LbSC39CySEbTMePrEfIbBzLcom43yrACkJyjvBWM9si._r6hQ6HjvlKBoyWFkTBmjJ
 y5IwMWwY6yuVwAmvIsnDAGuRsT_TtB6jQIW0yEtmZOBMyoLyxAQgji9GZVt8jMPNo2dYesWC0YHm
 AtSIozRUdN1ABetA6R_XjIY3EsorsKrb.S3e.mzTjOCtkH6tPVEcOIgNYRkA7rd4D8q84j5wa8cd
 ZqZV4M1XE_7I2lFnErkjNjeIxNdZTkVI1siiCeyMx97INLVnAMZs6zZbfKvZf4l0khhCtQ3qA4Wq
 xArdYEoG7Stxbxax0ZVBio6YfAn.d449iXPvuIZiK_EIOjfaVppG5VwizQSAGKU_A6K49XM1rMqF
 Ua75B4szFZnrHmVe6FGCr2_vLVJWQECjnvu1vzFQLZATMQ5cgsy4J7S_.x2KejjWwBUV2pcl7Puo
 yYP1bVtgMRI7Ym0yUGcgPZXdd0kdy3n5cl7olWrxybX3TMYwWPtnN1FXapydMUORneHLmfeAZLfx
 8A_EsLhZjpuAQ7etmq75NvhQwY84peHkHi5BH2eLjTtYAfdRXdOTVQAJtIU5Xr.wP7PXcrkdDGSp
 TuOlWdII1ErxVGxtoNxJ5CQ8pxasq2DqukaGx8S1U8i3zH2_QhF._uNTNdBMFhu9JFBpJglBtaQZ
 52.JoIXGq0aSBLBt8DCQo6o0a1Dgx7xSxZQGdA1THpw6Ru1I0t6FFnHVaOaAcrMrWIkSDizYFB4h
 DXTG0eXVSc85KN6FvIA3AhPvvlZp2b.npqEWLc99CpAwF7i_jcp7fg1Or8kCqGFIfZb8YeX_PSDs
 rcMuWi1ITeL3NR1eOaibG0Ny3qlXGC347UtUxNBoQZFUyGPOD56CtzuZB0VXLqt1K_SUXkBgmq1R
 IXaZkCKkyhU4crjEI.4s1Lv2hrJKUuq6d8VFEWAWPzSXEDprrdSXIQqQ64D7etw5UWjBzcFX_siK
 Ij.kWecaQpKVFjvWOaKDn8YZIFl3Qewf.uk2mfG_WzlN_D9utCCHPuH4UrFXD9H9WBes2jzmCaqS
 JL73kghALE.8GjFdOj7Tp9X_6rElyL61xk59KZI4WlXGMykPrtrUvkP61m0NjzJyhwp8aumSWF0l
 KtBmBKZUjIXfvHBsSd8.UwKiyzVyVDWVwA37Mo96amqUfR2KTf1VhRj_JOQp8jV_NwotuliPuUZH
 OkTGswQ7UcmUBM3onOKVhfgUpVF6wXgvR9gMuGXp.3C.hbSr187JM6Yvf9DRR8Ipc_9Sfwzs7YEZ
 _UQuX4h9eyBbdJHPXkeFFIZkmugr8iVJkIJ02GnWLXZaw1mA0lqIYDaqWEQAFIU2Xg2_3lGESCAS
 LD22u9UYGYW8dVahQXLhLuut._AFphTER.O6rYYwiwaSWSvOsJeY9KXHhdP1O8.fYFVpetBcEnOQ
 PPCLrV2Ri7mEWKe8PmeYDomIJXeUb3tJz82ZFuJRxj_4TOT5hZeKN.BVYCD8PsemqO74XlkNtJ5f
 _RUx7H.wxR.Y3hsUzlJhhQ1CaXof5zQ2sOILPRi5Iv_prUvIfu_PgpATxNiNUAV0jtJYZWEKXXz0
 hjSxrREAlX.HbJxHdk7LWRiIvpWvZ6taqkNsxfTrrK1AI9uN1o.E1qJ2QA4_nYkGoP.kPgfco5GL
 mMSQFeG5u5DemVcAkhAcXlLLqK.JRpBmgkymiolqm6eD3YOaVSaXYKLh9PBnJkZ2v8IVdA2utJMb
 0NjqaUc9UoGf3jWd4joo26ar_E6rhsrMPjn4PHSopA1cby3Cci0nEJKWu63v8kMuWbwhH3kXuxGz
 bNIIv0WylC3OAX7p0Ppou8kPtICXz2By34qFYyNLB6SukrCIpe2.D8ZAsJN2Hpzn1I.IBIboDE.f
 MxvVe_kueqKM_fASPcTcRKXPJT_ghJXVbfYMCqGpkWo0Leo7BvFarV3752Sdm5HywdfL6YvtGQpb
 ePw_.dv7N8.F_TkO3cBH5QvQ9F.iclIFxJHmFVWZkYsLhmPQbyYNGTP9vAdYXZ0FHPcNDF_HcEIw
 d_gwqW7A0Y9BhvX8bkGQBoBXTPicxnCT89Vx4t1iwV_E6.GSQam4edUYaml6CDUwLTkW3GtvtRpO
 nkYhW
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f00e6c41-2143-4447-991e-7f8a2949223e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Sep 2023 17:53:58 +0000
Received: by hermes--production-ne1-6cbd549489-k2llt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bc804610b6fbe59a15e4022144b9412a;
          Fri, 15 Sep 2023 17:53:56 +0000 (UTC)
Message-ID: <568c0730-b458-04b4-dbfa-77da1758aa05@schaufler-ca.com>
Date:   Fri, 15 Sep 2023 10:53:54 -0700
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
Content-Language: en-US
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <1f5e725d-58b6-eca2-97dc-d7c1209ff167@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/2023 4:32 AM, Tetsuo Handa wrote:
> On 2023/09/13 5:56, Casey Schaufler wrote:
>> Create a struct lsm_id to contain identifying information about Linux
>> Security Modules (LSMs). At inception this contains the name of the
>> module and an identifier associated with the security module.  Change
>> the security_add_hooks() interface to use this structure.  Change the
>> individual modules to maintain their own struct lsm_id and pass it to
>> security_add_hooks().
>>
>> The values are for LSM identifiers are defined in a new UAPI
>> header file linux/lsm.h. Each existing LSM has been updated to
>> include it's LSMID in the lsm_id.
>>
>> The LSM ID values are sequential, with the oldest module
>> LSM_ID_CAPABILITY being the lowest value and the existing modules
>> numbered in the order they were included in the main line kernel.
>> This is an arbitrary convention for assigning the values, but
>> none better presents itself. The value 0 is defined as being invalid.
>> The values 1-99 are reserved for any special case uses which may
>> arise in the future. This may include attributes of the LSM
>> infrastructure itself, possibly related to namespacing or network
>> attribute management. A special range is identified for such attributes
>> to help reduce confusion for developers unfamiliar with LSMs.
>>
>> LSM attribute values are defined for the attributes presented by
>> modules that are available today. As with the LSM IDs, The value 0
>> is defined as being invalid. The values 1-99 are reserved for any
>> special case uses which may arise in the future.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Cc: linux-security-module <linux-security-module@vger.kernel.org>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Reviewed-by: Serge Hallyn <serge@hallyn.com>
>> Reviewed-by: Mickael Salaun <mic@digikod.net>
>> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Nacked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

I *could* respond with:

-#define LSM_ID_TOMOYO	103

but I won't. I won't make a difference because TOMOYO doesn't present
any attributes. I understand your objections, but don't believe that
they can't be worked around. The argument that a LSM ID will prevent
new LSM development is rebuffed by the exact same situation with system
calls, PRCTL and IOCTL values. The argument that it somehow prevents
out-of-tree modules falls on deaf ears. The argument that it prevents
dynamic security modules is subsumed by the other issues surrounding
dynamic security modules, and does nothing to decrease the likelihood
of that facility going upstream. Especially since, to the best of my
knowledge, no one is working on it.


> https://lkml.kernel.org/r/4a6b6e2c-9872-4d4c-e42e-4ff0fb79f3ae@I-love.SAKURA.ne.jp
>
