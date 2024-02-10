Return-Path: <linux-kernel+bounces-60344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DF285036F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D311F23C2D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2883B2B9B7;
	Sat, 10 Feb 2024 07:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DzwZGlZH"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0F5364BE;
	Sat, 10 Feb 2024 07:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707551595; cv=none; b=oGNjzq+cg6ycAzdFZLvjgAMXgF1IhoWN9wEy4TfjWNWSrhJJeTahmRHOS9vh2sVPGWJYU+bw8H5FM/OYqV0qVepdpsxxp0YP8QMYCrF14U9HhtrRdD4qBk1ZAF5+amg690mXlLatwJMWPrVnZZ2DUI6ut0MhEwHL4RXDMywJ41I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707551595; c=relaxed/simple;
	bh=N/bMUlvEIHFtWC9m3ywNAcaX2rKlbaWGROOfKxrvTJI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=OAJd9KmQxVBL100oNL/yDhWDS0enscunFC9kyWrPPl8qN+jP0cpXtE0Mu8s9JXRfjqFVOBbAm43tvSihluji08elU7LrAvsHewptB6r+v9kjGvYD6owsCyRsd3rBO/nMxHLQLMiv1b8FgryQEmHrq527JpMSVbKnYK0ksbhfPt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DzwZGlZH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5F39540E0192;
	Sat, 10 Feb 2024 07:53:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bDtIDKNp_WIC; Sat, 10 Feb 2024 07:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707551586; bh=DlcbY2ofqS2cG6ZOauI2M8Te0nskCJJ70t7PzuUSjsY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=DzwZGlZHYZnC1dygrA6CdZ5GbW4FhvzFU6cySoTdT8ZMjQLd4o5JAMxxas9VgfU5Y
	 cJF9701Mog3xoT44fA8tD/TcKEadwfQRHwgKq13fAkMuP6TUL1AzNWNLfeVl7gvdQw
	 UcH9sLPsE2SLAdt+xTFlvVUVkQwZ4xXh9lQGDd6Gix879+F7nPByiZaC+3AwcatyPf
	 M4M6uIQvqUiqiZGf6YUBEnDbqTDaSisLYwpIK3aXhOfsmJSMtKl6e/q5VRkPysw3ND
	 Dy+rEPPOlJI+xRqFUSE5rmBU2/BkLTGRjWtZbsNy2EU2SFycpwtgwsQMOrQ8y+cyKt
	 GO0fK1uo05XSB/eTDU1WYUKrevFQtRElw7y9KDeq1PwLAUsB4PljeMACpd5qTR117M
	 T1GtcXFsv68TiM75qSxqGd6xc3DojuS7Ysj7j9gEWzXxr0HVFinepbe5TNFc+rclyT
	 WlnNbPboT6Uu3lOQlhm2DQYrMWn51rH8uN1bG8clbPVRVadqdaBWyQ+GsJImNvx9ib
	 4LnWpIs0PdXXIkIDhOHcTGlecOJ+V7A4R1rz4qpPyl60Tj2450qMcN3qWupk+M/hdX
	 hiKb1Oj6Ln+/IwOQzMbV567I+tPGaSTj1bkKBduCJi3W73h9QxfSiY9rozYFyyJFie
	 yj0fltcStP+JuyoWh0CH5lD4=
Received: from [IPv6:::1] (p200300Ea97226B845026c69288948424.dip0.t-ipconnect.de [IPv6:2003:ea:9722:6b84:5026:c692:8894:8424])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C295340E01F7;
	Sat, 10 Feb 2024 07:52:57 +0000 (UTC)
Date: Sat, 10 Feb 2024 08:52:53 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Naik, Avadhut" <avadnaik@amd.com>
CC: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
 linux-edac@vger.kernel.org, tony.luck@intel.com,
 linux-kernel@vger.kernel.org, yazen.ghannam@amd.com,
 Avadhut Naik <avadhut.naik@amd.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/2=5D_x86/MCE=3A_Add_command_?= =?US-ASCII?Q?line_option_to_extend_MCE_Records_pool?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240209205111.GGZcaQP1gb6C9m0WZB@fat_crate.local>
References: <20240207225632.159276-1-avadhut.naik@amd.com> <20240207225632.159276-3-avadhut.naik@amd.com> <8b4f8ec2-7534-4f77-b44f-6728c699ff64@intel.com> <51255499-0b5d-45c6-9c72-f353bae83c0d@amd.com> <20240209200920.GFZcaGcOr757W9O3IG@fat_crate.local> <7a4945b0-322a-444e-a0ca-860a062a49c3@amd.com> <20240209205111.GGZcaQP1gb6C9m0WZB@fat_crate.local>
Message-ID: <5DB0FF8D-C6DA-45DC-B287-201A9BF48BDA@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 9, 2024 9:51:11 PM GMT+01:00, Borislav Petkov <bp@alien8=2Ede> =
wrote:
>On Fri, Feb 09, 2024 at 02:35:12PM -0600, Naik, Avadhut wrote:
>> IIUC, this is exactly what the first patch in this series is trying to
>> accomplish=2E  Please correct me if I understood wrong=2E
>
>Yes, you did=2E
>
>I don't mean to extend it - I mean to allocate it from the very
>beginning to
>
>	min(4*PAGE_SIZE, num_possible_cpus() * PAGE_SIZE);

max() ofc=2E

>There's a sane minimum and one page pro logical CPU should be fine on
>pretty much every configuration=2E=2E=2E
>
>Thx=2E
>


--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

