Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25947DEDAD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344700AbjKBHvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbjKBHvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:51:19 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC79116;
        Thu,  2 Nov 2023 00:51:16 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-58686e94ad7so317326eaf.3;
        Thu, 02 Nov 2023 00:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698911476; x=1699516276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2PrAs2Tc99o3KGDiQSF+aKrZ+y8qL8PDxem+N4SUKa0=;
        b=UrDWbB3YLJk6vetgcCtK75ZVtaLmaVtgX1AlS8S/a7A8L/lhs4vMP7eG164dLBymre
         C4cSo5O4igOOoZ0J+ywMfvE0Ktkh8+oVAMhvfaBqJ2ZjtegBtNob8yAZHCaK4aOanOka
         cP7lTGPboTis0VwcsVB/2pP6ijx+lLWC6ZFwFc4NmoS9Nl9S2PdVrxDrXUbi1HnCXKcg
         qAxH0/Vb8cUHu1XMx5AM5C2i+b7i1B7sclsM8FRIvgN0ru4ow1xAZwwTVFCkKv1a87ZD
         6dxEdz+xuT1xOFKlcP9pACZQsF+EquntqykagdlDzUQYsIS6noKiv92xBlHI9QIdUYjn
         Aosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698911476; x=1699516276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2PrAs2Tc99o3KGDiQSF+aKrZ+y8qL8PDxem+N4SUKa0=;
        b=nJNL09M0YBEq7Z8bxbK6MD7vqjgW/ot0DQXtVEaC9E8sMCns/EMQFX6tHVJ76zdOz+
         8/OPLyevjdCUztdMsvsnT9ttHFXQOQLOMWHsZ1eYSEIpQRKIsJnc2Ni/cApmrwu32zF/
         4ra95d/n3NScgeb+wCvl8Qn1ZzlZHQpTfvi1HU+3Yti5jzL+0nCK1N+eyPhgX4Woep4O
         1rSeM99TBaQTRW8FokydhJKQTp2oSOOI26/EPmscjjp5biU6Aq+i170bmKSrtYQSO0M8
         Ngne3l8gNdjIAf1Aw3hef87/ln1bHqpKtRtRKaEf/2/YNIVatSWKKgNFPkCgn/R1B1T3
         p+0w==
X-Gm-Message-State: AOJu0Yyg4rKRKvatAoJ6+SEfT5EPdse7LnhqiZtZ+FWPSdkbE7CtDaVL
        oYZSYnrEUCO6WV4jX3hu9DA=
X-Google-Smtp-Source: AGHT+IEWAs69KuY7cTMb7hRnkK3qdDBXgD0tDxLUGUOPZMC+cBH1Oxifx11JAVnBW7QBLliKSdA5YA==
X-Received: by 2002:a05:6358:7f0f:b0:16b:406c:a002 with SMTP id p15-20020a0563587f0f00b0016b406ca002mr227655rwn.19.1698911476055;
        Thu, 02 Nov 2023 00:51:16 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id w29-20020a63935d000000b0059d219cb359sm935259pgm.9.2023.11.02.00.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 00:51:14 -0700 (PDT)
Message-ID: <557f1553-4e85-4988-83e4-c07acaccfd1e@gmail.com>
Date:   Thu, 2 Nov 2023 14:51:05 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Requesting your attention and expertise regarding a Tablet/Kernel
 issue
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Jiri Kosina <jkosina@suse.cz>,
        David Revoy <davidrevoy@protonmail.com>
Cc:     "jason.gerecke@wacom.com" <jason.gerecke@wacom.com>,
        "jose.exposito89@gmail.com" <jose.exposito89@gmail.com>,
        "ilya.ostapyshyn@gmail.com" <ilya.ostapyshyn@gmail.com>,
        Nils Fuhler <nils@nilsfuhler.de>,
        Ping Cheng <ping.cheng@wacom.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Input Devices <linux-input@vger.kernel.org>
References: <kRKTNDYigUSblpNgSuZ2H4dX03Of1yD4j_L9GgbyKXcDqZ67yh5HOQfcd7_83U3jZuQzxpKT3L6FXcRkkZIGdl_-PQF14oIB0QmRSfvpc2k=@protonmail.com>
 <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm>
 <ZULw6AcBaD6z2UZA@debian.me>
 <ba7aeb6b-19ee-4491-a60f-efc5216177a7@leemhuis.info>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <ba7aeb6b-19ee-4491-a60f-efc5216177a7@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2023 13:31, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 02.11.23 01:44, Bagas Sanjaya wrote:
>> On Wed, Nov 01, 2023 at 08:37:40PM +0100, Jiri Kosina wrote:
>>> On Wed, 1 Nov 2023, David Revoy wrote:
>>>
>>>> Hi Jason Gerecke, José Expósito, Jiri Kosina and Illia Ostapyshyn,
>>>>
>>>> I am emailing to draw your attention and expertise to a problem I had 
>>>> earlier this week with my Xp-Pen Artist 24 Pro display tablet under 
>>>> Fedora Linux 38 KDE after a kernel update.
>>>>
>> […]
> 
>>>> Thank you very much if you can help me.
>> […]
>> Thanks for the report.
>>
>> David, can you resend the regression report as plain text email (preferably
>> with 276e14e6c3 people and regressions@lists.linux.dev Cc'ed)? You may need to
>> see kernel documentation [1] for how to configure your email client to send
>> plain text emails. Also, include in your report details from your blog post.
> 
> Bagas, I know you mean well, but I think you are making things
> unnecessarily complicated for both David and the developers here. Sure,
> the mail Jiri quoted did not make it to lore, but whatever, for him it
> was apparently good enough; and I suspect this "quote forwarding to
> others" is good enough for the people he brought into the loop as well.
> Yes, there are developers that don't want to go to a website for
> details, but if that's the case it's likely better to ask for details in
> this thread instead of opening a second one. And regression tracking can
> work without a separate mail as well.
> 

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara

