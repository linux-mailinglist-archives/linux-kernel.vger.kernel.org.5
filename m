Return-Path: <linux-kernel+bounces-24790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64AE82C297
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AADCF1C22021
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94B26EB49;
	Fri, 12 Jan 2024 15:13:34 +0000 (UTC)
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91A66D1AA;
	Fri, 12 Jan 2024 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 619B5490C3;
	Fri, 12 Jan 2024 16:13:23 +0100 (CET)
Message-ID: <db8b9e19-ad75-44d3-bfb2-46590d426ff5@proxmox.com>
Date: Fri, 12 Jan 2024 16:13:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-GB, de-AT
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
From: Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: vxlan: how to expose opt-in RFC conformity with unprocessed header
 flags
Autocrypt: addr=t.lamprecht@proxmox.com; keydata=
 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 DrEx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi!

We got a customer that reported an issue where the Linux VXLAN
implementation diverges from the RFC, namely when any of the (reserved)
flags other than the VNI one is set, the kernel just drops the package.

According to the vxlan_rcv function in vxlan_core this is done by choice:

if (unparsed.vx_flags || unparsed.vx_vni) {
        /* If there are any unprocessed flags remaining treat
         * this as a malformed packet. This behavior diverges from
         * VXLAN RFC (RFC7348) which stipulates that bits in reserved
         * in reserved fields are to be ignored. The approach here
         * maintains compatibility with previous stack code, and also
         * is more robust and provides a little more security in
         * adding extensions to VXLAN.
         */
        goto drop;
}

Normally this is not an issue, as the same RFC also dictates that the sender
must have those reserved bits set to zero. But naturally, some devices are
not following that side of the contract either, like some Juniper switches
of said customers, which set the B-bit (like it would be a VXLAN-GPE) in the
VXLAN packet, even though they have VXLAN-GPE explicitly disabled.

So, while I asked the customer to open a support ticket with their switch
vendor, as that one is breaking the RFC too, the kernel is just the simpler
thing to "fix", especially for our side the only thing we can change at all.

As just changing the code so that it would be always RFC conform (at least
in this regard) seems to be a no-go, as some setups would then suddenly see
extra (malicious) traffic go through, so to my actual question:

What would be the accepted way to add a switch of making this RFC conform in
an opt-in way? A module parameter? A sysfs entry? Through netlink?

As depending on the answer of that I'd like to prepare a patch implementing
the opt-in RFC-conformance w.r.t. ignoring the reserved bits values of the
VXLAN flags, this way setups with complementary broken HW in their network
path can opt in to that behavior as a workaround.

thanks!
 Thomas


