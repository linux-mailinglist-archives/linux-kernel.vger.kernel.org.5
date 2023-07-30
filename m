Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A43768925
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 00:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjG3Weh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 18:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjG3Wee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 18:34:34 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6654FAB
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 15:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690756472; bh=aKix5vI82drtxsFJdrJm0j7tUyn/l8L90W2u/GMMIY8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ZxQ8zgchK2eVTF870eZXOfgQ1CIfB+WBlA1AytsoMRcYlE9kVDNeaDa70Mn2YTWU05pSDE8tzK/7jxyo9rDa7bNmGmn2olWxCC/skH5higudmeBsbs1GOIsJO8TfxIg5JFDX0AFjZuk/KQVvqRJtAfEiaODKiOEHcIS5tzECBZrpAuE4D3rWXwAdMULvu9PCJVD39t0dDc9R9QLFSjIEg7MbCsOjU2YI2LBVKlYqvzZPMuQV8p1Z01k5RsOYJ3b+RmhzXmoyG1iwwj5Oeav8Q3AXgK4ERBzQDeqLV8KDXNzg/qS1xKbj2io9ZuuV/gGvD0eHNcrBoT5UyW2SBdFinQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690756472; bh=LE4U9gxfE64/qhnYX5v/EEqd+oDxql5K6YFnogBbDsk=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=a9cE3zt1BOR924ad8EsbxLkMeRe90+iqwaJldoY8e3Xze05WlDVb1s6DMB8L+7o5tWyp1Y9KgutAdXq+CWIdiLeQ8+5v88f+W6nFqtsgXUZI+JjofTK1HZ809daFQuW5y93y+Ea9krH47a6ssiO/Nz/jfDnapU6gX7H38+JMqWrApb7xIfEoBH9Tmr7adi1q4Ed+PKczVOkP2Qdcs4j5ds6DfdQrmQXFFe/DId0n2Jw5YxzivtKPH4lzin8exAzbvDpTI7nLTSkIZZz0f7vipwkNbYXoB2wA5bV5FW3dxSHxTfsS06e9rcuazS4OYdPYzhocUFqYdC6uVqY1yDAn0A==
X-YMail-OSG: _ArBdX4VM1nGidBTqFVjB1RbqRDoUeZGvKd7C2DYH_tAMVmkGyAD_gzehRfyof3
 2PmStS5mzzYlFwyHlpetITLkljKGNskDAiT52lSkx8ceLqBvWGFFpk4EOZEdO_CHuvY6OD4VZB2J
 9qYvzclwvflHJhAI3jcMprLd0Xcqi04QJauNgc_dpXCdEHzHrwCjIZE2DGFp1uZK0YCxp0ele2MO
 cJx6YEURirQvNLG2ZbhjUYYVxpKkwPgSsaTB5gHbr3z_Qvqj64FBGAoQjeC6zBYXpmx.FYomox7I
 To6Hvovx.ZkH5fsbEbVQP0N3iZrtiemZ5KMKDB7SkZg6AyzavTlFuXN3L3M3BbF.r2GiMyUpxFJO
 ywsSxLdR.gYri4L7jBz.7uSge8dHmc0c5lu1kbVy2Jof6c.qC8Cl.Wfwnif_cOwfk9QcYFs2oPFL
 6qHkE3j1CJuetJ6me.APowlnnFL3FUyZmSNi_V05FpL3P9bRTa9.7KqpL8lqvKRrHSP3s0c70hDi
 wewyMTX947KPL6QIoOaEwe7lN3DGZlXfOjdRzz1gW.ZMKhnOQ7fv6Lbqr99T7imrn3r3j9R920Iy
 8OKvA_AOV_.yy8sziTvKY5kVpPETFRSljsIhADCgG66PFqTHEiJOhd5_ZCljRv8TQzYaiphA4LdX
 K.3xgBYlS2f7S0yK6bzzImnEoRPP_KFLJvnoSGNY3bwYgtKRyoG4twR5YBZPUPCvZc6HrEtuBnyi
 lhR5Z2k1dmfYcgJ3lw3livol7DlphnGad7ikXfQfBkE8XMIskahBYIdlT1rWQMsPsp_r..R6kcaI
 Mqi1jJhWz08kOx0Xy9UOAHG8vdLktyGQxIeoco9bP9xVJBdVokvI6JsGxPBgJFaSs04lPBLjDYEB
 znr5T_zWKl9rh_MOHjviq_JKVVk50xYwtCZ7.ijmdL6nn385oW6rQ4v.713hBo11o.juWKhB_.CU
 Yn5jqCH2v8eNrFve9J7B6L6.3cf4YQgMpCLSsFCI1mRQFtSDxrEXUtWMIxKs8z7X4Qz13SZVWATF
 nMzALdh9moaEaKmXmS0jCoXZi82y25cytRoR9viWsKC4kvpPVD02s5maug5CPQp2Ua1B2FpFVn6U
 hL5vgdAI0RZg3NjTtsfQmgF3NF0GZUtrQiElaparn3u4XeuMWQ1Y.Atwgx0Z8YOA5_p9NePw415V
 NgjYSq8xzh69oqqY90ZP7Z9eSQCnzNg5j8Vsa_PCKLEZsnhE9qJ3aCYCFJE6oLZ45cb9IN3bidI5
 IP9CwK3QYnnQahHA4rBQrSw9.B3kl.2ZzKI2H2TyYo9k64yg5zTG5.E..ZLqqAj0doaGkvvd28eG
 Ib88FNaiJmS8W0qRi9wWY3Gpd7Ir4HytisRLsnYQwrO9csGnTG25gtXRQEGFwIZ_ylkCpfHy9fO2
 DqfqfhokLTk42bX69HncljcV2NSjeCwYteNmLjlxCoPsQurDy1DHoXnaLu8EVJM.009BLjpAZg9a
 1GKzfZpVFAXElnpbXPW9p7jMhxsC9jL35n5HJ63z_N4aB_MmUyxvxHnalDeFg_NnT5dymVLGNK_W
 QyFe45PohCY9eLYTgH5Lfl8Cgf1Nz4eSuTchCTiDh01t.8ZJKkfyg40lAq3nHiSrH6BcU1yS7.9f
 d3LgzLQI9nuDBOzm_Z9gToVTokzf.8yAG3CHAKs4p14RzR_L_FIz77c.LnYdctWbcq.d6T1DNl0Y
 XjImwU8pb2_UefI86w_lwsNcFUyNYQzRh6JbFO1tvzlixZvRqr1F1MQhj8BGMdNc53j1_yfD5ejD
 Sjfx1emjqScUwO4mqI8doNaRKeikX4uEAijVGM2D8PL4UJabpRONE7jb.kdJuczT1kpEeA3UVYyZ
 YmGq_a8i09S0AIA2h.SIP.gb7_Qz75f1xBAGHpMyJzlc3S6fRjWT7ExOuI2LI_DzCORSjQQqT591
 6r1y7tb_h6YmNzGWEEKT48Fl5mJUkWDlGC.GK2Yyy7JHtTR0XkzwRrco0eM8SqmyE6DKPxCsTlCY
 O5ni5oBxGdFqdTVy9Y._AnzUi1uwpUfK.yfDoxXUbTEUdW_TT02l8siKjkXMXZX2YKqaLm4THbGN
 BlR0SMyURg8.G3TnC27OeSMg6K8kEjP9AZv9W2lzYl2ZKWbedSUEUvXYYQBceGsUO4zqT6n5K3XR
 APuBYlq7BR8d_ZP_890WoHE8DLPjKDms2I3crLPw_t.zkUYUR.32NpRmVO2BWOSls7am0lpjnwDR
 pCyO_kZLg7.4rTPEpqBetlv9OPxEZuRL.2MzJQ9GiECFXnb4O9iJaie6zeLssTN2MD5.6BENdiXz
 o7a1mHA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c3a89b9d-88a5-4ca0-bc48-b72059988390
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Sun, 30 Jul 2023 22:34:32 +0000
Received: by hermes--production-gq1-7d844d8954-4zvpd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ac6118e96f5bc100bda3c1c8526cbebe;
          Sun, 30 Jul 2023 22:34:26 +0000 (UTC)
Message-ID: <2882094d-3551-09c3-a192-ce9b3f80758e@schaufler-ca.com>
Date:   Sun, 30 Jul 2023 15:34:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 04/11] LSM: syscalls for current process attributes
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20230629195535.2590-1-casey@schaufler-ca.com>
 <20230629195535.2590-5-casey@schaufler-ca.com>
 <dde1ce1f-280d-f4b2-4bb0-bc9d8a6894a3@digikod.net>
 <CAHC9VhRvNLYE6aQJ9-LReLGQ5304j7wC4MLN1B7X8LV=2zgyXQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhRvNLYE6aQJ9-LReLGQ5304j7wC4MLN1B7X8LV=2zgyXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21647 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/2023 3:28 PM, Paul Moore wrote:
> On Tue, Jul 11, 2023 at 11:36 AM Mickaël Salaün <mic@digikod.net> wrote:
>> On 29/06/2023 21:55, Casey Schaufler wrote:
>>
>  ...
>>> +/**
>>> + * security_setselfattr - Set an LSM attribute on the current process.
>>> + * @attr: which attribute to set
>>> + * @ctx: the user-space source for the information
>>> + * @size: the size of the data
>>> + * @flags: reserved for future use, must be 0
>>> + *
>>> + * Set an LSM attribute for the current process. The LSM, attribute
>>> + * and new value are included in @ctx.
>>> + *
>>> + * Returns 0 on success, -EINVAL if the input is inconsistent, -EFAULT
>>> + * if the user buffer is inaccessible or an LSM specific failure.
>>> + */
>>> +int security_setselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
>>> +                      size_t size, u32 flags)
>>> +{
>>> +     struct security_hook_list *hp;
>>> +     struct lsm_ctx lctx;
>>> +
>>> +     if (flags)
>>> +             return -EINVAL;
>>> +     if (size < sizeof(*ctx))
>>> +             return -EINVAL;
>>> +     if (copy_from_user(&lctx, ctx, sizeof(*ctx)))
>> I'd suggest to handle all the user space copy here and pass a kernel
>> pointer to each LSM hook calls (and handle kmalloc and kfree here, if
>> needed).
> Agreed.  I thought I mentioned something like that at one point, maybe
> not.  In general we should do whatever user/kernel copying and sanity
> checking in the LSM layer that we can; there will be somethings we
> can't check, but those that we can, we should.

That is in direct conflict with the "thin LSM" concept. My recollection,
and it could be wrong, was that you wanted the user space copy in the
LSM specific code. Maybe I'm wrong. I will move it into the infrastructure.
It will make the code simpler.

