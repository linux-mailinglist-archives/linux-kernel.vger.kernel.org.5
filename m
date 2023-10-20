Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0177F7D0D12
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376802AbjJTK1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376715AbjJTK1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:27:22 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF22B8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:27:19 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9b6559cbd74so97644466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697797638; x=1698402438; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O9G9iqXSn4bIWBu+1DJE9aW2IMSJDKBdGcQ03iTHUdg=;
        b=ggQl4cAl0qvH/xy2iY8hIKw3ouJfQu21CkAlQvrbyc8o6uo3qRhs+K7JxvuXKtNbhM
         KOeJNisJ6OfAtU0R3/xyMGD6FhEnadXm3azqEICgU1Yelco7fa8oiaB+8VksVUNGNpx9
         okHC2pwsf6+3gWjvuv6C73lVeBcd8073DhvvRueeNiHswgZWvRnUBKiMpznrul5YCAsL
         p3hAPgSSTyv0W6EWkD+XuZ0pKK4HUuh8HvHfsK0kPPL7Uxm+jPEogH8n+3XSXxKo5AJT
         bSHjJfN2FEVKi4mOz6s9/rQfgffbn60lZ7bI79ylUVVHXykwk4l/i/F7SGUrd08r+67m
         p5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697797638; x=1698402438;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O9G9iqXSn4bIWBu+1DJE9aW2IMSJDKBdGcQ03iTHUdg=;
        b=GMVKV8TGlucsqrt7oM7eOzxImgLlYGIRKKkDBlGKFDVzh05cTKck5pZ0oWZwqXmDGY
         ta7+zQJ/WGXrvdxYJ0Rns4P3Ox9WOa3u3fM5lgDb+EtjL0eGi6fHy2Z7BjQvyV4cUyIH
         Iol1q18T5la/p1lBc168auCLZK4KXur87fOW9Rg760/BtRuThyaFwhv2RINCPtwkCDDi
         HENvMp5Y2AdmJ3WNveE13jtFOYySdibZJ1wsLxiy+QEmZc/NxtLkG4PDfFHSsUQK0RBC
         /W6ZFc+tcikiReYIBPpWhGL5E+uISkcM32j7T5SLgg/VcfdWq/fItySOi88L4p6/Ho1M
         Amow==
X-Gm-Message-State: AOJu0YxXU+yOxivpR4+80x0FLqmC9X3vOOR9i/27X++6vswkl4YKweh7
        Ve64Y2aDfcycc2WQFfgszwS0oQ==
X-Google-Smtp-Source: AGHT+IHZl6pUqwMf9CFUA2xEvYwgpCp82Av0Lk//UAONUT1SVS4Axb4Qd2P3hrYxgtOT7flTfwUbaA==
X-Received: by 2002:a17:907:3f85:b0:9be:6ff7:128a with SMTP id hr5-20020a1709073f8500b009be6ff7128amr1087855ejc.67.1697797637704;
        Fri, 20 Oct 2023 03:27:17 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a19-20020a1709065f9300b0099e12a49c8fsm1215456eju.173.2023.10.20.03.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:27:17 -0700 (PDT)
Date:   Fri, 20 Oct 2023 12:27:16 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
        Evan Green <evan@rivosinc.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Samuel Ortiz <sameo@rivosinc.com>
Subject: Re: [PATCH v2 01/19] riscv: hwprobe: factorize hwprobe ISA extension
 reporting
Message-ID: <20231020-cee6ba8c9b3dc3c2a984fbb5@orel>
References: <20231017131456.2053396-1-cleger@rivosinc.com>
 <20231017131456.2053396-2-cleger@rivosinc.com>
 <CALs-HssL=wNwj9nRuZwpZhy1CB9p9-X=OqgwBw9zvgA7hA4fEg@mail.gmail.com>
 <20231018-scrap-bankable-a0f321d97a46@spud>
 <20231018-flagpole-footpad-07a6228485f3@spud>
 <844f6f35-3125-4014-852c-9ad7aee19ddc@rivosinc.com>
 <20231019-flatten-showbiz-127b2e917a7a@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231019-flatten-showbiz-127b2e917a7a@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 11:22:26AM +0100, Conor Dooley wrote:
> On Thu, Oct 19, 2023 at 09:26:31AM +0200, Clément Léger wrote:
...
> > BTW, wouldn't
> > it make more sense to get rid out of the unsupported extensions directly
> > at ISA string parsing ? ie, if kernel is compiled without V support,
> > then do not set the bits corresponding to these in the riscv_isa_ext[]
> > array ? But the initial intent was probably to be able to report the
> > full string through cpuinfo.
> 
> Yeah, hysterical raisins I guess, it's always been that way. I don't
> think anyone originally thought about such configurations and that is
> how the cpuinfo stuff behaves. I strongly dislike the
> riscv_isa_extension_available() interface, but one of Drew's patches
> does at least improve things a bit. Kinda waiting for some of the
> patches in flight to settle down before deciding if I want to refactor
> stuff to be less of a potential for shooting oneself in the foot.

And I recall promising to try and do something with it too, but that
promise got buried under other promises... It's still on the TODO, at
least!

drew
