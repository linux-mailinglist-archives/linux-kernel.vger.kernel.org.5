Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F5B78489E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjHVRoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHVRoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:44:54 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8DB10B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:44:52 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68730bafa6bso3855440b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692726292; x=1693331092;
        h=content-transfer-encoding:subject:from:reply-to:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D83pxoorKSMZ3KXT4tteloMjPSR576OWtj/BqTWoltc=;
        b=VfouFOcEQm14bIP+hmAy9H5Cbv7pd8goiWgJvgc1/lWxlzx8olBW3oKzSwr9VnqdBi
         plsJsRPUMXz4Ru4PwMrCp8aDdrOWhuSSnIDwGnUP7utY8nrhv5bXAZKjtoxpOs3IRcT7
         U9wXwvDoj9coLJ+9yMf4iMbS9wKZ4ZxoM7D8k8xSlgYWlS/VtCgnOy9Tk9nxZ5r6nKX7
         03DGfI9Q0eZ6mRNWgpH6ppeR+3UoBXmuuCDsj63/RyrVJzvmsxzgaEx9ZaFZi9TuUGVS
         VtC7G+VBbngPYQTX0KFlorQMeFIm9skopJwZAwnQgZaJKA6LdrMC1srd+bEbmBtsaG+D
         khag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692726292; x=1693331092;
        h=content-transfer-encoding:subject:from:reply-to:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D83pxoorKSMZ3KXT4tteloMjPSR576OWtj/BqTWoltc=;
        b=MpkwgvQYFVAvqNdd/FIUr068x8YaGRtxGjCyIbgYFd0KCYxjcZw5NELAm6f8Z505Rn
         oikKpL+heYS6Ssl0M4L43WmF3/cfaKLRkEYceernndZlrojdMTFmq54rL0xH4INlu4zb
         6QbzWQ9EWj0julp8mv/+LyESHjYRazDm2vtnaLvOLwOUhx/ph6pU9sC04OjWgN1Gr0iP
         VKFDGjhY32+690chNfVWjxLyze99yuXlIxVghN5gvC2ccTJoZe94RdgLN/ydNaN1/YiC
         4covwD104o5bd+/lo/F5fvFXKruU/gTl3ayB+8jtzsGxv+T+lTVSOIVfT8D2ESDMTphz
         45lw==
X-Gm-Message-State: AOJu0YxTjP4XSGe5njH6fV9vCz3SU5wJbkcCaQhu6hfAZ5qdDTDv1nKS
        XF/0dBLJ0OY5sd54dLNc/Ho=
X-Google-Smtp-Source: AGHT+IFKTE7SIbTMMWJAx0oW0kr9RcAgSRKog0enFdYErkO+dy/8hNTNi/3zJPYuYshsZtVCFglNpw==
X-Received: by 2002:a05:6a20:1456:b0:13f:c159:63ec with SMTP id a22-20020a056a20145600b0013fc15963ecmr14333954pzi.24.1692726292148;
        Tue, 22 Aug 2023 10:44:52 -0700 (PDT)
Received: from [10.0.2.15] ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id n15-20020aa78a4f000000b00682a27905b9sm4500417pfa.13.2023.08.22.10.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 10:44:51 -0700 (PDT)
Message-ID: <f2b664d5-0710-67ae-fda8-d407af4df6fe@gmail.com>
Date:   Tue, 22 Aug 2023 23:14:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     anton@tuxera.com, linkinjeon@kernel.org,
        syzbot+ef50f8eb00b54feb7ba2@syzkaller.appspotmail.com
Cc:     linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Linux-kernel-mentees@lists.linuxfoundation.org
Reply-To: 000000000000aefc5005f5df169b@google.com
From:   Manas Ghandat <ghandatmanas@gmail.com>
Subject: fs/ntfs : use-after-free Read in ntfs_attr_find
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was looking at this syzbot issue : 
https://syzkaller.appspot.com/bug?extid=ef50f8eb00b54feb7ba2

While debugging I found that when we are traversing through the 
attribute list, there is case when the next attribute is null (most 
likely we are traversing out of the list) and thus there is this error. 
I was wondering if we could add a size field to this attribute list. 
This would fix this issue. Currently we are just parsing to the next 
attribute using the length field.


