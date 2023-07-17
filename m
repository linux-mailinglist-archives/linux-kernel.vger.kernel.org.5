Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB117756DC4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjGQTzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjGQTzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:55:47 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136A3172C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:55:22 -0700 (PDT)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 758363F187
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 19:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689623715;
        bh=RsZ80vHPsv7p3WHvik8ahbpar4KBJIeZVzI7m9eLzKg=;
        h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
         Content-Type:Date:Message-ID;
        b=qET+yTpGKvB2qsQkg4N8fVuj8Hcu6Jf16Px0dM1+23RaoTt+5Oo1mM8d2J+rUp56F
         LJopvwukFjGARQD3yNYR1gL9MH8esBYD2DspOCp07ebl6ygmDAi1QVZFqKbU2Fnpy0
         zr9/WIfVS3lX8+2t3gls4XDx2u6m+kDnHWEcCpkngi5ae27kbG3fbZBfI5i+Z5fEAo
         zqIzZoVAaUjhN0W/oxrVT7QSpL008NAuAWAJ0G/m77Y8kuTDTmuandLaqsn3o/B605
         M2aDhAX4gaWaVOxcxMe57j61NbkXK/CcKBeaHdGSnvz87579OiqZHChH78InYVsx0W
         xV1D2El/N6njQ==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1b8b310553bso38111425ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689623714; x=1692215714;
        h=message-id:date:content-id:mime-version:comments:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RsZ80vHPsv7p3WHvik8ahbpar4KBJIeZVzI7m9eLzKg=;
        b=BCNBmUwuhU+bFw93HLgZlC735T3J291702HsIsK1dFreyTewbQ4p8L1cKVoFOWp7M3
         BYqaYf3y813LrZP+oE3fQZxMzAQvmoO88puzEfCvZwBVYJ6XjxwdMtMilFkFNCg/wgI7
         LWNQGniufzGY8aibdq9m4Fy33oZg6h3N5tAkz14gk6ts7AprGNh+eo9cHkm0qgn/t7xv
         al/qGiqbnpqy/aWqfQ6B4oa0rkz/5kZ3mQLb1a9DzC2SWXMJb6qW/qkQTDhAzG4YDRVU
         AEt6q2bnrU16NxSzgYRJyXaykR+OmqosRxXzRbKEH9LZlC96o3QcrEukIyedI8covOkM
         CjQw==
X-Gm-Message-State: ABy/qLaD3D4/BNoDufgen7rTlHWzkylqqsbU1c7e+k57jTjRVhorvLwD
        lrqnhdgezHkmoMnIeaFdk24VOW47DzFVLEv2HN7BO0pWwb10QttBiqncCHRgO35hqO2+A8Mp491
        tQI+7Vm8oocl/9L54Gi/MkmyfSvB8jtpyi53Kb0KlTw==
X-Received: by 2002:a17:902:6b4c:b0:1b8:400a:48f2 with SMTP id g12-20020a1709026b4c00b001b8400a48f2mr11658316plt.62.1689623713986;
        Mon, 17 Jul 2023 12:55:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGrOjtnY6lWiNfKGhtjqsBOM3t/HRtYVHIACSFW7pWvLs/xsm66kPBIrPbltatdXBvmmrKnDA==
X-Received: by 2002:a17:902:6b4c:b0:1b8:400a:48f2 with SMTP id g12-20020a1709026b4c00b001b8400a48f2mr11658306plt.62.1689623713638;
        Mon, 17 Jul 2023 12:55:13 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id w21-20020a170902a71500b001b9c5e0393csm238801plq.225.2023.07.17.12.55.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jul 2023 12:55:13 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
        id CB87160283; Mon, 17 Jul 2023 12:55:12 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id C5C689FABB;
        Mon, 17 Jul 2023 12:55:12 -0700 (PDT)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     Tariq Toukan <ttoukan.linux@gmail.com>
cc:     Wang Ming <machel@vivo.com>, Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yufeng Mo <moyufeng@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net v3] net: bonding: Fix error checking for debugfs_create_dir()
In-reply-to: <1051f5ae-82de-2e52-64f5-545fa2dedff9@gmail.com>
References: <20230717085313.17188-1-machel@vivo.com> <1051f5ae-82de-2e52-64f5-545fa2dedff9@gmail.com>
Comments: In-reply-to Tariq Toukan <ttoukan.linux@gmail.com>
   message dated "Mon, 17 Jul 2023 21:36:58 +0300."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2412.1689623712.1@famine>
Date:   Mon, 17 Jul 2023 12:55:12 -0700
Message-ID: <2413.1689623712@famine>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tariq Toukan <ttoukan.linux@gmail.com> wrote:
>On 17/07/2023 11:53, Wang Ming wrote:
>> The debugfs_create_dir() function returns error pointers,
>> it never returns NULL. Most incorrect error checks were fixed,
>> but the one in bond_create_debugfs() was forgotten.
>> Fixes: 52333512701b ("net: bonding: remove unnecessary braces")
>
>It's not this commit to blame...
>Issue was there in first place, starting in commit f073c7ca29a4 ("bonding:
>add the debugfs facility to the bonding driver").

	Agreed; please upate the Fixes: commit and resubmit, thanks.

	-J

>
>> Signed-off-by: Wang Ming <machel@vivo.com>
>> ---
>>   drivers/net/bonding/bond_debugfs.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/drivers/net/bonding/bond_debugfs.c
>> b/drivers/net/bonding/bond_debugfs.c
>> index 594094526648..d4a82f276e87 100644
>> --- a/drivers/net/bonding/bond_debugfs.c
>> +++ b/drivers/net/bonding/bond_debugfs.c
>> @@ -88,7 +88,7 @@ void bond_create_debugfs(void)
>>   {
>>   	bonding_debug_root = debugfs_create_dir("bonding", NULL);
>>   -	if (!bonding_debug_root)
>> +	if (IS_ERR(bonding_debug_root))
>>   		pr_warn("Warning: Cannot create bonding directory in debugfs\n");
>>   }
>>   

---
	-Jay Vosburgh, jay.vosburgh@canonical.com
