Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A5376EDBE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236954AbjHCPOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236914AbjHCPNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:13:53 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B301713
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:13:53 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bc34b32785so7642215ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 08:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691075632; x=1691680432;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QfdqFLI+Yigoh2tSKncXu/Nn57pn/kwUE3F2H3L+0lQ=;
        b=QfkUzDL0Vm8IZGyEdI0nOBHryanS4OZSKoIOCn1T5u13n3Qmzaim+gXxII9Uwe0n06
         /HqawbymsuS3f7q0VxzzkfA2Tzr8elr1eYqpOZ2z7DSTbgy5GuXfOVc45PefSWEirM3G
         N+nD84idw0RlhCoFONSeOP2fg6acY3mdxXoGpiyJ9w+gxa4r07YMKh+YHoUVsqwcT2LY
         hdctxcswM47jlFLU/V3o6zGzAQnkXBxw6OMzpoXQBv9y42ePJIStVOHTVxE+WYKYEbZX
         vQRVtRt6bxYX1haxGp1ANow9thYAR9SlyDV6XYNO/1CHs6PbBoA6TdiQwOjg2VgLWGjm
         2fxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691075632; x=1691680432;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfdqFLI+Yigoh2tSKncXu/Nn57pn/kwUE3F2H3L+0lQ=;
        b=DnpK390AWErj4mxt6BPPRwNL6q6MmgvzReOiSl9WhrufmtbxmqfRQbGj7qFztkNkGx
         Ctq4Qyg3njTbzwUPUfQ4C+qRadpkk6mXIk1Q570bOU92EStf7pJTBY5MdUlS8jAZoj+s
         yFJNE74OwKYv6dru/qQBrFvuTwTUU4zPgBeKHitzj4h1/i1I17CGPuqk1a9zq3Mfs523
         6E5QNskSy/cgQGXD4pqOpP5Zo+161mnK5ANs/mjHQpTWXF/yyL/lghM5UgdznDLWQ5ca
         pJsbtnsniT+C2MxY27Sh1pbnu2godYt+aajjVVdAipB3/iiM6DD4HQVQfELacoCeQJSF
         Ok5A==
X-Gm-Message-State: ABy/qLZrYMIv3ZpWlQKvjaQv2OP/Y+FSiXHpRImbaovIYGzo8ge0pxo1
        t4WeITOKk3r0+5jlaJuOGj0z4w==
X-Google-Smtp-Source: APBJJlGhjEEgT3hr12KvBN8qcCVSd9AdvEfi+asOYi2IMMVbUfmY4NJ7WLSAG8b8QfUJ7FD0xk11Gg==
X-Received: by 2002:a17:903:44e:b0:1b9:d362:426f with SMTP id iw14-20020a170903044e00b001b9d362426fmr13881743plb.3.1691075632530;
        Thu, 03 Aug 2023 08:13:52 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id e14-20020a17090301ce00b001a98f844e60sm14492382plh.263.2023.08.03.08.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 08:13:52 -0700 (PDT)
In-Reply-To: <20230724100346.1302937-1-sunilvl@ventanamicro.com>
References: <20230724100346.1302937-1-sunilvl@ventanamicro.com>
Subject: Re: [PATCH v3 -fixes] RISC-V: ACPI: Fix acpi_os_ioremap to return
 iomem address
Message-Id: <169107392505.27633.6574092293821407107.b4-ty@rivosinc.com>
Date:   Thu, 03 Aug 2023 07:45:25 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        kernel test robot <lkp@intel.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sunil V L <sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Jul 2023 15:33:46 +0530, Sunil V L wrote:
> acpi_os_ioremap() currently is a wrapper to memremap() on
> RISC-V. But the callers of acpi_os_ioremap() expect it to
> return __iomem address and hence sparse tool reports a new
> warning. Fix this issue by type casting to  __iomem type.
> 
> 

Applied, thanks!

[1/1] RISC-V: ACPI: Fix acpi_os_ioremap to return iomem address
      https://git.kernel.org/palmer/c/568701fee366

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

