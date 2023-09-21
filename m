Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFE37AA382
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjIUVv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjIUVvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:51:07 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97AE66372;
        Thu, 21 Sep 2023 10:53:07 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690fa0eea3cso1096734b3a.0;
        Thu, 21 Sep 2023 10:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695318781; x=1695923581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XHuJ7BTGYLX/fwLQnd2cpHBWJn57UyO8h1tWeuupHTc=;
        b=CXJcrC0Unp4Xm/ZygVRivLfwIRnDI6NxWIliMteblc5Tg+/FYRvXw4LFglIjM/IE1P
         IaKW5wPNJGEPdzoH2CCPKHDLSLK7mvEqKM0nFdb8X1okDkIxmAiKc14fRitNfgdx8yoN
         lrzsliClqnrTJPH/folRjOReG7BsRVTK/Yt4Im4l1FumDUqDp0lm/wNTKDkTnd/xQ3AH
         9q81Mr7WlSzzF70ecCigl7cxArFyxk1D6fsjCxHwl2tqGtrDgFe7Rskgqu5CBlkZe35I
         eLIhYclLgQNykRPRWF9fenhBisfje/2yEr+zwJeMRZWs1i2XIzOLU1SXkSkjoIeVFwRL
         CUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318781; x=1695923581;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHuJ7BTGYLX/fwLQnd2cpHBWJn57UyO8h1tWeuupHTc=;
        b=VG7cttTSSzrD/VDvlvZVJW4sOI6viLCdK4PJ87ykQMNfnDdvyBJQJoWNoKXgCQ/YST
         s8QBMhcor5GJxnpQJ2PaK8ZIRQ7GAaRN4vQjon3/nyG6RcntPRiAyto2kHFpbHMomzrZ
         nVwzIliwMWggImkNBu8fHt2uEI9sn/bTtgw0YsSm4HXT5M6Q9A7uf475w8zPtCGe1ukE
         HC14wgbWpcQ9Fn+EzwgLaJe5rvoKAItBPJBiFYTUa4hmR4M/4BLGDFny5L6I4Bhqovgl
         2rDiU91roHkejv4kHU7Fty3LjqTdKMN6MuWEDcS/j79qPwpON0s7Ojj+jAvZfty67jln
         5kUQ==
X-Gm-Message-State: AOJu0YyDNoNqDRScBq4T4KMkypUVaFA1FJFnOSFr7kYzkiU+HKwbhtDU
        DfdLkOeRRLiRiMf8CKb0oag=
X-Google-Smtp-Source: AGHT+IEoTmPNXOMGKusK4wexaLbXyXVmGp7os6X9lKM+xyqmC4XhiledoKFSVypT0hfevDwbtGiliA==
X-Received: by 2002:a05:6a21:498a:b0:15d:5f9a:3921 with SMTP id ax10-20020a056a21498a00b0015d5f9a3921mr2021043pzc.27.1695318781163;
        Thu, 21 Sep 2023 10:53:01 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id b2-20020aa78702000000b0068620bee456sm1659432pfo.209.2023.09.21.10.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 10:53:00 -0700 (PDT)
Message-ID: <c0103cd4-7779-1f7c-2d90-d1d0512aa1ba@gmail.com>
Date:   Thu, 21 Sep 2023 10:52:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 net-next 5/5] net: dsa: microchip: Enable HSR
 offloading for KSZ9477
Content-Language: en-US
To:     Lukasz Majewski <lukma@denx.de>, Tristram.Ha@microchip.com,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20230920114343.1979843-1-lukma@denx.de>
 <20230920114343.1979843-6-lukma@denx.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230920114343.1979843-6-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 04:43, Lukasz Majewski wrote:
> This patch adds functions for providing in KSZ9477 switch HSR
> (High-availability Seamless Redundancy) hardware offloading.
> 
> According to AN3474 application note following features are provided:
> - TX packet duplication from host to switch (NETIF_F_HW_HSR_DUP)
> - RX packet duplication discarding
> - Prevention of packet loop
> 
> For last two ones - there is a probability that some packets will not
> be filtered in HW (in some special cases - described in AN3474).
> Hence, the HSR core code shall be used to discard those not caught frames.
> 
> Moreover, some switch registers adjustments are required - like setting
> MAC address of HSR network interface.
> 
> Additionally, the KSZ9477 switch has been configured to forward frames
> between HSR ports (e.g. 1,2) members to provide support for
> NETIF_F_HW_HSR_FWD flag.
> 
> Join and leave functions are written in a way, that are executed with
> single port - i.e. configuration is NOT done only when second HSR port
> is configured.
> 
> Co-developed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

