Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655CC79D736
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbjILRIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbjILRIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:08:39 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E022110;
        Tue, 12 Sep 2023 10:08:35 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76de9c23e5cso363397285a.3;
        Tue, 12 Sep 2023 10:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694538514; x=1695143314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4otOjvr3R3E7logGWkXFy9+KYYJe3UIuAQ28yWhDj8Y=;
        b=h+ZtrU+neS7QDoRm57I8MIf0u03+11/XgCcGvjT9lKZ0hUwNsU8kB3IpYiX5KOBhzJ
         6kw+2FpqvIERbgyiXFYtv2DdHRWBubPR1fHe00eWr6zsRNflCK3cWDqw2TsCrxWombev
         jZ9ALqizCQp6JBy4Mwma/A060QGsyqV+XHlsG6ASNRAtHeS/Zh6efw2pt46UnuMW2dM8
         4DxGuieSVFe4wtME+ZiJ2Hoyv9KmPZ6Ah4Mb8IXm6Lir+mj4M/4OWobQcWfl137YskSU
         hYzuCq6FRAtoWD2hg74N0qkijg9+PZlMG2Iwd4pt1iBCHlWAXWwtVBqaXkYsymB6g7hh
         PlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694538514; x=1695143314;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4otOjvr3R3E7logGWkXFy9+KYYJe3UIuAQ28yWhDj8Y=;
        b=LaV8gmEHDpIWQqsBkhroKzhJ7ToBN1ATsHhp2ExYj1co50Jeax0SE4ZpNYkQps6G61
         fyySYl0Z5DFfhWmvfvu5Gj4xvGrxngagySv27GKOtRjySeoSl9DwhtSLXgJxh/50j9Qp
         1duTIe9IBmrNCT8uAx/FM7Gy3Y5pcABpY5Vg0UJKDKohh6OGITI7XcyLIOdH3U6fvDy9
         90bWrHETUdCt8ixJN31h26CU1AKvA9YXWHT7T5FwMTiLp5RPVMjA05gC3PCOq0h6QMw+
         HjqJEJFh0GggsSPpYANdS+eo8NPamj8Xvhlz7H2RG4e7Pt2CzbXGdpZFyIzYaTgarFf+
         xTeg==
X-Gm-Message-State: AOJu0Yw5ND5HDlodzEse4u/1zFAAWHmnCw29wxUlwQrXX5GC1B4MkSZt
        HVuGDJ3DsTMYvt5VC3i8GX9eK7x+L8LoNA==
X-Google-Smtp-Source: AGHT+IH0YlRsKUwbUPupJzN/kK/Mrv09y8VEdwhCA23jNg+rGsU/96R8koDbmRSm5P9eNc4G/NxG4g==
X-Received: by 2002:a05:620a:2908:b0:765:9f15:c324 with SMTP id m8-20020a05620a290800b007659f15c324mr7586qkp.48.1694538514537;
        Tue, 12 Sep 2023 10:08:34 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id k7-20020a05620a142700b0076c89639526sm3305782qkj.93.2023.09.12.10.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 10:08:32 -0700 (PDT)
Message-ID: <4da2f97e-5bfe-fd94-0540-a10ca65d0b58@gmail.com>
Date:   Tue, 12 Sep 2023 10:08:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH net-next 1/7] net: phy: introduce phy numbering and
 phy namespaces
Content-Language: en-US
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        =?UTF-8?Q?Nicol=c3=b2_Veronese?= <nicveronese@gmail.com>,
        thomas.petazzoni@bootlin.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
 <20230907092407.647139-2-maxime.chevallier@bootlin.com>
 <d0a4c2c5-2d2b-42b6-a15c-06f9dc3c1e04@lunn.ch>
 <20230912181010.615d6b79@fedora>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230912181010.615d6b79@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/23 09:10, Maxime Chevallier wrote:
> Hello,
> 
> On Tue, 12 Sep 2023 17:41:31 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
>>> Introduce a numbering scheme allowing to enumerate PHY devices that
>>> belong to any netdev, which can in turn allow userspace to take more
>>> precise decisions with regard to each PHY's configuration.
>>
>> A minor point, and i know naming is hard, but i keep reading _ns_ and
>> think namespace, as in ip netns. Maybe we should think of something
>> other than ns.
> 
> Yeah that was the initial idea, to imply that the numering is
> independent between netdevices... I thought about "phy_list", "phys",
> "phy_devices" but none of that felt correct :(

How about phy_devices_list?
-- 
Florian

