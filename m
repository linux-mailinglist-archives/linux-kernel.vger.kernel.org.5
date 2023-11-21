Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC6E7F60A6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345584AbjKWNpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345539AbjKWNpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:45:14 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846ACBA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:45:20 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5098e423ba2so1171239e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1700747119; x=1701351919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dYiFNM71aXrUdzFahhyPP0f3rdCUb0ZEqejFPIXSycE=;
        b=1StHSanxf8LD0gKHpaHz34ukovvIq7eKFWM2OmTil3mXpwxREyJN2PVzfV8qFZ3RR3
         ePcx7jijFBpSbY46tKR3CBSvPsmo2dGR8TzpeNCJT48H3Bx0WsdPWAcwFibXkWr8wuyw
         U71EySm6zD9WCzsEwgah0F3btyZ47hb44xCQrxlHY1AWx/lGgobV9IGtP7q7Cgs+ZdS+
         RynOfwSOLdt+LmtMoEtkhHlTzbDwQ1ve7oTXEcVOBsxeDalcZZ7bX6tGzQmg138b/m8v
         3peb87JsblUzd5KlEqIejYAIZbT9FIUfl/U8ESzpqgcUfdgkIldLuKLM2r3bpk0/b4Nz
         3yzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700747119; x=1701351919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYiFNM71aXrUdzFahhyPP0f3rdCUb0ZEqejFPIXSycE=;
        b=upQJ4znv7w2dg5NLhNPE5w7sJoee/nr/mQPTVYgXc+WkrxGK5mJPY6MkVxmb96MSKw
         OCV57KJReSWHReL0k2ddUmyRo8OQDvz4AIm9Fmh1OD18l9hTBpd5xj6XSa0uG4WaUjoE
         TwXlz9v0uuKPgTAm3xVSSPWsc7RaHOrIt0EyHVBo8QRw729mIR3HLLXU7mL4q9HtapAQ
         4DZUI1bQuyLVBlIWDbI0BtuC7i4oVl0C0zO5+dWGQacamIE2oKPmASiz+ddKT12QIJcI
         Ql/riTsxg4dp+ZeAcc6a6XJV5z6ub8o3FKXaLW9sq9oClYSSMN1HfhavSMs5PqINB3jl
         U7hA==
X-Gm-Message-State: AOJu0YyitvL70fd4jeVla40dG48xaspZ9bUX3rrQCjg/BGFckJxP5R5e
        dQ1sSoqwFKVNF6qLe02oGKqWOg==
X-Google-Smtp-Source: AGHT+IF4+CxtDPrhXBIv5S9T2L8REMdTsIcFXNPJgHND943qu/7UkOunGpim4XJQAZhJGMtymhcFNw==
X-Received: by 2002:ac2:551b:0:b0:507:a229:f53e with SMTP id j27-20020ac2551b000000b00507a229f53emr3462952lfk.24.1700747118781;
        Thu, 23 Nov 2023 05:45:18 -0800 (PST)
Received: from airbuntu (host109-151-228-202.range109-151.btcentralplus.com. [109.151.228.202])
        by smtp.gmail.com with ESMTPSA id dm16-20020a0560000bd000b00332cb4697ebsm1734886wrb.55.2023.11.23.05.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 05:45:18 -0800 (PST)
Date:   Tue, 21 Nov 2023 22:36:45 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, wyes.karny@amd.com, beata.michalska@arm.com
Subject: Re: [PATCH v4 0/2] Rework interface between scheduler and schedutil
 governor
Message-ID: <20231121223645.i2ujzcln72tw4gw7@airbuntu>
References: <20231122133904.446032-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231122133904.446032-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/23 14:39, Vincent Guittot wrote:
> Following the discussion with Qais [1] about how to handle uclamp
> requirements and after syncing with him, we agreed that I should move
> forward on the patchset to rework the interface between scheduler and
> schedutil governor to provide more information to the latter. Scheduler
> (and EAS in particular) doesn't need anymore to guess estimate which
> headroom the governor wants to apply and will directly ask for the target
> freq. Then the governor directly gets the actual utilization and new
> minimum and maximum boundaries to select this target frequency and
> doesn't have to deal anymore with scheduler internals like uclamp when
> including iowait boost.
> 
> [1] https://lore.kernel.org/lkml/CAKfTPtA5JqNCauG-rP3wGfq+p8EEVx9Tvwj6ksM3SYCwRmfCTg@mail.gmail.com/
> 
> Changes since v3:
> - Fix freq selection with runnable RT

Thanks! Both patches LGTM now.


Cheers

--
Qais Yousef
