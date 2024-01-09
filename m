Return-Path: <linux-kernel+bounces-20971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE6C8287E9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712841F251CC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9DD39AC0;
	Tue,  9 Jan 2024 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaByO4AF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B016E3984A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704809899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3THNFHQS5wwo4cI4QVHpCKin2eJ0VsiVpReOMSRKkw=;
	b=FaByO4AFMIloAe0Lx4OWS9QUBDg6Klz+ULPtzq0axKDMjaHfJETY1lGdnnKYkz0VuR86t7
	zdV7IvFLDSpyQ/M6O8USNurgobC0FgXn2FddppIkoSIQq1XsqMT7d6OAd3+4t8oAMJGFq/
	PoF8mAC/ox/31EfnzDd9cnpSwUuaEX0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-axC3MfuLMQacYPlSe3Wr4w-1; Tue, 09 Jan 2024 09:18:18 -0500
X-MC-Unique: axC3MfuLMQacYPlSe3Wr4w-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-554acc951faso1941076a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 06:18:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704809897; x=1705414697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3THNFHQS5wwo4cI4QVHpCKin2eJ0VsiVpReOMSRKkw=;
        b=IbiRY6J8XE/hSwEopqWXFwED9AKp0SaiHKAL2FakGxtfWKksjR040OOKB+2+CnYsJI
         D4IWRfdcEuvTf16Q/z0daRwxXchdE8BDl+7HwmP4EoP/VoZ3UWHPLU9KanTSSneNaU+p
         FjLC6PvTA0Y+Vrj1Oc70VCIQ/aFqB3C+nfzpaN2DsAysWFduMaUqNyxIxUmdNXT5ZHZo
         /6B/znWhlpD8f6wkBskdrGNmMvmR28y/qTzHRCV+qs+szxcawhAmNGlxrvDXi0a49gUh
         ks4aB0J6Rb0FdvXB6tMm8nZF+4aLrUwVsYItcFgb+TqdQ+SFCamBJjtKB+rpOdPwdOM0
         oK2Q==
X-Gm-Message-State: AOJu0YxTgfmpgILC8GTkUYFPGLj0rmnjz3s62BekZ/nMUuSbq5ByAUwl
	7hylTukxLUlxpvOteJ5eCvcn+BrtZzGZuk21GDwlJuZer/1bZEwZ6oXvOW3dvCQsAfbPVWIDSQ7
	GLkXWSOhB2arsIfQnKjtTbDwCH/NiMZU7emxIxvtbbEJWfnc4
X-Received: by 2002:a50:a69a:0:b0:557:17d5:9afe with SMTP id e26-20020a50a69a000000b0055717d59afemr2594698edc.66.1704809897191;
        Tue, 09 Jan 2024 06:18:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnxz/MmvkNTxaoNNw0HTzCCSkv+92BVZ2g1k8dn0fX+gCCKNB5Cu4wEGfVWClLdQrqXvDCk1kHOD1FtOQuk7Q=
X-Received: by 2002:a50:a69a:0:b0:557:17d5:9afe with SMTP id
 e26-20020a50a69a000000b0055717d59afemr2594687edc.66.1704809896861; Tue, 09
 Jan 2024 06:18:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3277085.44csPzL39Z@natalenko.name> <824573bb-ae01-41b9-8f97-a760ae8f3f18@redhat.com>
In-Reply-To: <824573bb-ae01-41b9-8f97-a760ae8f3f18@redhat.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Tue, 9 Jan 2024 15:18:05 +0100
Message-ID: <CAO-hwJ+GLVYzYKUv=NyhEVb-_h_3NAstv6sjL8stqDMkS98j+w@mail.gmail.com>
Subject: Re: Flood of logitech-hidpp-device messages in v6.7
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
	Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jikos@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 12:58=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi Oleksandr,
>
> On 1/9/24 12:45, Oleksandr Natalenko wrote:
> > Hello Hans et al.
> >
> > Starting from v6.7 release I get the following messages repeating in `d=
mesg` regularly:
> >
> > ```
> > Jan 09 10:05:06 spock kernel: logitech-hidpp-device 0003:046D:4051.0006=
: Disconnected
> > Jan 09 10:07:15 spock kernel: logitech-hidpp-device 0003:046D:408A.0005=
: Disconnected
> > Jan 09 10:16:51 spock kernel: logitech-hidpp-device 0003:046D:4051.0006=
: HID++ 4.5 device connected.
> > Jan 09 10:16:55 spock kernel: logitech-hidpp-device 0003:046D:408A.0005=
: HID++ 4.5 device connected.
> > Jan 09 10:16:55 spock kernel: logitech-hidpp-device 0003:046D:408A.0005=
: HID++ 4.5 device connected.
> > Jan 09 10:36:31 spock kernel: logitech-hidpp-device 0003:046D:4051.0006=
: Disconnected
> > Jan 09 10:37:07 spock kernel: logitech-hidpp-device 0003:046D:4051.0006=
: HID++ 4.5 device connected.
> > Jan 09 10:46:21 spock kernel: logitech-hidpp-device 0003:046D:4051.0006=
: Disconnected
> > Jan 09 10:48:23 spock kernel: logitech-hidpp-device 0003:046D:408A.0005=
: Disconnected
> > Jan 09 11:12:27 spock kernel: logitech-hidpp-device 0003:046D:4051.0006=
: HID++ 4.5 device connected.
> > Jan 09 11:12:47 spock kernel: logitech-hidpp-device 0003:046D:408A.0005=
: HID++ 4.5 device connected.
> > Jan 09 11:12:47 spock kernel: logitech-hidpp-device 0003:046D:408A.0005=
: HID++ 4.5 device connected.
> > Jan 09 11:38:32 spock kernel: logitech-hidpp-device 0003:046D:4051.0006=
: Disconnected
> > Jan 09 11:43:32 spock kernel: logitech-hidpp-device 0003:046D:408A.0005=
: Disconnected
> > Jan 09 11:45:10 spock kernel: logitech-hidpp-device 0003:046D:4051.0006=
: HID++ 4.5 device connected.
> > Jan 09 11:45:11 spock kernel: logitech-hidpp-device 0003:046D:408A.0005=
: HID++ 4.5 device connected.
> > Jan 09 11:45:11 spock kernel: logitech-hidpp-device 0003:046D:408A.0005=
: HID++ 4.5 device connected.
> > Jan 09 12:31:48 spock kernel: logitech-hidpp-device 0003:046D:4051.0006=
: Disconnected
> > Jan 09 12:33:21 spock kernel: logitech-hidpp-device 0003:046D:4051.0006=
: HID++ 4.5 device connected.
> > ```
> >
> > I've got the following hardware:
> >
> > * Bus 006 Device 004: ID 046d:c52b Logitech, Inc. Unifying Receiver
> > * Logitech MX Keys
> > * Logitech M510v2
> >
> > With v6.6 I do not get those messages.
> >
> > I think this is related to 680ee411a98e ("HID: logitech-hidpp: Fix conn=
ect event race").
> >
> > My speculation is that some of the devices enter powersaving state afte=
r being idle for some time (5 mins?), and then wake up and reconnect once I=
 touch either keyboard or mouse. I should highlight that everything works j=
ust fine, it is the flood of messages that worries me.
> >
> > Is it expected?
>
> Yes this is expected, looking at your logs I see about 10 messages per
> hour which IMHO is not that bad.
>
> I guess we could change things to track we have logged the connect
> message once and if yes then log future connect messages (and all
> disconnect messages) at debug level.


Sounds reasonable to me.

Cheers,
Benjamin


>
>
> Jiri, Benjamin, do you have any opinion on this ?
>
> Regards,
>
> Hans
>
>
>


