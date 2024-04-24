Return-Path: <linux-kernel+bounces-157105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC328B0CE2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4250D1C23FAE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B189715ECEA;
	Wed, 24 Apr 2024 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="XbEgg70A"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A54915ECD1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969736; cv=none; b=EAbrUR1aLWC3Aatdi2qN1JOGYOmrMMEo6uiuBKM85y7BO9zrbpd30YaMEunSkiG+2xz6gVyGbDBK264CcuP9eDAe4MoEARexwL7iYjEjZFCCzMrlu8h1iwBbIYFy7fkjs0TqdnDxpbnj49K63WznwALVHtvkCH+QIhfI9FmBFP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969736; c=relaxed/simple;
	bh=Iw7YtBtpZd4ROPQF63kSnNGoK/MtPehWRHgbmFqEJzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWq3CSnkyCnK4IAyUI6y7tyNaOJFQZlATrpjonz7cr4X/Bl3i8gyyJrXJ5vtzC4zNsll9xzqFzaeP2xNPkuwIFwd6YG5JzqL6c4hOeJemwzJ/cvbqgOowwSAHKOn/c1YmaQYDcIZKQBj2Iqw1/vbU2hmwwgf7OgoNijTTRUe6bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=XbEgg70A; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41b086d6676so5029685e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713969733; x=1714574533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=69Egah4QAsYC9pgbkxh/+p2ynsIbi+y+XwI5n1WVgUE=;
        b=XbEgg70ACOV95Do9jiMQZqacQNVR59BeZfHo+xD42cWdy56E6At+n2ulwr4r0qLS6F
         sKXvH6Gs89DucjI54juO88dT4dTBRGrz5/VvYewrQVuaT9ZhdX5nJpGbWb/eRGZRWpqZ
         iFdzLkfKSRocjgICde+gmiIgofxPeeLesHI0h22QRyLH7OTxUOK0uf7es/TjT52QSa5p
         tAK2HHn0mWMumswNmNslWkuy6N391vyvHmTY8Nn6m9LExdT1VEgyABIwJFBHgBjPthH6
         khry4wtw4u9kEgQpav2BEoIgiYde+E92bJyVoRdgSL4cG8tZpEYGjEXiJBB4pyuSquou
         ieuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713969733; x=1714574533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69Egah4QAsYC9pgbkxh/+p2ynsIbi+y+XwI5n1WVgUE=;
        b=pUS/ZbhWGH9NX90EuJ6hjSXuncSwoefeRgJr/ZfT36qQHrCp1wjSw/qztaZRTchFOS
         HN9InoZHT+KbGiFAYWRftLXkUs031Vf7i85kmpt8MjRAiqQpVtHR1bMuIAJTDrDmdgOT
         KChawrFxo3ahXyEL0ASzJXgL89G+Z1LHYTFc/EEShM/HZl6+FFrnJn2Zn8j0iyj+7b1t
         oF3WjFLWhKu84+9vg5Y+XKtPH7gwDk4m2W0WkptvXoJzNcZuxStPWFp7D13A8ApJfYrC
         31Nit+6o9ZSd7DKrq34AMrW5eLpw+aC4An1KYEZ5V5JH5e7JdmJA4GRjahwgYMWn6Mo+
         71hw==
X-Forwarded-Encrypted: i=1; AJvYcCXJu6ixaRK+I/oba2/DHk9Ln+q04fvjGa+nf+MxmN18TVwYgZuAD05YTPvHmD4wA8Zzdrxx8BfzaaFcuj09TC9OUrqacB6F4DWrdHxI
X-Gm-Message-State: AOJu0YxtCu9ZDauiyO4snpNfQbXx1Dl3fqHtVFGB3LbW3Aauuz5oDnla
	3XEZ5GH+nPcMapJuK7JNvP9pK2GTUGtKo/S9RRQcsRerKj+/C0PyPliFBP3mNdI=
X-Google-Smtp-Source: AGHT+IFMvdANjHtJoSchXh8wSWNVwu1errsdc/tkT9T6kXVzhZWSBpLnQtdfdwee6EGBolTxJVoF0w==
X-Received: by 2002:adf:f18d:0:b0:34a:d2a:58ff with SMTP id h13-20020adff18d000000b0034a0d2a58ffmr1816437wro.51.1713969733352;
        Wed, 24 Apr 2024 07:42:13 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c468600b0041563096e15sm28203040wmo.5.2024.04.24.07.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:42:12 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:42:09 +0200
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
Message-ID: <ZikaQQbAb2Manu72@nanopsycho>
References: <20240422095401.14245-1-gakula@marvell.com>
 <Ziexkkz8HCtIVRap@nanopsycho>
 <BL1PR18MB434216126F143177DE9A1D9ACD112@BL1PR18MB4342.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR18MB434216126F143177DE9A1D9ACD112@BL1PR18MB4342.namprd18.prod.outlook.com>

Tue, Apr 23, 2024 at 05:39:15PM CEST, gakula@marvell.com wrote:
>
>
>> -----Original Message-----
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: Tuesday, April 23, 2024 6:33 PM
>> To: Geethasowjanya Akula <gakula@marvell.com>
>> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org;
>> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
>> Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
>> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
>> Subject: [EXTERNAL] Re: [net-next PATCH v2 0/9] Introduce RVU representors
>> 
>> Prioritize security for external emails: Confirm sender and content safety
>> before clicking links or opening attachments
>> 
>> ----------------------------------------------------------------------
>> Mon, Apr 22, 2024 at 11:53:52AM CEST, gakula@marvell.com wrote:
>> >This series adds representor support for each rvu devices.
>> >When switchdev mode is enabled, representor netdev is registered for
>> >each rvu device. In implementation of representor model, one NIX HW LF
>> >with multiple SQ and RQ is reserved, where each RQ and SQ of the LF are
>> >mapped to a representor. A loopback channel is reserved to support
>> >packet path between representors and VFs.
>> >CN10K silicon supports 2 types of MACs, RPM and SDP. This patch set
>> >adds representor support for both RPM and SDP MAC interfaces.
>> >
>> >- Patch 1: Refactors and exports the shared service functions.
>> >- Patch 2: Implements basic representor driver.
>> >- Patch 3: Add devlink support to create representor netdevs that
>> >  can be used to manage VFs.
>> >- Patch 4: Implements basec netdev_ndo_ops.
>> >- Patch 5: Installs tcam rules to route packets between representor and
>> >	   VFs.
>> >- Patch 6: Enables fetching VF stats via representor interface.
>> >- Patch 7: Adds support to sync link state between representors and VFs.
>> >- Patch 8: Enables configuring VF MTU via representor netdevs.
>> >- Patch 9: Add representors for sdp MAC.
>> 
>> 
>> Could you please add some command outputs to the cover letter? Like $
>> devlink dev $ devlink port
>> 
>#devlink dev eswitch set pci/0002:1c:00.0 mode switchdev

?

>> outputs at least.
>> 
>> 
>> >
>> >-----------
>> >v1-v2:
>> > -Fixed build warnings.
>> > -Address review comments provided by "Kalesh Anakkur Purayil".
>> >
>> >Geetha sowjanya (9):
>> >  octeontx2-pf: Refactoring RVU driver
>> >  octeontx2-pf: RVU representor driver
>> >  octeontx2-pf: Create representor netdev
>> >  octeontx2-pf: Add basic net_device_ops
>> >  octeontx2-af: Add packet path between representor and VF
>> >  octeontx2-pf: Get VF stats via representor
>> >  octeontx2-pf: Add support to sync link state between representor and
>> >    VFs
>> >  octeontx2-pf: Configure VF mtu via representor
>> >  octeontx2-pf: Add representors for sdp MAC
>> >
>> > .../net/ethernet/marvell/octeontx2/Kconfig    |   8 +
>> > .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
>> > .../ethernet/marvell/octeontx2/af/common.h    |   2 +
>> > .../net/ethernet/marvell/octeontx2/af/mbox.h  |  73 +++
>> > .../net/ethernet/marvell/octeontx2/af/npc.h   |   1 +
>> > .../net/ethernet/marvell/octeontx2/af/rvu.h   |  30 +-
>> > .../marvell/octeontx2/af/rvu_debugfs.c        |  27 -
>> > .../marvell/octeontx2/af/rvu_devlink.c        |   6 +
>> > .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  75 ++-
>> > .../marvell/octeontx2/af/rvu_npc_fs.c         |   4 +
>> > .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 457 ++++++++++++++
>> > .../marvell/octeontx2/af/rvu_struct.h         |  26 +
>> > .../marvell/octeontx2/af/rvu_switch.c         |  20 +-
>> > .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +
>> > .../ethernet/marvell/octeontx2/nic/cn10k.c    |   4 +-
>> > .../ethernet/marvell/octeontx2/nic/cn10k.h    |   2 +-
>> > .../marvell/octeontx2/nic/otx2_common.c       |  53 +-
>> > .../marvell/octeontx2/nic/otx2_common.h       |  83 ++-
>> > .../marvell/octeontx2/nic/otx2_devlink.c      |  47 ++
>> > .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 305 ++++++---
>> > .../ethernet/marvell/octeontx2/nic/otx2_reg.h |   1 +
>> > .../marvell/octeontx2/nic/otx2_txrx.c         |  35 +-
>> > .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +-
>> > .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  18 +-
>> > .../net/ethernet/marvell/octeontx2/nic/rep.c  | 596 ++++++++++++++++++
>> > .../net/ethernet/marvell/octeontx2/nic/rep.h  |  51 ++
>> > 26 files changed, 1707 insertions(+), 225 deletions(-) create mode
>> > 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
>> > create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.c
>> > create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.h
>> >
>> >--
>> >2.25.1
>> >
>> >

