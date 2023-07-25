Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC8D760C52
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjGYHsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjGYHsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:48:32 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EDB113;
        Tue, 25 Jul 2023 00:48:29 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A2380FF80F;
        Tue, 25 Jul 2023 07:48:22 +0000 (UTC)
Message-ID: <cdb56d2f-1e52-46fd-5d89-12b34749e823@ghiti.fr>
Date:   Tue, 25 Jul 2023 09:48:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND PATCH -fixes 2/2] Documentation: kdump: Add
 va_kernel_pa_offset for RISCV64
Content-Language: en-US
To:     Song Shuai <suagrfillet@gmail.com>, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, corbet@lwn.net,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, xianting.tian@linux.alibaba.com,
        anup@brainfault.org, robh@kernel.org, ajones@ventanamicro.com,
        alexghiti@rivosinc.com, conor.dooley@microchip.com
Cc:     kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230724100917.309061-1-suagrfillet@gmail.com>
 <20230724100917.309061-2-suagrfillet@gmail.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230724100917.309061-2-suagrfillet@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/07/2023 12:09, Song Shuai wrote:
> RISC-V Linux exports "va_kernel_pa_offset" in vmcoreinfo to help
> Crash-utility translate the kernel virtual address correctly.
>
> Here adds the definition of "va_kernel_pa_offset".
>
> Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
> Link: https://lore.kernel.org/linux-riscv/20230724040649.220279-1-suagrfillet@gmail.com/
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> ---
>   Documentation/admin-guide/kdump/vmcoreinfo.rst | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> index c18d94fa6470..f8ebb63b6c5d 100644
> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> @@ -624,3 +624,9 @@ Used to get the correct ranges:
>     * VMALLOC_START ~ VMALLOC_END : vmalloc() / ioremap() space.
>     * VMEMMAP_START ~ VMEMMAP_END : vmemmap space, used for struct page array.
>     * KERNEL_LINK_ADDR : start address of Kernel link and BPF
> +
> +va_kernel_pa_offset
> +-------------------
> +
> +Indicates the offset between the kernel virtual and physical mappings.
> +Used to translate virtual to physical addresses.


You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

