Return-Path: <linux-kernel+bounces-158092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 056378B1B5C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D951F23F97
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02246AFB6;
	Thu, 25 Apr 2024 07:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZK9lZ9qy"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5778C5CDD0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714028445; cv=none; b=Lxkq1rM34tzuoyLJfedAbGtb6RP56/sT7F3xNDSr9gHMmjzfaYOICLw1yqhfJPgcLJ5qtJMJps/eGBIzxQK7zijbfPb1z0/wAwkwaR4RdEdPXjhaKlUmdPIMl4UgLGOqm/+TXkx72ZnA4jiwNAgq4uDGW9YdPZPyoSF+he32drY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714028445; c=relaxed/simple;
	bh=5gD4270b8K6bujrjPx4bLZQctiTr2ZfBPTKafi5t+m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpBsWOdAn8vuR6ECwrwXOfp+7omgHkoS0INGDnNi0Mt3USCyvY7iB0oe7Qf7zsI+siFw4Srf+Ck2WZzCTTgKj6WKi4QvFal82LHiTU5Uri+PrYxAfvVYHHFp4vJMKABUIgz4b2UdeiQk8aHfQdTn/4yjaRX2XWhEJXixPz6C/vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ZK9lZ9qy; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a5544fd07easo81097066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 00:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1714028440; x=1714633240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BcX5U+8n/ANNJt6fW16Sve1uLIZ1XhN9l3ZH/EGG0xc=;
        b=ZK9lZ9qy/evNHKDlXKfIcBpn3wZm6UE1zpgGoXPWxqn7qKvUixkSjdt+TfPKNEscuY
         gWL6qKLhjl5tAl2tyk1X0L1b4CN05+6DhaNynR3FIOk5cLYx9eOyejVNuYSS+DKIbZPo
         NbFOq3b/fl/FbRP1AWgxWZiGlpBkqn0IoQeaF6kM7LoefUEYQ33C+nH7bEO27bmVP8km
         hRMOVXS83AhNU/Gs7J6FLIcPI7yhFK3mBf+sScGgzO2vJsuN3B+etdtK/4ecorSrYr7P
         cdwxuVEvHbqX39j53AKJijFQt2jui0lBbwm+gw+KTeLKYFMGmXl/wPDrvjmpAfw6QQPY
         qhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714028440; x=1714633240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcX5U+8n/ANNJt6fW16Sve1uLIZ1XhN9l3ZH/EGG0xc=;
        b=BoNMcNzl3pOBtqcRBbKM1H9EIy5pmuvf2SudPnQ6yEcqlMY7KeoFI1tvhNINK93Ys9
         Ep/Hwc/yrGThHKJn7W/6klzD3BIf0TPH/zTv8JssmPouliKSkLOLKN+NUTYUN5BWSY4N
         k54dC3W7ymQ8Uv5CbTJd6Lq3OsKg3bDEbdYO++ErhS+Ih9CDP2FYJxCwpRuShmW0hcQV
         4Ts9RfjexewlKjfBIySby5w8nvNsy+19UWhzVOjWf6kDADg0VXKPjFaqBUHUGUDzVe5h
         rX8YRCYVTus4kVjkCMLKSfEBlYVepUuQH3JpcQxr+mHQKnoK5BsFV//6ceRMCC/Yx4ft
         FwLA==
X-Forwarded-Encrypted: i=1; AJvYcCWDHDwl9tYg6PkfmyflMMC0n7CwWqyTo7nYyW50N6v8qpvtGcJ7tBWpAAl5pQju040BsqR8PRsJvPyw+LzL2oKykgFsHvQrt91Mpxiv
X-Gm-Message-State: AOJu0YwgQfXzOQtOcr8xOOz0qkrxnKuH9AwmRxIHNtCIvytg8BSi31py
	8BP06FTs0j/Ut3fOJa7dKe1m1zKSy4SFtlWkBOCBAF6EkVCJh0CmWVZ26lHEbp0=
X-Google-Smtp-Source: AGHT+IH7XBrrHA7tkNl1BzhyNcrgopp0eeXlsfxHmqSzga8TfWcFIDXSluCL+yE0uHqZSLgkyVA9NQ==
X-Received: by 2002:a17:906:2650:b0:a55:b05b:cdf2 with SMTP id i16-20020a170906265000b00a55b05bcdf2mr2765517ejc.21.1714028439495;
        Thu, 25 Apr 2024 00:00:39 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id s8-20020a170906500800b00a4e24d259edsm9148480ejj.167.2024.04.25.00.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 00:00:38 -0700 (PDT)
Date: Thu, 25 Apr 2024 09:00:34 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geethasowjanya Akula <gakula@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: [EXTERNAL] Re: [net-next PATCH v2 0/9] Introduce RVU representors
Message-ID: <Zin_kmyhwImG56Hu@nanopsycho>
References: <20240422095401.14245-1-gakula@marvell.com>
 <Ziexkkz8HCtIVRap@nanopsycho>
 <BL1PR18MB434216126F143177DE9A1D9ACD112@BL1PR18MB4342.namprd18.prod.outlook.com>
 <ZikaQQbAb2Manu72@nanopsycho>
 <CH0PR18MB4339CF300EB8D1C50EB60E78CD172@CH0PR18MB4339.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR18MB4339CF300EB8D1C50EB60E78CD172@CH0PR18MB4339.namprd18.prod.outlook.com>

Thu, Apr 25, 2024 at 07:09:01AM CEST, gakula@marvell.com wrote:
>
>
>> -----Original Message-----
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: Wednesday, April 24, 2024 8:12 PM
>> To: Geethasowjanya Akula <gakula@marvell.com>
>> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org;
>> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
>> Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
>> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
>> Subject: Re: [EXTERNAL] Re: [net-next PATCH v2 0/9] Introduce RVU
>> representors
>> 
>> Tue, Apr 23, 2024 at 05:39:15PM CEST, gakula@marvell.com wrote:
>> >
>> >
>> >> -----Original Message-----
>> >> From: Jiri Pirko <jiri@resnulli.us>
>> >> Sent: Tuesday, April 23, 2024 6:33 PM
>> >> To: Geethasowjanya Akula <gakula@marvell.com>
>> >> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
>> >> kuba@kernel.org; davem@davemloft.net; pabeni@redhat.com;
>> >> edumazet@google.com; Sunil Kovvuri Goutham
>> <sgoutham@marvell.com>;
>> >> Subbaraya Sundeep Bhatta <sbhatta@marvell.com>; Hariprasad Kelam
>> >> <hkelam@marvell.com>
>> >> Subject: [EXTERNAL] Re: [net-next PATCH v2 0/9] Introduce RVU
>> >> representors
>> >> ---------------------------------------------------------------------
>> >> - Mon, Apr 22, 2024 at 11:53:52AM CEST, gakula@marvell.com wrote:
>> >> >This series adds representor support for each rvu devices.
>> >> >When switchdev mode is enabled, representor netdev is registered for
>> >> >each rvu device. In implementation of representor model, one NIX HW
>> >> >LF with multiple SQ and RQ is reserved, where each RQ and SQ of the
>> >> >LF are mapped to a representor. A loopback channel is reserved to
>> >> >support packet path between representors and VFs.
>> >> >CN10K silicon supports 2 types of MACs, RPM and SDP. This patch set
>> >> >adds representor support for both RPM and SDP MAC interfaces.
>> >> >
>> >> >- Patch 1: Refactors and exports the shared service functions.
>> >> >- Patch 2: Implements basic representor driver.
>> >> >- Patch 3: Add devlink support to create representor netdevs that
>> >> >  can be used to manage VFs.
>> >> >- Patch 4: Implements basec netdev_ndo_ops.
>> >> >- Patch 5: Installs tcam rules to route packets between representor and
>> >> >	   VFs.
>> >> >- Patch 6: Enables fetching VF stats via representor interface.
>> >> >- Patch 7: Adds support to sync link state between representors and VFs.
>> >> >- Patch 8: Enables configuring VF MTU via representor netdevs.
>> >> >- Patch 9: Add representors for sdp MAC.
>> >>
>> >>
>> >> Could you please add some command outputs to the cover letter? Like $
>> >> devlink dev $ devlink port
>> >>
>> >#devlink dev eswitch set pci/0002:1c:00.0 mode switchdev
>VF representors are created for each VF when switch mode is set switchdev on representor PCI device
># devlink dev eswitch set pci/0002:1c:00.0  mode switchdev 
># ip link show
>25: r0p1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>    link/ether 32:0f:0f:f0:60:f1 brd ff:ff:ff:ff:ff:ff
>26: r1p1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>    link/ether 3e:5d:9a:4d:e7:7b brd ff:ff:ff:ff:ff:ff
>
>Sorry if I was not clear before. Hope these answers you question.


Again, please add outputs of:
devlink dev
devlink port

I'm not sure why this was not clear the first time I wrote it.

>
>> 
>> ?
>> 
>> >> outputs at least.
>> >>
>> >>
>> >> >
>> >> >-----------
>> >> >v1-v2:
>> >> > -Fixed build warnings.
>> >> > -Address review comments provided by "Kalesh Anakkur Purayil".
>> >> >
>> >> >Geetha sowjanya (9):
>> >> >  octeontx2-pf: Refactoring RVU driver
>> >> >  octeontx2-pf: RVU representor driver
>> >> >  octeontx2-pf: Create representor netdev
>> >> >  octeontx2-pf: Add basic net_device_ops
>> >> >  octeontx2-af: Add packet path between representor and VF
>> >> >  octeontx2-pf: Get VF stats via representor
>> >> >  octeontx2-pf: Add support to sync link state between representor and
>> >> >    VFs
>> >> >  octeontx2-pf: Configure VF mtu via representor
>> >> >  octeontx2-pf: Add representors for sdp MAC
>> >> >
>> >> > .../net/ethernet/marvell/octeontx2/Kconfig    |   8 +
>> >> > .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
>> >> > .../ethernet/marvell/octeontx2/af/common.h    |   2 +
>> >> > .../net/ethernet/marvell/octeontx2/af/mbox.h  |  73 +++
>> >> > .../net/ethernet/marvell/octeontx2/af/npc.h   |   1 +
>> >> > .../net/ethernet/marvell/octeontx2/af/rvu.h   |  30 +-
>> >> > .../marvell/octeontx2/af/rvu_debugfs.c        |  27 -
>> >> > .../marvell/octeontx2/af/rvu_devlink.c        |   6 +
>> >> > .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  75 ++-
>> >> > .../marvell/octeontx2/af/rvu_npc_fs.c         |   4 +
>> >> > .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 457 ++++++++++++++
>> >> > .../marvell/octeontx2/af/rvu_struct.h         |  26 +
>> >> > .../marvell/octeontx2/af/rvu_switch.c         |  20 +-
>> >> > .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +
>> >> > .../ethernet/marvell/octeontx2/nic/cn10k.c    |   4 +-
>> >> > .../ethernet/marvell/octeontx2/nic/cn10k.h    |   2 +-
>> >> > .../marvell/octeontx2/nic/otx2_common.c       |  53 +-
>> >> > .../marvell/octeontx2/nic/otx2_common.h       |  83 ++-
>> >> > .../marvell/octeontx2/nic/otx2_devlink.c      |  47 ++
>> >> > .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 305 ++++++---
>> >> > .../ethernet/marvell/octeontx2/nic/otx2_reg.h |   1 +
>> >> > .../marvell/octeontx2/nic/otx2_txrx.c         |  35 +-
>> >> > .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +-
>> >> > .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  18 +-
>> >> > .../net/ethernet/marvell/octeontx2/nic/rep.c  | 596
>> >> > ++++++++++++++++++ .../net/ethernet/marvell/octeontx2/nic/rep.h  |
>> >> > 51 ++
>> >> > 26 files changed, 1707 insertions(+), 225 deletions(-) create mode
>> >> > 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
>> >> > create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.c
>> >> > create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.h
>> >> >
>> >> >--
>> >> >2.25.1
>> >> >
>> >> >

