Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590D18012FD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379412AbjLASp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379400AbjLASpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:45:53 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19411719
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:45:58 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c9ea37ac87so2840501fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 10:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1701456357; x=1702061157; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ehPF3PQOoozfZlnimBntfStR9Uo37yTTJuQcGJqsFug=;
        b=k74UPw0gvygvuodz9qrWcR7HUx0dBMN4mF149dah9Uxyi9VWLTZ60NyEPAEAs/R4ub
         5P9zzkzUxJPVEhx6wPJ2w4wKVJZZoCSTZf2NyddD/4zcsrulrVz4HmcKQbpAnA6Jxq9F
         B0mFDhbNST8NJrTmf+X4W53+RWTFFSVCJiRf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701456357; x=1702061157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehPF3PQOoozfZlnimBntfStR9Uo37yTTJuQcGJqsFug=;
        b=HMvrgYvnBBqTJWDmB0mwfkNK6OSQZjYpNkkb2iy77yNUOB0wDRE2hwjmm1+w0ad4mA
         NzESp7As80985T/Nw/S4OAMOiOkSaxMnQZMB5s4roWDqVDGhc7sQApXouW8K+nYuwbmC
         YmdNXgZwrMC9776DX4fzCqKEPbJi6aF+2fMFrkvyjanu0HxbGBGYLx/F4rti5Jk9gtgb
         7CT/6Pf2LxGKXdPr0q8h2qj8kE0axzEoYA0uq8ySVvTcnkRucu/rsTX/WGnKSEMSbHvA
         U37r4GYVts9KqlT4Y1yVpLvdCxXJhct1ytxtcmf8XaWiAQE2RQpY0HdGg7p3v0xk4g8Q
         4ngw==
X-Gm-Message-State: AOJu0YyYvtkZhHPo2S4m/pcT90Ug7bmXUPrLReHcvIuKx6p0WoWrkVPb
        XP4SCAh0LFePxns3lTWnMuJB2RT96uxCyHuuHkfYTg==
X-Google-Smtp-Source: AGHT+IE8xiDq7cDppayGfqhkRD9LEy43hC3BSAYf6c5fbstKSddOuXMTu49xOCFaaxIyVwQF4T/pnR9h142dF8etd88=
X-Received: by 2002:a2e:9e8a:0:b0:2c9:c1f8:fa29 with SMTP id
 f10-20020a2e9e8a000000b002c9c1f8fa29mr873997ljk.33.1701456356945; Fri, 01 Dec
 2023 10:45:56 -0800 (PST)
MIME-Version: 1.0
References: <CAMVG2stxMYZbDoAHeVQjgJ7f+Td7+VJrLNRbY8au68ZVkzhb0g@mail.gmail.com>
 <20231201032548.5y3lafkwamlhruqs@moria.home.lan> <20231201052701.jrxwpjte4htzn6wo@moria.home.lan>
In-Reply-To: <20231201052701.jrxwpjte4htzn6wo@moria.home.lan>
From:   Daniel J Blueman <daniel@quora.org>
Date:   Fri, 1 Dec 2023 13:45:45 -0500
Message-ID: <CAMVG2ssNi_otD9tjobdCVFn6RivojzvKGqS7b6k+aPrvk-7JQA@mail.gmail.com>
Subject: Re: bcachefs page fault oops after device evacuate/remove and unmount
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-bcachefs@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2023 at 00:27, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> On Thu, Nov 30, 2023 at 10:25:48PM -0500, Kent Overstreet wrote:
> > On Thu, Nov 30, 2023 at 08:47:33PM -0500, Daniel J Blueman wrote:
> > > Hi Kent et al,
> > >
> > > On upstream bcachefs (master @ evilpiepirate.org/git/bcachefs.git) SHA
> > > f8a1ba26, I was able to develop a minimal reproducer [1] for a page
> > > not present oops I can provoke [2]. It appears we need further
> > > synchronisation during unmount.
> > >
> > > Let me know when there is a patch I can test, or for debug.
> > >
> > > Thanks,
> > >   Dan
> > >
> > > -- [1]
> > >
> > > modprobe brd rd_size=536870912 rd_nr=2
> > > bcachefs format -f /dev/ram0 /dev/ram1
> > > mount -t bcachefs /dev/ram0:/dev/ram1 /mnt
> > > fio --group_reporting --ioengine=io_uring --directory=/mnt --size=16m
> > > --time_based --runtime=60s --iodepth=256 --verify_async=8 --bs=4k-64k
> > > --norandommap --random_distribution=zipf:0.5 --numjobs=16 --rw=randrw
> > > --name=A --direct=1 --name=B --direct=0 >/dev/null &
> > > bcachefs device evacuate /dev/ram0
> > > bcachefs device remove --force --force-metadata /dev/ram1
> > > bcachefs device remove --force --force-metadata /dev/ram1
> > > kill %1
> > > wait
> > > umount /mnt
> >
> > The remove fails for me with DEVICE_SET_STATE_NOT_ALLOWED - evacuate set
> > ram0 to ro, we can't remove our last rw dev.
>
> Got it to repro, just had to ignore those errors - there's now a ktest
> test for it, and the fix is in master :)

Fine work Kent! The fix is good from further testing here.

Tested-by: Daniel J Blueman <daniel@quora.org>

Thanks again,
  Dan
--
Daniel J Blueman
