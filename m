Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2522A78DFE8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241405AbjH3TK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343795AbjH3Q7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:59:09 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149F919A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 09:59:05 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-26f38171174so3676008a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 09:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693414744; x=1694019544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wgkRy2fHXk12I8uXbR8oF1JVRCE6YBpekWqJS8+t/SY=;
        b=d4yyZUmyNTyacw+phcl6hkaLY+5PT1bZ+CtCRULah9RdxCdSif5Lgh6vytmZ9biVhm
         2cwfO2HMdmxTRb1Mv4vJ8kWFVuqIsmRvebeOxQOqVAovVweaP0e8263tAX1PnYZ4lkk2
         /9XJ5+enIeYnPidOw1rD7Q9TJ1KhRMMeDlbDdZqRMZ+cRieODsyjOSrTX8abxsGs5usk
         0IoIcN6vKI/6XrpsZL/ry0PX5PepOVdmxorhcTDsQwehjtby11PDZUSmYnnSea1f9Ids
         wTHUj3eLb74jZD1d5eqnDCcOPF3FtPz2NGSI3nOR5eA+wMMrnxwVeklZaEGIyOBjqpYt
         uT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693414744; x=1694019544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wgkRy2fHXk12I8uXbR8oF1JVRCE6YBpekWqJS8+t/SY=;
        b=XoxlDFTHdX1KsuCA+XqVaFn033LofBjf3SKb8vL6amssZ/NHsn0XvkBbO5GBQSIc6D
         IkMgQDvfykltjFOO/irULXvQnVic9bJQktZMflj0PgxkE7iAMWD+AaCfEtgz6x0qCQRY
         wCEIpjBw7Bq64UCNj1l8sSloTCIQxyaUp4DPgD0JEMuE0DtyjZ95kEVNhsQjJTiLyHjZ
         x5gqXVAb+4NR6zyYX2t9hN3VrOZTFm12Ibi77eWSVctj9tuBCeELr8mugrDH2YoYZddw
         W5nAd/D5n/PWATT/LHRNW47Rl1NK16Ir0lcL6O0BcsF9JxJgwL+ma1lwZc4zeqkVlYEm
         vrzw==
X-Gm-Message-State: AOJu0YxqUJRr/tdp6BKeygFte05eUfxhpnP/PAzSpWdbnipCQYDZsYYp
        5Xmc/xoLos296scDsUX9qVE=
X-Google-Smtp-Source: AGHT+IEiBWKa3xloyf6eL2PYGoBgEH0g8SDOhM3inWHe4UsSlpRC7tRISmG4yyxSsF9If5WjYXUl6w==
X-Received: by 2002:a17:90a:7345:b0:26b:4a9e:3c7e with SMTP id j5-20020a17090a734500b0026b4a9e3c7emr2738462pjs.4.1693414744444;
        Wed, 30 Aug 2023 09:59:04 -0700 (PDT)
Received: from [10.0.2.15] ([103.37.201.174])
        by smtp.gmail.com with ESMTPSA id d13-20020a17090ad98d00b0025bfda134ccsm1496364pjv.16.2023.08.30.09.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 09:59:03 -0700 (PDT)
Message-ID: <e655b722-f610-99dd-16c1-ed3235860a80@gmail.com>
Date:   Wed, 30 Aug 2023 22:28:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] jfs : fix shift-out-of-bounds in dbUpdatePMap
To:     Dave Kleikamp <dave.kleikamp@oracle.com>, liushixin2@huawei.com
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+91ad2b52815a08caf4ea@syzkaller.appspotmail.com
References: <20230827050513.364567-1-ghandatmanas@gmail.com>
 <edf10660-2e8a-4f5b-8eb5-16038f8adbcf@oracle.com>
Content-Language: en-US
From:   Manas Ghandat <ghandatmanas@gmail.com>
In-Reply-To: <edf10660-2e8a-4f5b-8eb5-16038f8adbcf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I checked for the v6.5. Its fixed there.

On 29/08/23 23:19, Dave Kleikamp wrote:
> On 8/27/23 12:05AM, Manas Ghandat wrote:
>> Currently there is no bound check for number of logical blocks per
>> page (bmp->db_l2nbperpage). Added the required bound check for the
>> calculation of dmap.
>
> This should already be fixed by 11509910c599 ("jfs: jfs_dmap: Validate 
> db_l2nbperpage while mounting")
>
> Can you please verify if this problem still exists in v6.5?
>
> Shaggy
>
