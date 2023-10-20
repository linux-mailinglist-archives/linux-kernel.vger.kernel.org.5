Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A8E7D1693
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 21:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjJTTxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 15:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJTTxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 15:53:00 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619A5D57
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1697831576; bh=EpVkC5AGZXp0L0Z303ND7RTOhjv3pv4lcwIG15RjL8Y=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=MHGydxSrIYlG8fcdN+QKArBRROB0LnluBO/bTt52gB4DQv6VIgF8AvYYw0mq+k4p7JVrCLXmETHS8zN+SOU7vyuKpP24ao7+a2gd+RDPEu+C8u/dk0AFdvzY0SSJS+Qra5zKzoKGrmHF49VhFY90QLAQ2xwZrALPn1RfVKpaw9uVzkpJTzdIHKt5lz90K7vkH1h840aqQ3CAQgBrw6cdNe1c0Qm80OTGhN7u8MlVpbB0zvZzxhEy1/nXQI1Wi9F83ti1UPzShmfHXGIE0jdbD/XUht7uO5NgNtWhRr0y5vU/QX+jrRF93uB5HKtBQ+7II2h9qHzzNGLT5Dwb2b8iTw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1697831576; bh=Z2M7SgQklCeM3YLkpk2Qz0fcgv32pWFf6iBzGcw6uvG=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=BC7xzY+qUeSz/IGAxmjY2TmpcZwogT2B2R3gAcW7yvUae7rEmqcseO3TCXwCj6ZHM3pGRzjpNA3wNVRwfFIfuZ3XrZXZkJGqUhN91dgkzMaMJal8w23JTp6z2PFLn1ImpKQ8FlHEz59pPoJv08+sHvC2hP1BBPwcuYd5R+A3y0jKFV/Tg0n555R0nPlfGaj/O7miRZ8Y5E1bkrOqi4liFyknbt+tyc+hrAga0sh5xzNPTp2CA79yDouGX/ub0YWUpaepvKyFxyLJTZFac+WY1ivUcb7qOG+B7PiSslopv9J6a8DwNtqYPtXGOnWohDI6MuHATvEomhq6VBZSTXTUFw==
X-YMail-OSG: TWj2ddEVM1lEfRyNjKHdgBIoGrAup2o40ECGjhu5H4oQm3ktpdpWZqbyS9CU7CD
 Bn8pZ81AgH_NHhfYwsZnNvk_HPAZQ6miOfjO7XR2kAnpZh_mgJjyOZi_eWjbet5trfDzcAVFVWsN
 aPoAa6OKsRbvIutcFbF9ZHx7Qeg3ktbec7s3KKTAGw80gBfErtN6GFg9pzUGty7y94ACSHChTr54
 6oCvcdq8kx3SS39HPKs33RYjz9JSsthbED9ynl3Lat6NFC_gmORvaY38gAhMn7LL9DeZQMEymtaR
 oDkKoqjedwOAwUEtv8S2iSAHQFySdIyyyTEAIftMMYymz5NHuWwsiAvwpf2cLc6DxsL7a.GqWNbl
 I48vV2qy2Y0If9iyxs7jNikmC_exjS1CIk0fHA45NXVHRVOJ0s7jgJ4iEGDS0CqLIOKaeSLDs_ne
 MokATlrI3c3sRrEoQfgtxRe2qQq.uSKQkcgaiwQLOxG3sOvHuqrmIMFQDu.xKbzZ6t4Bic8.MArX
 pWvAcB4IROLhMfRLo0K9bfVx8kEu10odxbfXzmupUdm0dujF05a_32j1fiAUi.d_jq26j.bf1Dg1
 tmeIV94rvmpwI6fho3F8Cp3ShpGWOYLWDlO1nyVUuxJ5njM82tB8kBEQbxl7sHO1SawjUjSCy5Qf
 YQPUOCLoF0l2p_.QJCNvzVzPxqnxz62qS3AsuZkh80YgJHHZi9OMP0e9OgJC9ZbPjJif.JFKpD7r
 _dC.N6ojOkFvisY8rYbXZsoKY9DPveXmsYuX8IUUwSkXvgHxqpHmJ3DJ99FodtxLpdfBNJ7DBjNr
 lgGmhqt.w705HVoz77rH3g_I5sQVgLGA1WUZoJQdFspDdVxxpEsNV0dXA9cW2JBRsrGXa.luhTYb
 b1KGORaxDDq5xByoO5MNM3GlRR7LlJ53uwWYM9c___bKQJM_qwFDFYfMqNdcCG7LO1HtNkrNBV_H
 D_Pz.8xsHAUikFV_fpCJRdkrotLc_Vm.2prMErW8nUSXmFjohvbfZObh0b7AJJnKj8nT2voLkFdj
 iQrgl_zu3jnlxWP.ii2przpgoOcivDSnduTIEdt3r9cxsKa0D0GIO_w.NXKrQ02IYFYB.xhrjsvs
 EEehgIfPmR08dTKkrw1afiCOaN25YfQM0G4yKjj9s_TwS_6Q_cf0ga0.UGExouv4slHscYViOlaK
 woeK3w_50cpSyDWPeoETviICogDGPSpIx9XXrDZnLIhh6nuetwzJ8ujiVcKs4lHtPZTfuD4vWbQM
 mWqG7EjNHj42DB7GomBCdeXcr5zgemrX4mbBPbsF6gGUmV1soYeiZME8zc8OocJcTTMRcsW9tWx9
 7pxNFjv0mhvPGfZThQX6x0bJ_4wb5IDHe0O9qg4YBWT47yN42mIhGMGDdW2qf03jnYm7X5BG3tzq
 mR3HiDY0HbPwiEq_lhDiIi10DhTn15zFd_KP_0q9S9hr5J8WZnh.rtlZ2LnctpIEQIKd39C2UdMx
 WZqGK.u7FjzfrBwodrf_Yng6BuTiC69urK3gT8yoYBXNARBDlE3sOTyWi5ecZ50TiPHECBF3h3Go
 XxY.gl3Zy9zT3rbDe.XZ6NOV9KZPRD_A2o5xvUWEB9O2uU9hR3D3QYab.ZS3BfkFVh8yKFC3ar1F
 nWmG_ABN69q14MfEgil4Ir0qWejsXZdjoUJGbAvEFW9_NZ0HNZ6m0i1v2YfBFoZ..RsNnexE4_Qt
 m7i0un8I3EiYcJh8Wycy4NNU7h_MKLSxeVMjvoWsQTdOjA4odQmxU_FRulGBLKYlE2onSEG_faaY
 p69wpip45nROmGHWwkZ01AdJKLoA0PbZcyEgcYrQJx_SRO55wfTQ9Y5QNYdpOwtFImJD59upF28N
 NJnAnrSuUQ0sdivryzX2MGne4kqEAjCpd.cjqvcEpbJSt.mTTunJjFPqMv_8GWTJ03oMr5PPdFji
 aBL20ftvZYUn539BMfb_4OZrFKGSiJFY60D0LknAuLKi3hM6EYLgjkIjYtPCUkfLUoAdBB1h5mYI
 zbW993uthZxMyMNxNovIFxvXLHlUZc6UOH7jE1JrktNoSLWugASUUyxlCUs96JZpDe.JcpHZ2PTr
 kDkN1qkxMZZp5StBIoIEHujErVgo2MeOm4zwIM0J6cu0_mJEvmiP6b3ZrfBv7h6RIf7F.lupsnJp
 nw1VXE1DAHXV.NIVMM6YF7l0YAMYtR0ndBfZ3.MWUJ9Jh0Q5kERfXPzl9VOVJdwfxRUgpCUWIXGJ
 _r6eY4kqPmQqR4QJ0DmiTu2YHp2_pUKgQM94ZIhuLFSFvLh9dONp67Zp4bGOTVm0vykKiP193sle
 mDKWLUBJufAmfPmETNw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 7bd88aeb-f3f3-4948-b4a1-5cb66ac474cb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Fri, 20 Oct 2023 19:52:56 +0000
Received: by hermes--production-ne1-68668bc7f7-j2rhn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 55ca460fb48d2cac1ab70cd1ef65e60f;
          Fri, 20 Oct 2023 19:52:51 +0000 (UTC)
Message-ID: <30d1110a-7583-4fa1-85c8-d6ce362f5ae2@schaufler-ca.com>
Date:   Fri, 20 Oct 2023 12:52:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 01/11] LSM: Identify modules by more than name
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        paul@paul-moore.com, linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net, Casey Schaufler <casey@schaufler-ca.com>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
 <20230912205658.3432-2-casey@schaufler-ca.com>
 <e391877d-cd10-3c6d-1f57-0aaa32846a8e@I-love.SAKURA.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <e391877d-cd10-3c6d-1f57-0aaa32846a8e@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/2023 5:58 AM, Tetsuo Handa wrote:
> On 2023/09/13 5:56, Casey Schaufler wrote:
>> Create a struct lsm_id to contain identifying information about Linux
>> Security Modules (LSMs). At inception this contains the name of the
>> module and an identifier associated with the security module.  Change
>> the security_add_hooks() interface to use this structure.  Change the
>> individual modules to maintain their own struct lsm_id and pass it to
>> security_add_hooks().
> I came to worry about what purpose does the LSM ID value (or more precisely,
> "struct lsm_id") is used for. If the LSM ID value is used for only switch
> {reading,writing} /proc/self/attr/ of specific LSM module's information, only
> LSM modules that use /proc/self/attr/ will need the LSM ID value.
>
> But this series uses "struct lsm_id" as one of arguments for security_add_hooks(),
> and might be reused for different purposes.
>
> Then, BPF-based LSMs (which are not considered as in-tree LSM modules, for
> only BPF hook is considered as in-tree LSM module) might receive unfavorable
> treatment than non BPF-based LSMs? 
>
> [PATCH v15 05/11] says
>
>   Create a system call to report the list of Linux Security Modules
>   that are active on the system. The list is provided as an array
>   of LSM ID numbers.
>   
>   The calling application can use this list determine what LSM
>   specific actions it might take. That might include choosing an
>   output format, determining required privilege or bypassing
>   security module specific behavior.
>
> but, at least, name of BPF-based LSMs won't be shown up in lsm_list_modules()
> compared to non BPF-based LSMs? Then, the calling application can't use this
> list determine what BPF-based LSM specific actions it might take?

That is correct. Just as knowing that your system is using SELinux won't
tell you whether a specific action might be permitted because that's driven
by the loaded policy, so too knowing that your system is using BPF won't
tell you whether a specific action might be permitted because that's driven
by the eBPF programs in place.

I wish we could stop people from saying "BPF-based LSM". BPF is the LSM. The
eBPF programs that implement a "policy" are NOT a LSM. There needs to be a
name for that, but LSM  is  not  it.

