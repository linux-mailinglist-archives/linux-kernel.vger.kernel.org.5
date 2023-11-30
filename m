Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F5A7FEB5D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjK3JG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjK3JGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:06:24 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5054B9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:06:30 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3330d64958aso463359f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1701335189; x=1701939989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eJ5LmNpN5QcwNvER/5g/ZnTRjIBCAtvU7kmUUks1hNI=;
        b=K0r+XOF3C1iQrXytK+rIxZgSSQ4W3ZrViMomJ53pkTXvfed3TxRzJnkSfx2jQqDvbf
         Q/adUp9UM8LyR07bO56ApOj0+oeH0PlHHQd09Pd+a6h+eBhiVO0Gpbfj9g/FQpurGSuK
         WA6kidV2RCAUeQ/d0NRPf6XbVA5p0bQehtcXy2CYNaJbTlo2DxpfIS4pcc+9/C0iZZWQ
         4ns/84AB9yOGtlsjkgrEhFFg9kw3DEx6dO9b3IniK3gjeT0TI8V5CRb0H9f1sfzbauh+
         yep7L5cZ4S+brErHelCDZx/92yTt0OLcm+91FFnCb1b0RnP+xczjF+CnHR6yE6BMBWLv
         DQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701335189; x=1701939989;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJ5LmNpN5QcwNvER/5g/ZnTRjIBCAtvU7kmUUks1hNI=;
        b=V+k9wiW2lfdR6k0nbnj3+A2gu9JlhZtctkjr+k13N/bmzYarw8+AR+++05/NJz/+td
         ItNLuhh9a4rzQbFOa9jjxsBU+a1ACbx5FATTJCgkQzvpQB4tcKoEbCK+7HONjSAEL6zj
         DMwXsYv4LXjiV8taMHN4pEf6PH2Gc2yRA8CRzJ64SjBryAQriw6sUDDEoePfICbA2JT5
         1RcOiKK6MG1K4aBF7llqYt2N83ex29vR+61iZPjAV8xRgicTUhtGFlkNc7BknfCVIg4J
         fBcXq9WlsTyL34d6PT+/9BsgJtmFJrCv6IuYCxmSK3Yi4mJEJ/Ii31i6Ycl3uwZ3RaQj
         XBiQ==
X-Gm-Message-State: AOJu0YxspvSYFguaUa2Yz1cduOom2zHoN3sql/xGwNd4JkwHXFzefz/N
        Rj+n0qTJFlRiELQ01FUHeu+mWw==
X-Google-Smtp-Source: AGHT+IG3qiBMyklUjHLUA0JpQRxzV/uVj6ZdX1vKxXoWyydiAQzpr8xbbllWv+CAuQ+aC0bky0EhcA==
X-Received: by 2002:adf:f1c6:0:b0:333:75c:362f with SMTP id z6-20020adff1c6000000b00333075c362fmr7589388wro.45.1701335189038;
        Thu, 30 Nov 2023 01:06:29 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id e9-20020adffc49000000b00332cfd83b8dsm929523wrs.96.2023.11.30.01.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 01:06:28 -0800 (PST)
Message-ID: <51dd35c9-ff5b-5b11-04d1-9a5ae9466780@blackwall.org>
Date:   Thu, 30 Nov 2023 11:06:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next] netkit: Add some ethtool ops to provide
 information to user
Content-Language: en-US
To:     Feng zhou <zhoufeng.zf@bytedance.com>, daniel@iogearbox.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangzhenze@bytedance.com,
        wangdongdong.6@bytedance.com, tangchen.1@bytedance.com
References: <20231130075844.52932-1-zhoufeng.zf@bytedance.com>
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231130075844.52932-1-zhoufeng.zf@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/23 09:58, Feng zhou wrote:
> From: Feng Zhou <zhoufeng.zf@bytedance.com>
> 
> Add get_strings, get_sset_count, get_ethtool_stats to get peer
> ifindex.
> ethtool -S nk1
> NIC statistics:
>       peer_ifindex: 36
> 
> Add get_link, get_link_ksettings to get link stat.
> ethtool nk1
> Settings for nk1:
> 	...
> 	Link detected: yes
> 
> Add get_ts_info.
> ethtool -T nk1
> Time stamping parameters for nk1:
> ...
> 
> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
> ---
>   drivers/net/netkit.c | 53 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
> 

Hi,
I don't see any point in sending peer_ifindex through ethtool, even
worse through ethtool stats. That is definitely the wrong place for it.
You can already retrieve that through netlink. About the speed/duplex
this one makes more sense, but this is the wrong way to do it.
See how we did it for virtio_net (you are free to set speed/duplex
to anything to please bonding for example). Although I doubt anyone will 
use netkit with bonding, so even that is questionable. :)

Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>

Cheers,
  Nik

