Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52F978FD53
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349477AbjIAMeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238417AbjIAMeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:34:16 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B67107;
        Fri,  1 Sep 2023 05:34:13 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bee82fad0fso15136805ad.2;
        Fri, 01 Sep 2023 05:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693571652; x=1694176452; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKS56aNj/oeFJ6bZnMlQ2+jsvafiN0tr1LTFMkTVK/o=;
        b=bHsQa1xjRfQVki4aQd9ZuexIG4nu//O6yp1Tl8LBQ62fhQiZHidCa570FSFleDbYZu
         1Z0v+mwcl9qu9XUZaYoHws/XLs7zf1L43xjLzo2AdljfBnW20O2o8pDUs8vMxg2pDD8U
         rNoKNCOzQkIJrNxoYsPzGcxdlzAz4H/d5Ai6idWX0micie1pHBmyI5Ixq6mX7ygYauVN
         4GeQDmL0iFkCkcUHw7jQidtH9Amfz8H4StV3WoeiGc5Oci2T0n5y0NOoiVs/cQTBZ0hL
         urXh3OViFW3KgIAaEG9Pqp16OUXq0Gb2cZUPq58uOK75RW1vKRGuNHLfp1qOeo0XDf4d
         We3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693571652; x=1694176452;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FKS56aNj/oeFJ6bZnMlQ2+jsvafiN0tr1LTFMkTVK/o=;
        b=fv76qhqawMwyfq2SN1xmXTn2IM01gZpowv0/PwsxF+kUgFxXa6CJK+NfGp529FG+rS
         cF+Gc/dY7g0gM4omkgworyVguJ0zdzK17S/5ZZcDGhaSzb9monGs9XiTWiHdqBw4F0i0
         YyT8HMQt7dnV+TPOqpLxuk48wKiT0+KLh5Lu1ktOPjpjxoja6crthWU1qTKVqT9+ogci
         qeRITncK7o/rjTs0u+nm0+5WjfoSL+PRgqXc1VwtVv6owQYcpaObrFqLLtsCpXEnbcSa
         t6mWmShR2Mx+9bxrD9hbJs/SUXjNbDlfKavMBM25UB09Is1q5YZtVEQYNo8NGrMxqxLC
         /P/g==
X-Gm-Message-State: AOJu0YxlG2ZGwTrryAoog4u0gfGV5jznVr1X659/NnejNYYGmlAHUQQK
        GnHDxmpIc1O14MvJYI2ttjE=
X-Google-Smtp-Source: AGHT+IGakq/z2ybFt6VKBYFE9cXXze6xF7ush+DUKu06qQzDjF341STBSR2N7SVW5dvAhAQ7BkBmIw==
X-Received: by 2002:a17:902:e841:b0:1b9:e591:db38 with SMTP id t1-20020a170902e84100b001b9e591db38mr3216676plg.8.1693571652516;
        Fri, 01 Sep 2023 05:34:12 -0700 (PDT)
Received: from [192.168.0.105] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id g24-20020a170902fe1800b001b0358848b0sm2935191plj.161.2023.09.01.05.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 05:34:11 -0700 (PDT)
Message-ID: <c0b931e2-ae3a-bd20-ca43-b931571602c1@gmail.com>
Date:   Fri, 1 Sep 2023 19:34:07 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        llancelot7@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Input Devices <linux-input@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Betop Titanwolf Hotas Bundle missing axis and second Hat
Content-Type: text/plain; charset=UTF-8
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

Hi,

I notice a bug report on Bugzilla [1]. Quoting from it:

> I has USB Flashfire Cobra V5 Hotas wich recognized as:
>    11c0:5608 Betop Titanwolf Hotas Bundle
> 
> Problem is in that bundle missing Throttle axis and second Hat, because it's mapped to Sync.Report:
> 
> GenericDesktop.X ---> Absolute.X
> GenericDesktop.Y ---> Absolute.Y
> GenericDesktop.Slider ---> Absolute.Throttle
> Simulation.Rudder ---> Absolute.Rudder
> GenericDesktop.HatSwitch ---> Absolute.Hat0X
> GenericDesktop.HatSwitch ---> Sync.Report
> GenericDesktop.Rx ---> Absolute.Rx
> GenericDesktop.Ry ---> Absolute.Ry
> Simulation.Throttle ---> Sync.Report
> 
> 
> Kernel 6.4.10
> 
> P.S. is it needs special "driver"(quirk)? Or hid joy really can recognize more than 1 Hat, because I saw only `map_abs(ABS_HAT0X);` for `HID_GD_HATSWITCH` in hid-input.c

See Bugzilla for the full thread and attached debug logs and a patch
that fixes the report.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
