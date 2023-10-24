Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA5C7D50DE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbjJXNDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbjJXNBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:01:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E353128
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698152471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TdTXynsl0mVy35KpmI9bLMXkB0nwWaN15oyfZ6foo9E=;
        b=Yjn5ZFGmYJrfUDfd2I5W8ZoGykHe5SIFcJ9mHa3GMzx9uGuOIPBiiXGACWJ+/G2dHGlkNq
        aXhSAmUmeR7u2QV8Uigr6PXD8YcrQi53xXBjLvOAKKdCRppLPBm9Lr6NNhwoT3cagSd2u2
        4FO+Cq49OU4jIyj/sgwXkgmYnRSRpZY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-_Yx9v7gsPGSlGCwy8j95PA-1; Tue, 24 Oct 2023 09:01:07 -0400
X-MC-Unique: _Yx9v7gsPGSlGCwy8j95PA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8EBE857BC5;
        Tue, 24 Oct 2023 13:01:05 +0000 (UTC)
Received: from [10.43.2.183] (unknown [10.43.2.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E865A492BD9;
        Tue, 24 Oct 2023 13:01:03 +0000 (UTC)
Message-ID: <d71f2fa2-e5b7-4221-bbd0-86285b6c1c33@redhat.com>
Date:   Tue, 24 Oct 2023 15:01:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 2/3] i40e: Add other helpers to
 check version of running firmware and AQ API
Content-Language: en-US
To:     Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org
Cc:     intel-wired-lan@lists.osuosl.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20231023162928.245583-1-ivecera@redhat.com>
 <20231023162928.245583-3-ivecera@redhat.com>
 <2aba9a2d-9dfd-49f2-bfec-1ff563a5f017@intel.com>
From:   Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <2aba9a2d-9dfd-49f2-bfec-1ff563a5f017@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24. 10. 23 12:24, Wojciech Drewek wrote:
> On 23.10.2023 18:29, Ivan Vecera wrote:
>> Add another helper functions that will be used by subsequent
>> patch to refactor existing open-coded checks whether the version
>> of running firmware and AdminQ API is recent enough to provide
>> certain capabilities.
>>
>> Signed-off-by: Ivan Vecera<ivecera@redhat.com>
>> ---
>>   drivers/net/ethernet/intel/i40e/i40e_type.h | 54 +++++++++++++++++++++
>>   1 file changed, 54 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
>> index 050d479aeed3..bb62c14aa3d4 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_type.h
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
>> @@ -608,6 +608,60 @@ static inline bool i40e_is_aq_api_ver_ge(struct i40e_hw *hw, u16 maj, u16 min)
>>   		(hw->aq.api_maj_ver == maj && hw->aq.api_min_ver >= min));
>>   }
>>   
>> +/**
>> + * i40e_is_aq_api_ver_lt
>> + * @hw: pointer to i40e_hw structure
>> + * @maj: API major value to compare
>> + * @min: API minor value to compare
>> + *
>> + * Assert whether current HW API version is less than provided.
>> + **/
>> +static inline bool i40e_is_aq_api_ver_lt(struct i40e_hw *hw, u16 maj, u16 min)
>> +{
>> +	return !i40e_is_aq_api_ver_ge(hw, maj, min);
>> +}
> It feels a bit off to have those helpers in i40e_type.h.
> We don't have i40e_common.h though so I'd move them to i40e_prototype.h or i40e.h.
> Same comment regarding 1st patch (I know I gave it my tag but I spotted the issue
> while reading the 2nd patch).

I'm sorry I already submitted v2 and helpers are present i40e_type.h.
I would submit v3 but there is also i40e_is_vf() inline function already 
present in i40e_type. Would you be OK with a follow-up that would move 
all these inlines into i40e_prototype.h?

Btw i40e.h is not a good idea as this would bring a dependency on i40e.h 
into i40e_adminq.c, i40e_common.c and i40e_dcb.c.

Regards,
Ivan

