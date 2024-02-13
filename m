Return-Path: <linux-kernel+bounces-63857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94948853595
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6251C2191E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7045F876;
	Tue, 13 Feb 2024 16:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="RC+YzCK9";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="wykuj6PW"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381FF5F84C;
	Tue, 13 Feb 2024 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840351; cv=none; b=ZLnMncfxyf5cb79Qr9mXf1QgY+gVA1Whkg1sqbHQtFYP14eKjNG+/o/hsvmqNwiRcB86qqcc7wz6TMBiI0LJXq+k341nUcis+PreRNHfJp9iFTXsA5h2uSxVfxtb/Llg9bMnhRqS3k0YVF4n1zoKml5uFLuLZbLAqLb/PSQbG28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840351; c=relaxed/simple;
	bh=76ZkJstMN7d/lrOa91yJRmUFOo1w7pwJqg2u8ceSdmA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V/ZgC4dA/bhbtYDvcFVivFPZS9dUGd+U0igbse3XR17i0Iti+/BMhBvUoZ/L3ChZtR4Px07afe6E8VuZUp20SUSF9kOmYXi2tHmnkQ2NzImQgGxJ3i/tr4LxvoF6iWT31Zq8dhdUVGDb8gWSUwxMGSNEPokAtvi83KENYUrvqVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=RC+YzCK9; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=wykuj6PW; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1707840346;
	bh=76ZkJstMN7d/lrOa91yJRmUFOo1w7pwJqg2u8ceSdmA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=RC+YzCK9+TmWyGc8oHMRHccejewT+5xtcOsOvZwW+ISun1i0pl5fk64i710sfujoO
	 ar8bFmkR3b/3LR0onAdRzZeXpruSWUKztTYsELcidDjGwpVE2iLkoSlBWvEb9MfRK6
	 sMXZgpCW9LWLEKQ045rChXrCIsSTA2NQzD6NZgL8=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7E5D812861A8;
	Tue, 13 Feb 2024 11:05:46 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id eQwYdNqMijvb; Tue, 13 Feb 2024 11:05:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1707840345;
	bh=76ZkJstMN7d/lrOa91yJRmUFOo1w7pwJqg2u8ceSdmA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=wykuj6PWjdyHpNBbkLohFDsLNpmkH5yKdncABXFTXCyM0uJ2iTVtOCvaZFyEdRWuG
	 3KJ8J7aWw331i7ojUyOxe51nelVmCWCxeZpa3Y9WAUWtSgV0nupx2T+ysNGWmkTDdd
	 ABCECKzbWdn8r0dCZcZmTg4I9Fw17pf3BMQD+bfk=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D6AA91286197;
	Tue, 13 Feb 2024 11:05:44 -0500 (EST)
Message-ID: <982e19fcd71c41a162ba664281eb0a68d9dc960c.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH v2 0/4] tsm: Runtime measurement registers ABI
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Xing, Cedric" <cedric.xing@intel.com>, Dan Williams
	 <dan.j.williams@intel.com>, Kuppuswamy Sathyanarayanan
	 <sathyanarayanan.kuppuswamy@linux.intel.com>, Dan Middleton
	 <dan.middleton@linux.intel.com>, Samuel Ortiz <sameo@rivosinc.com>
Cc: Qinkun Bao <qinkun@google.com>, "Yao, Jiewen" <jiewen.yao@intel.com>, 
 Dionna Amalie Glaze <dionnaglaze@google.com>, biao.lu@intel.com,
 linux-coco@lists.linux.dev,  linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 13 Feb 2024 11:05:41 -0500
In-Reply-To: <226df539-b3f4-4099-b6a6-293fa200c536@intel.com>
References: <a255bc36-2438-41b7-b304-bcf7a6628bef@linux.intel.com>
	 <42e14f74d3819c95fdb97cd2e9b2829dcb1b1563.camel@HansenPartnership.com>
	 <1557f98a-3d52-4a02-992b-4401c7c85dd7@linux.intel.com>
	 <85b7a4a679eada1d17b311bf004c2d9e18ab5cd3.camel@HansenPartnership.com>
	 <b8140cc8-a56b-40f6-a593-7be49db14c77@intel.com>
	 <fe1722c3618a8216cb53b8fd3f1b7cbb6fdff5a0.camel@HansenPartnership.com>
	 <65c2e4aa54a0_d4122947f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	 <22088ed3-51a4-415f-932c-db84c92a2812@intel.com>
	 <527da630-4952-4b1d-80c0-5a87997ff9fd@linux.intel.com>
	 <332775d7218843d6cc168c963d76e6841eab5d5b.camel@HansenPartnership.com>
	 <65c691e13a50d_afa42948a@dwillia2-xfh.jf.intel.com.notmuch>
	 <226df539-b3f4-4099-b6a6-293fa200c536@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-02-12 at 23:36 -0800, Xing, Cedric wrote:
> On 2/9/2024 12:58 PM, Dan Williams wrote:
> > James Bottomley wrote:
> > > Just to correct this: IMA uses its own log format, but I think
> > > this was a mistake long ago and the new log should use TCG2
> > > format so all the tools know how to parse it.
> > 
> > Is this a chance to nudge IMA towards a standard log format? In
> > other words, one of the goals alongside userspace consumers of the
> > RTMR log would be for IMA to support it as well as an alternate in-
> > kernel backend next to TPM. IMA-over-TPM continues with its current
> > format, IMA-over-RTMR internally unifies with the log format that
> > is shared with RTMR-user-ABI.
> > 
> I'm not a TCG expert. As far as I know, 
> https://trustedcomputinggroup.org/wp-content/uploads/TCG-PC-Client-Platform-Firmware-Profile-Version-1.06-Revision-52_pub-1.pdf
>  
> defines the event types for TCG2 logs for firmware uses only. I
> cannot  find a spec that defines event types for OS or applications.
> We may  reuse the firmware event types for Linux but I doubt they can
> accommodate IMA.

The TCG crypto agile log format is

 index (32 bit),
 event tag (32 bit),
 digests array,
 sized event entry (up to 4GB)

So an IMA log entry can definitely be transformed into this format
(providing someone agrees to the tag or set of tags).  The slight
problem would be that none of the current IMA tools would understand
it, but that could be solved over time (the kernel could use the TCG
format internally but transform to the IMA format for the current
securityfs IMA log).

> IMHO, we don't have to follow TCG2 format because TDX is never TPM,
> nor are any other TEEs that support runtime measurements. The
> existing TCG2 format looks to me somewhat like ASN.1 - well defined
> but schema is needed to decode. In contrast, JSON is a lot more
> popular than ASN.1  nowadays because it's human readable and doesn't
> require a schema. I just wonder if we should introduce a text based
> log format. We could make the log a text file, in which each line is
> an event record and the digest of the line is extended to the
> specified runtime measurement register. The content of each line
> could be free-form at the ABI level, but we can still recommend a
> convention for applications - e.g., the first word/column must be an
> URL for readers to find out the format/syntax of the rest of the
> line. Thoughts?

https://xkcd.com/927/

> > ...but be warned the above is a comment from someone who knows
> > nothing about IMA internals, just reacting to the comment.
> > 
> > 
> > > > I am wondering where will the event log be stored? Is it in the
> > > > log_area region of CCEL table?
> > > 
> > > IMA stores its log in kernel memory and makes it visible in
> > > securityfs (in the smae place as the measured boot log).  Since
> > > this interface is using configfs, that's where I'd make the log
> > > visible.
> > > 
> > > Just to add a note about how UEFI works: the measured boot log is
> > > effectively copied into kernel memory because the UEFI memory it
> > > once occupied is freed after exit boot services, so no UEFI
> > > interface will suffice for the log location.
> > > 
> > > I'd make the file exporting it root owned but probably readable
> > > by only the people who can also extend it (presumably enforced by
> > > group?).
> > 
> > I assume EFI copying into kernel memory is ok because that log has
> > a limited number of entries. If this RTMR log gets large I assume
> > it needs some way cull entries that have been moved to storage.
> > Maybe this is a problem IMA has already solved.
> 
> We don't have to, and are also not supposed to I guess, append to the
> log generated by BIOS.

We do actually: the EFI boot stub in the kernel appends entries for the
initrd and command line.

>  The kernel can start a new log, and potentially in a different
> format. I think the BIOS log is exposed via securityfs today. Am I
> correct?

I already said that, yes.

>  For the new TEE measurement log, I don't think it has to be
> collocated with the BIOS log, because TEEs are never TPMs.

This depends.  Logs are separable by PCRs.  As in every entry for the
same PCR could be in a separate, correctly ordered, log.  However, you
can't have separate logs that both use the same PCR because they won't
replay.

James




