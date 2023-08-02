Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6118F76C1DE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjHBBHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHBBG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:06:58 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC821BCF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 18:06:57 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b8ad356f03so39167785ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 18:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690938417; x=1691543217;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+PdQZNMSX4BWd7GfGQsgkbSU4z+LmFph5fAsS9Mb/8E=;
        b=LiiY6SIY57LUWIarlaRfiiG5slzPSiWyCTrNC10J1X6bDP306y+pZtT4CiOn9V2+QH
         5O4LpUeNPytWKhbHYu/aEVdn43Kouub92jKz1O33BAJrvN7jdqzIusQV3wXDKxQeDzdQ
         Q5EdAnfrwHW7fzo7lcGuH0AZelAvIOOVO7MGlFsm1dvIWD/g5tvkk3KpCj76xKclykHe
         tu9Ukv+OeUJLyP7fW4VTh9Vmkh6u4R8m0DYnbjdt8PThMHhosNfl7pOSk+A1FN2Jlf+n
         /SWqkEaxG3mISL+aJWqUXOl7rdOnbmGYvESMtlVtQSXaAUksiod8bW3ZupB+1zXc672G
         RnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690938417; x=1691543217;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PdQZNMSX4BWd7GfGQsgkbSU4z+LmFph5fAsS9Mb/8E=;
        b=jX8/+8SV9Ev2LzTzU0ODW4DH3ETvsWNyd8gdjLpUPGfaojWIpbMBcfmlSGjLXMMziZ
         JPn1v6ZPdoYWWE3Nu4seT76ZN2BpsRgySt3gqIH3TlEk+kOcq6GF0xih+KAvM0y0/k4J
         8Hd3WC3earxemYwu1iVr1LLDuwd3tKlWjm7s3OIg9Yu/yjC51nAcQDlDs+B11TllvOiu
         6d3bfsawJSp4Kg2lE32h3K1Jmz8wwVCw48EC+47vCZANyrVpYbjVBCzN4RMWJ5nxZ0ss
         yFM3V0yf9TflWH6YRp1ZQ1Dmj8VXRY+jlNpV0OJVGc8jh4/9GCnsQax1PfKhkngrmW1H
         gOKg==
X-Gm-Message-State: ABy/qLb2MLSE8ag8ub7p/QPt81Xm5dEcXqqoleVZ3MfPv5SOqWBN3X5Y
        uTCvPMtqmyH/KZJ6cwkBbUo=
X-Google-Smtp-Source: APBJJlFPO24E4YncgqAZho5j6BS4ESZz3zlESgIJC4yejRGuMT93LjBIrPlB6A5DdR6DXK6Z7FVJpQ==
X-Received: by 2002:a17:902:7086:b0:1ae:10bc:4ae8 with SMTP id z6-20020a170902708600b001ae10bc4ae8mr12904705plk.26.1690938416930;
        Tue, 01 Aug 2023 18:06:56 -0700 (PDT)
Received: from [192.168.0.105] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902748900b001b54a88e4a6sm11017738pll.51.2023.08.01.18.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 18:06:56 -0700 (PDT)
Message-ID: <2f4f53e2-b12b-c77c-e7cb-8c0436a209e5@gmail.com>
Date:   Wed, 2 Aug 2023 08:06:51 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in smu73_discrete.h
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Ran Sun <sunran001@208suo.com>, alexander.deucher@amd.com,
        airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230801100024.8215-1-sunran001@208suo.com>
 <ZMjposYeMFxU5nE9@debian.me> <87cz07vvwu.fsf@intel.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <87cz07vvwu.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2023 18:34, Jani Nikula wrote:
> On Tue, 01 Aug 2023, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>> And it is unfortunate that you and @208suo.com people doesn't reply to
>> review comments (try searching lore.kernel.org)
> 
> Essentially a one-way firehose of patches pointed at our general
> direction is not benefitial to the community. It's not participation,
> it's not co-operation. If the review gets ignored, why should we invest
> our time on *any* of the patches?
> 
> 

Well, I guess this is the kind of "hey, some new orgs spam us tens
of trivial patches, then we review them as usual, but people from
that org are deaf in regards of our reviews (maybe deliberately?)".
The exact same situation happened last year with @cdjrlc.com
people, when they were notoriously known for spell-fixing and
redundant word fixing patches. Many of these patches were correct,
but some of them were not, triggering reviews requesting changes.
Yet, they also ignore the reviews.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

