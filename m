Return-Path: <linux-kernel+bounces-139339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D90798A0194
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789881F23638
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF2B181D0A;
	Wed, 10 Apr 2024 20:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="j1G70P5U"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84FD181CEB;
	Wed, 10 Apr 2024 20:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712782737; cv=none; b=GQOEYUNC2/i9FxowKyYUPSz3YUTHxWRDlwKmCAR89A0P4WmVof8ZozuRUO/6VgCBJ3Pavt33Zla+085YOAi6Q9mrY4rDXaxybZZ88Ie/sDxzi5sBLs8sIE2BsggqA+Qa15teIqN8PnMAoUSYy1t3cf8H0Mi6hP2oDwDRgRivO2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712782737; c=relaxed/simple;
	bh=+/tK43G6OWAgoc1IQTUZhMc0O85NKgsfQkWwbiBN2Vs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gjcio1guYno6LCf9G1PTBXd4vNT2YCWZC4PSVcXXMrkLSFj/DYPQMNrtOQuiEn5ZGOA/xvUiiA5rpp/U3/NUE2A4eEes/JVwmvbHtjJuYW3Xkvz0gsG+efypSkjcoX3jrHRvoMbbXw/y2YWbJRBPbf69j9sXLtGBdYMsPAsqnkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=j1G70P5U; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0C3A347C3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1712782735; bh=jqS9ei4MBkFAHGGRpxDKU18p0pVh8bcbcGcggGmQPfM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=j1G70P5UhkT/YPryiPKQIArCsyH4ERz/0JWB3XBZtl+d1Mh99m05L24oxivtAZIPy
	 m71uNgfsE++Dp36nTk1fVseOW4fYvwrXSwXMyo5P46FCn5CBGeAyeLEiDLq0XnUFbl
	 kncHD8tWB8e/3mJDAIk4O9n7dySWBLS0vcgccdUB/TJcgSgM2HdahM2eaiZblhw6SU
	 RGSNQ5hZYrwqlEwOfgsOO0RYPNybsBcuzVdbcsXVE8swol0cYzkgKctQWU+ZQ9yNu5
	 zdZtBbMjEhZKJXOdhAZBG7fB8LLgMh0cOi8kil2LHoPrw4yMbB/on/tp9nscMn5BBe
	 QOIGftY6OqdVg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0C3A347C3E;
	Wed, 10 Apr 2024 20:58:54 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: regressions@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/2] docs: reporting-issue: rework the detailed
 guide
In-Reply-To: <ac847c1c539d5f2c3d55ab363a5038ce6d303424.1711455295.git.linux@leemhuis.info>
References: <cover.1711455295.git.linux@leemhuis.info>
 <ac847c1c539d5f2c3d55ab363a5038ce6d303424.1711455295.git.linux@leemhuis.info>
Date: Wed, 10 Apr 2024 14:58:54 -0600
Message-ID: <87cyqxszn5.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Rework the detailed step-by-step guide for various reasons:
>
> * Simplify the search with the help of lore.kernel.org/all/, which did
>   not exist when the text was written.
>
> * Make use of the recently added document
>   Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst,
>   which covers many steps this text partly covered way better.
>
> * The 'quickly report a stable regression to the stable team' approach
>   hardly worked out: most of the time the regression was not known yet.
>   Try a different approach using the regressions list.
>
> * Reports about stable/longterm regressions most of the time were
>   greeted with a brief reply along the lines of 'Is mainline affected as
>   well?'; this is needed to determine who is responsible, so we might as
>   well make the reporter check that before sending the report (which
>   verify-bugs-and-bisect-regressions.rst already tells them to do, too).
>
> * A lot of fine tuning after seeing what people were struggling with.

So I have read through this, and don't find anything objectionable.  I
will point out that each of those bullet items above might be better
handled in a separate patch; the result might be easier to review.

Thanks,

jon

