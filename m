Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4DB7D9CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346237AbjJ0PPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346219AbjJ0PO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:14:58 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42699186
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:14:55 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-357f487346dso2808365ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1698419694; x=1699024494; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=st57z9D7jfCFI7fw8EVno0lGyYuE+XP3ZmfBI82leXA=;
        b=lg31mNrsX5kuTOT9zme5R2fT8dCZFyaU97AObw53HKKSAjf7LTHf/+fl1xXeVQYSLl
         hJCQfzOE9Mni1QyXUpaRyQECz+pW4oN6E2EbxcixHyUr9D8oHnQyLX1qySEnWtUQYb+G
         pq/aW0qDzSWf3FfCeigA7S458hx86kkbW40Iu4x4J7MubRCwaoZLvh6fqtXJRY4BWyJn
         YTFs7c5KJsIjPiaXyXK7pUk5dlnp9ubC62Z/AiAFvTQjp5TfPVSEysWRIRjhRINnNanN
         9OljNdUrjgclQTjmciPlM2Vo8rkK+s0Zce4HwXrB582Bb5nWw5Rowi8BZARNU1/zDOxZ
         mLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698419694; x=1699024494;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=st57z9D7jfCFI7fw8EVno0lGyYuE+XP3ZmfBI82leXA=;
        b=KNKa9NuX923JvzyUsXIjqjYHB3/rMw2dHoVILMkvi6spe9SrmDtQf/yS1OEeELgTYc
         uMAb6l0Y1xyGm5YumRn79rrpaAX3vkqPGVjgAsUuM9jpss1ynSmhjKYH+Mt2S0dLpYQN
         WLo/rFfRVUIxah/62eBKLQMD8Qab03SIVCuwtNL9lO2FVhkcO9UhR13iK3X4xObdwU58
         5zhKXtGANurpzRgDTwX727UR2TMa39dwiZKqNaNxauDPYD8Me6w5C7vVax/wSiotUzDJ
         WZRVhCDhqGOCdKdsS2w8KtNhK8jbCxjiZFwdrkTMKKKrj/QZAWXrUgRJgw4Bj/nrsrU+
         RbHQ==
X-Gm-Message-State: AOJu0YwDa6FHkomTPM3zFSaitroyuEIgaqOINh2Uev45ZDm6Xg94qH6x
        Yub6IWwUVbR+vylzcRmnpiP2Tw==
X-Google-Smtp-Source: AGHT+IGqC94+jJIpy5Fv7ZQVenZ/Xv5a5N0eR2bEIrnRIEYLGXMoM2t77FGc56CMKntcpxt2ZYYKCw==
X-Received: by 2002:a6b:500a:0:b0:792:6068:dcc8 with SMTP id e10-20020a6b500a000000b007926068dcc8mr3608120iob.2.1698419694585;
        Fri, 27 Oct 2023 08:14:54 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id g90-20020a028563000000b0045c1fcf2ef7sm455858jai.37.2023.10.27.08.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 08:14:53 -0700 (PDT)
Message-ID: <a99a7fbe-ec31-4e31-87c7-1b7ae1dd1a5a@kernel.dk>
Date:   Fri, 27 Oct 2023 09:14:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: lockdep: holding locks across syscall boundaries
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Normally we'd expect locking state to be clean and consistent across
syscall entry and exit, as that is always the case for sync syscalls.
We currently have a work-around for holding a lock from aio, see
kiocb_start_write(), which pretends to drop the lock from lockdeps
perspective, as it's held from submission to until kiocb_end_write() is
called at completion time.

This is a bit of an ugly work-around, and defeats the purpose of
lockdep.

Since I've now got another case where I want to hold a resource across
syscalls, is there a better way to do this?

This is for inode_dio_start(), which increments an inode int count, and
inode_dio_end() which decrements it. If a task is doing
inode_dio_start() and then inode_dio_wait(), I want to trigger this. I
have a hack that does this, but it disables lockdep_sys_exit() as
otherwise I just get that warning rather than the more useful one.

Thanks,
-- 
Jens Axboe

