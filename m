Return-Path: <linux-kernel+bounces-144626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDFC8A4884
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D8D283D4E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C17120335;
	Mon, 15 Apr 2024 06:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="JQknEPZT"
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D8E1EB5E;
	Mon, 15 Apr 2024 06:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713164293; cv=none; b=K3dCU8LaIDgWHf6M9sIHWYi4EHMmFK/smduol/wDDyncY/G2KGWYTU3ebD3DxtDb/+Lp5TBODqDY4197t79djYxOgpmb9ce0Qg3rwE/F7zbeLXGoLVEFsyBSVLIcA1o8/cUNjb5ArWnsU7vJciPhT1P1M/toGzdsU4/TX4ZinyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713164293; c=relaxed/simple;
	bh=5dQYE555WyWLOIGjnlUIwdBPsURAhH1u3CUIqS7Bd6I=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=rOneibs6YXWWZ4y354xHIn3It2FW49vtmnDk8wB/RnX2zgg0w4AWSaVpW6VHEKyxeLFx3S4niRnQ2eXX0/teYXFoEW1k64MCxbgQlzQ1vgP9VOMBqsVSoy8fKXfX5l8TLEsPbJKwTRpdh7OaOoAHGq8we2yNyWDyoLt03NRpqPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=JQknEPZT; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10da:6900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 43F6lJGr265481
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 07:47:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1713163639; bh=ptLbaXHFz1SjMcJUxVZ1MKPDLiUChee6AAW1Ax7maBk=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=JQknEPZTeGKCD2KEeFUG9yDA2PEETWkDp9Ntu7+q6E1u0TzswuRdN3XgTIhipVnA6
	 QW2Ld+vLwa/dFtImLTm4CN4QB8mucwg/Yt6d4Yc9vf5HVbwpxqHAEiNWrlLNVIdt6e
	 a9quzffcyP60fDXlYkxUBpD/36Hfg0+7jTsjU6LA=
Received: from miraculix.mork.no ([IPv6:2a01:799:10da:690a:d43d:737:5289:b66f])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 43F6lJwZ367339
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 08:47:19 +0200
Received: (nullmailer pid 17569 invoked by uid 1000);
	Mon, 15 Apr 2024 06:47:19 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Aleksander Morgado <aleksandermj@chromium.org>
Cc: oneukum@suse.com, linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        ejcaruso@chromium.org
Subject: Re: [PATCH] usb: cdc-wdm: close race between read and workqueue
Organization: m
References: <385a3519-b45d-48c5-a6fd-a3fdb6bec92f@chromium.org>
Date: Mon, 15 Apr 2024 08:47:19 +0200
In-Reply-To: <385a3519-b45d-48c5-a6fd-a3fdb6bec92f@chromium.org> (Aleksander
	Morgado's message of "Mon, 15 Apr 2024 05:42:06 +0000")
Message-ID: <87mspvi0lk.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.0.3 at canardo
X-Virus-Status: Clean

Aleksander Morgado <aleksandermj@chromium.org> writes:
> On 3/14/24 11:50, Oliver Neukum wrote:
>> wdm_read() cannot race with itself. However, in
>> service_outstanding_interrupt() it can race with the
>> workqueue, which can be triggered by error handling.
>> Hence we need to make sure that the WDM_RESPONDING
>> flag is not just only set but tested.
>> Fixes: afba937e540c9 ("USB: CDC WDM driver")
>> Signed-off-by: Oliver Neukum <oneukum@suse.com>
>
> We are not aware of all the details involved in this patch, but we had
> to revert it in all the different ChromeOS kernel versions where we
> had it cherry-picked, because it broke the MBIM communication with the
> Intel XMM based Fibocomm L850 modem. Other modems shipped in
> Chromebooks like the QC based Fibocomm FM101 don't seem to be
> affected.
>
> Attached is an example output of mbimcli talking directly to the
> cdc-wdm port (i.e. without ModemManager or the mbim-proxy). In the
> example, we are receiving a bunch of different messages from previous
> mbimcli runs. Looking at the timestamps, it looks as if we only
> receive a message right after we have sent one, e.g. after each "open
> request" we end up receiving responses for requests sent in earlier
> runs; or something along those lines.
>
> Is this bad behavior of this specific modem chipset, and if so, how
> can we workaround it? If you need any additional information or help
> to test new patches, let us know.

I'm not sure I understand what problem that patch is supposed to fix.
Which means that everything I write could be completely wrong...

But to me it looks like the described issue is exactly what you should
expect if that change ever triggers.  I believe we must resubmit the
urb from service_outstanding_interrupt(). That's why it was added. See
the explanation Robert wrote when introducing it:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/d=
rivers/usb/class/cdc-wdm.c?id=3Dc1da59dad0ebd3f9bd238f3fff82b1f7ffda7829

As for the XMM behaviour: it's been a long time since I tried any of
those, but AFAIR one the major differences compared to Qualcomm was the
strict queue handling in the firmware.  This caused a number of problems
where the cdc-wdm driver wanted to skip a message for some reason.  So
I'm not surprised that a bug like this is triggered by one of those
modems. That's probably the only thing they are good for :-)



Bj=C3=B8rn

