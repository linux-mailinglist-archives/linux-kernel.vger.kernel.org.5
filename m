Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B220E7FAD57
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjK0WTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbjK0WT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:19:27 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1A555AC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:12:58 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-35b0b36716fso4267705ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701123178; x=1701727978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=puE78O4RI+u15yYno75dce4/a2n9AH0YF0ve/Gmlb5Q=;
        b=NHBb0IP0C6hPiBRNBhwtOPT9jec5xHAa1htnTrdTrk9c23Gol3cM/mRY62hgvdV7yS
         WsXqFVP0Z8G0hlDyxQIag4yRrRXMMnvf/NzwbvuNSwRGpj5Z2kxMBIJKhpsSSN9r4b8+
         LN8bJKb/RsP+OBNqIrXdK/bMQi69MKWVxkxV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123178; x=1701727978;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=puE78O4RI+u15yYno75dce4/a2n9AH0YF0ve/Gmlb5Q=;
        b=jgi9gesaBU1WDeaSIK0UrDi/FXGpSnsCOxdaJqYv65h2ualm6kIbGmiOuWQ8nzgT60
         he1JXAoVSdAaP8CuEWvq5zwYQbOsglnhhF8e2FjbPdQK9u96fOvp+zoEcESSyoRdDTdv
         HrIPLNksVfeq1bzvg/s2/U2NOyXVflIgVmd8ehoL+G9WcJAsFqYlK5tOtcQXEaR8HNUk
         JeLhhPLHxyycMCPcNe/lfzi90b8rA8/4y6LVXEp3oAOy983XD/TCetExsnJdhTuekUxD
         jWqFa1rUnU9ihevO5O3dQiXbKOWvPYsF/YnP5fTJEIMDMPMmjldughFpu6m0fl8SNRAE
         DEzA==
X-Gm-Message-State: AOJu0Yx4FPy7U8nkfc9xNBlhf7F1+sFFbUrjplRP0GNVP25ZbtFZvSie
        vS6TBim9AXZ6Gahyh3ViTkYKSw==
X-Google-Smtp-Source: AGHT+IE6AGzwlGF+z7GOguSo74p0/n5g/TMMxCkC6xGkkoe96+I+4m4tenPVLxlT9SvVCDVTMTD2fA==
X-Received: by 2002:a05:6602:2245:b0:7b3:5be5:fa55 with SMTP id o5-20020a056602224500b007b35be5fa55mr13412624ioo.2.1701123178133;
        Mon, 27 Nov 2023 14:12:58 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id az9-20020a056638418900b004665ad49d39sm2541973jab.74.2023.11.27.14.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 14:12:57 -0800 (PST)
Message-ID: <94429ea4-c6a1-4437-8642-3a24930c7ad7@linuxfoundation.org>
Date:   Mon, 27 Nov 2023 15:12:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools cpupower bench: Override CFLAGS assignments
Content-Language: en-US
To:     Stanley Chan <schan@cloudflare.com>, linux-pm@vger.kernel.org
Cc:     kernel-team <kernel-team@cloudflare.com>,
        Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20231127212049.455008-1-schan@cloudflare.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231127212049.455008-1-schan@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/23 14:20, Stanley Chan wrote:
> Allow user to specify outside CFLAGS values as make argument
> 
> Corrects an issue where CFLAGS is passed as a make argument for
> cpupower, but bench's makefile does not inherit and append to them.
> 
> Fixes: dbc4ca339c8d ("tools cpupower: Override CFLAGS assignments")

There is no need for this Fixes tag since this patch doesn't
fix the problem introduced by dbc4ca339c8d

This patch fixes the problem in bench/Makefile like dbc4ca339c8d
did in cpupower/Makefile.

In this case Fixes tag is incorrect. I removed the Fixes tag
and applied it to

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

thanks,
-- Shuah
