Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B682D7FBA56
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbjK1MlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbjK1MlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:41:02 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C159D59;
        Tue, 28 Nov 2023 04:41:08 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cfafe3d46bso30430235ad.0;
        Tue, 28 Nov 2023 04:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701175268; x=1701780068; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2gvT/eemWfZnbuwVirPp8cMGK9ZIdrawZbRWTeF6Ry4=;
        b=RpMy41qlarmTU9VnO4CH1odjhd5UYWOqpEg4JOeQTOW6MYL4WhVIRmNtEXetvJMkqb
         MR6SEoLQz7GhAPNZ2Y3YUcWgv31SD23veMLZnoYxdLUs1UwPzwudhXe5IPhbRYr3n2y/
         279/kfQnuEUQvXfNNWe/fW8fPq/cRwvdmvIHpVnZzIVBYk2Gmw2XlLctPxP3D0UwPQr2
         k65P4I/SaWhIxiSE1FifH2zuXMedBiH2rQG+V53IoGYKSoiLLiyJEKJvPVdVb248Xc5H
         WJ1AVMdzzIuSXClY+oQTfeO9JaC3Foqoa+mcCFwFCyuBZnaKHbKsPxrz1+2H7hzHxK4a
         2u7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701175268; x=1701780068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2gvT/eemWfZnbuwVirPp8cMGK9ZIdrawZbRWTeF6Ry4=;
        b=qSlMVytxCDp7FHvpJMo3PqBgt5APVf19UWD7xjLRprQRCvzvz2yVI3+APiEadLXauH
         srqc+XJKmkQoqZSgw98itH+xdJ7aopBCrL5WNJrF6gwEyTQpS4b1UfO8lrfDIPV9BehY
         Ls9i4CbCDzhdcjl6qGFwQYx85BJpF7mug+MtYjnQ4JH2c6cv1TL0q8qEVsyMSWJQRP1i
         d/P2iN6v786B7fxDXPqO5j0r6NzLFrl82Z5d29gy2/oTNqPN293RACS8aZFJq5reC7OI
         Fybi4qmZyabX2+T6oQ0qHKSF3gkB/enGxmNnWI0AUpLMyzmDY7nSUY9cakzUoD5SCU95
         Vw2g==
X-Gm-Message-State: AOJu0Yx5/V3yMP08jozNMVHFpE3rH0EXyJDJWyir+g4I1i+Yo6F0xEe7
        ts6a+/WjsSzONmXEchZqcJU=
X-Google-Smtp-Source: AGHT+IGyPQepTZKf/8QpPbbXEfU73fNPpR57oJdfkl5//aM7PggI11U1u2zrwxI8KxaDY+iBgyUH4g==
X-Received: by 2002:a17:902:d904:b0:1cf:a2aa:23ae with SMTP id c4-20020a170902d90400b001cfa2aa23aemr13508818plz.35.1701175267509;
        Tue, 28 Nov 2023 04:41:07 -0800 (PST)
Received: from [192.168.50.127] (awork111197.netvigator.com. [203.198.94.197])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b001cf68d103easm7212151plr.46.2023.11.28.04.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 04:41:07 -0800 (PST)
Message-ID: <74e0f310-fdf7-4a4b-bfcb-4d63c0cdfae4@gmail.com>
Date:   Tue, 28 Nov 2023 20:40:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dm verity: don't verity if readahead failed
To:     Wu Bo <bo.wu@vivo.com>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Cc:     dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>, stable@vger.kernel.org
References: <cover.1700623691.git.bo.wu@vivo.com>
 <b23a4fc8baba99010c16059a236d2f72087199a1.1700623691.git.bo.wu@vivo.com>
Content-Language: en-US
From:   Wu Bo <wubo.oduw@gmail.com>
In-Reply-To: <b23a4fc8baba99010c16059a236d2f72087199a1.1700623691.git.bo.wu@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping.

On 2023/11/22 11:51, Wu Bo wrote:
> We found an issue under Android OTA scenario that many BIOs have to do
> FEC where the data under dm-verity is 100% complete and no corruption.
>
> Android OTA has many dm-block layers, from upper to lower:
> dm-verity
> dm-snapshot
> dm-origin & dm-cow
> dm-linear
> ufs
>
> Dm tables have to change 2 times during Android OTA merging process.
> When doing table change, the dm-snapshot will be suspended for a while.
> During this interval, we found there are many readahead IOs are
> submitted to dm_verity from filesystem. Then the kverity works are busy
> doing FEC process which cost too much time to finish dm-verity IO. And
> cause system stuck.
>
> We add some debug log and find that each readahead IO need around 10s to
> finish when this situation occurred. Because here has a IO
> amplification:
>
> dm-snapshot suspend
> erofs_readahead     // 300+ io is submitted
> 	dm_submit_bio (dm_verity)
> 		dm_submit_bio (dm_snapshot)
> 		bio return EIO
> 		bio got nothing, it's empty
> 	verity_end_io
> 	verity_verify_io
> 	forloop range(0, io->n_blocks)    // each io->nblocks ~= 20
> 		verity_fec_decode
> 		fec_decode_rsb
> 		fec_read_bufs
> 		forloop range(0, v->fec->rsn) // v->fec->rsn = 253
> 			new_read
> 			submit_bio (dm_snapshot)
> 		end loop
> 	end loop
> dm-snapshot resume
>
> Readahead BIO got nothing during dm-snapshot suspended. So all of them
> will do FEC.
> Each readahead BIO need to do io->n_blocks ~= 20 times verify.
> Each block need to do fec, and every block need to do v->fec->rsn = 253
> times read.
> So during the suspend interval(~200ms), 300 readahead BIO make
> 300*20*253 IOs on dm-snapshot.
>
> As readahead IO is not required by user space, and to fix this issue,
> I think it would be better to pass it to upper layer to handle it.
>
> Cc: stable@vger.kernel.org
> Fixes: a739ff3f543a ("dm verity: add support for forward error correction")
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>   drivers/md/dm-verity-target.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index beec14b6b044..14e58ae70521 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -667,7 +667,9 @@ static void verity_end_io(struct bio *bio)
>   	struct dm_verity_io *io = bio->bi_private;
>   
>   	if (bio->bi_status &&
> -	    (!verity_fec_is_enabled(io->v) || verity_is_system_shutting_down())) {
> +	    (!verity_fec_is_enabled(io->v) ||
> +	     verity_is_system_shutting_down() ||
> +	     (bio->bi_opf & REQ_RAHEAD))) {
>   		verity_finish_io(io, bio->bi_status);
>   		return;
>   	}
