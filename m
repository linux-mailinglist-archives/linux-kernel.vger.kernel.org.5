Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876B17D1670
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 21:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjJTTkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 15:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjJTTkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 15:40:19 -0400
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD70D61
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1697830816; bh=P4+dGmicz9DIRgkMgvxzJNVTrGjiL0Qm6oIu+orhbyc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=LroFa3qO6pBy7tLhU2ovGSSj/YrCevYSvCG4rHeNSvKyXlp50Zaxiz/SuBnuaUW73mKhLZlyLbwbmYdfM3beqZznaUAELtmElAzcaw6mY1CHVC1jAY1OZt4xOi5vp4Ogw//ZY30uAakLYPl+ZHrm+7e7y0kBOSI9gjBN4oOCInseFhG6UvgRvJMfINsycXeZqNGQ6Rx3WN+9jnl7ryL68MC8unq7XhUjyW/syjB9zv729+aOEBfhmcZuoK6MamuA1bl5ONDRsenmuEdHAaeSUADgshKT3J8gIwbrc9R2BkUuhYfBRVIydGFkir8ZcqtqaTBxAR2TBWx8VWvVdezelw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1697830816; bh=8geZSWnK915HLFaha7VQtqVdHbbNlm/muP/a81Uh7MZ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=T7Vbt5cW0WIIxo14iznqW7PtVty3tsdpTJ18ZHmytY+0FyvgMhuypZaRXMFKQ3Tm9Kg+qVVbDQQGFu9s+HF0T2T9zSjOlqe1yiJjAFtx8LB0wBMKePzRIFpSU85O8nmBikWpmrcGN2vHMjiyF6qEbS4yX/LqaQFn5IVoRnUVOE6o5heM1KqYBGIrgp5yPp6nZEAhoWy6i3rzFLkcwNVR1wnlIOvYVAGAzIi1s4vbKVmS1Zm4XWuKcjSwceh88dlLC81oE1ovIVMNsGTqqN49m5skVPz96aekOmJCTg953rTbLZVxyqzc73cantsqy0zio1jfs27GDimHKZHad+fAWw==
X-YMail-OSG: 8IEvnCgVM1k3HIj8QSXm.EDFHxycBdzdL8VmP.KjBaVop4mD3TwdjQI1z2rL8Wg
 CxegDuBxiPU4Qz7VVP72FwSpeQhAh96Nuo1beDjSJYVYLU94_UiYRwx1nCSLHA.7bN29Wu.HBiK6
 A_LsXDoejIEEX.cVRogn95WPE97SFMHhZvwE_rMZ5l2CTHGgS7TSi6Tq7GAh7mUbQl_iwOJ51Ekq
 LdMX5Ix9S0zCDXSNGOUt2ufCF9s1cqHqZUR9pfkdMV7Hz6sBeJeGkGTDfIZ4j6xHn29JE_iyPOeq
 yRGkTuFXeUzkOyvSxz4cTGh3lyg.0yGj1YRCfdKBDRAstp90mpookOLXBhcKFY6.vu02i9lD_lTs
 71oJhfsGEeXcxDNee_j1J5DNwbkR3DXBPu7YGqNAUgakgYuGH4ACL3AN.z5uh_YFa.13af3UZlGC
 IotS0R6S3.xcQCh95OZLPy5y97.zScLtZFGNf3TU2ueaS93os2JshDbze.pguqGl3BO1hgi39SL9
 qfR4aiEjHIh3kaXmbU_h7pz9W9jso_ooAxnOceO7cHOPb02dsv4InWw_rsduBal0d34h4B3TU79Q
 soxNxRhaj7Pl_DYBhcwLTyrR66FMZTS3KCM3BIH0FoDPinQ0HfUYWbi1VK1o.a378K9sEM6kbm75
 n.nbbeQui1LANINxpTpsOUSHi89oQ_a_X5JztS6c0eqQiOVvFlfWJMFICWHrXTuJEFtFtFzb9Gxk
 2pKeIJ7U73.Gz7h.pIYq0hSeX1o65qZfe1lz7M7kJwmzlQbcXj47ik8XDpzBd.sEmc8O3BZWCXCR
 X4kGOeUdKRo6fH.I0YMOva9EN0W7b5ZzZb4k.5z6E5M79.vzrNtmQQrwvgzRNJTWKvQMHRxnd6YR
 bAFiYEepWwRTa9YpN9K.xbx0.5ggYKUsap_LBmt92wSFDhBUoUwqxwj0UIjKPybadTtpT4TMJaaK
 UIelVtdKx8GR4q2pnPI43Yt2U0V1kixqy4egK9DRFazZefKcriWR28J2he7QP4t0X5dXPSelRqS3
 unbIXVH3iEs.QcL6.UKgBkbscwOHuPqoBsoDmsiZRMSfW_PwZ4faPwPdqGGsTbVQMGokFNI7fhWB
 22hArxfYPhCNDQMgfzaFzV0oLHdJ.iOsCMpe50K6Sb3uDF9Brsy2dtQoNE78guSeHG0Jawps9o6x
 i16JoR40dJzPMJocu7MtwJ0IAdZaur62eb22KGVxHMuAZnk7HPQ9UyvPfmjbf_oKMGQsDHkovcXV
 wsJPjxBHlCe.tiYt9mztOg9WH5O8KjHnles3vSftKFxDazO7RakVVzoYzNieiPICD6eJewckH5OW
 yhWCP2JSGlYo2o9m2A3V8sfmLK7T9NR863gKqp6Nsfmn2yqjWLCJRqkPUtG6F9YQPVprX2avxYBo
 BYwviCy34Yk99q1TjvzEt.WjF80FkJIygrCzTXS215ssHNlmSxlRs1ma29Rc0neD2YFRIJwRua4a
 oF5B1AvsKf7ACmHOUWfI_ETL4fg5R.kRM56AUZh7.CqPLvvg_NV3Uy8lS9YN1z9KawHFlc9gCfip
 Av0XyLDJmNU3qGUsk51wbtNrqJbahSfxatus1ONYThyUrIWc5G2wsXNvkz.mHHUz07mWxtRO5F7n
 CiEVG6IE3LToCVsOr.D6KYunFWDANGhH3aFh25q9biamI3hP821FxoSsfBRuklTRp1zL06Gnmq3W
 Sjctv4O4Yai1JC_C8VXCBDRYI.N.UkBN6nUoBDRKWc.bQH9aUqvJulYxpO.vvalqy4IV_i_rqH4g
 zz9_uBMvhMIpcBrHSK4XefsDU_5.wz_mYMp_SxWs_Ymg1gsM8JooSUSrs_gB9YAhjxpay_387xV4
 sVmt1_IaAdrlQtRTWqBc3q5HNJgLogqWU4EbMasJsP_tc5oN6k8SnYwikNJyDKP7.9laNxFGpAEL
 SgFcV9bGeML9BNLQpNPMz38zphxTRZrd5xJ4PI8EdVjyB_oDQzL1U6ft849U.KhxlADhBxahZmP1
 pjxGpJdk9TC.FSqC_MwXwjzjohtUPC.0tPczVv58Bpb.L0MJloSxPBmC_5p.UUq8.nGv974H5vC3
 Z6iPcM3k.IlapLO9BTpKF2T1_tzFQuGYvxJjOqts3nroGSJjFtsGqGI8t.dRcQn8EjLzC_0XIiM3
 fHoMPwERQ0z5r19mXHZTrXTP.lQpGT5639YnA8fTtMb4M1jJpf8ZBDC4WGg72KEUSPRGyWzqJkQ9
 wF4viW2sdjut4Ek8tn2pD4wqbJg13cWex290ZVYWaosH1QARqGY3KiVrP97CceKXNeS9GNmN9fN0
 .UWjbZcBa8QtU
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: fbd246bd-d168-47ed-ac28-d72132a1d3dd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Fri, 20 Oct 2023 19:40:16 +0000
Received: by hermes--production-ne1-68668bc7f7-bhhrm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f0b4bd6dfbd94eb190fd6ebd13636346;
          Fri, 20 Oct 2023 19:40:15 +0000 (UTC)
Message-ID: <c47ed955-f2c4-4356-a13e-90fb8fad6449@schaufler-ca.com>
Date:   Fri, 20 Oct 2023 12:40:13 -0700
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
>
>> +
>> +	*size = total;
>> +	if (rc >= 0)
>> +		return 1;
>> +	return rc;
>> +}
