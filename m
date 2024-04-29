Return-Path: <linux-kernel+bounces-162148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DD78B56AC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D8C1F238B0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0515744C6A;
	Mon, 29 Apr 2024 11:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="0A7KMG/h"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C46F40843
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390276; cv=none; b=hzVJJNj7YH5NQLWIfuqUK20hKBYyacR6w4sQbfVaSHITJY9qBw4hXBl1+PXv81vAFvprLpjn5d8li5tkLi1iOfpEH8JwpyZh9l5ihM522Lv75ri2BdNB/uhfygeU9AJvbb4e/uHDzsaGQpSI+c0s0iSosphyd9PYYd62ZT/j32s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390276; c=relaxed/simple;
	bh=uy2vh8u9ZADC1OcAT3rXG1sLp60D39gwRrHD2sCrNwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnXiEHuI8wkEA6TlhD/QDG8PNrbXIvuKfq1mxrSDT1KaTui0Vde4vvWwBTwfiRXj+8nU/DWOpiJZ76SJZG9QePtkMS296a7zkswgeYOYL6Xzr3dIbLHdvlDLY9D+i++Qyjt+KvI5x3RFZ6yQsDssPzLEg/iKaW5d6ifKm7CVQlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=0A7KMG/h; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a5544fd07easo567866166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 04:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1714390272; x=1714995072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6qoJzYIBQX5QaPxjs+ERZ3/Z6q9IjN4L6qeLvUgaCNw=;
        b=0A7KMG/hCA5Gn78q4MvwTpgBmEQ4QzVLho+k5MMFshBfqf//G2AZmqt2pnXqCapYVe
         /igjpapu69EDrZLRY67HufHBNASeBSGhfugjN4kKGv48BLI9my17ae1ey86Ju33KeLDF
         ++ZTHHd6zW/vcVR5Q7zy3ZMLUteM7PfvCsb3rXS241dJ/OkY2+ZX08qvHKO7PzqmDVX/
         DQl0ylt4ApHZjgRdPcqoBlMdVgvLwoPV9QQO/wskhFoL+6uVfMB6AkKDX7CaeGLcuS0p
         cEi6q3jb0R4C1Cnkkc+cIUHaCfQkGLd1vkyr9548dXKR+W6xcQBUbJE1P/ZJiPEnIxXu
         qpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714390272; x=1714995072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qoJzYIBQX5QaPxjs+ERZ3/Z6q9IjN4L6qeLvUgaCNw=;
        b=dMXYcrFbkovK8gbgVVMa5EXSHcsilu/rNKhCbHy68p3xd7oYPQmt+g7w1nR/EeZuUC
         IY8umcoLBSmGsLP3aCnFO5WMYwUlB65msAJyQqqH6dPpvFd0jyQf9aUEDZ2VeG54BLgu
         1OLt1I+RybZp4tW4cmO1TLrx18TZhUUe2zgCiJQWdpIoNLk7psxJ2hecf2P5svj+kLtE
         HXMrBEPLJJG9lGuP531/VY9jI784k0jTMT+wnOuh1n9hZSotbAUIs9mzLR8TIPmsz1El
         A9jkStgFRqpxVVJ6FaZneMnWgRlfycM0R6JBy4KJdze57uHGNaGUM0w5d7BbA7ETJlcz
         7ufA==
X-Forwarded-Encrypted: i=1; AJvYcCVY5W1u63piFYShHlYJPA6tRN+Bzl+KRnD8eOEDezf/hcNzQ92Nu5aYDZSwALFHmiewv70rflcWfM500FIIj8idzRcBISxHRmVj0OD7
X-Gm-Message-State: AOJu0YyH3qHDLhgxESbHzIroiLwsUqEhZgQBYBvT+HUycs8fZ9wpY3bV
	GPtmG1TeThlxzJzO/BciTOSFbvNzsAPDImzF+Dqqw2pSgoZdIXuNrKSx7ETRDFY=
X-Google-Smtp-Source: AGHT+IGQl4GlF6MF4A3/But9/Az//eQPL+PctHLL42OPWU4BvAUSlYi2jRGr4RoRWv+e+t1Q1OgDaA==
X-Received: by 2002:a17:906:d930:b0:a58:c09a:692e with SMTP id rn16-20020a170906d93000b00a58c09a692emr6597867ejb.23.1714390272467;
        Mon, 29 Apr 2024 04:31:12 -0700 (PDT)
Received: from localhost (89-24-35-126.nat.epc.tmcz.cz. [89.24.35.126])
        by smtp.gmail.com with ESMTPSA id hx11-20020a170906846b00b00a46d2e9fd73sm13858743ejc.222.2024.04.29.04.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 04:31:12 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:31:10 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v3 0/9] Introduce RVU representors
Message-ID: <Zi-E_rfFx5LuV_Nq@nanopsycho>
References: <20240428105312.9731-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428105312.9731-1-gakula@marvell.com>

Sun, Apr 28, 2024 at 12:53:03PM CEST, gakula@marvell.com wrote:
>This series adds representor support for each rvu devices.
>When switchdev mode is enabled, representor netdev is registered
>for each rvu device. In implementation of representor model, 
>one NIX HW LF with multiple SQ and RQ is reserved, where each
>RQ and SQ of the LF are mapped to a representor. A loopback channel
>is reserved to support packet path between representors and VFs.
>CN10K silicon supports 2 types of MACs, RPM and SDP. This
>patch set adds representor support for both RPM and SDP MAC
>interfaces.
>
>- Patch 1: Refactors and exports the shared service functions.
>- patch 2: Implements basic representor driver.
>- patch 3: Add devlink support to create representor netdevs that
>  can be used to manage VFs.
>- patch 4: Implements basec netdev_ndo_ops.
>- Patch 5: Installs tcam rules to route packets between representor and
>	   VFs.
>- patch 6: Enables fetching VF stats via representor interface
>- Patch 7: Adds support to sync link state between representors and VFs .
>- patch 8: Enables configuring VF MTU via representor netdevs.
>- patch 9: Add representors for sdp MAC
>
>Command to create VF representor
>#devlink dev eswitch set pci/0002:1c:00.0 mode switchdev
>VF representors are created for each VF when switch mode is set switchdev on representor PCI device
># devlink dev eswitch set pci/0002:1c:00.0  mode switchdev 

I specifically asked for output of:
devlink dev
devlink port

Why you ignored my requests?


># ip link show
>25: r0p1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>    link/ether 32:0f:0f:f0:60:f1 brd ff:ff:ff:ff:ff:ff
>26: r1p1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>    link/ether 3e:5d:9a:4d:e7:7b brd ff:ff:ff:ff:ff:ff
>
>-----------
>v1-v2:
> -Fixed build warnings.
> -Address review comments provided by "Kalesh Anakkur Purayil".
>
>v2-v3:
> - Used extack for error messages.
> - As suggested reworked commit messages.
> - Fixed sparse warning. 
>
>Geetha sowjanya (9):
>  octeontx2-pf: Refactoring RVU driver
>  octeontx2-pf: RVU representor driver
>  octeontx2-pf: Create representor netdev
>  octeontx2-pf: Add basic net_device_ops
>  octeontx2-af: Add packet path between representor and VF
>  octeontx2-pf: Get VF stats via representor
>  octeontx2-pf: Add support to sync link state between representor and
>    VFs
>  octeontx2-pf: Configure VF mtu via representor
>  octeontx2-pf: Add representors for sdp MAC
>
> .../net/ethernet/marvell/octeontx2/Kconfig    |   8 +
> .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
> .../ethernet/marvell/octeontx2/af/common.h    |   2 +
> .../net/ethernet/marvell/octeontx2/af/mbox.h  |  73 +++
> .../net/ethernet/marvell/octeontx2/af/npc.h   |   1 +
> .../net/ethernet/marvell/octeontx2/af/rvu.h   |  30 +-
> .../marvell/octeontx2/af/rvu_debugfs.c        |  27 -
> .../marvell/octeontx2/af/rvu_devlink.c        |   6 +
> .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  75 ++-
> .../marvell/octeontx2/af/rvu_npc_fs.c         |   4 +
> .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 457 ++++++++++++++
> .../marvell/octeontx2/af/rvu_struct.h         |  26 +
> .../marvell/octeontx2/af/rvu_switch.c         |  20 +-
> .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +
> .../ethernet/marvell/octeontx2/nic/cn10k.c    |   4 +-
> .../ethernet/marvell/octeontx2/nic/cn10k.h    |   2 +-
> .../marvell/octeontx2/nic/otx2_common.c       |  53 +-
> .../marvell/octeontx2/nic/otx2_common.h       |  83 ++-
> .../marvell/octeontx2/nic/otx2_devlink.c      |  47 ++
> .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 305 ++++++---
> .../ethernet/marvell/octeontx2/nic/otx2_reg.h |   1 +
> .../marvell/octeontx2/nic/otx2_txrx.c         |  35 +-
> .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +-
> .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  18 +-
> .../net/ethernet/marvell/octeontx2/nic/rep.c  | 596 ++++++++++++++++++
> .../net/ethernet/marvell/octeontx2/nic/rep.h  |  51 ++
> 26 files changed, 1707 insertions(+), 225 deletions(-)
> create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.h
>
>-- 
>2.25.1
>
>

