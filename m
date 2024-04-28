Return-Path: <linux-kernel+bounces-161250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 223FF8B4996
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 06:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C5B1F2170A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 04:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1653D75;
	Sun, 28 Apr 2024 04:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=trudheim.com header.i=@trudheim.com header.b="Ge/n5cN7"
Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C284B19F;
	Sun, 28 Apr 2024 04:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714278781; cv=none; b=F0nJF+0rj4/y985ZdpBXeJ6ol/t/1uf+T+EsII9kIohLNLmD/WHBBtyzHrv4ldTmLnfwT6o+GyefnJiXqiKpXa9aNM5qlxuKWCYTWdT3R3YejOgW8vL62DCrS4FyJ7XUojEbfrl6GU8O2Ap9JvCocfml1POuT+a/b2Xz1AXfBzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714278781; c=relaxed/simple;
	bh=HMrm9rNMfGcHoEG7S4kdJ/HDvK8wpZH670y877FeSrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOdRoumXRU3rkFQaBG3Ijk7GU6d8dNgP0HmlVfC0TAXDM2GhoHNsbMVXYkkAXlu6lqMGXBes44QdtM3Nb+n+1Fbd4PFy+8Vt2Rp1KjKPp0UAhiZ76cS0vdhyrRtppQLL3UdvwVKVdIpg4kc8a/dGpc5dC0aiOrYWh8yOF4n5h1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trudheim.com; spf=pass smtp.mailfrom=trudheim.com; dkim=fail (2048-bit key) header.d=trudheim.com header.i=@trudheim.com header.b=Ge/n5cN7 reason="signature verification failed"; arc=none smtp.client-ip=79.136.2.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trudheim.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trudheim.com
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id A5C213F3CD;
	Sun, 28 Apr 2024 06:25:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: 0.199
X-Spam-Level:
Authentication-Results: pio-pvt-msa1.bahnhof.se (amavisd-new);
	dkim=fail (2048-bit key)
	reason="fail (OpenSSL error: data too small for key size)"
	header.d=trudheim.com
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ioErA7ij4ibj; Sun, 28 Apr 2024 06:25:41 +0200 (CEST)
Received: 
	by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id D375A3F784;
	Sun, 28 Apr 2024 06:25:39 +0200 (CEST)
Received: from acer.trudheim.com (acer.trudheim.com [IPv6:2001:470:28:a8::44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by trudheim.com (Postfix) with ESMTPSA id 02822ECA9F3;
	Sun, 28 Apr 2024 06:25:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trudheim.com;
	s=trudheim; t=1714278337;
	bh=HMrm9rNMfGcHoEG7S4kdJ/HDvK8wpZH670y877FeSrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ge/n5cN7ibL0LaFVcwBy96e4OANeUsHHDs/z7e5BFo25LRPquoATlu6c3n0uzmnP4
	 esOQQHUe1xGLfBzX9r+nlgWOEGvJlTYM6Fzoo0xdvZ5lev8cGKaGJob132+Tq4Klr2
	 SPM/A4A3sbicpFwhb7XxOjJ1iLYK+bJg7xw0AzaA=
Date: Sun, 28 Apr 2024 06:25:35 +0200
From: Sirius <sirius@trudheim.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Harold Johnson <harold.johnson@broadcom.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-cxl@vger.kernel.org,
	Sreenivas Bagalkote <sreenivas.bagalkote@broadcom.com>,
	Brett Henning <brett.henning@broadcom.com>,
	Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
	linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linuxarm@huawei.com,
	linux-api@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Natu, Mahesh" <mahesh.natu@intel.com>
Subject: Re: RFC: Restricting userspace interfaces for CXL fabric management
Message-ID: <Zi3Pv1GrCY6bSk4e@acer.trudheim.com>
References: <20240425123344.000001a9@Huawei.com>
 <662a826dbeeff_b6e02943c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240425182605.00005f22@Huawei.com>
 <662aae2fe4887_a96f294bf@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240426094550.00002e37@Huawei.com>
 <662bd36caae55_a96f2943f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240426175341.00002e67@Huawei.com>
 <6351024b5d6206c4e9a8cd98d1a09d43@mail.gmail.com>
 <2024042708-outscore-dreadful-2c21@gregkh>
 <662d263dd17c7_b6e0294ab@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <662d263dd17c7_b6e0294ab@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Autocrypt: addr=sirius@trudheim.com; keydata=
	mDMEZfWzYhYJKwYBBAHaRw8BAQdA12OXNGLFcQh7/u0TP9+LmaZCQcDJ5ikNVUR6Uv++NQy0HFN
	pcml1cyA8c2lyaXVzQHRydWRoZWltLmNvbT6IkAQTFggAOBYhBP4MEykW8GvNTTxpa4Pq//Pg5C
	PuBQJl9bNiAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEIPq//Pg5CPuatYA/3QLv92lC
	7xfhdf7NgmqipA+DXyobhzn9JgwLpRQQcu0AQD77L+EQ3aiyga7NR15r2IRC4DDLFK9Mnsbvi+K
	ZHmdBbg4BGX1s2ISCisGAQQBl1UBBQEBB0AZotbLXS2sTulJhpCsxrd9be2zedV47TV8CInC4nt
	9PQMBCAeIeAQYFggAIBYhBP4MEykW8GvNTTxpa4Pq//Pg5CPuBQJl9bNiAhsMAAoJEIPq//Pg5C
	PubFIA/3d2DFaXz0WJ1zq/tSacU7fckFQ7KFwddlyI7Y+IiosmAQCnBrV+e1iJXnZRSZCGBu+Xt
	BMLXZe+WKVyzQ0/AWV5Ag==
X-MailScanner-ID: 02822ECA9F3.AA808
X-MailScanner: Found to be clean
X-MailScanner-From: sirius@trudheim.com

In days of yore (Sat, 27 Apr 2024), Dan Williams thus quoth: 
> Greg KH wrote:
> [..]
> > So while innovating at the hardware level is fine, follow the ways that
> > everyone has done this for other specification types (USB, PCI, etc.)
> > and just allow vendor drivers to provide the information.  Don't do this
> > in crazy userspace drivers which will circumvent the whole reason we
> > have standard kernel/user apis in the first place for these types of
> > things.
> 
> Right, standard kernel/user apis is the requirement.
> 
> The suggestion of opaque vendor passthrough tunnels, and every vendor
> ships their custom tool to do what should be common flows, is where this
> discussion went off the rails.

One aspect of this is Fabric Management (thinking CXL3 here). It is not
desirable that every vendor of CXL hardware require their own
(proprietary) fabric management software. From a user perspective, that is
absolutely horrible. Users can, and will, mix and match CXL hardware
according to their needs (or wallet), and them having to run multiple
fabric management solutions (which in worst case are conflicting with each
other) to manage things is .. suboptimal.

By all means - innovate - but do it in such a way that interoperability
and manageability is the priority. Special sauce vendor lock-in is a
surefire way to kill CXL where it stands - don't do it.

-- 
Kind regards,

/S

