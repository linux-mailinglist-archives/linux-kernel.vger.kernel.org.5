Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A08760DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjGYJAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjGYI76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:59:58 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A8DE121;
        Tue, 25 Jul 2023 01:59:53 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qODtR-0008Gp-00; Tue, 25 Jul 2023 10:59:45 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 78FCEC01D0; Tue, 25 Jul 2023 10:45:49 +0200 (CEST)
Date:   Tue, 25 Jul 2023 10:45:49 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     xuanzhenggang001@208suo.com
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: prefer 'unsigned int' to bare use of 'unsigned'
Message-ID: <ZL+LvWjuWWJPXTIG@alpha.franken.de>
References: <20230709141701.16324-1-denghuilong@cdjrlc.com>
 <e30eb541f2fc615b264a70af2f40a5f9@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e30eb541f2fc615b264a70af2f40a5f9@208suo.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2023 at 10:19:50PM +0800, xuanzhenggang001@208suo.com wrote:
> Fix the following warnings reported by checkpatch:
> 
> arch/mips/kernel/linux32.c:128: WARNING: Prefer 'unsigned int' to bare use
> of 'unsigned'
> arch/mips/kernel/linux32.c:129: WARNING: Prefer 'unsigned int' to bare use
> of 'unsigned'
> arch/mips/kernel/linux32.c:129: WARNING: Prefer 'unsigned int' to bare use
> of 'unsigned'
> arch/mips/kernel/linux32.c:129: WARNING: Prefer 'unsigned int' to bare use
> of 'unsigned'
> 
> Signed-off-by: Zhenggang Xuan <xuanzhenggang001@208suo.com>
> ---
>  arch/mips/kernel/linux32.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
> index 6b61be486303..4bd52b38dd00 100644
> --- a/arch/mips/kernel/linux32.c
> +++ b/arch/mips/kernel/linux32.c
> @@ -125,8 +125,8 @@ asmlinkage long sys32_fadvise64_64(int fd, int __pad,
>              flags);
>  }
> 
> -asmlinkage long sys32_fallocate(int fd, int mode, unsigned offset_a2,
> -    unsigned offset_a3, unsigned len_a4, unsigned len_a5)
> +asmlinkage long sys32_fallocate(int fd, int mode, unsigned int offset_a2,
> +    unsigned int offset_a3, unsigned int len_a4, unsigned int len_a5)
>  {
>      return ksys_fallocate(fd, mode, merge_64(offset_a2, offset_a3),
>                    merge_64(len_a4, len_a5));

this is white-space damaged, please resend with that corrected.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
