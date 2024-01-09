Return-Path: <linux-kernel+bounces-21466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F731828FCA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B334A1F28462
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FD63E48F;
	Tue,  9 Jan 2024 22:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEGV0IlU"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C640D3E480;
	Tue,  9 Jan 2024 22:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5e82f502a4cso27283157b3.0;
        Tue, 09 Jan 2024 14:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704838696; x=1705443496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=v/5fHRZ3TTIgaikqWrDxvko86x0/5zJ9RLo/uHWIt/A=;
        b=FEGV0IlULHHjigvmkKZTV9Lldy03f1hTjQuXyhPm2KPrEFIr7XbZ1LWkOBMwxOwMhO
         2j1ck1HymPEk+O94xKDx2XwBFBHdFAUSG0L2PDDn+YFpeBMldshwtx+CYtTRQMpIP2zd
         68FDGkuldnQXkEwuxjV0FqugCzUQ51x5Kws4xq5yYvhr3O6ypBinr4po7fsjN5sZrbtS
         DRThm0nJiPTrqlR4r3VMAhtwJ7AOMn+Di1rVYdPsNIfh6u17T6BAdauhujgugE8+mB8A
         50zAwZyxoeEhDYVqEt+DO4M5fiiivQi61UC9M1mtOezn68eNhcGw4BIgCp91kWf3EUsp
         RSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704838696; x=1705443496;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/5fHRZ3TTIgaikqWrDxvko86x0/5zJ9RLo/uHWIt/A=;
        b=vLMc2R4gGvII/leELkL1dD91Nl07rYIwEphXF00DmxA+/Um07Oa8N/AePG/tP5ZLJ4
         itFoGxcAFMpDo1YI18EJb6j+a9KpIgGCoTiZhrqRKDmj2FR2AZ/IwM8/ixlIEx1vb1s6
         jdV0GTH7ZkJQsvFv0OO8fad10cQg13pndWG5EnGWUL/aFCA6+Amu+RP5ylX6FoXK3xbS
         oCJTvgQT043WdIIj22IDWl4LigSHl+UcuEtAp7EADupBF81EnVgXx4BEANzz0G+eWXzA
         nWTnQCwxGRY+qHRj5f11fyhm5/2SeDUhj0RM/ja7RWUg7Lx/GIV0L11fEouTeK0OVZVu
         2rYA==
X-Gm-Message-State: AOJu0YxKNMVv7OqWIfmklZ5hTHaPsAdCuqUHxjdbXZD4QVBcFuxAB7uY
	T40rqYyyN15J8W+tQWcm0hs=
X-Google-Smtp-Source: AGHT+IE4ioHYsK8BrRCtioucpZLYJByHQF+hhkA6bdoAIejoNjkkeOSHea6O51p+qmcZCeTkErbKZQ==
X-Received: by 2002:a81:4fd3:0:b0:5d7:1940:8dd7 with SMTP id d202-20020a814fd3000000b005d719408dd7mr142850ywb.62.1704838695631;
        Tue, 09 Jan 2024 14:18:15 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s84-20020a815e57000000b005e8991c1a69sm1072050ywb.140.2024.01.09.14.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 14:18:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cea9dfbe-89a1-4832-a09f-10582cd034fb@roeck-us.net>
Date: Tue, 9 Jan 2024 14:18:13 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] ACPI: IPMI: Add helper to wait for when SMI is
 selected
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: jdelvare@suse.com, Len Brown <lenb@kernel.org>,
 Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
References: <20240109041218.980674-1-kai.heng.feng@canonical.com>
 <CAJZ5v0g4_5k-+_-ZPkm5LNOLsveJJqt2t60q_4a3wm+kAFCv_g@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAJZ5v0g4_5k-+_-ZPkm5LNOLsveJJqt2t60q_4a3wm+kAFCv_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/9/24 11:50, Rafael J. Wysocki wrote:
> On Tue, Jan 9, 2024 at 5:12 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>>
>> On Dell servers, many APCI methods of acpi_power_meter module evaluate
>> variables inside IPMI region, so the region handler needs to be
>> installed. In addition to that, the handler needs to be fully
>> functional, and that depends on SMI being selected.
>>
>> So add a helper to let acpi_power_meter know when the handler is
>> installed and ready to be used.
>>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> and I'm expecting this to be routed along with patch [2/2] that has
> been posted elsewhere.
> 

Note that linux-hwmon@ isn't copied on this patch and it therefore
does not show up in hwmon patchwork. To me that indicates that the
patch should _not_ be applied through hwmon. If hwmon is supposed
to pick it up, please copy the hwmon mailing list.

Guenter


