Return-Path: <linux-kernel+bounces-39679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B10EE83D4F3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63FF1C24EF3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F4C21A19;
	Fri, 26 Jan 2024 06:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3uJQZa2"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D445921A10
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706252235; cv=none; b=CnhQ1tD9Cak7oV68AvC7/oV3n8UYsyUmM6iOBocBcLYzPg7zOv2v4WAY+0QahLQC95g3AHKkIYHi55gtlz9ghWeHk7qrHw61JUwvoZ7Rrd4qzQVMhwvatgaIvkmfivgHZ96ZE6AwVE5fV2b0Nk3kvuNcHljTDiNKZS+IfcHLtqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706252235; c=relaxed/simple;
	bh=fmeJgmo1eTm45ia0BY+No10zL89lzqsqyA/OXLp4CYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1ny9JO5BO8ZzX+tHVuIqKn92OfjLZhIFCahfk4Vz9Q07n6fIJ+cm2VH1/e3Gvtha8oVmNaemNzjoqp77qqIHVLjj0dppP5Kaa304V3vM247COA/IYmQlRBbeawZdBFnlbo/1Scp45HRsfOeqsDWmS6lQbMFuV9fpJDwnMA73Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3uJQZa2; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6dddee3ba13so103140b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 22:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706252233; x=1706857033; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obmNILo/IhMsOn7tNaJgOnb5hD2rgV9SrDPKtcBkAB0=;
        b=R3uJQZa2sevm9zr1ONW7Q8VTAcOcQ9w+BbEUdcgjRFJiX8CLmW2SRfs/X1n5Dr+JIu
         alscH3agYaJdAkONq1e3zKi+cx9XFLkf1I5PZnxgKIqgD9xD0GPtgzTHoojX3iTpqwBz
         rFa/04BgFZIIWrdVo4b3qdyIADwGtcdmeuL40hQzARIIcSrHQz7y6uS2rvDIngjY+1Ae
         HEdjsBPgyVflHEH/FViiJnn3j1oYIoltsDdHyvU5vBu3QnByQkPUZzlDW2EMXyJ37lHL
         k7uCEuP9mzH9bzDf4RobGmwytJV7j/5HinW9FXTgRhSV1CnbTI0FOa2++kNNNQ5rvNys
         m8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706252233; x=1706857033;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obmNILo/IhMsOn7tNaJgOnb5hD2rgV9SrDPKtcBkAB0=;
        b=X4gVOZH4xPnIDkBUdmJSVQGMF1YBzk6Hldq/yzzfYEq+VxrFc96xjpPXmlQt4CE+/s
         H7L0viuIg4xqezzXSUXHlMhoUaO5IhvDuLhl44cQZWbsK55MV18T3LjEb+Z2GOGYD7ZA
         BGC1Ou1m/w7vZplgfhAfcVJaYTZdfDAR3N0AyqqIg9PhKZicleR7AtgIBF5Bhm8l9UZn
         SCqhvj2zGTTg8RnWKycV4BHpyQtMJCe8xn7GUuTiqOvsa5ixZYH+W9JOx+CriSEI50dH
         N4wzyr8+nqUy8sDidBu2plFhpoEkztSja/OODN/95EvB6HvnrUgtDElGwfvrFuhT0Hum
         9pSQ==
X-Gm-Message-State: AOJu0Yw796bmNULfVCxu1WV7NUcblLrPV+mKeHYCKx2gz2I7hK846ger
	x8Z7YWVwVqEe+6fDZ7lInxzyo5ZRLO5K60R2pN9aXqkP3WH/wKaK
X-Google-Smtp-Source: AGHT+IG7PKlIuVbF4dQed4/SZvmdfB0JA0BdDNlbOuweQSdzYs2QW8PJVNxyumqtKvz2V3xPIQE9Gw==
X-Received: by 2002:aa7:86d7:0:b0:6da:8572:ecab with SMTP id h23-20020aa786d7000000b006da8572ecabmr587227pfo.64.1706252233040;
        Thu, 25 Jan 2024 22:57:13 -0800 (PST)
Received: from cuiyangpei ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id lp17-20020a056a003d5100b006ddd182bf1csm533350pfb.46.2024.01.25.22.57.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jan 2024 22:57:12 -0800 (PST)
Date: Fri, 26 Jan 2024 14:57:06 +0800
From: cuiyangpei <cuiyangpei@gmail.com>
To: SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
	damon@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: xiongping1@xiaom.com
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Message-ID: <20240126065706.GA16652@cuiyangpei>
References: <20240122054631.GA7880@cuiyangpei>
 <20240122175611.46371-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122175611.46371-1-sj@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, Jan 22, 2024 at 09:56:11AM -0800, SeongJae Park wrote:
> Hi cuiyangpei,
> 
> On Mon, 22 Jan 2024 13:46:31 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> 
> > On Sun, Dec 03, 2023 at 07:37:45PM +0000, SeongJae Park wrote:
> > > On 2023-12-03T13:43:13+08:00 cuiyangpei <cuiyangpei@gmail.com> wrote:
> > > 
> > > > On Fri, Dec 01, 2023 at 05:31:12PM +0000, SeongJae Park wrote:
> > > > > Hi Cuiyangpei,
> > > > > 
> > > > > On Fri, 1 Dec 2023 20:25:07 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> > > > > 
> > > > > > On Thu, Nov 30, 2023 at 07:44:20PM +0000, SeongJae Park wrote:
> > > > > > > Hi Cuiyangpei,
> > > > > > > 
> > > > > > > On Thu, 30 Nov 2023 17:14:26 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> [...]
> > 
> > Hi SeongJae,
> > 
> > We set 'access_pattern' and 'stat' action in schemes when apps are on
> > foreground, record apps' memory access pattern when they are switched
> > to the background with 'update_schemes_tried_regions' state. But it
> > catch the snapshot after next aggregation interval. DAMON is still
> > sampling during the app switches to the background and the next
> > aggregation time, which can cause the value of "age" to change. The
> > sampling results during this period cannot accurately reflect the app's
> > foreground access pattern.
> > 
> > Is there any way to catch sampling result immediately after setting the
> > "update_schemes_tried_regions" state?
> 
> There is no way for exactly doing this.  You would need to proactively collect
> snapshots while the app is foreground, and use the latest one that collected
> before the app goes background, like recording-based approach would do.
> 
> I think recent DAMON changes might make an alternative approach available,
> though.  From v6.7, DAMON provides pseudo-moving-average monitoring result in
> sampling interval granualrity, since patchset "mm/damon: provide pseudo-moving
> sum based access rate".  And a followup patchset, namely "mm/damon: implement
> DAMOS apply intervals", has made DAMOS works in the sampling interval
> granualrity.  Both patchsets are merged into v6.7-rc1.
> 
> Hence, I think you could use 'update_schemes_tried_regions' after you noticed
> the app's state transition, with DAMOS apply interval of one sampling interval.
> Then you will get the monitoring results after one sampling interval.  Of
> course, the snapshot may contain some of background access pattern, but
> wouldn't made it changed significantly, unless you set aggregation interval too
> short.

All other actions will apply at one sampling interval except for the
`stat` action.

We use 'update_schemes_tried_regions' after switch to the background. The 
before_damos_apply callback function will only be set when the next aggregation
interval arrives. The `tried_regions` will only be updated after setting the 
callback function. 

DAMON is still sampling during setting 'update_schemes_tried_regions' to the next
aggregation time, which is not what we expected. The pseudo-moving-average
monitoring result can reduce nr_accesees inaccuracy, but age is still being modified
during this time, so it can't improve this issue.

Please let me know if my understanding is incorrect. Thank you.
> 
> > Alternatively, can it return the "last_nr_accesses" and "last_age" values in
> > tried_regions/<N> directory?
> 
> This could also be a good alternative in my think.  Nice idea.  But, because
> the previously mentioned alternative is already available while this require a
> bit small but additional changes, could we check if the previously one make
> sense and works first?  We could revisit this idea if it turns out the previous
> alternative is not suffice in my opinion.
> 
Can you consider adding "last_nr_accesses" and "last_age"  two files in
'tried_regions/<N>' directory?

Thanks.
> > 
> > Do you have any other suggestions?
> 
> As I mentioned above, I'd suggest the DAMOS apply interval of single sampling
> interval for now.
> 
> 
> Thanks,
> SJ
> 
> > 
> > Thanks.

