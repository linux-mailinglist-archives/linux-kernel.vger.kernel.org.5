Return-Path: <linux-kernel+bounces-10393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1297081D3CD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 12:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8002838DB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 11:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E120CA78;
	Sat, 23 Dec 2023 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f3DW52Xd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF09CA5F
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-336979a566aso1096876f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 03:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703331713; x=1703936513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XvbgNe9ygEkQ00vTu/GxGFniUa92RCIW2iyIcatnI3I=;
        b=f3DW52XdirTnImDxactCkUyTRTR5R/GEYrofoJdKXnircDTy1Jv47IA8JXjtpdXBvz
         E0W794qudG/skctUv0qONqd7bJRaJMbGKxPaO8bmhCLEzpZ35t6yiWzRHKAZMbXbKYyG
         FNQqoQ9bVAF7Tna/AsncCzgkFMtvs3o1smYoqoG4gzmgzFhgzggZLpcBt9uxNj97bKe8
         DsP4O+BbAlmKYL0Zgf6KzwoUtzXfjQKwyBJ0W8x0qS3JzJd707qQN+tWPnSC2Y0sATzI
         KzBGIRmLks/mz1yxLNzhD6JSTNyhEDa+qSDXrm1Fq5FuHYrR6/I8GOaQrgWDnQlu9Y7Z
         W8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703331713; x=1703936513;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XvbgNe9ygEkQ00vTu/GxGFniUa92RCIW2iyIcatnI3I=;
        b=PgXqLmsOYj3c7NVoA+Y49p1i8dLpA2K+69U1rLdIyuNR4DIlKllFcsYaFo2BI6QF/a
         cn3Z0ZRYt1x+JbwijbliM9F0s0oGKyGsrsJbMLp3kqupBkiB6/VRCPFRD8PnxTcktMsf
         t9x9Am/2jfwbzmAzHxDtEUxcZ4+5EoY6NPl/RuJ985lfiZqgFCY/wI6gMiNNY0QagX2X
         7Yc2tfq+agh6oY8hlpDrKAofUhlXX3KWul9zyvpT0HHBk7A+MVikYl9v2VYMRPLvc3F0
         uMFV6molxNyYfpeyVnEydkEs+wBTyReVaQv+aeHqD9KuQmfRrfvlkqDwPMszWOlCDHwM
         kGgg==
X-Gm-Message-State: AOJu0YxVtdVmcWlKFESOrLFc+gwf7WScashfNBPiHyvN+3iUkIDUiu7d
	JoyxIm2/fKNmdfpTURd83PbuftynQi4uoA==
X-Google-Smtp-Source: AGHT+IHw4UDFR6QFEVnzejSVPtBsuJrocfnimUDy+P9zAgQEVZIlLUj4McjYCBjVxDV9nPF71nDVLA==
X-Received: by 2002:a5d:67cb:0:b0:333:5464:1d01 with SMTP id n11-20020a5d67cb000000b0033354641d01mr1291999wrw.91.1703331712837;
        Sat, 23 Dec 2023 03:41:52 -0800 (PST)
Received: from [192.168.10.46] ([78.240.5.0])
        by smtp.googlemail.com with ESMTPSA id z8-20020adfec88000000b0033672971fabsm6306658wrn.115.2023.12.23.03.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Dec 2023 03:41:52 -0800 (PST)
Message-ID: <60ecab8e-7b96-469e-9bae-25c51514e6e8@linaro.org>
Date: Sat, 23 Dec 2023 12:41:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] thermal/debugfs: Add thermal debugfs information
 for mitigation episodes
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rjw@rjwysocki.net, lukasz.luba@arm.com, rui.zhang@intel.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20231219092539.3655172-1-daniel.lezcano@linaro.org>
 <20231219092539.3655172-2-daniel.lezcano@linaro.org>
 <CAJZ5v0gPHwJ+02hYbp5dRx1r69BdLWr_QDKautu-RXy1MEC5LQ@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gPHwJ+02hYbp5dRx1r69BdLWr_QDKautu-RXy1MEC5LQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Rafael,

On 21/12/2023 20:26, Rafael J. Wysocki wrote:

[ ... ]


>> +/**
>> + * struct tz_events - Store all events related to a mitigation episode
>> + *
>> + * The tz_events structure describes a mitigation episode.
> 
> So why not call it tz_mitigation?

A mitigation episode = N x tz_events

eg.
trip A = passive cooling - cpufreq cluster0
trip B = passive cooling - cpufreq cluster0 + cluster1
trip C = active cooling + fan

temperature trip A < trip B < trip C

The mitigation episode, as defined, begins at trip A, and we can have 
multiple events (eg. trip B crossed several times, trip C, then trip B 
again etc ...).

[ ... ]

>> +       if (dfs->tz.trip_index < 0) {
>> +               tze = thermal_debugfs_tz_event_alloc(tz, now);
>> +               if (!tze)
>> +                       return;
>> +
>> +               list_add(&tze->node, &dfs->tz.tz_events);
>> +       }
>> +
>> +       dfs->tz.trip_index++;
>> +       dfs->tz.trips_crossed[dfs->tz.trip_index] = trip_id;
> 
> So trip_index is an index into trips_crossed[] and the value is the ID
> of the trip passed by thermal_debug_tz_trip_up() IIUC, so the trip IDs
> in trips_crossed[] are always sorted by the trip temperature, in the
> ascending order.
> 
> It would be good to write this down somewhere in a comment.
> 
> And what if trip temperatures change during a mitigation episode such
> that the order by the trip temperature changes?

Changing a trip point temperature during a mitigation is a general 
question about the thermal framework.

How the governors will behave with such a change on the fly while they 
are in action?

IMO, we should prevent to change a trip point temperature when this one 
is crossed and has a cooling device bound to it.

>> +
>> +       tze = list_first_entry(&dfs->tz.tz_events, struct tz_events, node);
>> +       tze->trip_stats[trip_id].timestamp = now;
>> +       tze->trip_stats[trip_id].max = max(tze->trip_stats[trip_id].max, temperature);
>> +       tze->trip_stats[trip_id].min = min(tze->trip_stats[trip_id].min, temperature);
>> +       tze->trip_stats[trip_id].avg = tze->trip_stats[trip_id].avg +
>> +               (temperature - tze->trip_stats[trip_id].avg) /
>> +               tze->trip_stats[trip_id].count;
>> +
>> +       mutex_unlock(&dfs->lock);
>> +}



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


