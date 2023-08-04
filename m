Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0969676FCCE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjHDJFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHDJEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:04:49 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D80749F2;
        Fri,  4 Aug 2023 02:01:48 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a5ad6087a1so1146587b6e.2;
        Fri, 04 Aug 2023 02:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691139707; x=1691744507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hdiYU3oLs+tgo2aXTFMAz2724lcG+amcmhYKagtlmaI=;
        b=SV2hvlrZQwHK2+xQNQYc2ut84T8pMZl7IeoPdua9ZB0FEXVj5YSFNX8wPmzvAsZOrd
         rXGMznNF+EYb3LwDCz7NnRqo5fNMTLjsWirqwCa5Zxb1sTgX9SPPh5IIQigG0Rw2HclA
         EF8oanS4OJNEqckK9F356aV3nAge3pfPglVZLl+6bNHvlaYH0WG6kCYug0jA6F0R5JE2
         RgrVSS8qordThEg7SNPNUCAZ/++TQjVMYUJLegMzmx4WSn9pfrII2Z1wenAy7NYXQKgf
         R/ofDHt8lkW/Wv53F26j0/Qa1425UBlH+hvfYGYZd4eiJj1fINSQrut/aeHqZWoyZjKR
         M6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691139707; x=1691744507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdiYU3oLs+tgo2aXTFMAz2724lcG+amcmhYKagtlmaI=;
        b=IZL1ZooPYCKlUazrkHK8djhs7kSu8Dy9ryluUf1Ke+RBekCBVcMARZlyu42BIWagqB
         RPEMNK+2rcoIosTsR0xEbj2za1Cp6hy/Rrs5s3NEHaexYR/FpaZWxiXPWBEH5ilztpkj
         TFlp/hp5arVV3MAUykkUNxtL+CHgqicTuMNmEbaEyLHrhdNiIMnGJ5aeESB9IBZI8Vrk
         BfXMSHerG4jxQCmKUJFP9TrFVpZLSse41ZeFUW0qLne3bDT6eComepIBlEv+jpkF4hty
         Dv6fxd4hGNVsxdTkGkfe/wMx0rNuzJ0a+WTR0MRjvyCyiBMg2Sm0Oj7laH7Wx1U+w6lG
         EvRA==
X-Gm-Message-State: AOJu0YytqyCc1MeohAISlPQdc0bs31fPcod7TOqcQJvhP5oDpEfjIjYZ
        H2Utc1TzNXWQnPc5St8xFGE=
X-Google-Smtp-Source: AGHT+IEQDKRqBz57duyD/KV5eCWHbi6NUmXol/Y1XOols+Hm9yBd9ALRdjrErd1O4KzJX36hoZjVVw==
X-Received: by 2002:aca:1012:0:b0:3a4:8a41:c69c with SMTP id 18-20020aca1012000000b003a48a41c69cmr1146059oiq.13.1691139707559;
        Fri, 04 Aug 2023 02:01:47 -0700 (PDT)
Received: from ovpn-8-25.pek2.redhat.com ([2409:8950:2e11:36e6:d082:6f8a:2f51:c30e])
        by smtp.gmail.com with ESMTPSA id j4-20020a635504000000b00563bee47a79sm897541pgb.80.2023.08.04.02.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 02:01:47 -0700 (PDT)
Date:   Fri, 4 Aug 2023 17:01:41 +0800
From:   Ming Lei <tom.leiming@gmail.com>
To:     "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>, gost.dev@samsung.com,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jth@kernel.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 2/3] ublk: move check for empty address field on
 command submission
Message-ID: <ZMy+dTpJzln7DlgZ@ovpn-8-25.pek2.redhat.com>
References: <20230803140701.18515-1-nmi@metaspace.dk>
 <20230803140701.18515-3-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803140701.18515-3-nmi@metaspace.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Thu, Aug 03, 2023 at 04:07:00PM +0200, Andreas Hindborg (Samsung) wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
> 
> In preparation for zoned storage support, move the check for empty `addr`
> field into the command handler case statement. Note that the check makes no
> sense for `UBLK_IO_NEED_GET_DATA` because the `addr` field must always be
> set for this command.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
>  drivers/block/ublk_drv.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index db3523e281a6..5a1ee17636ac 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1419,11 +1419,6 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
>  			^ (_IOC_NR(cmd_op) == UBLK_IO_NEED_GET_DATA))
>  		goto out;
>  
> -	if (ublk_support_user_copy(ubq) && ub_cmd->addr) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -
>  	ret = ublk_check_cmd_op(cmd_op);
>  	if (ret)
>  		goto out;
> @@ -1452,6 +1447,12 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
>  				goto out;
>  		}
>  
> +		/* User copy requires addr to be unset */
> +		if (ublk_support_user_copy(ubq) && ub_cmd->addr) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +

Given you have to post v11 for fixing build issue, please convert the
above two 'if' into one 'if else':

		if (!ublk_support_user_copy(ubq)) {
			/*
			 * FETCH_RQ has to provide IO buffer if NEED GET
			 * DATA is not enabled
			 */
			if (!ub_cmd->addr && !ublk_need_get_data(ubq))
				goto out;
		} else {
			if (ub_cmd->addr) {
				ret = -EINVAL;
				goto out;
			}
		}

>  		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
>  		ublk_mark_io_ready(ub, ubq);
>  		break;
> @@ -1470,6 +1471,13 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
>  						req_op(req) == REQ_OP_READ))
>  				goto out;
>  		}
> +
> +		/* User copy requires addr to be unset */
> +		if (ublk_support_user_copy(ubq) && ub_cmd->addr) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +

Same with above.

BTW, I have verified this patchset with ublk-zoned example in
libublk-rs:

https://github.com/ming1/libublk-rs/tree/zoned.v2

cargo run --example zoned -- add -1 10240
mkfs.btrfs -O zoned /dev/ublkb0
mount & git clone linux-kernel &umount

Hope V11 can be merged.


Thanks,
Ming
