Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D907A6B93
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjISTcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjISTcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:32:03 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC78B3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:31:57 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bf1935f6c2so1228145ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695151917; x=1695756717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jjsN1SvSzM74FCs+epYa3vF7No0rymKrcXSLojQ1y0s=;
        b=crQeTz7E9dKq/rKL9gBbj9AFG3SWoaFvo4sD/nwKAntFiB/LzkCBQhO8d0sMYSLMvO
         oWIXuBuMA31OOZaDizIHMM/Bv8BBCjmH/s5wzGI+DziQFQyhKYYWZDPSaaOpfW/oq3pc
         ZXHoGvrFxBxKNpcgT2v2ubL95EfoshesBkXgepFHKcuqZNFufdyfZmmu7y69HW8keh1M
         n7UEQ9YH6BgyoyU/kLh6xWtdaiPvocJuBA18OBOeYLVS1hUoLetRAI2+Hli4jMgd1SEH
         S2MgqDc/5HO/wYHzMN83cSORQu3MWdXJSg22xAP28I/GFDg8/2bA0/g0WU8JamCp//FC
         CfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695151917; x=1695756717;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjsN1SvSzM74FCs+epYa3vF7No0rymKrcXSLojQ1y0s=;
        b=bQOPNEDkGOdBoeu2PYaYly8PwRJ5skmIGnU8QvwYRalhbviEHQpmXyTAODZtYXPp3l
         tiLv/RdT66uZHwOISjmsl3SVC2JOoxk6PxNMZPtl8SsZa9FKbJSSN1XtI1LbMGvauKPm
         O8mK9QpocLf/DV6B1+fIQIBQn23jLApOQNW5jnGHyLnvQPjm7/V7DfEBko+x/onTDd7N
         ps++RoycFTTBwvj0iUTiHG63OKB4C4LkG+q7Q+rY8zGIX10uoKi/vaI3nAkJclj7+Hpz
         +HXiZMpjV/sivVFzLqCX6Lg3dbrurZS2Qy5c7FNlSORTRXE6Lk1nP5tsg8UXgTn+lRws
         a4MA==
X-Gm-Message-State: AOJu0YzEUUOLsFBjiVLLzIC9IgY+uFvilDTcDNC/BcWoa7ckBulgQ/bK
        tSX2BCXBUHzV/JOXIw31hHtCIvd4TBQ=
X-Google-Smtp-Source: AGHT+IEHDDuWl6hsVpOsfQ9/JE/vnkvU73VZnh0N/Tcc3CorV3mRj3eL1GifHFVn+prkrVS/GHpHZg==
X-Received: by 2002:a17:903:2283:b0:1b6:a37a:65b7 with SMTP id b3-20020a170903228300b001b6a37a65b7mr4769859plh.23.1695151917051;
        Tue, 19 Sep 2023 12:31:57 -0700 (PDT)
Received: from [192.168.31.134] ([117.243.68.251])
        by smtp.gmail.com with ESMTPSA id ji22-20020a170903325600b001c1f0b3e900sm6909509plb.229.2023.09.19.12.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 12:31:56 -0700 (PDT)
Message-ID: <1fadd651-2e2d-8fd7-3f39-8d3b31921951@gmail.com>
Date:   Wed, 20 Sep 2023 01:01:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] staging: rtl8723bs: hal: Fix codespell-reported spelling
 mistakes
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230917134940.2746-1-bragathemanick0908@gmail.com>
 <CAHZF+VZVBkRP6D4xJEhoqKmr9MbjNFJ8A0NZXSwDEMFJhqBc-w@mail.gmail.com>
 <2023091949-drove-goatskin-3627@gregkh>
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
In-Reply-To: <2023091949-drove-goatskin-3627@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/09/23 00:35, Greg KH wrote:
> On Tue, Sep 19, 2023 at 09:31:48PM +0530, Bragatheswaran Manickavel wrote:
>> Gentle reminder !
> of what?
>
Sent this remainder for considering my patch.
>> On Sun, 17 Sept 2023 at 19:19, Bragatheswaran Manickavel <
>> bragathemanick0908@gmail.com> wrote:
> You sent this 2 days ago, for a spelling fix?  Please relax, there is
> obviously no rush.
>
> greg k-h
>
Actually, this was my first patch mail. Just want to make sure, the way 
I sent the patch and other things are fine. Anyway thanks for your response

Thanks,
Bragathe

