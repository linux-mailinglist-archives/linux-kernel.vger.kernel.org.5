Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C034E76CCFF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbjHBMjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbjHBMim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:38:42 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF1530C4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:38:30 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bb9e6c2a90so53809325ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 05:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690979909; x=1691584709;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BCaJfRDcQ/j8NvxBseF28uGTZsyouYPenyGPtBvs7Ag=;
        b=OQVD00X+fFdoFOV6AIVr9E8zFxSx5ZSdlWn1z9cEHpSHI7fNoaOxt+4YE4hIq/sS0H
         Tc5t+QY/Af0FPcb0UbOUTKbN/wjHt3x+M1L1EhJbNwv2Yeft9fGLKiBOmOdaJlFBaMCB
         SA+05FZQ3LxRO8tWClstvW84jkw6GQQYE85CC2iYP4dk1nwSuSKe+ktwGc1OoOxNufBt
         rHzA+llAGUZSu6H62F4OtIV8VCF0Qoh62wsylG1k4K0GiuIkbpbwqUISRAEgYjMvqv3H
         xunEdkFirMg+HlQItswVt+0Ps8H3/2T6EIGW7GF0juUEzQ+jtxGI0Lvs97p+PayymOr1
         XKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690979909; x=1691584709;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BCaJfRDcQ/j8NvxBseF28uGTZsyouYPenyGPtBvs7Ag=;
        b=LAw32X5V2x7NUsTW+PUyEGbBojcDX9K69XB1ChrRsQO6WdbxBIR/DTC12z0hWGplV3
         ie1vLGnDPb2rMRSHzZVHOOzNDpF2jfOZYkoVf2j4Q6EuMgGXZ0zsP0WuxDgjBgP7ApNt
         Hdu6knt+SES4EnNXkTSlQmzJvb+yttv5gprVQwDJipdAoLKbX5RYrKKWm83w6vRHgji3
         m11MddrvFMr84DRBr3nS/3IwY/6M/sjZaMPHmsvCfykPow4EkVzCwtvj094skT3cNu5G
         Bt8gXhJHNdI4MdOVg0DZg/3FU88sTvtR9qvZKOpGmfTLly2jR9mFGhvm+io/vx/u2WnN
         j9Ng==
X-Gm-Message-State: ABy/qLa5di5UPhP7dAca6V7lP00SB39n3ZXqSpUL0E0HTN3gExQcqg5f
        EIBqO1BdJZxQ8brox5IvaVnmOUakJU0=
X-Google-Smtp-Source: APBJJlHnD8LH6jLPiA1ybE8b0xGJc/HDo+xItbPoicPJ8NQ6sOjqNAamf9Z3J9pUfqgq/hovKFa2Sw==
X-Received: by 2002:a17:903:2343:b0:1bb:a85c:23cc with SMTP id c3-20020a170903234300b001bba85c23ccmr20078880plh.15.1690979909291;
        Wed, 02 Aug 2023 05:38:29 -0700 (PDT)
Received: from [192.168.0.105] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id m24-20020a170902bb9800b001b87bedcc6fsm12310621pls.93.2023.08.02.05.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 05:38:28 -0700 (PDT)
Message-ID: <80e4fe8d-96d0-2eba-918b-7c36f8341568@gmail.com>
Date:   Wed, 2 Aug 2023 19:38:23 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Fwd: Kernel memory management bug at mm/migrate.c:662 when
 flushing caches
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Alistair Popple <apopple@nvidia.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco <rodomar705@protonmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Regressions <regressions@lists.linux.dev>
References: <428d8fe9-8c19-ddba-b36e-7db5524e8d04@gmail.com>
In-Reply-To: <428d8fe9-8c19-ddba-b36e-7db5524e8d04@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 02/08/2023 18:08, Bagas Sanjaya wrote:
> #regzbot introduced: v6.2..v6.3 https://bugzilla.kernel.org/show_bug.cgi?id=217747
> #regzbot title: kernel memory bug when cleaning hugepages before QEMU boot
> 

The reporter confirmed that this regression is (Open)ZFS-specific,
so:

#regzbot invalid: out-of-tree (OpenZFS) regression

Sorry for inconvenience.

-- 
An old man doll... just what I always wanted! - Clara

