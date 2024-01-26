Return-Path: <linux-kernel+bounces-39486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814FF83D1EE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF651C24D18
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B4010F5;
	Fri, 26 Jan 2024 01:15:04 +0000 (UTC)
Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com [115.124.28.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F51C4683;
	Fri, 26 Jan 2024 01:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706231703; cv=none; b=S/opoBdYZY6J92x/rRQuqyrqFUGIBtZGWSKFPAfGNQpKEs8a8xPEPOLFS4o8OgsxZeatbQPHzENr44BJpg8ePvig6Qm+WQCx8F1y5KAdgFquHKl87AWN7iwQTHgociQm0Vu4z6WxGUNRECTDnkf6DJ+HpLolVv3FDLc6NP3HA/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706231703; c=relaxed/simple;
	bh=FMwtVHTmxAGlaBDsl/6/3KrW1fighMyMZHNpy1DBJxI=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=NQE7NNOAt8fBeNJ69C8FWNEpkSipTvo054KCItmiWIXkRtI52VSMMAoiauKoVBPgaJN/M4zo58HB6cW0YoPBdVylAh/BXOLqBOreAMqLcFFQ9ryGZRQpuDj4JW92AJvNB5nEqiEpLhYXjov1i0vXfuLMComyRHWfKZiSzvunJJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ubisectech.com; spf=pass smtp.mailfrom=ubisectech.com; arc=none smtp.client-ip=115.124.28.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ubisectech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ubisectech.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.3014811|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.062876-0.00401077-0.933113;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=bugreport@ubisectech.com;NM=1;PH=DW;RN=6;RT=6;SR=0;TI=W4_0.2.3_v5_21282248_1706230868553_o7001c77u;
Received: from WS-web (bugreport@ubisectech.com[W4_0.2.3_v5_21282248_1706230868553_o7001c77u]) at Fri, 26 Jan 2024 09:14:48 +0800
Date: Fri, 26 Jan 2024 09:14:48 +0800
From: "Ubisectech Sirius" <bugreport@ubisectech.com>
To: "=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?=" <toke@toke.dk>,
  "linux-trace-kernel" <linux-trace-kernel@vger.kernel.org>,
  "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: "johannes" <johannes@sipsolutions.net>,
  "kvalo" <kvalo@kernel.org>,
  "linux-wireless" <linux-wireless@vger.kernel.org>
Reply-To: "Ubisectech Sirius" <bugreport@ubisectech.com>
Message-ID: <42e06f48-a2cf-40ef-8a43-eb1bf3b946c0.bugreport@ubisectech.com>
Subject: =?UTF-8?B?5Zue5aSN77ya5Zue5aSN77yaZ2VuZXJhbCBwcm90ZWN0aW9uIGZhdWx0IGluIGF0aDlrX3dt?=
  =?UTF-8?B?aV9ldmVudF90YXNrbGV0?=
X-Mailer: [Alimail-Mailagent revision 79][W4_0.2.3][v5][Chrome]
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ed1d2c66-1193-4c81-9542-d514c29ba8b8.bugreport@ubisectech.com> <878r4e4q69.fsf@toke.dk> <fb3ea26f-f9b6-4107-bb03-ca4893f0495f.bugreport@ubisectech.com>,<0320fac8-68dd-40a6-bb38-1da0d71d0dbd.>
x-aliyun-mail-creator: W4_0.2.3_v5_M3LTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEyMC4wLjAuMCBTYWZhcmkvNTM3LjM2vN
In-Reply-To: <0320fac8-68dd-40a6-bb38-1da0d71d0dbd.>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

PkdyZWF0LCB0aGFuayB5b3UgZm9yIHRlc3RpbmchIEknbGwgc2VuZCBhIHByb3BlciBwYXRjaC4g
SG93IHdvdWxkIHlvdQo+bGlrZSB0byBiZSBjcmVkaXRlZCB3aXRoIHJlcG9ydGluZz8gSnVzdCBh
cyAnVWJpc2VjdGVjaCBTaXJpdXMKPjxidWdyZXBvcnRAdWJpc2VjdGVjaC5jb20+JyA/CgpIZWxs
by4KICAgIFBsZWFzZSB1c2UgJ1ViaXNlY3RlY2ggU2lyaXVzPGJ1Z3JlcG9ydEB1YmlzZWN0ZWNo
LmNvbT4nIHRvIGNyZWRpdCB0aGUgcmVwb3J0LiBUaGFua3MuCg==

