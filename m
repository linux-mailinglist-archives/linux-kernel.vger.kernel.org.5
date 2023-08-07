Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848EF772D92
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjHGSQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjHGSQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:16:28 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2EF1726
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 11:16:26 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-26890669c8eso1018426a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 11:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691432186; x=1692036986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/q4TjxxI1B9tc9NK0ysQsqSRDTxO2q8K4DUCy+lY3jg=;
        b=ZHm0E6gCIT3guFsyTN+9ko/ZfAVeXA06TaGhqrJU6Z1duQ4H4mOs/YYBAuo9Ezgff+
         BJW1myC9fSPHEBFRVa69oMiB1BDGnfySVJROq2md92FnSLbj0ztldbM1Rilptl/OGYfq
         O2IiEtH+44E2rndBHhKND7T+of670U83MaOsv5yKHL546HVZrLYIXRPSxBsV3p2EY7fS
         YfTppA7bJE2XZnsm775YPmeLeRvL6lq4C3JU/RhS3unfOjq1FtWM9DRMyKd8TATajEjt
         HIkbeBY7euBxfZ5J/kCOkF9kiA3kjEnvzWEA5DjzilXb+BYuV95nZqSVhnY/JE0+kWvH
         rB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691432186; x=1692036986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/q4TjxxI1B9tc9NK0ysQsqSRDTxO2q8K4DUCy+lY3jg=;
        b=kYC9KZoSXAoS9AW7AuY7ZjOodI3+VFb8Uh6vP7r1Vm71Dpr2DX0QUXEWL8zPXS2keS
         kZzpX78MS03PsOtiP3MrNkR4ri4eTb0pN5ZjNpAG2wo7+zKSEdZTNT43O88ZYz76TqP7
         P4N1SFeM/n8XMB0jBAixfS0sodCMWc9oQY8eDRs+UiIwqZzEgKnw47JXprSYkNBHEtyz
         nuGCQ4Seob3ZYAffOt0cxtiMzOU+8FOGr5UNdWNEBifZxFs4/XdfjxKHyO7yz4Q63nve
         +Arq0EYQHoJrPkEC9LjH54jnwWVhGfOROqDC9ZTj5QCyGdmgNZtcw8gdz/pzLkSGOV2x
         JKKA==
X-Gm-Message-State: ABy/qLaejge+tRQd6vfm/1XDRARXaVDE8yJ9d3LhEWw472ktLLWqFXZa
        ubXA7AVJv2uokRnZC2Wm8xpmkQWHmif+w1LR9d8=
X-Google-Smtp-Source: APBJJlFVbkymLFOT/pjbfQRXS7wM3unL75yLMeFsY1s4Ndwc4JM9eAPrNzM57PDrDtPwd/jwX5C8WQ==
X-Received: by 2002:a17:90a:1348:b0:268:38a7:842e with SMTP id y8-20020a17090a134800b0026838a7842emr26021763pjf.2.1691432186424;
        Mon, 07 Aug 2023 11:16:26 -0700 (PDT)
Received: from [172.16.7.55] ([12.221.160.50])
        by smtp.gmail.com with ESMTPSA id q11-20020a17090311cb00b001bb8895848bsm7258030plh.71.2023.08.07.11.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 11:16:25 -0700 (PDT)
Message-ID: <c46eae4e-549b-0951-bef3-4747a7799856@kernel.dk>
Date:   Mon, 7 Aug 2023 12:16:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: linux-next: duplicate patches in the block tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230807145120.6c2080a0@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230807145120.6c2080a0@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/23 10:51?PM, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in the iomap tree as different commits
> (but the same patches):
> 
>   634aae6c3333 ("iomap: support IOCB_DIO_CALLER_COMP")
>   4d184b3fd1ab ("io_uring/rw: add write support for IOCB_DIO_CALLER_COMP")
>   d6cb42b086fe ("fs: add IOCB flags related to passing back dio completions")
>   7e8dcad9affa ("iomap: add IOMAP_DIO_INLINE_COMP")
>   448373a0bd1d ("iomap: only set iocb->private for polled bio")
>   661687f531ef ("iomap: treat a write through cache the same as FUA")
>   0e40c9e86011 ("iomap: use an unsigned type for IOMAP_DIO_* defines")
>   062ef9f4932e ("iomap: cleanup up iomap_dio_bio_end_io()")
> 
> These are commits
> 
>   8c052fb3002e ("iomap: support IOCB_DIO_CALLER_COMP")
>   099ada2c8726 ("io_uring/rw: add write support for IOCB_DIO_CALLER_COMP")
>   9cf3516c29e6 ("fs: add IOCB flags related to passing back dio completions")
>   7b3c14d1a96b ("iomap: add IOMAP_DIO_INLINE_COMP")
>   daa99c5a3319 ("iomap: only set iocb->private for polled bio")
>   3a0be38cc84d ("iomap: treat a write through cache the same as FUA")
>   44842f647346 ("iomap: use an unsigned type for IOMAP_DIO_* defines")
>   3486237c6fe8 ("iomap: cleanup up iomap_dio_bio_end_io()")
> 
> in the iomap tree.

I'll drop them on my side since Darrick has them merged now.

-- 
Jens Axboe

