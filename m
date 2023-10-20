Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB827D1678
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 21:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjJTTmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 15:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjJTTmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 15:42:50 -0400
Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2CAD5E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1697830967; bh=Izr45HyIaKoE4cz09PMwTts7ybC7A1AHwj+nXIptXuE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ks6ioE09+0hL/vCa/8yPkHarVg3PoJCxgJe20utl9SIgE/GWEDQj6nMrEP+lLlLz6kAArJ8/KLc5nvD+G5oi85oKkTzL5A811+KLXKdDT+ce7gh7hhrhzYg02tVsRKXrahDsdn+7ooILhRvxrF7RlEpLjjz6F2NSAMM5LitG1l4nRl6k7sKTsTCoaIsfYXt9LyNfxc8dU3UQGp91MsAYg3zH2eXm0Oi8qYoyb7qQA3qx/3fhhJeDxtrnbs/99RVZe/Oi7aaitMVdZly7L4Uq7mdASlft9mBNezXSvIZxrjHQwB5vUo5yKMA8oGrOaX9ikZ2vbGFVqd3QtQjQ6Xqyow==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1697830967; bh=rQPvUIancDmlQflSB/Qy8hS21akCeFpbvEHakYevJLd=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=QSpD3ymykPEg/Z1tDWuHO4yibZ/cHJzCqhUSISivzbDDrbpDxsFXwa4cZti2ejGhEJPOxeCnpheyIYh8xizUo2F3CYf4yejolkYey/nLTE6hus2aTDGlCvzCyiIz2PDLdamF2zejo+0AupRQb5D10bggft8qnB4Hvtr3Qq8ySSdLvOzvB06rVucsWiJ/SotQBi3CsAD0sslZn1T1lwDOkWDhXMHKP7+HIbZ6wn5PeJVmvKunOczS4NG5Ypek+daOKcye0Xw2J/c3YIV+JJN9HiazgXzzrUkp3uh/2aC+wjL1cZhKvmydByG6kzC7ichjtV9u7sS8lQlHySnW9FfJgA==
X-YMail-OSG: 5uuS1boVM1kOcIFTXVKqiltXNdqjPjh3K8pVhVF0GUSf5vzCDcElFXSoZMsyfWR
 atpcNsUN9Aav16sLcwLvEPuDtNEO0180YhzT.vkZNQwXdi6kyrUxMEBl3hfiof1JKa1p.zjrpnKv
 Niy_VeJz8rdVlzKRYFFSatFsMaWQsXj1qbxmJ04NkoUcGfN2WZhcid5c9HeSNfbLmxp3qcvxbf_O
 gpIW1DfLNgla4Av0meR.hO0RITCfossMPWdRH5n5eB867qoCCHpuVHhT.y5AZYvWAVsxBAOM5OGt
 GLCzpgSLvCYfeUy.XxSPVt9ji9zNzfc2FrRNhBG_LWODoTjLtQH5u3S5tIO_uJY9inhqBlQ00I5n
 Torw63dg9nSSLeQaqIIS9cdXbmaY.sDmmsxinpsHlTrSmoBfBOu_PAcgL3ouUKob3342XJP9xW.F
 HFipS29Ezesl8Ok0XlkDU7RafR3kMeZdCOKGfDvpKArQeTWAunjN52GLDuNLBYofh_mqTBfz.iMS
 GPNJh7a5nEzLVAQ7B79HIi97UCNxiJxsI7GylXtg5sDrFOCb6gd4uA1aT2BJWWOTQOY4emlNJG9c
 9QZGWTx9S4W8gzLvSUJZofqLo8.ca0mPvHkdfDsHBu8xeTwA0iHYLYFcoyJTV4myhnOBawim2fCc
 1S4Uy1Nq2ShhP98qm4.lRT.XEeFuNLCbqc75DWETO3x_3gmi5ZzbU0BpUqgEFNYH9PPyHG7ZLs3d
 3vSpZr7AM8YrJbtFoB82Af4qKSpH9jDqMIFIy1T75dOjSVS2PHWln_gOF413E67MoQJk_qRQ27pf
 hNh8UzU5.kd.LLwtcfdgVb4p._r2NNfZrTWKrZYbr8PgmchgfLgTzM_z2WVwSKFP.aMgCcY7IN2n
 1LCQBNt_Y_pHwRsgt5KAzqcctvNHzG01ECZ4JPhra_ALoYFYAzbVuLoZ_TnunOtXOjJVo2eYXpPD
 w.mSLlPJDFiMe7IeHkPcpd95KUVMhYDdYJCVjMBhkk4axcPdBVaqJ.waAy5h.YxBfh0_eaQ2vK.S
 xKdsGzGWeEraZ20aHck49t94xQM57.z4vI9KyG0j1uR94F8C4vqUKpLN1Yhnl3_LqBpTxO5JN_0X
 yNo5groYITIQRqC4tO8XXKE9rO5gLHpqa4xMXLmSrDbOg1AKIIEn06xYMvjy9p0VhIi9TgHaAEtw
 u1gMb9FUlzArVHAtXMSIOtCg5_PAvqtl7ku3go.rXuX5m6iqxiLIgiWAPLTGUZcUDrZAIyyPVTgp
 0_476YlERBun_JTpxVI8YKbbCUkphx6eBQjQ7HaiCwq5qkHfL1pVO0WMMojmPXJ9a6PLxej96Up0
 viPp8ePFUwkrVEeRPFBFjShYKfM7CYD_9CCBMl2XcLS6nBITK4h4PlHU1NzZa5h4n5OhuHivYiSu
 8vsYyvVziUF01.ye.pivlJVC0iDEEOkw5kgKVEwY8SA7o5CDlpiu3RPQuNvcxTmo.zTmK_gx1i2z
 pOAlLKBNtaTHjNfVemxRrqtIt1FVq1fwzCdWtRZwNNoVeoibR8FBQN8Z4xpIU_MNQfzDGJCX.Cy9
 TmDZiTLhYScXWmiC_nHVY6qC.3PngpCfuoYoryhDaeow4Z5p9miKBCPdJ4_2BTboOgLZoqGN7ARo
 n25K2vIwEwsUP9Hpjz.D6bilBFDWQrE8Ex3sJ3j2siO2nMlVR2KYdppq0wIy.gmUSC7uWXuZJJQw
 OdwJ1rlsMo.QmwQd13W52VU0mHw6YlR2qStLzmDFSxpiEYVwiTXRM3xHR2UdOZSNV0tCRsUnT0RM
 QMeD96GHKRz3h3S3q54gr3poi4cDLx_KunT0.ia869BSYyqAu.YKHdo0cc4qV_v1gXDDWhZsZcKp
 hIow2S_WSsVZ3jxsz_qty_aT7Je5tJkMEcPX1JvJI139tnTiYGjS4TnuRggf21WEmQ7u4JU_7M6T
 njVbJus_Xm2jQX1CxXB6sU4G7GGPCw21r1Km3OLqoiMQ89kYC_Zdnu.CWGSxE_QZgATuMG2c4M6L
 5_sg2zeh2reAFYNr333wPUC7ZWiU3YvKIi_lhaow0iz63sjfrwjghNI5xKcS5KWcE1eZKeN3HiLc
 NP1cyGh9VaTnj9QrPZZYXZJYcBBpzIbuIWDL3ZadG.JsseBKpzx9zQfavy1w1hl76obf82U53c5l
 G6D1qlaXOuvo.IOakwcotJfZp_2yYZe1p.8SKK_vek9xSycV1LyMyFyhvuIeFB5f9poitS65NdA.
 qr8_r_nRvjemQxRBjT.JOJazsTu4cxdaRtOZOly7chKy44yzgY1x9QZJKVn4bAeLT7ykXjzDk6N5
 6o6RIs6nCF_c-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: af4079dc-9681-41bd-a2be-da77c45f5527
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 20 Oct 2023 19:42:47 +0000
Received: by hermes--production-ne1-68668bc7f7-tcb7m (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 61b855ece54e3c9ac0b267506fbc72a7;
          Fri, 20 Oct 2023 19:42:45 +0000 (UTC)
Message-ID: <8880b6e1-eae7-4317-b038-05aedcb41532@schaufler-ca.com>
Date:   Fri, 20 Oct 2023 12:42:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 08/11] Smack: implement setselfattr and getselfattr
 hooks
Content-Language: en-US
To:     =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
 <20230912205658.3432-9-casey@schaufler-ca.com>
 <20231003.uva7zohqueNu@digikod.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231003.uva7zohqueNu@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/2023 7:28 AM, Mickaël Salaün wrote:
> On Tue, Sep 12, 2023 at 01:56:53PM -0700, Casey Schaufler wrote:
>> Implement Smack support for security_[gs]etselfattr.
>> Refactor the setprocattr hook to avoid code duplication.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Reviewed-by: John Johansen <john.johansen@canonical.com>
>> ---
>>  security/smack/smack_lsm.c | 95 ++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 90 insertions(+), 5 deletions(-)
>>
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index f73f9a2834eb..12160d060cc1 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -3626,6 +3626,46 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
>>  	return;
>>  }
>>  
>> +/**
>> + * smack_getselfattr - Smack current process attribute
>> + * @attr: which attribute to fetch
>> + * @ctx: buffer to receive the result
>> + * @size: available size in, actual size out
>> + * @flags: unused
>> + *
>> + * Fill the passed user space @ctx with the details of the requested
>> + * attribute.
>> + *
>> + * Returns the number of attributes on success, an error code otherwise.
>> + * There will only ever be one attribute.
>> + */
>> +static int smack_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
>> +			     size_t *size, u32 flags)
>> +{
>> +	struct smack_known *skp = smk_of_current();
>> +	int total;
>> +	int slen;
>> +	int rc;
>> +
>> +	if (attr != LSM_ATTR_CURRENT)
>> +		return -EOPNOTSUPP;
>> +
>> +	slen = strlen(skp->smk_known) + 1;
>
>> +	total = ALIGN(slen + sizeof(*ctx), 8);
>> +	if (total > *size)
>> +		rc = -E2BIG;
>> +	else if (ctx)
>> +		rc = lsm_fill_user_ctx(ctx, skp->smk_known, slen, LSM_ID_SMACK,
>> +				       0);
>> +	else
>> +		rc = 1;
> Can we move these checks into lsm_fill_user_ctx()? They are similar for
> AppArmor and SELinux.

Possibly, but that would make lsm_fill_user_ctx() into lsm_validiate_and_fill_user_ctx(),
and I don't want to do that.

>
>> +
>> +	*size = total;
>> +	if (rc >= 0)
>> +		return 1;
>> +	return rc;
>> +}
