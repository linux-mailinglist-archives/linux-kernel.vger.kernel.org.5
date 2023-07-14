Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28347754264
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbjGNSN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236551AbjGNSNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:13:54 -0400
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E6E3A8F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:13:33 -0700 (PDT)
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
        by cmsmtp with ESMTP
        id KM9IqfG6TWU1cKNHeq1S2V; Fri, 14 Jul 2023 18:12:51 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id KNHdqHBNq9oEhKNHeqNAQv; Fri, 14 Jul 2023 18:12:50 +0000
X-Authority-Analysis: v=2.4 cv=WtE4jPTv c=1 sm=1 tr=0 ts=64b19022
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=ws7JD89P4LkA:10 a=wYkD_t78qR0A:10 a=QX4gbG5DAAAA:8
 a=snExLxxF2foCdKK6ZiwA:9 a=QEXdDO2ut3YA:10 a=AbAUZ8qAyYyZVLSsDulk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KCsVJp5qnfX7Jssk4LxDYEngrFE1DQACmhXzG+7FPBA=; b=M2IOJ51RbQeLWTH+hDTujo/BcT
        FNGZuK6zQ5WsYaZHqy6e15H9gS0lstlxNAYl6nkOh9BrObTSI01DAmMJe+kH1UJWGrbwfRjKj3wVZ
        w+XvmqONUISjI0gjmhcYyH0Shq8M7WpiSJLsFGokjDm3VPjHFrCKY2/l5PKU9/TZ7VaSJR3Kd7u1p
        uTY2pS3Eb6v6ATGGsMcFTfxWmCiptiGBISG4owzTHEMkGc7IF+IN/YI17JqIeJf2KLdhqg8DfDyiN
        J+jUs0Lu3d/IszVp55sQ2rf2wsCXnNhmQPTNBlgQqMxittAJ9wmHEw3lkzaCGock2N4feeHIM7DfP
        vXjo6oYg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:55814 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qKNHc-002I2a-1y;
        Fri, 14 Jul 2023 13:12:49 -0500
Message-ID: <442403e3-317e-8744-3348-dc9823c22074@embeddedor.com>
Date:   Fri, 14 Jul 2023 12:13:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: replace 1-element arrays with flexible arrays
Content-Language: en-US
To:     Alex Deucher <alexdeucher@gmail.com>,
        =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     alexander.deucher@amd.com, kernel@collabora.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-hardening@vger.kernel.org
References: <20230712083137.1080883-1-ricardo.canuelo@collabora.com>
 <CADnq5_OUS=JDfCdrCsuzTB0xD5yeX7piEDEqkRO-ffPTFVYs3g@mail.gmail.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CADnq5_OUS=JDfCdrCsuzTB0xD5yeX7piEDEqkRO-ffPTFVYs3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qKNHc-002I2a-1y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:55814
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCWN5E+A21o7qlnfGrkwqe1rJilXbZuu6J/t+F6pPCy9b5ncvOpAow3Ggam8SQj0gLA5V8KuW7uNp0uDHCxyLsD7ofYlpkgV2IhcxbOKPfU5Pa+puLBv
 eIWnjrg7r3JeKBVItBmQHelWnTB4YQDkQMGT1C/0nOj33ZOlm0ohfztMKtJ9y3r9T1CKK+ZLqYvcJnG/Ya5O8tbqPh+ewnHOOY+4qDD7BWbO/+poqWcmq58g
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/23 08:12, Alex Deucher wrote:
> On Wed, Jul 12, 2023 at 8:04 AM Ricardo Cañuelo
> <ricardo.canuelo@collabora.com> wrote:
>>
>> UBSAN complains about out-of-bounds array indexes on all 1-element
>> arrays defined on this driver:
>>
>> UBSAN: array-index-out-of-bounds in /home/rcn/work/repos/kernelci/kernelci-core/linux_kernel_mainline/drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/processpptables.c:1249:61
>>
>> Substitute them with proper flexible arrays.
> 
> + Gustavo, Paulo
> 
> I haven't kept up with the flexible arrays stuff.  Is this equivalent
> to a zero sized array?  We've been bitten by these kind of changes in

In terms of size, yes: the size of each array declaration does not
contribute to the overall size of its containing structure.

However, in these cases, using the DECLARE_FLEX_ARRAY() helper is not
required. Simply removing the '1' from the array declaration will suffice.
This helper was created to declare flex-array members in unions, as well
as in structs that contain no other members aside from the array.

In any case, these changes are not complete, as they're only modifying
the struct declaration, hence the size of the struct is affected. Now
the rest of the code where these structs are involved should be audited
and adjusted to accommodate the change in the sizes of the structs.

> the past.  These structures define the layout of data in a rom image
> on the board.  If the struct size changes, that could lead to errors
> in the code that deals with these structures.
> 
> Alex
> 

Thanks
--
Gustavo
