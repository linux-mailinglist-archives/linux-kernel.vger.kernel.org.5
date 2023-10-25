Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49F27D7521
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjJYUEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjJYUEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:04:43 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163618F;
        Wed, 25 Oct 2023 13:04:41 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9338e4695so1580821fa.2;
        Wed, 25 Oct 2023 13:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698264279; x=1698869079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aRXCvqUEGxPWmLeNrK49IAezUNl9MkqYIjX1pTeuyPs=;
        b=CyXkHZI8wVNtfKaOvmmhbeqlQwpIgNtlcdc9pouWUyF/ZCGu/1kJK5SAlCKiFpJOnc
         dQzemP2H4U3eQuxijtTlDAoLQcCnQTwl5ui8MidVTbPRcqbyAI+dnfaAdD1HDhpenhBg
         5BNZPMy0+u08y+N7OgWdnAiDT7IjzcDmM+2hLbkAx4CU7OLHOc0Z4CR0Q8xwMX4GmX+F
         etSFfexyGS6Wifp2RhWJ+D7YG5sKYEtBfBqCLxLODVPYHoCyP42uhgirgfqxOki/DHkq
         8WPxPEC136Xui6vrnDeyNqzBCQv6XA9Qmxq5TFD6RJUjCCkEVXDaKSFui5D9tEX6N2tG
         XRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698264279; x=1698869079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aRXCvqUEGxPWmLeNrK49IAezUNl9MkqYIjX1pTeuyPs=;
        b=O9nz73wmlOeed026+eTbpw9MbMUYQ2Btvp5n6DYMgR//mge4nXWvr6ghEHyhYeXNUd
         qJBNf1luD1CaSp+AjoV6KHpW3iQiPND4TWhZLb3YpDshk9nvXe258TDTXuJCXu3cnV5f
         6VRdM+qtlMgvMO36UX7eH1nRgNNLGMxTtxJZ21X8RyOsFGSnILAnyXq/hEakobq2yANp
         vg2l5i7fupog1Ey3NnGwk6NZQdwHVRZ6W4IhzeJGR2TMeIzyalo1t6J0c1WH5UWjdthV
         kcDQTYUQt1hISJftegJokbMYtpMMfi5XymU4Y1F/cMnuz2z/ezMiu0TQF556uVOxgYs/
         vEuw==
X-Gm-Message-State: AOJu0YwIb0ZFtGZ68IVyg2MiQGgO5GM4ubg5flaMMh0smmbVR+QFuxkf
        zjqb/84W1wrN6FwemdMq1og=
X-Google-Smtp-Source: AGHT+IGcyVppwMzWcJePLy+2lwN2fhKViA8GWuWortnTRRjauD38DvPVVxmawlDSowy+NlXgYcywQQ==
X-Received: by 2002:a2e:8716:0:b0:2bc:b0ae:a9e5 with SMTP id m22-20020a2e8716000000b002bcb0aea9e5mr11159207lji.42.1698264279020;
        Wed, 25 Oct 2023 13:04:39 -0700 (PDT)
Received: from [192.168.0.28] (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id az32-20020a05600c602000b004053e9276easm599668wmb.32.2023.10.25.13.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 13:04:38 -0700 (PDT)
Message-ID: <456be27a-1e62-4b88-a868-6238813c26c8@gmail.com>
Date:   Wed, 25 Oct 2023 22:04:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     savicaleksa83@gmail.com, linux-hwmon@vger.kernel.org,
        leonard.anderweit@gmail.com, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: (aquacomputer_d5next) Check if temp sensors of
 legacy devices are connected
To:     Guenter Roeck <linux@roeck-us.net>
References: <20231016083559.139341-1-savicaleksa83@gmail.com>
 <20231016083559.139341-2-savicaleksa83@gmail.com>
 <ac61decf-8ab7-46c1-83f0-d3f79f737bbf@roeck-us.net>
Content-Language: en-US
From:   Aleksa Savic <savicaleksa83@gmail.com>
In-Reply-To: <ac61decf-8ab7-46c1-83f0-d3f79f737bbf@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-25 21:41:00 GMT+02:00, Guenter Roeck wrote:
> 
> Why is the sensor instantiated in the first place ?
> Returning -ENODATA for every reading is not desirable.
> If this can happen, the is_visible function should check
> for it and skip affected sensors.
> 
> Guenter
> 

The external temp sensor(s) are hot-swappable and can be plugged
or unplugged anytime. Similar logic already exists in
aqc_raw_event() for the sensors.

Thanks,
Aleksa
