Return-Path: <linux-kernel+bounces-127053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF1D89463A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 117EDB21275
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6255027F;
	Mon,  1 Apr 2024 20:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJ6d9zDc"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2732E3EB
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 20:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712004450; cv=none; b=VKGpgq286gArK3NGQiD819+ZPvpUBu7pcxnHYkZP2cmDCF3ZfzgBr//RAe6aoQyvvp5E/ymH1c8+HQ1xyOF79QMlZjoFhdRRSkIPaCKmcRzpbUB/98grmlVkay8JzmvjeduTNilFBXkGh2Nz535o6FMAOqurCxr0Ox7yx75Zxjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712004450; c=relaxed/simple;
	bh=fUcKWaylPje7JoEGRLPNgb/gXUPzyY52GFBTMrRUYug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCv6bM7hopbRoEziN/XsiuEID6INplaeXvvvsXWtsZTDj1y87iuNawu5rLgb19HrGqn0bnaowBgZZk8hKfYXbj756n3/PAo3J9l3DQTi3BMbf8XmrMXBPi4u/1rzxsTLFfYIIX95AKPs+Rmb2ZWVeLK4336DUCYqoekZ1C3m7Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJ6d9zDc; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so3988145276.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 13:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712004448; x=1712609248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUcKWaylPje7JoEGRLPNgb/gXUPzyY52GFBTMrRUYug=;
        b=RJ6d9zDcm8W1kBV5u8HZ7HuFSrPqMkGHBKnrEfPcEU2BzVw2MPkewWuxAi/6KikLVf
         AixoH0jx+nyQShVwQG/ZbNDTbZrhauYqwanX4cex1OhlwHrU3Tz/orNvk+IMR1xUxg5B
         jJo5DLMa/Dd7TmCZKvqMS0eZkZWyWLoHPOfJzMsejk4faK2x79LyrMxX5zKmhpyLrXyF
         0haSmvLqmUNZEgKHXSTD5v+pCfYlspS9gSQGdLdjyk4eW2lu6kv2iKhOAjs429QBIjuh
         eGMCYqWGqeUnlikRToI5mQZRjGeclaDPcJAIFQc/F5+dJ5eSIcVcX5PgyKVhGza9yx5i
         r9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712004448; x=1712609248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUcKWaylPje7JoEGRLPNgb/gXUPzyY52GFBTMrRUYug=;
        b=bnK8GKRus7oQZNJtLwP6N2dRnSDtfk5yG9zk4ENzPr7LMGOfwmd/SrIfsuVupwIYoJ
         ZPxcwegEMhnshNX3BxdPVrrkMbrs1V3sMNUO8OmF0/8PJhu6V6Zr07UPGDlUMplyvDc8
         c7YuAqsL1MbGpJv6aY//1zWsmQxdsD/dSVoYCpFGQdsASBuotTNrmi1TB9vZ0yMLpU+B
         zIvP2LIFV800OdfEcLuVSQ7kShJQKlp1m1+aKc8AhNhIem/8wQ61W9lMLXOtufNvL+CI
         Io9//8/60iNSSMYWLM0ZpACIx9804H7tOeIiUPON9PrOyKCugeNzLMD9mRRuoV1uJR2m
         qXsw==
X-Gm-Message-State: AOJu0Ywn17kC8MPFDhojAPW/t7Dg3mqotOyTuwd8OsCpXMRyOw/kRjMr
	OL51o1R/9G1KWRsq9uvNAY7woKvYPUL0dqEyvV1waPRMkcr9MKSOf1EjmBf+LRJpS/7v9GpZ7h1
	xus6vvbFfn93JaWqGhcrUnx62lO6Q9iawNOg=
X-Google-Smtp-Source: AGHT+IGMQ31IZyI1sF5KGelg7Rndph9eLBjm42ggsH1ak4z/OcFWIMsn4LcrqY6f5tjG8qRdjlBF1PVAgfV+MCWZSnE=
X-Received: by 2002:a25:bb51:0:b0:dc6:238e:d766 with SMTP id
 b17-20020a25bb51000000b00dc6238ed766mr8748595ybk.2.1712004448456; Mon, 01 Apr
 2024 13:47:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALaQ_hrVM0dMaFqLshW5NTkkomGSvGnpyLOPx8E0QpniewyxUA@mail.gmail.com>
 <20240329194603.ed67a334f75ba3c933cc8876@linux-foundation.org>
In-Reply-To: <20240329194603.ed67a334f75ba3c933cc8876@linux-foundation.org>
From: Nathan Royce <nroycea+kernel@gmail.com>
Date: Mon, 1 Apr 2024 15:46:52 -0500
Message-ID: <CALaQ_hqHwBKFBFPyantgr59SDpfZHwJFyWimLAZROdDsvA6rwQ@mail.gmail.com>
Subject: Re: Allmodconfig - logic_outb - Boot Panic
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yup. I just figured linux would gracefully handle these sorts of
issues (eg. notify the caller, for them to handle, or just do
nothing).
"ISAPNP" was one of the small handful of things I had to disable from
"allmodconfig" before I could get it to boot.
The latest (and last) was "DEBUG_TEST_DRIVER_REMOVE". I had to add
"dump_stack()" in "__kernfs_remove"" in "fs/kernfs/dir.c" because I
couldn't understand why I was getting other hardware panics for
hardware that DID exist.
So while I wanted "everything under the sun", which "allmodconfig"
delivered, it also delivered things that simply made booting
impossible.
One other requirement for "allmodconfig" is making sure the FS that
root exists on is enabled ('Y', not 'M') for it (common-sense mention
for anyone searching for "allmodconfig" issues).

On Fri, Mar 29, 2024 at 9:46=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
> Could be that the logic_pio driver is crashing when the hardware isn't th=
ere.

