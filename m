Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DEF7CF779
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345409AbjJSLv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbjJSLvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:51:52 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0916C12D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:51:50 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c503da4fd6so92486491fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1697716308; x=1698321108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cYhetTUR+CNLH/HwN/8EfxVVrFaHA/qKC1NtVgTQ8Zs=;
        b=W/BCTtfdiiZ1KmMeLlH/aloQIe1e2TyG53XjugP4g1daw0xyHu2DUWCtptGLJ3yWEZ
         5uLUh5J3XTUv6NET9TAd//PP8qO+cM2eRr9DtrJm8h0sDhs7W2MavlSKEVOKt38hPgN5
         vQJn23xXFxN77NHSacJk3r01UZTdlSeObYXMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697716308; x=1698321108;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cYhetTUR+CNLH/HwN/8EfxVVrFaHA/qKC1NtVgTQ8Zs=;
        b=ftsDeoNV89MsvRufghPv1nqhkjP8epuBGsq702MWw6XEo0D+WaCbxXdxsHl+lXAlg8
         AcCIe+vZBF83KGL4Vt8wg0V8WrBsh4Nq27KkQotXcZKdR0pwvNOl5fnGyE01ins3cCyu
         XOsZs08qKCeQdO93Uhp705VtWrxSmvKOsV50HkVuSTdbFA8PrpAmicEQZdHnzBlMZ2FE
         1H+HSgDoUOaJK1IhZyFNAZktStJ5lCnMzgd8Ttz6TcDa5HEJ7k310k+M4SaPOZFH/Qym
         bh1VeAEiQDcVzfJAr9f+TPlPtyU/S4nYCXuHdeXu36JFIKrEdHbB3DGc0252LswmFm+s
         g1ZQ==
X-Gm-Message-State: AOJu0YwoLq+9lPy9qtjyp9SJESNi4Ilx+hMse46qE2viWXJpvObt241C
        Gcu5PaYanDIOwJFAf4zl8JhPaQ==
X-Google-Smtp-Source: AGHT+IFA7wGGmky01iqg+b8Uulv2cF9D6zxWN1ZWrcRCVZCW56DGx+23K95paengmhSA2mNRwuVKFA==
X-Received: by 2002:a2e:a4ca:0:b0:2bf:f7ea:884a with SMTP id p10-20020a2ea4ca000000b002bff7ea884amr1363550ljm.30.1697716308013;
        Thu, 19 Oct 2023 04:51:48 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id z4-20020a2eb524000000b002bcb89e92dcsm1104757ljm.6.2023.10.19.04.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 04:51:47 -0700 (PDT)
Message-ID: <f89a00c8-2ea2-4ef1-909e-2eaf7bc17cf9@rasmusvillemoes.dk>
Date:   Thu, 19 Oct 2023 13:51:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/vsprintf: Remove redundant code
Content-Language: en-US, da
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, pmladek@suse.com
Cc:     rostedt@goodmis.org, andriy.shevchenko@linux.intel.com,
        senozhatsky@chromium.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20231018064817.86721-1-jiapeng.chong@linux.alibaba.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20231018064817.86721-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2023 08.48, Jiapeng Chong wrote:
> When variable needcolon is assigned a value of false, it must be
> assigned a value of true later on, which is redundant code.

NAK on any patch modifying these things without first filling the blank
space in ip6() in lib/test_printf.c with tests for all the various ip6
printing modes.

Adding test cases there is much more useful than code-golfing, and would
help verify that these changes are actually ok. Or may reveal that the
current code is buggy.

Rasmus

