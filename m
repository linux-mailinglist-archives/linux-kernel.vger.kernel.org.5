Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C813753C50
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbjGNN62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjGNN61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:58:27 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B395726B5;
        Fri, 14 Jul 2023 06:58:26 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a3e1152c23so1522390b6e.2;
        Fri, 14 Jul 2023 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689343106; x=1691935106;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZfFtZs44m8Zo9MX+jI8UvKsAHjyMfdzKjYmKjQfTOeg=;
        b=SOMD47bUKBvnNMJxuo/Qqj7JmiLOY4XuCjCV7OA4NqC9jEPK/YBH9lguUT0Oj6V+Y0
         RLvhlP/QahZguVu7MiQ2n+nFhiiCGdnWJptntNF1dcLU7d9X8A1DMVpM6AXP2ACkPWf4
         /UG6tXSI3U9YII4hNk2in+CHaHdUU0RDiiCFcDsGcIwVk0tYEgNHxVgaGb9Kfpc0P0mi
         wxSHf6BeQFqLqAIZlaxFHD3dCqpXzWQ+eR9FH0R9tFo/LRDJpNRJyXdHwhkykqOzgqJN
         GYrrH0PfSIhTBxSc7OAig1DcEFl9ROCApXCSxK9z8km57x9l74Y/zBrP5oqdtZjyFc+1
         QsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689343106; x=1691935106;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfFtZs44m8Zo9MX+jI8UvKsAHjyMfdzKjYmKjQfTOeg=;
        b=O2lZ+6/1xwPxB4z+HtMwrrw34/pEu1sUN9EP5k6ECwSTByaU8qSWmTMdZh+JDWlD6d
         mP3amzlyXqG2qIvqLR1hBLDRuMqHKDPJS5DstrohS5tVlND3LlW27gY6FOYnkSCE3KIh
         DAH69/sebLI50QaqL47n13I3DjdEYFvMO4xPGqCzFIH2k8DTC4JN80aKf9OjTCecQog9
         lOZTfNxPpeeFCS2BrnLV4IyHGVrDrgy29p1f8XzLbPL+SBFOgm3kxZKNWP2+I84Rmj/j
         WsicAYpgw8AksNAYk/ncF0fWOo1ue1sy1LAXUkMzM7f/Zx7O8XUgXt2EwZYe1OxjOAai
         oMMg==
X-Gm-Message-State: ABy/qLaaLa0AUKXDDAF0iPt2soYSC03D67q7tPDbLdjavhQt+zH5YJLe
        W8R50aYf0fCLL3Hjtc+kfa0=
X-Google-Smtp-Source: APBJJlHP70TqG1swKvKXkahgek85etZ9fjwVf9HrNOpgCunvCDPnEnX1u4cZGMd0PKCFkhRHSHUn5g==
X-Received: by 2002:a05:6808:f11:b0:3a4:31da:34c5 with SMTP id m17-20020a0568080f1100b003a431da34c5mr6280192oiw.39.1689343105983;
        Fri, 14 Jul 2023 06:58:25 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id dz25-20020a056808439900b003a3600182f8sm3883960oib.57.2023.07.14.06.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 06:58:25 -0700 (PDT)
Message-ID: <213cc5ce-9d4a-eb51-7259-50dfae4665f0@gmail.com>
Date:   Fri, 14 Jul 2023 10:58:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] rust: time: New module for timekeeping functions
Content-Language: en-US
To:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Josh Stone <jistone@redhat.com>,
        Gaelan Steele <gbs@canishe.com>,
        Heghedus Razvan <heghedus.razvan@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        asahi@lists.linux.dev
References: <20230714-rust-time-v2-1-f5aed84218c4@asahilina.net>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230714-rust-time-v2-1-f5aed84218c4@asahilina.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 04:55, Asahi Lina wrote:
> This module is intended to contain functions related to kernel
> timekeeping and time.
> 
> Initially, this implements an abstraction for a time Instant (analogous
> to the Rust std::time::Instant) that represents an opaque instant in
> time. Unlike the std Instant, this is a generic type that is bound to a
> specific clock source, so that only Instants from the same clock source
> can be subtracted/compared.
> 
> Then we implement the relevant clocks available to the kernel:
> KernelTime (CLOCK_MONOTONIC), BootTime (CLOCK_BOOTTIME),
> RealTime (CLOCK_REALTIME), and TaiTime.
> 
> Co-developed-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
