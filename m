Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18777D6B11
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343542AbjJYMQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjJYMQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:16:47 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813F612A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:16:43 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50797cf5b69so7635255e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698236202; x=1698841002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l6enL5EbyDfVL6+C+BZSR7yee3p77mBvqCgXCd423pQ=;
        b=vcD/k8GCRaQ1ThDJ7LoedY/ON0NLKdVNmvkYYP1V2q0Tk8rDm3izvg7MrvKKmVQ7st
         WHGCqZO1qLjwPpaO6Z4Q805mCQmAOESt5PCEMU9iaWTq3S7ce855ZV1nssN7VB24U6n0
         37v1Es7URZt1gsMQBJP+su4xP8x/4iW4rJfzbmm3tyLKAH3mCi7K4/WOefAMeLREp+So
         ulNapVkkv4h75OqEROeoXjSL3J73yseZKG48PQU8kdQZkc737aok4NanCLTE92B0nTlR
         LUzrL+NHKL/Nh+00pa9hiO9XO6KtLvhTtMA5I7DIPlxQa2witTB7E3cJoWj9Latfupbq
         bN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698236202; x=1698841002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6enL5EbyDfVL6+C+BZSR7yee3p77mBvqCgXCd423pQ=;
        b=tfuc6kxcvnSRuiy7NfeA1yaKBO/FlrBHea8HoCbWVz+EBSR1p2yAcQoyId0u83pJ8J
         at4DP3ELztcIzOLHzI5/nitXBWnt6yILtpB5+lNe03lQe/8MJLjYZ6PIty3ZwWGzby8q
         BSXtWjTfEf58Jo5NzpSxl+Q71wMDC1re3+Zg27fnWE5mVBo225TD7vpzspoNL97VSOXv
         Bw7CuJwwT52cf55kgloTRp5wGUCrs6tfThUISAPB6pqIomTak8vKLrSogQ+XXKONp3Jb
         s4IKpoK5U5Nerkod4yUlbT2MbbKXwdWQ1BGIU7LQWTFlIYNf+XubSQUYOe93gJZKr9mB
         X2IA==
X-Gm-Message-State: AOJu0YxvymNJ/wXRe+rcQbrMxFLFLmndSQgJ50BScEPr/9SUQwScG+Lt
        IOqPLk9sj2KPK0U05PgJ7k1EoA==
X-Google-Smtp-Source: AGHT+IEFA6aHGTY5ZaZDxLfpdX+ICUrYbRcgGlM172dy60d4sgJiuydb3ODCVjhW/oUznlxvfDMtJA==
X-Received: by 2002:a05:6512:2356:b0:507:b14e:b10d with SMTP id p22-20020a056512235600b00507b14eb10dmr13201259lfu.66.1698236201634;
        Wed, 25 Oct 2023 05:16:41 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id b24-20020a05600c06d800b004064e3b94afsm19103500wmn.4.2023.10.25.05.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 05:16:41 -0700 (PDT)
Date:   Wed, 25 Oct 2023 14:16:39 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Wojciech Drewek <wojciech.drewek@intel.com>
Cc:     Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-next 1/2] i40e: Remove VF MAC types
Message-ID: <ZTkHJ6IP4tj3EmCV@nanopsycho>
References: <20231025103315.1149589-1-ivecera@redhat.com>
 <20231025103315.1149589-2-ivecera@redhat.com>
 <8a8f54a8-1a18-4797-a592-b57bc6fc45c1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a8f54a8-1a18-4797-a592-b57bc6fc45c1@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Oct 25, 2023 at 12:48:37PM CEST, wojciech.drewek@intel.com wrote:
>
>
>On 25.10.2023 12:33, Ivan Vecera wrote:
>> The i40e_hw.mac.type cannot to be equal to I40E_MAC_VF or
>> I40E_MAC_X722_VF so remove helper i40e_is_vf(), simplify
>> i40e_adminq_init_regs() and remove enums for these VF MAC types.
>> 
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> ---
>>  drivers/net/ethernet/intel/i40e/i40e_adminq.c | 33 ++++++-------------
>>  drivers/net/ethernet/intel/i40e/i40e_type.h   |  8 -----
>>  2 files changed, 10 insertions(+), 31 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
>> index 29fc46abf690..896c43905309 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
>> @@ -17,29 +17,16 @@ static void i40e_resume_aq(struct i40e_hw *hw);
>>  static void i40e_adminq_init_regs(struct i40e_hw *hw)
>>  {
>>  	/* set head and tail registers in our local struct */
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
>
>What about removing those I40E_VF_* defines?
>This is their only usage here, right?

Wait, do you suggest to use the values directly? That would be
wild even for i40e :)


>
>> -	} else {
>> -		hw->aq.asq.tail = I40E_PF_ATQT;
>> -		hw->aq.asq.head = I40E_PF_ATQH;
>> -		hw->aq.asq.len  = I40E_PF_ATQLEN;
>> -		hw->aq.asq.bal  = I40E_PF_ATQBAL;
>> -		hw->aq.asq.bah  = I40E_PF_ATQBAH;
>> -		hw->aq.arq.tail = I40E_PF_ARQT;
>> -		hw->aq.arq.head = I40E_PF_ARQH;
>> -		hw->aq.arq.len  = I40E_PF_ARQLEN;
>> -		hw->aq.arq.bal  = I40E_PF_ARQBAL;
>> -		hw->aq.arq.bah  = I40E_PF_ARQBAH;
>> -	}
>> +	hw->aq.asq.tail = I40E_PF_ATQT;
>> +	hw->aq.asq.head = I40E_PF_ATQH;
>> +	hw->aq.asq.len  = I40E_PF_ATQLEN;
>> +	hw->aq.asq.bal  = I40E_PF_ATQBAL;
>> +	hw->aq.asq.bah  = I40E_PF_ATQBAH;
>> +	hw->aq.arq.tail = I40E_PF_ARQT;
>> +	hw->aq.arq.head = I40E_PF_ARQH;
>> +	hw->aq.arq.len  = I40E_PF_ARQLEN;
>> +	hw->aq.arq.bal  = I40E_PF_ARQBAL;
>> +	hw->aq.arq.bah  = I40E_PF_ARQBAH;
>>  }
>>  
>>  /**
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
>> index 9fda0cb6bdbe..7eaf8b013125 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_type.h
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
>> @@ -64,9 +64,7 @@ typedef void (*I40E_ADMINQ_CALLBACK)(struct i40e_hw *, struct i40e_aq_desc *);
>>  enum i40e_mac_type {
>>  	I40E_MAC_UNKNOWN = 0,
>>  	I40E_MAC_XL710,
>> -	I40E_MAC_VF,
>>  	I40E_MAC_X722,
>> -	I40E_MAC_X722_VF,
>>  	I40E_MAC_GENERIC,
>>  };
>>  
>> @@ -588,12 +586,6 @@ struct i40e_hw {
>>  	char err_str[16];
>>  };
>>  
>> -static inline bool i40e_is_vf(struct i40e_hw *hw)
>> -{
>> -	return (hw->mac.type == I40E_MAC_VF ||
>> -		hw->mac.type == I40E_MAC_X722_VF);
>> -}
>> -
>>  /**
>>   * i40e_is_aq_api_ver_ge
>>   * @hw: pointer to i40e_hw structure
>
