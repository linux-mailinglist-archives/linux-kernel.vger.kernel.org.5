Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37179758133
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjGRPnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjGRPnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:43:41 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D068811C;
        Tue, 18 Jul 2023 08:43:40 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-666e916b880so3842339b3a.2;
        Tue, 18 Jul 2023 08:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689695020; x=1692287020;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/koSxq77hSR24QtFVNS0QJ26GEEQWB8WVjlFvhSTls=;
        b=Y959R8Ksn6jMbz80d40aR+I/ovr/QQfOmKWpOZsCRg1h8EeUUrV4kKRgZAEoprEjWA
         lqwupVOb59uzvYMofQoxtvyjqkrh9X+U4rsmhzVc97sA5rqqbliUTvATfaNoH5EnEuU3
         +MvaK03sWhodR2X9jzN2O+Rw2XBhgxeNCweQ/f2gi9Z9k6zIuoQ5Tt7lACDExd0YJNYn
         sdGoHXMoLxvxc2sahFXIEIOke+ituT4EQ6xoV+854mPvCF79gHYsGxcIQuB6dxkM+HI8
         hWpWBIYNl6WH/SZBuIWRmF9A4wmx+dimSEgW8LyJw+RmzlN6UTdYA2Cm+Kgpwv/OBFLM
         rmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689695020; x=1692287020;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s/koSxq77hSR24QtFVNS0QJ26GEEQWB8WVjlFvhSTls=;
        b=VV7NKp1gGfIbSQNreivps+k3vmt99AnoMfFr8G0tjgcE0xhSNrtpclIciCHoqLaVgM
         zIwAZ93+HNzi8CZbqub/7BRxcKHA8J+oXVS+b0GB6OQYh97Any11+rQrkRZm+pUYnHaA
         ajttSmliOHVbfjAqr7M3/FED1GuLaaA2PUc/DEsTmiBLU9LfAUfkXHggc7r9JFk7hTIb
         z0psH8X94WMJR2MKiP8ZIymb8xXDL7Iu5AsMpR7pVC+O4iBPG2EKVpszC7mkfKzfuDId
         AxyOUu6u/CgPvtLwexPepYp83J76pXO00wIFLYSsulCItWM63OCwgFbOdUHFvbdISGfB
         AZoQ==
X-Gm-Message-State: ABy/qLaH6WLExxmwoF7QKYxkdQAA3iOpMm2fAmyYrH4uy/FJ4bJ17A38
        C/UFPEQfxTZRB8DNHy/RrL43pFUVdzc6S4wy
X-Google-Smtp-Source: APBJJlEW7iBcZqHerCTAnpO9AruUgcaeYq/jAvAkp9Vcv/fLcnPA1w110fM+vFMRpJTaz6nO4rdUzA==
X-Received: by 2002:a05:6a00:198a:b0:67e:4313:811e with SMTP id d10-20020a056a00198a00b0067e4313811emr16357584pfl.0.1689695019730;
        Tue, 18 Jul 2023 08:43:39 -0700 (PDT)
Received: from [10.0.2.15] ([103.37.201.179])
        by smtp.gmail.com with ESMTPSA id k16-20020aa792d0000000b0063d24fcc2b7sm1698736pfa.1.2023.07.18.08.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 08:43:38 -0700 (PDT)
Message-ID: <59bb83c2-0914-7cee-c1d2-0360cdfbc0ee@gmail.com>
Date:   Tue, 18 Jul 2023 21:13:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org
From:   Manas Ghandat <ghandatmanas@gmail.com>
Subject: Fixing syzkaller bugs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was looking at the following bug 
https://syzkaller.appspot.com/bug?extid=5184326923f180b9d11a . Adding a 
null check at line 2556 of fix_node.c should fix this issue but i am 
unable to understand on how to call reiserfs_panic.
