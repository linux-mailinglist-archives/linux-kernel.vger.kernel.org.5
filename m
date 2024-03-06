Return-Path: <linux-kernel+bounces-94519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D44C8740F5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E923B1F24119
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7566140386;
	Wed,  6 Mar 2024 20:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="nxITYk6F"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE34C140397
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755201; cv=none; b=Lt7paM9pwf6iq0dUEtcJnEofw1YBXJ9QNUCMQVdYASUkYkfwF6VuJXnA43a22NFtsqP6E2Wizmko65EL3iTAr0musgl19yBLLDK0QmAvKHHrm4x4NJrGkrSuId/nVu7ZGMJqtgXTLOpLOqjVhJjeymmvD1gNQOPOgPYgTXq1dnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755201; c=relaxed/simple;
	bh=MJQooKERrkO5M8FdxXsbgrCB1vQwZZRXngnYowa1Ucg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klwJmPnY/8LslQdwLQ5THfH1d4rGdMGh1BCD1eHLhtYy9WLDVl2O15exvex6P5ucGJCCgEuhbD+daXVx3JYrUXNdjnEo6gbGmRlGoruiBZ1aSwaGuCdEx2xN6/Pj7NCwFYi4P+NCel98ZGQLkEoua2xQywNZ/jF/hdR8CvYDaG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=nxITYk6F; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6096ab005c0so1377747b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 11:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1709755198; x=1710359998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nk0/J29KPf4TmmeCSNMEsRp4h+k2/fvkEQwAaLlHWxs=;
        b=nxITYk6FUOJOhKf/sKhG47NLK2mwoGTzHmTNNhxNIk7Bj8T0g3ZXECO7EtcSbbER1L
         XjxBYhZohxdwY4VBAYKuMI4JSwJEYP2iAigz9VB0licnoowBnxfUxJ9tGsxhL5sZow5+
         sOkvA06fPJzle4rR3N4lrtCRMvFVd1tv6txgRiDRczMNjT3LuReoqnwbMQf7Yqx95zzO
         mde9jwIbLHrz1zpSU52WxOFTXRGf9+TA0pTf5na5pOZvEySIAMVSz+RHkZHJFSTsoiwT
         WJyfZSZrEu56E7OmanKvlynbnnJAqGBgJtm3YxTqt8khigdtDEZGkQq6smn02PrGzagD
         k8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709755198; x=1710359998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nk0/J29KPf4TmmeCSNMEsRp4h+k2/fvkEQwAaLlHWxs=;
        b=rz2SUdW50oZIIZ76jYOO/MYhhW6oTvkf8DWpf+gL2jSlpdpVtmgE/5E3pTda1NQBVk
         DSS7L5XM/6yze/gE+y6O0QQmrOlSqzBjBT+2wDf2IImWuVRy3zu58RKj7Src8hnUvD82
         Viu8oon7VgwOTHQEr42HvknJaE4UWITP4lE+eoxoaA+uJ1fyuIl0zC+unBb5ZofAVXJP
         iuuHA+nj83XCoxjDNljp/2R/GjZTKBBSGZWDKFMcQBcKXmAPSyCPZJayN0hqCkCpl2CA
         ZynZ6omzMKkTYyy58cnVjoLjzvKfD9ByarspmXwQ2e3zm1rKcik/oShkOtinhulrClKG
         AI9w==
X-Forwarded-Encrypted: i=1; AJvYcCWnvTDcNO6fEdPuGCy9gELSnJbmy9qOmHLYxeKanAJSfqJugGAyQNXjahN2r9PiKEELdxSZSYO+OExW95W0TctuqkzX4XGJck3LX4cJ
X-Gm-Message-State: AOJu0YxSellTrrwfRjyCM+ecquN6iQzvm/cMMvtihwZBNudpedreW60P
	S1YsBN45Ofl+9/eXjkpYq1kyJGKt4uDc/y6K/YZ2zUuJQiWRG1R42fBjiyBeeRw=
X-Google-Smtp-Source: AGHT+IEmVpurGUd31yZyHxSu4mjLVka0+r+yTrQMWzelFcoJ23tJQXn1JppRqRT3evd2Ke2EuGrRpg==
X-Received: by 2002:a81:8784:0:b0:608:290d:9f1b with SMTP id x126-20020a818784000000b00608290d9f1bmr14538562ywf.49.1709755197926;
        Wed, 06 Mar 2024 11:59:57 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id r13-20020ac85e8d000000b0042f02284578sm1888194qtx.68.2024.03.06.11.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 11:59:57 -0800 (PST)
Date: Wed, 6 Mar 2024 14:59:56 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] statx: stx_vol
Message-ID: <20240306195956.GA2420648@perftesting>
References: <20240302220203.623614-1-kent.overstreet@linux.dev>
 <20240304-konfus-neugierig-5c7c9d5a8ad6@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-konfus-neugierig-5c7c9d5a8ad6@brauner>

On Mon, Mar 04, 2024 at 10:18:22AM +0100, Christian Brauner wrote:
> On Sat, Mar 02, 2024 at 05:02:03PM -0500, Kent Overstreet wrote:
> > Add a new statx field for (sub)volume identifiers.
> > 
> > This includes bcachefs support; we'll definitely want btrfs support as
> > well.
> > 
> > Link: https://lore.kernel.org/linux-fsdevel/2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq/
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: Josef Bacik <josef@toxicpanda.com>
> > Cc: Miklos Szeredi <mszeredi@redhat.com>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: David Howells <dhowells@redhat.com>
> > ---
> 
> As I've said many times before I'm supportive of this and would pick up
> a patch like this. There's definitely a lot of userspace that would make
> use of this that I'm aware of. If the btrfs people could provide an Ack
> on this to express their support here that would be great.
> 
> And it would be lovely if we could expand the commit message a bit and
> do some renaming/bikeshedding. Imho, STATX_SUBVOLUME_ID is great and
> then stx_subvolume_id or stx_subvol_id. And then subvolume_id or
> subvol_id for the field in struct kstat.

Sorry I had my head down in some NFS problems.  This works for me, I agree with
the naming suggestions you've made.  Kent, when you send a new version I'll
review it and then followup with a btrfs patch.  Thanks for getting this ball
rolling,

Josef

