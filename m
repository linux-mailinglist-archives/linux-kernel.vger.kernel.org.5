Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D80F78DE38
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbjH3S7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244586AbjH3NYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:24:48 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B17DCD6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:24:45 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c1f8aaab9aso18188315ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1693401885; x=1694006685; darn=vger.kernel.org;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRT8HTnQl0A0AIoP4ZTxLcQAlQfUx0TWGO6B5/BcjqA=;
        b=sQ75QxiDhd4yPqNaHWEhXTXBjs+ovUmg+YDMYW0DkMceNemAPfOKaKZgy/oQxP7/ZB
         LIVVWd+1vvMpKq/hKUDTzf2dH+kXwWGrxhgP4wzbAS1f0VjCr8IENcDkFuymQxpN7BsZ
         N7IhZshv2zcl8Dd4hQNQkSbTf3g0pKjZphA/F7HBBxmG8fqvY46TqWfF4riM29cm6hEL
         Y6EhBVYnUx+2RomT3fM38C/P7lObMRyJh1Os77GTIB2V5A9wvSI1/twW9qwvVxrVbC9h
         R/O/KpKiHYoPGtdT94LB+0mmOZq4+MYc8A6+fEi8j5Ktf9gkQ/QDfhk+cFNKeebzPIkH
         kX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693401885; x=1694006685;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRT8HTnQl0A0AIoP4ZTxLcQAlQfUx0TWGO6B5/BcjqA=;
        b=hUyFqghnnLx6fVVdTYSGSeiXalKoj0E6rIj+uFKqjihdDMd3sRmjG7i4MjIRgswBQr
         dnySi6SQ2lyFDoksi1hgnquJzHnoQI9L9nNbEKdqrEUo512zGWy3AP0ZKk2ActRhIt5f
         RSGU57MYNQp19Ewll/qVn5AzSz9onNQQYGRdoXsd6k4qDF34el0xF5tbH2CWQXLjqExe
         aZJwfnkzUR6+zC0/kzUw7rQoVdV2F3hrIuuSdrzZeJ1NdC+AKz6V+mB8VFDeXWcCkoMY
         mDXY3knlBO9i1o+bWqPULvW9ALdOcJW0lyvU1DaHWnnBEpL8yfFNtNHfHonUVdIZXqyA
         Lg9g==
X-Gm-Message-State: AOJu0YwrjZqKxffQS6M2hSMs3KZWySpCstSoNhXp1K69IavBphxFwYeo
        C1sXm6eLr2ZX8+FAXhC+1LV/OQ==
X-Google-Smtp-Source: AGHT+IHIIGqJnityI0OPSbmG85fQUYCCUbZlEhqTIhCoa+VaqpTd500dDd/u6VytqECHnak/hR1Q0Q==
X-Received: by 2002:a17:902:c40b:b0:1c0:aa04:dc2f with SMTP id k11-20020a170902c40b00b001c0aa04dc2fmr2709086plk.11.1693401884752;
        Wed, 30 Aug 2023 06:24:44 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902eb4c00b001a95f632340sm11151096pli.46.2023.08.30.06.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:24:44 -0700 (PDT)
In-Reply-To: <20230711201831.2695097-1-evan@rivosinc.com>
References: <20230711201831.2695097-1-evan@rivosinc.com>
Subject: Re: [PATCH v4] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
Message-Id: <169340187980.2480.1248805004166656896.b4-ty@rivosinc.com>
Date:   Wed, 30 Aug 2023 06:24:39 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Evan Green <evan@rivosinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Jul 2023 13:18:30 -0700, Evan Green wrote:
> In /proc/cpuinfo, most of the information we show for each processor is
> specific to that hart: marchid, mvendorid, mimpid, processor, hart,
> compatible, and the mmu size. But the ISA string gets filtered through a
> lowest common denominator mask, so that if one CPU is missing an ISA
> extension, no CPUs will show it.
> 
> Now that we track the ISA extensions for each hart, let's report ISA
> extension info accurately per-hart in /proc/cpuinfo. We cannot change
> the "isa:" line, as usermode may be relying on that line to show only
> the common set of extensions supported across all harts. Add a new "hart
> isa" line instead, which reports the true set of extensions for that
> hart. This matches what is returned in riscv_hwprobe() when querying a
> given hart.
> 
> [...]

Applied, thanks!

[1/1] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
      https://git.kernel.org/palmer/c/3d44f547b677

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

