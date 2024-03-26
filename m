Return-Path: <linux-kernel+bounces-119425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0719C88C895
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE861F8162B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9EB13C9B4;
	Tue, 26 Mar 2024 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="M1jgghzv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD7413C696;
	Tue, 26 Mar 2024 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711469297; cv=none; b=gSbETM6+sks8HWYpWJJS5eGKReRH5HStoP0lQ+4raI80b14rzhycckhJp6JkfImdPpp60gRvPpktTnwzkPPnqUqY+TEEYGbDnGGZjAFCajtoA36XjhxeFBWDf/dFqYnpBPVya+5cFj6/o9IvXaT2V06asO5TBvIb51YXVM9hq1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711469297; c=relaxed/simple;
	bh=1Iwp34WIXn/TPRJOcu6SUvQdBFGuAro05DI9cIwDPXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXddUUhM7Y4tpMV921FymKeAEjEYwXO8lLJiEbS9zuAy80y8t7k2aH2nQ1GzO3pZtD3Pw9FigoDZk9RsbrqWfFlHW2ia3Iq7qQxE0GFz1GCX/k20vReNCIuHOEzgeDQlEF9hX1QAnOuVVtw7sXDyKb72KVwYNTh9okPZajOZq9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=M1jgghzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE23C43394;
	Tue, 26 Mar 2024 16:08:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="M1jgghzv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1711469294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Iwp34WIXn/TPRJOcu6SUvQdBFGuAro05DI9cIwDPXU=;
	b=M1jgghzvfVKreU0mBcGVGtzZHk2OV9tYb1tqg5CHRLMZPqsl38CPcUCaJjWy6GJQ4DxLK1
	zGszGe0R5/4Nq9qpA59l0ViDlrdGkLOgeepIxAyfNmGgoIWk3SDuwcD6mC9Pl3rrIeIbwV
	hJuzVrrBBjRWWKV38kl/gcxEv2NUa60=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bbfa59da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 Mar 2024 16:08:13 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-430b74c17aaso41864931cf.3;
        Tue, 26 Mar 2024 09:08:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4X/86OSAZU5AhvWw7Mczpi17Dffp595NSeWeAa0rxRiF6ZgKymaqFLk7ns1bqIQARJ+iEFZhJGA4epgmfPyXyKHickWVzCc6WwPUnW7em0hrcSXnDwfO1R9KbfSUTZPWmmzLBOc7c5g==
X-Gm-Message-State: AOJu0YzwdvDSUhwWb4RMlqOC0qPVAUASL1hp7dyvWKikTI6mMHgR/Tz/
	Fwv58D7qmrGKfiAzNUEBPUKrNLTQN7pjDi3swzMSzejKIBaMhGGppNa7lHKSFxiB4CtttRBMw5s
	FiEeXFDPIf93mrgmMPYCuEwsJWQs=
X-Google-Smtp-Source: AGHT+IGmAOse6lO9ZTLZGNR+NBxnukkRLki5SveSBOkBWwhjzlU2hXu+7zFK8hA8ygh6wTckyG10wpjQOukzCv4ISfY=
X-Received: by 2002:a05:6214:b63:b0:696:80b5:da5f with SMTP id
 ey3-20020a0562140b6300b0069680b5da5fmr72154qvb.38.1711469292642; Tue, 26 Mar
 2024 09:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325120122.4452a813@canb.auug.org.au>
In-Reply-To: <20240325120122.4452a813@canb.auug.org.au>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 26 Mar 2024 17:08:03 +0100
X-Gmail-Original-Message-ID: <CAHmME9pte7Uh4W0Hc8bjL1zTWwH452W3FqBJdJ+YZfGT=qDYQA@mail.gmail.com>
Message-ID: <CAHmME9pte7Uh4W0Hc8bjL1zTWwH452W3FqBJdJ+YZfGT=qDYQA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the random tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Fixed.

