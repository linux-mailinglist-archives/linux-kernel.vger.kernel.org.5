Return-Path: <linux-kernel+bounces-45081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD15B842B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 172161C210EF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9300156968;
	Tue, 30 Jan 2024 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="oXUr4SUt"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02678612D;
	Tue, 30 Jan 2024 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706638198; cv=none; b=I7atQSvj26W7S7RtgkvnyWDm+K0JolAzz4mdqJ89idd3kZdS8l21O7ctusCTmDw/4EAJMAyVuVyDp2Jy+CbNTdS98jT10zNso++Yxc7Q0nZpus8RzoEZ0yM2Qc5sFUWPKYxlNa4O4kS17Q8ySJvjwVqqQXrRTwfAI7XbB3/5IHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706638198; c=relaxed/simple;
	bh=m87LuxG5SlcKEZJiG44L5Eg1MueyoN2vTGz62/+gQhM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jfUiZbcwIFm25B3JijfkjBy/tw0NOUsgiahrKoo48KMEuGC7mmebBMGhwXkBtK7hl11NzYZr0PV+vKeP2bfgwRcw6lMfW/Dz8dnXJOqu6YEOzoSfbIuJpEvbr5SXG/BNIxlVt1SlcXjmUQfkMgdCZPkCefPEWEg+cAkxGdOakRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=oXUr4SUt; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.20] (p5de453e7.dip0.t-ipconnect.de [93.228.83.231])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 2AA442FC004A;
	Tue, 30 Jan 2024 19:09:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1706638192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yt5XmcRwrc6b3h54Zz6Vh2inuJB9pyPk7T4/qPJrHe0=;
	b=oXUr4SUtxCpBwyI+wvB3hhhVwpbRHVJlKIdgP9iwrS3sIV/8miYDVzgfiRh4TxnqK2Z6JK
	HYx9o3mSmxmpVGnXN/ceoezdXa0FMUU6DXEcU5bz5cFFX1904+XV4T+2xsGWx7wg8Ixgay
	i12V14VEKexLjH9vn3EHB50UkIdywas=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <9851a06d-956e-4b57-be63-e10ff1fce8b4@tuxedocomputers.com>
Date: Tue, 30 Jan 2024 19:09:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Werner Sembach <wse@tuxedocomputers.com>
Subject: Re: Implement per-key keyboard backlight as auxdisplay?
To: Hans de Goede <hdegoede@redhat.com>, Pavel Machek <pavel@ucw.cz>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, jikos@kernel.org,
 Jelle van der Waa <jelle@vdwaa.nl>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Lee Jones <lee@kernel.org>,
 linux-kernel@vger.kernel.org,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 linux-input@vger.kernel.org, ojeda@kernel.org, linux-leds@vger.kernel.org
References: <aac81702-df1e-43a2-bfe9-28e9cb8d2282@tuxedocomputers.com>
 <ZSmg4tqXiYiX18K/@duo.ucw.cz>
 <CANiq72mfP+dOLFR352O0UNVF8m8yTi_VmOY1zzQdTBjPWCRowg@mail.gmail.com>
 <87sf61bm8t.fsf@intel.com> <ZVvHG/Q+V6kCnfKZ@duo.ucw.cz>
 <f4137e34-c7fb-4f21-bc93-1496cbf61fdf@tuxedocomputers.com>
 <8096a042-83bd-4b9f-b633-79e86995c9b8@redhat.com>
 <f416fbca-589b-4f6a-aad6-323b66398273@tuxedocomputers.com>
 <4222268b-ff44-4b7d-bf11-e350594bbe24@redhat.com>
 <ac02143c-d417-49e5-9c6e-150cbda71ba7@tuxedocomputers.com>
 <ZaljwLe7P+dXHEHb@duo.ucw.cz>
 <6bbfdd62-e663-4a45-82f4-445069a8d690@redhat.com>
 <0cdb78b1-7763-4bb6-9582-d70577781e61@tuxedocomputers.com>
 <7228f2c6-fbdd-4e19-b703-103b8535d77d@redhat.com>
 <730bead8-6e1d-4d21-90d2-4ee73155887a@tuxedocomputers.com>
 <952409e1-2f0e-4d7a-a7a9-3b78f2eafec7@redhat.com>
Content-Language: en-US, de-DE
In-Reply-To: <952409e1-2f0e-4d7a-a7a9-3b78f2eafec7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Hans,

resend because Thunderbird htmlified the mail :/

Am 30.01.24 um 18:10 schrieb Hans de Goede:
> Hi Werner,
>
> On 1/30/24 12:12, Werner Sembach wrote:
>> Hi Hans,
>>
>> Am 29.01.24 um 14:24 schrieb Hans de Goede:
<snip>
>> I think that are mostly external keyboards, so in theory a possible cut could also between built-in and external devices.
> IMHO it would be better to limit /dev/rgbledstring use to only
> cases where direct userspace control is not possible and thus
> have the cut be based on whether direct userspace control
> (e.g. /dev/hidraw access) is possible or not.

Ack

<snip>

>> So also no basic driver? Or still the concept from before with a basic 1 zone only driver via leds subsystem to have something working, but it is unregistered by userspace, if open rgb wants to take over for fine granular support?
> Ah good point, no I think that a basic driver just for kbd backlight
> brightness support which works with the standard desktop environment
> controls for this makes sense.
>
> Combined with some mechanism for e.g. openrgb to fully take over
> control as discussed. It is probably a good idea to file a separate
> issue with the openrgb project to discuss the takeover API.

I think the OpenRGB maintainers are pretty flexible at that point, after all 
it's similar to enable commands a lot of rgb devices need anyway. I would 
include it in a full api proposal.

On this note: Any particular reason you suggested an ioctl interface instead of 
a sysfs one? (Open question as, for example, I have no idea what performance 
implications both have)

<snip>

>> I opened an issue regarding this:https://gitlab.com/CalcProgrammer1/OpenRGB/-/issues/3916
> Great, thank you.
First replies are in.
> Regards,
>
> Hans

Kind regards,

Werner


