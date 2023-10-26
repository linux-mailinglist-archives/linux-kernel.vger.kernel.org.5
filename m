Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311AE7D84F7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345303AbjJZOmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbjJZOmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:42:08 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6500F91;
        Thu, 26 Oct 2023 07:42:06 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-58686e94ad7so551503eaf.3;
        Thu, 26 Oct 2023 07:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698331325; x=1698936125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kTnrh9xoZy325r5v7+bzRAng/mUcspwJrrB2m/Qv9HA=;
        b=lvzG3+BLbPbGD1s1hxOi/fKIq72r1YHhXePIrdDJ96BU6nvtwYlu09qXZm+GcjXccP
         DUFlw2RWAYw8rY4qI64A8NxtthcEqZ1mc/F4rkf6mS7Kpz7nAxSbdRbFCi1c6Vb5gRlX
         /7KC98ytcVOL36THRGaz7gBWdiK6L2nbfeBIfiHgOVrLS5iyok2g4WQxeFyKUC39Puxj
         JKHeGuNUIpB6AIDd0+UwX6a082hySYEnquKW4VpSYI0UZ1QTq8/ZIGOGNFfdyITIeL7V
         KSFki9avL4sMSxYzRyXHmn8KGngP0BxukociROa8xSCxBnL+8JZe+zwvUsDkXtLYLwvy
         8DLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698331325; x=1698936125;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTnrh9xoZy325r5v7+bzRAng/mUcspwJrrB2m/Qv9HA=;
        b=kfDnrxuClXxKPM2fe575V4b2yh+KQtIiTNfT9rQ693nXpO6XDA9HEgV9i7UrkQO85q
         am6kpYaAjlW0KYswSQdogpkphHPUxsOBcHoQJ+cpSUUFdvVl8DKREu9PHIrMqY4tHfti
         ifejF2LfCPwbTSYOGhLeIL1K7KbwlSHEW+wAqGL8oxG7vpSoHoZKb6DHw9cs/MmlCndH
         9J7tjp5xAZ67jGtvG4uO2XFhbTa3GIarkiRwODH//JGBdTwc7DYnhZgsJLIWiklcyfEX
         I64Td/PS48U5woRKYMFnU/znOtkDJ+sOZ+mM98SJEcZfxq6PXx/uQjtuzGwbjzqSGt77
         QKhw==
X-Gm-Message-State: AOJu0YxyPtzsICzhH8gTyJ0ZYJ9br03fCvkoKVcxMYeE68E78qWQ6ztw
        929FyD2PFqzbaStlaEg9jv4jF+5sh1w=
X-Google-Smtp-Source: AGHT+IEEQsRl4/c+fXa8rnHxnlQFPUJqQ6KTzRzKF01/jKEFpzu2E/6LwxmyMT6+91DypG8HtNmCKw==
X-Received: by 2002:a05:6359:639d:b0:169:92d:64c5 with SMTP id sg29-20020a056359639d00b00169092d64c5mr5470513rwb.32.1698331325472;
        Thu, 26 Oct 2023 07:42:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o5-20020a0de505000000b0057085b18cddsm6067255ywe.54.2023.10.26.07.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 07:42:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <567f7feb-db79-58b8-f72c-d3c69b7b4369@roeck-us.net>
Date:   Thu, 26 Oct 2023 07:42:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] hwmon: (asus-ec-sensors) add ROG Crosshair X670E Gene.
Content-Language: en-US
To:     Ellie Hermaszewska <kernel@monoid.al>
Cc:     eugene.shalygin@gmail.com, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAB95QAR-UbfVULOCaZMO4H1AgvzbiHEoSYk-DiYPY6Pg-i7Vag@mail.gmail.com>
 <20231019135640.434752-1-kernel@monoid.al>
 <d013e9a3-df0a-4b8f-a1f3-db3cbd32812f@roeck-us.net>
 <b81ae275-d3ac-4565-a09a-4a5ce38fadf1@monoid.al>
 <3a8fd5d6-9b79-76de-80fe-b39e24510dec@roeck-us.net>
 <df22c0f4-671f-4108-85a0-d1667ec1da77@monoid.al>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <df22c0f4-671f-4108-85a0-d1667ec1da77@monoid.al>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/23 03:41, Ellie Hermaszewska wrote:
> On 10/26/23 13:01, Guenter Roeck wrote:
>> On 10/25/23 21:46, Ellie Hermaszewska wrote:
>>> On 10/26/23 03:35, Guenter Roeck wrote:
>>>  > This is not an acceptable commit description.
>>>
>>> This is not acceptable feedback.
>>>
>>> I am unable to accept it because it is not clear to me what you think
>>> should be changed.
>>>
>>> Is it because I misplaced the message to Eugene? Is it because of the
>>> Greek characters? Is is not descriptive enough of the change, or in the
>>> wrong tense, or has incorrect punctuation? Do I need to include my
>>> testing methodology?
>>>
>>> If it's only something minor, then please also feel free to correct it
>>> yourself before applying. If you can't or it's not something minor,
>>> then please let me know what ought to change and I can try to correct it.
>>>
>>> If you don't let me know, then I will have to guess and possibly waste everyone's time further.
>>>
>>
>> Please consider reading and following the directions in
>> Documentation/process/submitting-patches.rst.
> 
> I will guess that it was my misplaced reply, and submit again without that part.
> 

 From the document:

 > Other comments relevant only to the moment or the maintainer, not
 > suitable for the permanent changelog, should also go here. A good
 > example of such comments might be ``patch changelogs`` which describe
 > what has changed between the v1 and v2 version of the patch.

 > Please put this information **after** the ``---`` line which separates
 > the changelog from the rest of the patch. The version information is
 > not part of the changelog which gets committed to the git tree. It is
 > additional information for the reviewers. If it's placed above the
 > commit tags, it needs manual interaction to remove it. If it is below
 > the separator line, it gets automatically stripped off when applying the
 > patch::
 > ...
 > [ ... ] When sending a next
 > version, add a ``patch changelog`` to the cover letter or to individual patches
 > explaining difference against previous submission

Keeping the patch description clean does not mean to _drop_ the changelog
or additional information not intended to be added to the commit.

Guenter

