Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F7880D0A8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343886AbjLKQMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343941AbjLKQMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:12:23 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB6CC8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:12:29 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77f320ca2d5so341629585a.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702311148; x=1702915948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZpS7YigJlvbtafE8s+IgfD2mhqkpNW2HnzWlJXZ6u0Q=;
        b=hb/jTd2sTBZTQK/zyjqlOJFdtpYmHq/6oAMyodOsF4zZZJ3IzPBpoxcyLYPMRCFipR
         rOe7gD4ExrSm9Pgw9j5pu8j5nBJy3iUFYDy7KQ6Imaen+MSbBQwSr3AA12Y5Uw+FLAYZ
         SCIZYnBXSfAJBVYk12WiKHA5G8rmX1ADvwR7pF1+4a7gNzBPrvqABFHGsuEI467Dtg5Z
         WbU65UzYfqpDHEf+/wgGrEpPsppOOzIUdRwwUxIrHnMw055xTLQnDJccBeLHcpiC2CVT
         avwaEOJMn86choOT2nYDdqxgGk50bNAoFrURH9KXZ2UNvPUB9eQhBY4O+TtZtomXuh5c
         9JIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702311148; x=1702915948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpS7YigJlvbtafE8s+IgfD2mhqkpNW2HnzWlJXZ6u0Q=;
        b=pWHdKASF9Iqo8N/PSm1hVPXchNH/p9g4JK6862yxIe4+eQFG3JsCwQulfh/vLjthIF
         1PZTYKCsUBdwM0UyPm59Z7G72owxFUl1NR/94eXDlMU6lEQaKBdWiLvg8tU/wys8oqi5
         JdvB4mzbErHLMoDPZOySn+aGXeKnlYIUyDurTzNlT6TduNUKKTll2smsl5Kmvjb9F6Hx
         YRmKdwiCEr5ArOr4CCIKlR4gsa7U5lWYPCkV7lWopXdNZ6i8FysyDH9D9D0eIgr6uwbr
         HrCjPikrkPvZZORYLn+l3pSYCGKLHPl0IlroJacUHCNHJtEZNOxbLXHNHx4HvbDsrZhp
         CZ8Q==
X-Gm-Message-State: AOJu0YwQCfYKiEZTxZxMKkIqOwvHi+1ctkKN3sPvbXJPlvrK+WKxSZgi
        OoOMrugpMAeD3yYXwlJO4HAUng==
X-Google-Smtp-Source: AGHT+IEC8jdvAnetFbqJVF6lQQw8UXKnB/IQiMsN2t2NyqglmpS9Xy9aZsTAJAYPyNV0NsZe4DU6SA==
X-Received: by 2002:a05:620a:15a8:b0:77d:855d:1b09 with SMTP id f8-20020a05620a15a800b0077d855d1b09mr6457241qkk.0.1702311148452;
        Mon, 11 Dec 2023 08:12:28 -0800 (PST)
Received: from ?IPV6:2600:1700:2000:b002:f8a3:26ec:ac85:392e? ([2600:1700:2000:b002:f8a3:26ec:ac85:392e])
        by smtp.gmail.com with ESMTPSA id a15-20020a05620a066f00b0077d78afc513sm3014865qkh.110.2023.12.11.08.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 08:12:28 -0800 (PST)
Message-ID: <7c40dfe8-f245-413f-a424-bde52ce21b6a@sifive.com>
Date:   Mon, 11 Dec 2023 10:12:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/12] lib/raid6: Use CC_FLAGS_FPU for NEON CFLAGS
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, linux-arch@vger.kernel.org
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-6-samuel.holland@sifive.com>
 <ZXczty+Y6dTDL4Xi@infradead.org>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <ZXczty+Y6dTDL4Xi@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_XBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-11 10:07 AM, Christoph Hellwig wrote:
>> +CFLAGS_REMOVE_neon1.o += $(CC_FLAGS_NO_FPU)
>> +CFLAGS_REMOVE_neon2.o += $(CC_FLAGS_NO_FPU)
>> +CFLAGS_REMOVE_neon4.o += $(CC_FLAGS_NO_FPU)
>> +CFLAGS_REMOVE_neon8.o += $(CC_FLAGS_NO_FPU)
> 
> Btw, do we even really need the extra variables for compiler flags
> to remove?  Don't gcc/clang options work so that if you add a
> no-prefixed version of the option later it transparently gets removed?

Unfortunately, not all of the relevant options can be no-prefixed:

$ cat float.c 
int main(void) { volatile float f = 123.456; return f / 10; }
$ aarch64-linux-musl-gcc float.c 
$ aarch64-linux-musl-gcc -mgeneral-regs-only float.c 
float.c: In function 'main':
float.c:1:33: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
    1 | int main(void) { volatile float f = 123.456; return f / 10; }
      |                                 ^
float.c:1:55: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
    1 | int main(void) { volatile float f = 123.456; return f / 10; }
      |                                                     ~~^~~~
float.c:1:55: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
float.c:1:55: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
float.c:1:55: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
float.c:1:55: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
float.c:1:55: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
float.c:1:55: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
float.c:1:55: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
float.c:1:55: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
$ aarch64-linux-musl-gcc -mgeneral-regs-only -mno-general-regs-only float.c 
aarch64-linux-musl-gcc: error: unrecognized command-line option '-mno-general-regs-only'; did you mean '-mgeneral-regs-only'?
$ 

