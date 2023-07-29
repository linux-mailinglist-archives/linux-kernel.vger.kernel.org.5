Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75ACD767B90
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 04:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjG2Ckv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 22:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjG2Ckq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 22:40:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D6446B9;
        Fri, 28 Jul 2023 19:40:44 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RCTDY6131zNmYJ;
        Sat, 29 Jul 2023 10:37:17 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 29 Jul 2023 10:40:41 +0800
Subject: Re: [PATCH v2 -next] keys: Remove unused extern declarations
To:     Jarkko Sakkinen <jarkko@kernel.org>, <dhowells@redhat.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>
CC:     <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230724144717.23660-1-yuehaibing@huawei.com>
 <CUE18VURE744.1E29WQ8EU666G@seitikki>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <a6826fc1-3319-9ca6-4c25-61703424f052@huawei.com>
Date:   Sat, 29 Jul 2023 10:40:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CUE18VURE744.1E29WQ8EU666G@seitikki>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/29 2:55, Jarkko Sakkinen wrote:
> On Mon Jul 24, 2023 at 2:47 PM UTC, YueHaibing wrote:
>> Since commit b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
>> iterate_over_keyring() is never used, so can be removed.
>>
>> And commit b5f545c880a2 ("[PATCH] keys: Permit running process to instantiate keys")
>> left behind keyring_search_instkey().
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Please use the fixes tag properly.

OK， will add fixes tag in v3.
> 
>> ---
>> v2: Also remove keyring_search_instkey()
>> ---
>>  security/keys/internal.h | 7 -------
>>  1 file changed, 7 deletions(-)
>>
>> diff --git a/security/keys/internal.h b/security/keys/internal.h
>> index 3c1e7122076b..471cf36dedc0 100644
>> --- a/security/keys/internal.h
>> +++ b/security/keys/internal.h
>> @@ -109,13 +109,6 @@ extern void __key_link_end(struct key *keyring,
>>  extern key_ref_t find_key_to_update(key_ref_t keyring_ref,
>>  				    const struct keyring_index_key *index_key);
>>  
>> -extern struct key *keyring_search_instkey(struct key *keyring,
>> -					  key_serial_t target_id);
>> -
>> -extern int iterate_over_keyring(const struct key *keyring,
>> -				int (*func)(const struct key *key, void *data),
>> -				void *data);
>> -
>>  struct keyring_search_context {
>>  	struct keyring_index_key index_key;
>>  	const struct cred	*cred;
>> -- 
>> 2.34.1
> 
> 
> BR, Jarkko
> .
> 
