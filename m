Return-Path: <linux-kernel+bounces-82351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F51B86831F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82FE3B240DA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74831131E53;
	Mon, 26 Feb 2024 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaZq903s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63B4131E36;
	Mon, 26 Feb 2024 21:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983168; cv=none; b=aiEuCg3QPcV+jLes3SJoO60wkV2DYGbMmFLJqsgkCrJL8nzwz1QqMGdHvT16ZdHOytGqi9wiFS5TGU3tQOYs3vtaAYb8zr5fbhU9vo9v5xitOlRxXEIDXgAJGVR8bBkyg64y74xazQk5gKOoMiLVhpLjiwbrBSYgP646iqVznbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983168; c=relaxed/simple;
	bh=QgTMkNbqZ+DJ0W36PoSEg8EZurQhcpqm5UWGM61AQWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nh/JNN7mbSyWckp/BCgv8bRwO1ool7C8BRa3Mapsig/9CzQPgXzfgAMajvgZKSjh4A0zhYLQ7PwU3Zc+DnjI+pC7JRcKmSRKkcCZAdFMBvszThTNT/o6mMZDmsM8fagL6ZZe+Emp/52oy9+Pj6f+C/4OA6qupMHvvw5TSkz41n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaZq903s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31153C43141;
	Mon, 26 Feb 2024 21:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708983168;
	bh=QgTMkNbqZ+DJ0W36PoSEg8EZurQhcpqm5UWGM61AQWU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QaZq903sbcEdcrLewBaquhnpmlrqWVCuk9eztXybhDceDRAmnwXCCZs9ZyUeM4GFa
	 carpoz6l0FrWqypNIDljf3v2vpt+0PzDrOeMz/51w72PfUqrJO1jW7JnmPVMGN8mXo
	 5msIEOrp8qpNdrrnq/dZL509pbHA6haljqqXXD7a326N1Ncp7Dnww61QNfFtDvcUxh
	 KC9Q3wDk51FDVeb+Zc+WlziUXPrHhooPSfEY+gSmkfezA8LHuD4e7k86hFa4rPlHK5
	 /WHaHLw5aVITEG0nx+mU7iLoDCiwlSbHLu+/6sUnlPkJj9xCAnaZ9hH/mFoFYa1PhR
	 +wXb/6X/f7YTA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d23d301452so50135071fa.1;
        Mon, 26 Feb 2024 13:32:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVTA9MEXxgvpux4NyJg2S6QsgYJrG1Q2n0YRrog8yNHAJgx2mMrv9UmmpVFzL4ew9od4El/ZNccWctCvSq9x3lf9m8KFG2XQu97OeiatU10ApXTS+/nL+um5zkUeJrsaBcEmxVfbqy8yQ==
X-Gm-Message-State: AOJu0Yz8+IiyC5wFiWpr//SN+F/wd7rFuEfH7LvabfTl4kq5iSggiU65
	Nck5g1NEyGM8aWY9kn0Wko/HK2DSlMw4WmSf5jplw14LbiHPP3qP3vTs9TjhKPid20CvPhwP9Nr
	y4QN4gXcXwtTR+ccPOikax2sk6Ag=
X-Google-Smtp-Source: AGHT+IGJPETZdmWcv1JcMtiZcXDLQv9UNuQ6Q6W5+SuFDNMnsgjclOHgfStps+kqDAwzcB+ESoPgFRoAKA3M3BbOXpM=
X-Received: by 2002:ac2:4c49:0:b0:512:e704:44bc with SMTP id
 o9-20020ac24c49000000b00512e70444bcmr6524321lfk.23.1708983166391; Mon, 26 Feb
 2024 13:32:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226031444.3606764-1-linan666@huaweicloud.com>
In-Reply-To: <20240226031444.3606764-1-linan666@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Mon, 26 Feb 2024 13:32:34 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7meDZA26xEZAEZ6tFrh0FweA_zJXrXKh+pm-5S5qMQ8A@mail.gmail.com>
Message-ID: <CAPhsuW7meDZA26xEZAEZ6tFrh0FweA_zJXrXKh+pm-5S5qMQ8A@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] bugfix of MD_CLOSING and clean up md_ioctl()
To: linan666@huaweicloud.com
Cc: shli@fb.com, neilb@suse.com, mariusz.tkaczyk@linux.intel.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 7:20=E2=80=AFPM <linan666@huaweicloud.com> wrote:
>
> From: Li Nan <linan122@huawei.com>
>
> Changes in v7:
>  - adapt to md-6.9 branch.

LGTM. Applied to md-6.9 branch. Thanks!

Song

