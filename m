Return-Path: <linux-kernel+bounces-39344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6B883CF17
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E066D1F232DF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595DA13AA4B;
	Thu, 25 Jan 2024 22:00:18 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDD31CA89;
	Thu, 25 Jan 2024 22:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706220017; cv=none; b=ZZo/aETtuoE3pOMbhFpdyMVhEK/x6+M3ZTTkFxU0TQLLG2u5nFp2VFrHdeeio5wUa9+UnqFTSK5vqXmeUNFaW/j0FxjOOsXz834Fv9hmpKWGAv+C/3rU7QhuMUNu8/fdYEp2L2/NDIfsozXbf+mcqYRZgGsWcNCNrn1yJxKZvuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706220017; c=relaxed/simple;
	bh=RItmqS9jqdMPP9X0BIiJ7ScnCDLQTWAEQYeO6/47XXI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B6xeIZFJIE9U9Y6bnkMfePrqfFllHCuyCwFtiw90SHV3VRo+oz2y5g4xxNpA9p/zFm5ra/N9Ckh9vPxbPaQlLTresEkksMPdbpe7mf15SCFGkonJc5mRUzOF79mNQ1GULBywIeY7eVPw0CQvuhnpA0WRmiESE7QP4QGIiZQ0vOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 311EAA1AEA;
	Thu, 25 Jan 2024 21:54:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id 9578F2D;
	Thu, 25 Jan 2024 21:54:06 +0000 (UTC)
Message-ID: <443a7a529f6987eb53b8b399c0cf9375e05e993c.camel@perches.com>
Subject: Re: [HID Patchsets for Samsung driver v4 2/6] HID: Samsung : Fix
 the checkpatch complain. Rewritten code using memcmp where applicable.
From: Joe Perches <joe@perches.com>
To: Sandeep C S <sandeep.cs@samsung.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: gaudium.lee@samsung.com, ih0923.kim@samsung.com,
 suhyun_.kim@samsung.com,  jitender.s21@samsung.com, junwan.cho@samsung.com,
 linux-input@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Thu, 25 Jan 2024 13:54:04 -0800
In-Reply-To: <20240125043630.4031634-3-sandeep.cs@samsung.com>
References: <20240125043630.4031634-1-sandeep.cs@samsung.com>
	 <CGME20240125043702epcas5p33d9ef989dc51276185972d4517ba80fd@epcas5p3.samsung.com>
	 <20240125043630.4031634-3-sandeep.cs@samsung.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 9578F2D
X-Stat-Signature: netg7ytrkhf5yn7g9ss3rqtp6edq4y1x
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+/lgHE9tEIP3LCpllBaSnMinnSVYZnflU=
X-HE-Tag: 1706219646-171183
X-HE-Meta: U2FsdGVkX19q5nfWT/ncDEf0UGPqNDNT0bD1dD26L+l3U0BVk/FyRVy+8f9eZWqHq5bLV82zlpvR9tuWcE6/ER7oX3p5u99J8rt2u5JESFzHamwHXOJnDSTRwcS3ucnC8NgSxPnHj22qGi49gamdUVu5oXD1Di9q5/fzr8kK5Qsu01Nb3qY6NKjQNQ+g6pq7U61pQk4Tw0XMXPNln3gkICanL/V7CsIzRZcbJ62bhjUbql1GapkB1RBmYiNEh3fW0vX/0NCSTumAXQzOWwxxINQs6B6Teso/3uwuQIzDwauNnMtYjxfljCON+NJ31W3rj1DTFkV5AvPRAdAMHiaDvM4FqwJA+kfKA7QcI6BBP0WrorFc/UPE/p+KWNXaUNU1vaHPZ7OipTbmdNi6FummXm6skyHmOvrZ5MdBowO77hxNzc3b3FTx1TAzt4OiQ1c5

On Thu, 2024-01-25 at 10:06 +0530, Sandeep C S wrote:
> Resolved warnings found by checkpatch.pl script.
[]
> diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
> @@ -107,17 +99,39 @@ static int samsung_kbd_mouse_input_mapping(struct hi=
d_device *hdev,
> =20
>  	switch (usage->hid & HID_USAGE) {
>  	/* report 2 */
> -	case 0x183: samsung_kbd_mouse_map_key_clear(KEY_MEDIA); break;
> -	case 0x195: samsung_kbd_mouse_map_key_clear(KEY_EMAIL);	break;
> -	case 0x196: samsung_kbd_mouse_map_key_clear(KEY_CALC); break;
> -	case 0x197: samsung_kbd_mouse_map_key_clear(KEY_COMPUTER); break;
> -	case 0x22b: samsung_kbd_mouse_map_key_clear(KEY_SEARCH); break;
> -	case 0x22c: samsung_kbd_mouse_map_key_clear(KEY_WWW); break;
> -	case 0x22d: samsung_kbd_mouse_map_key_clear(KEY_BACK); break;
> -	case 0x22e: samsung_kbd_mouse_map_key_clear(KEY_FORWARD); break;
> -	case 0x22f: samsung_kbd_mouse_map_key_clear(KEY_FAVORITES); break;
> -	case 0x230: samsung_kbd_mouse_map_key_clear(KEY_REFRESH); break;
> -	case 0x231: samsung_kbd_mouse_map_key_clear(KEY_STOP); break;


It's rather smaller code to remove the call duplication and use
a static const struct and for loop as suggested here:

https://lore.kernel.org/lkml/10aeef4ddd523b85ab34327bf384119d0d4b6567.camel=
@perches.com/


