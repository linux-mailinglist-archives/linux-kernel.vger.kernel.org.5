Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4DE7DB9B9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjJ3MSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJ3MSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:18:02 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E04C6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 05:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hsbAezSzyBm53JGNRgJ84VRvXKjNQAxnaTLPoA+ep88=;
  b=tdD0mbyOlqMTUlPXFIWb/ZrZqHHX1TKohOX2NAgORsQb+qCQlG8sEhJe
   NNds9aiSaUx5Pky/rL5/ciPwFu3ilYYPX4w+SNhKPUa98dkXSztdAXxuq
   R86hRUi1AwzScpztUfg+1Cj1NsPnl6fmchjLoPSP5di34MeOt4BzkSf3w
   A=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,263,1694728800"; 
   d="scan'208";a="70115333"
Received: from unknown (HELO hadrien) ([163.173.89.160])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 13:17:58 +0100
Date:   Mon, 30 Oct 2023 13:17:56 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Nancy Nyambura <nicymimz@gmail.com>
cc:     nicydaniels@gmail.com, outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Staging: rts5208: Replace strncpy() with
 strscpy()
In-Reply-To: <20231030115939.48985-1-nicymimz@gmail.com>
Message-ID: <8c2e19c5-bb32-3a78-f6fa-33bf4c97802e@inria.fr>
References: <20231030115939.48985-1-nicymimz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Oct 2023, Nancy Nyambura wrote:

> warning found by checkpatch.pl script.I replaced the usage of strncpy()
> with strscpy() in the code(line 524) for the buf buffer to improve
> string copying.This is appropriate since strscpy() is used when you want
> to copy a NUL-terminated string and the destination buffer requires
> trailing NUL-padding.

Are you sure that the original string is null terminated?

Please put a space after each . in your message, for better readability.

julia

>
> Signed-off-by: Nancy Nyambura <nicymimz@gmail.com>
> ---
> Changes in v2:
>   - Make the commit message more clearer.
>
> drivers/staging/rts5208/rtsx_scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/rts5208/rtsx_scsi.c b/drivers/staging/rts5208/rtsx_scsi.c
> index 08bd768ad34d..52324b8ebbc7 100644
> --- a/drivers/staging/rts5208/rtsx_scsi.c
> +++ b/drivers/staging/rts5208/rtsx_scsi.c
> @@ -523,7 +523,7 @@ static int inquiry(struct scsi_cmnd *srb, struct rtsx_chip *chip)
>
>  	if (sendbytes > 8) {
>  		memcpy(buf, inquiry_buf, 8);
> -		strncpy(buf + 8, inquiry_string, sendbytes - 8);
> +		strscpy(buf + 8, inquiry_string, sendbytes - 8);
>  		if (pro_formatter_flag) {
>  			/* Additional Length */
>  			buf[4] = 0x33;
> --
> 2.40.1
>
>
>
