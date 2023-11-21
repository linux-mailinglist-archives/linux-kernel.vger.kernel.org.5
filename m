Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEBC7F3874
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 22:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjKUVj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 16:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKUVjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 16:39:55 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65790D49
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 13:39:51 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-548034455d9so1439401a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 13:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700602790; x=1701207590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ErP2QbBSryU90jbbhUT9w3qIH4Nqm8yBb72ux6w1ytg=;
        b=L+VgIR23ttVuFfAVttV2tpNZv839h4hdlUTpIYNATwH3kJDPYq0hW86zR0/bqv3Dp/
         1xhZhzudsvwr1gp32meY0BUwMPGL/9ZWXtn91V/dmACdMEoXoeSs4MrkWdMMoZ7O99oH
         +einWEH2szR0YcIPxLYEfqYsRUV7joZcuIgAtTySmzW7fh3Sg9GEQT5PdDLQit04Dt99
         42J8JmV/w+W4TMzUSGRQKwYY453icWubqSQuwnqikbiV/F4Ah8suuhJjuLKofk8MANVx
         v8zYHbGWsEEPHFGRvUfpDibG88aBqjJdyebmo/dH93Omy0bYRUCEA7QAYrJO7P4e91EW
         1PXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700602790; x=1701207590;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ErP2QbBSryU90jbbhUT9w3qIH4Nqm8yBb72ux6w1ytg=;
        b=Yia8ZMZm3dHMAtja3OzcC8BhDlpLvsXl2qgYqE55DAI9gAu9bA8M2Qs6jQz0Qsygdp
         DE7Fltu+E7YsGJw59/FM8Y3abCWtAlORehk+oclW5wwZ7B6aNmP6GpmY4PXnICov0hRa
         dXd+rsGvy6z4nPqyygL8Bt7wfMFnbXpIDxZr0mrfODVHjwQ7E/UaFFK3KFIvf4hRp3uh
         Xo9ewfCP4X16EhdKmrjqFerObHWvvehwq8B/1EQ4F0mDhPTr2141TtmTIBXTkZTBeSev
         RIMyKs4JnzV0UAL5LTs9Rf83qXPseTRVGFwVUnKQajUG5P29rAGcgqdzMKc+Ncgunr/V
         XE2w==
X-Gm-Message-State: AOJu0YwOb6kFISrgwFg70kFDY7d7VM/0Rfz/hloi9AaP52UneJIh78vS
        l+Zdoe5fPtDmx7dj6T7UQGI=
X-Google-Smtp-Source: AGHT+IE3eASFefohbz6YfGH63DNUdruC91vTO+VWFsUrK7HjURzQLhpeO1KSldfpf4U5iASxSjC9aQ==
X-Received: by 2002:a17:906:74ca:b0:9dd:5609:55b9 with SMTP id z10-20020a17090674ca00b009dd560955b9mr187091ejl.2.1700602789518;
        Tue, 21 Nov 2023 13:39:49 -0800 (PST)
Received: from [192.168.0.100] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id cm42-20020a170906f5aa00b009ff8f199f21sm2443879ejd.19.2023.11.21.13.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 13:39:49 -0800 (PST)
Message-ID: <4004f37e-66f8-4ba3-bfa4-41235e979043@gmail.com>
Date:   Tue, 21 Nov 2023 22:39:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] staging: rtl8192e: renaming of 5 different variables
 patch series
To:     Gary Rookard <garyrookard@fastmail.org>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231121181435.9337-1-garyrookard@fastmail.org>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20231121181435.9337-1-garyrookard@fastmail.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/23 19:14, Gary Rookard wrote:
> Hi,
> 
> This patch series renames 5 different variables from
> Pascal/CamelCase to snake case.
> 
> Linux kernel coding style (cleanup), checkpatch Avoid CamelCase.
> Driver/module rtl8291e compiles.
> 
> Patch 1/5) renamed variable from HTMcsToDataRate -> ht_mcs_to_data_rate
> Patch 2/5) renamed variable from TXCountToDAtaRate -> tx-count_to_data_rate
> Patch 3/5) renamed variable from IsHTHalfNmodeAPs -> is_ht_half_nmode_aps
> Patch 4/5) renamed variable from HTIOTPeerDetermine -> ht_iot_peer_determine
> Patch 5/5) renamed variable from HTIOTActIsMgntUseCCK6M -> ht_iot_act_is_mgnt_use_cck_6m
> 
> Regards,
> Gary
> 

Hi Gary,

this patch series needs to be a V2 with change history.

The next patch series you are going to send is V3.

The cover letter of your patch series seems to be hand made. You can use 
git to do this.

I am using this command to do this:
git format-patch -o ~/Documents/kernel/patches/ --cover-letter -n 
--thread=shallow --to="Greg Kroah-Hartman 
<gregkh@linuxfoundation.org>,linux-staging@lists.linux.dev,linux-kernel@vger.kernel.org" 
7b88c62d3cc5c3fb670b5448c7381c7c099b3518^..HEAD

There are now 31 patches pending for this driver. May be it is a good 
idea to wait until those are accepted or rejected. May be this is 
happening on Thursday morning. Or you apply the patches before you put 
yours on top:

https://lore.kernel.org/linux-staging/c464f4a8-753b-417c-97bb-7aa29ab5bf59@gmail.com/T/#t

https://lore.kernel.org/linux-staging/cover.1700296319.git.philipp.g.hortmann@gmail.com/T/#t

https://lore.kernel.org/linux-staging/d911d509-8677-444c-ad7f-92dd141e8e1e@suswa.mountain/T/#t

In case of question feel free to write to me.

Bye Philipp
