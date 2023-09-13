Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6F479DF66
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 07:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbjIMFaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 01:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjIMF37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 01:29:59 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B04172D;
        Tue, 12 Sep 2023 22:29:55 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-99c3c8adb27so812045166b.1;
        Tue, 12 Sep 2023 22:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694582993; x=1695187793;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9F0k3qHLkCMs/58Mn5Z2HOuZhpX+vcMY742PpQ7DgqY=;
        b=NxC6X3BDiroU+aTNCrMBkqhl1IfL4qNA+NHJMAnJXpFrIlw8xtxZb7tBxtC8R9FnTx
         DXvKnpNd/UvSkGgX/7NYtERg/HstWG+ddSbJomhCgVHiVOQmFCU6QCm/LbauuRidVOR4
         c6YuaCtqIO1sl5wInaQThR71Vxrlx2kQGS9S8PGKPlAOJjekZNGwK/J8aQaa61MIsEKF
         Kf8Vn8WxC7MBCJUfh/ZP5AdoRMlv50EbG5wPRWcSGHth/eMpVSwAgYgWvs4PMYDLr8Nr
         6+pBlGh5ADQHvewEyjnPgIqVajm61IRiOsK6G53V1bQXgrsWw50I6SuXiL23pxuNrFpP
         XWxA==
X-Gm-Message-State: AOJu0Yz2nFyDww8x5m4MFfb03w0ss3StRdMLXD1998140HhdO6odYGLC
        xJpk1lfnMJHEHabaGJepTbkcjf0ZfME=
X-Google-Smtp-Source: AGHT+IH7zkPUbCc51X9k1dfLJdJvPxOGuqwx7twcRfLUH8NtpFNb2FbeN3HPRIbLMTRy7mz4EMH89w==
X-Received: by 2002:a17:906:cc9:b0:9a2:c5a:6c9a with SMTP id l9-20020a1709060cc900b009a20c5a6c9amr934560ejh.45.1694582993322;
        Tue, 12 Sep 2023 22:29:53 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709066b9200b009a5f1d15644sm7715294ejr.119.2023.09.12.22.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 22:29:52 -0700 (PDT)
Message-ID: <e74982c0-4942-1c46-1c53-6dd6e7677373@kernel.org>
Date:   Wed, 13 Sep 2023 07:29:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] tty/serial: Sort drivers in makefile
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20230912103558.20123-1-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230912103558.20123-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12. 09. 23, 12:35, Ilpo Järvinen wrote:
> Sort drivers in alphabetic order in Makefile to make it easier to find
> the correct line. In case the CONFIG and filenames disagree, sort using
> the filename (but ignoring "serial" prefixes).

Overall looks good.

I just want to make sure you considered the below, as you don't say 
explicitly in the commit log.

The order in the makefile defines the link order. So built-in drivers 
are loaded in that order. So are you sure your patch doesn't change 
order of some drivers which need to be in a specific order?

thanks,
-- 
js
suse labs

