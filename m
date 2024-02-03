Return-Path: <linux-kernel+bounces-51025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D652C84852D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 11:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31C41C213C7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 10:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657245D736;
	Sat,  3 Feb 2024 10:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Qp71fFkF";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="PNMWcq6r"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF025D724;
	Sat,  3 Feb 2024 10:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706956050; cv=none; b=a8+1NfVRuE3cQ0bZoK4WGq8j5eBIRgYKbZEGnNYafyRIBhTpkQw5D0TjwpjKpEjWEmMi6Ks2eyHg9EKtk4Zg3GbEZIZBZpoTC9mavJBHazdu0Zv3tuKE7OEuM0zRLVfIUQ1CHHWegnXgr2QQitNPMjNL3dktHHNuwUGSu/rof8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706956050; c=relaxed/simple;
	bh=mYMlO94+qqGU6EIIkvherrMrf4NdbLBrBZ+xFuBRaTo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PmxMZpKQyvFuvVISPtPNA/2ULyHZnBEB1G1bGS2vhOyMzDZK3KLrrEtNKtv0yjYQkzHhVVG2S8DlvFeB8Ft8AX0TuFbmORf77D9z75siF1rmXIWcaxSZNw7/pTLXcGwJL92tHv27GD5kZ1WOvbLgMZN3lxbdK7tYVKX+9LirJ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Qp71fFkF; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=PNMWcq6r; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1706956047;
	bh=mYMlO94+qqGU6EIIkvherrMrf4NdbLBrBZ+xFuBRaTo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Qp71fFkFavvAXnK9wZeK4K7rxcIJYAHIdToBfgwTP1y38uehurcBv7Jr6stA8/VCb
	 Q6ABcfTBxbOmqZgsxNRCSK6AmvK6mkrHA4plqEW+IRATptdvrbGqkXZAt5Tg37Duix
	 64ANq+0LxTIP5hXAY+sOSPw9hpbulPG9l5A78ulw=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 31E0812867F0;
	Sat,  3 Feb 2024 05:27:27 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id ulQMKMU24K12; Sat,  3 Feb 2024 05:27:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1706956046;
	bh=mYMlO94+qqGU6EIIkvherrMrf4NdbLBrBZ+xFuBRaTo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=PNMWcq6riLEdQdBO7NG1Og31o1FCE8KALw7apsI0W5l6ADJ5uUBn2XUd0h/VMK/iy
	 1mbG9+7gAJbdTjZqTs3mUvZmitnEr/L7Ri448H6d2CIT2rteYc5X+u2H/3KGMVS6s8
	 2WuQFcOBC4nY93WEER5V8jlvRA6q4jsnCYeUlvtw=
Received: from [IPv6:2001:67c:1810:f051:aa84:e46e:cdd1:cb4c] (unknown [IPv6:2001:67c:1810:f051:aa84:e46e:cdd1:cb4c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 69EE21280FCA;
	Sat,  3 Feb 2024 05:27:24 -0500 (EST)
Message-ID: <85b7a4a679eada1d17b311bf004c2d9e18ab5cd3.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH v2 0/4] tsm: Runtime measurement registers ABI
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
  Dan Middleton <dan.middleton@linux.intel.com>, Samuel Ortiz
 <sameo@rivosinc.com>, Dan Williams <dan.j.williams@intel.com>
Cc: Qinkun Bao <qinkun@google.com>, "Yao, Jiewen" <jiewen.yao@intel.com>, 
 "Xing, Cedric" <cedric.xing@intel.com>, Dionna Amalie Glaze
 <dionnaglaze@google.com>, biao.lu@intel.com,  linux-coco@lists.linux.dev,
 linux-integrity@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Sat, 03 Feb 2024 11:27:21 +0100
In-Reply-To: <1557f98a-3d52-4a02-992b-4401c7c85dd7@linux.intel.com>
References: <20240128212532.2754325-1-sameo@rivosinc.com>
	 <c17a31e4fb30f5f9d4a337e5bd8d54cc6f99eef7.camel@HansenPartnership.com>
	 <a255bc36-2438-41b7-b304-bcf7a6628bef@linux.intel.com>
	 <42e14f74d3819c95fdb97cd2e9b2829dcb1b1563.camel@HansenPartnership.com>
	 <1557f98a-3d52-4a02-992b-4401c7c85dd7@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2024-02-02 at 23:13 -0800, Kuppuswamy Sathyanarayanan wrote:
> 
> On 2/2/24 10:03 PM, James Bottomley wrote:
> > On Fri, 2024-02-02 at 17:07 -0600, Dan Middleton wrote:
> > > On 2/2/24 12:24 AM, James Bottomley wrote:
> > > > On Sun, 2024-01-28 at 22:25 +0100, Samuel Ortiz wrote:
> > > > > All architectures supporting RTMRs expose a similar interface
> > > > > to
> > > > > their TVMs: An extension command/call that takes a
> > > > > measurement
> > > > > value and an RTMR index to extend it with, and a readback
> > > > > command
> > > > > for reading an RTMR value back (taking an RTMR index as an
> > > > > argument as well). This patch series builds an architecture
> > > > > agnostic, configfs-based ABI for userspace to extend and read
> > > > > RTMR values back. It extends the current TSM ops structure
> > > > > and
> > > > > each confidential computing architecture can implement this
> > > > > extension to provide RTMR support.
> > > > What's the actual use case for this?  At the moment the TPM
> > > > PCRs
> > > > only provide a read interface to userspace (via
> > > > /sys/class/tpm/tpmX/pcr-shaY/Z) and don't have any extension
> > > > ability becuase nothing in userspace currently extends them.
> > > > 
> > > > The only current runtime use for TPM PCRs is IMA, which is in-
> > > > kernel (and which this patch doesn't enable).
> > > > 
> > > > Without the ability to log, this interface is unusable anyway,
> > > > but
> > > > even with that it's not clear that you need the ability
> > > > separately
> > > > to extend PCRs because the extension and log entry should be
> > > > done
> > > > atomically to prevent the log going out of sync with the PCRs,
> > > > so
> > > > it would seem a log first interface would be the correct way of
> > > > doing this rather than a PCR first one.
> > > > 
> > > > James
> > > > 
> > > > 
> > > While we clearly need to cover PCR-like usages, I think
> > > Confidential
> > > Computing affords usages that go beyond TPM.
> > Well, don't get me wrong, I think the ability to create non
> > repudiable
> > log entries from userspace is very useful.  However, I think the
> > proposed ABI is wrong: it should take the log entry (which will
> > contain
> > the PCR number and the hash) then do the extension and add it to
> > the
> > log so we get the non-repudiable verifiability.  This should work
> > equally with TPM and RTMR (and anything else).
> 
> Maybe I misunderstood your comments, but I am not sure why
> the user ABI needs to change?

Well, there is no ABI currently, so I'm saying get it right before
there is one.

>  I agree that logging after extension is the right approach. But,
> IMO, it should be owned by the back end TSM vendor drivers. The user
> ABI should just pass the digest and RTMR index.

Well, lets wind back to the assumptions about the log.  The current
convention from IMA and Measured Boot is that the log is managed by the
kernel.  Given the potential problems with timing and serialization
(which can cause log mismatches) it would make sense for this ABI also
to have a kernel backed log (probably a new one from the other two). 
If you have a kernel backed log, the ABI for extending it should be
where you get the PCR extensions from, that way nothing can go wrong. 
An API to extend the PCRs separately will only cause pain for people
who get it wrong (and lead to ordering issues if more than one thing
wants to add to the log, which they will do because neither the TPM nor
the RTMRs have enough registers to do one per process that wants to use
it if this becomes popular).

James


