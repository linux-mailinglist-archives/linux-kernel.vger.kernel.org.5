Return-Path: <linux-kernel+bounces-95296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3807F874BE1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E76CB284BD2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE07185276;
	Thu,  7 Mar 2024 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="L/8K+AJM"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CCF85269;
	Thu,  7 Mar 2024 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805828; cv=none; b=VElBSgKzM0oAaEyOWBiiqBUOXCPCcAGp2ehsYhlXwgxFnBdfqppYb/2JpXycPPMTEKDBdo1dWwBkmmmchLHBVoaRkosnmsYaHLgsG/MvsiBhcgUBfz9qRqR3QImRcmy1SpMbyJztKsI0ZwqE0k3buRp2JdSpsDCBCQB8pXaSZDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805828; c=relaxed/simple;
	bh=JFLuqFDwfQNL2xOZkFhl8oaJxM0htnjHmGADG1CLZbw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fQXmywMcFRncEEOiAhyvUw+TDMIZpbakIg5JF889gNGb2AkNpDnXDcNbIu/3rHqr3bQZ5hDaeFhatAaLHK00Z/mXTIYeG40vEUIqW9LNc6ZvKPiLbyXMbRc0Fi03bYvGOb5gArDBK0MC1Ba+bG5QfestC9Iqj9xRYK8D6mLEFpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=L/8K+AJM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JFLuqFDwfQNL2xOZkFhl8oaJxM0htnjHmGADG1CLZbw=;
	t=1709805825; x=1711015425; b=L/8K+AJM9cns0BwzhHNoIoTTUxitNtCAk8/yhWxG5RZ+81l
	1HqslLbcXtH6LYosm3UpnkJXnaQ7zhYyc8wHp/Erl2+efSVIUofrGggZLXEGC5ewNtLUP74GfZ9WY
	P+poR6QHkdGK9SWWAJ6z/kSBvX8nO+V0ZH05AEGb+r2KpSyjltzbBEJjlXe1BCziUgljQs34xG3DQ
	SZeC6Lj7Il1X2ckQPSNHABnqqLWyyyWYUmw0vqdtx7de3yRnzICPCqvLWjDNQKgHYCDskgIDOssED
	Sn3CL6+1Q9Cv8blDLqNn7ghcfmkXgGcecESx6MgT70P7kcDuFlOpLs72KsAVESfg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1riAb7-00000005aOU-0Sdn;
	Thu, 07 Mar 2024 11:03:33 +0100
Message-ID: <463be980baf66b967031e3294c3b9745b07aa058.camel@sipsolutions.net>
Subject: Re: pcap-dbus.o:undefined reference to `dbus_message_demarshal'
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Waqar Hameed
	 <waqar.hameed@axis.com>, Ingo Molnar <mingo@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel@axis.com, Richard Weinberger <richard@nod.at>, 
	linux-um@lists.infradead.org
Date: Thu, 07 Mar 2024 11:03:32 +0100
In-Reply-To: <87cfca1e-3f53-4935-a274-0920bce86373@cambridgegreys.com>
References: <202403052336.y6DkUd8a-lkp@intel.com> <pndzfvbibgm.fsf@axis.com>
	 <87cfca1e-3f53-4935-a274-0920bce86373@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-03-07 at 09:54 +0000, Anton Ivanov wrote:
>=20
> PCAP is not feasible to incorporate into the build system at present.
> It has grown all kinds of warts over the years and brings a lot of depend=
encies.
> IMHO we should remove it from the tree. It has reached a point where it c=
annot
> be built on a modern system.

I suppose it might be possible to call pcap-config? But agree that it
doesn't seem really worth investing in.

> The users who need the same functionality can produce a bpf filter using =
tcpdump
> and load it as "firmware" into the vector/raw driver.
>=20
> I am working on a pure python bpf compiler which takes the same syntax as=
 PCAP.
> It is showing signs of life and it can do some of the simpler use cases. =
Once
> that is ready, it should be possible to use that instead of pcap/tcpdump.

How's that required to be formatted and loaded? tcpdump itself can also
dump the filter in BPF format, with -d/-ddd (-dd is a C representation,
so probably not useful). Perhaps we could even automatically call
'tcpdump' at runtime?

johannes

