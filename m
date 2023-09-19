Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D763C7A5672
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 02:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjISAEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 20:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjISAEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 20:04:50 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062C990
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 17:04:44 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31c5a2e8501so4845694f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 17:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1695081882; x=1695686682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lKmKB9vKf9hesrksaYYza5X75bJdTltwCKlh53iy6pA=;
        b=VJTGOIhWTC+utVlvWwChb3XnHhljXNxCtg/Fs4DE19GxRyeSE3lVfXQhhGIpe6L/88
         +MUywgwIpePapZJngHhPkwM2M9JT1oVD54T2CoPdNtURDuB4DK1WOy0kAr4Ebkvk5zHD
         TILNbuFhe4SoKh/MOT/98Xio8ZyZMu8IJozakR8n1QOFLCEEZaYPUZMsX9UGwDf6biI7
         ZzE0A7gPBu7DaskGEe3+zD1c2V/T8NGLK4SJZhT6JhTUtzwWPvyuaXRQQ0H6f6m3NZJE
         pl0HD1FDL3qvxWTTgVQkenBQREHs2iB7SFzgApxEDqtMuySWviuwECAEvOguKu8Ys74W
         bdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695081882; x=1695686682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKmKB9vKf9hesrksaYYza5X75bJdTltwCKlh53iy6pA=;
        b=dmV9zEWpJ7p3PCD4A48bg3E60rSlkj6S4l+sjowFm9UpTIJZE5fxi/qDBKjYIfZF5x
         Ik725FE2Z2ee8HSaESJNovnfdre7ae9zE/QI8qZ6hLKoGklFB2cQXNjBEQ4cJZYSFUM+
         VS96LUG5+lzXGIA1wcV1xO+p6WMg5rZ1dMlBvWsBLgyAMc5pm/HyXM6FoJ9nsmnE6X96
         Hga4bQXa7BngLyYaPetBfeYIETLdIyytQCjItot/w+R9tZZM80FVTbyMKbfh17sRt0nZ
         2SjAmeNL0d7Amf6dmVJgp8Hhjm4ZyJQDoZPyq14qcURkMu2vkP/dbem1H3KDK9pYHHYP
         0NOQ==
X-Gm-Message-State: AOJu0YyN3D96E3fXCmvXUhuqiyT1exExewE38GWkB38VyECeGgowv6+L
        MvbbzY+WOmDmTjVjOZDmXHRhng==
X-Google-Smtp-Source: AGHT+IFFNKYAqa2w2v6F9Nsoh+8X0Rmm4dO2+giDMVqp6b0lA5AFGb6pjPhsq9KnLzYuiV/4dGOdfA==
X-Received: by 2002:a5d:4591:0:b0:31f:e418:223d with SMTP id p17-20020a5d4591000000b0031fe418223dmr7716962wrq.7.1695081881961;
        Mon, 18 Sep 2023 17:04:41 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id r2-20020adfe682000000b0031fe0576460sm4223971wrm.11.2023.09.18.17.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 17:04:41 -0700 (PDT)
Date:   Tue, 19 Sep 2023 01:04:40 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 2/2] cpuidle: teo: Introduce util-awareness
Message-ID: <20230919000440.fq5nyttc4mgpou7x@airbuntu>
References: <20230105145159.1089531-1-kajetan.puchalski@arm.com>
 <20230105145159.1089531-3-kajetan.puchalski@arm.com>
 <20230711175814.zfavcn7xn3ia5va4@airbuntu>
 <ZLZ/btJw5LNVxVy8@e126311.manchester.arm.com>
 <20230718132432.w5xoxbqm54jmu6n5@airbuntu>
 <20230917010516.54dgcmms44wyfrvx@airbuntu>
 <ZQg3eKYNe7hjFTds@e126311.manchester.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZQg3eKYNe7hjFTds@e126311.manchester.arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18/23 12:41, Kajetan Puchalski wrote:

> Yes very much agreed on this part, they definitely can be improved. I'm
> currently exploring some other approaches to this issue as well but
> that's more of a long-term thing so it'll likely take a couple of months
> to see whether they're workable or not.

Sounds good :)

> The role I think the util bits are supposed to play here is mainly to
> give us a view from a bit higher up than the metrics themselves do
> because of how quickly those decay. Another way to do it would be some
> way to make the threshold self-adjusting in the same way the metrics
> are, e.g. increase the threshold if we're suddenly hitting too many too
> shallow sleeps and decrease when we're hitting too many deep sleeps as a
> result of the util checks. This would take care of the edge cases
> currently falling through the cracks of their util being right around the
> threshold, the mechanism would adjust within a few seconds of a workload
> like video playback running. Could be a step in the right direction at least.

I'm not keen on the 'too many' part personally. It does feel finger in the air
to me. But maybe it can work.

Beside timers, tasks wake up on synchronization mechanisms and IPC, we can
potentially gather more info from there. For example, if a task is blocked on
a kernel lock, then chances its in kernel contention and it supposed to wake up
soon for the kernel to finish servicing the operation (ie: finish the syscall
and return to user mode).

Android has the notion of cpus being in deeper idle states in EAS. I think we
could benefit from such thing in upstream too. Not all idle cpus are equal when
idle states are taken into account, for both power and latency reasons. So
there's room to improve on the wake up side to help keep CPUs in deeper idle
states too.

Load balancer state can give indications too. It'll try to spread to idle CPUs
first. Its activity is a good indication on the demand for an idle CPU to be
ready to run something soon.

Generally maybe scheduler and idle governor can coordinate better to
provide/request some low latency idle CPUs, but allow the rest to go into
deeper idle states, per TEO's rule of course.

On HMP systems this will be trickier for us as not all CPUs are equal. And
cluster idle can complicate things further. So the nomination of a low latency
CPU needs to consider more things into account compared to other systems
(except NUMA maybe) where any idle CPU is as good as any other.


Thanks!

--
Qais Yousef
