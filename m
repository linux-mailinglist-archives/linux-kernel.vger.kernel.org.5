Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91817BEC68
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378215AbjJIVMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378151AbjJIVMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:12:01 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6024AF;
        Mon,  9 Oct 2023 14:11:56 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c724577e1fso39513805ad.0;
        Mon, 09 Oct 2023 14:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696885916; x=1697490716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VpnnDrV62Lb8b1mH1h65bJ9wtlLLlsDnibD389OPjEQ=;
        b=aoZqgYnu1QnLO/BWYNOQJNvpn7+eXqZeqtuzriseFYyz8NX+IxPAm5hfyRhX48EGIh
         RS6FI8i0sYwBxqRZTV6hXGBFGL1UoemIjazeVHsQBN/HA8k6vYuHy49uh7gwvD4C5VPQ
         yvDuSty2n1VjXjctus30PhxA3ulWx/Cw6DMKn9LYfElowRnaf0C0ba0M0wk9wnjMD1f3
         ylAvKsStZHunfJyyHwBI0AVLQ8F4IG0ePMRyHMgciOS2HrVSxMLupUg0Ci4S+xntzDQZ
         +EII456Tkc2028ws6TTPMykvccRCU1nB9EUqQ4rXLTsgeU9CEymMFvTOKSlusosFBqZe
         4Mkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696885916; x=1697490716;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VpnnDrV62Lb8b1mH1h65bJ9wtlLLlsDnibD389OPjEQ=;
        b=wdUGMeP2EAfrus7RW54m53Jxnd80c1OahMUmLRV4PJ7M+umfkyY5jZxoV+Q0krIsFy
         qgvYkyCQoN8t0kQbVF143FW4knlJbRcDqZPiG3XCfTbqn1IYdO79ojP5CzKX7DfrmATl
         6PVTJyVXEyLlyAhyuoyH03jTOaqV2hMAsngdntdqA/AA4DKidFgmRvz9o7XEEBTQ3qcf
         5TA3pscRMRlskTTsfsarXcxpJEkNrL4/E4/NunaLFrLRv7NtqXaypSUFPFPCEqLbIUqX
         iP4k/oyHE17ociI5A9nEiVhPsOxoMm7DHoEGi1t9UMo3lX3c05ra/JhN2gudw8dshYGg
         R79Q==
X-Gm-Message-State: AOJu0Yyizh/5WqB2XCUwpdC/YnuzLZt0MeTyJzLwbbiqUaUxlboH7cJq
        eF2PsckCMk92ORvVUcT9ptg=
X-Google-Smtp-Source: AGHT+IEq56jSvqiDxz07W/Q7rS9rGk4uKwrfoZiuJu5LOp10BwoK329vd33JpGbWgWs89AoJ5LLEpA==
X-Received: by 2002:a17:902:f546:b0:1c5:b622:6fcd with SMTP id h6-20020a170902f54600b001c5b6226fcdmr20629948plf.22.1696885916089;
        Mon, 09 Oct 2023 14:11:56 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id c16-20020a170903235000b001c0a414695bsm10106370plh.43.2023.10.09.14.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 14:11:55 -0700 (PDT)
Message-ID: <d6e6b07e-ae54-4c69-bd93-3b5cf0aaeef4@gmail.com>
Date:   Mon, 9 Oct 2023 14:11:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 06/16] net_tstamp: Add TIMESTAMPING SOFTWARE
 and HARDWARE mask
Content-Language: en-US
To:     =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
 <20231009155138.86458-7-kory.maincent@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231009155138.86458-7-kory.maincent@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 08:51, Köry Maincent wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 
> Timestamping software or hardware flags are often used as a group,
> therefore adding these masks will easier future use.
> 
> I did not use SOF_TIMESTAMPING_SYS_HARDWARE flag as it is deprecated and
> not use at all.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Maybe you can squash this patch where it actually gets used in patch 10?
-- 
Florian

