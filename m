Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E41A75B2B6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjGTPbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbjGTPbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:31:25 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122FB273A;
        Thu, 20 Jul 2023 08:31:03 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1b9c368f4b5so14339465ad.0;
        Thu, 20 Jul 2023 08:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689867062; x=1690471862;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o9pCoYfLYt9B3ChEvgrKldiUE8AoOWfPJHRKLLp3+jA=;
        b=DqE6Cr+kIf9OW0thCOvOADRkskSzpHMmBsgHy4ZByuTyC6r1EUsoHgcnJ28zwTpQhv
         36YECQOqtifRSOZfTRMpcF/C8FJ+xWWmoS6LFX85s7CAeUkCDYtdbpguJtlkVn/80Unv
         BMuDvJUbjBxyEyYnSCCPWQET03+Q6dvxc1Oubm11eZotKwSoL16O9vtShvOmDMAQ9jyg
         I7btG6lXzOnMKfjEtgzDgNKinbOWZ0Wg5Hyu8QS9DVPD7+0CuOeFBRILSjP0eGJgCWmN
         VliDwtOoUUKHFmDX/o1gO+NYcH7uPD6Amod2FyzkF8bf4TZN2CcFGwmywVixGyGpiS/y
         YHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689867062; x=1690471862;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o9pCoYfLYt9B3ChEvgrKldiUE8AoOWfPJHRKLLp3+jA=;
        b=gdYPHWaXYT/17V2Q17azpKR+9p2k0KuY4/mBGMvfREzxhCpi3OZcGu8gjPIHYzcDXn
         aGBe4ulCKQYZj9F7S79pN9B5yCyOkVl09QH0GMbArc1ccLJvKCMrzKWyZsjqYUXf07sv
         139TgLHfK0CM/0X7Hs+guDqzC0WIjgjfg3jakbx/7scS9q26Ec0PRINUQAPZbSTMjO22
         4gx4WEw1bENvry81VQQfosxBJYEyCh9KbRuiX3BImCiqIuwKwOBLz1MVBGQanI498NtT
         OGCk2S7x8cxi+ONucmO9squ8FCGcKt7XwFVVrJskaN9r19Xq014Ct3zBxBj0c3+YhUFo
         5m+A==
X-Gm-Message-State: ABy/qLagvJl6M4u+NKCyzlqzIq5csIwk2wGf+EIJi7aL5d+EbHVHSfRK
        qd2WudMG4gcA/KXA3NnbH98dSnLzjkGcRkGQLdo=
X-Google-Smtp-Source: APBJJlGgAxfEmsiDRz5I9c14rHKpjRRYROihAalNfv7cu7/JYJNIrhBD0B+MgfydBQfc8b2Am9w8nQ==
X-Received: by 2002:a17:903:338e:b0:1b7:de50:7d9c with SMTP id kb14-20020a170903338e00b001b7de507d9cmr6670195plb.15.1689867062281;
        Thu, 20 Jul 2023 08:31:02 -0700 (PDT)
Received: from [172.23.111.174] ([113.251.0.121])
        by smtp.gmail.com with ESMTPSA id g14-20020a63ad0e000000b00528db73ed70sm1390564pgf.3.2023.07.20.08.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 08:31:01 -0700 (PDT)
Message-ID: <671503c8-c5c9-f475-1085-2a5c551d74ea@gmail.com>
Date:   Thu, 20 Jul 2023 23:30:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Hu Haowen <src.res.211@gmail.com>
Subject: Re: [PATCH RESEND 0/6] docs/zh_TW: update zh_TW's documentation from
 an ascensive aspect
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230720132729.1821-1-src.res.211@gmail.com>
 <877cqur8l6.fsf@meer.lwn.net>
Content-Language: en-US
In-Reply-To: <877cqur8l6.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/20 21:55, Jonathan Corbet wrote:
> Hu Haowen <src.res.211@gmail.com> writes:
> 
>> Update zh_TW's documentation concentrating on the following aspects:
>>
>>      * The file tree structure changes of the main documentation;
>>      * Some changes and ideas from zh_CN translation;
>>      * Removal for several obsoleted contents within the zh_TW translation
>>        or those which are not exising anymore in the main documentation.
>>      * Replacements for some incorrect words and phrases in traditional
>>        Chinese or those which are odd within their context being hard for
>>        readers to comprehend.
> 
> Is there a reason why you're resending a patch series from four days
> ago?

Considering for a long time but no reply, I just thought my patches were
ignored among the flood of emails or regarded as spam information.

Accordingly I resent my patches to ensure the reception of my patches as
well as added the cover email to provide an outline of my patch series.

Thanks,
Hu Haowen

> 
> Thanks,
> 
> jon
