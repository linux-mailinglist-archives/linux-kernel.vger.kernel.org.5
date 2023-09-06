Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363127939F0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238755AbjIFKcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239118AbjIFKcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:32:02 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1409C170E;
        Wed,  6 Sep 2023 03:31:54 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bcb89b4767so53707401fa.3;
        Wed, 06 Sep 2023 03:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693996312; x=1694601112; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6pAkRqgeQrygmWfSfN4PJKp03XDlNyzBHf9eQxSb1GQ=;
        b=acLbj7dsqwLJJ28lHVNun88AzJ4bA9stRjXQ5ll/vF8nmfKkHQ7JkUdcboPzeil7RP
         23XmcXzD6X5SDZ0iu5t3/q12x5ZlADcRDOiQp0MtTK/mEEF3ZcSMnY0BqoH9pyr6ybdb
         +yR+l0Xui3Qg3nlFE4ltdJrwpkkmCcxBOgiCfgbz94Al4X3pOlueI/LwlS12jgTxOZP4
         q7NFf3s0gZ7vKgl9S8rUycX8Eq6IQAaCh9bKfDgQzXxNydBIi/oFghRHry5FOLibcRvH
         640V1R14vjQBkvDMzfAxVWQ+qj6tF6gzZBH2IpIZYFcoTAwUwaSwqX7ESy1n2srvDc8C
         wBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693996312; x=1694601112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6pAkRqgeQrygmWfSfN4PJKp03XDlNyzBHf9eQxSb1GQ=;
        b=Ae/fYDdXPd3h1W0tfaMX10a4h5qQPXA/BA+yixAstcjtwKGYRT6MPom5YIZpZkLCCZ
         ANh4uoQeWJ0SFGzwiPx2b8RTUWRpiRLl1aQqL23r2Ldd1oiwmpa9w24d3+ToEogpNh1m
         9++QO0jRPtpZJTu3oFMAQ8lwHJ+pTG7oeuj+P28knD6SpKt6b7PMQMdHkIjFDlCm97+H
         tPXmu3lg/6z50mclvbT0rbabG4y94PK/bdh6Gv4gIv57fA+l9oqwDcvo2mZ96dsuPt+m
         ctQUKnQS1ghA37Yah0Q1cAmBGJSfAtTGKli+7KGfSduJ+mw9XExOhJu6X+fjdHVIFKJw
         NxCg==
X-Gm-Message-State: AOJu0YwDGmYGslKRmo7SOypBcfkYCSuXT8L6bBkCAZ6hPmXvIK2YM1fs
        nee03xPfr9EUna3I4ovy8Wo=
X-Google-Smtp-Source: AGHT+IEdXslLqse0Kjy7k/XtDETw0FJMj96UkAyO5u6pB1rrm7q7InPsD+Cx2soqGvQkC9d5ra/WSw==
X-Received: by 2002:a2e:7a1a:0:b0:2bc:b0ae:a9e5 with SMTP id v26-20020a2e7a1a000000b002bcb0aea9e5mr1957864ljc.42.1693996311969;
        Wed, 06 Sep 2023 03:31:51 -0700 (PDT)
Received: from pc636 (host-90-235-20-237.mobileonline.telia.com. [90.235.20.237])
        by smtp.gmail.com with ESMTPSA id a16-20020a2e9810000000b002bb99f6f2c7sm3372444ljj.90.2023.09.06.03.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 03:31:51 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 6 Sep 2023 12:31:48 +0200
To:     Marcus Seyfarth <m.seyfarth@gmail.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Ziwei Dai <ziwei.dai@unisoc.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: Fwd: [6.5.1] Slow boot and opening files (RIP: kvfree_rcu_bulk)
Message-ID: <ZPhVFJXHchy+hbuR@pc636>
References: <CA+FbhJMr6LzmOpVNkYyiSERAsNEqqvQwQ7SwJK=CmwvV9d2Z-A@mail.gmail.com>
 <ZPYLmm3ih7u95l1a@pc636>
 <ZPYsY2HEjySkq/NR@pc636>
 <CA+FbhJPNK=4s8J5OqOBaDC8EDNQzevQMQ+fwZnfxG92ReabQOA@mail.gmail.com>
 <CA+FbhJMEqLycroz=J6VvC=4OBaJSwz8K+K6Zgki80M-5YdYp6A@mail.gmail.com>
 <ZPdbVO8ySCHLIEGu@pc636>
 <CA+FbhJOekDxBjQH6jUFXusgakRVx_Y0S3s5avko23c6XqCc2Mw@mail.gmail.com>
 <CA+FbhJNQfGW5RMJc-WaOmjqmYuTnqdvRPYO_40TP5=P4LFPDYQ@mail.gmail.com>
 <ZPd3n09wxHLMj2Bm@pc636>
 <CA+FbhJO4xfdrUtZLWMRMaZdM2W-G+ZKtg9ESdwT8DUFJZKmW-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+FbhJO4xfdrUtZLWMRMaZdM2W-G+ZKtg9ESdwT8DUFJZKmW-Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 09:07:40PM +0200, Marcus Seyfarth wrote:
>     Good. Please do not include that patch on top of 6.5.1 and higher kernels.
>     It just
>     breaks the things and is not considered as applicable, because the
>     functionality
>     which improves reclaim process is in place.
> 
>     As for slow boot up time, it is another issue and not related to RCU, IMHO.
> 
> 
> Thanks for your help, I will  close the RCU-related bug report and file a
> seperate report for the boot/shutdown/reboot problem.
>
You are welcome! Thank you for closing an RCU report. When it comes to
a boot time issue, i see that user space is up and running and it seems
kernel loading process is ongoing. It might be that some modules during
inserting/probing take time. Like you mentioned, firmware related timing
issues.

--
Uladzislau Rezki
