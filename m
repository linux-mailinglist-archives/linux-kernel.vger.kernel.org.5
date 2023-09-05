Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C01D792B90
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245738AbjIEQzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354817AbjIEOoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:44:04 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AC8197
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 07:44:00 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-77dcff76e35so35677139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 07:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1693925040; x=1694529840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uDutPGiBG6Po2dvkxSBUfS+rF+sofgODeMl6ZDUIXuY=;
        b=PKBCuFlftW2zUpE1hg25k20DOb4QmZZG1DbNoBi0L7Vt/KaeJJEvzp+Yivx5EnxMc1
         4LRXV+pq+KBkYy6yF4P+5X8Mqf90BOtjUodDdl95HgtwzO8I3xbfm3hny+XznMI8wx1s
         DgX0d/aRaWeftYz653xG5cE//6zodBdEJrmhsUM8rxNjiewYqOGx0Wwna4xMwFugLvbw
         Tr+cri+sI544kt1/EHEBH77yFEcs6Ea+iOK/qy+X1J3RFh51896S+QZR7av0ou9ch/Dw
         39/mvVWhf8e33M2Umb+uax/mSrDtHa9v3e9qV10xLYPfv6K7tjGZRmtJE7YxT8T/3GKq
         1RKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693925040; x=1694529840;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDutPGiBG6Po2dvkxSBUfS+rF+sofgODeMl6ZDUIXuY=;
        b=YWEqgOHiLEf1FedpgIJWcU9ONnG4odix4loP0BvFcg4Fd1veyKEthsU/b9bkZjHpqw
         pjNNMxF32bOXlR+oqvSgXc+wfJiaVcPvkXIWwRY6Ahv8js4PAgZPllygScptaRIvg27G
         HdogwlQR1fREPEjow9UzB3pNz7rKS2ureQH0AibEIG/cDqrNilUw65wzJ55GbinvvD3M
         jWvcgu24Zdx24P+XPh5XSB4BO4hJ3nmtaWVWhIX9DoqmWfw/apKFajcI+pdqiwpj+SfL
         wRFtShZBLMhXzrfYSgQgvMBMUmHPF/jLDGVCDptij03cz8TMCX4MDchczZrvtmKlFpDg
         WY9A==
X-Gm-Message-State: AOJu0Yz6pYxR22Bp2i0Gy9IcMA7qKsbSg6YFWSujWSwOmMkFVi74hKsC
        PomwrlAD5T8Gmdr6mWuXQ1g5hA==
X-Google-Smtp-Source: AGHT+IHJndDQG9aAVEP8VOwCX4dTzbOMcwnbnj+Ha6Hf1f7Ztt5hjbzUXDKhMeEhthYGOu22jdCxLg==
X-Received: by 2002:a05:6602:73a:b0:794:da1e:b249 with SMTP id g26-20020a056602073a00b00794da1eb249mr12614585iox.1.1693925040086;
        Tue, 05 Sep 2023 07:44:00 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 24-20020a0566380a5800b0042b05c1b702sm4117731jap.12.2023.09.05.07.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 07:43:59 -0700 (PDT)
Message-ID: <706c8b32-e530-4768-8d77-7df52c310506@kernel.dk>
Date:   Tue, 5 Sep 2023 08:43:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] io_uring: add a sysctl to disable io_uring system-wide
To:     Matteo Rizzo <matteorizzo@google.com>, io-uring@vger.kernel.org,
        asml.silence@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, akpm@linux-foundation.org, keescook@chromium.org,
        ribalda@chromium.org, rostedt@goodmis.org, jannh@google.com,
        chenhuacai@kernel.org, gpiccoli@igalia.com, ldufour@linux.ibm.com,
        evn@google.com, poprdi@google.com, jordyzomer@google.com,
        krisman@suse.de, andres@anarazel.de, Jeff Moyer <jmoyer@redhat.com>
References: <x49y1i42j1z.fsf@segfault.boston.devel.redhat.com>
 <CAHKB1wKh3-9icDXK9_qorJr4DZ61Bt7mZznFT75R99a8LeMi_w@mail.gmail.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHKB1wKh3-9icDXK9_qorJr4DZ61Bt7mZznFT75R99a8LeMi_w@mail.gmail.com>
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

On 9/5/23 8:24 AM, Matteo Rizzo wrote:
> Hi all,
> 
> Is there still anything that needs to be changed in this patch? As far as
> I can tell all the remaining feedback has been addressed.

I think we can apply it now. Needs hand applying as it no longer
applies, but pretty trivial.

-- 
Jens Axboe

