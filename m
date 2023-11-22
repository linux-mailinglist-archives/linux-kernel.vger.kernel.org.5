Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A605B7F3D0B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 05:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjKVEzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 23:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVEzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 23:55:46 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07127E7;
        Tue, 21 Nov 2023 20:55:43 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ccbb7f79cdso47335315ad.3;
        Tue, 21 Nov 2023 20:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700628942; x=1701233742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4BWTNx2Usd2MLM0igaHIxkodLvHly8HX8g96LPstSIY=;
        b=bTzOGbJ1Rstd08ObzcUjOgkkGhOvdl74BGOKBuJWANx5bF6aI+Yz49DGZUV1TR+3i3
         Xf2AOnD9J/7GGcmU+sPh5CSrLWgGDAX5btgUEBqW8Xj+d+jiYSW0dlcu9YBbqXDjbk4q
         nZovCZ52Th4BYApyvYAxj4on20M2Phw4obJucstDG61vPO8M+WfcJgGrdnH6yejsG+W1
         6JmAtkflqBJizu9PRsbH/J10RzEC4DiPlHC+i+zMiGIJ930gJ4t420MyduW3JetcxMy+
         9YJqmwlnAAEpPaMy9Iqd8hZHeipY9m6CSdu7Bxn8XaACCAr9EtvDKwH/2d11Wc+BR5iD
         0+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700628942; x=1701233742;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4BWTNx2Usd2MLM0igaHIxkodLvHly8HX8g96LPstSIY=;
        b=YqCRbHKi1u8wcVN0pbKayiXnVMOStiSnLvPiTRxMiB/ldbh34ubvHmuQc0Q28qEu8x
         RUryI6akWmQDEt7ZK/Mxfh1k4JlHnWdh2SCUWJIHk5qAD9jMBQbdLyoaVhUTJ+ZKfKPr
         5UmSvQK6zbJCfwOdWWD5jlEM80+xuiUtqWF3X43P6yf6ewFZNVIiMASoItknBvhawA5J
         PAbBjwAm5KSJzG0gY9YjaqJYUvHOm45s/2CxICTA2nsctLom+w7yTsTeJCWtpf7HPVQB
         s5czX0df/OlPE/j8PuVzSKrKxzaVc714+5tA26hvaQn+6irr63z0r9ilKnxeXsYZ/Vxu
         g2lQ==
X-Gm-Message-State: AOJu0YyOCTckNqiodYRdH+h2aec5rv5z2JVZqwoRKOgyCE0eigc3dZON
        MrNyyi5ERyC+ukIU4Ppmu/810d9cOT/ZfA==
X-Google-Smtp-Source: AGHT+IEgdbsMqDRYpHotVosS4FYvhOFFrpSSBZ8x0rFFDXmVhzL7uHiHUwTZA4Z0uS2ryJv7X0KIHg==
X-Received: by 2002:a17:902:b7c6:b0:1ce:89a7:440b with SMTP id v6-20020a170902b7c600b001ce89a7440bmr1158502plz.2.1700628942386;
        Tue, 21 Nov 2023 20:55:42 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id iw15-20020a170903044f00b001cf69103b91sm3237407plb.130.2023.11.21.20.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 20:55:41 -0800 (PST)
Message-ID: <da6d3886-3b51-4ce3-92f1-6e86a62ff579@gmail.com>
Date:   Wed, 22 Nov 2023 11:55:35 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_Fwd=3A_sign-file=2Ec=3A149=3A17=3A_warning=3A_impli?=
 =?UTF-8?Q?cit_declaration_of_function_=E2=80=98ENGINE=5Fload=5Fbuiltin=5Fen?=
 =?UTF-8?B?Z2luZXPigJk=?=
Content-Language: en-US
To:     Dennis Clarke <dclarke@blastwave.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
        Linux Kernel Keyrings <keyrings@vger.kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
References: <1fca50c4-6d7b-4c9b-bcea-4df17e2c2e7e@gmail.com>
 <e110cfff-08f9-4bbc-6b69-0d67ae6562b6@blastwave.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <e110cfff-08f9-4bbc-6b69-0d67ae6562b6@blastwave.org>
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

On 11/17/23 12:34, Dennis Clarke wrote:
> On 11/16/23 18:41, Bagas Sanjaya wrote:
>> Hi,
>>
>> I notice a bug report on Bugzilla [1]. Quoting from it:
>>
> <snip>
>>> Not related to https://bugzilla.kernel.org/show_bug.cgi?id=215750 but I *feel* that
>>> this code needs a hug.
>>
>> See Bugzilla for the full thread.
>>
>> AFAIK, this looks like a bug when the kernel is compiled against custom
>> (non-system) version of OpenSSL library.
>>
> 
> I do not know what you could possibly mean. There is nothing "custom"
> about OpenSSL. For that matter the gcc compiler I am using was also
> built by me. Works fine. The sign-file.c source compiles fine.
> 
> It fails to compile in the usual way when trying to build the kernel.
> 

Hi Thorsten and all,

AFAIK there is no reply from kbuild people (maybe they missed this bug?).

As for the error itself, let me clarify. The reporter (Dennis) have a build
problem with /usr/local version of OpenSSL library. He installed it
(presumably) alongside with system version (which is installed to /usr),
hence I called the /usr/local version as custom one (IDK if that version
is vanilla OpenSSL or not). Maybe am I missing something?

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

