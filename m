Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E478019B9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 02:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjLBBZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 20:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBBZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 20:25:51 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C84B10DB;
        Fri,  1 Dec 2023 17:25:58 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cfbda041f3so10487535ad.2;
        Fri, 01 Dec 2023 17:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701480358; x=1702085158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hacFEanQzWYjmfz58yegpzfIkRd3gFMDu04K5m4XZz0=;
        b=gYPnz9bRr79LGMt6eO8MRMsQ7g0Gn1eriCaFGRFnlPAaxPKcxrtPDxUxoYvpbO2Z+o
         AmaoeigwGdP2VzM5cKsMA3lQ2rlknIWZz3rP9JD4XNrTMJCqNPVRGDw4aXmL8S9uRLyp
         nRtfES6QdkPceDLkGij8Z2PUPTn84Ow9alUI9RAjQy3GttbgYPLWtlLaeGX/0t3lop6a
         QBnEmxor92XNoGC6D1mqK9Rh/8FFOhcmZ4/LWTcsDJZH4Dgru7zDj9bOmU/Ed7Ml/yrc
         8j10ftVkDIBxd0C0YlS1rsOUJwmGaLu/jDhmOC2116zQztO2XOvUJjVPNxwn008Fppxu
         n1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701480358; x=1702085158;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hacFEanQzWYjmfz58yegpzfIkRd3gFMDu04K5m4XZz0=;
        b=gXOlRWih/mt67RBtaJO3OttmXSj3cO8PuhXnrRhzJZzYS2ObClot5ITkOaRiO7LuAb
         2fa75TeDfVQI3AY9v1olCN8iZZePPmn/EVrPjWAgMOyeoG3JWqeYo+ObzFpv7Mlbnj3b
         GU0d4ykHZH+cjzGEEFdYcF6uBDGukKiBLtBCRA8gP+R9gfKN1/jrCLQNnPM/DlkIoy/i
         b1xjJCXiyDrEPHCG8gm6SffWqBUFMLgJ+lVSPbJnceDiINCfyzDoBEemkWRJGULTpPuP
         +JJj2dxrcrrKgF+GSPMoJipFzvFJ86mbR8h2ficvcug9JU7iuK6n+HQJEagp5nJZ5dw0
         XL+Q==
X-Gm-Message-State: AOJu0Yz6ryWayvMeSebAsCMXxOArjqFzzQABcZYiUrLBitlskKNm4ODc
        xxObmh4bFJ30BgNmfjyY3cs=
X-Google-Smtp-Source: AGHT+IGNFqW1MhgL1AFGxbvT48JZfa1hxFAE3KPxRlQIAOPwmaFLKl1MCpIyXYJTbjrTE8VShwNbbQ==
X-Received: by 2002:a17:902:f7c4:b0:1cf:c901:5451 with SMTP id h4-20020a170902f7c400b001cfc9015451mr418703plw.14.1701480357676;
        Fri, 01 Dec 2023 17:25:57 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id bg1-20020a1709028e8100b001cfca7b8ee7sm335301plb.99.2023.12.01.17.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 17:25:56 -0800 (PST)
Message-ID: <53769b00-086e-4913-a0d1-606322d2ced5@gmail.com>
Date:   Sat, 2 Dec 2023 08:25:52 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup: Fix documentation for cpu.idle
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, Josh Don <joshdon@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Linux CGroups <cgroups@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Attreyee M <tintinm2017@gmail.com>
References: <20231201005203.309873-1-joshdon@google.com>
 <ZWlzwnO7PcOWQ2q_@archie.me> <87fs0meyzw.fsf@meer.lwn.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <87fs0meyzw.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/23 22:14, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
>> On Thu, Nov 30, 2023 at 04:52:03PM -0800, Josh Don wrote:
>>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>>> index 3f85254f3cef..9debf02bcb39 100644
>>> --- a/Documentation/admin-guide/cgroup-v2.rst
>>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>>> +  cpu.idle
>>> +	A read-write single value file which exists on non-root cgroups.
>>> +	The default is 0.
>>> +
>>> +	This is the cgroup analog of the per-task SCHED_IDLE sched policy.
>> "... cgroup analogy to ..."
>>> +	Setting this value to a 1 will make the scheduling policy of the
> 
> Bagas, please stop this (again).  The original wording is better than
> your suggested "improvement".
> 

OK, withdrawn!

And then,

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

Sorry for inconvenience.

-- 
An old man doll... just what I always wanted! - Clara

