Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AF078D135
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 02:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238370AbjH3AnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 20:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbjH3Amd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 20:42:33 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1C819A;
        Tue, 29 Aug 2023 17:42:30 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-56c250ff3d3so232511a12.1;
        Tue, 29 Aug 2023 17:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693356150; x=1693960950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nqBGU9u1vGB8q2WDmOt/P3uNLvgaRaNASZ7VqIyPuPA=;
        b=m1I2JOaSxnYJ586wCUyU7xCaPU8oaz4fws6A5XcTyjBaG8VtwVJmNb2BjqVfhW8zQw
         HEc/nVswEmA1imcPV58JduI1bi7Erp6eFWM2JAvk1KZPHK3YNMnqDy5zhoKYgcWGVpQY
         vHSdtw/D+DZg3Ah+o8tLrtjaRRL2hCfPemv56hTKVf+0avG9NmP+ZdXcZyr0rZmzFXPc
         MOKEgAB71T1Z7lD5OafGwOk267ahub3QP8ZCabmZR/uEwV+wprIB8GVTGDCodKk/6VOW
         ILArsKRrV4ap/i2gjP5u9KFme/MTwciVk4uLPwj7lGMZ+4tehlF+Xjrj99pJPJEGUUiD
         sSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693356150; x=1693960950;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nqBGU9u1vGB8q2WDmOt/P3uNLvgaRaNASZ7VqIyPuPA=;
        b=YKsLHepzVXNMaPgJ3uZMn1YtjGkL380UrNyfb0GcLMebv6Yb07LxjpQ6594TnFVwSC
         pcw0XNmK5nknYtdkm0/jSAop/V7Ye53Y0PopEHhjUskWEVoUERUIk9VK5GLd6St0krYf
         Z5dilTt/w7zM+XBDDO3hiSrDPtIiiIbFn6iuvGmurGHaqSCNI3onqKXOk43i3wzu0ou0
         pxOP7Y261dgsUWusx1wb3HRQ+Gl7bsWbcrez7aEtkb8iX4uHF6mIDeBodhwFYoi1yJjf
         hgN3/SaKmRxS8hsncnmDPyzYCSpJvBkldbgsuPpd6FG96sJXJ8W5bs+dsyrWD/c4Z65p
         tIrA==
X-Gm-Message-State: AOJu0YxTskYfiJpaxU9Bx1UJmkOZu7csqGNsIInXwnj2FxFskh2PJ1Fo
        I9yH+esw2dXV0I8rXovuApE=
X-Google-Smtp-Source: AGHT+IFI9e21DDk43+YPYhcUOd1/CtgBttiDPMm7ASOhe3wBqKJz22o2cMS7DIUdPGR2LbK2Yj7j0A==
X-Received: by 2002:a17:90b:4c04:b0:26b:535e:fc12 with SMTP id na4-20020a17090b4c0400b0026b535efc12mr1318629pjb.7.1693356149943;
        Tue, 29 Aug 2023 17:42:29 -0700 (PDT)
Received: from [192.168.0.105] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id hi23-20020a17090b30d700b002636dfcc6f5sm167066pjb.3.2023.08.29.17.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 17:42:29 -0700 (PDT)
Message-ID: <085d4cb6-dd7c-9093-1464-9e421961cb65@gmail.com>
Date:   Wed, 30 Aug 2023 07:42:24 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: Fwd: WARNING: CPU: 13 PID: 3837105 at kernel/sched/sched.h:1561
 __cfsb_csd_unthrottle+0x149/0x160
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Hao Jia <jiahao.os@bytedance.com>, Ben Segall <bsegall@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Igor Raits <igor.raits@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>
References: <a5dd536d-041a-2ce9-f4b7-64d8d85c86dc@gmail.com>
In-Reply-To: <a5dd536d-041a-2ce9-f4b7-64d8d85c86dc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2023 07:37, Bagas Sanjaya wrote:
>> [293790.956625] CPU: 13 PID: 3837105 Comm: QueryWorker-30f Tainted: G        W   E      6.4.12-1.gdc.el9.x86_64 #1
>> [293790.957963] Hardware name: RDO OpenStack Compute/RHEL, BIOS edk2-20230301gitf80f052277c8-2.el9 03/01/2023

To Igor: Does vanilla v6.4.12 also exhibit this regression?

-- 
An old man doll... just what I always wanted! - Clara

