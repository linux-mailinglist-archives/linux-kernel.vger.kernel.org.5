Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2965A76EDBF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236959AbjHCPOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236931AbjHCPNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:13:55 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A2CE75
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:13:54 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b8ad8383faso9566375ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 08:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691075634; x=1691680434;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FwOPfqP2jqQDqtzxDPpbpkmjqrOiOYyKNAFNDG2M+II=;
        b=yPARXjcdGStftqjS/oaJ5OYvo5LUnTfmx1JvFnBofb2p/O4qgVB4qczUnlhcdDM9ie
         jc3iAyKoKYLaOCxs7AxQXXLuTnhHqG2jtdQ8svhSaLSYYOzSPPcBdlWjPfL7J055mVpx
         H/IbJCrtdcdxcOwQ/XdiIhnxhcGSftrkbPJCqRsJ+1eYgj5MVLRqPrIyUIWI04KbbLeV
         jvJQGNWJrf6TbAAzmJff/hZiQL1Ld7rMBNC53J3eEwrNKe0Rvdyr/Xts2pB/5GR1hqtQ
         ZpV/1fA6+tgyO6jX3Ipg8khhn50zxjdbPdfdwU045gNTqdPMTM2MtMX8cKjBM4oCAhfj
         nqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691075634; x=1691680434;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FwOPfqP2jqQDqtzxDPpbpkmjqrOiOYyKNAFNDG2M+II=;
        b=f0GhULN0l5Zu9q76PpaFfA44dk8eJmzVc66kDynbZrrsjk5zpV0txomTL/K8uZ/wHi
         GfqfBKZIdlsMQ0O0ww/F5VEgg124phwjelAhOmxzFyh4FUFsC/InvUlFtuqtvgFs9SDc
         BLHuI9jWGutWXxYftDNfwTzVSoiWmJ5KI2WfakSJvSDb9Oqx27nRtQnWqK9Wj8W+0apH
         tmGvp/51Tvor6J+iySCMQextPjvj9O0dRrz2Vi2cxt9mjdgLRJbfJweuLRnfGg9bTGhr
         B+6gr7gwBMpQdAaV9NwtXFiitqs9QsZbvAdN+DehQ2JKA2TCwbsIxZteuxjXfVXiOBho
         ultA==
X-Gm-Message-State: ABy/qLb4TJEh7ynpxooZXuG1YeBR7KG+GlQ2N/9nXCi//XnsuJFBrjQJ
        UbatQCuH9ayLu16LxsgNQxZTBg==
X-Google-Smtp-Source: APBJJlF/emt41UduXS9wIVIwn/4gqNBAL9/6FhE5OrvzMvPUxpZj9XYWSKdyhE9O9GMBigEHv6eC3g==
X-Received: by 2002:a17:903:456:b0:1bb:77a2:edda with SMTP id iw22-20020a170903045600b001bb77a2eddamr17288120plb.36.1691075633664;
        Thu, 03 Aug 2023 08:13:53 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id y7-20020a170902b48700b001b8b1f6619asm14535688plr.75.2023.08.03.08.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 08:13:53 -0700 (PDT)
In-Reply-To: <20230724100917.309061-1-suagrfillet@gmail.com>
References: <20230724100917.309061-1-suagrfillet@gmail.com>
Subject: Re: [RESEND PATCH -fixes 1/2] riscv: Export va_kernel_pa_offset in
 vmcoreinfo
Message-Id: <169107392509.27633.2884019260902221664.b4-ty@rivosinc.com>
Date:   Thu, 03 Aug 2023 07:45:25 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        xianting.tian@linux.alibaba.com, anup@brainfault.org,
        robh@kernel.org, ajones@ventanamicro.com, alexghiti@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Song Shuai <suagrfillet@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Jul 2023 18:09:16 +0800, Song Shuai wrote:
> Since RISC-V Linux v6.4, the commit 3335068f8721 ("riscv: Use
> PUD/P4D/PGD pages for the linear mapping") changes phys_ram_base
> from the physical start of the kernel to the actual start of the DRAM.
> 
> The Crash-utility's VTOP() still uses phys_ram_base and kernel_map.virt_addr
> to translate kernel virtual address, that failed the Crash with Linux v6.4 [1].
> 
> [...]

Applied, thanks!

[1/2] riscv: Export va_kernel_pa_offset in vmcoreinfo
      https://git.kernel.org/palmer/c/fbe7d19d2b7f
[2/2] Documentation: kdump: Add va_kernel_pa_offset for RISCV64
      https://git.kernel.org/palmer/c/640c503d7dbd

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

