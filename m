Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C2B7C9BDD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 23:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjJOVSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 17:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJOVSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 17:18:49 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A541AA1;
        Sun, 15 Oct 2023 14:18:47 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-417f872fb94so28179271cf.0;
        Sun, 15 Oct 2023 14:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697404727; x=1698009527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZK3DjSDrs7+Fpjx53h+0VI7muc22Uwp8hTfWyevlIao=;
        b=mAUEdKRMcELyf3y53ETpjL6rINFVlSwUSWMUX3iiQv29we6zlBpWmM3Xf+YJcBO3u1
         sTJ1d1gW7V9i3PqP3Dt5cAtllldX7gfZZQyz39Jkdr8O7ekMrsDYq5Wp4F6WJYg0uVY4
         R9Nn06Bw4NNzwlk/ZpFdNTMdgxUItLPqNVFYLvbfhiMNmvyI+rOPqqdrvGmQJNevhZZI
         n82YvRIoAj16M1ORbHcH3/dmMLZQGTFz8LdbdNfL9Fi7AubzzqnrXRmcpVqy1tUM6lzm
         DXXAV/gKdY8UgmFYennRicOQWqzx9LKe6mMahwY/Sc1xJHrUXcEZICyVbv0nhFtyLyR6
         0Wgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697404727; x=1698009527;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZK3DjSDrs7+Fpjx53h+0VI7muc22Uwp8hTfWyevlIao=;
        b=JkzXl0y5spb+9PnjJ8iMeSpNH44CR796AAHnz78NgR1NckBfuQYHI5/ySw8D5MG3WB
         I7CYdYS99lOeAqqsbCJQURK0y9UCI7iS738pSOzligY+1cFeG7Py4B8V9rvCPvofaOY2
         3cS7cAcgMVw4WlzrcaXqdAFUIH58zn4EzyPsKormwWmJaGak6E540wXy7JE7WH72Xzge
         ZmC6fgijnMgdJIoWsJX9T6lBxeNp5PE+4vCSvJllhLorYz3OwJ9GYcaD1gk+o6XtE+BW
         9sntt9ZLExPUMEwwu7ReXhNvbwthml7K2BnKcS3nSJJgydK7lMXXD1543WEQ6gQz/lZF
         5Wkw==
X-Gm-Message-State: AOJu0YyYRCdzXLM+StqC2IoVQlfQ6anbg64oEu+kYwjSg70K0RwU3/RI
        qiam0BcOHfXVYHxMAUZ6kRI=
X-Google-Smtp-Source: AGHT+IE5lV49udTMBJubPOE9Br0wBZEZ+q481szijXd/ZC1Q/XOuqodJfDrN5ihP7pT48HinMMUcCw==
X-Received: by 2002:ac8:5916:0:b0:410:90c7:5185 with SMTP id 22-20020ac85916000000b0041090c75185mr40960539qty.54.1697404726705;
        Sun, 15 Oct 2023 14:18:46 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id ie4-20020a05622a698400b00403ad6ec2e8sm2474500qtb.26.2023.10.15.14.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 14:18:46 -0700 (PDT)
Message-ID: <188688f2-1028-41ee-ba0a-c52456f63111@gmail.com>
Date:   Sun, 15 Oct 2023 14:18:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/7] net: dsa: microchip: Set unique MAC at
 startup for WoL support
Content-Language: en-US
To:     Vladimir Oltean <olteanv@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
References: <20231013122405.3745475-1-o.rempel@pengutronix.de>
 <20231013122405.3745475-3-o.rempel@pengutronix.de>
 <20231013123249.bhigwsezy6afb5qt@skbuf>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20231013123249.bhigwsezy6afb5qt@skbuf>
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



On 10/13/2023 5:32 AM, Vladimir Oltean wrote:
> On Fri, Oct 13, 2023 at 02:24:00PM +0200, Oleksij Rempel wrote:
>> Set a unique global MAC address for each switch on the network at system
>> startup by syncing the switch's global MAC address with the Ethernet
>> address of the DSA master interface. This is crucial for supporting
>> Wake-on-LAN (WoL) functionality, as it requires a unique address for
>> each switch.
>>
>> Although the operation is performed only at system start and won't sync
>> if the master Ethernet address changes dynamically, it lays the
>> groundwork for WoL support by ensuring a unique MAC address for each
>> switch.
>>
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> ---
> 
> Why not take the MAC address of the user port at ksz9477_set_wol() time,
> and use the existing ksz_switch_macaddr_get() API that was just added so
> that this use case could work?

Agreed we do that in a number of Ethernet MAC and PHY drivers FWIW 
(net_device::dev_addr).
-- 
Florian
