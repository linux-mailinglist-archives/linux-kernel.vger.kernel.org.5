Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A7A76620F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 04:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjG1Ctj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 22:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjG1Ctg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 22:49:36 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AD32126;
        Thu, 27 Jul 2023 19:49:35 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1bbb4bddd5bso1306015fac.2;
        Thu, 27 Jul 2023 19:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690512574; x=1691117374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a7ldvBB2rbS3bYpCeMk71DDYYFjKwRoTgn+P6aVeXY8=;
        b=Pp24ZpJ2RxVFGw7CKZD0faZuq3f3UGoYXjgpgNEI+9I2zbl8POTFoc26bWPtyNanwb
         jY6ud7VqOanqu7KAG6BKVONJm0B4wd5qqWrTxInpvVbGwuBuYpMBPxRJFr6eSEdHsYqs
         ZpzkpND221WNnzjG1DJSC5EcgIPdH0IOkJjTSzfhrhXSCCgT2gTe1wEvNuauTnAi5GjK
         LSt2uZvpgSQfNcXl0S2l4UrZGuUCFSOWPa5LQxCvZQohiw0LPyxXRlsTajuIhXgUej2F
         XgfxuKA38WEW6l33DineQZgCj4nJFP4fmmmn0Jng+oIzPXGdhQRhHcKbSLHTkm0oVQuX
         r9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690512574; x=1691117374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7ldvBB2rbS3bYpCeMk71DDYYFjKwRoTgn+P6aVeXY8=;
        b=cm3ClawDesjnDRX2Dz/wpVRKGk5pYlROqxoibZ4nENfWbqoD8krU7Fg2cfERl3uERX
         emhgIcYmVO/a3tjmFIClC0KFtXQLUVTHE7bL2rHiVuXRAfaQBS7300q+FF/7swbjvBAh
         bzfu3kMhqbAY6E4tdqc4x9lliwezA2L8t0aQyfSs13BnevcIRuWfuXlmLqO12ZAY5fCx
         PFb4FwQhnhn86foS3qqPV2/k7FbTBCUsbVSDLChcL718BRObwiUCv+BSWwfupB2XRcL9
         y/E16HhiFU4rhdzbnlDVDkT5ZWSy5MDRbMjlrc3LWyqiHEVXtkyvwXhzvfQzeb+XK5/7
         30uA==
X-Gm-Message-State: ABy/qLYtkrrLYM736i1h7iCmMTfzpJ0xT7ObGZvrK5/toJIJx1br4Y3J
        4fSMglADl7ksW9oikGrbf5Q=
X-Google-Smtp-Source: APBJJlGtCgVp7ZuZ7VNDUXvMMZkTwW96lkumq0zI3xVahOPyULSN9yW+RyhmE3N48WJfKWzkn28A7Q==
X-Received: by 2002:a05:6870:5b9d:b0:1bb:a264:a7ba with SMTP id em29-20020a0568705b9d00b001bba264a7bamr1599749oab.56.1690512574356;
        Thu, 27 Jul 2023 19:49:34 -0700 (PDT)
Received: from [192.168.1.121] ([65.129.146.152])
        by smtp.gmail.com with ESMTPSA id m3-20020aa78a03000000b00686e8b00a50sm429979pfa.104.2023.07.27.19.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 19:49:34 -0700 (PDT)
Message-ID: <d44e4057-0758-4cb8-ca29-02b5bb340b8b@gmail.com>
Date:   Thu, 27 Jul 2023 20:49:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Scsi_bus_resume+0x0/0x90 returns -5 when resuming from s3 sleep
To:     Damien Le Moal <dlemoal@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     regressions@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bart Van Assche <bvanassche@acm.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
References: <0e272abe-292d-d58f-cf80-55868e793abc@gmail.com>
 <6b66dd9a-8bd5-2882-9168-8e6e0848c454@leemhuis.info>
 <c70caa9e-164c-fee5-8f85-67f6d02373ab@kernel.org>
 <b0ed86e0-3e4a-d4d1-7b9d-c57f20538a80@gmail.com>
 <86435987-734e-c6c1-a857-1ba80da709fe@gmail.com>
 <48bc1736-5e4e-3a9b-3715-60509c333bb1@kernel.org>
 <f7e7b601-571f-bd2e-6410-a8a27e510c2f@gmail.com>
 <40365501-283a-408b-3514-48c29db36861@kernel.org>
Content-Language: en-US
From:   TW <dalzot@gmail.com>
In-Reply-To: <40365501-283a-408b-3514-48c29db36861@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Comparing to the 5.15 kernel which had almost no delay. They are HDDs 
though, it was working flawlessly earlier but didn't want to top post 
again. Tried a systemd suspend instead of from the Xfce4 logout menu and 
everything works as intended. So I'd say that it's fixed now.

On 7/27/23 20:33, Damien Le Moal wrote:
> "Slow coming back" -> Compared to which version of the kernel ? Do you 
> have numbers ? If the devices are HDDs, resume will wait for these to 
> spin up. That takes a while (about 10s normally).
