Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B93F799639
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 06:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbjIIEbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 00:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbjIIEbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 00:31:31 -0400
X-Greylist: delayed 898 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Sep 2023 21:31:26 PDT
Received: from mail-m25497.xmail.ntesmail.com (mail-m25497.xmail.ntesmail.com [103.129.254.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3551BFF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 21:31:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha256;
        b=Y9T09Ba3aDJmf/t9nRe28WFU3HTYA0M4yUY0ZPSc1KaH9+fCUt0R1GLPvr5Od612vVEMwJoj1t7livYkSUeVy9jDLQ4BD/A5L+fxW0kB3Z1ChJrMyRWDMpsniFxBcob7XvURgwbLQ05EUTrVtEttfWA/5hX5zoDnFKhorp2UPYY=;
        c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
        bh=WuNKHkVsHNP86Di5GRNLcvWVzu0r7U61O+1vXD2vASo=;
        h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
        by mail-m127102.qiye.163.com (Hmail) with ESMTPA id 5E4B06C01C6;
        Sat,  9 Sep 2023 12:06:19 +0800 (CST)
Message-ID: <468e55f2-f3d7-1340-dac9-1d6763d996cb@rock-chips.com>
Date:   Sat, 9 Sep 2023 12:06:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND PATCH v1] clk: clk-fractional-divider: Export
 clk_fractional_divider_general_approximation API
Content-Language: en-US
To:     Elaine Zhang <zhangqing@rock-chips.com>, mturquette@baylibre.com,
        sboyd@kernel.org, heiko@sntech.de
Cc:     linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangtao@rock-chips.com
References: <20230801081456.2551-1-zhangqing@rock-chips.com>
From:   Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230801081456.2551-1-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaH0NMVhlLSh9NQhhOHUgeSVUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpLSFVJQlVKT0lVTUxZV1kWGg8SFR0UWUFZT0tIVUpNT0hNTFVKS0tVSkJLS1kG
X-HM-Tid: 0a8a781e81efb280kuuu5e4b06c01c6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pi46Tjo4HD1RARAhPjw3M0sK
        GDYwCzpVSlVKTUJPSUhJSENLT0tLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
        EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlOQk83Bg++
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael and Stephen,

     Could this patch be land to common clock?

On 2023/8/1 16:14, Elaine Zhang wrote:
> This is used by the Rockchip clk driver, export it to allow that
> driver to be compiled as a module.
>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

Looks OK to me,

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever

> ---
>   drivers/clk/clk-fractional-divider.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
> index 479297763e70..44bf21c97034 100644
> --- a/drivers/clk/clk-fractional-divider.c
> +++ b/drivers/clk/clk-fractional-divider.c
> @@ -142,6 +142,7 @@ void clk_fractional_divider_general_approximation(struct clk_hw *hw,
>   			GENMASK(fd->mwidth - 1, 0), GENMASK(fd->nwidth - 1, 0),
>   			m, n);
>   }
> +EXPORT_SYMBOL_GPL(clk_fractional_divider_general_approximation);
>   
>   static long clk_fd_round_rate(struct clk_hw *hw, unsigned long rate,
>   			      unsigned long *parent_rate)
