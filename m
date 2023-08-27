Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3600C789D3D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 13:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjH0LQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 07:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjH0LQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 07:16:53 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE687109
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 04:16:46 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a85b9c6ccdso1859598b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 04:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693135006; x=1693739806;
        h=content-transfer-encoding:subject:from:reply-to:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJmYrWmRmpXxOujg+OQiE1K3Sx+g8h3tcHh7bhFexXI=;
        b=aa5zTc1Cb8tV/b2O3cRWLmGPwUbCfUELxsGhzzogTH4qcw61HXJVY/SpzY3R1dEoFP
         JpA2dnP22KvxtNvjfUm4roW+K7mVl5tM4QLTKWLNSWgKMwP1UlbOuOH960dm8w/DnnRo
         z/z+xIivziHZqW9OsxNaAvuKlEfnS22eP9N2CE6hi0XLCmS0vlMt1pTiWaNEbOvU6UUy
         aelEaTR3AvOMgYXk3pLf93NNZ82vkfmJA4438KOaXD02zID38DxRZxOQrQw86yqUiOhN
         JKUQbAl5Ln4eWuuVelJoTPt4QowJDjYIqylHLs2Fr9/w6D4xf8t3zcHBtxygZBFeC0Nb
         qbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693135006; x=1693739806;
        h=content-transfer-encoding:subject:from:reply-to:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJmYrWmRmpXxOujg+OQiE1K3Sx+g8h3tcHh7bhFexXI=;
        b=KQYfC4WrhcOKFG+3oIQny3ZgcgtUtrdsFP1zgmRVOcKdo1eSN8T2PZ7uwofzWxiXTx
         MTzaUMdDwvjWvVnc7GS62ujwFrYA/wCXDkamOH3Q1nh0ie1QVa34evs+z1X6L4aAqvT5
         T2VfilwRzgh4gGVteseFrwLzW9XHfgkGyJ3GzzLN2HeBQwx/4zos1Fv4E3QjOaxlTbjO
         C7lC/xL7/LJqsv51g82phSTfhgGWt0hIs+uvHjfh+Ix8fMz9rp0Qjfw3w3ghNVP6c2ca
         Myli6hUibKYUKrV+y1S89mdrIWItcfsS4QqYb/YQb4QKvXSS+rSUTdQwFB3MYUdOsFZe
         27mA==
X-Gm-Message-State: AOJu0YxupnYIiEYRn0ILnuOfPtLdK2dCF7UUpv6al3fhGvjVoPfei7gL
        CBnBQoJMQHEq9b1vYwFaUHqN+mi732TVzD4k
X-Google-Smtp-Source: AGHT+IGTYj4MItsxKHcKFDgUktBntcZHWgfBzG560nKtJGQNI6VXo6O3t+2NFSbm7mS2xghDGP9SqA==
X-Received: by 2002:aca:1c17:0:b0:3a7:4fa4:edfe with SMTP id c23-20020aca1c17000000b003a74fa4edfemr8124630oic.54.1693135005812;
        Sun, 27 Aug 2023 04:16:45 -0700 (PDT)
Received: from [10.0.2.15] ([103.37.201.178])
        by smtp.gmail.com with ESMTPSA id p13-20020aa7860d000000b00687790191a2sm4629446pfn.58.2023.08.27.04.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 04:16:45 -0700 (PDT)
Message-ID: <24deab57-5480-3af6-17e6-0874aeaef3db@gmail.com>
Date:   Sun, 27 Aug 2023 16:46:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, luisbg@kernel.org,
        salah.triki@gmail.com,
        syzbot+fc26c366038b54261e53@syzkaller.appspotmail.com
Reply-To: 88c258bd-3d0c-de79-b411-6552841eb8d0@gmail.com
From:   Manas Ghandat <ghandatmanas@gmail.com>
Subject: [PATCH] fs/befs: fix shift-out-of-bounds in befs_check_sb
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Greg,

Sorry for directly mailing to you but I tried to reach the maintainers 
for quite some time now. I haven't received any response on my patch. I 
was told to mail you in order to get my patch pulled.

