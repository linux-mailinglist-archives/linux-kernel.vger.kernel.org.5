Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF85A777DEA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjHJQOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjHJQOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:14:48 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8B62723;
        Thu, 10 Aug 2023 09:14:45 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686f94328a4so804284b3a.0;
        Thu, 10 Aug 2023 09:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691684085; x=1692288885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WW7xl5RfavY1jtjAqVUV0opgpVMtWFJH0DTTpNeR8g=;
        b=U6c1d6IfFu/0q/cT8XTEBz4/J6WrJ/1nZBCJFpveWKFv01DrUOALIB9TLTyJ8EBS5i
         YV2j3OKNSgzoqqbTjAi/Y3lrE6Suhrwgf9MwSpBUqsquC94Bx5r5bFSj9OmEDQFjR08n
         eyXlECqY4uuy/7eQWLsxke5WgG8fu/8Mqmk7Qh6IuCZuhsqZxZQb1P4Fh1sQPuclRJfD
         8r8QG4cFpUI3i+y3dXU0KeoUfw8fu1jydE4t1/jayWcD1L0HrgDZGbdjTTScG9iRsaYm
         yL4dofSR9eLkMXVk4S7FAtYPSlyd1AAq9XcKj2asZGxecyd0u//RwIwop0kTl7Ip8DZP
         thCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691684085; x=1692288885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WW7xl5RfavY1jtjAqVUV0opgpVMtWFJH0DTTpNeR8g=;
        b=Dn/GH78Zk5GnwfgpSSP4ijTZ1XZ9FTh86mJasjIOQHW6gblO0JMaeEFb0tQ1S3Ql2f
         R9zTDnnOmHT+C+G/JI1+LCDxUyUmTl62NgCpQdkDrTJ7JjHtLRjxAq58CWgTZ5J+9P+z
         ObfFzVclg1gdeEf2K7bBlnUMEr33zp743IX61WZDBnJVgN2InIT3/H+6E7nc79MqrNGg
         84CVe6pAZ1DpbNzkVuTfvfFgGbs+HtBvCFEnj4M2eDJImT1fW889QvNg9CYsFRc0ulTS
         Yah3PWlbtwfZMImI9K2ToAnI+/MPltWI9ufV1ytn83D8uT1dUuvVMmyR8OyBxIBwGkxw
         Oj/g==
X-Gm-Message-State: AOJu0YzvHBpcyjVgJD8HnTu92gLQ/dXNIU86PpKqrjiDri9mllEg0czR
        8HGEgxw+l6ZHaWfzxNNh7So=
X-Google-Smtp-Source: AGHT+IHfBKBXihlTWr0wq5ROJdmyqocaQiRSYDUdVo/El5ivmKdKqviKNuiYo8DgaZ6ARMrGf6EgIg==
X-Received: by 2002:a05:6a00:803:b0:67f:830f:b809 with SMTP id m3-20020a056a00080300b0067f830fb809mr3329046pfk.3.1691684084979;
        Thu, 10 Aug 2023 09:14:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bm16-20020a056a00321000b0063f0068cf6csm1708556pfb.198.2023.08.10.09.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:14:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 10 Aug 2023 09:14:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/127] 6.1.45-rc1 review
Message-ID: <a800f7e3-5a59-4dba-afc8-d3ae5f39b058@roeck-us.net>
References: <20230809103636.615294317@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 12:39:47PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.45 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 153 fail: 4
Failed builds:
	loongarch:defconfig
	loongarch:allnoconfig
	loongarch:tinyconfig
	loongarch:allmodconfig
Qemu test results:
	total: 521 pass: 513 fail: 8
Failed tests:
	arm:fuji-bmc:aspeed_g5_defconfig:notests:mem1G:mtd128,0,8,1:net,nic:aspeed-bmc-facebook-fuji:rootfs
	arm:bletchley-bmc,fmc-model=mt25qu02g,spi-model=mt25qu02g:aspeed_g5_defconfig:notests:mem1G:mtd256:net,nic:aspeed-bmc-facebook-bletchley:rootfs
	<all loongarch>

loongarch failures as already reported, introduced with v6.1.44.

The failed arm tests crash in f2fs (again - previously reported
against the v6.1.43 release candidate).

[    6.685458] 8<--- cut here ---
[    6.685593] Unable to handle kernel NULL pointer dereference at virtual address 00000034
[    6.685725] [00000034] *pgd=00000000
[    6.686010] Internal error: Oops: 5 [#1] SMP ARM
[    6.686209] CPU: 0 PID: 194 Comm: seedrng Not tainted 6.1.45-rc1-00128-g02a4c6c322d1 #1
[    6.686350] Hardware name: Generic DT based system
[    6.686467] PC is at f2fs_issue_flush+0x160/0x210
[    6.686821] LR is at f2fs_do_sync_file+0x7c8/0xaa8

Guenter
