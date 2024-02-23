Return-Path: <linux-kernel+bounces-77936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFBF860CF2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7E6281EFE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD78F29D08;
	Fri, 23 Feb 2024 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="uiGUC3PN"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A3A1946C;
	Fri, 23 Feb 2024 08:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708677232; cv=none; b=swkSu06jotNYeuUzksfOQuoU5rzVa2cDYhZrrI0jDDXx8/CARBTSMJP/HaPg7KT+eNkO+ko+QR+WrhvhskT9rwn7Q2jGXIlSnG5zy2sPDznHGNTDHCzQ/mN7PPqbihUl8po7z6+1+J/TIcg1ykLQSRBWLVLVeHKa9hnt7jZX0ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708677232; c=relaxed/simple;
	bh=5c0V9iUcpSHiDMvTejGO6cBy5XVestFd+FPyt7ByrNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/+5yM1KMqsSvWlhHUU2jI9nhZC70514CeRkVEVYwulbNSXNKWFf27/sTij46rBYFh6JmKLJZ7i4JoJiqc1CFrIp3en1AGfiYEcRmuXgf3TqcRdH3G4BEF3IKEAwsPljNinoXtcBUCH9xi6nbR+VqlWO+s5KIJox2i828V5WUxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=uiGUC3PN; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.20] (pd9e59c8a.dip0.t-ipconnect.de [217.229.156.138])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id D55A92FC0048;
	Fri, 23 Feb 2024 09:33:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1708677222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hyg/6mIbbTS+jgvBpDapIOM2QZ8XaLynxTsM3xRcdr0=;
	b=uiGUC3PNuqR8MRaR8BM4zMwX+uJOlh79kFVIufcDk4kXGjhe/w44A2tFFVubAtH+YXlD8i
	WXoK/JYaw9BqwItu0YEa6blEf3H8bn1cudUoBjecz7Jf1hTD/YVRKmZG8ur14Sx+onhp71
	Nxa8LUFPzUedZJHyTXFiJZi76cLcdTc=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <38b6998a-eb5c-44b6-95c9-260bd84046af@tuxedocomputers.com>
Date: Fri, 23 Feb 2024 09:33:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Future handling of complex RGB devices on Linux v2
Content-Language: en-US
To: Pavel Machek <pavel@ucw.cz>
Cc: Hans de Goede <hdegoede@redhat.com>, Lee Jones <lee@kernel.org>,
 jikos@kernel.org, linux-kernel@vger.kernel.org,
 Jelle van der Waa <jelle@vdwaa.nl>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 linux-input@vger.kernel.org, ojeda@kernel.org, linux-leds@vger.kernel.org
References: <0cdb78b1-7763-4bb6-9582-d70577781e61@tuxedocomputers.com>
 <7228f2c6-fbdd-4e19-b703-103b8535d77d@redhat.com>
 <730bead8-6e1d-4d21-90d2-4ee73155887a@tuxedocomputers.com>
 <952409e1-2f0e-4d7a-a7a9-3b78f2eafec7@redhat.com>
 <9851a06d-956e-4b57-be63-e10ff1fce8b4@tuxedocomputers.com>
 <1bc6d6f0-a13d-4148-80cb-9c13dec7ed32@redhat.com>
 <b70b2ea8-abfd-4d41-b336-3e34e5bdb8c6@tuxedocomputers.com>
 <477d30ee-247e-47e6-bc74-515fd87fdc13@redhat.com>
 <e21a7d87-3059-4a51-af04-1062dac977d2@tuxedocomputers.com>
 <247b5dcd-fda8-45a7-9896-eabc46568281@tuxedocomputers.com>
 <ZdZ2kMASawJ9wdZj@duo.ucw.cz>
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <ZdZ2kMASawJ9wdZj@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Am 21.02.24 um 23:17 schrieb Pavel Machek:
> Hi!
>
>> so after more feedback from the OpenRGB maintainers I came up with an even
>> more generic proposal:
>> https://gitlab.com/CalcProgrammer1/OpenRGB/-/issues/3916#note_1753072869
>>> evaluate-set-command ioctl taking:
>>> {
>>>      enum command                /* one of supported_commands */
>>>      union data
>>>      {
>>>          char raw[3072],
>>>          {
>>>              <input struct for command 0>
>>>          },
> Yeah, so ... this is not a interface. This is a backdoor to pass
> arbitrary data. That's not going to fly.
>
> For keyboards, we don't need complete new interface; we reasonable
> extensions over existing display APIs -- keyboards are clearly 2D.

Maybe we should look on this from a users perspective: Running custom Animation 
(i.e. where treating it as a display would be helpfull) is only >one< of the 
ways a user might want to use the keyboard backlight.

Equally viable are for example:
- Having it mono colored.
- Playing a hardware effect
- Playing a hardware effect on one side of the keyboard while having the other 
side of the keyboard playing a custom animation (As I learned from the OpenRGB 
maintainers: There are keyboards which allow this)

There is no reason to define a custom animation as the default and then just 
bolt the other options on top as it might not even be possible for some devices 
where the firmware is plainly to slow for custom animations.

Also I still think a 2*2, 1*3 or even 1*1 matrix is not a display, coming back 
aground to the earlier point where I want to implement this for keyboard first, 
but this discussion is also thought to find a way that works for all complex RGB 
devices. And I don't think it is a good idea find a way that works for keyboards 
and then introduce again something completely new for other device categories.

>
> Best regards,
> 								Pavel

Best regards,

Werner


