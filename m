Return-Path: <linux-kernel+bounces-126794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AAE893CCD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AE3CB22714
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC04E4CDE0;
	Mon,  1 Apr 2024 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20230601.gappssmtp.com header.i=@fireburn-co-uk.20230601.gappssmtp.com header.b="CDoC1mx2"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8BA4AEF6
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711984864; cv=none; b=lmo0PxIOL7raJDhmeO77LiDwOgCpJXci+lFtMuTkvGIye6ZR9ddVnUw40sjfGu/uVX20SrjB3kv3R3v16FsRaZkM17/fCn3NqExl/jbYum98+uM3ZY8jWtNbYPUaTPbBJpod0toD89Vxk+mm8GjNldoJ+IBwdzpSkJO2Sjga++A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711984864; c=relaxed/simple;
	bh=nW4KVcUljnrqT34rDqiJ5XMz9R+fw396kTItAuhWVC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=koiwBuc83Vydh6fvMEAqg/zuFu8X2c4c80PYdnv4QGpG3sIxVfIM0wnxSadylHKJGqp+TMmFgsrJz+PKUkBOJoldeN4uXDvF91oFplJt+LD/yQ7HgT57ux9GWodShlTxHKV3NuppQ8YJ+ov7LqeC05IxqyF6sqwagY4zRaq3LsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk; spf=none smtp.mailfrom=fireburn.co.uk; dkim=pass (2048-bit key) header.d=fireburn-co-uk.20230601.gappssmtp.com header.i=@fireburn-co-uk.20230601.gappssmtp.com header.b=CDoC1mx2; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fireburn.co.uk
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2a07b092c4fso3106941a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 08:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20230601.gappssmtp.com; s=20230601; t=1711984862; x=1712589662; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Kyf88o4qsQlO/wR+KsemeXOmT0rB7nYlUY+SaWAaQc=;
        b=CDoC1mx2Yrpa5tdATcbKXMf/VAxsAtlJixpbZxmsulMQsRE20IcUtRBfX+r6vfV46W
         UTFlx6kCqA+yragjAWVU9/GcsszkgvygORS1RB1OqkM6icoJtfE7Se60X9gr7QV7LPoz
         l87mC1XGoOM3Qq9ES62I1cQu8QpcB4AjcTmhFfzVJ7/drTVsrn93Yl4V9qJagJYvgaoS
         gbGse+HBBnERS1GJfhvsoC1eADa7DisXXvTLG1jYXccbv5vIiJi+MNknIa1U98BufZp1
         DRSzVVRCxFq7A3PqNupj0hVp8mi05qBx42f32eklsgkvhGAMlUhbCg3MJBcGhRxq8FYO
         BRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711984862; x=1712589662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Kyf88o4qsQlO/wR+KsemeXOmT0rB7nYlUY+SaWAaQc=;
        b=GMTFUlOg1EPMT/JP8n7Q8+3iWuLZZIa8YadS0AMGK+mbtqUf6qE1YL7MqyxYAHj0pV
         eH2Ij8CMA3SOGjZl//i+eWT77CC2GSbbPBdbYkWYyYJfT9ta6hu6aBxFMWFpN1nQOD/I
         ZgNvWhBvZP9g0J7NdehsaalZDHW6wH/tbagcTLEjMvP1uT26cXAzHv+UJm3ZFGLQEAaw
         TiJErV8eEzA9JIcx1VKgucjKoQy8czil1LBLmrKtEx/Cq4FlxyPwBsWXD2Mmv7kEH42W
         xKcskjPJqUUKjCJBFyLedQjRCtYItWLfSFnRpK+sK1e05tKYNXJ5xWsQyQSK59ES8UYO
         qDtg==
X-Forwarded-Encrypted: i=1; AJvYcCWriXbHcfseU067ckinH9dWlTWHavOd+kN3M4SHZE52U6joXdsz6VCRd7AkEJ5dl76DTukJMAyeocv0NpEw4lNm0XIJEuUC7B51hD0+
X-Gm-Message-State: AOJu0YwtzLTMM6BPQeEKy2vlXaroW2H9PMHvJzL1iUBcNe+UrCDIsM7x
	2KiNsfXzVmwFm/GxzhyBn72fhCw8+BfVgfY0UTOwrXi7W57VLyD/aKWgeHJtKJodt5Rl1Vhnpbe
	g6GD0zJSPUbTANKiO+Ld4HOuvvp51UL8v3Mok
X-Google-Smtp-Source: AGHT+IFPdgTg4m5tdz2zVUYiPfiHs6ZUPBKRXVgXamNWYYGHph95LpNshQvN2PHe1hlxkS0udPLirfwMVN9/FJiljx4=
X-Received: by 2002:a17:90a:f3c6:b0:2a0:5234:6842 with SMTP id
 ha6-20020a17090af3c600b002a052346842mr8533728pjb.31.1711984861895; Mon, 01
 Apr 2024 08:21:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304144844.2042-1-peter.tsao@mediatek.com> <20240401144424.1714-1-mike@fireburn.co.uk>
In-Reply-To: <20240401144424.1714-1-mike@fireburn.co.uk>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Mon, 1 Apr 2024 16:20:50 +0100
Message-ID: <CAHbf0-FqUqoDty81OH9_Et7MTWFikYYhEvP7SBVGyeXO-R94_A@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] Bluetooth: btusb: Add support Mediatek MT7920
To: peter.tsao@mediatek.com
Cc: aaron.hou@mediatek.com, chris.lu@mediatek.com, deren.Wu@mediatek.com, 
	johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, sean.wang@mediatek.com, 
	steve.lee@mediatek.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Apr 2024 at 15:44, Mike Lothian <mike@fireburn.co.uk> wrote:
>
> Hi
>
> I think this patch is causing issues with older firmware
>
> Bus 003 Device 002: ID 13d3:3563 IMC Networks Wireless_Device
>
> [    0.315064] Bluetooth: Core ver 2.22
> [    0.315064] NET: Registered PF_BLUETOOTH protocol family
> [    0.315064] Bluetooth: HCI device and connection manager initialized
> [    0.315064] Bluetooth: HCI socket layer initialized
> [    0.315064] Bluetooth: L2CAP socket layer initialized
> [    0.315064] Bluetooth: SCO socket layer initialized
> [    4.670811] Bluetooth: RFCOMM TTY layer initialized
> [    4.671029] Bluetooth: RFCOMM socket layer initialized
> [    4.671790] Bluetooth: RFCOMM ver 1.11
> [    4.673416] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [    4.673659] Bluetooth: BNEP filters: protocol multicast
> [    4.673895] Bluetooth: BNEP socket layer initialized
> [    4.674125] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> [    4.674360] Bluetooth: HIDP socket layer initialized
> [    5.016365] bluetooth hci0: Direct firmware load for mediatek/BT_RAM_CODE_MT7961_1a_2_hdr.bin failed with error -2
> [    5.017163] Bluetooth: hci0: Failed to load firmware file (-2)
> [    5.017557] Bluetooth: hci0: Failed to set up firmware (-2)
> [    5.018129] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
>
> The correct name should be mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin
>
> Reverting this patch fixes things
>
> Cheers
>
> Mike

If it helps, the device ID is 0x7961 and the fw_flavour is 24 or 0x18 in hex

