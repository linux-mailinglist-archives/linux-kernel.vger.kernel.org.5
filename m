Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C1F76FD74
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjHDJgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjHDJgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:36:20 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83A330EB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:36:18 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe15bfb1adso3322489e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 02:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1691141777; x=1691746577;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b3lbJTLxyqYJX0fxtiEjE0xWQWcO772B/HmxfLlMWGA=;
        b=VOaKqkAf6Ep3eJbBlWy9/IfPkSOcVAfnCdKa61kGrK9qIsaBTnsYi2wrOoVw5/Anz9
         o0Nl5P9GLkcGxZbnZwQtJtz6TS03bSNyduzjiAO3yHHn/fyYYjBOjNIbfJbW6gdXSshh
         TvpfE3d/oyH+XKNNV+hJ4nVutixXFaxHRfjfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691141777; x=1691746577;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b3lbJTLxyqYJX0fxtiEjE0xWQWcO772B/HmxfLlMWGA=;
        b=T3A6nhG4KwzF7dFEBDm2e9didAVmwTNX8n7aJqzP/sAtiPAj3xqGhaGQQcUBtQmY/r
         AlipaoaP4L6P5jZgpar/VFejbVON04PO0b+C67zEoFJTpWnSrpWfzqGlGjzylaLwUEK3
         nf4DHoXLApKS5qURfoeZVIJg2zEQfVp3MzbfyGws79YCPPg1J3mAh2MKlAa4FbYwyye8
         nqhG60dYiXZThtsAZgTxaWU09mf5mzFYNBh+8fYq+7BwGdsWsZppiEZhH6O1+HN1/FsV
         90w3SnFEHQfaxXaymrhNtuBr13K29n6cm9RS9z+djuVXMyBU1sTjAMG4jTrN5iJwlmYR
         E3hw==
X-Gm-Message-State: AOJu0YycQNLDw+ey9fDJbRWNltGruM+7ycARxr3zKZwdVZRW8uYtDRiR
        +q2VsV28IscY6GipsCpzXC8fFQ==
X-Google-Smtp-Source: AGHT+IFc2EnskwxlAotytkXsvAmMAiyzBKtBknSNu3wCYyYRLeDZbPirG2dtzOZRMIYX04Z5L4cAow==
X-Received: by 2002:ac2:4eca:0:b0:4fd:d9e0:4d79 with SMTP id p10-20020ac24eca000000b004fdd9e04d79mr801440lfr.6.1691141777216;
        Fri, 04 Aug 2023 02:36:17 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id i13-20020ac2522d000000b004fe461aab36sm303606lfl.129.2023.08.04.02.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 02:36:16 -0700 (PDT)
Message-ID: <33e128e8-9330-c73e-4c55-e56cbc87450a@rasmusvillemoes.dk>
Date:   Fri, 4 Aug 2023 11:36:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 3/4] lib/vsprintf: Remove implied inclusions
Content-Language: en-US, da
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230804082619.61833-1-andriy.shevchenko@linux.intel.com>
 <20230804082619.61833-4-andriy.shevchenko@linux.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20230804082619.61833-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 10.26, Andy Shevchenko wrote:
> Remove inclusions that are implied and guaranteed to be provided by others:
> 
>   compiler.h	by types.h
>   string.hi	by string_helpers.h

What? No. That's not what we want. Each .c and each .h file should
include the headers that declare the stuff they're using. So if
string_helpers.h magically stops referring to anything from string.h,
one should be allowed to stop including string.h from string_helpers.h.

Sure, those two may forever be so intertwined that it never happens, but
one really can't maintain some matrix of "X always includes Y so if you
include X you don't have to include Y" in one's head.

Rasmus

