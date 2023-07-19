Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA58758B00
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 03:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjGSBpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 21:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjGSBpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 21:45:20 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06E91BCD;
        Tue, 18 Jul 2023 18:45:18 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R5JXK407Bz18LxF;
        Wed, 19 Jul 2023 09:44:33 +0800 (CST)
Received: from [10.67.110.48] (10.67.110.48) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 19 Jul
 2023 09:45:16 +0800
Message-ID: <d1c27478-a90c-359e-dc49-fc2d9eec3112@huawei.com>
Date:   Wed, 19 Jul 2023 09:45:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC 7/20] selinux: services: update type for umber of
 class permissions
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
CC:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>
References: <20230706132337.15924-7-cgzones@googlemail.com>
 <703e95374a9a0d25186e7ac472f143d7.paul@paul-moore.com>
From:   Gong Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <703e95374a9a0d25186e7ac472f143d7.paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.48]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/07/19 6:01, Paul Moore wrote:
> On Jul  6, 2023 Gong Ruiqi <gongruiqi1@huawei.com> wrote:
>>
>> Security classes have only up to 32 permissions, hence using an u16 is
>> sufficient (while improving padding).
> 
> Can you explain the improved padding comment?  

I think what Christian means is that struct selinux_mapping will occupy
less memory since num_perms is changed from uint (32 bits) to u16, which
saves 16 bits of space due to padding.

> [...]
>
>> diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
>> index 8a9b85f44b66..b6f99353301e 100644
>> --- a/security/selinux/ss/services.h
>> +++ b/security/selinux/ss/services.h
>> @@ -12,7 +12,7 @@
>>  /* Mapping for a single class */
>>  struct selinux_mapping {
>>  	u16 value; /* policy value for class */
>> -	unsigned int num_perms; /* number of permissions in class */
>> +	u16 num_perms; /* number of permissions in class */
>>  	u32 perms[sizeof(u32) * 8]; /* policy values for permissions */
>>  };

Check here.

>>  
>> -- 
>> 2.40.1
> 
> --
> paul-moore.com
