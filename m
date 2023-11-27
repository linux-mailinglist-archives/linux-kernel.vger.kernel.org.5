Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FED7FA8C2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjK0SSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjK0SR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:17:56 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEDF194;
        Mon, 27 Nov 2023 10:18:03 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77bb668d941so250320685a.3;
        Mon, 27 Nov 2023 10:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701109082; x=1701713882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GsGTK2OLrJvt6juuRuNX910QuTvJRVdp20QBvxaUol8=;
        b=Jy7zGHbeLZ6JmXbg/ir6ai/0xBw+9Z9azAzDaQSGny1u6wADGXkfSn1JFAWDJAKpPT
         A4nfL8r8y4uv0gdHQq/LFuKaROeINOQdMp18nbiiIvufsSdL9aFwBLCDv3EtfcpIgHwl
         vqXS2FGjRjlZJhHwal31PF7fMZmulyJMt2lzIEd/odkyWh4ApY+ER5XrIGr+vnocW09p
         /00g7/WxGFC9kXfFLVi6xi7hNk39bL3Xsj9VPec+yvi1gzQRVs+d+q4p/CSzdxvzvEQ2
         OiywoXHZD3KGKOt0a6XGGdDjXiI2NMtXw0n5CKsQHAD2YJtYIMsPxfGu0Xl9QOhwF9UX
         EnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701109082; x=1701713882;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GsGTK2OLrJvt6juuRuNX910QuTvJRVdp20QBvxaUol8=;
        b=lY3CDwwdF7Q4ujl1gqb/s+D54rsQS/8SN9WiWiuER4/5FvKk5ji2nmH6FyxS0oie5e
         bKSRf2p41/1fbGxW5nkigY8J6WFR/easLDsvlcDwUwke33FJ4XnInKjzWGFGwTLfuIWK
         acZ+DHlNJKl6W1r7EOhRt/kjm8ldJoel9DkO/aVMle4ZkTH7tpTQt+H2ZxmImgaQd3kt
         kD3HkED54pXryvN8QX2TpLHyEtFEfwmtTw/vRiJuZ+SvvDV7vIIgLiPuLRI6VotdGC0Z
         Y/hdbcQuQGkXsAoUwfmwL/1lGDgpHD5BL5Asgvtga1NABO91smR5CFKL+eUO00ROcRh4
         TSXg==
X-Gm-Message-State: AOJu0Yy9yA4s6drx+d6jrH0NrfIvuQSLPXI+SzIqZTsn5dqvICI7rVHl
        ANnQp2j34x3EXCT6dy4tqsw=
X-Google-Smtp-Source: AGHT+IG4L7etcA53wVQ832m9RBkpQABd3veCfryBv515K5QPpHsAyNH6MFRI+Y/ArlwZr6Gf6ulUdg==
X-Received: by 2002:ad4:4211:0:b0:671:8df:38f5 with SMTP id k17-20020ad44211000000b0067108df38f5mr14722219qvp.20.1701109082239;
        Mon, 27 Nov 2023 10:18:02 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ee5-20020a0562140a4500b0067a22a8564fsm2872202qvb.140.2023.11.27.10.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 10:18:01 -0800 (PST)
Message-ID: <8494d7b2-fe52-483e-9d2d-534040054315@gmail.com>
Date:   Mon, 27 Nov 2023 10:17:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 1/3] net: dsa: microchip: ksz8: Make flow
 control, speed, and duplex on CPU port configurable
Content-Language: en-US
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Simon Horman <simon.horman@corigine.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com
References: <20231127145101.3039399-1-o.rempel@pengutronix.de>
 <20231127145101.3039399-2-o.rempel@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231127145101.3039399-2-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/23 06:50, Oleksij Rempel wrote:
> Allow flow control, speed, and duplex settings on the CPU port to be
> configurable. Previously, the speed and duplex relied on default switch
> values, which limited flexibility. Additionally, flow control was
> hardcoded and only functional in duplex mode. This update enhances the
> configurability of these parameters.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

