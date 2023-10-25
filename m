Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6E57D6F3B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbjJYOkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344217AbjJYOkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:40:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1CA136
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698244767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fKSNaHDd6rmGllCi23XMfucJBxxGAMgO6JLoDnVZ6/0=;
        b=hti+1FV4CAGzWzbBblZcEFGgRbt9OVNw5IAIDlKb4b8DGD2xSHoQhgpWDdTdLJualNiYD6
        8D/JkNBt+JdwOzvvT3vhHyqZn+/JnJaEkpIGgHyi1dPggjGk912ZTO8OdE8WJbEujqcCAU
        Umrbjf7QBYbWaoc51DWI95fxEozJUPI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-uGjaI0IbPZiTFloVzjgFZA-1; Wed, 25 Oct 2023 10:39:20 -0400
X-MC-Unique: uGjaI0IbPZiTFloVzjgFZA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4A3788D140;
        Wed, 25 Oct 2023 14:39:18 +0000 (UTC)
Received: from [10.45.225.62] (unknown [10.45.225.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 619A0492BFA;
        Wed, 25 Oct 2023 14:39:17 +0000 (UTC)
Message-ID: <cbb2e9f4-03f8-4a46-99e4-e952bb754a2f@redhat.com>
Date:   Wed, 25 Oct 2023 16:39:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 1/2] i40e: Remove VF MAC types
Content-Language: en-US
To:     Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>
References: <20231025103315.1149589-1-ivecera@redhat.com>
 <20231025103315.1149589-2-ivecera@redhat.com>
 <8a8f54a8-1a18-4797-a592-b57bc6fc45c1@intel.com>
From:   Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <8a8f54a8-1a18-4797-a592-b57bc6fc45c1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25. 10. 23 12:48, Wojciech Drewek wrote:
> 
> On 25.10.2023 12:33, Ivan Vecera wrote:
>> The i40e_hw.mac.type cannot to be equal to I40E_MAC_VF or
>> I40E_MAC_X722_VF so remove helper i40e_is_vf(), simplify
>> i40e_adminq_init_regs() and remove enums for these VF MAC types.
>>
>> Signed-off-by: Ivan Vecera<ivecera@redhat.com>
>> ---
>>   drivers/net/ethernet/intel/i40e/i40e_adminq.c | 33 ++++++-------------
>>   drivers/net/ethernet/intel/i40e/i40e_type.h   |  8 -----
>>   2 files changed, 10 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
>> index 29fc46abf690..896c43905309 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
>> @@ -17,29 +17,16 @@ static void i40e_resume_aq(struct i40e_hw *hw);
>>   static void i40e_adminq_init_regs(struct i40e_hw *hw)
>>   {
>>   	/* set head and tail registers in our local struct */
>> -	if (i40e_is_vf(hw)) {
>> -		hw->aq.asq.tail = I40E_VF_ATQT1;
>> -		hw->aq.asq.head = I40E_VF_ATQH1;
>> -		hw->aq.asq.len  = I40E_VF_ATQLEN1;
>> -		hw->aq.asq.bal  = I40E_VF_ATQBAL1;
>> -		hw->aq.asq.bah  = I40E_VF_ATQBAH1;
>> -		hw->aq.arq.tail = I40E_VF_ARQT1;
>> -		hw->aq.arq.head = I40E_VF_ARQH1;
>> -		hw->aq.arq.len  = I40E_VF_ARQLEN1;
>> -		hw->aq.arq.bal  = I40E_VF_ARQBAL1;
>> -		hw->aq.arq.bah  = I40E_VF_ARQBAH1;
> What about removing those I40E_VF_* defines?
> This is their only usage here, right?

Yes, do you want to remove them in this patch? Or follow-up is sufficient?

Ivan

