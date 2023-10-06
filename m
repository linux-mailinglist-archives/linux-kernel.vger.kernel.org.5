Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C2C7BB1C8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 08:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjJFG5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 02:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjJFG5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 02:57:24 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C85E4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 23:57:20 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c6219307b2so13238345ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 23:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696575439; x=1697180239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ltCjm4aJUWe9aYqASEplzIRx3exF5lO5oefAHyj9uWI=;
        b=Kq6YVFnnFCOVf43HPBclDrsBIPDxha4hoT8FeWjj/0a2RWS3YiBnLiJzkUgvG4wXgm
         h5WOmgdUVg5dDHzfqx20dlGhoZ/lSgbFIYRiZlJSBCUgs76VPsX+yZchcez+pzAM+Pem
         nfZmDQ77Qmrca7TYJrMkEZrwx6K+7yrqb6MweCd5qLErWwhBeEOPQJWKGfEoGb/USIwr
         V+C1+RuV93UmMDdQLXhtvfoXAJrhlDAgotK0eeBHIsy/1CKsyZvm3aZPR2mnEYy1EBj3
         1Zi4WR7Kbfa3wdcB4IZuVs61dqcovE/F5Ec4UjwuEvB7F4nFC3JISTQxjfdhSApFZsid
         r1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696575439; x=1697180239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltCjm4aJUWe9aYqASEplzIRx3exF5lO5oefAHyj9uWI=;
        b=FxdaPoth0PBCKjR49/iNJ5/MjHz/eM+tRQQZd21zxlS77D8bSenyNnoLxLPSys/Cgi
         j2DRHHoWsHYz2+gj3mfvWua5aDD1C1xSnmqjG0A1WVUj2mqasgnhvvp37/a2eC+V2kT7
         C4FQuIfRrFIysk+5dm9osAkW9tEHJaZBtO7zaLbE9/qlkHsJ2T2hV3yWupS6tPkR5Iml
         Is8k4cLABMEh4Vn89iFzzIsZJUGv+p4Xrsnjypp6dvbpPO7fvmGTULUNT5q5xcyoPTqh
         BY8nnhoNSe2h8vMi8LhxijuFK7mda0Eeww2Ji5X3urTpwA7zyNnaF5G8Ial+IUFV5hP+
         GPyg==
X-Gm-Message-State: AOJu0YzJOVU81jFuamxmbnNKU2GMo2Qd2QhiUI5GbT9YZ3JOhFPhSz6s
        buO5R875ZJB14ySJNcZZUfINkFmhz60=
X-Google-Smtp-Source: AGHT+IGqQwQOB9t6/yYKRaS6b8thQhpGRr5Dk8tWrNhV15C8CICkgfRtYX3GSYgryu7yNxfhJNi1eQ==
X-Received: by 2002:a17:902:ecc8:b0:1c4:29dd:2519 with SMTP id a8-20020a170902ecc800b001c429dd2519mr7615049plh.67.1696575439280;
        Thu, 05 Oct 2023 23:57:19 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id q1-20020a170902a3c100b001c61512f2a6sm3035443plb.220.2023.10.05.23.57.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 23:57:18 -0700 (PDT)
Message-ID: <0802bc5a-9fb0-433a-8491-47806cc7c549@gmail.com>
Date:   Fri, 6 Oct 2023 13:57:12 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bisected] PowerMac G5 fails booting kernel 6.6-rc3 (BUG: Unable
 to handle kernel data access at 0xfeffbb62ffec65fe)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Erhard Furtner <erhard_f@mailbox.org>,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230929132750.3cd98452@yea> <ZR9esG8H17LY2KOX@debian.me>
 <ZR9gkZKafUSNOAEf@casper.infradead.org>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <ZR9gkZKafUSNOAEf@casper.infradead.org>
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

On 06/10/2023 08:19, Matthew Wilcox wrote:
> On Fri, Oct 06, 2023 at 08:11:12AM +0700, Bagas Sanjaya wrote:
>> Matthew Wilcox, did you miss this regression report? You should look into it
>> since it is (apparently) cause by a commit of yours.
> 
> No, I didn't miss it.  I'm simply choosing to work on other things.
> All this regression tracking nonsense and being told to work on things
> by people who've appointed themselves my manager has completely sapped
> my motivation to work on bugs.  If you want me to work on things, *don't*
> harass me.
> 

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara

