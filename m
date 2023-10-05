Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FFA7B9F56
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjJEOVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjJEOTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:19:13 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF53E4C07
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 22:15:54 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c874b43123so4384485ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 22:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696482954; x=1697087754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H9nT5tLRN5qqmtXX+vtQZ11JSBruGv0fxOyk+moMln8=;
        b=kmvhdUxUlbnxq02vSii0ln+sRYRZs8Kw/1sWj+/uxLViHgqXPzWtYrJ7mkcCTALkY3
         FwfqubpOsL36Rlrsuv2WNylqzKPgSxEZCFHHAiDl+JClQvUJKWaGhTHZalsobCQhI81Z
         zO+aEQAsfALsJ3sF1n+9de8+HWThxVxuJvx7UVBpq8iH9so2uFV90xvZuFLFmyCg2S48
         vmdm4Krj4Kk3rRMjkSXE61p3PryftlI6DR9l33akDE/lcqzKErkeA9jEWzkIE5ZxFosa
         IyQr21FoxlO7mvkhu8J4rBHtwmcgt/Ji+BPfcxxQD1IAQB3BWLZaTgSYB8yfEsAuu6lX
         RxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696482954; x=1697087754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H9nT5tLRN5qqmtXX+vtQZ11JSBruGv0fxOyk+moMln8=;
        b=tkxtGv6k9z8jjE39Kwvqug7uosKEqINfHI5R6Dk46YM7nOsd0zWQm30m+XSf5W12Of
         Z+vt58WQk4V+wAG53/YXzwSIz15R5r7gv40nQG+er1weHmAXIf8/vAakZ+X4wWiwWiZe
         gsksDJq/KJKkeURYf9MYV9UDn2nsa3VfPKhQVsSWFc2WpexmeYskeGnX8EfY/odB0rI3
         mdE4QY6nkfh/d5Dk+I/gC/f6sWdqc2ZOgejNDXglqgIkGN7yL7j7tH/IjOqMgmrt7BtG
         0uo8NBQJ2wHtEnu9y9X4Tw58NWl9/vEri4L1FWczH+317AomdzgPUg29yq3fvWFg3hBX
         DzOA==
X-Gm-Message-State: AOJu0YxNOUzgZuSI4nvSRxdFF4Vj/zDx4WqXBdjE9VBTubPPTs85usve
        I8qeZ5U+OmnjN+F18xE3xNI=
X-Google-Smtp-Source: AGHT+IG0E0MClgQEMPm1p4gW05l/cLgh45hB65zPuXG48f5XxjBjvLGQ87pk67e720CBKvIJ65j8ZQ==
X-Received: by 2002:a17:903:2445:b0:1c7:4ab6:b3cc with SMTP id l5-20020a170903244500b001c74ab6b3ccmr5233304pls.54.1696482954260;
        Wed, 04 Oct 2023 22:15:54 -0700 (PDT)
Received: from [10.0.2.15] ([103.37.201.179])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902f7ca00b001bc445e249asm533587plw.124.2023.10.04.22.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 22:15:53 -0700 (PDT)
Message-ID: <3d4e0f62-35bb-4b18-a64c-191c88415032@gmail.com>
Date:   Thu, 5 Oct 2023 10:45:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs : fs array-index-out-of-bounds in txCommit
Content-Language: en-US
To:     Dave Kleikamp <dave.kleikamp@oracle.com>, shaggy@kernel.org
Cc:     linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+0558d19c373e44da3c18@syzkaller.appspotmail.com
References: <20230919155542.4354-1-ghandatmanas@gmail.com>
 <423182d1-3d75-4a73-9011-da24658a40cc@oracle.com>
From:   Manas Ghandat <ghandatmanas@gmail.com>
In-Reply-To: <423182d1-3d75-4a73-9011-da24658a40cc@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/23 00:46, Dave Kleikamp wrote:
> The size of the xad array can be either XTROOTMAXSLOT or XTPAGEMAXSLOT 
> depending on whether it is the root, imbedded in the inode, or not. It 
> is currently declared with the smaller value so we can use xtpage_t 
> within the inode.
>
> I had promised to address this, but haven't gotten to it yet. I'll try 
> to carve out some time to do that.
>
> Thanks,
> Shaggy

Can you guide with the workflow of how things should be done. I can try 
to work on it and resolve the issue.

