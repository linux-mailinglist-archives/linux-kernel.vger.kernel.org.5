Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D847CE20C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbjJRQBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbjJRQBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:01:18 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88C51AB
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:01:07 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3574c225c14so9613325ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697644867; x=1698249667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Re5m8iHz1XkyNebK2Y537dUrlrxbONrU8mRiJflAZPo=;
        b=CxAnCd4XG67W5bD5ha0scQajb4NXV1TZKbHIkCLLW+P/uVGv2ctWgp9+VIh0dpy/ke
         DaImFBWNejMsNOmF8Hc06J9IQ3PNW0oSiweSwQqmjDPgMW/LDMwRQj230n02lIFaleY/
         KhCDN2AyVTF9l+tdI4MS0Dn0dd/k21UBEjNRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697644867; x=1698249667;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Re5m8iHz1XkyNebK2Y537dUrlrxbONrU8mRiJflAZPo=;
        b=aTHd0ZOPS+CdiICl8MCEarijECcTiCYHtIT6iw5c+Legswmuvh0e2EnmeX9Z/V+4vg
         r+Ihl8kvLlPzGqEeIW/ITZvtXuWqHFWYz8/PzUYmUUoY61v9CArTKouaqv2L4ZPgVa+E
         N/Z3uA8u7BoXSVGCJZk0dmd3LhqwAmMnes9jR47Ouh2rPmkrK9KbR8pQx2jgZ7tJlJ0v
         05HE0U1Y8ZXujSES/9nDjbqIvNssFuIAIAP8aFzK508IUhtPQLxuKlp/pzGBsXIayj7J
         dHgB5Ft9XO8FUocY5m2SIrRfvjEk02CoA81Q/YW8sTSEB5URpQ4CfvYjp6DncmR/kV/S
         W8/Q==
X-Gm-Message-State: AOJu0YznORDDsmGFhJt0pj55vNyuIJZTfIfN5CoIqL5ZD7ZJJQPa3poH
        LK1wC5XT0Sb8Wlzya2zrE2N1BQ==
X-Google-Smtp-Source: AGHT+IHQ7HshmB8YgHYdUd4C6uc7bjRahbkcttwic0Tc57CdqXFte0eOKR5c4D5+bHEQE4VseCFOyw==
X-Received: by 2002:a05:6602:1652:b0:79f:8cd3:fd0e with SMTP id y18-20020a056602165200b0079f8cd3fd0emr7754261iow.1.1697644866906;
        Wed, 18 Oct 2023 09:01:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h12-20020a056638062c00b00459d7c3dcf3sm1250235jar.115.2023.10.18.09.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 09:01:05 -0700 (PDT)
Message-ID: <8482e2c8-9ee9-4207-9ad5-b2e66dd38b4a@linuxfoundation.org>
Date:   Wed, 18 Oct 2023 10:01:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the ftrace tree with the
 kselftest-fixes tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20231018123014.65073211@canb.auug.org.au>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231018123014.65073211@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/23 19:30, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the ftrace tree got a conflict in:
> 
>    tools/testing/selftests/user_events/abi_test.c
> 
> between commit:
> 
>    cf5a103c98a6 ("selftests/user_events: Fix abi_test for BE archs")
> 
> from the kselftest-fixes tree and commit:
> 
>    cf74c59c4fc1 ("selftests/user_events: Test persist flag cases")
> 
> from the ftrace tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 

Thank you Stephen.

Steve, how would you like to handle this one. I am planning
to send fix to Linus this week to be included in Linux 6.6
in a fixes update.

thanks,
-- Shuah

