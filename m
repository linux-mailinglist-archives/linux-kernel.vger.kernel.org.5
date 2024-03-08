Return-Path: <linux-kernel+bounces-96549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA79875DEB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADA8E1F221B8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B59936125;
	Fri,  8 Mar 2024 06:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5IMmOcE"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39801D6A8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 06:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709878551; cv=none; b=Ck6uR/j2bm8wcY1sWwU49AVUg72SI77ElEesvJIOzxuJsH2CEBDMqPnwk6CiTen2P7O3UO6QQK2Dhx8TKL7HDMFq3e1EvVya8OdMnQKOLHq2VOdezR/5vduH4Dmm9voujvuzsOp7XnkOaKc4BpMUBW4OlA5AWEaQhj5QFaeulPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709878551; c=relaxed/simple;
	bh=A5lFeqrUZ44ZOatoEVpwqOvKVmz/zITH6JBAVi5yVjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNlI4W5Ms2i174EbFuWc2xtiEzPdby+SqkD0nqR2fl54Lbx4roiG7kBcColj1iEz493RB/MMUDLFeFN/veowqmnvbZ3780Mz6s47/OyitTaztWXcSVkmQ/uLJXqE/Yjfv+tkOmS6sof8Muo4AuWMyslIDNM7pOdK/+3h3/hshAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5IMmOcE; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56682b85220so519332a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 22:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709878548; x=1710483348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t2rRm5g3FkuVedRBQ27W4ssDD/4ZMTDR+BULXAB4Mb4=;
        b=b5IMmOcEHoyQRJCAzVRegx46YRuQxh+fsW6lbwnN6XYlzuJXWpcAYbB1lx+LDyWyJG
         y+yhskrFhk0CWGUjYX0JqmdMelz20kamNAGcmuLb5iDX09EnbyZNIwp09YAeiECL5BXl
         w3GGceVvRRqGIgedt1mH9NiHfT14TH+IvrJm4F7uo6psMvzzdtVoHDSv4Xst3WLa0pvP
         7VRukmEudaYOy8Ap80wfUTwXjRuub7MkAk/0khoArnkSDQQpkRg/lmM8WvXbWKsO+Nwh
         Y2Y/VXLMVFB5M2wCficZWnn8J/gq6pwy6b5hM5tVqjidjlHZ4BkvJn5eXtfkgBlnkRta
         DvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709878548; x=1710483348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2rRm5g3FkuVedRBQ27W4ssDD/4ZMTDR+BULXAB4Mb4=;
        b=ilUgxgE7lQbahKoWwBCQz/yOteXW1i6FM/AOK+v1B5X7GTx2zqcO47VXeV9UuYPfcl
         flF1/3hKHZGoNMltLvnqQW2W9iX+pipwWp5T8uljAQxZiU1qNB8kCCkFqJRRgaY1/401
         Ua9qBQRt6eqYmXtXQsb1IXiqpcazHkO9J/gHXscLjAhDOq2Bi74LxSTARmmsKL06QlcU
         7iYi0yuuRQ0GiV9Ox65o7Sx6tPzE7+OIm11tQFY0aORS2da9TXfVFQPhaOfXDtOgo86j
         ui8tlFImO7x74zmpYkYMJ1HJ4XUrzOoMxQBUrHTHOlA2svPuFJlbR/YY9G7/YDS0XEFO
         g6XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkVxb4gDW7FIGe+85wMbdVbyL1Q8oj2wX0lhW59Y4u11Fg2fyYk3uuPUTNtnf+EXeGI996b14Ex/kWOhgp55y6rBfBJ6n9sd6bGRxq
X-Gm-Message-State: AOJu0YxYVUji0auxry+q8RY0Xmu2YGMFcsprrPdCDdrUb/dGW8l5Uax2
	+oK05F4z6e6CRg6/8BpIu/9jSmBFf4+Dt/YzG/KL5Kljxz/jStPlOTteeaU=
X-Google-Smtp-Source: AGHT+IFiAYw7T8Wr4APGkRItNxwlDEPWImZmq0Z87jgCQzhgZZR1lEENF7fllAfQ7iyOCFkYxfoF6w==
X-Received: by 2002:a50:8ad7:0:b0:565:c814:d891 with SMTP id k23-20020a508ad7000000b00565c814d891mr1304246edk.0.1709878547715;
        Thu, 07 Mar 2024 22:15:47 -0800 (PST)
Received: from p183 ([46.53.254.187])
        by smtp.gmail.com with ESMTPSA id b13-20020aa7c90d000000b005681599a033sm1552814edt.13.2024.03.07.22.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 22:15:47 -0800 (PST)
Date: Fri, 8 Mar 2024 09:15:45 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: stfrench@microsoft.com,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: regression/bisected/6.8 commit
 5d390df3bdd13d178eb2e02e60e9a480f7103f7b prevents the system going into
 suspend mode
Message-ID: <c10916cd-670f-41c9-a3a7-7599b0a9a946@p183>
References: <CABXGCsNnE=tz6dfQO4fU58jAYNT2A=9g0CjtdMOQ05AVM6yDRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABXGCsNnE=tz6dfQO4fU58jAYNT2A=9g0CjtdMOQ05AVM6yDRA@mail.gmail.com>

On Fri, Mar 08, 2024 at 02:22:03AM +0500, Mikhail Gavrilov wrote:
> on one of my systems, commit 5d390df3bdd13d178eb2e02e60e9a480f7103f7b
> prevents the system going into suspend mode.

> Every time when I tried switch to suspend mode I saw this messages in the log:
> [  117.596548] xhci_hcd 0000:12:00.3: PM: pci_pm_suspend():
> hcd_pci_suspend+0x0/0x20 returns -16
> [  117.596569] xhci_hcd 0000:12:00.3: PM: dpm_run_callback():
> pci_pm_suspend+0x0/0x4e0 returns -16
> [  117.596583] xhci_hcd 0000:12:00.3: PM: failed to suspend async: error -16
> [  118.295894] PM: Some devices failed to suspend, or early wake event detected
> [  118.301032] xhci_hcd 0000:10:00.0: xHC error in resume, USBSTS 0x401, Reinit
> [  118.301129] usb usb1: root hub lost power or was reset
> [  118.301132] usb usb2: root hub lost power or was reset
> [  118.301868] [drm] PCIE GART of 512M enabled (table at 0x0000008000300000).
> [  118.302115] [drm] PSP is resuming...
> [  118.336045] [drm] reserve 0x1300000 from 0x85fc000000 for PSP TMR
> [  118.374741] xone-dongle 3-1.1:1.0: xone_mt76_resume_radio: resumed
> [  118.377527] nvme nvme0: 31/0/0 default/read/poll queues
> [  118.379470] nvme nvme1: 32/0/0 default/read/poll queues
> [  118.493231] amdgpu 0000:03:00.0: amdgpu: RAP: optional rap ta ucode
> is not available
> [  118.493237] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY:
> securedisplay ta ucode is not available
> [  118.493241] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
> [  118.493245] amdgpu 0000:03:00.0: amdgpu: smu driver if version =
> 0x0000003d, smu fw if version = 0x0000003f, smu fw program = 0, smu fw
> version = 0x004e7900 (78.121.0)
> [  118.493248] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
> [  118.609941] ata3: SATA link down (SStatus 0 SControl 300)
> [  118.610052] ata4: SATA link down (SStatus 0 SControl 300)
> [  118.610154] ata2: SATA link down (SStatus 0 SControl 300)
> [  118.610174] ata1: SATA link down (SStatus 0 SControl 300)
> [  118.690018] usb 1-12: reset high-speed USB device number 4 using xhci_hcd
> [  119.067818] usb 1-10: reset high-speed USB device number 3 using xhci_hcd
> [  119.442726] usb 1-6: reset full-speed USB device number 2 using xhci_hcd
> [  122.034768] amdgpu 0000:03:00.0: amdgpu: SMU: I'm not done with
> your previous command: SMN_C2PMSG_66:0x00000006
> SMN_C2PMSG_82:0x00000000
> [  122.034779] amdgpu 0000:03:00.0: amdgpu: Failed to enable requested
> dpm features!
> [  122.034780] amdgpu 0000:03:00.0: amdgpu: Failed to setup smc hw!
> [  122.034782] [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR*
> resume of IP block <smu> failed -62
> [  122.034975] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_resume
> failed (-62).
> [  122.034984] amdgpu 0000:03:00.0: PM: dpm_run_callback():
> pci_pm_resume+0x0/0x200 returns -62
> [  122.034990] amdgpu 0000:03:00.0: PM: failed to resume async: error -62
> [  122.042111] OOM killer enabled.
> [  122.042115] Restarting tasks ... done.
> 
> So I tried to find which commit borked it.
> And I successfully found it:
> 
> 5d390df3bdd13d178eb2e02e60e9a480f7103f7b is the first bad commit
> commit 5d390df3bdd13d178eb2e02e60e9a480f7103f7b
> Author: Alexey Dobriyan <adobriyan@gmail.com>
> Date:   Tue Jan 23 13:40:00 2024 +0300
> 
>     smb: client: delete "true", "false" defines
> 
>     Kernel has its own official true/false definitions.
> 
>     The defines aren't even used in this file.
> 
>     Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>     Signed-off-by: Steve French <stfrench@microsoft.com>
> 
>  fs/smb/client/smbencrypt.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> I am convinced that suspend mode started work after reverting commit
> 5d390df3bdd13d178eb2e02e60e9a480f7103f7b on top of 6.8-rc7.
> 
> Bisect log and all kernel logs from each step I attached here.
> Also attached build config.
> 
> Alexey, can you look into it?

What? Deleting unused defines breaks suspend?

Collect fs/smb/client/smbencrypt.o with and without patch and
see them being identical.

Enum in stddef.h are

	enum {
		false = 0,
		true = 1,
	};

so if defines were used somehow they would expand to same values of
same type.

Something else is going on.

