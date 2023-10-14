Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DDA7C926B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 05:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjJNDNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 23:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjJNDNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 23:13:20 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A61BF;
        Fri, 13 Oct 2023 20:13:19 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-3514bf96fd2so10458845ab.0;
        Fri, 13 Oct 2023 20:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697253199; x=1697857999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gZR9GQ4UrQVETczfpFoA5oUJZGuPlJ1DionOkWcaQtk=;
        b=E+UQMkxq4S2q8iDp+M69yYUIRhfG9s11dQp+w6gRT29teVC/OzSTBhq9eZ1VXXrG3U
         Ht6goN8diPY3h+wmKq9Af4jU9kBI2C+F/pGHtz60ja7ymKVd6avE6oTBFAEvYltSn2Q6
         jjT3+9mlx8YV+ZCTRsRpB9gpGdSUr71ykImJT4qI18PxpZB17A4bhdmUMQ8oMfFzPNxH
         Gm3oxLEY6ZVlLGYB4nBqwXDwRbLdYzPZg1nnazyRQIqV6nI6wL2hM5NESRK4NmKB7kQ8
         P2gcCdZFmTpAKryy2T2NbdTqEozmotPvb3I76OIOIfB30Qfa3GI+S2aEbX+YLhfw38a8
         sN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697253199; x=1697857999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZR9GQ4UrQVETczfpFoA5oUJZGuPlJ1DionOkWcaQtk=;
        b=Kvv3funiqW5gfcRoKcPbU8SS1dkvXxJXA1Yqi0nhypgQLZpmrTOUHFOZE6qiD/rBvk
         I7RZ0d98jsPWRi9iJFCJX3FzIxZ1KQuGU1tUVSv3ktLuvGNeJkliEFgWZOZszeyDUDs/
         BWWI7nZUDC31ceyqXIZ/WbBSl/wOP+jzJyJHnKin5gk7JHHLpcUqivb9AFrqUHjiGl/L
         mI6VwM63Qy9EZCIBNJxkcWI80WAtLMecPvCMLkKWh+d0INQz/rPX/JUWfgt4RgX1SJEv
         hG0EjfQZA3x5ZvSOMagAGluScizdqMNm4jMG3Haks+hn2U6k+Z+G3TgkH9DXWhSBhFKN
         4mfA==
X-Gm-Message-State: AOJu0YyLy2EXvtTFbMM/oVb67KikLOi8BbZMHmAukK9b3NjlW6YUJx8S
        OVM9Ta3cTvmY9vyJMRqMRgU=
X-Google-Smtp-Source: AGHT+IE1MZxT0XghpiJowhFJRgqww5CD22lTnCxtQabkQXxZ9NnqVBBA8Elvrko+kZZ4eIRkQ8bMCg==
X-Received: by 2002:a05:6e02:f45:b0:357:478f:a744 with SMTP id y5-20020a056e020f4500b00357478fa744mr10335334ilj.10.1697253198835;
        Fri, 13 Oct 2023 20:13:18 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:469c:3411:2771:1b7f])
        by smtp.gmail.com with ESMTPSA id bf6-20020a17090b0b0600b00274b9dd8519sm771138pjb.35.2023.10.13.20.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 20:13:18 -0700 (PDT)
Date:   Fri, 13 Oct 2023 20:13:16 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+0434ac83f907a1dbdd1e@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] Input: powermate - fix use-after-free in
 powermate_config_complete
Message-ID: <ZSoHTMQSa17OBzOw@google.com>
References: <20230916-topic-powermate_use_after_free-v3-1-64412b81a7a2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230916-topic-powermate_use_after_free-v3-1-64412b81a7a2@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 04:36:13PM +0200, Javier Carrasco wrote:
> syzbot has found a use-after-free bug [1] in the powermate driver. This
> happens when the device is disconnected, which leads to a memory free
> from the powermate_device struct.
> When an asynchronous control message completes after the kfree and its
> callback is invoked, the lock does not exist anymore and hence the bug.
> 
> Use usb_kill_urb() on pm->config to cancel any in-progress requests upon
> device disconnection.
> 
> [1] https://syzkaller.appspot.com/bug?extid=0434ac83f907a1dbdd1e
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Reported-by: syzbot+0434ac83f907a1dbdd1e@syzkaller.appspotmail.com

Applied, thank you.

-- 
Dmitry
