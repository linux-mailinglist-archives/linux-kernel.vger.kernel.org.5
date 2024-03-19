Return-Path: <linux-kernel+bounces-107475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DDA87FD03
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DEDE2815F1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069237EF14;
	Tue, 19 Mar 2024 11:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcYsrBZr"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD9F53E09;
	Tue, 19 Mar 2024 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710848224; cv=none; b=lRDnjzQKeoun2ikNAVBtlsNCx6OBpJljsbnL1vGJe0DrnM7yz4+4syqCYA3YCc367vpB0LKU5p9TgxoYr55kX7AdxbnP8dKVLa/Xz5LUKl1xDdfIfxQFoxsYEWxlQA8k2VVk+yFOLBJ19+7S4dn3FrvulaOHPGB2X4z9sAfaDfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710848224; c=relaxed/simple;
	bh=qKcu8EaYJp0rxLpfIpqkAN5cPH1+9ScDj2xHFfsv2ZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pjLoFXiLbbgGapihAN6iM0leM39jy0fkda6VVnK7CpKSoo86djIpW8C/U2MgaN2ANy/6qw/VwLk6nLY4dypseIA7WRc78zcE4pUu9Ge5ZVUWGeoP3NyQs02Rs9zdi+b0CphM3jay87sG1WsZyK18HEWjNxEMqS6lWcuFUOp3VOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcYsrBZr; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e00896dfdcso14128815ad.1;
        Tue, 19 Mar 2024 04:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710848222; x=1711453022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=umAIavC67cazmJ9lW2ejp2jSJGxVPgTOeby3+DV2+G4=;
        b=JcYsrBZrh/cC4qT6ZqtinwYsNFQc5A0RBfgObkG73u38w4vBEp7PXDwY2BOmZsUypn
         Ck0Fhkzyy+HkHZBul092FeIEiv3WOjMZAeBFdV5lCy+GAnQ6N4dc5ARzsUvwh6Mbi4QM
         6VzskSUoF6d0Z0WGRrW82SXLWUb8W5cHYB9sPdfBEUVSKFDsnunbUtyTDHS9LeZROl02
         AyqP1ZM2BQqlP28GTzCVu/UX8I2E2dq/PtS8AT5FzzO8r+cWBUBWjIAP6S4mqy8aVrZd
         iloryZ+6GmqhJl6lk0TI6sJoAtqKAc8F46ZyGQ62V/V2eKgdr3Red/qaa8YZUTzjcX/U
         tGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710848222; x=1711453022;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=umAIavC67cazmJ9lW2ejp2jSJGxVPgTOeby3+DV2+G4=;
        b=isUec89rXbkgocP8uMFtk+V18hDLYCpri9oKcrj80JRpuooPE4ORYVvNP+YQzDLB2A
         WwJ/rA/ukvmWAffTO1W+D92OESM5WlboKXYsV1UFJ3U80g/z8PoB56pmg01ZgiSpeCI8
         KhZuI84AYeaHscypyDUpZ7t8ihWhj/qQ/juk2S83oO/qJYAvxrvAXFQjemdpYAoKFhUK
         0RE6HWmOgRQz3tjOFJGbji/HgWuyosXPVbrkStDtCdojF4tWuQrX956RshGvj6BwBK7f
         +bNxwRCoLh0dOKx/UcfzxHxmWdJ0lL1impbgfm+WhgBHkpLfsfgYNNtDYPFpx1tqEcXx
         TwQg==
X-Forwarded-Encrypted: i=1; AJvYcCXqEG5O9ZBRNqCxeKIT9DbPDEY54WPgftuLpSdBaxnWo4voRYuX7LlbhHBNcLGgMRSqQBKU7oUdZtw7339aUaTfHSw06mYfVrx5GhQflCNbSTyxb8jW2sdap6eFRym5m29SffKW52PBxZERqessk0BvlDz1aD318Pt6V2OjWtFuQkCTlQ==
X-Gm-Message-State: AOJu0YxjudfQ8xS9/o7o5lsfdP5UDP4DHhnyBNYiTbPMXuQbpUkxkfg6
	56kno5nLWqRt9U/4UEJwqKAhXPilWf83IAJ8Ho8eFb5pw/C06WcDrWxmDcWNo1A=
X-Google-Smtp-Source: AGHT+IF+DsFLA4Qvhq8yiEnjGjx2GBguwAi8iI5wKdvQAedsOquaxYYW+xLfytLU6wfSwtrLpVXPfw==
X-Received: by 2002:a17:902:6502:b0:1e0:3861:9e46 with SMTP id b2-20020a170902650200b001e038619e46mr2136786plk.49.1710848222071;
        Tue, 19 Mar 2024 04:37:02 -0700 (PDT)
Received: from [172.16.116.58] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id lg7-20020a170902fb8700b001dd1d7bc0f7sm11218702plb.154.2024.03.19.04.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 04:37:01 -0700 (PDT)
Message-ID: <5a9b1cd9-05ec-4606-92b6-eadbc7af6202@gmail.com>
Date: Tue, 19 Mar 2024 17:06:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] dt-bindings: misc: Add mikrobus-connector
Content-Language: en-US
To: Michael Walle <mwalle@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: jkridner@beagleboard.org, robertcnelson@beagleboard.org,
 lorforlinux@beagleboard.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vaishnav M A <vaishnav.a@ti.com>, Mark Brown <broonie@kernel.org>,
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
 "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
 Vaishnav M A <vaishnav@beagleboard.org>
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
 <20240317193714.403132-2-ayushdevel1325@gmail.com>
 <CZWVF90JJO98.2M7ARQ9WMGC94@kernel.org>
 <d4dc4d94-d323-4158-8c08-b7d37d8750d3@gmail.com>
 <0f3f56d4-3381-44f1-91bc-c126f3ced085@linaro.org>
 <c8031e17-5ae8-4794-8b8c-1736be6452d3@gmail.com>
 <CZXMK3W52AFO.1APK080GVJESK@kernel.org>
From: Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <CZXMK3W52AFO.1APK080GVJESK@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/24 15:08, Michael Walle wrote:

> Hi,
>
>> Regardless, this patch actually does not contain any code for EEPROM
>> support I have just mentioned it to give more context on why mikroBUS
>> manifest is the focus of this patch instead of DT overlay or something
>> else.
> Right, and I think this is the crux here. Why can't you use DT
> overlays? The manifest files, seem to be yet another hardware
> description (method) and we already have DT. Can't we have some kind
> of userspace helper that could translate them to DT overlays? That
> way, you could also handle the EEPROM vs non-EEPROM case, or have
> some other kind of method to load a DT overlay.
>
> Admittedly, I've never worked with in-kernel overlays, but AFAIK
> they work with some subsystems.
>
> -michael


So let me 1st go over 3 cases that the driver needs to support:

1. Non EEPROM boards:

Using overlays should be pretty similar to current solution. If the 
manifest is converted to overlay in userspace, then we do not even need 
to do manifest parsing, setting up spi, i2c etc in the kernel driver.


2. EEPROM boards

How do you propose handling these. If you are proposing storing dt 
overlay in EEPROM, then this raises some questions regarding support 
outside of Linux.

The other option would be generating overlay from manifest in the kernel 
driver, which I'm not sure is significantly better than registering the 
i2c, spi, etc. interfaces separately using standard kernel APIs.


3. Over Greybus

It is quite important to have mikroBUS over greybus for BeagleConnect. 
This is one of the major reasons why greybus manifest was chosen for the 
manifest format.


Also, it is important to note that mikroBUS manifest is being used since 
2020 now and thus manifests for a lot of boards (both supporting clickID 
and not supporting it exist). So I would prefer using it, unless of 
course there are strong reasons not to.


Ayush Singh

CorrectBasicCloseSpellingPossible spelling mistake found.GrabsGrey 
busIgnore

