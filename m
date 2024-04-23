Return-Path: <linux-kernel+bounces-155243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49D68AE747
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5CF1F20845
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F50134751;
	Tue, 23 Apr 2024 13:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="kxKeOQ1t"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E76712FF71
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877405; cv=none; b=dVzk1FF3r6pzYyvObuZYf/LCqhaft6xFXPMf8KDZ3+dRxc+NuIPE9gfv8EEPE8JpZ3cp4ZY/47OWBkyhtKcI1P6sF/oQjg//cgSpYsKR6UjxUdCytledmW4O6HQcf1s8Bw468tPFQfHlJj/KbLh7Y2AX18fivK3L2fTYZx+ghj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877405; c=relaxed/simple;
	bh=HzAJFBGJNzG+mmpiLhhdmnsEu2H7mtL2tnPdNu265DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaELBK+mLxageobFzYf7jvaJAJgUQlMmQzhHsAHaoOZeDFmHfXtFQiTXRe68QvP+d5g9FPS5rmGn+gm593xHSDMW2+7Dl6bY3skzwtla0928ug7uRrX0PIg5Ee0mnl9Vk2xX1D7tuyF71qturndenegEURHQJ2GQu6Bc6USKb68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=kxKeOQ1t; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57215beb016so1414888a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 06:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713877398; x=1714482198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yEMgQabm/0/E0TemyCdNw0BH8lVeUgs2Tq3e3AEWvmU=;
        b=kxKeOQ1tVvhTjUVS0N309epxgdj02/I1JeZrpmbPj1/j1EcZtFkPFBfYvJKPVZKY9V
         kIM4ZTh8S1IqE2RKuEdzrQSlZYhp7zBSZSiN8mguR4KIpTA6EDEzPXLhPJ7nrvPhGqPu
         K05Rg1TKs6kjbCw7hfrIJlcOeDtNnpxcTzJqaV2dQbsAVW8DezkWRwRjDYh7T7MwB3WX
         TG+Zp0mMV2T1aStUV55P2TDcBv8dllaVVlLWIXezKJAh9cZjlRvc8SxZ6mqO6jM24xoq
         S1msFwXrAfVV2CqT9T5qfeGuoq68OLkS7yYZ1cWclFAEIlsUaSyY49FP9m8XfqwxuSyS
         7hTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713877398; x=1714482198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEMgQabm/0/E0TemyCdNw0BH8lVeUgs2Tq3e3AEWvmU=;
        b=FcwzA0OSiIEDsnCd5Xev+XQjFGBRPxmQEMZsp9FA37e47pg7ghtbv7/YftxyLHIYHN
         kfi7JC2nQz5Vz5CXTuA+RQOyd9vQkdtF/GfB78NB601T7R8tvvgTglh6ZJkDx6gUmzMa
         DF2HoAduPK+CBLvhT1wdmAaqUOv0FWCA4r6utLntpCJl2/l3T5cP58M+Fm5NffArUdZj
         bnKNuimcH+szmH33PB0ZyBWt/E5/bg6iMc6wXRmUn3mVOm9i57gIQUccd0fqcwhnkSnv
         ksTuX7kfE4juiLQXizFTqhWPdY2HVsb7+xMFIIuX+DXTcyakISCq0+UAqhQgg+K2X4OH
         0zKw==
X-Forwarded-Encrypted: i=1; AJvYcCXFUtbrqyKlbJePnz5qhkuKwtaNBqqFbv+K1Uzkvyv0CTufeYUQnmdovcyktEZFl23TXlEg1vmHV+YfXO1Qn5HIEZHBNMTHMy5PlO1W
X-Gm-Message-State: AOJu0YxDg9+FqFGYQmXkfzEXbl2pwL4RKzAjQucTZWIcG2alNEZGXuA2
	WdBXUo62PeeL8uC7LkPF7z9uMH+ivREAtDvKP02G+WG6hb5GAS4KsWwEmntJ/Cg=
X-Google-Smtp-Source: AGHT+IGOf9jTtjwTkllvBAcfwY4LnRurmtji2qf6CII78i3MTciBR8bvSzu25+7rRP8jP1GNkn3hmA==
X-Received: by 2002:a50:cd8c:0:b0:570:5b38:1bf2 with SMTP id p12-20020a50cd8c000000b005705b381bf2mr8304894edi.30.1713877398199;
        Tue, 23 Apr 2024 06:03:18 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id em8-20020a056402364800b0057021b811eesm6669990edb.67.2024.04.23.06.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 06:03:15 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:03:14 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v2 0/9] Introduce RVU representors
Message-ID: <Ziexkkz8HCtIVRap@nanopsycho>
References: <20240422095401.14245-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422095401.14245-1-gakula@marvell.com>

Mon, Apr 22, 2024 at 11:53:52AM CEST, gakula@marvell.com wrote:
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
>- Patch 2: Implements basic representor driver.
>- Patch 3: Add devlink support to create representor netdevs that
>  can be used to manage VFs.
>- Patch 4: Implements basec netdev_ndo_ops.
>- Patch 5: Installs tcam rules to route packets between representor and
>	   VFs.
>- Patch 6: Enables fetching VF stats via representor interface.
>- Patch 7: Adds support to sync link state between representors and VFs.
>- Patch 8: Enables configuring VF MTU via representor netdevs.
>- Patch 9: Add representors for sdp MAC.


Could you please add some command outputs to the cover letter? Like
$ devlink dev
$ devlink port

outputs at least.


>
>-----------
>v1-v2:
> -Fixed build warnings.
> -Address review comments provided by "Kalesh Anakkur Purayil".
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

