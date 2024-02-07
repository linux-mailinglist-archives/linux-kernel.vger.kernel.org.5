Return-Path: <linux-kernel+bounces-57239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE44284D58B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E1628DD3A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823AB1339AD;
	Wed,  7 Feb 2024 21:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ZJdIUXTV";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ZJdIUXTV"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F9D128839;
	Wed,  7 Feb 2024 21:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707342402; cv=none; b=tt54sLwSUizy3HFWoFPl9PdQiMlNhxftwq6ecId4iFBdcBgDBG7wjr2yXinxL1dbvy94FI5Pg5DOI4WqxzswIqKXK8b3gUw4WFeDvktYE2X+lVRZeLxsErzzXHp96hLWgekQGECTHvUtgaEQH932NkcZaTqwoJWbV0T980tuscI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707342402; c=relaxed/simple;
	bh=5Wq5XepFX7KipWqC5rMU8UDQDlUIbiTkgTTlIit02w0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ai3yX3obPwARfyyUswXlCqlK+EFBHRswhG/AE4QDylk4jVwm2ZqaD75JqeajcNahzC62allb2ETVGRs0s5N7a2+XGHU62as/AgEwFwRtwoqrr+RynjZ/479p+pZk6kp4tE0abO6mi6AH8zkROBn1yz1KFbkmQ7lO3RTS3VXL0w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=ZJdIUXTV; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=ZJdIUXTV; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1707342399;
	bh=5Wq5XepFX7KipWqC5rMU8UDQDlUIbiTkgTTlIit02w0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=ZJdIUXTVYGIztILl5RnDiKes3CjE/8d4qui7VZ3ywTRTxjBjgktqhGUqQTwHpniea
	 SIEZA7v9ctmuYBccJabmNAfIHHOGa9KSXC7Y9boGimZdsmG3Fy0w1FRT6OD4AwrBpF
	 dnBERBXZZdOc2/+DwGRPdPNYGvUP2bb/4XeLZTCE=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id E96DA1287246;
	Wed,  7 Feb 2024 16:46:39 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 6rQ-zAb7-YI0; Wed,  7 Feb 2024 16:46:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1707342399;
	bh=5Wq5XepFX7KipWqC5rMU8UDQDlUIbiTkgTTlIit02w0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=ZJdIUXTVYGIztILl5RnDiKes3CjE/8d4qui7VZ3ywTRTxjBjgktqhGUqQTwHpniea
	 SIEZA7v9ctmuYBccJabmNAfIHHOGa9KSXC7Y9boGimZdsmG3Fy0w1FRT6OD4AwrBpF
	 dnBERBXZZdOc2/+DwGRPdPNYGvUP2bb/4XeLZTCE=
Received: from [172.20.41.137] (unknown [12.248.214.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id CD9E412871FD;
	Wed,  7 Feb 2024 16:46:38 -0500 (EST)
Message-ID: <332775d7218843d6cc168c963d76e6841eab5d5b.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH v2 0/4] tsm: Runtime measurement registers ABI
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
  "Xing, Cedric" <cedric.xing@intel.com>, Dan Williams
 <dan.j.williams@intel.com>, Dan Middleton <dan.middleton@linux.intel.com>,
 Samuel Ortiz <sameo@rivosinc.com>
Cc: Qinkun Bao <qinkun@google.com>, "Yao, Jiewen" <jiewen.yao@intel.com>, 
 Dionna Amalie Glaze <dionnaglaze@google.com>, biao.lu@intel.com,
 linux-coco@lists.linux.dev,  linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 07 Feb 2024 16:46:36 -0500
In-Reply-To: <527da630-4952-4b1d-80c0-5a87997ff9fd@linux.intel.com>
References: <20240128212532.2754325-1-sameo@rivosinc.com>
	 <c17a31e4fb30f5f9d4a337e5bd8d54cc6f99eef7.camel@HansenPartnership.com>
	 <a255bc36-2438-41b7-b304-bcf7a6628bef@linux.intel.com>
	 <42e14f74d3819c95fdb97cd2e9b2829dcb1b1563.camel@HansenPartnership.com>
	 <1557f98a-3d52-4a02-992b-4401c7c85dd7@linux.intel.com>
	 <85b7a4a679eada1d17b311bf004c2d9e18ab5cd3.camel@HansenPartnership.com>
	 <b8140cc8-a56b-40f6-a593-7be49db14c77@intel.com>
	 <fe1722c3618a8216cb53b8fd3f1b7cbb6fdff5a0.camel@HansenPartnership.com>
	 <65c2e4aa54a0_d4122947f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	 <22088ed3-51a4-415f-932c-db84c92a2812@intel.com>
	 <527da630-4952-4b1d-80c0-5a87997ff9fd@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-02-07 at 13:08 -0800, Kuppuswamy Sathyanarayanan wrote:
> 
> On 2/7/24 12:16 PM, Xing, Cedric wrote:
> > On 2/6/2024 6:02 PM, Dan Williams wrote:
> > > James Bottomley wrote:
> > > > There isn't really anything more complex about an interface
> > > > that takes a log entry, and does the record an extend, than an
> > > > interface which takes a PCR extension value.  So best practice
> > > > would say that you should create the ABI that you can't get
> > > > wrong (log and record) rather than creating one that causes
> > > > additional problems for userspace.
> > > 
> > > Agree, there's no need for the kernel to leave deliberately
> > > pointy edges for userspace to trip over.
> > > 
> > > Cedric, almost every time we, kernel community, build an
> > > interface where userspace says "trust us, we know what we are
> > > doing" it inevitably results later in "whoops, turns out it would
> > > have helped if the kernel enforced structure here". So the log
> > > ABI adds that structure for the primary use cases.
> > 
> > Dan, I agree with your statement generally. But with the precedent
> > of TPM module not maintaining a log, I just wonder if the addition
> > of log would cause problems or force more changes to existing
> > usages than necessary. For example, IMA has its own log and if
> > changed to use RTMR, how would those 2 logs interoperate? We would
> > also need to decide on a log format that can accommodate all
> > applications.
> 
> 
> IIUC, CC event logging in firmware uses TCG2 format. Since IMA
> internally uses TPM calls, I assume it also uses the TCG2 format. I
> think we can follow the same format for RTMR extension.

Just to correct this: IMA uses its own log format, but I think this was
a mistake long ago and the new log should use TCG2 format so all the
tools know how to parse it.

> I am wondering where will the event log be stored? Is it in the
> log_area region of CCEL table?

IMA stores its log in kernel memory and makes it visible in securityfs
(in the smae place as the measured boot log).  Since this interface is
using configfs, that's where I'd make the log visible.

Just to add a note about how UEFI works: the measured boot log is
effectively copied into kernel memory because the UEFI memory it once
occupied is freed after exit boot services, so no UEFI interface will
suffice for the log location.

I'd make the file exporting it root owned but probably readable by only
the people who can also extend it (presumably enforced by group?). 

James


