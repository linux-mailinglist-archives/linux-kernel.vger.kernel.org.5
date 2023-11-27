Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADBB7FA8CD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjK0STU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjK0STT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:19:19 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2329194;
        Mon, 27 Nov 2023 10:19:25 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77bcbc14899so262040885a.1;
        Mon, 27 Nov 2023 10:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701109165; x=1701713965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5qzQ5jeraGpYSm3FpmqL9etjlYc/TVcStCfVUmtTsyo=;
        b=HIACrthQuZNNfi2GvxAkHUmki3wkb0T4CRQM0pAN0gbioOWCDiADj086Yj/aJEEl0g
         w6tBJtwJQ4iyeHZ5OFqxnHF2lJwvQs+ZimurvQBGQvoM+7cygj/yeUF9Afgt7zVzYN0e
         CyG5BW6DVw+Anz+HK4ZuGcMJFUW5OLaT2T5IU4jHGcOgT94EkY9kHzl/KWMU1xanaV6s
         /8DpwtQdJmLc/iEHwPSD4Zl1q+0LtyoYjjZgUTsL8/mwiTI9e7lCmr+p1iOPvOzqmP9v
         U6SfDGl30fKTkQrvMDyx2NfrhUKpfAzByNkzbUaDoyUZgr/jJvaVJS9FfLwWIkMgpbcm
         sSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701109165; x=1701713965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5qzQ5jeraGpYSm3FpmqL9etjlYc/TVcStCfVUmtTsyo=;
        b=O3Syn5AI5h6qBtfsCWpuMYR2dytVcEM1WRz4AT/FIX8fpUgHdqw1frMfRa9h7dUvGf
         oK6Pg1ES6UeP6xBJcI+ijFtwiA+YV1qgvGKLzHgvdP9aOvbIsW/x6ers328KGHYspdaL
         bSomOLg4JiimOypG39afFY2dUccz9OufZxh8MgDAWggu6tMXz8510YPQzvDDSqNC2zvY
         CT72vF1FyxdGD7ShtFBV6ETcjyP+AJ+KSJKlZrerQmNM1TQ55aAk7HVHCzRU5aRPSXGB
         a3T3xStg6eHV/YBqRjWVu2Ux8qOhu/f9JDb+6KupyevFXHJ0lg/3h0ZOgKkduDaQd+tD
         P7ZA==
X-Gm-Message-State: AOJu0Yw49aS1NMRDHXm6EZGRDljwpjiPX2rrMLBdA+8lkqrCgBo9EqlR
        TKtr2grBsQSJwvKmG2qdDMM=
X-Google-Smtp-Source: AGHT+IH74IMwgDe+ZnPL6RMPBzM5FqZt2ybZedW2xj+iYX/04nmo23R409BH9yUTSBSXHIHAOKHTlA==
X-Received: by 2002:a05:6214:190a:b0:67a:3f40:4bf8 with SMTP id er10-20020a056214190a00b0067a3f404bf8mr5018182qvb.19.1701109164719;
        Mon, 27 Nov 2023 10:19:24 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ee5-20020a0562140a4500b0067a22a8564fsm2872202qvb.140.2023.11.27.10.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 10:19:24 -0800 (PST)
Message-ID: <455296c5-a453-41a2-9c8d-e50146ec75a9@gmail.com>
Date:   Mon, 27 Nov 2023 10:19:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/3] net: dsa: microchip: ksz8: Add function
 to configure ports with integrated PHYs
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
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
References: <20231127145101.3039399-1-o.rempel@pengutronix.de>
 <20231127145101.3039399-3-o.rempel@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231127145101.3039399-3-o.rempel@pengutronix.de>
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

On 11/27/23 06:51, Oleksij Rempel wrote:
> This patch introduces the function 'ksz8_phy_port_link_up' to the
> Microchip KSZ8xxx driver. This function is responsible for setting up
> flow control and duplex settings for the ports that are integrated with
> PHYs.
> 
> The KSZ8795 switch supports asymmetric pause control, which can't be
> fully utilized since a single bit controls both RX and TX pause. Despite
> this, the flow control can be adjusted based on the auto-negotiation
> process, taking into account the capabilities of both link partners.
> 
> On the other hand, the KSZ8873's PORT_FORCE_FLOW_CTRL bit can be set by
> the hardware bootstrap, which ignores the auto-negotiation result.
> Therefore, even in auto-negotiation mode, we need to ensure that this
> bit is correctly set.
> 
> When auto-negotiation isn't in use, we enforce symmetric pause control
> for the KSZ8795 switch.
> 
> Please note, forcing flow control disable on a port while still
> advertising pause support isn't possible. While this scenario
> might not be practical or desired, it's important to be aware of this
> limitation when working with the KSZ8873 and similar devices.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

