Return-Path: <linux-kernel+bounces-20819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA4C8285A3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A5B1C23B56
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099D1374F6;
	Tue,  9 Jan 2024 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOGh+kia"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E887A374D9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704801499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A46ZABusnuPby4jfDWsq1H+YiDfFZvDkeQGqnfkjvNE=;
	b=NOGh+kiaWNdWEWsPu1W6mnSZwK7Kee1dgAEDcRr1s8ULBneZEAHnhwBuaaURuPZrh6Dyz9
	HHm3h6eEuj4JuQLf6rD/SHyPnK3/isGIyM5K5B2qtmGFEu5nDNHl8hfhI0sskWFxdIyuqN
	OzU8Ou/FRSH27FUTWT3yfjZbTUkchI8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-D1uAaXLTPHmOuvfyZJOIcA-1; Tue, 09 Jan 2024 06:58:13 -0500
X-MC-Unique: D1uAaXLTPHmOuvfyZJOIcA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a28f0137fd9so137812366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 03:58:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704801492; x=1705406292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A46ZABusnuPby4jfDWsq1H+YiDfFZvDkeQGqnfkjvNE=;
        b=CWf6t833tRr8eszNeqKjGTr4glriILiNPZOZ4WJxwiRoPrnNW+b/WKSpBLnIkYqy2Q
         4o5CUcj/5d37cBUQBBGgJuA4a5jnsR4jjF7aqY05f+eQAodltSDBMSOfiuCc6BSV5D6L
         W1uVMDTca9eCLhPVaa3tsZ9dclEXO5hhIJyELwNmTw4/B/w6UJOiFpXGWKFbGrAGwUcC
         2Ct2NKHyrw1yJA9f2uAOOZwwXNREorZMLlpzHk1HDXuXfrfPByYj/ScMrwBTP1KbullH
         bw4VUeaIe2j2mO3X1pNKUtRCSDklVcPRqFnJIhk9q4yM/JjJ7HKjZXX8CFA/P4ORxq/T
         Yq6Q==
X-Gm-Message-State: AOJu0YyPHk3U7Y6gcW9LHk0j/mv1JaACHmSqC8FNNZP8XhRuhhx+ou3l
	MlR2iP32dspnbS9HUMFy2eVpkoWq3iltjgcfoWbZvRT0dgGnZf2oYWrNMoPd3OffZpCjR496ywd
	hF6kS4KlqZkGqpZWapKYU8+UbsRc5WBeQ
X-Received: by 2002:a17:906:2318:b0:a26:84d8:9411 with SMTP id l24-20020a170906231800b00a2684d89411mr397721eja.128.1704801492356;
        Tue, 09 Jan 2024 03:58:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUPUo3Hf8NYwcxCCtWDmcKKsI+mhttPHlNo0mn1ibzA/uXwyGd+oIvo4cIgDpDnrlGV35e5Q==
X-Received: by 2002:a17:906:2318:b0:a26:84d8:9411 with SMTP id l24-20020a170906231800b00a2684d89411mr397712eja.128.1704801492005;
        Tue, 09 Jan 2024 03:58:12 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id lf8-20020a170907174800b00a2a360d719fsm959961ejc.221.2024.01.09.03.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 03:58:11 -0800 (PST)
Message-ID: <824573bb-ae01-41b9-8f97-a760ae8f3f18@redhat.com>
Date: Tue, 9 Jan 2024 12:58:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Flood of logitech-hidpp-device messages in v6.7
To: Oleksandr Natalenko <oleksandr@natalenko.name>,
 linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, =?UTF-8?Q?Filipe_La=C3=ADns?=
 <lains@riseup.net>, Bastien Nocera <hadess@hadess.net>,
 Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>
References: <3277085.44csPzL39Z@natalenko.name>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <3277085.44csPzL39Z@natalenko.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Oleksandr,

On 1/9/24 12:45, Oleksandr Natalenko wrote:
> Hello Hans et al.
> 
> Starting from v6.7 release I get the following messages repeating in `dmesg` regularly:
> 
> ```
> Jan 09 10:05:06 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: Disconnected
> Jan 09 10:07:15 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: Disconnected
> Jan 09 10:16:51 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: HID++ 4.5 device connected.
> Jan 09 10:16:55 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
> Jan 09 10:16:55 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
> Jan 09 10:36:31 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: Disconnected
> Jan 09 10:37:07 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: HID++ 4.5 device connected.
> Jan 09 10:46:21 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: Disconnected
> Jan 09 10:48:23 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: Disconnected
> Jan 09 11:12:27 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: HID++ 4.5 device connected.
> Jan 09 11:12:47 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
> Jan 09 11:12:47 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
> Jan 09 11:38:32 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: Disconnected
> Jan 09 11:43:32 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: Disconnected
> Jan 09 11:45:10 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: HID++ 4.5 device connected.
> Jan 09 11:45:11 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
> Jan 09 11:45:11 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
> Jan 09 12:31:48 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: Disconnected
> Jan 09 12:33:21 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: HID++ 4.5 device connected.
> ```
> 
> I've got the following hardware:
> 
> * Bus 006 Device 004: ID 046d:c52b Logitech, Inc. Unifying Receiver
> * Logitech MX Keys
> * Logitech M510v2
> 
> With v6.6 I do not get those messages.
> 
> I think this is related to 680ee411a98e ("HID: logitech-hidpp: Fix connect event race").
> 
> My speculation is that some of the devices enter powersaving state after being idle for some time (5 mins?), and then wake up and reconnect once I touch either keyboard or mouse. I should highlight that everything works just fine, it is the flood of messages that worries me.
> 
> Is it expected?

Yes this is expected, looking at your logs I see about 10 messages per
hour which IMHO is not that bad.

I guess we could change things to track we have logged the connect
message once and if yes then log future connect messages (and all
disconnect messages) at debug level.

Jiri, Benjamin, do you have any opinion on this ?

Regards,

Hans




