Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAC67CD3D8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjJRGHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjJRGHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:07:41 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8755EFE
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:07:37 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso1008787466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697609256; x=1698214056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=12Ki6pOs9EDEYe9sW9iaFz4JG4me1D3T1b13jqZlW2k=;
        b=o1k4gw0ph+B3Gssb1qvgoWQ3sQYH3Y1xxxlfjSHpWwesf1I8OlUHoiIDRywLbTrzUV
         ffDsiy+VyP7diEDfqeE6dVZ5qSB3KInJ4pORxLXQtuT3qdHLhVuDS1yeFvG0FaebCTJ/
         r/dyqHF02EhA/bPE+qcT/ZeEV9/XZKn74Yw4X9mgL2UxF185ypaVhUeSQl13OjOd7PiK
         HSqVoX29CsZkph4i+xGn7UkNtNjASrC8GM1H1/i5q7bLPLZ6eRep2gs9MTSLqzuPPVke
         s9jWNClqxQkwTZyIh4aAAK+m+1Ymp0LaoH5UaiD449Q2qqjdDxNca1CmNv7BduP8i5/8
         nBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697609256; x=1698214056;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12Ki6pOs9EDEYe9sW9iaFz4JG4me1D3T1b13jqZlW2k=;
        b=D7mhS+9yMHC/wgVOleJ8zftEB5DlZdKSQxzg7RM1IBLBzLF1XVu4M/LfyeIxmUjkYR
         zi7ScZ2DXKPTQPrKzhG+ovPkYCyX/OjLz39+Nt6B6s2QckJWZ3tO5xqK95+T4KsZwBHR
         rHirMQbEONRitRTW/jm78hdzJW4GIKDCKylj6Wm+ZOzOtTKQFUP1ZgBwsPtNvCkkkawo
         8WJCbcLesfV0Ac6LUvlQVoAcr1TmjSLJucFB1cqsHndOHeTYUoO4DNGcD0etLVtr8Der
         BZyMDxSp/16hz68veLb5u0x/7n/71m+nz7vXq1f9/qXMRGf16gem1XOeHJXObC3cnYsZ
         u25g==
X-Gm-Message-State: AOJu0Yz4eFAMqf/pHxe/ecOmpJkZm6pg69D1hvU2gSPY5LkeYdl5VVEd
        +4u3BIbtbSXb6ItY20edWg9YfA==
X-Google-Smtp-Source: AGHT+IEUQoC8psfKLUB/+f6hfs65fspFuxwkifskgcN24nOlUyzhwi4x3BUhbGaaEZ8CVlYT39zkZw==
X-Received: by 2002:a17:907:320b:b0:9be:d217:40b7 with SMTP id xg11-20020a170907320b00b009bed21740b7mr3271384ejb.32.1697609255921;
        Tue, 17 Oct 2023 23:07:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.154])
        by smtp.gmail.com with ESMTPSA id l26-20020a170906a41a00b0099d798a6bb5sm941784ejz.67.2023.10.17.23.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 23:07:34 -0700 (PDT)
Message-ID: <9e1233ce-1a6d-443d-873e-6efb3ed0207c@linaro.org>
Date:   Wed, 18 Oct 2023 08:07:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] HID: touchscreen: add himax hid-over-spi driver
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Tylor Yang <tylor_yang@himax.corp-partner.google.com>,
        Tomasz Figa <tfiga@chromium.org>, jingyliang@chromium.org,
        poyuan_chang@himax.corp-partner.google.com, hbarnor@chromium.org,
        jikos@kernel.org, wuxy23@lenovo.com, conor+dt@kernel.org,
        luolm1@lenovo.com, robh+dt@kernel.org, dmitry.torokhov@gmail.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        poyu_hung@himax.corp-partner.google.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        benjamin.tissoires@redhat.com
References: <20231017091900.801989-1-tylor_yang@himax.corp-partner.google.com>
 <6c7d9c92-7616-4fad-806e-44302c33b63c@linaro.org>
 <CAD=FV=X2kZcyeyK1SBcXaViBft4F6XYtA6+JwBqJswU41V9kUQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAD=FV=X2kZcyeyK1SBcXaViBft4F6XYtA6+JwBqJswU41V9kUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2023 23:41, Doug Anderson wrote:
> Hi,
> 
> On Tue, Oct 17, 2023 at 10:08 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 17/10/2023 11:18, Tylor Yang wrote:
>>> Hello,
>>>
>>> This patch series adds the driver for Himax HID-over-SPI touchscreen ICs.
>>> This driver takes a position in [1], it intends to take advantage of SPI
>>> transfer speed and HID interface.
>>>
>>
>> Dear Google/Chromium folks,
>>
>> As a multi-billion company I am sure you can spare some small amount of
>> time/effort/money for internal review before using community for this
>> purpose. I mean reviewing trivial issues, like coding style, or just
>> running checkpatch. You know, the obvious things.
>>
>> There is no need to use expensive time of community reviewers to review
>> very simple mistakes, the ones which we fixed in Linux kernel years ago
>> (also with automated tools). You can and you should do it, before
>> submitting drivers for community review.
> 
> We can certainly talk more about this, but a quick reply is:
> 
> 1. If a patch really looks super bad to you then the right thing for
> you to do is to respond to the patch with some canned response saying
> "you didn't even do these basic things--please read the documentation
> and work with someone at Google to get a basic review". This seems
> like a perfectly legit response and I don't think you should do more
> than that.
> 
> 2. IMO as a general rule "internal review" should be considered
> harmful. When you're a new submitter then absolutely you should get
> some internal review from someone who has done this before, but making
> "internal review" a requirement for all patches leads to frustration
> all around. It leads to people redesigning their code in response to
> "internal review" and then getting frustrated when external
> maintainers tell them to do something totally different. ...then
> upstream reviewers respond to the frustration with "Why were you
> designing your code behind closed doors? If you had done the review in
> the public and on the mailing lists then someone could have stopped
> you before you changed everything".

No one expects forced internal review on mature contributions. We talk
here about a first time contribution where already basic mistakes were
made: like not using get_maintainers.pl, not using checkpatch, not using
other tools and finally sending code which does not look like Linux
kernel code at all.

> 
> 3. The ChromeOS team is organized much more like the upstream
> community than a big hierarchical corporation. Just as it's not easy
> for you to control the behavior of other maintainers, it is not
> trivial for one person on the team to control what others on the team
> will do. We could make an attempt to institute rules like "all patches
> must go through internal review before being posted", but as per #2 I
> don't think this is a good idea. The ChromeOS team has even less
> control over what our partners may or may not do. In general it is
> always a struggle to get partners to even start working upstream and
> IMO it's a win when I see a partner post a patch. We should certainly
> help partners be successful here, but the right way to do that is by
> offering them support.

I don't know who is exactly core team, who is partner. I see
"google.com" domain, so Google folks are responsible for not wasting
time of the community. If Google disagrees, please change the domain so
I will understand that and not feel like Google wants to use us all. I
am fine and I understand if small companies or individuals make such
mistakes. It feels like a waste of our time if Google makes such
mistakes. Google's (Alphabet's) revenue for 2022 was 282 billions USD
and net revenue was 59 billions USD.

> 
> About the best we can do is to provide good documentation for people
> learning how to send patches. Right now the ChromeOS kernel docs [1]
> suggest using "patman" to send patches and I have seen many partners
> do this. Patman will, at the very least, run checkpatch for you. Our
> instructions also say that you should make sure you run "checkpatch"
> yourself if you don't run patman. If people aren't following these
> docs that we already have then there's not much we can do.
> 
> 
> So I guess the tl;dr from my side:
> 
> a) People should absolutely be posting on mailing lists and not (as a
> rule) doing "internal review".
> 
> b) If a patch looks really broken to you, don't get upset and don't
> waste your time. Just respond and say that you'll look at it once it
> looks better and suggest that they get a review (preferably on the
> mailing lists!) from someone they're working with at Google.


Best regards,
Krzysztof

