Return-Path: <linux-kernel+bounces-39736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A238883D58F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198061F259EA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9E214265;
	Fri, 26 Jan 2024 08:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QR1r+KWA"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A4E134B0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706256299; cv=none; b=bL4raiDgt7WVOPbOraIdRJp6+C9/khGjE7yUbjdlVfLYgLDGfnHiI6oAxAYO/Bz74266+gqHQqE2Ba4XGDdMKlgEGnybt0Iqc3sdgHRFCl63gp71keaGLhvfMrWz1Gl3xAvI+Q7dya4ftTwRhsnFWSc/0gRuK67zSMOByu1N1wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706256299; c=relaxed/simple;
	bh=vBWqTUqUZtCh3EPJLAcL8wR/fYdkX3CFgMZPjKfyz1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To; b=YsiWXLPa/81gU1LZXBx25YsxPRSRyAxUQz43xkgfQ+rN6x912nkNYKBQCO5Sb0qbcvm19uMsSXNec1/r1Nd2uwrK2Eq09WHJQZfH4C6ACe5lpfjVUtxxXkgYXTN4mdim68Qtl356CITc8+Zb2Ez6XeYza5dJoKr5a6keSVuO7Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QR1r+KWA; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso138349a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706256298; x=1706861098; darn=vger.kernel.org;
        h=in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PQZqXjnfMiJnpMoo1+KQWc+QVfHQsa7SqRJloMMoGq0=;
        b=QR1r+KWA6OU/OhXw1Wxobh9VCpCci8jDlRSBIN0JFD1/BxMOJkkRZDiEd6j6esLs2U
         R7TZ+TAgohGWSrKfj11MXXHg7AXc9NwKmvxMGS1VNn3R4h5I20ZGH38X+VbtBUwJQAOo
         ItP+9ljnAS7pPCs5nzFNUBi3fYtgkzfXFIiKwZLKZTaeHOK4I3+nxCileCavD/9eNQOH
         j8gef/Bo+lNfzAorQ8xC8TcE6Hf5dLYC4nXjcpBDXjRWBivRV6vdL8LJ44SvSNyPiNF4
         Z5bpjpUvPCkJZVyvpGs19V/mtY59JNxqsY2wICu+f38XG84ym1GBY91QHTxtT0gbN+ZI
         YJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706256298; x=1706861098;
        h=in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQZqXjnfMiJnpMoo1+KQWc+QVfHQsa7SqRJloMMoGq0=;
        b=uKjKvetFqKBKRoKRML2BIWcoEDUl+7gGz/nUEKvfTz3k1Np4CR51CY6EZXhdpvYgU8
         tyexdyrz8dWyyGBuSjM1YUgrlNo90Wjd3evte2r6FQm556GtKrRaqGL767Qf4KJyHGLo
         l35shcwBNegQiEpflWSzR3O0dQvSH93Y4rlZy84Z2tQ2mC6/j+Zq8bWrxGAxP4hqKXsX
         aA+pqhQETaBhtXP4YXcLhDK4aZChUOI5yHHyaFfOvem4a/fz/eQiQee5OyrOsWk9GS3b
         btFzhwVvHN3A2KMiE/45LZbpCoKctyc5tmcL1SRQYK8iarRaE0se4r4B0Zp+LZJJTlOZ
         nxKA==
X-Gm-Message-State: AOJu0Yzr946Ovta2dxJSDwqYydt+fvTYdG6QXTn7oQHBdNeQhzUvVfhK
	5OsXIhNSnpd0+Q8+jAVAOm1GCv+qe5fRZofDSS2n3kLntvRoUt8L
X-Google-Smtp-Source: AGHT+IGfmbZKkJqn5DYHsnUB/HlbsSD4b7U+wcFk2saImSWOh/tYsOuUy6DJa89k+5XYyr7wqpmGTA==
X-Received: by 2002:a17:90a:6fe2:b0:290:b29a:5258 with SMTP id e89-20020a17090a6fe200b00290b29a5258mr526348pjk.29.1706256297570;
        Fri, 26 Jan 2024 00:04:57 -0800 (PST)
Received: from localhost.localdomain ([216.243.7.87])
        by smtp.gmail.com with ESMTPSA id sk8-20020a17090b2dc800b00290701c8623sm669927pjb.28.2024.01.26.00.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 00:04:56 -0800 (PST)
From: SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sj@kernel.org>
To: cuiyangpei <cuiyangpei@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	xiongping1@xiaom.com
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Date: Fri, 26 Jan 2024 00:04:54 -0800
Message-Id: <20240126080454.15649-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240126065706.GA16652@cuiyangpei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Fri, 26 Jan 2024 14:57:06 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:

> On Mon, Jan 22, 2024 at 09:56:11AM -0800, SeongJae Park wrote:
> > Hi cuiyangpei,
> > 
> > On Mon, 22 Jan 2024 13:46:31 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> > 
> > > On Sun, Dec 03, 2023 at 07:37:45PM +0000, SeongJae Park wrote:
> > > > On 2023-12-03T13:43:13+08:00 cuiyangpei <cuiyangpei@gmail.com> wrote:
> > > > 
> > > > > On Fri, Dec 01, 2023 at 05:31:12PM +0000, SeongJae Park wrote:
> > > > > > Hi Cuiyangpei,
> > > > > > 
> > > > > > On Fri, 1 Dec 2023 20:25:07 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> > > > > > 
> > > > > > > On Thu, Nov 30, 2023 at 07:44:20PM +0000, SeongJae Park wrote:
> > > > > > > > Hi Cuiyangpei,
> > > > > > > > 
> > > > > > > > On Thu, 30 Nov 2023 17:14:26 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
[...]
> > > Is there any way to catch sampling result immediately after setting the
> > > "update_schemes_tried_regions" state?
> > 
> > There is no way for exactly doing this.  You would need to proactively collect
> > snapshots while the app is foreground, and use the latest one that collected
> > before the app goes background, like recording-based approach would do.
> > 
> > I think recent DAMON changes might make an alternative approach available,
> > though.  From v6.7, DAMON provides pseudo-moving-average monitoring result in
> > sampling interval granualrity, since patchset "mm/damon: provide pseudo-moving
> > sum based access rate".  And a followup patchset, namely "mm/damon: implement
> > DAMOS apply intervals", has made DAMOS works in the sampling interval
> > granualrity.  Both patchsets are merged into v6.7-rc1.
> > 
> > Hence, I think you could use 'update_schemes_tried_regions' after you noticed
> > the app's state transition, with DAMOS apply interval of one sampling interval.
> > Then you will get the monitoring results after one sampling interval.  Of
> > course, the snapshot may contain some of background access pattern, but
> > wouldn't made it changed significantly, unless you set aggregation interval too
> > short.
> 
> All other actions will apply at one sampling interval except for the
> `stat` action.
> 
> We use 'update_schemes_tried_regions' after switch to the background. The 
> before_damos_apply callback function will only be set when the next aggregation
> interval arrives. The `tried_regions` will only be updated after setting the 
> callback function. 
> 
> DAMON is still sampling during setting 'update_schemes_tried_regions' to the next
> aggregation time, which is not what we expected. The pseudo-moving-average
> monitoring result can reduce nr_accesees inaccuracy, but age is still being modified
> during this time, so it can't improve this issue.
> 
> Please let me know if my understanding is incorrect. Thank you.

So, 'update_schemes_tried_regions' command is firstly handled by
'damon_sysfs_cmd_request_callback()', which is registered as
after_wmarks_check() and after_aggregation() callback.  Hence
'update_schemes_tried_regions' command is still effectively working in
aggregation interval granularity.  I think this is what you found, right?

If I'm not wrongly understanding your point, I think the concern is valid.  I
think we should make it works in sampling interval granularity.  I will try to
make so.  Would that work for your use case?

> > 
> > > Alternatively, can it return the "last_nr_accesses" and "last_age" values in
> > > tried_regions/<N> directory?
> > 
> > This could also be a good alternative in my think.  Nice idea.  But, because
> > the previously mentioned alternative is already available while this require a
> > bit small but additional changes, could we check if the previously one make
> > sense and works first?  We could revisit this idea if it turns out the previous
> > alternative is not suffice in my opinion.
> > 
> Can you consider adding "last_nr_accesses" and "last_age"  two files in
> 'tried_regions/<N>' directory?

Actually we don't have 'last_age' field, right?  And in case of
'last_nr_accesses', it is a hidden private field, since it is intended to be
accessed by only DAMON core code.  Making it exposed to user means exposing
implementation details, and the mechanism that coupled with an exposed
interface is hard to be changed, so be unflexible.  Hence I'd prefer making
'update_schemes_tried_regions' works in sampling interval granularity, more
than exposing the two information if it works for your use case.


Thanks,
SJ

[...]

