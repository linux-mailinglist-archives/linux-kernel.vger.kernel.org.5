Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F1778836C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244169AbjHYJU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244274AbjHYJUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:20:08 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322A21FEC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 02:20:06 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9a1de3417acso371790266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 02:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692955204; x=1693560004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P5y25gob/FRn47TB3uE916gwNPLot6UByiaDLp9rLcQ=;
        b=sCPqbDGzRWbxJlSfUmv3fORoh/7RehiDu5aHsAmt5eM4nxtrXZLo3T+X6xtJuxVcZ3
         Cjz4SQ0rAkmQZEF0OQ99/E9+nCsPhj05xB/q+/rljAu3MrgR4rjWQ0hj5quAJiDeliNq
         Hbj5ji4oyCaicMXW1tbSs6Co3f5AhQTJB4u7EQgIfC03Jo52pGoMQgPvFIrADxpc4faS
         SQjQHXLlbO2yaUpErq+BMeJS3b4/Iq9pzuj3VeiYE7tQgRp5ou4yuSYEFU4DiNDmgXW5
         JWcjPiZDrXaKOQ8oJ9OztoCcfqtkXH0lJ3jBKSWhvlFRScvW/kWb3ohzSEF+7zXuIrWl
         Ruvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692955204; x=1693560004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5y25gob/FRn47TB3uE916gwNPLot6UByiaDLp9rLcQ=;
        b=IbAkSDtIhxPBNqxKGEBdlIb3pxrxKfgqTImHc/Fl3lJ4K8OZsStoeJ/9UiNeoNmKxE
         l6/FY7Ter5iduL/SD9cwDlGRAh3SwuaVFTDnWXK0roYDd0F6EBunYxBq41SdBxa99eT7
         UaDTvB5dknfIF3qtCvE3aPD8GEivfwIkMcT1TXtDg8xDOwcz/7vXrjouGLA40mrg6bWn
         uIJSUTdLONlz2zCzmyt4RGShpBl2ThZE5plIOTImP1Uv7meOAhdZJR+DRR93dYK0Sg/N
         cbM1KyzIMemyaVsuNlLcgy2nh/1GdPrQIGSPPQ1wpHY/XgA1XvVzaQWfpSnbTqBR3FNK
         cfjQ==
X-Gm-Message-State: AOJu0Yw9jjarvvL8SJzP4zvAzdVOxw1X/ylVIuawykLQ9s5souZV4pw1
        drrfMuYxwwqrLZv7FM09x4U=
X-Google-Smtp-Source: AGHT+IGgqCExH4c2OmdFUbkVCl8SzQf5ww4zLepWnKHaxY7Oi5And6+MZYmy7HtHPgtOUCoHORfNMg==
X-Received: by 2002:a17:907:a410:b0:99b:af5a:fc2c with SMTP id sg16-20020a170907a41000b0099baf5afc2cmr19916786ejc.26.1692955204466;
        Fri, 25 Aug 2023 02:20:04 -0700 (PDT)
Received: from gmail.com (195-38-113-90.pool.digikabel.hu. [195.38.113.90])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906840d00b00992665694f7sm740898ejx.107.2023.08.25.02.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 02:20:03 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 25 Aug 2023 11:20:01 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 12/23] x86/alternatives: Remove faulty optimization
Message-ID: <ZOhyQQvy2lsIa3AA@gmail.com>
References: <cover.1692919072.git.jpoimboe@kernel.org>
 <ca76a2e94217d6fc8e007d2ca79fee219f3168f8.1692919072.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca76a2e94217d6fc8e007d2ca79fee219f3168f8.1692919072.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> The following commit
> 
>   095b8303f383 ("x86/alternative: Make custom return thunk

End of line got chopped here, I extended it to:

    095b8303f383 ("x86/alternative: Make custom return thunk unconditional")

Thanks,

	Ingo
