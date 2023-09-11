Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CCF79BA95
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358123AbjIKWHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238118AbjIKNkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:40:11 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3085CC3;
        Mon, 11 Sep 2023 06:40:06 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68fbb10dec7so927653b3a.3;
        Mon, 11 Sep 2023 06:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694439606; x=1695044406; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9VDr84hSVbwi5hvH4wIjokLGVKj3hqHaN8d1hkVJY4=;
        b=UwWHz2pUq8cdrgJIgHQaqu9ZAAOYpFvbuKLJbVAONbBkS3mqY6qGloQedqrfU0TYf9
         HAxV9hdgskY6s6yQUggj3XTcjgWBKlxLMBVOQRFvF8mZB40VQSWFIbWkFklGdASMXZzE
         /ZnZBv2mNGpRb8z5aEmY7nRtpGHZNWguBcKBRJnKXxJJII4JpL/nHrDojQUziLHMFHvm
         o9o67VD45/t4UfA24FZROFHWwiZGqY7nDsDw83EEXiiIZShPZi7Nlr3g4rc1OB8ojkUs
         eWQXSqEU+P+eYiE/oOsQeQd9ezkPHuWb0b5qDeCmS1noTvr2stDaiGRNsTwQB2YfHO3i
         uY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694439606; x=1695044406;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K9VDr84hSVbwi5hvH4wIjokLGVKj3hqHaN8d1hkVJY4=;
        b=jNxbsz9zISa4SBCnGJTjpOkptvRV/KrDrEUYmeIzK2LQmg9zG/5epUuy+3X2JtaVG+
         FR1T+qf5m1Vr0gnNPCZESumIHDXkQGLYCCKM5tVHvAsVwv/59Npmks5NhFb99/Eyzhuw
         4A8OD6mnIzHSFzWGyRDWvHApbUlLRuzII8INLx6pUKDHmSmxt829nLofu3bPqwFir+Rz
         KPrdO6p5mGTTyUxrh1x0k6VJ9FI3ndOH7nJgSBLonpBBPa07YFp6ME00MCC2MAhT4ndc
         ErJiVENsKNGEMJ/bN4Sz6SiCGn7hXZ4TNKu8DG2iEmrlBonN1Nla4UKYx6Ysbudga/vJ
         9aew==
X-Gm-Message-State: AOJu0YxROwbScqP11WlKOZSNsLmGqfIMsa2GN5uBvW36EYlus3TappU3
        icUfdR3POfztyzLXtT06Qh0=
X-Google-Smtp-Source: AGHT+IHl+4gbjB8OtkXTZb4JoAUuLBWU7WwHxuNnS5Pl8rXN09CaFnfnRlaNdAWTO0udNuAZHj3BVg==
X-Received: by 2002:a05:6a21:33a8:b0:153:39d9:56fe with SMTP id yy40-20020a056a2133a800b0015339d956femr9510871pzb.47.1694439606062;
        Mon, 11 Sep 2023 06:40:06 -0700 (PDT)
Received: from [192.168.0.106] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id w14-20020a63934e000000b0056c52d25771sm5473916pgm.69.2023.09.11.06.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 06:40:05 -0700 (PDT)
Message-ID: <514e7d3d-93ed-f2e3-0278-2bbf71e87693@gmail.com>
Date:   Mon, 11 Sep 2023 20:40:00 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Mehmet <mehmetmutinturk@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Input Devices <linux-input@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: amd-sfh module causes reboot and shutdown hangs randomly on hp
 aero 13
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> My laptop (hp aero 13-be0024t) hangs at reboot and poweroff requiring physical poweroffs (long pressing the power button) when attached dmesg output is generated. But this seems to be random as sometimes I have a dmesg with no errors related to amd_sfh and I can cleanly reboot/poweroff. Blacklisting amd_sfh module fixes the problem. This problem started with kernel 6.2.x and still present in 6.5.2.
> 
> During shutdown/reboot console outputs:
> 
> "Failed to umount /oldroot..."
> "kvm exiting virtualization..."
> 
> but cannot complete the process (waited for more than 1 hour).

See Bugzilla for the full thread and attached dmesg output for both hanging
and no hanging conditions.

Anyway, I'm adding this regression to be tracked by regzbot:

#regzbot introduced: v6.1..v6.2 https://bugzilla.kernel.org/show_bug.cgi?id=217900

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217900

-- 
An old man doll... just what I always wanted! - Clara
