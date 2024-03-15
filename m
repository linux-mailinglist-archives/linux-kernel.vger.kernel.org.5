Return-Path: <linux-kernel+bounces-104948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657CF87D65B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92A8283380
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A2C5491A;
	Fri, 15 Mar 2024 21:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jiq152X+"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1CC12B82;
	Fri, 15 Mar 2024 21:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710538910; cv=none; b=az2Qchnf4tCbsrVekhapT3yUKrvJzKJ2ZnbUJBQKdlZrRiiyGThNomvDvHJiKFwzcZJAhsj8wxkmVSMWM9DZsO5wRLQAfdA+Gz7VU1LM96IbcTgXKVagY2jgMK92siWr8ho+zDieMGVlFnC8j/pPBPAFRcrNsw/ALlY6JyfP4MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710538910; c=relaxed/simple;
	bh=/nGnq3hxjY4shar4UFIsYXg/H02Kuji0gsz0j+/Yk0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfDjGd+zNoHhTMc2DT4rsFWfzUHAAEAv8tMUxtfILpqfL1DbvLrZ3/siptWupW9dSoRBe1tjemLsMbhTTwEFl/wflgf/WpS1uKzuUSbwB+Novi/5KNh0r2QetibWkb8fHPdKfjPqfB12p1RxLJ7xrlIdPBjfm5J0J2DRMdEikiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jiq152X+; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so1947578a12.1;
        Fri, 15 Mar 2024 14:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710538907; x=1711143707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MfsIptA/4PZLiGdSLGGHlwjOlLY40NV1suJA7LpgEmg=;
        b=Jiq152X+hQJH0KsoLWKJo9Z9uV0ernXmE9hYukwprpUQUAGBK84drP9XZyTQK9vwNS
         WTYxCkINYdoEDQ5/26lpDisQ+ZoouSEfCu5G8w2693neK2ia1E1aLCI3NepVjphFd9CY
         KqArVsVA4NAOEDcTD7bCl32oUIdRNqolUoBVanrjvgiayx8cmSiRE50rEh8Ch4DMrO+c
         0YzjWqXXJCAltR8j2GL04bX/bcfxQ/m53CmjRIN2r+OX2lnzLMUxB8So/a1CisZ0nVQn
         q+hCV43rq/q945mQ/hhPnltplg1bODrJgBXBFRv1avBdHuyzxtJyUqbW0kdrGY2pDil6
         //nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710538907; x=1711143707;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MfsIptA/4PZLiGdSLGGHlwjOlLY40NV1suJA7LpgEmg=;
        b=X5vpRiDI1ybSoZUSX38DvNt6GxAgBosPU4JZZhnUS2MqIsxYIgiS9O3HsnWxI3IeZd
         9uLi9djCZvIXYrhzXquR4gqi2fAR5svojBBaEzaNb+DVjMfkd2+pCkpSC7Vl0MwUx48X
         doUhDXvg1wX2T+Ebr5SOcuv6KqZMX5YmDbL7or49t1V6kX/tPTOi0wDuhttTsqSJ75x+
         Hdim31fH6+hnu8CgF+EnYV6QnRhmRmo77F/PeE5ULavB3UJ5xkT5gHiSLt2F+f0uLzIl
         FpWpw3aSRh/xt5DQZpJDhSfgbgHVVT9k1zVR8J/NaEv35xnXNCwITPCXP3vl9KqiGYy5
         Tj8g==
X-Forwarded-Encrypted: i=1; AJvYcCXhgSeTvgWdlOtyfQtppQ3nfDHj63hop+3A0qvPK+NqrMkOBZ8AQF8oKU0TmGOI6UfzF18LGNQJ001Co0O8RciQ+I1qwytq67kEMStOYoKCI9Heb/n0iwi9+Do9Kou/xe+6y3x1Z4VFbHwttX7pkxzAV95P+XSkN/T7tQwmxrFTYSOR4w==
X-Gm-Message-State: AOJu0YzGmm69W0g/Dg2jl32JN4vVZTgCm4XqvW87wtrUuRGJC8uUHZas
	6L+FWsWkfllTBh0ccaOer0I7U7Yzs/PKfeEc9apP4bBinp1sUi6M
X-Google-Smtp-Source: AGHT+IHX+3R9SSRleSnLmp8BDxeZsd4p0itl5+n5AO/M3ml1OcNBcURbWzjM71sz3x19FXPcUQyPCA==
X-Received: by 2002:a17:90b:882:b0:29b:4755:23fc with SMTP id bj2-20020a17090b088200b0029b475523fcmr5925822pjb.33.1710538906691;
        Fri, 15 Mar 2024 14:41:46 -0700 (PDT)
Received: from [172.16.116.58] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id sj16-20020a17090b2d9000b0029bc2b845c4sm3417482pjb.11.2024.03.15.14.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 14:41:46 -0700 (PDT)
Message-ID: <656ca446-9e56-4879-bb42-cd29063e0a82@gmail.com>
Date: Sat, 16 Mar 2024 03:11:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] misc: Add mikroBUS driver
Content-Language: en-US
To: Vaishnav M A <vaishnav@beagleboard.org>
Cc: linux-kernel@vger.kernel.org, jkridner@beagleboard.org,
 robertcnelson@beagleboard.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jiri Slaby <jirislaby@kernel.org>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, greybus-dev@lists.linaro.org
References: <20240315184908.500352-1-ayushdevel1325@gmail.com>
 <CALudOK5v_uCUffxHGKS-jA-DKLNV7xwmKkxJwjHaMWWgDdPDqA@mail.gmail.com>
From: Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <CALudOK5v_uCUffxHGKS-jA-DKLNV7xwmKkxJwjHaMWWgDdPDqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/16/24 02:50, Vaishnav M A wrote:

> Hi Ayush,
>
> On Sat, Mar 16, 2024 at 12:19 AM Ayush Singh <ayushdevel1325@gmail.com> wrote:
>> MikroBUS is an open standard  developed by MikroElektronika for connecting
>> add-on boards to microcontrollers or microprocessors. It essentially
>> allows you to easily expand the functionality of your main boards using
>> these add-on boards.
>>
>> This patchset adds mikroBUS as a Linux bus type and provides a driver to
>> parse, and flash mikroBUS manifest and register the mikroBUS board.
>>
> As Russel had provided the feedback, this patchset does not add support
> for mikrobus, but a subset of mikrobus add-on boards which have a
> 1-wire click ID EEPROM with an identifier blob that is similar to the greybus
> manifest. This series lacks the necessary context and details to the
> specifications that is implemented.
>
> https://www.mikroe.com/clickid - you should atleast point to this specs.
>
>> The v1 and v2 of this patchset was submitted by Vaishnav M A back in
>> 2020. This patchset also includes changes made over the years as part of
>> BeagleBoards kernel.
>>
>> Link: https://www.mikroe.com/mikrobus
>> Link: https://docs.beagleboard.org/latest/boards/beagleplay/
>> Link: https://lore.kernel.org/lkml/20200818124815.11029-1-vaishnav@beagleboard.org/ Patch v2
>>
> Thank you for making the effort to upstream this, arriving at the
> latest revision of the public available click ID hardware took almost 2-3 years
> and I could not personally keep up with upstreaming, my sincere apologies to
> the maintainers that provided feedback on the earlier revisions. I hope an
> updated version of this series lands upstream with your work as the  efforts
> made at BeagleBoard.org Foundation makes development simpler by adding
> plug and play support to these add-on boards. Also this series mentions only
> the case where mikroBUS port is present physically on the board, but there
> can be mikroBUS ports appearing over greybus and that is the reason why
> greybus manifest was chose as descriptor format - the series needs to
> describe these details so that a reviewer has the necessary information
> to review your patches. A link to beagleconnect is also helpful to reviewers.
>
> https://docs.beagleboard.org/latest/projects/beagleconnect/index.html


Yes, I left out the mikroBUS over greybus patches for now since this 
patch series is already too big.

>> Changes in v3:
>> - Use phandle instead of busname for spi
>> - Use spi board info for registering new device
>> - Convert dt bindings to yaml
>> - Add support for clickID
>> - Code cleanup and style changes
>> - Additions required to spi, serdev, w1 and regulator subsystems
>>
>> Changes in v2:
>> - support for adding mikroBUS ports from DT overlays,
>> - remove debug sysFS interface for adding mikrobus ports,
>> - consider extended pin usage/deviations from mikrobus standard
>>    specifications
>> - use greybus CPort protocol enum instead of new protocol enums
>> - Fix cases of wrong indentation, ignoring return values, freeing allocated
>>    resources in case of errors and other style suggestions in v1 review.
>>
>> Ayush Singh (7):
> It looks like the version you have sent is very similar to the
> version I had previously updated for Beagleboard git with
> only rebases and cleanup, but I don't see major functional
> changes. I request you give credit to the original author
> atleast as a Co-author with Co-developed by tag, As there
> there was a significant amount of work done by myself to
> come up with this specs and get everything working on close
> to 150 mikrobus add-on boards on physical mikroBUS ports
> and over greybus:
> https://github.com/vaishnavachath/manifesto/tree/mikrobusv3/manifests

Yes, I will add Co-author and Co-developed tags. I think I should use 
your ti email? I would have preferred to keep you as the author in the 
git commit but I could not get the patches applied cleanly back when I 
tried it.

> The driver today is poorly written and was one of the first
> Linux kernel development work I did while I was still in college
> so I might have made a lot of blunders and just rebasing and
> reposting will not get this to an acceptable state, here is what
> I would recommend:
>
> * Drop all the unnecessary changes in the mikroBUS driver to
> support fixed-regulators, fixed-clocks, serdev device .etc and
> implement minimal changes to support the mikroBUS clickid
> devices.
>
> * Provide necessary justification to why the particular descriptor
> format (greybus manifest) is chosen, with pull request to manifesto
> and greybus-specification.
> https://github.com/projectara/greybus-spec
> and similar to : https://github.com/projectara/manifesto/pull/2
>
> * Move the mikrobus W1 driver to w1/ subsytem, it is a standard
> W1 EEPROM driver (also a standard part with updated family code)
> * Keep a RFC series of changes where mikroBUS ports can appear over
> greybus to justify why the identifier format needs to be extended greybus
> manifest.
>
>>    dt-bindings: misc: Add mikrobus-connector
>>    w1: Add w1_find_master_device
> Dependent patches that goes to different subsytems should
> be sent first separately to avoid confusion and then your series
> should mention the necessary dependencies. (same for
> spi).
>
>>    spi: Make of_find_spi_controller_by_node() available
>>    regulator: fixed-helper: export regulator_register_always_on
>>    greybus: Add mikroBUS manifest types
>>    mikrobus: Add mikrobus driver
>>    dts: ti: k3-am625-beagleplay: Add mikroBUS
> Send this patch as DONOTMERGE till your bindings are
> accepted.

Thanks, should I just add it in the message body? I cannot see anything 
in docs about that.

>> Vaishnav M A (1):
>>    serdev: add of_ helper to get serdev controller
>>
> Drop this from initial series,
> I will provide further feedback from my TI e-mail,
> Vaishnav Achath <vaishnav.a@ti.com>
>
> Thank again for taking this up,
>
> Thanks and Regards,
> Vaishnav
>
>>   .../bindings/misc/mikrobus-connector.yaml     | 110 ++
>>   MAINTAINERS                                   |   7 +
>>   .../arm64/boot/dts/ti/k3-am625-beagleplay.dts |  76 +-
>>   drivers/misc/Kconfig                          |   1 +
>>   drivers/misc/Makefile                         |   1 +
>>   drivers/misc/mikrobus/Kconfig                 |  19 +
>>   drivers/misc/mikrobus/Makefile                |   6 +
>>   drivers/misc/mikrobus/mikrobus_core.c         | 942 ++++++++++++++++++
>>   drivers/misc/mikrobus/mikrobus_core.h         | 201 ++++
>>   drivers/misc/mikrobus/mikrobus_id.c           | 229 +++++
>>   drivers/misc/mikrobus/mikrobus_manifest.c     | 502 ++++++++++
>>   drivers/misc/mikrobus/mikrobus_manifest.h     |  20 +
>>   drivers/regulator/fixed-helper.c              |   1 +
>>   drivers/spi/spi.c                             | 206 ++--
>>   drivers/tty/serdev/core.c                     |  19 +
>>   drivers/w1/w1.c                               |   6 +-
>>   drivers/w1/w1_int.c                           |  27 +
>>   include/linux/greybus/greybus_manifest.h      |  49 +
>>   include/linux/serdev.h                        |   4 +
>>   include/linux/spi/spi.h                       |   4 +
>>   include/linux/w1.h                            |   1 +
>>   21 files changed, 2318 insertions(+), 113 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/misc/mikrobus-connector.yaml
>>   create mode 100644 drivers/misc/mikrobus/Kconfig
>>   create mode 100644 drivers/misc/mikrobus/Makefile
>>   create mode 100644 drivers/misc/mikrobus/mikrobus_core.c
>>   create mode 100644 drivers/misc/mikrobus/mikrobus_core.h
>>   create mode 100644 drivers/misc/mikrobus/mikrobus_id.c
>>   create mode 100644 drivers/misc/mikrobus/mikrobus_manifest.c
>>   create mode 100644 drivers/misc/mikrobus/mikrobus_manifest.h
>>
>>
>> base-commit: 61996c073c9b070922ad3a36c981ca6ddbea19a5
>> --
>> 2.44.0
>>

I guess I will start with only i2c and spi support and go from there.


Ayush Singh


