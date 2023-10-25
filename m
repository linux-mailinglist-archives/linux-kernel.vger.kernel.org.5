Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505137D5F21
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 02:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjJYAkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 20:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjJYAkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 20:40:20 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CC5B9;
        Tue, 24 Oct 2023 17:40:18 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5ac865d1358so3301291a12.3;
        Tue, 24 Oct 2023 17:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698194417; x=1698799217; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oy3ZCxUaOTBccOyYOfscwNqRTq+2Vm1/fUY8yV/tkg8=;
        b=W+Nc25dhOf2YX+DRj8QkD0QqO36prwVZnR7YOrbIssk+kjOZEJn6YrO1sEGaRQhcZz
         ItXaYLnVWdqrW6yx0TtfhSluUWmbQXLBptifDVOvC216B1lLK1zSU30yKO5sekUAsyF7
         AFih/nN8ilPHbTUVseY3bRukHkkGYTSHUdP1anS+6hqam/G9hqcVjdyLQUQtZ/uf7k1L
         v5Bqlc2eOcylg1GA5GXtW9+TIzea/FfYYfdOk7r1UFM7hxWGL5r4H4Mt4Td0dADY7iaU
         6qAX3GrtIaSESXcCcnYd0l4r4hOyoe7FSmCr5MwuPV/OwagZtDROKqMVPWUpmFqzQt6u
         eMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698194417; x=1698799217;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Oy3ZCxUaOTBccOyYOfscwNqRTq+2Vm1/fUY8yV/tkg8=;
        b=uc0p4lCKIjcYb5vWJ1+cKUlACgepVfDd/4Tk7Qe+HQYpX4HAFfPPraeWcKkty49KF/
         jCMYeAco10NDuQA3E2t7m2sHCVPudkGv7IGJW7SX1+OAwrsusFgWakI3FDkZZke5Br+6
         J48fJKN5JvC4/OWN3QzhLt6dAkLNk3bFwWKm11x1wJS/bJDMBK5O4Zp/OUw2rPiS73NP
         o58id4Kuru3gJeCLDfVj+tnyMBXA5SMY2lQV7Go6WfC8OCqrxCXJdXYgLDL0xzTAQlIS
         wsjyvNSInDwA8wSPNlCKvclB/an3FAmyhUzt3u6rXDt71esdNAtwojWws1xIoS3I16hc
         CU+Q==
X-Gm-Message-State: AOJu0Ywb7VSnC9r2hVpos8u2ySMxe4W9z1no2WCdEKcRMNILjTtV3vjS
        N5i9YI9f95kheUF1naFLFAD+pSPJjY4=
X-Google-Smtp-Source: AGHT+IGNKaEZC7W8MQaC26f2qUIAnpX/xebK0G7PQ8bDsxQN4pRfDpZ3iswNsTR1vE87PzfChReSdg==
X-Received: by 2002:a05:6a21:7182:b0:17d:ed85:541e with SMTP id wq2-20020a056a21718200b0017ded85541emr4333239pzb.45.1698194417473;
        Tue, 24 Oct 2023 17:40:17 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id ji18-20020a170903325200b001c99b3a1e45sm8024928plb.84.2023.10.24.17.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 17:40:17 -0700 (PDT)
Message-ID: <cd397c88-bf53-4768-9ab8-9d107df9e613@gmail.com>
Date:   Wed, 25 Oct 2023 07:40:11 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux IDE and libata <linux-ide@vger.kernel.org>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Tejun Heo <tj@kernel.org>,
        Totallyreal Name <kotversuchung@gmail.com>,
        loqs <kernel_bugzilla@entropy-collector.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: bbbf096ea227607cbb348155eeda7af71af1a35b results in "dirty"
 shutdown
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla that seems to have been
handled already there [1]. Quoting from it:

> I have noticed that after each shutdown SMART would log +1 on each raw_value of drives that count power related issues.
> 
> Here are some of the smart values where i noticed increase among different drives
> 
> POR_Recovery_Count 
> Unexpect_Power_Loss_Ct  
> Power-Off_Retract_Count 
> 
> That doesn't happen on previous Kernels.. and it stops as soon as i switch back to LTS.
> I seeked through the Bug Reports but couldn't really find the issue. So i don't know if this has been reported or patched already.

Another reporter had found the culprit:

> 
> 
> This has been reported as being introduced in stable 6.5.8 [1].  Reverting commit 	bbbf096ea227607cbb348155eeda7af71af1a35b is reported to solve the issue [2]. bbbf096ea227607cbb348155eeda7af71af1a35b [3] is mainline commit aa3998dbeb3abce63653b7f6d4542e7dcd022590 [4] which was introduced in 6.6-rc4 which matches the original report.
> 
> [1]: https://bugs.archlinux.org/task/80064
> [2]: https://bugs.archlinux.org/task/80064#comment223100
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=bbbf096ea227607cbb348155eeda7af71af1a35b
> [4]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aa3998dbeb3abce63653b7f6d4542e7dcd022590

See Bugzilla for the full thread.

Anyway, I'm adding this regression to regzbot:

#regzbot introduced: aa3998dbeb3abc https://bugzilla.kernel.org/show_bug.cgi?id=218038
#regzbot title: dirty shutdown due to disabling manage_system_start_stop on SCSI devices
#regzbot link: https://bugs.archlinux.org/task/80064

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218038

-- 
An old man doll... just what I always wanted! - Clara
