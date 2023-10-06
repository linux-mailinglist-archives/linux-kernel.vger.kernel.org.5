Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FE97BB5D4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjJFLDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbjJFLDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:03:44 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9931F4;
        Fri,  6 Oct 2023 04:03:38 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c00e1d4c08so25079471fa.3;
        Fri, 06 Oct 2023 04:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696590217; x=1697195017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+TRwFSu5xqtCS4GBmrR7m1FXCNdXTVhpoe8UmPcZTw=;
        b=fEMy6+Mg87KjdAke8wWQ9Ng83cC6weYDRG24sBLa/Aud5O7dLi2HXfs/3YLOD04dDB
         TNuwFIZuieZQ86uFjXEc3z0DLTxQk+d4nfru+k3/wt7thCfU0HVHKHM0z985CmLCRu75
         tIwg2WmiJRL/cVfaUF2IjQ/zXhdw5rKuHYXJ0IizY8If+R9zsdJBaJRIggV5q6w6uGme
         48/U/zqYBIOTBNTMLMg5RscLkRFMGWtsZcC7jKsDN0tvb9w94aCTtt/D6SZasusNqqhz
         1cWIhLBIZv7pUUVnOqWg9TrA9YaRPv6Q5EfTc6Yg2XiGGV4nPGrfvt6RvTAhzI/LxuUo
         MsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696590217; x=1697195017;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z+TRwFSu5xqtCS4GBmrR7m1FXCNdXTVhpoe8UmPcZTw=;
        b=lvzojYqv47VK+pNPJ8ANv4t187R9EV0zSGQxxhufKuaDJFKaGQEe1E/OJd/QH7ifKZ
         K3ZBznNE7/c60zS7GMfanAw8uSCsU5+SWIvyhqjl1yLPbsadkblTV7rlSMbFySvt10Aq
         ZVlPzoms4kKNnQWKi6UqKENWHdLJV83rbz42xce2oIgcT2s1+GuRo7LKcFYGt+ANUMPA
         k6JBx9XoremhUfzjixPlZyc/xp6SyQCKc8HNiCqquScGzB+t5Kmi3qLzwpR4+8JeCjMA
         IaWdZUGdsGgYgDIt/qoYCtKzo9od0LQPnk30XXOQXG5HnbrnyGALpMC1X6mokJJIJWJf
         zvLw==
X-Gm-Message-State: AOJu0YxftroErFa0MsR0aaQQnp8DqupZis5EzcILvv5NYNFAHWE+YVpf
        E+BwanErd5EkvoN6YVmkPN+lVOUucWQKng==
X-Google-Smtp-Source: AGHT+IHbJIkrY2O3p6RlIgFAJE8d2tiwnAaepkLjqi+oST9E8RjdFvBeCrjedWjwJRAvUsWAv5tVTQ==
X-Received: by 2002:ac2:5de2:0:b0:4f8:ff52:93b7 with SMTP id z2-20020ac25de2000000b004f8ff5293b7mr6840655lfq.30.1696590216741;
        Fri, 06 Oct 2023 04:03:36 -0700 (PDT)
Received: from [192.168.0.9] (88-114-1-11.elisa-laajakaista.fi. [88.114.1.11])
        by smtp.gmail.com with ESMTPSA id u7-20020a056512040700b00501ce0cacb6sm259934lfk.188.2023.10.06.04.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 04:03:36 -0700 (PDT)
Message-ID: <48b3624d-ef0c-96e7-ff3d-9f34eb1caad8@gmail.com>
Date:   Fri, 6 Oct 2023 14:03:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     herbert@gondor.apana.org.au
Cc:     agk@redhat.com, bagasdotme@gmail.com, dm-devel@redhat.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, snitzer@kernel.org
References: <ZR9l446ndB4n1Xl4@gondor.apana.org.au>
Subject: Re: [PATCH] dm crypt: Fix reqsize in crypt_iv_eboiv_gen
Content-Language: en-US
From:   =?UTF-8?Q?Tatu_Heikkil=c3=a4?= <tatu.heikkila@gmail.com>
In-Reply-To: <ZR9l446ndB4n1Xl4@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 09:41:55 +0800, Herbert Xu wrote:
>
> On Fri, Oct 06, 2023 at 08:04:18AM +0700, Bagas Sanjaya wrote:
> >
> > > Git bisect lead me to:
> > > # first bad commit: [e3023094dffb41540330fb0c74cd3a019cd525c2] dm crypt:
> > > Avoid using MAX_CIPHER_BLOCKSIZE
> > > 
> > > If I git revert e3023094dffb41540330fb0c74cd3a019cd525c2 on current Linus'
> > > git master, the issue goes away. So I'm personally not all that affected
> > > anymore (if I'm ready to compile my kernels from now on), and I understand
> > > that you have no clear way to reproduce this as it seems strongly bound to
> > > hardware, but seems like this could point to a potentially serious security
> > > issue since it involves both crypto and undefined behaviour.
> 
> Thanks for the report.  Sorry this is indeed my fault.  The allocated
> buffer is too small as it's missing the size for the request object
> itself.

Thank you for your prompt fix, I can access the volume without issue now. :-)
-Tatu

