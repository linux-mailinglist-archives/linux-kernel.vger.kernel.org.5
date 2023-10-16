Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3957CB0E9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbjJPRDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbjJPRDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:03:22 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233032720;
        Mon, 16 Oct 2023 09:41:42 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4181e268447so33585181cf.1;
        Mon, 16 Oct 2023 09:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697474501; x=1698079301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p4Tn0hTDyHkVTPWKQdaEhkQ4FlIC2s9fFr2Zb+BIJWk=;
        b=BwuNWpp6KdPUEVuuaLRlKpGaooZIPbJfNB2TKrpul0/0HH0mR+eVgxNu55cNcJB2ts
         MaLSI/0RHakEM3HeCHPgUvCPAGHbpWeI3OGXta6oS2VVRPf/87l423ZQcVNv3jyXAL0u
         o0ETxKB+3RTRzKze1nNNxUhFIUQrEglWwVZrN7tc+3n7QK7eRvw9wcRXrowDy0vmJ+9r
         WAFGdNVv8QIgLbI0f5LqBq52Vc5MwthhyX/7AJovdfRMjM9TRcfW+5RwxwJc4blaXniX
         X2thCHBjgULSwLLoIJMHzht9vHhrWgEq55HkbCcsloMW1bQZ1vp5qFBOtMOUruMuYkpk
         /gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697474501; x=1698079301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p4Tn0hTDyHkVTPWKQdaEhkQ4FlIC2s9fFr2Zb+BIJWk=;
        b=k14ZfRlJoaLxxvGSqh+ZdIUgo2Rs9Y9uMOtE8GNR2opt5l4ttaxau0ieq9RCsnHECa
         HFWjD7tYMrfN0zzsw2X2iBvuoz9qrwEqQhQvsfbuqnRPJYx7Hxo7W7l9sqjIzcTpgeP+
         w6KNmIr/SmMmHTqo1yqHnfHB6/dll5q6SCz+gFI3TXx71dI6EAvrECakPz84zW12aSoi
         r668IUzigJeXXorVj0ih2iMH36/oaW8V0GXtdcXWnEAGosNmhNaTT5TEKvaKfvh0ssKU
         Qqp4jTrbVvWjSuNSWEkk5M6JFfWknbP+aQdk9cE02ZgOQnEoEyjX517DGACMCt2GygXa
         r1sg==
X-Gm-Message-State: AOJu0Yy/1zlgIygPs0j7qRa+7D0pAF6JMmEONbmllFkevEDNB2BfUBS/
        A5EzvvhA/F+z/ZUr92l1gQI=
X-Google-Smtp-Source: AGHT+IHqVpggNu+ii0SHrH08qvBi2XpiI/K0hmpxEmKsgbPNFoRSHIAP2DrOD7lqW1LrCmhEqgMNBw==
X-Received: by 2002:ac8:7dd3:0:b0:410:9089:6b74 with SMTP id c19-20020ac87dd3000000b0041090896b74mr48344327qte.15.1697474500952;
        Mon, 16 Oct 2023 09:41:40 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id bv10-20020a05622a0a0a00b004109d386323sm3138150qtb.66.2023.10.16.09.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 09:41:40 -0700 (PDT)
Message-ID: <ea6918d3-7e8c-4e31-9efb-cb9f3360962a@gmail.com>
Date:   Mon, 16 Oct 2023 09:41:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net: dsa: Use conduit and user terms
Content-Language: en-US
To:     Vladimir Oltean <olteanv@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>
References: <20231013215251.152912-1-florian.fainelli@broadcom.com>
 <20231013215251.152912-1-florian.fainelli@broadcom.com>
 <20231013215251.152912-2-florian.fainelli@broadcom.com>
 <20231013215251.152912-2-florian.fainelli@broadcom.com>
 <20231016132334.b5pz7kw5oitk32z2@skbuf>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231016132334.b5pz7kw5oitk32z2@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/23 06:23, Vladimir Oltean wrote:
> On Fri, Oct 13, 2023 at 02:52:50PM -0700, Florian Fainelli wrote:
>> Use more inclusive terms throughout the DSA subsystem by moving away
>> from "master" which is replaced by "conduit" and "slave" which is
>> replaced by "user". No functional changes.
>>
>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> ---
>> diff --git a/Documentation/networking/dsa/configuration.rst b/Documentation/networking/dsa/configuration.rst
>> index d2934c40f0f1..e6c9719874b0 100644
>> --- a/Documentation/networking/dsa/configuration.rst
>> +++ b/Documentation/networking/dsa/configuration.rst
>> -Past this point, the DSA slave network devices get delivered regular Ethernet
>> +Past this point, the DSA user network devices get delivered regular Ethernet
>>   frames that can be processed by the networking stack.
>>   
>> -Slave network devices
>> +User network devices
>>   ---------------------
> 
> Please adjust section underline width.

Done.

> 
> Do we want a sentence in the documentation that clarifies that "user interfaces"
> and "conduit interfaces" used to be called "slave interfaces" and "master interfaces"
> (for 15 years), so that old time users don't get confused as to what happened?

Sure, we can do that.

> 
>> @@ -863,7 +863,7 @@ int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
>>   }
>>   
>>   /* This enforces legacy behavior for switch drivers which assume they can't
>> - * receive VLAN configuration when enslaved to a bridge with vlan_filtering=0
>> + * receive VLAN configuration when enuserd to a bridge with vlan_filtering=0
> 
> when joining a bridge
> 
>>    */
>>   bool dsa_port_skip_vlan_configuration(struct dsa_port *dp)
>>   {
>> @@ -1057,7 +1057,7 @@ static int dsa_switch_event(struct notifier_block *nb,
>>   		err = dsa_switch_tag_8021q_vlan_del(ds, info);
>>   		break;
>>   	case DSA_NOTIFIER_MASTER_STATE_CHANGE:
> 
> As Stephen points out, maybe you want to change this notifier name as well.
> 
>> -		err = dsa_switch_master_state_change(ds, info);
>> +		err = dsa_switch_conduit_state_change(ds, info);
>>   		break;
>>   	default:
>>   		err = -EOPNOTSUPP;
>> diff --git a/net/dsa/tag.h b/net/dsa/tag.h
>> index 32d12f4a9d73..f6b9c73718df 100644
>> --- a/net/dsa/tag.h
>> +++ b/net/dsa/tag.h
>> @@ -9,7 +9,7 @@
>>   #include <net/dsa.h>
>>   
>>   #include "port.h"
>> -#include "slave.h"
>> +#include "user.h"
>>   
>>   struct dsa_tag_driver {
>>   	const struct dsa_device_ops *ops;
>> @@ -29,7 +29,7 @@ static inline int dsa_tag_protocol_overhead(const struct dsa_device_ops *ops)
>>   	return ops->needed_headroom + ops->needed_tailroom;
>>   }
>>   
>> -static inline struct net_device *dsa_master_find_slave(struct net_device *dev,
>> +static inline struct net_device *dsa_conduit_find_user(struct net_device *dev,
>>   						       int device, int port)
> 
> Please adjust alignment.

checkpatch did not complain and my editor shows me the alignment appears 
to be proper, what am I missing?

> 
>>   {
>>   	struct dsa_port *cpu_dp = dev->dsa_ptr;
>> diff --git a/net/dsa/tag_8021q.c b/net/dsa/tag_8021q.c
>> index cbdfc392f7e0..71b26ae6db39 100644
>> --- a/net/dsa/tag_8021q.c
>> +++ b/net/dsa/tag_8021q.c
>> @@ -468,10 +468,10 @@ struct sk_buff *dsa_8021q_xmit(struct sk_buff *skb, struct net_device *netdev,
>>   }
>>   EXPORT_SYMBOL_GPL(dsa_8021q_xmit);
>>   
>> -struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *master,
>> +struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *conduit,
>>   						   int vbid)
> 
> Alignment.

Likewise.

> 
>>   {
>> -	struct dsa_port *cpu_dp = master->dsa_ptr;
>> +	struct dsa_port *cpu_dp = conduit->dsa_ptr;
>>   	struct dsa_switch_tree *dst = cpu_dp->dst;
>>   	struct dsa_port *dp;
>>   
>> diff --git a/net/dsa/tag_8021q.h b/net/dsa/tag_8021q.h
>> index b75cbaa028ef..41f7167ac520 100644
>> --- a/net/dsa/tag_8021q.h
>> +++ b/net/dsa/tag_8021q.h
>> @@ -16,7 +16,7 @@ struct sk_buff *dsa_8021q_xmit(struct sk_buff *skb, struct net_device *netdev,
>>   void dsa_8021q_rcv(struct sk_buff *skb, int *source_port, int *switch_id,
>>   		   int *vbid);
>>   
>> -struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *master,
>> +struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *conduit,
>>   						   int vbid);
> 
> Alignment.

Likewise.
-- 
Florian

