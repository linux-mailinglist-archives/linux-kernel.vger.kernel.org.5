Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37777DD6EA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 21:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjJaUGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 16:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjJaUGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 16:06:47 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9B4F3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 13:06:44 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5ab53b230f1so4287906a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 13:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698782804; x=1699387604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lWGVGD/v1823PvN5lw+9ZoRQkBLtbriYZcZfAadSLGo=;
        b=hXSjsi71/xDpp4b/nYugTqJZXPdGPVf8dFoYBFSPs4AbMcJGhr3IQkMCKUUDrhV7Y5
         db2m6goRyhoW4Oenau4nm5EevkD1sDrWagQ+ssv0TEs8877bc74jTAeWl7Un0Gxwba9e
         cX7RGUtgSxm1DAd+pe20uvV9A/DHUNuhTDRbHZBns+tKh2rwgdV5tJ1qqETEnjYznM3e
         4jgNhYAy9fbXPZ/uJdc0E7hMCeqoakxX8+cLcbbhvb88EV8bpI5v1WyvIhI/g2mGmOuS
         5Z8+sa87oTuI7DUs89teKWFeWUHidD+XjtyxT1SQtEzNVNVi3EdZ/GxhkMh+axlC3fOB
         XUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698782804; x=1699387604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWGVGD/v1823PvN5lw+9ZoRQkBLtbriYZcZfAadSLGo=;
        b=p2cVaJxFNx6h4XGGFu+mU9EM9umgQlAsCJLFn5xo7k9D4lCyGlUAj1ACu2+1QefHHy
         I31zKOB6j6zPGwpO4FXeqRMS6JUTLohu6BMZyg5zSv2gSPRNhLxSgDpCJJkKOl8ijzJN
         wlwLCzDfuGA/8peGPTq0pFP31w9I7JhoUX/3+FmwiaIl6VdUfQMgRnxa4DOztQln/Hna
         PKQ7ttEp+Gtw4iC+Zxn3keD9l6DnvCcWHUXKArNPJ1Rfd7NtCPx29dt349oM2ljxABdD
         23Eb3rZEoKn41iZhuSCYhsYSJnUtH0iFtlnB2LC7XjXbRpWqlqRgnfdLz8q7lVFqZhzs
         cfEw==
X-Gm-Message-State: AOJu0Ywm0yyjHWiCGxNgOMZEcH0SIajBxRXeQyHd1kc2mYFff9H3BCEy
        UKPiaxN9ZA4PLYRJDBfXTsfSDQ==
X-Google-Smtp-Source: AGHT+IFB177CiEPUJCGzRzwkcnZ+y4NsBpO9de+GvXzBwzuPMcsZqkPWsTreDvgjfnlKEr9qBU4eyg==
X-Received: by 2002:a05:6a20:3d82:b0:17b:689e:c751 with SMTP id s2-20020a056a203d8200b0017b689ec751mr12075501pzi.5.1698782804089;
        Tue, 31 Oct 2023 13:06:44 -0700 (PDT)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id t15-20020aa7938f000000b006c2d53e3fb3sm30549pfe.78.2023.10.31.13.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 13:06:43 -0700 (PDT)
Date:   Tue, 31 Oct 2023 13:06:39 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel.holland@sifive.com>,
        Nelson Chu <nelson@rivosinc.com>,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: Re: [PATCH v7 1/3] riscv: Avoid unaligned access when relocating
 modules
Message-ID: <ZUFeTzStw1qaM0m+@ghost>
References: <20231031-module_relocations-v7-0-6f4719b64bf7@rivosinc.com>
 <20231031-module_relocations-v7-1-6f4719b64bf7@rivosinc.com>
 <CAJM55Z-v0EwrZp876DdLSzad2u55nJV_uBs_+MUJDqFW5MTPkA@mail.gmail.com>
 <878r7iiwb6.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878r7iiwb6.fsf@igel.home>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 05:35:57PM +0100, Andreas Schwab wrote:
> On Okt 31 2023, Emil Renner Berthing wrote:
> 
> >> +static int riscv_insn_rmw(void *location, u32 keep, u32 set)
> >> +{
> >> +	u16 *parcel = location;
> >> +	u32 insn = (u32)le16_to_cpu(parcel[0]) | (u32)le16_to_cpu(parcel[1]) << 16;
> >> +
> >> +	insn &= keep;
> >> +	insn |= set;
> >> +
> >> +	parcel[0] = cpu_to_le32(insn);
> >
> > Why cpu_to_le32(insn)? Unless I've misunderstood something downcasting unsigned
> > to unsigned values in C (eg. from u32 to u16) is defined to always discard the
> > most signifcant bits, so cpu_to_le16(insn) should be fine.
> 
> cpu_to_le32(insn) can't be right here anyway, since it also swaps the
> two u16 halves and would be the same as cpu_to_le16(insn >> 16) on big
> endian.

Yes, not sure why I did that... I will fix that up.

- Charlie

> 
> -- 
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."
