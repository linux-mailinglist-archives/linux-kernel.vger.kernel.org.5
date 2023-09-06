Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD65793C0A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240418AbjIFL7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjIFL7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:59:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AF8BF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 04:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694001540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=SKAV4fdQ3q6kj6qxeQRHTIbhfVN1rKf4+zbwkUoPtTU=;
        b=hcU5cqt3iTObhTl24ygPuCM9s6NudHQ63KIRzkDtdjw057bwxF9s781R8BdP181RTGCmIa
        apDt+0WjbNA9TXV4FXVpk82Yi+/M8SIQqt7OOsoJz/17jW4IRjFlzXjn+NXQKqYv70dQvK
        IBvdCpFEzgS5cVVRcepXP3eLliKQhvk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-rhGtyjGZNOqhe1jDRYopIw-1; Wed, 06 Sep 2023 07:58:57 -0400
X-MC-Unique: rhGtyjGZNOqhe1jDRYopIw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-401ea9bf934so22034955e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 04:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694001536; x=1694606336;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SKAV4fdQ3q6kj6qxeQRHTIbhfVN1rKf4+zbwkUoPtTU=;
        b=Xg4Rw7KkH17AFZedYRg7fSBwCK8xmsl10jYty00s1TzMgjzevoZu0XMRaXdcMZdYj0
         J1adsNyWhaFwfBmpj2J43eaUIaNbX05mRSaXuKO64AXQG8i/y5BJaLwKSb/iWV5SBGnf
         Fp9R50Z2EKzidPhrO027VIqo0Fou4yiHK3y6RgJwvfkTJyGBxadiq0gcsUGSlfD+uT9q
         fXQrY7li5s+yRGW6WjEHuMRnX/dbFGyEtWirfxL/yqB5RIUGVeBLWBK8w+Cj4bLM09TX
         Bc40TbO40vsxQSWS4WL6J8OtFBz33G8xPYM0GKEdG4Yv25FWIJNa9pUdKzxPikJoUsDG
         Uh0Q==
X-Gm-Message-State: AOJu0YynX1trGtuAuYWZnd7pfTlIvjAd/3rAbDYp8eWzRb7O3J466rDk
        KjsXMNHLFdcYS/6gTkriFIWM7vzavT213DmPFV/A5ptvbuWQJQTZsFqMgPfpokdTatqP3KXT37B
        BwP/xENH530+DbbSznjWYoG5S
X-Received: by 2002:a05:600c:b58:b0:401:bf87:989c with SMTP id k24-20020a05600c0b5800b00401bf87989cmr2026887wmr.34.1694001535742;
        Wed, 06 Sep 2023 04:58:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPggtM57hDQTIGuqanL6rw8QE92aXofPdGiP8puZm9Op7yO5UYaLvV6EFOToqu3n5AXS4P7w==
X-Received: by 2002:a05:600c:b58:b0:401:bf87:989c with SMTP id k24-20020a05600c0b5800b00401bf87989cmr2026874wmr.34.1694001535392;
        Wed, 06 Sep 2023 04:58:55 -0700 (PDT)
Received: from localhost.localdomain ([151.29.94.163])
        by smtp.gmail.com with ESMTPSA id r16-20020a05600c299000b00400268671c6sm19480370wmd.13.2023.09.06.04.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 04:58:55 -0700 (PDT)
Date:   Wed, 6 Sep 2023 13:58:52 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Question on tw_timer TIMER_PINNED
Message-ID: <ZPhpfMjSiHVjQkTk@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

I'm bothering you with a question about timewait_sock tw_timer, as I
believe you are one of the last persons touching it sometime ago. Please
feel free to redirect if I failed to git blame it correctly.

At my end, latency spikes (entering the kernel) have been reported when
running latency sensitive applications in the field (essentially a
polling userspace application that doesn't want any interruption at
all). I think I've been able to track down one of such interruptions to
the servicing of tw_timer_handler. This system isolates application CPUs
dynamically, so what I think it happens is that at some point tw_timer
is armed on a CPU, and it is PINNED to that CPU, meanwhile (before the
60s timeout) such CPU is 'isolated' and the latency sensitive app
started on it. After 60s the timer fires and interrupts the app
generating a spike.

I'm not very familiar with this part of the kernel and from staring
at code for a while I had mixed feeling about the need to keep tw_timer
as TIMER_PINNED. Could you please shed some light on it? Is it a strict
functional requirement or maybe a nice to have performance (locality I'd
guess) improvement? Could we in principle make it !PINNED (so that it
can be moved/queued away and prevent interruptions)?

Thanks a lot in advance!
Juri

