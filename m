Return-Path: <linux-kernel+bounces-78338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 208F1861213
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2DF91F22D01
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E1E7D41D;
	Fri, 23 Feb 2024 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJp2IlZM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427467CF21;
	Fri, 23 Feb 2024 12:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693134; cv=none; b=NZGd4daou+RsI3bPbpdCGnTiljQ6MJPzi1m8X6UD0xgWgWHDOmEowUNd0nC/izVR/r9wPm8yB1kd11UCM9qT8Ja2EnNwg32AjDwuf1jd6nsD62OC4btJTRmm7q4PmYJuQJR7SKa/A9e32DiHNG9ee/PksGJIcDEelHr+1l2oT7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693134; c=relaxed/simple;
	bh=QbCeKgCF+2cvriyW1QLoaWdnb5N532ueeh9KURAIqHs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=j/mrZK37dqQkRWOKoyXGRPvcN6uPGK+fOelPK4kw6XMosuT9DDYTy7lfRndJ+nOLkDoHz+BTz3rbGv0BCC9N9NNcE7T2HYvOSVfVsAE4CKIpqrJdK8sqX7rgHh/BrGwcc9CnBbzaE0Ia8tNtfIwzDIb2UnBmFlJ20PLO53MdK50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJp2IlZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8429C433F1;
	Fri, 23 Feb 2024 12:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708693133;
	bh=QbCeKgCF+2cvriyW1QLoaWdnb5N532ueeh9KURAIqHs=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=iJp2IlZMJYf0zTzXwC1xyC2pXfRwRwx4+mMd5aQll5KR53OKz4VvvgOvhQQs/Rdue
	 QwYtvvjPvkUpyJwfWICaajy60aetP/WKZihlJ4f5BcL1pxqdqG1UILGD4zyaVYBwLL
	 gd24/y5f+VF9t6rfBXbE08h9IvyAlWRFxn3D1cnlSkE+aqm9fi9SAsEWG6oMdROjJZ
	 B6Gq/zkvlLlCvD4GzPD1FBjVNsExVVB7CvBm+TpJTj5X9XiwRFgtQeQEyplG4jGP+T
	 QOGp6Tf1STo88TjkxlMaoltYPZO/cRKtYxMwpMBshHSxbS3rzaVjd9dRXb1QpwUJ//
	 5KD28RF0n899w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Feb 2024 14:58:49 +0200
Message-Id: <CZCH5V83WBBV.20JR0RC1GJVJY@suppilovahvero>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>, "Lino Sanfilippo"
 <l.sanfilippo@kunbus.com>, "Alexander Steffen"
 <Alexander.Steffen@infineon.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Sasha
 Levin" <sashal@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Cc: "Ross Philipson" <ross.philipson@oracle.com>, "Kanth Ghatraju"
 <kanth.ghatraju@oracle.com>, "Peter Huewe" <peterhuewe@gmx.de>
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.15.2
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-2-dpsmith@apertussolutions.com>
 <CYU3CFW08DAA.29DJY7SJYPJJZ@suppilovahvero>
 <2ba9a96e-f93b-48e2-9ca0-48318af7f9b1@kunbus.com>
 <ae3fecc4-7b76-4607-8749-045e17941923@infineon.com>
 <91f600ef-867b-4523-89be-1c0ba34f8a4c@kunbus.com>
 <CZA9ADCGOTQT.LB5XHZZVTWVH@seitikki>
 <88b75c9c-98ab-4474-8112-6a27d11a2fdf@apertussolutions.com>
In-Reply-To: <88b75c9c-98ab-4474-8112-6a27d11a2fdf@apertussolutions.com>

On Fri Feb 23, 2024 at 3:58 AM EET, Daniel P. Smith wrote:
> > Just adding here that I wish we also had a log transcript of bug, which
> > is right now missing. The explanation believable enough to move forward
> > but I still wish to see a log transcript.
>
> That will be forth coming.

I did not respond yet to other responses that you've given in the past=20
12'ish hours or so (just woke up) but I started to think how all this
great and useful information would be best kept in memory. Some of it
has been discussed in the past but there is lot of small details that
are too easily forgotten.

I'd think the best "documentation" approach here would be inject the
spec references to the sites where locality behaviour is changed so
that it is easy in future cross-reference them, and least of risk
of having code changes that would break anything. I think this way
all the information that you provided is best preserved for the
future.

Thanks a lot for great and informative responses!

> v/r,
> dps

BR, Jarkko

