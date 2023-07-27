Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1758F7650F2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjG0KXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbjG0KXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:23:16 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A771319BA;
        Thu, 27 Jul 2023 03:22:59 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2682e33509bso598766a91.1;
        Thu, 27 Jul 2023 03:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690453379; x=1691058179;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SOS+4iMvfIqSqMDfD009RckKJ93j4gnKYZMgqoKrYXA=;
        b=qiqhDJsW68fry/uR4TLtmce/93goZBVsCTW8/DS42XKrLFR12FbIPDUs/wX3Yqyn5S
         5OdxFeBD4XCEIGOAYMgZ0GuzRaR9jFmPCE4RYxUbVQ+isd9le6c1p/ELlzV3yL/ovcbw
         NQXOdhIfMlDW7KY0YxnS3VyZxghvjzx1rwhblxhg0WlfylsY8gHUrfDnE2IuMmJSfZee
         twAcIanP4ZNZFQIK9W+xP5YOi/+9nuKkVLfz+TXge9geGixVqcuIF76+sqSHZQU3xYLo
         XMc+3Ps+jm1iaYHENJfTht4DHLsNr2rNomckm2KKF39AKAVELwIfWf9HjBSQL4qWjTeq
         Q64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690453379; x=1691058179;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SOS+4iMvfIqSqMDfD009RckKJ93j4gnKYZMgqoKrYXA=;
        b=ech19tpavVYwtIrnhVS0mLRCxbOFzgPI4+Lcjgyfwy4fhb7mXzmbfagp7y1cO8eNph
         LKX2CQVZbOGWEI5OqElEv8EZLDn7x3T6rJGo3FOMBl9Os8sHWGQcqP8oODjkhWhenCDI
         MU6WKLxQCr+B3mBNKmbEoPcMzqgxrFVwgjnPgPtQDhJEA6Kl5NSUMTWR3JlyV80FkOgi
         9rxUD1oqpeuX01bj8AghVfY68Bkb+4u/7+ADb6JPRRceHyya23yXgLug9QRq/9QQtJ0Z
         VB0OQQ3lzfzfjnSWtGUA7w2t7lkRKf3lQxSNgGPd6UT14qMcRbFQnbcoGZL2KgZTpLvr
         wxbw==
X-Gm-Message-State: ABy/qLabrsfhMZUr975ia8ZZ/5Sci+FOPg1PHhbcy4f8qi5JHdvh4/89
        DsRpoh2l4U8NwrvBVkljyyM=
X-Google-Smtp-Source: APBJJlFddPx3cGLNjyXpDC378SkH9rHKbY7ad9h5Wq6Htdvyb1Wp3rP77aG0mAzX2jor48p7Ca+OCA==
X-Received: by 2002:a17:90a:114f:b0:25e:bd1d:4f0c with SMTP id d15-20020a17090a114f00b0025ebd1d4f0cmr4156327pje.10.1690453378929;
        Thu, 27 Jul 2023 03:22:58 -0700 (PDT)
Received: from [192.168.1.121] ([65.129.146.152])
        by smtp.gmail.com with ESMTPSA id g4-20020a170902c38400b001b85bb5fd77sm1243108plg.119.2023.07.27.03.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 03:22:58 -0700 (PDT)
Message-ID: <86435987-734e-c6c1-a857-1ba80da709fe@gmail.com>
Date:   Thu, 27 Jul 2023 04:22:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Scsi_bus_resume+0x0/0x90 returns -5 when resuming from s3 sleep
Content-Language: en-US
From:   TW <dalzot@gmail.com>
To:     Damien Le Moal <dlemoal@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     regressions@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bart Van Assche <bvanassche@acm.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
References: <0e272abe-292d-d58f-cf80-55868e793abc@gmail.com>
 <6b66dd9a-8bd5-2882-9168-8e6e0848c454@leemhuis.info>
 <c70caa9e-164c-fee5-8f85-67f6d02373ab@kernel.org>
 <b0ed86e0-3e4a-d4d1-7b9d-c57f20538a80@gmail.com>
In-Reply-To: <b0ed86e0-3e4a-d4d1-7b9d-c57f20538a80@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I managed to fix the patch file, guess the formatting messed up a bit. 
So will try with those patches installed.

On 7/27/23 04:06, TW wrote:
> I retried on 6.5 rc3 without the Nvidia drivers and still received the 
> same error and going to try for the patch next but got a malformed 
> patch error on line 6 for the first patch for libata-scsi.c. The other 
> two seem to go through just fine however.
