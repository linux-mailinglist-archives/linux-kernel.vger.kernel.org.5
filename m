Return-Path: <linux-kernel+bounces-41363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F34BE83EFAA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914981F23BA1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907AE2E410;
	Sat, 27 Jan 2024 19:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="G2yo9fmF"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F184D2576B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 19:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706382511; cv=none; b=IhixmCWtZ/e0Nfi8iyPme6raJ8dQjCpNUWFD4klMVu04jlTY+aM88c4vX+b7mD19eRRu2uyFAEG+/YoUVqf6AL6Wwix8B+CVHunyrwoAKrgaSGp98FNhmAvVBh2qbgxx/oCkwTeahslfcz0qmVLf7sLianCr1ACZR42JorAv8G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706382511; c=relaxed/simple;
	bh=BOf1uwV0T5tAdDxkKE8hubYOYuYK37j+DNPhKF3vcuM=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:Message-ID; b=aSvm+FQZVBsJxd0KROMZTJU8daQTAxeU90q6898LWNqdWFDfkllRHSGNVT+GFhLHop79yHVWnrgFilfMagMLYwQBKtIHMmavnFuMsLwzH1+cbZgjhLVtIWe3NyRM7JEy8YUr+wgGMRuoPqGE7IzSDXUYwiXelGIoomFQAZ+PnDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=G2yo9fmF; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id E1383240103
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 19:58:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
	t=1706381917; bh=BOf1uwV0T5tAdDxkKE8hubYOYuYK37j+DNPhKF3vcuM=;
	h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:
	 Cc:Subject:Message-ID:From;
	b=G2yo9fmFM5PyzqtJuzZeb/ABhgTYVUMIPhYEDDjYCcE21GirF8oLy4s0rkZ3Id9k3
	 yXuE62Rng4OT1EctmpoFLViBxIquswNL71+9zgtjtOBi4/6Q32TKHYiPhflEfx10U8
	 tYffcl6+t99MwKeNNaYYqPnedUguzpnyiK8+uUHPv8SjlQVjqT74GOK9Yx8gbcC3yT
	 WId78zg08sbS2h5y6kmCvyrXHMF/0+Be4kd0dh/68kuU1yOtKFcdwGbDa0nj4JTaDU
	 kH/1HME6Yd5FESYthhBgzp1jUy7tNlEaHHRxN1rAN4UTFg2GlZJu1s21aQnrD13yQD
	 B8MYwbMCVylMA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4TMkNs197fz9rxK;
	Sat, 27 Jan 2024 19:58:37 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sat, 27 Jan 2024 18:58:37 +0000
From: a-development@posteo.de
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
 David.Kaplan@amd.com, Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
 gregkh@linuxfoundation.org
Subject: [RFC][PATCH 00/17] Fix up the recent SRSO patches
Message-ID: <cbad6acb30e33e8dd387080e5936cc38@posteo.net>

putting srso=off in the cmdline fixed up my FUSE related issues.
Basically, I could not suspend anymore.
kernel 6.7.1.

This is the behavior with srso enabled... 
https://paste.cachyos.org/p/bae7257

