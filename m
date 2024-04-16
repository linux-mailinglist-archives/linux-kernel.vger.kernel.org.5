Return-Path: <linux-kernel+bounces-146173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7D68A61A7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD3E3B2397E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672A1374FB;
	Tue, 16 Apr 2024 03:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b="PxluG/gy"
Received: from rn-mailsvcp-mx-lapp02.apple.com (rn-mailsvcp-mx-lapp02.apple.com [17.179.253.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750421946F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 03:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.179.253.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237788; cv=none; b=n1l9mhZ/VJsB+UHUPgZdXWFEeKVZCK3iWancAQgHrKSWbOWhZhU04FBtzYALrrTQc8Spfvqno03c9L6UygznpEXlkBwTsGbD53V2kVVf69Ud3FdCyvp2x4STfc8326P/hj8HhbueO3/qGg5sC4LEHF44A/pabenE7/Oa0Fitqo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237788; c=relaxed/simple;
	bh=WwzWSRaDGLC7Jl3VN4s5jShOzj49M6d0mhTOVh8VTl4=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=gKMoN1QjJrK1RzvaqWqKvAJ9gUQXW9uL4ENz5KZVomGI5RdM+Jgf//fbkVLr2AOGS0wUIfsTLTUjusJQFZLFTdS5gzFIQKWI3NhHq14wSBkOFeA/dvMGa2nsAlDvoKn9U7rQ4gUgxGD2GRoWwDGGoem2e3YO2yyCJ0i9sp8GgHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com; spf=pass smtp.mailfrom=apple.com; dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b=PxluG/gy; arc=none smtp.client-ip=17.179.253.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apple.com
Received: from rn-mailsvcp-mta-lapp04.rno.apple.com
 (rn-mailsvcp-mta-lapp04.rno.apple.com [10.225.203.152])
 by rn-mailsvcp-mx-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SC000T98JYC9920@rn-mailsvcp-mx-lapp02.rno.apple.com>
 for linux-kernel@vger.kernel.org; Mon, 15 Apr 2024 19:23:00 -0700 (PDT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_01,2024-04-15_01,2023-05-22_02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=from : to
 : cc : subject : date : message-id : in-reply-to : references : mime-version :
 reply-to : content-transfer-encoding; s=20180706;
 bh=WwzWSRaDGLC7Jl3VN4s5jShOzj49M6d0mhTOVh8VTl4=;
 b=PxluG/gyNjG1svs3YhUBq1UBtCibg4S7Ga7Z0YhIkKxvgPgatQAZQ/ITzYXkI6dzzffG
 Rlcl40+2We0dWPDQdYqJtUtqDVTPr3spg4LLefsqlkcsOTLOT+giI1a5pua59ZXXUiZB
 fMcGykhp+W8mEssGFONCifScdeKDF8z2y7eNttRbqzTdse5aYLpcvmq6h4/ner64Jl9V
 qgC3MLE6DPyO97oi10vsAN6HYIYEuWi7brFXRZercZ4+fLht3iNs9Q5i7pdWJPOoAt8A
 KCMDdhOW4zx/ZB8neVY+DurLs09vO90uwoaTLRkavYZ58WJHb4f7yCjvhp9c1yyUNHVR Zg==
Received: from rn-mailsvcp-mmp-lapp04.rno.apple.com
 (rn-mailsvcp-mmp-lapp04.rno.apple.com [17.179.253.17])
 by rn-mailsvcp-mta-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SC000G97JYBVWB0@rn-mailsvcp-mta-lapp04.rno.apple.com>;
 Mon, 15 Apr 2024 19:23:00 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp04.rno.apple.com by
 rn-mailsvcp-mmp-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0SC000U00JCL0X00@rn-mailsvcp-mmp-lapp04.rno.apple.com>; Mon,
 15 Apr 2024 19:22:59 -0700 (PDT)
X-Va-A:
X-Va-T-CD: 3075b9643109b0fe17c43e4f1b7ca0e4
X-Va-E-CD: 631f076f6b365e42e06a1df7057e44fb
X-Va-R-CD: ce6be43db0cce57f85f587e814b9d60f
X-Va-ID: a4de5280-170c-473d-9b33-eeac3760abae
X-Va-CD: 0
X-V-A:
X-V-T-CD: 3075b9643109b0fe17c43e4f1b7ca0e4
X-V-E-CD: 631f076f6b365e42e06a1df7057e44fb
X-V-R-CD: ce6be43db0cce57f85f587e814b9d60f
X-V-ID: d01307ab-8361-4e0f-a1dd-199f180af2d9
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_01,2024-04-15_01,2023-05-22_02
Received: from rn-mailsvcp-relay-lapp01.rno.apple.com ([17.11.155.73])
 by rn-mailsvcp-mmp-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023))
 with ESMTPSA id <0SC0004BHJY7NG00@rn-mailsvcp-mmp-lapp04.rno.apple.com>; Mon,
 15 Apr 2024 19:22:56 -0700 (PDT)
From: Zayd Qumsieh <zayd_qumsieh@apple.com>
To: Hector Martin <marcan@marcan.st>, Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Zayd Qumsieh <zayd_qumsieh@apple.com>,
 Justin Lu <ih_justin@apple.com>, Ryan Houdek <Houdek.Ryan@fex-emu.org>,
 Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Mateusz Guzik <mjguzik@gmail.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>, Miguel Luis <miguel.luis@oracle.com>,
 Joey Gouly <joey.gouly@arm.com>, Christoph Paasch <cpaasch@apple.com>,
 Kees Cook <keescook@chromium.org>, Sami Tolvanen <samitolvanen@google.com>,
 Baoquan He <bhe@redhat.com>, Joel Granados <j.granados@samsung.com>,
 Dawei Li <dawei.li@shingroup.cn>, Andrew Morton <akpm@linux-foundation.org>,
 Florent Revest <revest@chromium.org>, David Hildenbrand <david@redhat.com>,
 Stefan Roesch <shr@devkernel.io>, Andy Chiu <andy.chiu@sifive.com>,
 Josh Triplett <josh@joshtriplett.org>, Oleg Nesterov <oleg@redhat.com>,
 Helge Deller <deller@gmx.de>, Zev Weiss <zev@bewilderbeest.net>,
 Ondrej Mosnacek <omosnace@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Asahi Linux <asahi@lists.linux.dev>
Subject: Re: [PATCH 0/4] arm64: Support the TSO memory model
Date: Mon, 15 Apr 2024 19:22:41 -0700
Message-id: <20240416022242.89623-1-zayd_qumsieh@apple.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-reply-to: Hector Martin <f6484dcd-ebf6-4b6f-be17-69b05539e33b@marcan.st>
References:
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Reply-to: Zayd Qumsieh <zayd_qumsieh@apple.com>
Content-transfer-encoding: 8bit

>I'm probably going to make myself hugely unpopular here, but I have a
>strong objection to this patch series as it stands. I firmly believe
>that providing a prctl() to query and toggle the memory model to/from
>TSO is going to lead to subtle fragmentation of arm64 Linux userspace.

It's definitely not our intent to fragment the ecosystem.
The goal of this memory ordering is to simplify emulation layers that benefit from this.
If you have suggestions to reduce the risk of it being misused outside of emulators, we'd be happy to look into it.

Thanks,
Zayd

