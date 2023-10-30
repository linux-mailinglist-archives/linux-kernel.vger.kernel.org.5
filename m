Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A2D7DB37D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 07:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjJ3GhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 02:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjJ3Gg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 02:36:57 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931C5110
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 23:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WhYOyNsBwSt0A2Sp6fwBP45n6hPWu9Zp4no3NFT8gLY=;
  b=HBfA4fZy8ZtGAthr3cjLV20wKPLkSFoB2J5GF/4mmuydOUkwrqyURjnD
   b9FQmOu5+1zWfgQLY0Dk+aHL72ZY3LrVgMVnpSgUbotXtJQMtXhwtbkeK
   aP2iKulGtnHrQ9Q3W/ssVxl3hlPtbs6j7IAa1hZRNJJ/pDQe2Uvg1ECM2
   E=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,262,1694728800"; 
   d="scan'208";a="133818847"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 07:36:52 +0100
Date:   Mon, 30 Oct 2023 07:36:52 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Nancy Nyambura <nicymimz@gmail.com>
cc:     nicydaniels@gmail.com, outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Replace strncpy() with strscpy() for
 appropriate string copying in rtsx_scsi line 524 warning: found by checkpatch.pl
 script
In-Reply-To: <20231029191647.44127-1-nicymimz@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2310300735480.3533@hadrien>
References: <20231029191647.44127-1-nicymimz@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like the entire log message ended up in the subject line.  The
subject line should give a concise summary of what is done.  The log
message should give more detail about what you are doing and why.

julia

On Sun, 29 Oct 2023, Nancy Nyambura wrote:

> Signed-off-by: Nancy Nyambura <nicymimz@gmail.com>
> ---
>  drivers/staging/rts5208/rtsx_scsi.c | 2 +-
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
