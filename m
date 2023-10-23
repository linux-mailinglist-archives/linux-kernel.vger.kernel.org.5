Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33C17D2DEF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjJWJTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjJWJT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:19:28 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6D498
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:19:26 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ba081173a3so483508666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698052765; x=1698657565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OCckZKiavm/5db1JMZXPnnv3QX7n6P10MPj5nZzGxrk=;
        b=Ii1qYfDvi15GMKeUaSeeUqjFYUJzTENLWErugtqxuImbDnu/OZG0JWo1dUssb0pa66
         buPQZlXlrAYfHDT1p/lnUssrcqYZCbwq7qsBCRMhIRr80ng2+S6RWMsQ04xtIHdjqRlZ
         QUaCJlgHTKfN+NpOiCfyLPPQzGikGQIwqmhxZTEFNgqOM6o4IDyHpc0LxCyPE6pEPds3
         p24+gbStQZJANzL2Ow8nvov5fXFXmT6I5zF+q/XjKEEtuI3cwGsKJHLuTSH/nDNeYWZP
         qDqsKHDnPoBo9Kn8afewLqRmw8460du0JMexzORXj8g8TNn19JQlmU3tISVsUvQSrayq
         pK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698052765; x=1698657565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCckZKiavm/5db1JMZXPnnv3QX7n6P10MPj5nZzGxrk=;
        b=ByE3wv4vbR5Jg7KfzghS0utsUpz7f3J3Onz2ZrsKveF29StYjKQQFitNLjzxWEOSlk
         ZvAxrdkLXB7WmXfs60hDYO3OD2bSLaIQvnbykMBZmaM598NmI3ZfXC+PB6Ijee0KFauQ
         /i20J23eqV8/J/h6SogsCXbnUVAU17+ktaqrSxJiS4I667OFgciqgWmpqQPmlKqCEEVH
         vRhXTmukPvxJioMRw53VMTn5veSVLmvGnyzIKTFo3y0SN4kWpQeU6K5man0vz/E9yByE
         DloxfC/6DFOh+nLP+xQTQJymGES2DGleHkvALHXK69asBCPLW6AB8RTmDwXkimdWYwhb
         TL/Q==
X-Gm-Message-State: AOJu0YxwLrfWfDi/c3GgTsmo4SJ0z6P/RFTwfGs+GwodUyp/ho5A3v2y
        beWf6sltmrDDbWvbEv98NNuDrbgOmmbnx8SPNGo=
X-Google-Smtp-Source: AGHT+IEYZ8FmgAtBUAoMw3wuvGj5PvX10JDPD6nRYIzq2tWu0Sl4uMwKk6kB0eX+9TR+4Lkx8Im9Ig==
X-Received: by 2002:a17:907:d86:b0:9be:b7da:72d6 with SMTP id go6-20020a1709070d8600b009beb7da72d6mr7079390ejc.63.1698052764885;
        Mon, 23 Oct 2023 02:19:24 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id y29-20020a170906519d00b009adc5802d08sm6411655ejk.190.2023.10.23.02.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 02:19:24 -0700 (PDT)
Date:   Mon, 23 Oct 2023 11:19:23 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] riscv: Script to autogenerate instruction handling code
Message-ID: <20231023-aa3f789ccb483afbbdd55b38@orel>
References: <ZRD8RzBeA2RMrcki@ghost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRD8RzBeA2RMrcki@ghost>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 08:19:35PM -0700, Charlie Jenkins wrote:
> I have heeded Andrew Jones' advice and written a script to generate the
> instruction handling code. It is still in development, but currently
> lives on a fork of riscv-opcodes [1]. I am interested if what I have
> produced so far is in line with what people would want to see.

Hi Charlie,

Sorry for my slow response. I'm glad to see that we're going in a
direction where we generate these functions and reuse an existing
generator to do it.

> 
> An insn.h file can be generated by running the following in the repo:
> 
> make
> python3 parse_linux.py instr_dict.yaml insn.h opcodes_config variable_field_data.yaml
> 
> I have pushed the generated files to the repo so people do not need to
> run the script.

I couldn't find the generated files, not even [3] from your references
seems to be present.

> 
> Each instruction has "variable fields" such as registers and immediates.
> For each variable field that appears in any provided instruction 3 functions
> are provided: extract a variable field from an instruction, insert a value into
> a variable field of an instruction, update a value into a variable field of an
> instruction. Update first clears the previous value of the variable field of the
> instruction. Then for each instruction, the script generates a function to check if an
> arbitrary 32-bit value matches the given instruction, and a function to
> generate the binary for the instruction given the required variable
> fields.
> 
> I was able to use riscv-opcodes to parse the instruction files, but
> needed to create a new data structure in variable_field_data.py [2] which
> holds the positioning of immediates inside of an instruction.
> 
> I envision that opcodes_config [3] would live inside of the kernel alongside
> a simple script to call riscv-opcodes (that resides somewhere in the
> user's file system) with appropriate parameters. When somebody wants to
> add a new instruction, they can add an instruction to opcodes_config,
> run the script, and commit the resulting generated file.

That sounds good to me. (They may hand craft the functions for a single
instruction too, by just using the other functions as templates, but even
if the script isn't used all the time in the future, the initial
conversion of many instructions makes it worth while, IMO.)

> 
> If this script is in a direction that people like, I will continue to
> fix up the issues in it and try to get it upstreamed to riscv-opcodes
> before I send a kernel patch.

Please send me a pointer to opcodes_config and insn.h. Also, since you're
extending riscv-opcodes with variable_field_data.py, have you found a way
to verify that all the immediate offsets are correct? Or were the offsets
extracted from the spec/tool directly somehow? I.e. was
variable_field_data.py mostly generated itself?

Thanks,
drew

> 
> - Charlie
> 
> [1] https://github.com/charlie-rivos/riscv-opcodes/tree/linux_parsing
> [2] https://github.com/charlie-rivos/riscv-opcodes/blob/linux_parsing/variable_field_data.py
> [3] https://github.com/charlie-rivos/riscv-opcodes/blob/linux_parsing/opcodes_config
