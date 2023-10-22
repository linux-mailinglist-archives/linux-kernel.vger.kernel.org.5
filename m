Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6597D26F3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 01:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjJVX35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 19:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVX34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 19:29:56 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819D2EB;
        Sun, 22 Oct 2023 16:29:52 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2027684a12.3;
        Sun, 22 Oct 2023 16:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698017392; x=1698622192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UAiFPAdfabhyAlHBA9awAKPzZIO6nmeBseQuv58ya+w=;
        b=Qa/C6HM5TVJFnUpaRCThK2JkjusqnjjNOa4u770qI+ma4pZQJMYOSAElhB2vAPqZmN
         G7zUjSMme0jEG1jjHX6Y0hBOVGcuEyvv0tE1bYzfcHujtlkhYZeAYvBlbr+zRj/b5q//
         Y/qxZqfLfZu2jjYhZZbMlJvCWyEOkEoFCINLx/dVIt7u+K94DlkqWo1LIEMBvQeBpEDT
         tdYRofx7OV3gYtG50in1ZrSqdWvxQIkN3CQGPhofAZSJtS/bIyi8pnNyedL/PiSfivrA
         VYSJoLyuMJPEmqbqE9Dkfmqnaw8oswxUx59LL5Xt6mPeF0qx3JrXTg96jzP2b6TD5yDG
         fizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698017392; x=1698622192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAiFPAdfabhyAlHBA9awAKPzZIO6nmeBseQuv58ya+w=;
        b=ZBOjVnZAYZnFSJVl0+BwgC0r6VrTYjWYTGNmCiD5I7aE99dqo/qC18CwEFgPcY+9ki
         MamA2l+TsDw2VmR3txycm/olEpcF3G2zYrg34L3ykPwoVS78BB7PSDml8aFw8nSwCRq4
         jgPzOuTK0533M0out3q6UZIXetKvjD0VGox6by2weoBtUstukRTenRlcR8SkZUjs6NxU
         Gp6lp0wPXUmenVGYEFVmn8fTjoFa3pRP6M3W35eLTu2i33R32w4PQi9oZw957sCjlEen
         RtfX5hpE48NAKPPlDsR3XCqLqMp7/fgNNyMZZ62M6TuxoCnOeL5zWOP0bYy9lW3qSJyE
         HxbA==
X-Gm-Message-State: AOJu0YyuDWsf1NRNN/KNMT5scXaseoBB3MTKmt8fhuP6ezCua+D8AJ6a
        4WoytSS85fgvuOkvnIj8qQM=
X-Google-Smtp-Source: AGHT+IEThTDdMN1Z/Y1huDRF91qZc+GxG1Deabkk8nF/dNTubsZM6E0EwBjjHg2mYQc3lB7n5dO0WA==
X-Received: by 2002:a05:6a20:6a28:b0:155:2359:2194 with SMTP id p40-20020a056a206a2800b0015523592194mr10460844pzk.46.1698017391877;
        Sun, 22 Oct 2023 16:29:51 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id h1-20020a62b401000000b00690d255b5a1sm4960034pfn.217.2023.10.22.16.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 16:29:51 -0700 (PDT)
Message-ID: <fcf374fd-4d06-4136-a0ac-790bc08c549b@gmail.com>
Date:   Mon, 23 Oct 2023 06:29:43 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Old WiFi modules -- for testing?
To:     Rostislav Lisovy <lisovy@gmail.com>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Gregory Greenman <gregory.greenman@intel.com>
References: <ca929e1d8197ace414a06b20151b84de3dd160f4.camel@gmail.com>
 <ZTUIJHf1vdSxkXeX@debian.me>
 <d85050999a2944a921a38352d1c371fdb3b8c29e.camel@gmail.com>
 <872e8be6-c0d0-4e5f-94d8-e5c021d24585@gmail.com>
 <c998e99a4b8051b62776c66afb1ccd516d888d63.camel@gmail.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <c998e99a4b8051b62776c66afb1ccd516d888d63.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2023 21:17, Rostislav Lisovy wrote:
> What patches? Have you read my original email? :)
> 

Please don't top-post; reply inline with appropriate context instead.

Yes, I always did read the context.

> I am offering the modules to the linux-wireless project for free...
> Maybe they can be used for testing or some "training activities".
> 
> If not... no problem and I can get rid of them is some other way.
> 

Since you have Intel devices (from your album), I've added Gregory
(iwlwifi) to Cc: list. You can contact him off-list and see if he's
interested on your offer.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

