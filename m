Return-Path: <linux-kernel+bounces-109447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823AB88194F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C2F1C21298
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D7085C41;
	Wed, 20 Mar 2024 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficientek-com.20230601.gappssmtp.com header.i=@efficientek-com.20230601.gappssmtp.com header.b="HKyvxAZx"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7834F8B2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710971781; cv=none; b=TRWHmtjfuw66dgk4I5CogaD7Zo0lKCptIGrTKKSKw172h2qJ7nAZS+XPA1tj8i7kSGTjl1IqCWlVLwZjfOlTc9sq1UQprpS+YHDC5YBUdamKmhATz1IlAg4fDGQYfSyU2Tsr1Nmcag3Dwv6nZEe9CzkJLcx0QqbA9jGJ5K7cPLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710971781; c=relaxed/simple;
	bh=3Y9zpf1wfvY5KLBzI213sJGWxjZ+o1dGQveIv1ywB5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=akgWo1kZ91BEIPLvLFOZC/PLK8LIhUhs65NvM6bDvY3SN7sJcmGoGeMQHA0+rzoiHl78pMAhDPc/YwrlGMDAmU4CsiUELR7WpRrL/lNYAR26oDm2fzjqWRAkTBWD1GivoaFtKx/qr/I0onmS4hMyzJuQUP4U21oe78CUvNEcpgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=efficientek.com; spf=pass smtp.mailfrom=efficientek.com; dkim=pass (2048-bit key) header.d=efficientek-com.20230601.gappssmtp.com header.i=@efficientek-com.20230601.gappssmtp.com header.b=HKyvxAZx; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=efficientek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficientek.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a21859a4b8so136477eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 14:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20230601.gappssmtp.com; s=20230601; t=1710971779; x=1711576579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NwLRl82njW9qOCI08DiI0Mi6Z9GVC805nkZi5Fy+J9U=;
        b=HKyvxAZxTSMEeUfFujy9WMqCQfTdS/hXv6tZfmJlVLwreIfFN38Nx5vfGkDYSQBdJB
         NBNHVQBnz8aPgPl1ZDy0xFiZZhqr+btDSva6F8RC3XmVyzhnPkS0XtdMxCLiS3OdhSUm
         RaSY0LiuZyB1mQBKCiiZqRSlH2HBzHcjprFDWPXbcCB1k+Zz5mzoHDTIH2TYo+g4znyL
         3zqXWHTVcBbTLYaTSmlS+GRVbcAb1R3rtD2wL2BAzTwxF4EuFXKGSYQzLJdv5HG4tE2a
         GzrABiUSGfEEUNXh7BKpGGUEbySQEJDnBm7aGjqvwHnbkLJP/hQxXnyB+ywddSzOSV4I
         eLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710971779; x=1711576579;
        h=content-transfer-encoding:mime-version:reply-to:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwLRl82njW9qOCI08DiI0Mi6Z9GVC805nkZi5Fy+J9U=;
        b=QC8qiWmUyjV/wEdzCEhQGdch16JlR7FaQhY+IguoW85RW1wnju9rKPg0T/1lL/DpF4
         OP5p+P42Jb8wTxLRfeD0Sv0vQEdPZFu+eutdcPyrdUzdfS9IMwoBLEsoNKH6U5pwZxxA
         hFUuK3Pi3fCKtjWH1cckMdTeQqGnTD9dqYbgo7lvN2wcKxfL9jKe3S6i78w5mkF85qCs
         Sg4s6CcL+PLuiJoudU9ZpCU2wOxZ2znd0f4lS/6Y0H+wF2V68Sefd7iPU/vUvRbdwmnY
         BvPtKSvWlUJ6BI9PKrE/FfUqhqT4YFbUqJZMztc++mEHmvOcI+pVYv7CYX4pRPbDIkCs
         19sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBm4KS3S4A80J8+11p9nqReDEG/9oWnzhxiMLRjbfv2U668Qv7IawIx/pE8kXYI8Vq3mGR03P4x0n1Ge4igvDP9wSzbhxDAZRYqBDB
X-Gm-Message-State: AOJu0Yw9vqO6xRn8c/ETxayXKs2VKCy/BT8MbIfYcUyvdGq/S4KuIj5U
	ScASrqgGdLkM5QoVKa0Uo75ketm696NXEIzZbteEgWLhWvIEPPbaaPyOVaXy1A==
X-Google-Smtp-Source: AGHT+IERVnHDyCRKMbKQ1CvMqRQ1iTEgmI48bTHDG/oAkD5At/lDqY2l5505tlZOZPPXI9jhbAQZAQ==
X-Received: by 2002:a05:6870:6195:b0:220:99bf:c26d with SMTP id a21-20020a056870619500b0022099bfc26dmr397339oah.9.1710971779086;
        Wed, 20 Mar 2024 14:56:19 -0700 (PDT)
Received: from crass-HP-ZBook-15-G2 ([204.13.164.84])
        by smtp.gmail.com with ESMTPSA id lb3-20020a056a004f0300b006e664031f10sm12270964pfb.51.2024.03.20.14.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 14:56:18 -0700 (PDT)
Date: Wed, 20 Mar 2024 16:56:09 -0500
From: Glenn Washburn <development@efficientek.com>
To: Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>, Mike
 Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Cannot create dm-linear or dm-crypt mapping on scsi or mmc block
 device if mapping already exists on partition of device
Message-ID: <20240320165339.1c6b4d39@crass-HP-ZBook-15-G2>
Reply-To: development@efficientek.com
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Saludos,

I've hit some unexpected behavior that is not intuitive and might be
considered a bug. A dm-linear or dm-crypt (possibly others) mapping is
attempted to be created on a scsi or mmc block device (again, possibly
others) when there already exists a mapping on a sub block device, the
mapping creation will fail with EBUSY.  Here's a concrete example:

# dmsetup create --concise "dm-test,,,ro,0 8 linear /dev/sda1 0"
# dmsetup create --concise "dm-test2,,,ro,0 4 linear /dev/sda1 2"
# dmsetup create --concise "dm-test3,,,ro,0 4 linear /dev/sda 2"
[  968.046906] device-mapper: table: 252:2: linear: Device lookup failed (-EBUSY)
[  968.047305] device-mapper: ioctl: error adding target to table
device-mapper: reload ioctl on dm-test3 (252:2) failed: Device or resource busy
Command failed.
# dmsetup create --concise "dm-test4,,,ro,0 4 linear ${DEV}2 8"
# dmsetup table --show
dm-test: 0 8 linear 8:1 0
dm-test2: 0 4 linear 8:1 2
dm-test4: 0 4 linear 8:2 8

The second command shows that dm-linear has no issues with creating an
overlapping mapping on the same device. It makes little sense that the
third command fails where the second and fourth succeed. Further testing
shows that if there is an existing linear mapping on the full block device,
then mappings fail to be created on any partition block devices. This has
been tested on scsi and mmc devices. It is also true for the dm-crypt
target and mixing dm-linear and dm-crypt mappings. I've tested on Ubuntu's
6.8.1 test kernel. I doubt this is affected by any Ubuntu patching, but
perhaps someone could confirm this on a vanilla kernel.

I noticed this because I tried to create a dm-linear mapping of a scsi
device to capture sectors not contained in a partition, but it failed
because I already had a dm-crypt mapping on a partition of the device.

Any ideas what's going on? Are there good reasons for this behavior that
I'm unaware of? I've done some searching but haven't found it having been
reported anywhere. If this has been discussed, please point me in that
direction.

Glenn

