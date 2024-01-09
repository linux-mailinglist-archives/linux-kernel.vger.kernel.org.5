Return-Path: <linux-kernel+bounces-20293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4367827CF6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068EE1C233D8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB3A611B;
	Tue,  9 Jan 2024 02:41:35 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E000E5665;
	Tue,  9 Jan 2024 02:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 8D1B040189;
	Tue,  9 Jan 2024 02:34:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id B02C930;
	Tue,  9 Jan 2024 02:34:31 +0000 (UTC)
Message-ID: <10aeef4ddd523b85ab34327bf384119d0d4b6567.camel@perches.com>
Subject: Re: [HID Patchsets for Samsung driver v2 2/6] HID: Samsung : Fix
 the checkpatch complain.
From: Joe Perches <joe@perches.com>
To: "sandeep.cs" <sandeep.cs@samsung.com>, 'Jiri Kosina' <jikos@kernel.org>,
  'Benjamin Tissoires' <benjamin.tissoires@redhat.com>
Cc: gaudium.lee@samsung.com, ih0923.kim@samsung.com,
 suhyun_.kim@samsung.com,  jitender.s21@samsung.com, junwan.cho@samsung.com,
 linux-input@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Mon, 08 Jan 2024 18:34:30 -0800
In-Reply-To: <020e01da421f$c0d20660$42761320$@samsung.com>
References: <20240108091917.1552013-1-sandeep.cs@samsung.com>
	 <CGME20240108091959epcas5p2559b779424e2fb7c7e268d1b24612b4f@epcas5p2.samsung.com>
	 <20240108091917.1552013-3-sandeep.cs@samsung.com>
	 <486973921f89f70bcc5d42501eeca3fd105be2c4.camel@perches.com>
	 <020e01da421f$c0d20660$42761320$@samsung.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: 8px9nt77ak184m7pm8kydhce6yd95e4c
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: B02C930
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+WUbPlmxvZTf3rFTUAcrpyC10KPvDb1P0=
X-HE-Tag: 1704767671-95191
X-HE-Meta: U2FsdGVkX1+4BlMMN4VYkL7ubNmhBc7tEHFS823XnNWJbctipkN5qo8dsBAtnQBSM23x7/0gA+c8DqFScQmmes356bB6zgWnc166SzJh6NhxxHxLd/oflvJYO6wdUBRpZrsqTs9fHVHFE4aR6HcLkOMUyHyivl6/iqUq8StCgI6QnJy60+QidZoOUQ6mTK8wuSO2t2D/hpiFGb2/O7mWqHNs/HTkANXo1svYPcHmt3QzFNOb9z5+Te7v6GnJlS1ptztuqgvfq2b2y5ZMsA9SVU69XtgfQto4DCZitn84L4iEzAzoQpjADRhZp7TigHat

On Mon, 2024-01-08 at 16:14 +0530, sandeep.cs wrote:
> > On Mon, 2024-01-08 at 14:49 +0530, Sandeep C S wrote:

Generally, it's better to refactor code that checkpatch
bleats about than merely shutting up the warning.

> > For this block, I think a rewrite using memcmp would be clearer.
> > Something like:=20
> Okay . Thanks for your valuable feedback. We will promptly address your
> suggestions and enhance our code accordingly.
> And also please review other patch set as well.

Another way to write the input_mapping function is
using a static const struct and a for loop like:

static int samsung_kbd_mouse_input_mapping(struct hid_device *hdev,
	struct hid_input *hi, struct hid_field *field, struct hid_usage *usage,
	unsigned long **bit, int *max)
{
	struct usb_interface *intf =3D to_usb_interface(hdev->dev.parent);
	unsigned short ifnum =3D intf->cur_altsetting->desc.bInterfaceNumber;
	static const struct {
		unsigned hid;
		__u16 map;
	} samsung_hid_key_map[] =3D {
		{0x183, KEY_MEDIA},
		{0x195, KEY_EMAIL},
		{0x196, KEY_CALC},
		{0x197, KEY_COMPUTER},
		{0x22b, KEY_SEARCH},
		{0x22c, KEY_WWW},
		{0x22d, KEY_BACK},
		{0x22e, KEY_FORWARD},
		{0x22f, KEY_FAVORITES},
		{0x230, KEY_REFRESH},
		{0x231, KEY_STOP},
	};
	int i;
	unsigned hid;

	if (1 !=3D ifnum || HID_UP_CONSUMER !=3D (usage->hid & HID_USAGE_PAGE))
		return 0;

	hid =3D usage->hid & HID_USAGE;

	dbg_hid("samsung wireless keyboard/mouse input mapping event [0x%x]\n",
		hid);

	for (i =3D 0; i < ARRAY_SIZE(samsung_hid_key_map); i++) {
		if (hid =3D=3D samsung_hid_key_map[i].hid) {
			hid_map_usage_clear(hi, usage, bit, max, EV_KEY,
					    samsung_hid_key_map[i].map);
			return 1;
		}
	}

	return 0;
}


