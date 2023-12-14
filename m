Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19530813713
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjLNQ5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjLNQ5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:57:30 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6378FB7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:57:36 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7b709f8ba01so72330639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702573056; x=1703177856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bF6JAIGkdcWEDAxYfIlQw3OSyrt6nxRKSkcWVcaayZU=;
        b=ez7aJSHpNmVv1H/2VNFP+XRnCwtwjnJuPlbf1RujMYUaS5TwF5i+UNRIG0kGeCIrva
         E9BiVSdjOhuv0m0V3fqlTFbkLAjIN7e4RY1MPfeOiNCCmYJsZNs8jQ+4TBeae32aKCZD
         UljhMivp5KgHETOdFfEWvUogrhyAC0vXh/sEkILqKeKalS5IfnE4yVo4ICVAWmn9r4Gq
         lAhIDibydYmaCd1rPHNETO/INYLBbsOUlTGdAqWHuwVX3ADMbqm6s3p+PTTYLRjlhwNs
         6BBlw9bVdDYlgFbADzocb/SBtRkDmUuuEV947Q1DC0O+IQcC68X4GmhGATOCDaE4a6Ga
         ovCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702573056; x=1703177856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bF6JAIGkdcWEDAxYfIlQw3OSyrt6nxRKSkcWVcaayZU=;
        b=JWqcM9r73aD9CGakSBYxOy0On77C5SlLU2o0RnQNXoWhBQpNvUzj2aZVeclq/rcoQj
         LDgHstilibWC6xSgeqpBFnsrNLBTFnDQl5yEau2CMr1ztB5jHEN0pX0wKw2y19PRvc34
         ZYrEj4GRX4eXArx3A0yE9c9IVB9qqeftHqbgYEAkjNSrvGATSa+N8vFojXM5ZHqWaCMY
         pfhZbfKobKNAsSttSBkvRXK1DkarhZymH/T+uMcgjtBp5odxP4sgxYC94KKBDegvAyk0
         nG5Ht82725xMyXhTC/+pDigAvuU5CKadrChgfkJlc0rvJEcEiBayltSRoFdXyjyPwbUF
         4lFw==
X-Gm-Message-State: AOJu0YzzsVMoE/ebOWDq5UK6jiOlqMg5u7aBiWA1BBqbMk5FesL3cvtn
        ejyqY2WncAgHezizKK8bZ7YdgQ==
X-Google-Smtp-Source: AGHT+IFlw+XRTrT7e71YKSTcDQk//pRdpkg0t26kRH8ZiJIsDpZhk7PFQa8ipkgdwGtQW7W2DeCpYw==
X-Received: by 2002:a05:6e02:1bac:b0:35f:692e:2049 with SMTP id n12-20020a056e021bac00b0035f692e2049mr8161692ili.2.1702573055728;
        Thu, 14 Dec 2023 08:57:35 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bn14-20020a056e02338e00b00357ca1ed25esm1231116ilb.80.2023.12.14.08.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 08:57:35 -0800 (PST)
Message-ID: <3d025aeb-7766-4148-b2fd-01ec3653b4a7@kernel.dk>
Date:   Thu, 14 Dec 2023 09:57:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 06/11] net/smc: smc_splice_read: always request
 MSG_DONTWAIT
To:     Christian Brauner <brauner@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Tony Lu <tonylu@linux.alibaba.com>,
        Ahelenia Ziemia'nska <nabijaczleweli@nabijaczleweli.xyz>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
 <145da5ab094bcc7d3331385e8813074922c2a13c6.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
 <ZXkNf9vvtzR7oqoE@TONYMAC-ALIBABA.local> <20231213162854.4acfbd9f@kernel.org>
 <20231214-glimmen-abspielen-12b68e7cb3a7@brauner>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231214-glimmen-abspielen-12b68e7cb3a7@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/23 3:50 AM, Christian Brauner wrote:
>> Let's figure that out before we get another repost.
> 
> I'm just waiting for Jens to review it as he had comments on this
> before.

Well, I do wish the CC list had been setup a bit more deliberately.
Especially as this is a resend, and I didn't even know about any of this
before Christian pointed me this way the other day.

Checking lore, I can't even see all the patches. So while it may be
annoying, I do think it may be a good idea to resend the series so I can
take a closer look as well. I do think it's interesting and I'd love to
have it work in a non-blocking fashion, both solving the issue of splice
holding the pipe lock while doing IO, and also then being able to
eliminate the pipe_clear_nowait() hack hopefully.

-- 
Jens Axboe

