Return-Path: <linux-kernel+bounces-84786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E837086AB88
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6005B1F21385
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D9136125;
	Wed, 28 Feb 2024 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="peW0vXEm"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE5A2D052
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113424; cv=none; b=fuhdCSsWRM8cgOlJpl6x0NVGX0E9G1eUGWCnU9TpeD7PL842b9gPSFdefEyr4GL5uEWd+oSe9FxUykw/LFMWWxpxfaxYqVavBZHpz1n252kLPopEher5ZUiPut9+Gw0lK85ETldLNSU2z9NNvdvaD4/+36RbimY615XtqASQ+eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113424; c=relaxed/simple;
	bh=Ult8vei6p6VMkXn/9tdyilwesfzp6VrkTIDAJq5kUtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9s1hsPYvzHjo6tjfxsJSJ6OTBTtL3V/Esg86k6VOPSjIQO69Y2iKljY2GD94Vi+wvo6KsD5/+2AyspFUHYNjWdJ6xri9d+LaKMEb3mq7TxaO4BC8HoVgI/KE7qN53wwUWi2ktLoImkQ9StwWniVdzX0taAJa5Zpz2eqpjo4xpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=peW0vXEm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412af574501so9799765e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709113421; x=1709718221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kRPlWagDvPDMQ7ZK9LzRF2TmTIwImnAEbz7S+2nAljo=;
        b=peW0vXEmBsf7z1/hspbBP+IagT/DOAQo9bClkdS48eeiR54yGh8NX8YZCxYW10KaLg
         Ivlu5rlgfehXtOAPQX2Prj2eQEA8MuL+eeD10tT4b7xio/D+yoNrj2JNVqOySzueMeUo
         0iPZVKTm8lQA6Li4NZIMbYckuR1FPVP/HpsRJqU8sCdGKPBLJ1Ob+ncQSUZbLoXYht1h
         W4MqTBy/+Mw6JAKjgzdVxTqCFvcVXdZq04/A9wxgrR0TPi9O+j2nno4EL7aZMkX8Qlaz
         0vy8Tf8QScHTH3kJsXgnLz6S2aUTbrPaJaEEuvRJ1SHId+vuslTDjeX6VrdMGXKHy275
         sH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709113421; x=1709718221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRPlWagDvPDMQ7ZK9LzRF2TmTIwImnAEbz7S+2nAljo=;
        b=eetWhjqJVB3M9Gwi676FZJ2UIt7/klubM9Z4AgU0As4HJxsWaMZMBAkMz+CyroWGoo
         1/PFi1XdxA8VLusEMrIO/EIlFwCpnAmIz18688eZHD/ZZr1HjiqZW1/RkhRjNHWBKKLX
         5gXOQ+YHBxt5wLeh1rThGCuPNm9dO1k9jGktdIcsBFyn3cQU+ETCpNkxuWthvXXl3HEM
         v9XYFz4uAs4zb/eFb3mRMYMcFsT4eFU7zwD2i9LHRSt59s2Su6aPJaGnRK95Ny/6DLuh
         5K1hUKxM7xcmBNkluI7sHwMNfbtBjPEX9WfHWnhB5Kp/wrXtzvdLqjNQrmXueoZHk+E1
         g38Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNs7kOne1AWeJHdvo3nnVkDsge2VRyhH8EeyOH0RQ05qM54djkKl5EFb7O1YEs2NZs9PigTWrVfWFs8y0J1ad57BTVXjQ78Y3G5SqF
X-Gm-Message-State: AOJu0Yxt7WA8jV14DxIWqDUdGiEI/D1oxR2i5WpyPCe8AgxL52Mobb/+
	2GTcLIxe1JL3KnQcjDd09EIDdhr07YdwfN+VFyOEf6gn2qugnF6MCiLR+s+1z9M=
X-Google-Smtp-Source: AGHT+IHuR2/GUaaVQKMylulngc2NeSpLM/wXdoWCxP1RvRNWXEcQoYpHV6mjF9Upqj7OQcQnPl17cQ==
X-Received: by 2002:a05:600c:5493:b0:412:f24:560a with SMTP id iv19-20020a05600c549300b004120f24560amr10064073wmb.11.1709113421234;
        Wed, 28 Feb 2024 01:43:41 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id je13-20020a05600c1f8d00b00412b236f145sm1566537wmb.26.2024.02.28.01.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 01:43:40 -0800 (PST)
Date: Wed, 28 Feb 2024 10:43:37 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Erwan Velu <erwanaliasr1@gmail.com>
Cc: Erwan Velu <e.velu@criteo.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i40e: Prevent setting MTU if greater than MFS
Message-ID: <Zd8ASR9ocx-Xk4OT@nanopsycho>
References: <20240227192704.376176-1-e.velu@criteo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227192704.376176-1-e.velu@criteo.com>

Tue, Feb 27, 2024 at 08:27:03PM CET, erwanaliasr1@gmail.com wrote:
>Commit 6871a7de705b6f6a4046f0d19da9bcd689c3bc8e from iPXE project is
>setting the MFS to 0x600 = 1536.
>
>At boot time the i40e driver complains about it with
>the following message but continues.
>
>	MFS for port 1 has been set below the default: 600
>
>If the MTU size is increased, the driver accept it but large packets will not
>be processed by the firmware generating tx_errors. The issue is pretty
>silent for users. i.e doing TCP in such context will generates lots of
>retransmissions until the proper window size (below 1500) will be used.
>
>To fix this case, it would have been ideal to increase the MFS,
>via i40e_aqc_opc_set_mac_config, but I didn't found a reliable way to do it.
>
>At least, this commit prevents setting up an MTU greater than the current MFS.
>It will avoid being in the position of having an MTU set to 9000 on the
>netdev with a firmware refusing packets larger than 1536.
>
>A typical trace looks like the following :
>[  377.548696] i40e 0000:5d:00.0 eno5: Error changing mtu to 9000 which is greater than the current mfs: 1536
>
>Signed-off-by: Erwan Velu <e.velu@criteo.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Next time, could you please indicate the target tree in the patch
subject prefix, like this: "[patch net-next] xxx" ?


>---
> drivers/net/ethernet/intel/i40e/i40e_main.c | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
>index 54eb55464e31..14fc70d854d3 100644
>--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
>+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
>@@ -2950,7 +2950,7 @@ static int i40e_change_mtu(struct net_device *netdev, int new_mtu)
> 	struct i40e_netdev_priv *np = netdev_priv(netdev);
> 	struct i40e_vsi *vsi = np->vsi;
> 	struct i40e_pf *pf = vsi->back;
>-	int frame_size;
>+	int frame_size, mfs;
> 
> 	frame_size = i40e_max_vsi_frame_size(vsi, vsi->xdp_prog);
> 	if (new_mtu > frame_size - I40E_PACKET_HDR_PAD) {
>@@ -2959,6 +2959,13 @@ static int i40e_change_mtu(struct net_device *netdev, int new_mtu)
> 		return -EINVAL;
> 	}
> 
>+	mfs = pf->hw.phy.link_info.max_frame_size;
>+	if (new_mtu > mfs) {
>+		netdev_err(netdev, "Error changing mtu to %d which is greater than the current mfs: %d\n",
>+			   new_mtu, mfs);
>+		return -EINVAL;
>+	}
>+
> 	netdev_dbg(netdev, "changing MTU from %d to %d\n",
> 		   netdev->mtu, new_mtu);
> 	netdev->mtu = new_mtu;
>-- 
>2.43.2
>
>

