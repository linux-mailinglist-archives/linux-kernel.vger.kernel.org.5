Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726F4779647
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbjHKRjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjHKRjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:39:07 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCE730DA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:39:05 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6877eb31261so1662990b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691775545; x=1692380345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z+ShFNdSFVR21QLlnvolclztaU/XrR69W28hugrsBGg=;
        b=lRRmYJGIe/7kIapJAZLe0Wi2gygQ/5cSk0bAuJHIKyAeUL+6Am2QUMqEmW3kBonPG+
         9oMdo+3aOy6NM2HmcY69SkFOAPgB24R5xDEbqQm1klQZsjwEByzFmi6DoBTUSigtEG1h
         sREFrOHPCTmkJ0d035ZGJTLc8A2nglbEeAHB1bfQi+aeELTMldn1+miRo9o6YrsUVgln
         3OAQb/HuRpMR0lTkUHsY6PQ6cvXRgLBSDOcgL6fg5P3373RjWyR9tsLeDwNps8qUJjat
         0Ni2EeS6cAQa6nn02FKmjeQrVb+/KmSF+RgWXB3jrGkAkH2UoXyDptC9lx3wPY4a2OrV
         0sew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691775545; x=1692380345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+ShFNdSFVR21QLlnvolclztaU/XrR69W28hugrsBGg=;
        b=ldde0dquXt5vexjTX+hf+JMTarlYOhGdhI+GP0zMVQ110Sa1V3hCuPI2jWYz/2KwU+
         G0MsbCR0iyabswAn2EDTFzvxJAC5vz9/rtCkal49jTyoySBKP/ZF29Swb3h/Et2054Pz
         yKMm4RjLA0jfvwM3IfO7gY1DTDgeS5Q5aFRGZSauveVoE6QTxMRUSQ63wMMW5N1VS+2z
         co/GHx9T6vZo0jFhBmd7jshV8BRkWY0CbQO9FPL9avm5RQD8KLzxk12rWjvGThh2zgSr
         uMpDvu5RmJZ5AZxat8rF2LlxeU01Ilud2U0pu4grcAzZWcUvQ+k1x8njdvMLSCzT3vxN
         QCYQ==
X-Gm-Message-State: AOJu0YwadJ8HezwAbG7DWP94acbUpMCTFrnE4ODgzCJvpwvRdgE9koyr
        APiC1HAT19jV361HsNlPbgRqnQ==
X-Google-Smtp-Source: AGHT+IGYyZOh7G4Z/0Cx1ClUmw6Rc7am59y/FzYhsjgC95YBAR1CPevol7CBsiKpsbsJ/c8HFbIgUg==
X-Received: by 2002:a05:6a20:102:b0:13b:9ff3:f52e with SMTP id 2-20020a056a20010200b0013b9ff3f52emr1984874pzr.56.1691775545137;
        Fri, 11 Aug 2023 10:39:05 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:f680:42e5:c1a1:995:5aef])
        by smtp.gmail.com with ESMTPSA id w9-20020a63af09000000b00563deb296bbsm3586241pge.22.2023.08.11.10.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 10:39:04 -0700 (PDT)
Date:   Fri, 11 Aug 2023 10:39:02 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/8] Add Sipeed Lichee Pi 4A RISC-V board support
Message-ID: <ZNZyNjjekd2SW/mn@x1>
References: <20230617161529.2092-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230617161529.2092-1-jszhang@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2023 at 12:15:21AM +0800, Jisheng Zhang wrote:
> Sipeed's Lichee Pi 4A development board uses Lichee Module 4A core
> module which is powered by T-HEAD's TH1520 SoC. Add minimal device
> tree files for the core module and the development board.
> 
> Support basic uart/gpio/dmac drivers, so supports booting to a basic
> shell.
> 
> NOTE: the thead cpu reset dt-binding and DT node are removed in v3. This
> makes secondary CPUs unable to be online. However, minimal th1520
> support is better than nothing. And the community has been working on
> and will work on the cpu reset dt-binding, for example, Conor, Guo and
> Jessica are discussing about it, I have seen valuable comments and
> inputs from them. I believe we can add back cpu reset in next
> development window.

I'm interested in starting the secondary cpus on mainline. It seems that
that "thead,reset-sample" is already implemented in upstream OpenSBI in
lib/utils/reset/fdt_reset_thead.c and the issue is getting the
dt-binding accepted. Is that correct?

It looks like you've tried to restart the discussion on the DT list [1]
so I hope that the DT maintainers will give their perspective.

Thank you,
Drew

[1] https://lore.kernel.org/all/ZNURXBKkYdiWLanf@xhacker/
