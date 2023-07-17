Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0376E756E40
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjGQUbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGQUbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:31:49 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7A318C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689625908; bh=9ph4eCZmhDQ3lr6GTYBorpZ/DsudWvdab7mcX4Jc74g=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=uYL2mCK4ol7FbXJQ4VXftNOTkITyi16WXWkMe8uXJxlv9QmamwFy4fGomBe81+fHk05Q4w3O5Rq8fDiwBaYql8HEZED6w9QFhHob7p15OoYFPOCZCnh1SkGRimktI4FGGiJTrFBm3PokXFTK0Nc3H+x5Xdg4kJ5j+ouH2OAmrVEwKQLmufKA7jE0LyINQBe5UsddjwYgqewWkAu/w46eUYkn1vziLE+4ab5alSHh9Fu3+8Z+ewr+5NZkSFzPxMNJ3fag90u3lBMYfhaqxxfFSWziQ59GUF3A2sPf2RIHreWcNXhklJAscdS7IZM6CgZlrtGangQ18JwlKdQalZtEaA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689625908; bh=o9DqBOfO9b/ahv1j+U3RJovW0axQHKQhOYXh8AE5EJ/=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=GA1ShMGomWqYlvK1uxw8aHniLqq8sTn2A5w5q4ZXaqpitBBgg6DN2/G8AzWFMwhQ8XUGjtkLZ/ElaosqDarg5RnFam9UrDUhZnVVhTzY5zx+dPMYVuQlJ4qLqJWSBqfsRAsx8z0fv1FhhC1qZUvyDnxlidFfDvudou4x4WUBf0jHhm2DaVaRu92kS9NnLOyXVyWPbDbZRz63dI00jKFecCYx0cSvTi6zqyTpDaotbCyhN3Clph2i85Bd0OeVqa7+ZHHB/CSHKMISoRcFzSrxdiKScnAtUIqYGiaI5hksTl8+/K1uvCyy6qB4dnCf9mCh6SlosDgz9oe8uZDO8Lvp8Q==
X-YMail-OSG: C334pLkVM1n3mGdfcTaWiTiwcRUmAwhEqYWBzjdmDNeiMkrMORK5qqvQUEQRO0O
 rbjD.OXukwPPwhgcHu6PLSo5vxQksSBQvbYUpvEBUngpy8IhEqMk3OPNRPAoHvLHg0gG1.j8.dne
 RDYcvMmRK13ra.4UmFu1GxAXnbRoWtG3ZMjfy0XKkYxz5cUOuvwsw3pK8PrQzhto5NdgdpX2_8Kv
 JTh8WtXhCFxaAuuf2pqxGK0M0AlmET3_VXttL7DLA2Lzgv31j.vlWh7I.mpNCcI.eXF4DMtmz1WJ
 WtCI1DrGIYG9_iDhRC0GAMXuRrx9eKXudh3qv_fBZScovOEme324Ef_nwcLIlmL_DG2ix2E39YL4
 JeYYvuf.OFDYr8B6HJF3F9liNRZV3aNNgtEsBGbKmDyTfMnTWbB0CBwRE3ibylnYd4ZVXn5J5PJR
 EMh9FLKac88NZCVU_3QDEVHnap.vrfI64oR5TY2W5RY2zxykrOL9NA2wIz9y3yPD.hFIzRSIQoSl
 TVzfB_2cG5Ugneyl2ujkFb6aY6ADntXDcQvdtBD1_F0AGILkUu0TbEUQg4hJwGqWo_LMNUlmqX5Z
 hIowkqR0WlkPkT7caqn553eeYvziMuYUmz2STHdY6goplAC1_7zoWXOjll9XwB6FTQBCDwTnCdGf
 b0Y2rZim_mUU.9D4CZMSnPAiSM35BCZSGWnkgTlCDvrA8ksDBZ_ngZMsUN_J8cWYCof4Q0l8Onca
 HBqzF4sdbtdPtJy1WYb3KO__FkJwlLv.GuD895RJlNIja5_.inu2vNnnpq4ccijyXPpngXjqgbNq
 nAyYyRfnSVP5HjdKgUY92ojd6kMr2q3gZSDKrM9gnntFslKf1f5.3_nqPmCtremqqcevKzerobVW
 V07g1Btka0hsNXy4PGt44oAirRN2YXk7ewC2H3gpQheYRQulRPBMngnCWJ4w6ylfT4pRDfO5Pzc5
 BOCmi17I.0iVQT7TDQFlH3I7jmThsYwIYBLipiayWIUxfigdETPR6uhRGD_DwUTx6SfUAo0itdT_
 w59Ek2es29BbwCVqkZPkKXD2ATvdr4e6txfGzKdsXC_.nTK0VfXr4M762rv0ZN3Xe2xGyiodJaDP
 LDkeN.0U3HmALoJG7woSDtcpQ.JS6ZLMdxddux4lnfmBrTw5I0OdVbpiBb8MDQKlXgt5j0Yu3q7i
 W5Kr1YKFQCRTlqV.D1VKxC4gMH8cu.A3G9F3uEtO9L6Q.gYS87Sf7HfUDamLavwUdlHfUf86xl2B
 wh.faRm7AyKuwGlicJ9KBneipftyQbZInTidzmUlYdDj9wuw1AnVS_SA3WiM6814YIvtFEzQ1Ni8
 l_qdNv0CqwCylfi7teed17VPvdRD2fyj9SyhMne01z4Qc1Womznimbw95hbL98MhITl4JlAcHfTv
 p1rdIaC3Qj76fMgRYLkJ5qiBzSDzO7uBIHr8vXKtAsgJfkGzru2T4HQX2R4KDS73UUQpAg2PEJil
 LqWB8P97ba8oJ84euzvfOqNAS5erq1XV8Tjuo.S5RcDSH.77zyIOHk194rftguVQu.DE_RqldlD1
 ETXZfox4tpTNJzzMyzqbE2GQAcaN.7grGy0zue15l99X9SgMrIxFsMnWbVQcC4boI2AIlrK7hKUK
 PUNvVCU6HL.SGFXS1gt9UdDVidkuryEJB3RvSxrFAJEQOOkaRZDBKJ6s4IVHmDPs6mu5NlPboE58
 l5pAMOgkZm7MY1Ivu3LLDGzlmw8mPUgPbk__YCsH8U43KoZP2OnyN_Lf9K1o74L2YcUtG5lOTSr2
 NByjHWKFWI6C9tIYdiz.3_bVXSXMX.ogAVv9Lq77G5iEKb_Pr9bKDJvgnB10XJ9q3OQ_tAmjA_Wb
 gcnuwrs.d65CEwjoHozp1PeYEjHfRh4oIkbYmhtJGg.LzJRDvlRDIBxo0_eJYt3C3BDKFB2tXzqh
 6vXDpyf8J6gDYkuW58LSy4ZIoNO8haPpoTPJmNQufilgWoShihG0AU4Ik6u5OcCWh39gOnOd43m0
 eUuHz81Ml_pL4hPm4ivactKG1UauOUOnLKdHd5Fpzwx5RP.OIRePkcUeqWyzpP7BGV6Wz.HVq0Bt
 VxeudsBGcrMZcRnYEAwfm1esoXr0B0dEMwV6IYJEQ.bRuKywKu0zGrDuVDCj34A6D5bRfDdTqBIR
 8CZR3kAiiwGLO0FGZ08YC.BC4KTj761aCzQCOd44jo7nvdjckZgLRcnZi_vKF1R1fnCUfA_GxZaJ
 a99chuYM.NaF0aLV2wsAixHFSuJF.VCwBkGCesQZsjIty86jCa9a1XvwjR2lBuLxH4V4wuVtE1ZC
 O5c__uwqUvB0-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 3365421f-4eaf-4161-bd32-60d398ead7ed
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Mon, 17 Jul 2023 20:31:48 +0000
Received: by hermes--production-bf1-69c9587855-ftxdj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID be6be41bd27bd00225caf7b38170cf90;
          Mon, 17 Jul 2023 20:31:46 +0000 (UTC)
Message-ID: <0fcac6a8-4ab8-91bc-34e0-cbbb81da3973@schaufler-ca.com>
Date:   Mon, 17 Jul 2023 13:31:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] selinux: optimize major part with a kernel config in
 selinux_mmap_addr()
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>, Leesoo Ahn <lsahn@ooseel.net>
Cc:     lsahn@wewakecorp.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230710082500.1838896-1-lsahn@wewakecorp.com>
 <CAHC9VhQY0Uq_xQ_AwAuZ8gJbS52nQvRONHvCxiR-dGDg3BviRw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQY0Uq_xQ_AwAuZ8gJbS52nQvRONHvCxiR-dGDg3BviRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21647 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/2023 1:13 PM, Paul Moore wrote:
> On Mon, Jul 10, 2023 at 4:25 AM Leesoo Ahn <lsahn@ooseel.net> wrote:
>> The major part, the conditional branch in selinux_mmap_addr() is always to be
>> false so long as CONFIG_LSM_MMAP_MIN_ADDR is set to zero at compile time.
>>
>> This usually happens in some linux distros, for instance Ubuntu, which
>> the config is set to zero in release version. Therefore it could be a bit
>> optimized with '#if <expr>' at compile time.
>>
>> Signed-off-by: Leesoo Ahn <lsahn@wewakecorp.com>
>> ---
>>  security/selinux/hooks.c | 2 ++
>>  1 file changed, 2 insertions(+)
> First, I agree with Stephen's comments that you should ask your distro
> (you mentioned Debian) to move MIN_ADDR higher.  Beyond that, I have
> one request, see below ...
>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index d06e350fedee..a049aab6524b 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -3723,11 +3723,13 @@ static int selinux_mmap_addr(unsigned long addr)
>>  {
>>         int rc = 0;
>>
>> +#if CONFIG_LSM_MMAP_MIN_ADDR > 0
>>         if (addr < CONFIG_LSM_MMAP_MIN_ADDR) {
>>                 u32 sid = current_sid();
>>                 rc = avc_has_perm(sid, sid, SECCLASS_MEMPROTECT,
>>                                   MEMPROTECT__MMAP_ZERO, NULL);
>>         }
>> +#endif
>>
>>         return rc;
>>  }
> Pre-processor conditionals inside a function are generally something
> we don't recommend.  In this case I would suggest doing something like
> this:
>
> #if (MMAP_MIN_ADDR > 0)
> static int selinux_mmap_addr(...)
> {
>   /* current func definition */
> }
> #else /* MMAP_MIN_ADDR > 0 */
> static int selinux_mmap_addr(...)
> {
>   return 0;
> }
> #endif /* MMAP_MIN_ADDR > 0 */

Better yet, skip the #else here and #if out the LSM_HOOK_INIT(mmap_addr, ...).
No hook at all is faster than a hook that does nothing.

