Return-Path: <linux-kernel+bounces-145878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3276C8A5C43
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63A771C21474
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E01715574E;
	Mon, 15 Apr 2024 20:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/v/rB/W"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5F41DFEB;
	Mon, 15 Apr 2024 20:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713213192; cv=none; b=dQoeQ9slkZM5rB4WETGSly1a3rzsAfvLul/IeQirTXfNCSpccFflS+DjP8Pmfm5+6ajiGvJrR15DCoTN9lg1NhALag3PTr2OR31+mnRepRL+MJrlN7G1dHl7cwlvLL/RWojLQy2eexS8iSdmyH/d38d68Txp9xcVeWs/JoUk8uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713213192; c=relaxed/simple;
	bh=202/kfRQNpNY1+8sikfNJFZBuC6/M8MPtrfxrT6VgZA=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=gtGCY2JP0avlhkbcT6dKXgsiMEeAVtDp6YYf6JbTkLutQsjuceKTpAnLyo++FiBgQ8JTyzz2RHZOP2u7R++4bWnhaYckpECGXrqlLXwxqiN7CNRkwL0xjFWkJlRbteUYRtD2m5/NDLR5yXmlCLtWM2sRUW8WpuaQngRK2352wqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/v/rB/W; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-516d2b9cd69so4401631e87.2;
        Mon, 15 Apr 2024 13:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713213188; x=1713817988; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=202/kfRQNpNY1+8sikfNJFZBuC6/M8MPtrfxrT6VgZA=;
        b=D/v/rB/Ws4wRwfmsGk/7C6Y/XJjxmTWM1FzzhhewLN1eukAHOtguOM7e8sOrMJaKJu
         feRpO8m1+bvNfOZmKTtYhQdlIz5vB9EAtge8DCA9HYFUKvGl9FF5yTh6nSjlPTgAxdFm
         bm7x0+ZWDn6nb6ZQfpujWoYkLxg/aJ7OarJqHWbhGeb05ROkBLfdJqEvPINoe3MH2P3P
         T6qy8viY6gl3hj58oro9f5IsSDIB4lfUc48pJjMMfVzQxt/em3epMpmXW8r9mxkiu2zo
         IoD+DTWCbOLJHa4vncywDrVRLx7EZCUzilrv02fIpUqJKUzMmFrd/IKGpHiFxI++QZhY
         ScZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713213188; x=1713817988;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=202/kfRQNpNY1+8sikfNJFZBuC6/M8MPtrfxrT6VgZA=;
        b=ViQgm5aywR7EerJGFHHJ3LYE9hdj1aBHdESXHah6a89153hcaKXe4h/TlZo0wMy/VT
         Dqs7h30hOVZ89eS+/WoOlUDeFWD565p82L5eXkD2+ooIUJEdDmm3MOEZrQD+Scg0DhlV
         M0xn8Lcknd3IvkDvpocYTOQ+kxneJ8Ep2g/E8Fo7GaOgai78Sp6H5Gn7WIPPamPccH2j
         W9g8aQReYFmiENy2DlggnMdxa0RYf0vC3dJA9LRFA9zP2d+LauKixnaHb2iAaQQ05FcX
         9XF9ym2BJbhU9Fm8pIeCjrJ2YyvzGAiLuT9Sv0R4m32i2FUykFSLKRY8LfGSRFzW2Jfs
         JO6w==
X-Forwarded-Encrypted: i=1; AJvYcCVm4nQQKih6G1iW5kQeZd2i76zQC5k+L38t3lqjrtBBc374HCHAg7u3BL9w7kzojvG8popfgvDBuZSANnv2lSwexbLHTO1B7P320o9M
X-Gm-Message-State: AOJu0Yz9UgqzDRMK++gZ3S4ly9cHGpvb3w2fChVMAk57HTBSk5eGP0Ds
	riN6zRRC6lrv1raPGkkJlQgEG26o2PGHGySNNq3GH0eSpIdtaeZu
X-Google-Smtp-Source: AGHT+IHmVC7ihGkGZH3fEUz/z0drIFNOTFELCf5m4O2zl1w22pkogQ1L5Llz3y8AulnaYJ63RdZNzg==
X-Received: by 2002:a05:6512:ac6:b0:518:df4b:40e9 with SMTP id n6-20020a0565120ac600b00518df4b40e9mr3851405lfu.4.1713213187692;
        Mon, 15 Apr 2024 13:33:07 -0700 (PDT)
Received: from razdolb ([62.176.29.172])
        by smtp.gmail.com with ESMTPSA id o1-20020a056512052100b00513d1e9ce7esm1342192lfc.90.2024.04.15.13.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 13:33:07 -0700 (PDT)
References: <20240402164552.19171-1-mike.rudenko@gmail.com>
 <20240402164552.19171-18-mike.rudenko@gmail.com>
 <ZhzEdXz-R2I6nZXf@kekkonen.localdomain>
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
Date: Mon, 15 Apr 2024 23:22:09 +0300
In-reply-to: <ZhzEdXz-R2I6nZXf@kekkonen.localdomain>
Message-ID: <87ttk274e6.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Sakari,

On 2024-04-15 at 06:08 GMT, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> Hi Mikhail,
>
> On Tue, Apr 02, 2024 at 07:45:48PM +0300, Mikhail Rudenko wrote:
>> Implement configurable analogue crop via .set_selection call.
>> ov4689_init_cfg is modified to initialize default subdev selection.
>> Offsets are aligned to 2 to preserve Bayer order, selection width is
>> aligned to 4 and height to 2 to meet hardware requirements.
>>
>> Experimentally discovered values of the cropping-related registers and
>> vfifo_read_start for various output sizes are used. Default BLC anchor
>> positions are used for the default analogue crop, scaling down
>> proportionally for the smaller crop sizes.
>>
>> When analogue crop is adjusted, several consequential actions take
>> place: the output format is reset, exposure/vblank/hblank control
>> ranges and default values are adjusted accordingly. Additionally,
>> ov4689_set_ctrl utilizes pad crop instead of cur_mode width and
>> height for HTS and VTS calculation. Also, ov4689_enum_frame_sizes is
>> modified to report crop size as available frame size.
>
> We're amidst of a change to the APIs touching sensors with the the
> introduction of the internal pads.
> <URL:https://lore.kernel.org/linux-media/20240313072516.241106-1-sakari.ailus@linux.intel.com/T/#t>.
>
> I'd therefore postpone this bit so it would align with the new practices
> (also subject to change in the metadata set).
>
> The rest of the patches would seem more or less ready for merging to me.

Okay, so I'll post a v5 of patches 1-16 with whitespace fixes (as you
suggested in patch 20) soon, and the remaining patches affected by the
metadata-related API changes as a separate series as soon those changes
land in media_stage. Do I get you right?

--
Best regards,
Mikhail Rudenko

