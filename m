Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7787CBC20
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbjJQHTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbjJQHTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:19:49 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D008E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:19:47 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a7eef0b931so66067537b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697527187; x=1698131987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sQwBZF7yomSeFnEELBnlnKpdEQecOf+IZL5sDoY9Qm8=;
        b=EpVKaLlpsMjbX4eEuIUqRHW20qHt1HgiiYpsoxD90ILWRExtSVmEnEIvBvy+IPONgX
         sEDlW9tKkwBYMPvllwZeeK5jOWiW7GE2z5XpsOd42nedrJ1xujYGcfUBXeazvz6Q0ndl
         OxGiooTJ86f+CTIEkJHg53FtX0lQhSXLZ0kn8/WduxHOiCzhBgizQ44szP3tJhckd6XA
         /8lRyNuQsDDg+V8bRTc7n69FUJDQ8wztQ6VFQF+7T6zr4lohyCn0VetQdseR+IoUmzUd
         FijrN1XH0thULxGgH3I8miapc3hu/Od4F8eR53Q4V/Aa5DD9e898ZZEWITuS0IaA4zej
         jSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697527187; x=1698131987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQwBZF7yomSeFnEELBnlnKpdEQecOf+IZL5sDoY9Qm8=;
        b=JUb018r1RafmWsQVwljl+YshHWhqBlFj/OMNMYeAD5ttneNcccKRnV5GPNgiUeAoyS
         pTq4PaqAbqZyN4xBB/bUqItyqKGr4tOdjyZtHn+gNyyORCSQfsj7AKmfxnRe53X/Ks54
         yohK4xD+ubBQ5AlhPwAfDliRQqmj7F866UvJ1pLTzdbYsAQXGV4fdvVj5Iehs8zJMikD
         zPT+aTkjEPJOEq8HpXOg/F4/i/wyb1ufIDWUWx3R8KPRx2vWbehzq8owxygSdQD/DINo
         9/bnHSwNMHxF6MhC247TIZtAHyR241VgHJYn/dmFjkE85w5gkV8D/mk3x4AimfhRQYaM
         wXZQ==
X-Gm-Message-State: AOJu0YyX4v515QlIDc2hDRGur3b7oBhxKcrSX23le6x8kVnOE4FRUMKJ
        bB/0lgP0HXC27qzmlM5rXy4=
X-Google-Smtp-Source: AGHT+IG6JQThO8Ot4Zuv2WY0wihxScM3250ow9B9wyGNqK1zuSbkrPAU1Qq9rG2B1hQ3GmhPeHsaTw==
X-Received: by 2002:a0d:d382:0:b0:594:e148:3c42 with SMTP id v124-20020a0dd382000000b00594e1483c42mr1311925ywd.52.1697527186914;
        Tue, 17 Oct 2023 00:19:46 -0700 (PDT)
Received: from gilbert-PC ([105.112.189.86])
        by smtp.gmail.com with ESMTPSA id d77-20020a814f50000000b005a7ba08b2acsm409249ywb.0.2023.10.17.00.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 00:19:46 -0700 (PDT)
Date:   Tue, 17 Oct 2023 08:19:40 +0100
From:   Gilbert Adikankwu <gilbertadikankwu@gmail.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     outreachy@lists.linux.dev, forest@alittletooquiet.net,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Rename variable bUpdateBBVGA, byCurrentCh, byCurPwr
 and byBBPreEDRSSI
Message-ID: <ZS41jFfwBJ672Rb7@gilbert-PC>
References: <cover.1697495597.git.gilbertadikankwu@gmail.com>
 <0f6661a4-7281-4d26-8c26-ba03a567fcaa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f6661a4-7281-4d26-8c26-ba03a567fcaa@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 08:19:49AM +0200, Philipp Hortmann wrote:
> On 10/17/23 00:58, Gilbert Adikankwu wrote:
> > Make the variable names adhere to Linux kernel coding style and mute
> > checkpatch.pl errors.
> > 
> > Gilbert Adikankwu (4):
> >    staging: vt6655: Rename variable bUpdateBBVGA
> >    staging: vt6655: Rename variable byCurrentCh
> >    staging: vt6655: Rename variable byCurPwr
> >    staging: vt6655: Rename variable byBBPreEDRSSI
> > 
> >   drivers/staging/vt6655/baseband.c    |  2 +-
> >   drivers/staging/vt6655/channel.c     | 18 +++++++++---------
> >   drivers/staging/vt6655/device.h      |  8 ++++----
> >   drivers/staging/vt6655/device_main.c |  8 ++++----
> >   drivers/staging/vt6655/dpc.c         |  2 +-
> >   drivers/staging/vt6655/rf.c          |  4 ++--
> >   6 files changed, 21 insertions(+), 21 deletions(-)
> > 
> 
> Hi,
> 
> -       if (priv->byCurrentCh == ch->hw_value)
> +       if (priv->current_ch == ch->hw_value)^M
>                 return ret;
> 
> ERROR: DOS line endings
> 
> What does the "^M" at the end of the new line?
> Did you run checkpatch on your patches?
> 
> Thanks
> 
> Bye
> 
> Philipp

Hello, 

I do not know what this error means. If anything, I'm surprised there is
an error. checkpatch is hooked to my git commit and all the patches
built cleanly on my machine. I will resend now.

Thanks 
Gilbert
