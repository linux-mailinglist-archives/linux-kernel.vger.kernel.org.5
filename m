Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA7B7E13CC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 15:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjKEOCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 09:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKEOCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 09:02:45 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A75AB6;
        Sun,  5 Nov 2023 06:02:43 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-280b06206f7so674034a91.1;
        Sun, 05 Nov 2023 06:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699192963; x=1699797763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XMML29XmljUBP73d1u+oACTcGOeBeUKVNwdj0nRDrlc=;
        b=m/+vKx3drawUZpLERM5bsvrwdbTBqX5SIm76vZJEoasUs3GSZs6/Swq/eg2uQBstVf
         DwjeKkvrNxxyD1f5FbGzv/oYVlnI7K1RN8rPoUfxD14kfaMCqpn7Ruz4SNBaQKvt2wR0
         oR7PAvYKIa580Te2wVE2I1SW6l2rndPVZbRFhf8oFKyf0SCGrDaOtr4FZzQ9d4jE7xTq
         N2LFt8l/Qh3GCJORbfvgVzE34p+yyzfvRJ0/sJZ7SXSnDxEl4CvW9G706Cr0S80DR7CL
         EZ/QBcberVaxNcpi93FeduzJ0gmgBRbhRGXGKovT6s7QaYCmBm3X8paVVS+C3U6mKtU3
         VCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699192963; x=1699797763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMML29XmljUBP73d1u+oACTcGOeBeUKVNwdj0nRDrlc=;
        b=Fs1gJaMCKz1lHdrdc2o8wz5XwagVxszZ1khBAbrjuComIZUSmrEZQusZblDJ1mblV2
         xa8Mn3x8LG4Sd7iUURFOBtZlmq9issgTW/TqwqrHdgBsaMcH0hVln0E/LVcgRlPQgpaq
         g0tlwr3a/2rDd9rN59/F19gIdmZb4cLPv38BYjppDzjTb+pgiA22qhoazZiBv96HfN8O
         BtuI5xcQCveGp75UqDqLaek+kc96J2VQu+H4Mp6aYQFzN7f3PzZb4ra8EP37rjQwHe9Z
         njwyF7t3kbhoTneads2ZXbi2bcfdpXbE4+kIJ+nwnoRG9fOp1cFzRyNcll4SiyTC3Obt
         s6MA==
X-Gm-Message-State: AOJu0YyaMd+8OufURbz5Y7MCogl0oY2aIcVASiFdgRS/JmDMvF95P682
        VUQ6cP9yd/p/fuUV7wc6nGM=
X-Google-Smtp-Source: AGHT+IGzCQDltgsQsyhXMBZj46CfBvqvXf6imqmbWz+g0+MwMI1JRQh72FBG2pHKMz0ch2CSnlsdOg==
X-Received: by 2002:a17:90b:4396:b0:274:99ed:a80c with SMTP id in22-20020a17090b439600b0027499eda80cmr24254426pjb.3.1699192962758;
        Sun, 05 Nov 2023 06:02:42 -0800 (PST)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id fh6-20020a17090b034600b0028031e87660sm4108981pjb.16.2023.11.05.06.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 06:02:42 -0800 (PST)
Date:   Sun, 5 Nov 2023 06:02:39 -0800
From:   Richard Cochran <richardcochran@gmail.com>
To:     Edward Adam Davis <eadavis@qq.com>
Cc:     davem@davemloft.net, habetsm.xilinx@gmail.com, jeremy@jcline.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        reibax@gmail.com,
        syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next V6] ptp: fix corrupted list in ptp_open
Message-ID: <ZUegf5Od1rWxZ7rO@hoboy.vegasvil.org>
References: <tencent_856E1C97CCE9E2ED66CC087B526CD42ED50A@qq.com>
 <ZUeaaVHlYCaq2NwG@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUeaaVHlYCaq2NwG@hoboy.vegasvil.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2023 at 05:36:41AM -0800, Richard Cochran wrote:

> > @@ -44,6 +44,7 @@ struct ptp_clock {
> >  	struct pps_device *pps_source;
> >  	long dialed_frequency; /* remembers the frequency adjustment */
> >  	struct list_head tsevqs; /* timestamp fifo list */
> > +	spinlock_t tsevqs_lock; /* one process at a time writing the timestamp fifo list*/
> 
> Please change this comment to "protects tsevqs from concurrent access"

And please don't forget to take the spin lock around
list_for_each_entry() in ptp_clock_event().

Thanks,
Richard
