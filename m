Return-Path: <linux-kernel+bounces-73308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D66085C0B9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25F78B21E85
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFED762DC;
	Tue, 20 Feb 2024 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="EVCwahnp"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D39B2C6AA
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708445262; cv=none; b=InLd7R7x+oeAvRZcQiY7DN4K7hHOnrLQoBLOt10TaeB3pN7+3vDeoFbSY/M/l1EP/5rTXCzBQale76AfZueYJKdebhspIAShgDD3svgwpwmfvykPLW5qQ80xbdTJgXQOy9GYxR1OM+3CPwxjJyrUwrUjrR2Dq3YaHvP4gTgY0uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708445262; c=relaxed/simple;
	bh=oH3dUa+Wj+jQQ655vwwAm7yhIATDl+ScAdW0bmMG23k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHFO3UMB5BAJlIXe7s30b0EByXkvLVahsw4dC/t7G7r6ITJf7sFVMYZmIDV1bENEeG0/ANUVZvpyYiV0TCOxfUkU1/dOAlk5wbTF4EGPv+yCi95Vq5a2t+2frfnncANNFt2XiOj6AVViD+hEQ+Mhxy2NZRiHU3//AUirxnej2Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=EVCwahnp; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33d3b72f710so1704708f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1708445259; x=1709050059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0dWqNRpDsoiB6tjjPBGEOWPL8uUbn8DxQ+SyVLyZ/g=;
        b=EVCwahnpxaE2WwV3hDB/hX7Un4D6FD8WLcGdm932gmIRZaxEqwn0uZyn9u8MOkJ+dm
         rPDq8LVQpqV68iWQs7MUGjOGtaocBm7ey2H8QvPy4yms4YVPXhzQH/OHGYzszVTfVsvW
         uBKs580tB2rd9qzKdtAAd3o0GhZ2gRVrWBCU4sCZRoiWkpZkHjQ3qVLkuKUo1O+jQYdi
         P27X0DfQ2Pnky+aQ5/5F1qZoLrUH+uQeNuAkt9SKAtOkyqqHfcdWzDwP7sBFfID/6VHT
         Rf3pUCVNWQnpzhd2RzXI8H1mzWeLpiYt5q769+r2JyNmxZ9aTIewu/lA44zwvjE8XMvF
         RHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708445259; x=1709050059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0dWqNRpDsoiB6tjjPBGEOWPL8uUbn8DxQ+SyVLyZ/g=;
        b=cAKRSoKT02zuo8ghqu0kbEmVoc4zfu8T1rz6UL6DjqowdV6UG0yjoObWCp3Y/zB/7g
         8L0tF9t07knnp/uv8Ca9bSzej6SgQz4zp9AR3u0jQaHg1vO2Ea+IPAk8CIDGugXBy5UP
         gzRRhFZmOqmoBrpCidxk1X2kLRdO3Xib6mTSwnBJEqM8fx7ISbEpDbwaCVBdZ0vC8FjJ
         Yf9NrQfJk/S32Yr8M3bTlBhqhIOU89DhPYjNVIF2cWxZmH3aABLsNF//rTtSZvKMfJrw
         K9asp5MigIgaDkTu0jy2NACEdmu60/7WnBMLpOezbKDYEdI2geWseCSoLZKMZQF3ceWq
         sCmg==
X-Forwarded-Encrypted: i=1; AJvYcCXNF5zdhEt/0lPQ9cluDvBkU6CkvDgcE7X8mOj75qds3P4sfQZNQ3OT9luBsBRAqlhDQtPOPuAT1PW0a6c2UFjBvnFrqglbGXmN0Srd
X-Gm-Message-State: AOJu0YzcF8QYe/0k4xot2EavkduPpeUEiAYJx2LUEedO64Zh/PCzXzVa
	kTNnF2dClAO3ZD5y2guj5YvH31aDLotQDwfiKLOoAPfcR+1DtE5MDrH349UEOzg=
X-Google-Smtp-Source: AGHT+IHDyzii/amy9Uxopv9sr9ryYg/PAOggp2fKUIhWJK+F7/THCmMLV61S4U2tuc+rOyESUb1ogw==
X-Received: by 2002:a5d:43ce:0:b0:33d:22a3:28bc with SMTP id v14-20020a5d43ce000000b0033d22a328bcmr7944783wrr.63.1708445258732;
        Tue, 20 Feb 2024 08:07:38 -0800 (PST)
Received: from airbuntu (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id co3-20020a0560000a0300b0033d70dd0e04sm1650817wrb.8.2024.02.20.08.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 08:07:38 -0800 (PST)
Date: Tue, 20 Feb 2024 16:07:37 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Pierre Gondois <Pierre.Gondois@arm.com>
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
Message-ID: <20240220160737.jlpewyyq3hp5nwgs@airbuntu>
References: <20240105222014.1025040-1-qyousef@layalina.io>
 <20240105222014.1025040-2-qyousef@layalina.io>
 <CAKfTPtBYcVWxYOhWZjzcQUB1ebUBA-B30hvToqGBq6JnfRUZNg@mail.gmail.com>
 <20240124222959.ikwnbxkcjaxuiqp2@airbuntu>
 <CAKfTPtDxqcrf0kaBQG_zpFx-DEZTMKfyxBu_bzCuZ_UZhJwOnA@mail.gmail.com>
 <20240126014602.wdcro3ajffpna4fp@airbuntu>
 <5249d534-d7ac-4cbc-a696-f269cb61c7d1@arm.com>
 <20240206150653.34ouqhbt4yz2cmgo@airbuntu>
 <f58fb725-39b6-4b76-bc23-bc0526bddccb@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f58fb725-39b6-4b76-bc23-bc0526bddccb@arm.com>

On 02/06/24 18:17, Dietmar Eggemann wrote:
> On 06/02/2024 16:06, Qais Yousef wrote:
> > On 02/05/24 20:49, Dietmar Eggemann wrote:
> >> On 26/01/2024 02:46, Qais Yousef wrote:
> >>> On 01/25/24 18:40, Vincent Guittot wrote:
> >>>> On Wed, 24 Jan 2024 at 23:30, Qais Yousef <qyousef@layalina.io> wrote:
> >>>>>
> >>>>> On 01/23/24 09:26, Vincent Guittot wrote:
> >>>>>> On Fri, 5 Jan 2024 at 23:20, Qais Yousef <qyousef@layalina.io> wrote:
> >>>>>>>
> >>>>>>> From: Qais Yousef <qais.yousef@arm.com>
> 
> [...]
> 
> >>> It seems we flatten topologies but not sched domains. I see all cpus shown as
> >>> core_siblings. The DT for apple silicon sets clusters in the cpu-map - which
> >>> seems the flatten topology stuff detect LLC correctly but still keeps the
> >>> sched-domains not flattened. Is this a bug? I thought we will end up with one
> >>> sched domain still.
> >>
> >> IMHO, if you have a cpu_map entry with > 1 cluster in your dtb, you end
> >> up with MC and PKG (former DIE) Sched Domain (SD) level. And misfit load
> > 
> > Hmm, okay. I thought the detection of topology where we know the LLC is shared
> > will cause the sched domains to collapse too.
> > 
> >> balance takes potentially longer on PKG than to MC.
> > 
> > Why potentially longer? We iterate through the domains the CPU belong to. If
> > the first iteration (at MC) pulled something, then once we go to PKG then we're
> > less likely to pull again?
> 
> There are a couple of mechanisms in place to let load-balance on higher
> sd levels happen less frequently, eg:
> 
>   load_balance() -> should_we_balance() + continue_balancing
> 
>   interval = get_sd_balance_interval(sd, busy) in rebalance_domains()
> 
>   rq->avg_idle versus sd->max_newidle_lb_cost

Okay thanks. That last one I missed.

> 
> > Anyway. I think I am hitting a bug here. The behavior doesn't look right to me
> > given the delays I'm seeing and the fact we do the ilb but for some reason fail
> > to pull
> 
> [...]
> 

