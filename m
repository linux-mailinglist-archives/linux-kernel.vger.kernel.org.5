Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D407CB687
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 00:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbjJPWXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 18:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjJPWW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:22:58 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9D895
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:22:55 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1e9b6f39f9eso3358230fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697494975; x=1698099775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ep3okjgpPqs/SuawFmrOIwNlvj2vgI/0SEsxtO/LHEg=;
        b=YzO20fTPeIEIOoiadiKJ2lvh1WJVgswU8BmIqKxFRagjEhAyoNU9pNC35D3M4iCxBK
         UTPv2ni9aHboxpwAYAROgIdKE2PH53XLMa22ZLKKlXCkJcGnABAiW/2cIhPpKOl6iEoq
         ORQ98t9aWSbkGzRFfIKFGKWZW++az+Ft7ctjUl5IW2ASoe3QSVBbG2sUO9S1X/L16ejZ
         oWubZxwZDwdU/xmVCb7FR20FaujLvfF7hNQyUb/lhJ3voyMpZ0Qk3tB0Q/9w7qExYDV7
         QHW8jm4Fb+ls/3kFONPwFOZPswMfa4jTvlkVjU2bkDTiD/9PEfKugkGjObaOKTOwLATe
         7bEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697494975; x=1698099775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ep3okjgpPqs/SuawFmrOIwNlvj2vgI/0SEsxtO/LHEg=;
        b=hx66lpGV5LX3vwRixQ8DZw1EjklweCiQQXqwmnEqXVJW1sCuKDau+693LLfHe1Jxws
         XGSUJrT83oQiOyfZxIkC46avnfLevJaaGlRDfYdwwNh6xUYxxnIxYezy10EyLsQDZIdG
         1wSI2vtW8WZ0KIbyEg9v1FP6MpaCN4I8vDZZQm70U03S16y0ZVLfI6lSxQfBNcCRQ6yr
         x7AzUhqf1lZYxkzspPIimuoHbqRuoAQv1ouNlMHYZKwi1HLUisYus4X+fjDHE7pKOEWs
         z9PQ4yYh/sVGSyBRonlmt9ybKSyqZPvcebMoSfgSwQZEHuNsJW18ptewbkz9C24UDyU7
         7fog==
X-Gm-Message-State: AOJu0YzZkOMd+A83RKcQUZKHshy7mCWu8NbZT5YvwuSrPRAFxH8ovq69
        BkpuSf2fCLguYXBysWKKgiPVeQ==
X-Google-Smtp-Source: AGHT+IHiEWD6MRJd+TaZ6w0hpRhBtF+BvSza1fmbGFOxARxyVi2XYgFgQfHLOFHJi74OH4nTUE5Qgg==
X-Received: by 2002:a05:6870:1157:b0:1ea:aa9:9b00 with SMTP id 23-20020a056870115700b001ea0aa99b00mr413599oag.57.1697494975207;
        Mon, 16 Oct 2023 15:22:55 -0700 (PDT)
Received: from ghost ([208.116.208.98])
        by smtp.gmail.com with ESMTPSA id j25-20020a056870169900b001cd1a628c40sm17676oae.52.2023.10.16.15.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 15:22:54 -0700 (PDT)
Date:   Mon, 16 Oct 2023 15:22:51 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v3 1/2] riscv: Add remaining module relocations
Message-ID: <ZS23u+NvzU6RmFbj@ghost>
References: <20231016-module_relocations-v3-0-a667fd6071e9@rivosinc.com>
 <20231016-module_relocations-v3-1-a667fd6071e9@rivosinc.com>
 <87h6mqo2r3.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6mqo2r3.fsf@igel.home>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 08:12:32PM +0200, Andreas Schwab wrote:
> On Okt 16 2023, Charlie Jenkins wrote:
> 
> > @@ -81,7 +82,7 @@ typedef union __riscv_fp_state elf_fpregset_t;
> >  #define R_RISCV_ALIGN		43
> >  #define R_RISCV_RVC_BRANCH	44
> >  #define R_RISCV_RVC_JUMP	45
> > -#define R_RISCV_LUI		46
> > +#define R_RISCV_RVC_LUI		46
> 
> The latest ELF psABI defines 46 as reserved.
I will remove that in the next version. Thank you.

- Charlie
> 
> -- 
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."
