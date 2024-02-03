Return-Path: <linux-kernel+bounces-50939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE8E84840B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 07:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478741F22CBC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 06:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DA311725;
	Sat,  3 Feb 2024 06:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="hQmjl2k5";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="hQmjl2k5"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FA1111A9;
	Sat,  3 Feb 2024 06:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706940231; cv=none; b=Iy55PbeFcqeM/XPRkbB/hoOsHgNOyx4GDkJKpRQEyIARlF+RlcS4NSobvyBkGgVmKji7+U/q+cus1vVq31/brhTmEoLsz8xupd/0/V76hZH7x14ir17Zp8MBJn9/DLyRrquk0Oxhis/FDcJXrtgg9QHGSfZJ5/sb7CTHjE+nlEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706940231; c=relaxed/simple;
	bh=eNd1ClVX59J0wqBIkVpAFV3QDg4zYqccFUENcGjqt+w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=apcy7XdZIJiEnRGBe/KEww3C7BGMgN7KFXMCiOViMSDaLD9VEWNQj9VSSW66emV22P1SW4f9AoimPJ6Ix3n3FNcM7aFns3Lw19zIuxNgFaLdf8jG6Ry847Q8NacDC6SIOq1JJHpfWMOMb+KTm09t/fnQJMJ6aFdJzTb5Eh+YsOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=hQmjl2k5; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=hQmjl2k5; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1706940226;
	bh=eNd1ClVX59J0wqBIkVpAFV3QDg4zYqccFUENcGjqt+w=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=hQmjl2k51DpQPx7lmCq+fB/7Ex/oy2kpEsZ730BpnAjWofxjmh1SPSf5Ljt14aY8b
	 hCR2pTR4h/fOVqOrvQu9zjVGyiMmmdX+wklOSCEbg66k7lTVYypMonR/qLYAnD0X0d
	 PDNAd/Q/7OYHgn0U9c7LWYrHcNzjmSUhWRuv0vjg=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id BE3DF128609F;
	Sat,  3 Feb 2024 01:03:46 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id V5jh_h4SDLnw; Sat,  3 Feb 2024 01:03:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1706940226;
	bh=eNd1ClVX59J0wqBIkVpAFV3QDg4zYqccFUENcGjqt+w=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=hQmjl2k51DpQPx7lmCq+fB/7Ex/oy2kpEsZ730BpnAjWofxjmh1SPSf5Ljt14aY8b
	 hCR2pTR4h/fOVqOrvQu9zjVGyiMmmdX+wklOSCEbg66k7lTVYypMonR/qLYAnD0X0d
	 PDNAd/Q/7OYHgn0U9c7LWYrHcNzjmSUhWRuv0vjg=
Received: from [172.22.1.223] (66.224-78-194.adsl-static.isp.belgacom.be [194.78.224.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4E30D128609C;
	Sat,  3 Feb 2024 01:03:44 -0500 (EST)
Message-ID: <42e14f74d3819c95fdb97cd2e9b2829dcb1b1563.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH v2 0/4] tsm: Runtime measurement registers ABI
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Dan Middleton <dan.middleton@linux.intel.com>, Samuel Ortiz
	 <sameo@rivosinc.com>, Dan Williams <dan.j.williams@intel.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
  Qinkun Bao <qinkun@google.com>, "Yao, Jiewen" <jiewen.yao@intel.com>,
 "Xing, Cedric" <cedric.xing@intel.com>, Dionna Amalie Glaze
 <dionnaglaze@google.com>,  biao.lu@intel.com, linux-coco@lists.linux.dev,
 linux-integrity@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Sat, 03 Feb 2024 07:03:40 +0100
In-Reply-To: <a255bc36-2438-41b7-b304-bcf7a6628bef@linux.intel.com>
References: <20240128212532.2754325-1-sameo@rivosinc.com>
	 <c17a31e4fb30f5f9d4a337e5bd8d54cc6f99eef7.camel@HansenPartnership.com>
	 <a255bc36-2438-41b7-b304-bcf7a6628bef@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2024-02-02 at 17:07 -0600, Dan Middleton wrote:
> 
> On 2/2/24 12:24 AM, James Bottomley wrote:
> > On Sun, 2024-01-28 at 22:25 +0100, Samuel Ortiz wrote:
> > > All architectures supporting RTMRs expose a similar interface to
> > > their TVMs: An extension command/call that takes a measurement
> > > value and an RTMR index to extend it with, and a readback command
> > > for reading an RTMR value back (taking an RTMR index as an
> > > argument as well). This patch series builds an architecture
> > > agnostic, configfs-based ABI for userspace to extend and read
> > > RTMR values back. It extends the current TSM ops structure and
> > > each confidential computing architecture can implement this
> > > extension to provide RTMR support.
> > What's the actual use case for this?  At the moment the TPM PCRs
> > only provide a read interface to userspace (via
> > /sys/class/tpm/tpmX/pcr-shaY/Z) and don't have any extension
> > ability becuase nothing in userspace currently extends them.
> > 
> > The only current runtime use for TPM PCRs is IMA, which is in-
> > kernel (and which this patch doesn't enable).
> > 
> > Without the ability to log, this interface is unusable anyway, but
> > even with that it's not clear that you need the ability separately
> > to extend PCRs because the extension and log entry should be done
> > atomically to prevent the log going out of sync with the PCRs, so
> > it would seem a log first interface would be the correct way of
> > doing this rather than a PCR first one.
> > 
> > James
> > 
> > 
> 
> While we clearly need to cover PCR-like usages, I think Confidential
> Computing affords usages that go beyond TPM.

Well, don't get me wrong, I think the ability to create non repudiable
log entries from userspace is very useful.  However, I think the
proposed ABI is wrong: it should take the log entry (which will contain
the PCR number and the hash) then do the extension and add it to the
log so we get the non-repudiable verifiability.  This should work
equally with TPM and RTMR (and anything else).

The issue, I suppose, is what log format?  The TCG has one which is
extensible and IMA uses a similar but different binary log format.

> For example, Attested Containers [1] (and similar explorations in
> CNCF Confidential Containers [2]) extends the measurement chain into
> the guest. There, a trusted agent measures container images, and
> extends an RTMR with those measurements. Particularly in the case of
> containers, the  existing runtime infrastructure is user mode
> oriented. However the generalization here is in providing a mechanism
> to strongly identify an application or behavior provided by the TVM.

There's a similar proposal for Keylime which was demo'd at Plumbers
last year, except it uses IMA to measure the container so you only have
to trust the kernel:

https://lpc.events/event/17/contributions/1571/

> Less concretely, I think this is an area for developer creativity.
> Attestation is one of the main APIs that CC gives application
> developers and
> these runtime extendable fields provide a further degree of
> creativity.
> 
> [1] ACON https://github.com/intel/acon

Just on this, lest we repeat the errors of the past (and believe me
there was a time people thought that simply extending TPM PCRs without
log entries was the way to do measurements), if you're extending a PCR
like entity you also need a log entry to tell people who come after you
what you've done.  Even in the one ephemeral VM per pod kata use case
(with RTMRs local to the VM), you'll still likely be starting several
sidecars and if you don't have a log to tell you the order you measured
the containers deriving the RTMR value is a combinatoric explosion.

James


