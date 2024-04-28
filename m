Return-Path: <linux-kernel+bounces-161349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 132058B4B06
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895F91F2157C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DF754FAB;
	Sun, 28 Apr 2024 09:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spsk4.lublin.pl header.i=@spsk4.lublin.pl header.b="nt48oQ09"
Received: from mail.spsk4.lublin.pl (mail.spsk4.lublin.pl [94.230.25.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00A879E1
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.230.25.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714297545; cv=none; b=qZTzUcq9hwb+SI9HRhpsNX/U30FPMf57Xt/5PxmHeR++foqjRSfooJAPzzmysP44l7I3RsW86stoIym0aK/j7zqheNnyuUDCFdUgjcdsRjjmFAd/Z2K6SUpRkoXdn+9YNG15bUgRnr/XTep3S+5f8OBiPvuKDzJ3JCcPErJdExQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714297545; c=relaxed/simple;
	bh=v2c5/7wPZJso13gFAmJxg9/lu4caPLpEZTN0isUs2Yo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z1hOfE2B+ZYEf0SfEOy7NENrvpLes77Zjth2i4bu7a6S3rFgFq9Fb4yx1BBcpIcFkaD+0YQ55JU9Pu+0VakGWlZbHFyaFSqm3+B0Abj7xGDTpBfs152OlduzYnfaK4w96tSMcCENGgiYdmm3uOToLaBRGtctx3BFPz5UIegbPa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spsk4.lublin.pl; spf=pass smtp.mailfrom=spsk4.lublin.pl; dkim=pass (2048-bit key) header.d=spsk4.lublin.pl header.i=@spsk4.lublin.pl header.b=nt48oQ09; arc=none smtp.client-ip=94.230.25.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spsk4.lublin.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spsk4.lublin.pl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.spsk4.lublin.pl (Postfix) with ESMTP id 802BA27DC3
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 11:36:49 +0200 (CEST)
Received: from mail.spsk4.lublin.pl ([127.0.0.1])
 by localhost (zimbra-mta.spsk4.lublin.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id NmuP4t7Dr2lD for <linux-kernel@vger.kernel.org>;
 Sun, 28 Apr 2024 11:36:49 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.spsk4.lublin.pl (Postfix) with ESMTP id 5CDDA27DC7
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 11:36:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.spsk4.lublin.pl 5CDDA27DC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spsk4.lublin.pl;
	s=0B6D5DC2-FF57-11EB-9505-2F96557CE46E; t=1714297009;
	bh=v2c5/7wPZJso13gFAmJxg9/lu4caPLpEZTN0isUs2Yo=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=nt48oQ09TZixHKaxLK7VvErMFRBOcQusJfutT4asQXj/AIsieMFV1ADm8ggxvkC6m
	 n40fIhp8jaKf8uMWU8QxPkxrMW1fUTd7FdcqhNNGMqkoc5frLOidp7leqciqrUqX+i
	 BMdoDHidR/snsLUs1fTuj/oOH7mntBXkNsXFMhEi2FQ9zbG9evnSjK2nqny+yJAQPq
	 1NNC+qUbvfty5CpI1Jk/Em4QnR5B5bJgMoezgyGPUoOjCQU9V22dO6Kt0zPRlCH/pY
	 lY/SYZd8/oR2+irmbQLdtD2sltEkGpqn9oulpHnu52qO1wpz9sj4zXHIBI4GRgciiJ
	 20tDUh+KaODBg==
X-Virus-Scanned: amavis at 
Received: from mail.spsk4.lublin.pl ([127.0.0.1])
 by localhost (zimbra-mta.spsk4.lublin.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id EEwyiX_lVP8R for <linux-kernel@vger.kernel.org>;
 Sun, 28 Apr 2024 11:36:49 +0200 (CEST)
Received: from spsk4.lublin.pl (unknown [5.253.206.184])
	by mail.spsk4.lublin.pl (Postfix) with ESMTPSA id 7BAEA27DC3
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 11:36:48 +0200 (CEST)
Reply-To: cheng@xinyisolar-sale.com
From: "Cheng Kin"<Marta.Orzel@spsk4.lublin.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Representative
Date: 28 Apr 2024 19:35:00 +1000
Message-ID: <20240428193459.D5E31831DE49FDA5@spsk4.lublin.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello linux-kernel,

I apologize for my cold outreach.

My company is interested in your service as a company=20
representative. I have also reviewed your profile and know your=20
eligibility to work with the company.

Have a great day ahead.

Best Regards,
Cheng Kin
Executive Director
Xinyi Solar Holding Co., Ltd

