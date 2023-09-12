Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0946379D72E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbjILRGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjILRGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:06:45 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63E5110
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:06:41 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-34e1757fe8fso7016665ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694538401; x=1695143201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U2j/Jw9eTuzQFJfXJuPtObQqtmWRSTu+BiB0SV3hnyg=;
        b=TGXD7Xbq8XngKWyOsz1dunxsOEvY9L29IzEpkF8h+DggHGdd/NXFEODwW8fupLKiPm
         KA2zFx17+SM5b3PDCbVYZvcznHDw9DVkCez500Qo6ErGAXN6fyOAm3te7/h7Jidwy9SL
         2/zsLwZR6gZyhYWLjPsUknKDInPWBcTZ9f5PvSaWpYsPGhNuG5mIsJ7clEs+2TdifZwL
         s5VkyHNgO4HCmOzL9YVXDQRZ/xWtUOOhvS9yItKH5hlDra/b+h7DOkUKObU/PuSd79DK
         /phFVU2oIbOONJvmIWCH/kRilMbc502jWgZShGDb+orija2ivpbm+SAV9vhUlyWRl/8H
         SWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694538401; x=1695143201;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2j/Jw9eTuzQFJfXJuPtObQqtmWRSTu+BiB0SV3hnyg=;
        b=SvmBrc94swowwDytDS9CwFmUEHvqy78vcAO+znItRRKzH/OTn8ETDBs6JOyCBgFwMw
         xkaW38Y1+fBdLk/Y2VdjgW2fWeV0IVi69dDd2/6zE7uIsmJudk9LRxqEeN90og0bXmVc
         GlF/G2DrrnNF7pMWlkSIeKiAHLlsa8DICjv5P/mBd48cIQXD9LR1L65a8zaq8vdaI+yp
         KcdphSVx9++B4k2TMHQos76lUtd/NSqk7SaAKSJDylQNayHergqS8r222GP91f57spid
         ZsFLA+EQ4Ky7XY2Cx/r3vc4cefHYFExi+wUEmyJn01nO20g56umQs0iWkRZN3+HUi7Cs
         MnPQ==
X-Gm-Message-State: AOJu0Yyjq9rOqCZw2ckKwfzDQNp6BiCrMnAhghnoadKQDg6RE/7/wxIS
        6uhUoY94gzi9poEgVdHxHDGhbw==
X-Google-Smtp-Source: AGHT+IHdt6IRcs9hAsCNchWOsHxOoRUWUOQv41eVA5rDSet1Hyuvw3eD3NYkW2GiZ5lRJSISETXOzw==
X-Received: by 2002:a05:6602:1489:b0:792:6be4:3dcb with SMTP id a9-20020a056602148900b007926be43dcbmr422572iow.2.1694538401048;
        Tue, 12 Sep 2023 10:06:41 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id n7-20020a6b4107000000b007951e14b951sm3014493ioa.25.2023.09.12.10.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 10:06:40 -0700 (PDT)
Message-ID: <26ddc629-e685-49b9-9786-73c0f89854d8@kernel.dk>
Date:   Tue, 12 Sep 2023 11:06:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v4 0/5] Add io_uring support for waitid
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     brauner@kernel.org, arnd@arndb.de, asml.silence@gmail.com
References: <20230909151124.1229695-1-axboe@kernel.dk>
In-Reply-To: <20230909151124.1229695-1-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/23 9:11 AM, Jens Axboe wrote:
> Hi,
> 
> This adds support for IORING_OP_WAITID, which is an async variant of
> the waitid(2) syscall. Rather than have a parent need to block waiting
> on a child task state change, it can now simply get an async notication
> when the requested state change has occured.
> 
> Patches 1..4 are purely prep patches, and should not have functional
> changes. They split out parts of do_wait() into __do_wait(), so that
> the prepare-to-wait and sleep parts are contained within do_wait().
> 
> Patch 5 adds io_uring support.
> 
> I wrote a few basic tests for this, which can be found in the
> 'waitid' branch of liburing:
> 
> https://git.kernel.dk/cgit/liburing/log/?h=waitid
> 
> Also spun a custom kernel for someone to test it, and no issues reported
> so far.

Forget to mention that I also ran all the ltp testcases for any wait*
syscall test, and everything still passes just fine.

-- 
Jens Axboe

