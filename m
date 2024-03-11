Return-Path: <linux-kernel+bounces-99345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294578786FA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586CF1C21114
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CABE53E22;
	Mon, 11 Mar 2024 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUot0MVm"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C92552F61
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710180380; cv=none; b=Tm4p42Qz3ZAqmN+FO0owQ+oCh4BG0nG2Z2Gu9JN1NcF6t2RCf1FWIf3oJYcjocbWduParfan5NZCNRaBWe+1663w218qEFkR48pEIoQinvJslq3OkwnSzeSVbTWHSRTHpkOR1BMr4IG4b/5L3EcQTulwWl/5ENpYEdhyFP70RrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710180380; c=relaxed/simple;
	bh=LP3TlOswg5wTsp/ZCP3kUfUuW3wo3f10c0fOqwS9csE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0aNboJFVPez3ZVX6GqZoAtTa5OZQYtXerZgv1ujRk+s7sPKSxR3M3JmIdwbWX6UEzc6sMC6Dtqu3N0+QhhJDA7AnaYUpISCNMMuyRBUdU0AtKkdYFkhau02PrAG04DA5REcgc/dkdEhGlqlssQjRgL4fO2DSlAVput95W1QhM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUot0MVm; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e5dddd3b95so3401266b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 11:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710180378; x=1710785178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m0+cxV4i5vz/lRVFARGwV33Cfm2tLK/wH7relVlcMGA=;
        b=eUot0MVmrJFimTQrrzyWw84BqXTlu6LaqPKi8EXA/q1MjT1eGLcrt2MRf1sDk18Xsa
         zqCQ1/L7M+HW7xtMytCXs5sQmF9BEcOWvB+LPhjheG/Q7WvhtCv1bScHGiXdAsXffuRK
         l0xn9LUdD6ORsMnm131IU+M/fjdCtv+Kq3eFePsFwauAOhZwcSNa4blDouDdQSzow5NI
         pyFZW7C8seMfWJKAa3KjymFR3oXOREjICV3wTziidaK89Zm4l0/W7ArNub+AlpHRys3Z
         s4FQ1yjRk6XGb3mgWxGPN6r0K9DKkrhbegYh1pi9jNdXxwQxwqKia1Px7yfuyYzCf2I+
         xwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710180378; x=1710785178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0+cxV4i5vz/lRVFARGwV33Cfm2tLK/wH7relVlcMGA=;
        b=uS4YPK08kHlRY1TM1DxcQLozXrq1AS0J4f4rax/eDrUF8VCVdtPBxwwr5zY/7NoOXF
         BIpyiYsm3nbUU5ERCqjD+AM8VAD55D9lWFFKtWJlg462FdRPBCN/nG7G0IMryzOfEwGu
         UxevTqnNAPrDu4MWMkfK8R+hEJFb4M7aXQ6v3/bdAlV4uycAjO5ooWUwOiUECcKVA9DK
         /osaZ9ZObVWBKY9Ab3u0S3jgbmtuQSKr2+EVSc+4eQL5YdxOIOm3H/CMXEmf3o89fA6J
         kUIffdcbD1pGfBUKliYwUbqfAuZp8I+kiAxX1AlzKP3bR3leDoSWU/awAyFj5SFsbCRI
         RpWw==
X-Gm-Message-State: AOJu0YymXHg4C1fP4CAMdPGHpl939L7l5z0k28dM2SNho4957hTe2H4c
	L8jXouLDr68kuK400FEHb/blK+2luNW/YqwLfS2uSYqhpNChUf/Fvx7VWmda
X-Google-Smtp-Source: AGHT+IHkdYTrIxoH87q4v2406n6aQut7bMd0S5cLKL+KlJ0/l3kefEc64e1MDufqpodsGTQjobVATg==
X-Received: by 2002:a05:6a00:188f:b0:6e6:9ac5:2c4 with SMTP id x15-20020a056a00188f00b006e69ac502c4mr2848916pfh.7.1710180377767;
        Mon, 11 Mar 2024 11:06:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x18-20020aa784d2000000b006e571bef670sm4665029pfn.70.2024.03.11.11.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 11:06:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 11 Mar 2024 11:06:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.8
Message-ID: <e525e9ac-b745-49f5-b219-b4dca77c658d@roeck-us.net>
References: <CAHk-=wiehc0DfPtL6fC2=bFuyzkTnuiuYSQrr6JTQxQao6pq1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiehc0DfPtL6fC2=bFuyzkTnuiuYSQrr6JTQxQao6pq1Q@mail.gmail.com>

On Sun, Mar 10, 2024 at 02:06:37PM -0700, Linus Torvalds wrote:

[ ... ]

> everybody who sent in early pull requests, you know who you are. But
> before that excitement commences, please do spend a bit of time with
> the now boring old status quo and give 6.8 a good test, ok?
> 

Build results:
	total: 158 pass: 158 fail: 0
Qemu test results:
	total: 549 pass: 549 fail: 0
Unit test results:
	pass: 215772 fail: 302

Nothing news, really. Unit test failures are retty much unchanged.
- mean_and_variance_test_2 and mean_and_variance_test_4 are still broken
  both in mainline and linux-next.
- m68k:q800:stackinit should be fixed in linux-next
- most of the IP checksum test failures are still present in mainline but
  fixed in linux-next. One notable and still unhandled checksum test
  failure is the failure seen in sh4 emulations. It is due to upstream
  commit cadc4e1a2b4d ("sh: Handle calling csum_partial with misaligned
  data") which is broken and would have to be either fixed or reverted.
  I added it to the regression tracker, so it should show up there in
  the near future. 

There are also still some warning backtraces.

- dev-addr-list-test with lock debugging triggers backtraces due to
  conceptual problems with kunit tests (locks are not necessarily
  requested and released from the same thread).
- WARNING: inconsistent lock state in stmmac code.
  Tracked in regression tracker.

Guenter

