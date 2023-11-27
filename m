Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5217FAC4A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 22:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjK0VJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 16:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjK0VJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 16:09:11 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F6BD5B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:09:18 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-35cd93add9fso1618275ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701119357; x=1701724157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KSTA5AxGidSyTaTLg4RSb2BlNCyrBOixWgjNXj4yZ5I=;
        b=hipEVxjpW8Zu4xcO9ZQhNa7vPJQI6D/hEAcqCnkJEf2W3jm/I7CRSHFXvKtiulIrmX
         oNEVVA9nvFaLVh+Yb4NlI9XxnFUxDG5eEfYAVntuwbhURlTEC7+5H0WaSIoARmvN00iA
         k899Ft6gnyocbIX6c1mboD7E/T2/tG5gGEATc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701119357; x=1701724157;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KSTA5AxGidSyTaTLg4RSb2BlNCyrBOixWgjNXj4yZ5I=;
        b=oewrR+WMPrRHg+RfruqnKJBx48pRMcplPF65gkCxnCoVH57GE7BV9L9johDT87rwHf
         lBebLbaWT3rqX1UYPtekdXPG8wsmqlx2jr/i6YcPqLpCKN44ROzTIgrGTc5u1JoFnB31
         Vt3hktLcEtstxfEJ2K6+FCrWlMuAUSOzRxl5EqBaDTPb0Dug3jEqntwTCvM+U+R8NDWx
         GbziHX1OPjBFEt71TdS6eT6KPNdhHqStlPWswlK8xDxLdTuqr76aZw03WY++ERJ4XUR/
         AAB2t54NmSZjupfgOuYUUW7vbC/h0uPxP08PhUQ+wanWf7vKOJtSiEJVACNAPX4q3XhB
         s35g==
X-Gm-Message-State: AOJu0Ywd/QjRbUBP8+PYUzAnj5peJQD7V6MpztrSvO668j1XQUjhQx2T
        tSzCGZrXJDmMWv8sza3nTXqt6w==
X-Google-Smtp-Source: AGHT+IEDfv//1mMXVgo9PqXe+/pr1A5gpV6QqcsMlT5ROeF3Ctnhg1wy+WAJgRG0QNmfDlm+EQnbgg==
X-Received: by 2002:a05:6602:2e0f:b0:792:6068:dcc8 with SMTP id o15-20020a0566022e0f00b007926068dcc8mr16208973iow.2.1701119357620;
        Mon, 27 Nov 2023 13:09:17 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id b20-20020a05663801b400b00463f8b3e34asm2613346jaq.23.2023.11.27.13.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 13:09:17 -0800 (PST)
Message-ID: <42bcba90-f32a-4b99-a68d-b4e8e37c202c@linuxfoundation.org>
Date:   Mon, 27 Nov 2023 14:09:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools cpupower bench: Override CFLAGS assignments
Content-Language: en-US
To:     Stanley Chan <schan@cloudflare.com>, linux-pm@vger.kernel.org
Cc:     kernel-team <kernel-team@cloudflare.com>,
        Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20231124185042.315148-1-schan@cloudflare.com>
 <CX79UGJ80EBU.34DF47O8X8C7V@cloudflare.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CX79UGJ80EBU.34DF47O8X8C7V@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/23 11:59, Stanley Chan wrote:
> Apologies, this is my first patch so I'm still learning.
> Meant to add
> 
> Fixes: dbc4ca339c8d ("tools cpupower: Override CFLAGS assignments")
> 


Thank you for the fix. Please send me v2 with this fixes tag.

thanks,
-- Shuah


