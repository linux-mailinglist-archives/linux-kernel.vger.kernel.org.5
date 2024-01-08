Return-Path: <linux-kernel+bounces-19681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD2E8270C6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F16B5B21BF7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD0945C15;
	Mon,  8 Jan 2024 14:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HImv1Tmx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFF145BE2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 14:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5e82f502a4cso10973837b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 06:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704723112; x=1705327912; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p4hyrXKTxJBPfjea5PgeQm4XAwKpbPc6GyeUlQcLIXE=;
        b=HImv1TmxmxVEwNs1RPYuuCIHthWc53vyXIpxOkIkXid3eXW8azAqrxXyn8HfOh0WWk
         bcKk0zDhaa7Qs8chZnQTliPB/GJIx6xnMd6gXhIEkEFCU3UQLnMLUBS8RqM2Kpo2G6md
         ASpB2rykEVoGjFwxL5rH7fbaAhRBcKvyrdGJoFrP9/2i4gr7F/+PRmXcSV5x1Td0R7Ee
         yUSt9d3cDhV9g9BG3Jn8CL8+kNq8YmOLOxVBKUq8yUtAG5gJc8ae8/UkHQn46PNfntop
         oPVgRfi/5jI/mF3tYoZGVyyeH4k1XrbYJxGICURkFCteNk5Tp4HTq0Pw8JQbE47FryHZ
         Q/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704723112; x=1705327912;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p4hyrXKTxJBPfjea5PgeQm4XAwKpbPc6GyeUlQcLIXE=;
        b=BcReSi26N0OS7/fHAC+4Frk+o3gN9xawQ4az2bowOHF0CpZvBHVdNlLLtAWEROfC//
         WMDjd5c3CxdcF39l+7C15DAjjP9Pf+wXCR+Kllzbf3/4sdBUIp7rYsCe4pKfrsEgy3cB
         I0fR3cpGzeLMBDw1XqBc9VhcF2dns74GDi/BXCJCJQrWRZZGVVn/hq0ghi1zKu719v8i
         EedC5/z6+JVaUJMP4riPA3myqIy2cUFJFVE2iYA8yXWE8eMONrwM0aMM/BFIZ1yeyK8+
         og1WmMm6ykGB8A2Fsckf7bbJyrIWuQsjDcjPsXxhSMh7zfWf/hn3ymUQ7Cvzb1/i4GKK
         FJug==
X-Gm-Message-State: AOJu0YxaOXm/s0foSu4+rsafNQ39+gs/+2DXKz0+neew/wE2QJ8Ci+83
	4EI0r/m+O3j9/6bJ9Sa2mHFhuMWJDWzIa5HL1bX4Y0P65Ag=
X-Google-Smtp-Source: AGHT+IHG/rdYy7UBSSIgwA3mBsm7jJd0mlMIM2cO4+ES1vwIUn/CE4VGhim7kdhpxCQkgwzyx8koJCVMrw9dW5QeB9o=
X-Received: by 2002:a81:9206:0:b0:5e7:d248:6b8f with SMTP id
 j6-20020a819206000000b005e7d2486b8fmr1088074ywg.33.1704723110315; Mon, 08 Jan
 2024 06:11:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alex Romosan <aromosan@gmail.com>
Date: Mon, 8 Jan 2024 15:11:39 +0100
Message-ID: <CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com>
Subject: [btrfs] commit bc27d6f0aa0e4de184b617aceeaf25818cc646de breaks update-grub
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Please Cc me as I am not subscribed to the list.

Running my own compiled kernel without initramfs on a lenovo thinkpad
x1 carbon gen 7.

Since version 6.7-rc1 i haven't been able to to a grub-update, instead
i get this error:

grub-probe: error: cannot find a device for / (is /dev mounted?) solid
state drive

6.6 was the last version that worked.

Today I did a git-bisect between these two versions which identified
commit bc27d6f0aa0e4de184b617aceeaf25818cc646de btrfs: scan but don't
register device on single device filesystem as the culprit. reverting
this commit from 6.7 final allowed me to run update-grub again.

not sure if this is the intended behavior or if i'm missing some other
kernel options. any help/fixes would be appreciated.

thank you.

--alex--

