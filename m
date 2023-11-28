Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B1F7FB093
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbjK1CtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjK1Cs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:48:59 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC7C191;
        Mon, 27 Nov 2023 18:49:05 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b8382b8f5aso3148106b6e.0;
        Mon, 27 Nov 2023 18:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701139744; x=1701744544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGzzlldCIGpuhAuCxitruslxNscpW2jyqRqhKkOYFIk=;
        b=ks3a+9LQ/7rNbhG8dC5OEMK8C7vEGZgBnZOUVQObJUod0E0SbUna67f0DqhCsKJxnI
         AImK48ivi7i9uozJM7Cy2QsiEIjlDLhaZ7hv26yquJVqKXVemYt729/jjxu5PmC0B4B6
         1hHJ0fBrYB6n2WAK0XeibrUvvApa1uzI9R942eP/navoP20JFP6O4jSHU/+UCpISTzSB
         XOS47HWfPHnf9a3upabcQom7F0Of0UycqCY56WruTHu6YYMtxfT6CgoL1BBSNrdMUE2l
         DgRMKB7FU4/hVD9DRXnMzSak2qnn1AhQiQNFGdZtJlTCkm3PVm9bfVP7GGyvjZHgxypv
         KjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701139744; x=1701744544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGzzlldCIGpuhAuCxitruslxNscpW2jyqRqhKkOYFIk=;
        b=Laj24a6XMJF8KAf8TfSgRfdRFZ15xc8kG+cp87qe7MznoTTSvJVFRHTnKd0wNBSfWq
         zvswEv3TjHgTlWeF+V/qdkcbyzKLrRubpznDOsHodmNDsEU0t436vvHlrQC9b8SoD76h
         gbDkO22B3uZ8iVy9fQJSFlWRQx9YUkzmWOCMS5eA4WhkUaXo9mvy6QSe/W0GJGA9eqY3
         rxJE8ZS+y4eyVIlk/LaWp1Vy6OXJAlMKVB4MI38U/rIQsckZqIx5uIToDkHAcwo9qjIT
         +t1R3dQMQmpB9kJwuFTcZDBrXPogZ9np5iGAaYw8z0V8RPlS1QEzmkvi4O/sshJK2MBI
         Q84w==
X-Gm-Message-State: AOJu0Yw9ouMyNXaq80NrhGDfloievlsTgrdASw5pShcBHwHFoqGwTPxt
        luozopl2ZOtplX40o+Fa4NM=
X-Google-Smtp-Source: AGHT+IG4l4bS6v+dvbF1ZzsJcK8uzNWexFCn5ZnNgR3hhozpbgaFS8HVLeM0QcTYSw8hPF0wSKzYjQ==
X-Received: by 2002:a54:4885:0:b0:3b8:402c:7072 with SMTP id r5-20020a544885000000b003b8402c7072mr17322832oic.25.1701139744530;
        Mon, 27 Nov 2023 18:49:04 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m6-20020a0568080f0600b003b8459f2ec5sm1689951oiw.55.2023.11.27.18.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 18:49:03 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 27 Nov 2023 18:49:02 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 4.14 00/53] 4.14.331-rc2 review
Message-ID: <59fb7a4c-1a68-425c-9f47-f0c1cf09921a@roeck-us.net>
References: <20231125163059.878143365@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125163059.878143365@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 04:32:43PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.331 release.
> There are 53 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 27 Nov 2023 16:30:48 +0000.
> Anything received after that time might be too late.
> 

For v4.14.330-54-g0957336c00be:

Build results:
	total: 139 pass: 139 fail: 0
Qemu test results:
	total: 440 pass: 440 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
