Return-Path: <linux-kernel+bounces-98556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A90D877BF1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF011C20D71
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA04E12B97;
	Mon, 11 Mar 2024 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b="sHrHGthp"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFBA125C4
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710147231; cv=none; b=pRzgwIhRr8dEqOAq9q7O7X1nnirS0fOBWlUHuu/KxqK7BfyiNE1aBpEjVbE6hmN6MLVQ9CbvYoaBkDD+m5sIgqIg7zUnVdw6Qn6gL3eK7/C80KnLftzrjjoHI+tadVBG2YdVrbUqehLRfDsasoqOHfMTZGiJw7l1gOmv7GYUuLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710147231; c=relaxed/simple;
	bh=fnGQK5mpYPky2EtgEWQVbUO7rqbWN3odhtSAfHQlY20=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V3VbOUvZDFpMU0dWqTWk+kTEHeTTj/SVXIyP86cifu28KocOKuRYS0El2BRbMfp/najweoLGajvzFYEyLsHwZkbiCUO28B5q6rCUn/yEMG6QHakcz5cfks/3uDoQW0X1iv/He8HioC8AnoJ+qpW7mTYov34LhbJDNfyWjtiLAfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev; spf=pass smtp.mailfrom=oltmanns.dev; dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b=sHrHGthp; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oltmanns.dev
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TtVtf1CRMz9sZh;
	Mon, 11 Mar 2024 09:53:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
	s=MBO0001; t=1710147226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBxxMeFHaNTIFVvrYkndR+gcWNWRWVLtfGRhdSP2/6o=;
	b=sHrHGthpynjybtW3iaYqn4VDz8W2mUnv6z71ZcETVBTQpDmc7sauHjv28wVIESNz/NT4JO
	/eVM/ApgVTwerUaZtR+crPq/PZ9QfQrPX1WDUb9R/U+hQMeqrmn84ffVdA6EYR8U8fVs6Q
	6MKWrZ3VMg106rd65FLMhOoNk88XdMcm1C0OOax6wn91vCLFoo+dRCog61XZh0FdNhLrDV
	G4ztOUTIEG0WWo+/ygkJP0lKF5CIN1zlM1Yx+VoYodoBkIzP1n5ZyULYJ9x4RqUUP0uzUp
	U3GKlswqNYL8bbUzk07xidLNJSJeVygSFU7YDvFnpK2JjH330jL778xHvnsOSw==
From: Frank Oltmanns <frank@oltmanns.dev>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <x@xnux.eu>
Cc: Maxime Ripard <mripard@kernel.org>,  Chen-Yu Tsai <wens@csie.org>,
  Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,  Thomas Zimmermann
 <tzimmermann@suse.de>,  David Airlie <airlied@gmail.com>,  Daniel Vetter
 <daniel@ffwll.ch>,  Jernej Skrabec <jernej.skrabec@gmail.com>,  Samuel
 Holland <samuel@sholland.org>,  Icenowy Zheng <uwu@icenowy.me>,
  dri-devel@lists.freedesktop.org,  linux-arm-kernel@lists.infradead.org,
  linux-sunxi@lists.linux.dev,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: tcon: Support keeping dclk rate upon
 ancestor clock changes
In-Reply-To: <s3iqqnqiqnlujncbb6vnip7hvofgbom54on7fx4hxmyfsk2v2w@gbvpkptsa5g3>
	(=?utf-8?Q?=22Ond=C5=99ej?= Jirman"'s message of "Sun, 10 Mar 2024 23:23:57
 +0100")
References: <20240310-tcon_keep_stable_rate-v1-1-0296b0a85c02@oltmanns.dev>
	<s3iqqnqiqnlujncbb6vnip7hvofgbom54on7fx4hxmyfsk2v2w@gbvpkptsa5g3>
Date: Mon, 11 Mar 2024 09:53:41 +0100
Message-ID: <87le6pcfoq.fsf@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4TtVtf1CRMz9sZh

Hello Ond=C5=99ej,

On 2024-03-10 at 23:23:57 +0100, Ond=C5=99ej Jirman <x@xnux.eu> wrote:
> Hello Frank,
>
> On Sun, Mar 10, 2024 at 02:32:29PM +0100, Frank Oltmanns wrote:
>> +static int sun4i_rate_reset_notifier_cb(struct notifier_block *nb,
>> +				      unsigned long event, void *data)
>> +{
>> +	struct sun4i_rate_reset_nb *rate_reset =3D to_sun4i_rate_reset_nb(nb);
>> +
>> +	if (event =3D=3D POST_RATE_CHANGE)
>> +		schedule_delayed_work(&rate_reset->reset_rate_work, msecs_to_jiffies(=
100));
>
> If you get multiple reset notifier calls within 100ms of the first one,
> the delay from the last one will not be 100ms, so this may violate expect=
ations
> you're describing in the commit message.

Let me start by saying, the implicit expectation is that the new user of
pll-video0 will get an exclusive lock on pll-video0 (otherwise,
data-clock would reset pll-video0 after those 100ms rendering the whole
endeavor of the new user pointless). This constraint makes the chances
that the above event (two consecutive rate changes within 100ms) occurs
very slim.

That being said, I don't see a problem with cancelling the delayed work
on PRE_RATE_CHANGE and restarting it on ABORT_RATE_CHANGE like this:

+static int sun4i_rate_reset_notifier_cb(struct notifier_block *nb,
+				      unsigned long event, void *data)
+{
+	struct sun4i_rate_reset_nb *rate_reset =3D to_sun4i_rate_reset_nb(nb);
+
+	if (event =3D=3D PRE_RATE_CHANGE) {
+		rate_reset->is_cancelled =3D cancel_delayed_work(&rate_reset->reset_rate=
_work);
+	} else if ((event =3D=3D POST_RATE_CHANGE) ||
+		 (event =3D=3D ABORT_RATE_CHANGE) && rate_reset->is_cancelled) {
+		schedule_delayed_work(&rate_reset->reset_rate_work, msecs_to_jiffies(100=
));
+		rate_reset->is_cancelled =3D false;
+	}
+
+	return NOTIFY_DONE;
+}

The need for this new code is slim (IMHO) but on the other hand it
doesn't add much complexity. I'll add it in V2 including the
is_cancelled member in sun4i_rate_reset_nb if I don't receive any
objections during this week.

Thanks,
  Frank

>
> schedule_delayed_work doesn't re-schedule the work if it's already pendin=
g.
>
> Kind regards,
> 	o.

