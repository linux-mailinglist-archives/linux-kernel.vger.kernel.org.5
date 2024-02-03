Return-Path: <linux-kernel+bounces-50800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EE1847E05
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 02:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECAAA1C21AC0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939BA17C2;
	Sat,  3 Feb 2024 01:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N502qxzC"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D7D10F9
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 01:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706922149; cv=none; b=qYxJoCaKugFmIsWUzzVlADEGJGnAY1KCy5I0hrax83aWzJiEyQltkMWtVStsSpBKsTAT/FlFzPG4BvcgKarZeQKbcbZn0bbSRDJPMtiIik/VFTDjvWHnwSf7mb8+ui23/LFaVSK17yFkGz7RbhnyUU8EwEiiserL5sQnfebI220=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706922149; c=relaxed/simple;
	bh=rfMLes6cWg00otP+ziiTc7vLUNnT0V+5z2wT+cVguLo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=hrNDmoEUxGnP2QaMM8XTcLmmiVrxwSRtGEmoax2bRIrl1dMP9dgMypKantpSOYHOOzrHfiS4oth950Ah3u0uFw5GbTBIDX4RBLIkPkRGC3how0sXPOgy+Whr3KiPaVs8WlAErIJIQ1jURHV6oGnhsa5x4+YR5gSfO4EKcaQn66U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N502qxzC; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68c840e0149so3322106d6.1;
        Fri, 02 Feb 2024 17:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706922147; x=1707526947; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RBhetPuLq4mpCpHehF9bxZ8BtNyp5du4RaHdsgtGdNg=;
        b=N502qxzC9INn2R+dAFWGuepz9IjXVq9WBJjjz7ermuUy87/xqH2qX4BlqNMkL4GoJD
         rpzobnz6GmJEEuUMNVLMl4Ij8/2m7E75wn9DNaypOZwGGFI4sfPyyTnp8Imv+gglL0Cd
         V9B51jxK3qbMTheZ5mPqmFqHTPdUtl0aTy2xebyexnI0G0cjsXshm7NUqRvpjuX5uLb2
         UoYMVq08Cw3DFPa/2nKEuZt7l/8ktoOV+wNvKbuksoyTIAuopBtwg1xEa2CRzG/l09GE
         3V3vKFQ6spZKQiJ8pZoC2xdXJESzGMq0gyinjhYvKC1MU6ibCQ4CrSiZpuMGC7Llra30
         n2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706922147; x=1707526947;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RBhetPuLq4mpCpHehF9bxZ8BtNyp5du4RaHdsgtGdNg=;
        b=BZHhMZ26t/Tz5hsidXBcxpxjnj9AWBUvGRPRiq6IoZmyXi+iYeyUgJs2Vc6wgMz62R
         nZkx329RU0WPZCOserwIwciykfRwRIgEat/hcj3/2gez1+dKVeCk8eH5dwb3L2D8T6uI
         JchfDbFPmNnvepX7Q+iSzGvjhYoIpgW+z226Dtcvoc255UJMU33Hu2JZvWjkziKF8BxY
         JEPn80y3dF7PWR8/fm8FXZXD9e/M5c2OONLUDsanJNj3XaV18TjNe06SKpk71omjvvxM
         slGx5pOk5PpqWuHEV2TZEOF5mg1d9wEYQ+2c2rx+d70yxoMwSL9TDPBkv/GQZNlxFZx7
         oewg==
X-Gm-Message-State: AOJu0Yz9wrxPqrCVX9JzVZuRKbERXG4D13EU5Xe/eBxeVWrG7lD6lGhd
	ltDcjAxZIYgd5GE39JmqCBqD2kKZfxllY6JVf+XO6JlBoJ1eJoCiazAzxMfhb40cj+WfDFANAka
	4CBRVE9cMX6Q5+RbELMhn5pHFG8JiddnLq9IJPS3epJ2WdA==
X-Google-Smtp-Source: AGHT+IHFYPNE5cR949vG4wtTn3rP0B5xk4ZK/X4Pf1TVWc8yzbYe6Y/07RRFDjLiMuO6ZOLErsUw00zwKuXL12Njh+M=
X-Received: by 2002:a0c:fe0b:0:b0:68c:67a3:da64 with SMTP id
 x11-20020a0cfe0b000000b0068c67a3da64mr7274944qvr.6.1706922146940; Fri, 02 Feb
 2024 17:02:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Sat, 3 Feb 2024 06:02:15 +0500
Message-ID: <CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>
Subject: =?UTF-8?Q?This_is_the_fourth_time_I=E2=80=99ve_tried_to_find_what_le?=
	=?UTF-8?Q?d_to_the_regression_of_outgoing_network_speed_and_each_time_?=
	=?UTF-8?Q?I_find_the_merge_commit_8c94ccc7cd691472461448f98e2372c75849?=
	=?UTF-8?Q?406c?=
To: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-netdev@vger.kernel.org, 
	Greg KH <gregkh@linuxfoundation.org>
Content-Type: multipart/mixed; boundary="0000000000003a972006106fc823"

--0000000000003a972006106fc823
Content-Type: text/plain; charset="UTF-8"

Hi,
I'm trying to find the first bad commit that led to a decreased
network outgoing speed.
And every time I come to a huge merge [Merge tag 'usb-6.8-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb]
I have already triple-checked all my answers and speed measurements.
I don't understand where I'm making a mistake.

Let's try to figure it out together.

Input data:
Two computers connected 1Gbps link.
Both have the same hardware.
Network: RTL8125 2.5GbE Controller (rev 05)

When I copy files from one computer to another and kernel snapshot
builded from commit 296455ade1fd I have 97-110MB/sec which is almost
max speed of 1Gbps link.
When I move to commit 9d1694dc91ce I have only 66-70MB/sec which is
significantly slower.

I bisected the issue by measuring network speed on each step.
I save all results to file [1]

[1] file is attached as a zip archive.

# first bad commit: [8c94ccc7cd691472461448f98e2372c75849406c] Merge
tag 'usb-6.8-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb

-- 
Best Regards,
Mike Gavrilov.

--0000000000003a972006106fc823
Content-Type: application/zip; name="speed-measure.zip"
Content-Disposition: attachment; filename="speed-measure.zip"
Content-Transfer-Encoding: base64
Content-ID: <f_ls5d0hci0>
X-Attachment-Id: f_ls5d0hci0

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
--0000000000003a972006106fc823--

