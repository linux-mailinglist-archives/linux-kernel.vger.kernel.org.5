Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8B376FE33
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjHDKMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjHDKL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:11:58 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145E72118
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 03:11:44 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe10f0f4d1so3360648e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 03:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1691143901; x=1691748701;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1NyZ2ZcEUgRJ05nh4qGkaHP8XwB2d++wqI7O42ED1c=;
        b=Ll5IFace3oreRLGj4UuXZ8P6oCeFDrrzBK771h6azQQEjz4rAuLG52KQiFFlmvesba
         SMTqy+JDw6UGy3gO69FUpAkAG1qVIrS5c4Zvmu+sIkIJwPjCFihNSKxoTOB1awPHK0el
         5vJWgq7/JLvBVaqTvG1igX5EZlvhrWqaeATIG5TWMSh6nCDrsRDq2P3zasreSlK21oeo
         XBmHmX7wNI60u7JwZSIfj6vytHToI0bVKiaK982ZNKW0/wt+Efg5ZcNEO94LE5LH61i3
         SAWygQpVfCgjToTSmKryKk3iZCSCNUj3LWeH+xdYjCNqfBcKsktE3Hm6gd3wFfV2zS1y
         sZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691143901; x=1691748701;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/1NyZ2ZcEUgRJ05nh4qGkaHP8XwB2d++wqI7O42ED1c=;
        b=SoVCEpU01phOZQUfwRdcg2RWicu2jPmo5pwZpiFFqCQMyAcen0vhOMzOoPFu1lCusU
         TVfhXZ1gb9N4yn49u0QwU1Q33g6n8zxYZ3snm1SDZAvWHAAdVQauQGHkRXWDoyJHu2fM
         FjOeH8ShPMGzSdU/xZO47eyM4uk3Qzq4HC/QN+5hez9FLJjuIK8czX88PWlsZErCEA8g
         t/ZXS649SPfdHy0rrCkaJ2dTreajATYLQCQ7gPHChiIHZ6t5cpySRKdpU8yzkaspqBeV
         ciRC9drncnrhOh5DHZdARwxwVCnRLywH20b1gmbR6T1NIE2NKlyChRhpVYamyDNjntBx
         ujXA==
X-Gm-Message-State: AOJu0Yw7pACIuuJXQDYVlb74kyCDCgMLrgbg8xk67nUSoLMZldAb2cvT
        SHVrD1Ze1atvGcsBfDQ+Q+bmAQ==
X-Google-Smtp-Source: AGHT+IHMm/cDQmqDveE+uqKs6mjna7XVIhwy/27dUDJSYJo9be60LkkzqE9EGqB0f7Bq3vZv7TOvcA==
X-Received: by 2002:a2e:9c02:0:b0:2b6:d8d5:15b1 with SMTP id s2-20020a2e9c02000000b002b6d8d515b1mr985558lji.50.1691143900793;
        Fri, 04 Aug 2023 03:11:40 -0700 (PDT)
Received: from localhost ([194.62.217.4])
        by smtp.gmail.com with ESMTPSA id d8-20020a1709063ec800b009927d4d7a6bsm1083243ejj.53.2023.08.04.03.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 03:11:40 -0700 (PDT)
References: <20230803140701.18515-1-nmi@metaspace.dk>
 <20230803140701.18515-3-nmi@metaspace.dk>
 <ZMy+dTpJzln7DlgZ@ovpn-8-25.pek2.redhat.com>
User-agent: mu4e 1.10.5; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>, gost.dev@samsung.com,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jth@kernel.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 2/3] ublk: move check for empty address field on
 command submission
Date:   Fri, 04 Aug 2023 12:08:55 +0200
In-reply-to: <ZMy+dTpJzln7DlgZ@ovpn-8-25.pek2.redhat.com>
Message-ID: <87350zxgkk.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ming Lei <tom.leiming@gmail.com> writes:

> Hi Andreas,
>
> On Thu, Aug 03, 2023 at 04:07:00PM +0200, Andreas Hindborg (Samsung) wrot=
e:
>> From: Andreas Hindborg <a.hindborg@samsung.com>
>>=20
>> In preparation for zoned storage support, move the check for empty `addr`
>> field into the command handler case statement. Note that the check makes=
 no
>> sense for `UBLK_IO_NEED_GET_DATA` because the `addr` field must always be
>> set for this command.
>>=20
>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>> ---
>>  drivers/block/ublk_drv.c | 18 +++++++++++++-----
>>  1 file changed, 13 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index db3523e281a6..5a1ee17636ac 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -1419,11 +1419,6 @@ static int __ublk_ch_uring_cmd(struct io_uring_cm=
d *cmd,
>>  			^ (_IOC_NR(cmd_op) =3D=3D UBLK_IO_NEED_GET_DATA))
>>  		goto out;
>>=20=20
>> -	if (ublk_support_user_copy(ubq) && ub_cmd->addr) {
>> -		ret =3D -EINVAL;
>> -		goto out;
>> -	}
>> -
>>  	ret =3D ublk_check_cmd_op(cmd_op);
>>  	if (ret)
>>  		goto out;
>> @@ -1452,6 +1447,12 @@ static int __ublk_ch_uring_cmd(struct io_uring_cm=
d *cmd,
>>  				goto out;
>>  		}
>>=20=20
>> +		/* User copy requires addr to be unset */
>> +		if (ublk_support_user_copy(ubq) && ub_cmd->addr) {
>> +			ret =3D -EINVAL;
>> +			goto out;
>> +		}
>> +
>
> Given you have to post v11 for fixing build issue, please convert the
> above two 'if' into one 'if else':
>
> 		if (!ublk_support_user_copy(ubq)) {
> 			/*
> 			 * FETCH_RQ has to provide IO buffer if NEED GET
> 			 * DATA is not enabled
> 			 */
> 			if (!ub_cmd->addr && !ublk_need_get_data(ubq))
> 				goto out;
> 		} else {
> 			if (ub_cmd->addr) {
> 				ret =3D -EINVAL;
> 				goto out;
> 			}
> 		}

Alright. I was debating with myself one over the other =F0=9F=98=85

>
>>  		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
>>  		ublk_mark_io_ready(ub, ubq);
>>  		break;
>> @@ -1470,6 +1471,13 @@ static int __ublk_ch_uring_cmd(struct io_uring_cm=
d *cmd,
>>  						req_op(req) =3D=3D REQ_OP_READ))
>>  				goto out;
>>  		}
>> +
>> +		/* User copy requires addr to be unset */
>> +		if (ublk_support_user_copy(ubq) && ub_cmd->addr) {
>> +			ret =3D -EINVAL;
>> +			goto out;
>> +		}
>> +
>
> Same with above.
>
> BTW, I have verified this patchset with ublk-zoned example in
> libublk-rs:
>
> https://github.com/ming1/libublk-rs/tree/zoned.v2
>
> cargo run --example zoned -- add -1 10240
> mkfs.btrfs -O zoned /dev/ublkb0
> mount & git clone linux-kernel &umount

Thanks!

BR Andreas
