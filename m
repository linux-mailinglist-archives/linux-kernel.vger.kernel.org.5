Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BD17AED9D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 15:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbjIZNFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 09:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjIZNFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 09:05:09 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072CEC9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 06:05:03 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-405361bb94eso88238925e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 06:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695733501; x=1696338301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lUDqzgKzbv3Gg1WyHYLHJCasPYrE5OE5lNvp2LrCBsI=;
        b=Z6iQd7/7LL17In5CREozElEuYlrtbgW3E6GV8cU/d2xo3Aq7zNPKQwbwbVCSJRcn9q
         JZCBMChsW2iOMMsh6zhC8n5oBSdo7WWoSY6k9JjK5c7Dm7MZ598TEC6mi2DICLD1jdmH
         tSIobbXID7ARx2oVYk29fTA6a/08lt/mCmsw8uz8sEyC62EGbjmo09YLdKhZpNDXQyTR
         SL5FvZlCfaRZfxbpSjuVJvf39fc5O4T/A81PXMWnz9F3UrYU1unPCkxQIpIajoaznpKv
         BjuNwDxWzZbaT6Rj9gAQqmpzYllDMvxoMKS4YdZYa1ECHBtvaYmXz+aqk4NXyoJZwFHj
         bCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695733501; x=1696338301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lUDqzgKzbv3Gg1WyHYLHJCasPYrE5OE5lNvp2LrCBsI=;
        b=aTjy3h8GFZpMeV3KZWX78ihaMsdEHES+Ogcm7lhoY61tGktI/o/HY4Xot5NIbRLeOA
         PEZyy0GJsmkZFgIdJbSwxRSnw0uqZOVfe0KLh4z2R/hNmmQwGm3cM6Ou9n11Sru0y5Ty
         DR/S9gkHmU4HLBF0Pp5MjqHe1fU9IphkNYjD8SCROHtf0vpEUvhdwWSDbI0CQ8+IcEhO
         UqMZraouwq4/rrJNANQ3pcTzbfYIpn+bMkJ8ZxqZsGP0lpD5iV+2rhimOKtt/Ls3UR/a
         6jn4sPATks/iqSZplfThlz0r0mBONQhwzqR5haRfLIPzEVz7XS8hDybn5TMBRZxhO/s1
         25aA==
X-Gm-Message-State: AOJu0YyusJOpKyoktii+gMX8+CCmHNyf5EqkMSI3z18nvc7L9OMrwtI6
        8Dbf8Rp1GBHb4Nak5H/XyAm38w==
X-Google-Smtp-Source: AGHT+IEFUIftfFnlxqxC3wkhyOmlpvv9lNkeHx563zR0o5R8xM6Pg3jSugWsd4ebp22q79f/MEZ5hQ==
X-Received: by 2002:a7b:ce92:0:b0:405:39b4:314f with SMTP id q18-20020a7bce92000000b0040539b4314fmr9421511wmj.24.1695733501384;
        Tue, 26 Sep 2023 06:05:01 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id g10-20020a05600c308a00b003fee8793911sm11724064wmn.44.2023.09.26.06.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 06:05:00 -0700 (PDT)
Message-ID: <3137cbd7-8c6e-486b-6572-33990b930bac@linaro.org>
Date:   Tue, 26 Sep 2023 15:04:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 7/9] ACPI: thermal: Untangle initialization and updates
 of active trips
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <5708760.DvuYhMxLoT@kreacher> <22010294.EfDdHjke4D@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <22010294.EfDdHjke4D@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 20:43, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Separate the code needed to update active trips (in a response to a
> notification from the platform firmware) as well as to initialize them
> from the code that is only necessary for their initialization and
> cleanly divide it into functions that each carry out a specific action.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

