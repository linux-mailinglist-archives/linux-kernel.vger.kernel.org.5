Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A4F7564E0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjGQN0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjGQN0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:26:32 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FB310D5;
        Mon, 17 Jul 2023 06:26:14 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-668730696a4so2895747b3a.1;
        Mon, 17 Jul 2023 06:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689600372; x=1692192372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zW664bGxEnZ5EFbso5lCDiNh/UezKb1BOyXuR9ms9f4=;
        b=PgfUMQDPYU8KG+K4+CmizByhgoVOetvDukfYRh31rqipWbjYtKTjspnMDqYE3zoRkT
         NReGr3vGY4cioBxL83F/3ixBWTGdGtYhSTGna+PxQLGWaYjyTJ6LgURskBT+MNQns2yb
         X9x51lv6DbhNgA6varNpb42ZQixFRg+0T1Rk1ccIwdgGeKAJoAfHvuqiDOEeDz4ucMXi
         +Nt0umgbLmpiqQpZB+jDE6wmais50I+1M62TCcZ9J0chC+ju5/Tko9BmOElo7VwIpnQ9
         0sIDYXADv0kZmrFMLx6/xKKzCyBf7X9/rpTVAxFTDzbIcjDY9m2BrPmzH08HF+h8sIAO
         gryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689600372; x=1692192372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zW664bGxEnZ5EFbso5lCDiNh/UezKb1BOyXuR9ms9f4=;
        b=HZ8IjsTaVXoRcBHgiTLU4EXrPBVPdR3jWpcwgrUM1BtdsPczcKvV90JpLfaIGOfyaw
         2PUurfcbOo2skxHZUjG5tOB81vbEDe3vuT+kLVViv/179Pm393O/NZg3T0jec55SOq/P
         yo6HO41viPM0gfwjNFPPX2SH07GjBHP6VSLLMrc28ritEkAjSDcMFe7n0UGc6v+piE1X
         ZamlkBudISMimZhDk1+MBlqaVpjgIB2AozYuUeZt7XIfCT8ZiYA4Ixh3VNrWtTrDnMA8
         k/lB1kSznZtfPqhVgdtkMioQ3WIrpyUn41x/n37GgDW1rcggqHp716veRA70opKGwO0Y
         9Asw==
X-Gm-Message-State: ABy/qLYknQCnrZDVzfonziEew3DR7yxnqVfir2RBaVhXDAPi/qmz7TRj
        pt1mpNMaN2e8k4ml7c7aUOA=
X-Google-Smtp-Source: APBJJlGnflrQ9U1W+NRQJ5TX6IU+yRwfEMAsBGxqDd/liL9SU0BW+xmtKo/8Rp6+X3RCMczVDEfHcA==
X-Received: by 2002:a17:902:a60d:b0:1b8:b827:aa8e with SMTP id u13-20020a170902a60d00b001b8b827aa8emr9828230plq.11.1689600371861;
        Mon, 17 Jul 2023 06:26:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902d34c00b001b5640a8878sm12776366plk.180.2023.07.17.06.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 06:26:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fa5e92c2-de66-07f8-3696-15b56e0da3eb@roeck-us.net>
Date:   Mon, 17 Jul 2023 06:26:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 1/3] dt-bindings: watchdog: ti,rti-wdt: Add support for
 WDIOF_CARDRESET
Content-Language: en-US
To:     huaqian.li@siemens.com, wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     huaqianlee@gmail.com, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jan.kiszka@siemens.com,
        baocheng.su@siemens.com
References: <20230717064124.1315746-1-huaqian.li@siemens.com>
 <20230717064124.1315746-2-huaqian.li@siemens.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230717064124.1315746-2-huaqian.li@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/23 23:41, huaqian.li@siemens.com wrote:
> From: Li Hua Qian <huaqian.li@siemens.com>
> 
> TI RTI (Real Time Interrupt) Watchdog doesn't support to record the
> watchdog cause. Add a reserved memory to know the last reboot was caused
> by the watchdog card. In the reserved memory, some specific info will be
> saved to indicate whether the watchdog reset was triggered in last
> boot.
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Drop that. I did not realize you cheated, and I was just trying
to match the other (apparently fake) Reviewed-by: tags.

Guenter

