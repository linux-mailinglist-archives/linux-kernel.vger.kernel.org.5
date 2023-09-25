Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DFE7AD5A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjIYKPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjIYKPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:15:34 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C253CF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:15:25 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c47309a8ccso51914785ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695636925; x=1696241725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/NVXxEEpqJ2UNnbMQkJOTpjyQq9eSlrGNtIF8Dr6n5c=;
        b=NWw73EeIpZeaZvweZfGNYZ5UkhIon6j20llzHpGLavrUW/NdkfPRHEC8EygTgBw/e3
         IUTWcp0PJPq2xq4tW5pJILY4Ab2xaCoU6PolibAJF8p8M9M7c7ONSdDa+XvoZPwGguzs
         EFCzXCdsSTnr+TXbc0SmfpSbpnhFwBcMXnzRnC1WEgnlEKK5nnuK07gklHo/pSYeBS7M
         ehol4bCuR5KW2SzyeaEKW3dE1vcO5ThuYTbRYdEcW2JvD/0GWsg4DsfMPxSr24+K4GeC
         ty7T8BQWCNW5PrFDjBrtDkJZlOjJFS8FkcWydzYo7KfGOJWr9e5nCHkwEBfDuUzVgC1T
         7hoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695636925; x=1696241725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/NVXxEEpqJ2UNnbMQkJOTpjyQq9eSlrGNtIF8Dr6n5c=;
        b=lNyO5daOWwXL3GIjrQGFfquUAEobQ+cMtI8BW+zeiJ24WkEGnNoYGH/jW5BHcfsTXh
         trG8/1eki91n5IVKPUBYn0YHk1DSrVsYiAmq3VgM9xfLkYXh69KQAQDklu7UqPJceIDz
         NaFvi0+q0xwp0sTWdL7KlMR5Ho6YJ+Hevzb1PzHuuv232ukyZvl0LIOwp1YvELU0gG63
         uppZ9dGa7aswJmBQxmOKUpn4fmDa2gbjqwFxgm+ihbaDwdj8ngXWX+AhzcrcHwDxrmze
         8m3T0gCxdXj8rbKQqF4tkCSVTxmOzKLwUMoyYR/bUIvcvJMsz+6X+7PdvDKIoj9Bgn/j
         9UjQ==
X-Gm-Message-State: AOJu0YyY523E8jb1N9Z631L1JU7zMvgSZ2tpSfzYaT6yIcKxugnFOkpB
        1EUiZD5GWm5taQLMe5BOoG/U3cJoRr3vDQ==
X-Google-Smtp-Source: AGHT+IEpbKaWl3nI75eL3Q9w3y/kFGxa7JzulCEuEbiSKZp03h6499/2xqNpvyYfnC+ckNXuzXNCcA==
X-Received: by 2002:a17:903:230a:b0:1bc:4415:3c1 with SMTP id d10-20020a170903230a00b001bc441503c1mr15610557plh.7.1695636924844;
        Mon, 25 Sep 2023 03:15:24 -0700 (PDT)
Received: from [192.168.0.106] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902cec900b001b9e9edbf43sm8481468plg.171.2023.09.25.03.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 03:15:24 -0700 (PDT)
Message-ID: <cafad11a-d7c7-4b68-880a-d6e05578fa5c@gmail.com>
Date:   Mon, 25 Sep 2023 17:15:20 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Atheros QCA6174 ath10k_pci fimware crashing
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Cool Goose <coolgoose54@yahoo.in>,
        Linux ath10k <ath10k@lists.infradead.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1209906123.2716993.1695416371605.ref@mail.yahoo.com>
 <1209906123.2716993.1695416371605@mail.yahoo.com>
 <ZQ4vQNe3XsArwWQT@debian.me> <87a5taa7lp.fsf@kernel.org>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <87a5taa7lp.fsf@kernel.org>
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

On 25/09/2023 17:08, Kalle Valo wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
>>> Sep 19 09:01:11 hostname kernel: ath10k_warn: 149 callbacks suppressed
>>> Sep 19 09:01:11 hostname kernel: ath10k_pci 0000:03:00.0: failed to wake target for read32 at 0x00036044: -110
>>> Sep 19 09:01:11 hostname kernel: ath10k_pci 0000:03:00.0: failed to wake target for read32 at 0x00036044: -110
>>> Sep 19 09:01:11 hostname kernel: ath10k_pci 0000:03:00.0: failed to wake target for read32 at 0x00036044: -110
>>>
>>
>> Looks like hardware issue, right?
> 
> It could be a hardware issue (for example a problem with the PCI bus
> communication) but also simply a firmware crash. These kind of reports
> come time to time but root cause is unknown.
> 

The reporter said on Arch Linux forum (see TS) that trying older
linux-firmware package doesn't help, so I suspect this as hardware issue.

Cool Goose, what is your laptop model?

-- 
An old man doll... just what I always wanted! - Clara

