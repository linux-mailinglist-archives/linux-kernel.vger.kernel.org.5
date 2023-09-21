Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883F77A99AD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjIUSRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjIUSQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:16:39 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD624F39F;
        Thu, 21 Sep 2023 10:49:15 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690bc3f82a7so1174768b3a.0;
        Thu, 21 Sep 2023 10:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695318554; x=1695923354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W2wfV/E+fvJQFqOd9U3s9nuYGhY7TXlGuTmZ5ygRn+8=;
        b=a2DDzy2Hn6fyIB8+uAex48RezFQZAFdSV1hKWQz7++mBCS9m7wwx8uQz5PQgF/A3sG
         xFNd21SWNhFR8/xJUKet4qbglN1BWSZC+0tAqtnwScaAMcdQudU3uH+aLrpXxfFQ4k6g
         a3ZiroInKBQV+MdP6hs3qYYrGcoZX0mjwk2QTeUOws8/WGZufMwwVo4zf0Iu+sru94VV
         S4Ar5Ph1kX+mJUHQXSNj+TQBm205MAES6Bnj6fYk57jg91RxP3yop8oKwrTn4T1dbQJ4
         WWDQM9xNX3OwwjGgR+7sg8z2829mPyEPYiTkPUxOLWp6Qf1RDvG8tRXeWymQS4I6SJ1G
         1PNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318554; x=1695923354;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W2wfV/E+fvJQFqOd9U3s9nuYGhY7TXlGuTmZ5ygRn+8=;
        b=A6wo9wgNfNZryBNOt+LWcdmdoPKv+EaNAD6oWHAn2I6fjeut0PoFue00vzhIWLE6ga
         vSPkJIVVsaHuL8GKCnOsyNmYqUlVv2LCsygtbHYV1YHcB7O1imAMBpdZu7UpuYRc9mGT
         tMk3Fl8kDWpFARZuk2qVSqF4rczqDBLkGHd3j56lRYMAEWjNwPq2cOw+7HxQRwuMs3lY
         Uck65v+gGMWIrS5EalcR/0lbPzpeeRp7rYLd+tFXyQsHjxjKCN/AgBoBVLVjaNBEzZ+B
         CZFZEqvtv1cmy/p1b5fvZhvEHM9G3GHZmAI26jXGMISo8JhKS+wa9+Flm8d+AThqd/Sl
         Ilog==
X-Gm-Message-State: AOJu0YzPofDCqAXHnvtqYL7xH1lwPOO9mtxvt8S1IGM4+8byDghZ9Kfd
        k6OXTUuYtm3ERlSYTtalW6U=
X-Google-Smtp-Source: AGHT+IFN5Qo3S/gdKI6RmUoa7YqqeNvU1hWE9nakU7LnRUBc6U0ZDuU9E4v7k6zRTh6J6kMRfLaI/g==
X-Received: by 2002:a05:6a00:b45:b0:68f:b72f:9aca with SMTP id p5-20020a056a000b4500b0068fb72f9acamr6785120pfo.27.1695318554312;
        Thu, 21 Sep 2023 10:49:14 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id j1-20020aa783c1000000b006675c242548sm1660426pfn.182.2023.09.21.10.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 10:49:13 -0700 (PDT)
Message-ID: <96ef7250-d382-095c-495b-836d5c61ab31@gmail.com>
Date:   Thu, 21 Sep 2023 10:49:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 net-next 2/5] net: dsa: notify drivers of MAC address
 changes on user ports
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
 <20230920114343.1979843-3-lukma@denx.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230920114343.1979843-3-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 04:43, Lukasz Majewski wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> In some cases, drivers may need to veto the changing of a MAC address on
> a user port. Such is the case with KSZ9477 when it offloads a HSR device,
> because it programs the MAC address of multiple ports to a shared
> hardware register. Those ports need to have equal MAC addresses for the
> lifetime of the HSR offload.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

