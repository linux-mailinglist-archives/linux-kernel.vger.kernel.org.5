Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A240079B514
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbjIKVjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244173AbjIKTaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:30:03 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E42212A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:29:59 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c3c4eafe95so1538035ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694460598; x=1695065398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BGQStCvoWj3/Xp0jbKniFWE15sG3u2sI0fTxWSIsDmg=;
        b=prit8A2FLQgr0zLq8PU7OKMy6APt/Ea5q5Z9Lg/+Ogff9XggPHwMpaMyrI400eQlxM
         TAyRPWBB89WiSwrwLZ5YA4iWYvlDXyDIfs1KYnq4ViCBvueAe2wPAnrBZqVQNk+Dqb5b
         krsks3p6QzsrnlTDJBEPYljI2tENee9FREhhLLW+x+YqpLpsVEqxFgQQq0nYsBIxyZHf
         sRgoNEb4fx+85lP7soJnVvdX+NI/y2OY14rjDbbZ3HGMr4fs6uzrnhSNhoyYr++AgOc8
         vd7D0K3Nk7ml6oSthT1f5+OQ4Okm+Cgissn2fsAumkVbeokP5wcYLJ9/bCxiIJ8CaAeU
         2Fmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694460598; x=1695065398;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGQStCvoWj3/Xp0jbKniFWE15sG3u2sI0fTxWSIsDmg=;
        b=VYWCUIOuZgmd1Z7LLx6ZqBru7XjAd9Z8ecCBU+kb4nHwQS8wlHG2bW57/n+tt8HVAK
         MTuqVLWeyYK5HKps0StvtrADKjMefcmgW4Ewlb4UZE3gPYaf5B52bkQPIUffY2VY9tqo
         nsykVSB0easfJxsbDnqa5XO/yp83pWOUPXMKCEhorDslp9qRQTgBAFtdodEXvPzhn3Jr
         JH2Cw/EvKKfqvS/r1vVyxL8IZGvR7cr3/LujeFkEvK9oZh+XUtgln8Z+0+k6OuSDppGu
         ajZluGNwmCkJiuby84Nik2SkqS/RlHotyDB1NQN5K+wnpd0ajpULBUy4wWr+JlyPRLVJ
         kBfw==
X-Gm-Message-State: AOJu0YzPG+u2vQulkL2TWoRFG6SvH3vXyFmrjJK0Ye6yqGNrjiCklKc+
        l4tGSEyLnf5F0LWz8MX8JEMObg==
X-Google-Smtp-Source: AGHT+IEaqmgNPlrgJsJYHYB0ZENpQMy8GU6BQOpJO6AC4O+btal68J7EbL9UcfulTF4O8CmZsO2gQg==
X-Received: by 2002:a17:902:e546:b0:1bb:9e6e:a9f3 with SMTP id n6-20020a170902e54600b001bb9e6ea9f3mr12355983plf.4.1694460598344;
        Mon, 11 Sep 2023 12:29:58 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b001bdc66478c1sm6809944plg.309.2023.09.11.12.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 12:29:57 -0700 (PDT)
Message-ID: <bf5831cf-74b8-438f-8892-8b41cc222c2b@kernel.dk>
Date:   Mon, 11 Sep 2023 13:29:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel/task_work.c:73: warning: Function parameter or member
 'data' not described in 'task_work_cancel_match'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>
References: <202309120307.zis3yQGe-lkp@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <202309120307.zis3yQGe-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 1:12 PM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0bb80ecc33a8fb5a682236443c1e740d5c917d1d
> commit: c7aab1a7c52b82d9afd7e03c398eb03dc2aa0507 task_work: add helper for more targeted task_work canceling
> date:   2 years, 5 months ago
> config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20230912/202309120307.zis3yQGe-lkp@intel.com/config)
> compiler: or1k-linux-gcc (GCC) 12.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230912/202309120307.zis3yQGe-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309120307.zis3yQGe-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> kernel/task_work.c:73: warning: Function parameter or member 'data' not described in 'task_work_cancel_match'

Wow, that got introduced with:

commit c7aab1a7c52b82d9afd7e03c398eb03dc2aa0507
Author: Jens Axboe <axboe@kernel.dk>
Date:   Thu Apr 1 19:53:29 2021 -0600

    task_work: add helper for more targeted task_work canceling

which is a while ago. In any case, this should fix it. I'll send out a
proper patch.


diff --git a/kernel/task_work.c b/kernel/task_work.c
index 065e1ef8fc8d..2a628b4a6124 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -78,6 +78,7 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
  * task_work_cancel_match - cancel a pending work added by task_work_add()
  * @task: the task which should execute the work
  * @match: match function to call
+ * @data: data to pass into match function
  *
  * RETURNS:
  * The found work or NULL if not found.

-- 
Jens Axboe

