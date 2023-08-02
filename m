Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CFC76CBE8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjHBLlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjHBLlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:41:10 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF67C0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:41:09 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686ba97e4feso6510814b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 04:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690976469; x=1691581269;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cV18Cisizme2k4YqWIWHrJEyGuocEaqPxg924l7XK8Y=;
        b=IlAptlq+VK98mpA2few2pmW5mYTUzP5uYXmdXaN/l0b1Pr25CRxbZ0IZrpzSaJdLF1
         LKHy4H0jBlHaaQcmjnw4aWlzvaIwACMlP2WBeG/l5UQNzhjIRfTylB+Pq6rK5vaukdr2
         hiiSJjYw5JEu+RD0SZ56T1tT3FOdybiUuD7BFDyyMsFiWFoZrVcY8nrCNBeSQOzL8NO2
         dJ7HzFdMyiYncy74xY8g6S1B/mHPnpS2HfVGQ56v/SUHKBfV03+qJgQQX1u/jceTmP6J
         KZrEbPROquPw4qnN11yg4pbrK73lUZ1plyqTosBJpn3MiSOS7K3x6MZxtMJOYFOXO15V
         wkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690976469; x=1691581269;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cV18Cisizme2k4YqWIWHrJEyGuocEaqPxg924l7XK8Y=;
        b=gZ5ou8mETlxbQxpZb44F/5Yb4gHgMP6j6nTiqkZZPyog8z+Oka/wsfb00EokgEI0AK
         3af3Az+Toz33oNkZyZaUnUxzSjR7n3r+97Bkjzw/cZTyEn1fCn6EdEKDeaV5RquXPhLb
         ldGqG+c+0b5ASLchp10UR5Ebv1R7Q2IwxkrnDl90yvljAfHU4JmRIURAUgLsKdKc9dtI
         aVBCAjBQ+/HblS3Lpowoh3RZFWrvAkmO7/gs3GoInLhhvRi40gIM14C7khO0SuVI4pLE
         z+9Dq48CFoa+Ua4rulLw9mq9HY5tFyTbnN6Kg+mR6wOQ9Q8pSNZc24wbT6vvqQxSLsFy
         eGjw==
X-Gm-Message-State: ABy/qLaokJY7mbUHHecacQN3725cCxOgP534qrln38nEHGahyGeM/tz6
        nnIuqPHn36AeanBO1P4fayY=
X-Google-Smtp-Source: APBJJlF6j5ZE3Y1mkxc9NxRnr/WudTbHe7GtCNVIUFzHuZuAyRVujwhnUraqbCBuy4C/MSirnmQb4g==
X-Received: by 2002:a05:6a20:a121:b0:13e:1945:8873 with SMTP id q33-20020a056a20a12100b0013e19458873mr9327883pzk.37.1690976468831;
        Wed, 02 Aug 2023 04:41:08 -0700 (PDT)
Received: from [192.168.0.105] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id j24-20020aa79298000000b006765cb3255asm10912100pfa.68.2023.08.02.04.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 04:41:08 -0700 (PDT)
Message-ID: <8edde583-2b5f-2332-e59a-f1f4688b9e40@gmail.com>
Date:   Wed, 2 Aug 2023 18:41:01 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        shenlinghai@163.com, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>, dwmw2@infradead.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux NVMe <linux-nvme@lists.infradead.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Ubuntu 22.04, "nvme list" will hang for 60 seconds after "nvme
 subsystem-reset"
Content-Type: text/plain; charset=UTF-8
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

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> Issue description:
> root:~# lsb_release -a
> No LSB modules are available.
> Distributor ID:	Ubuntu
> Description:	Ubuntu 22.04 LTS
> Release:	22.04
> Codename:	jammy
> 
> root:~# uname -a
> Linux dapu-Star-Lake 5.19.0-46-generic #47~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Wed Jun 21 15:35:31 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
> 
> root:~#nvme subsystem-reset /dev/nvme0
> 
> root:~#nvme list      //This command will hang about 60 seconds. 
> 
> Issue analysis:
> Maybe it hangs in function nvme_wait_reset. When we revert the following commit, this issue will disappear.
> if (!nvme_wait_reset(ctrl))
> https://github.com/torvalds/linux/commit/1e866afd4bcdd01a70a5eddb4371158d3035ce03?diff=split

See Bugzilla for the full thread.

Anyway, I'm adding this regression to be tracked by regzbot:

#regzbot introduced: 1e866afd4bcdd0 https://bugzilla.kernel.org/show_bug.cgi?id=217745
#regzbot title: listing nvme devices hangs after subsystem reset

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217745

-- 
An old man doll... just what I always wanted! - Clara
