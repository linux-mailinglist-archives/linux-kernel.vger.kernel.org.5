Return-Path: <linux-kernel+bounces-147723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7058A7832
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46067B235EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5271F13A3E2;
	Tue, 16 Apr 2024 22:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAXy4T2O"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2CC78B49;
	Tue, 16 Apr 2024 22:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307954; cv=none; b=mts9MObV/SUiRNiodCG7i2C0F6T2Ad5ACXCbr0ersc31Z0TwC2m4aWRxNrv77Kt4AwrcwmCRRo0Bh+xIYQzJHFCnYaEWGTdlwAyvoTYzRywSZJRN8030TkEZBkUjC14pNvcfLivcdTiEanzbBJ9pL3ix+ezkdlccyg0iUkorbqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307954; c=relaxed/simple;
	bh=8CmaAHJ8fyCKUaR/yDyoxLnNdYL/VOQyhvKaNxuvxrk=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=HpjNRG/y/NHENRuY19+83vogcD+Lz0m0YmxQ7G0j1qdQX3TwDFMuOsF87tFzeD77PL5IG9V8PNoSwGTDnORVaqZb3axh1sadEgrvYlduLjdqAcqd7GWfBF1RtODTXG4VksXjWyIpZ4X+usY1/3bs3sxjXmLztGIT06Y+7tu5jso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAXy4T2O; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-518d98b9620so3703947e87.3;
        Tue, 16 Apr 2024 15:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713307951; x=1713912751; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=8CmaAHJ8fyCKUaR/yDyoxLnNdYL/VOQyhvKaNxuvxrk=;
        b=BAXy4T2OwC4+BnkXODC3jYUlznCaY3mH0HbLsSwRyf2On1cllRTBy6v1Tk6ZdEvVdC
         D9mAhqYaLIKv65dNi/tqSnLJFxQt3kGfvKnfCow3yv52MG+byX1uJfaX2uRoio29djiW
         7/g8jxQLCePyjzH+QL0tyUubEIGO0rmUenIx+RrE3uT2Zw5XmpcjY3RVT7eIIHx/S7ee
         Wl9RAAZSA5GDbczbtKzKMzkQYiligqPoID+2SGLh1a+GlLRSCMD6YZYHhHtamCB6fg0F
         F0th1oueHTRbxy8+mfMM0Bghpmq+M1R0YN2pimePW1G53sj/FeaVEIpuXPYZeuedoCca
         z1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713307951; x=1713912751;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CmaAHJ8fyCKUaR/yDyoxLnNdYL/VOQyhvKaNxuvxrk=;
        b=eGWhNqnqj5bHY+/wsVUlM744L9R5HfUdkGX6rnWUu+m+Zb2WG2wdO2CWw2Af3TvDSd
         MjPPOBvbYnxs1yDvqxOBZxam/VEF614pIza3N/lziEHFfPkkCD2WHkL9iuiGXoUuuU0T
         hxL5Yav8mdRmzOoD9LW4L0rsnG3cEXSi9a9wvKy+Ds97ETeDa6j02jiITGV2NsGWcplv
         Lf9fwvACtbDYhlkHKmadOokvmECc7Z/vhGoTOnpU66Y44cpG7sOwzSUBh4ayeX7F+ndl
         KqMoSn31ubN1Mlj8QkV0HlCc3/TEk1hpGEQXgljLfOXU22DaNbNsCJuV37kPIMZDpge+
         6wBg==
X-Forwarded-Encrypted: i=1; AJvYcCXfCA+iiEj+vJcTE7AgX792JjkZZb7qouJwMZUNhZh46lomBOCBLplWL2DYkab0KcJ5k6JFc9Oep/p4B5PHVKYiMRSjOLWrLC92GC/a
X-Gm-Message-State: AOJu0YxzZk/hXUftdPTnSKp1GJy0aJu5+fJnZiiBQPnOV+SuDbySRmS5
	2FYJOFJPhEBMpty8fxozq8AMYOcw8hDBaROYuZOhit4DqfciVuNo
X-Google-Smtp-Source: AGHT+IFA7efeiSxnQliLFhuuFA6SCWoOSUUc8wb3OIDCgyBC1/RUkicksxvs0fIrmKHUgEAtGzX2/g==
X-Received: by 2002:ac2:4253:0:b0:519:36ba:2229 with SMTP id m19-20020ac24253000000b0051936ba2229mr966616lfl.28.1713307950777;
        Tue, 16 Apr 2024 15:52:30 -0700 (PDT)
Received: from razdolb (95-24-153-47.broadband.corbina.ru. [95.24.153.47])
        by smtp.gmail.com with ESMTPSA id n19-20020a056512311300b005158d77665asm1737965lfb.30.2024.04.16.15.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 15:52:30 -0700 (PDT)
References: <20240402164552.19171-1-mike.rudenko@gmail.com>
 <20240402164552.19171-18-mike.rudenko@gmail.com>
 <ZhzEdXz-R2I6nZXf@kekkonen.localdomain> <87ttk274e6.fsf@gmail.com>
 <Zh4e9q_RFIe-JIzz@kekkonen.localdomain>
User-agent: mu4e 1.10.8; emacs 29.2.50
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Jacopo Mondi
 <jacopo@jmondi.org>, Tommaso Merciai <tomm.merciai@gmail.com>, Christophe
 JAILLET <christophe.jaillet@wanadoo.fr>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: [PATCH v4 17/20] media: i2c: ov4689: Configurable analogue crop
Date: Wed, 17 Apr 2024 01:51:40 +0300
In-reply-to: <Zh4e9q_RFIe-JIzz@kekkonen.localdomain>
Message-ID: <87pluo7weq.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On 2024-04-16 at 06:47 GMT, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> On Mon, Apr 15, 2024 at 11:22:09PM +0300, Mikhail Rudenko wrote:
>>
>> Hi Sakari,
>>
>> On 2024-04-15 at 06:08 GMT, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>>
>> > Hi Mikhail,
>> >
>> > On Tue, Apr 02, 2024 at 07:45:48PM +0300, Mikhail Rudenko wrote:
>> >> Implement configurable analogue crop via .set_selection call.
>> >> ov4689_init_cfg is modified to initialize default subdev selection.
>> >> Offsets are aligned to 2 to preserve Bayer order, selection width is
>> >> aligned to 4 and height to 2 to meet hardware requirements.
>> >>
>> >> Experimentally discovered values of the cropping-related registers and
>> >> vfifo_read_start for various output sizes are used. Default BLC anchor
>> >> positions are used for the default analogue crop, scaling down
>> >> proportionally for the smaller crop sizes.
>> >>
>> >> When analogue crop is adjusted, several consequential actions take
>> >> place: the output format is reset, exposure/vblank/hblank control
>> >> ranges and default values are adjusted accordingly. Additionally,
>> >> ov4689_set_ctrl utilizes pad crop instead of cur_mode width and
>> >> height for HTS and VTS calculation. Also, ov4689_enum_frame_sizes is
>> >> modified to report crop size as available frame size.
>> >
>> > We're amidst of a change to the APIs touching sensors with the the
>> > introduction of the internal pads.
>> > <URL:https://lore.kernel.org/linux-media/20240313072516.241106-1-sakari.ailus@linux.intel.com/T/#t>.
>> >
>> > I'd therefore postpone this bit so it would align with the new practices
>> > (also subject to change in the metadata set).
>> >
>> > The rest of the patches would seem more or less ready for merging to me.
>>
>> Okay, so I'll post a v5 of patches 1-16 with whitespace fixes (as you
>> suggested in patch 20) soon, and the remaining patches affected by the
>> metadata-related API changes as a separate series as soon those changes
>> land in media_stage. Do I get you right?
>
> Yes, please.

Done, see [1].

[1] https://lore.kernel.org/all/20240416224524.1511357-1-mike.rudenko@gmail.com/

--
Best regards,
Mikhail Rudenko

