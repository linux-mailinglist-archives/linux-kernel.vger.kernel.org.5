Return-Path: <linux-kernel+bounces-157186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6F78B0E11
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23AF01F21D2D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E2F15F41C;
	Wed, 24 Apr 2024 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ev5t56CM"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56BD15EFAD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972207; cv=none; b=tbci92oFSgmmw5xpLKf3BOsUT2wBDNcF38tcP/+NMxSVf2uY0khhNCVKOytSq7RzOrBIq7yBjYpWab4vJTeFc927iQHY4vx/4qBGy1QIpAi+CwIvh3lgMrJ30nqnw8HUDUmT6pYQALS5vUCrlHN+suisLWG1aGdpU2rLRK9GIb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972207; c=relaxed/simple;
	bh=sCijfIoiWWuO+ID4TbJRdKV8axy5TX4E4LShcWAdV3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUgeXWHtXs/XDUQyNfkPpsnlCb/Q/7Se3xGPIuoXD7jFYoh6+2Z7fRlO+IDXXk35WfMTl5493d1gTcMHYGQQ67tpzMJgwkfsyJM3QDKYhF/bmOloN7m6QaWcBAt+0iWbSfZ5lYllxYw4Pt6grSyGVE6YpRmYGM+Wr5kdpPybfX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ev5t56CM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41a442c9dcbso29462065e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713972204; x=1714577004; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VL+zjtnTa4V4GoS3gEyjQ79J0VHTyJiZJ2md1+Efeok=;
        b=Ev5t56CMzhO5PFIR2LgecrKDWP+Szio/jP0qKkNK6+D49fg3RPinZzgGjZRYahzuA2
         MZh2yvRBTJoX2ZZ/Mlrb1tAh/oYiBBSGcViTQNQ6+fHOlMbT08Ua0QxWSqmsbK3LXWAb
         Y0nk6Y5mmYQpU4DWq8MVbiTOXu1A+V9kgcD4ybgU4QM8N5Fg8w/OULwqYBQOb8/po56t
         HnYns2D5+tBCbf1ffGpvP1DwFdKUXruFtiMXKe4DEAp+festqits/tZiFCDAZ+RPpMuZ
         KWynwewORBhn5OWjntkEgPT+efKlZW+MD1ZO28yYUlQnYW1CQc2d5Vebz4NGXZHs7Pde
         IQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713972204; x=1714577004;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VL+zjtnTa4V4GoS3gEyjQ79J0VHTyJiZJ2md1+Efeok=;
        b=lVAIKO4q4cj5IhgRNV3IBi7y5oTQN7/WfcUvgqiOlQeHSOgmm1cgY95+GTZOEZlUyw
         cJU6D36g5Jo3MBM7aDTLrh9Jl1+Z5GbFaF+nqjVF8ERzpimKQhHmzIoaVxFRZXULHtbB
         VJoNCGdKaMW6ZTstM6g7gnim1Mxlf/AXcjphcUDJejI5yu2JUnykZ0x0WxYUfCF7WUAl
         aKe8vSmmt1pcgXe2NviIQgShOhIVa5C7Egt8lks1LVO0h+qnQsZjOm1zC0bg4XHGtS4L
         RJKFA1AuYRT3ENChkrW/TiQ3MFPmADnxcVj+W629Cq9pEUv+CN9p4VarMLVONEJEHb4t
         Lb3A==
X-Forwarded-Encrypted: i=1; AJvYcCVAh+NGCQ6k2TrNMPFgFJvU//kEnGIcDzm0Qr/UR/8NKzuAWb4J4h4nH+sgzqezo6ZCYHnDDElsklA/PBEuf4Uevb43As/LUI7ej4OX
X-Gm-Message-State: AOJu0YxrXwapN8EkvCUdosXU0L8m+boqGSehNkXwpQ5ucxa+W1fjH14q
	qcNE+4AJTW8Azb5LwFqpa0wFMidiKnTiH3ecZNPGIiof/4de7Um3Wj3zJLUXeyY=
X-Google-Smtp-Source: AGHT+IGxx65KCqZ4q/prIN2iszax2XMR/WHT1xZqecy25hagi5Rc/3NljOGJBmCz23kmuErBnt/7ag==
X-Received: by 2002:a05:600c:190b:b0:41a:a5ff:ea3a with SMTP id j11-20020a05600c190b00b0041aa5ffea3amr2116282wmq.19.1713972204035;
        Wed, 24 Apr 2024 08:23:24 -0700 (PDT)
Received: from linux-l9pv.suse (2a02:9130:80a6:db2c:2677:3ff:fecf:2660.red-2a02-9130.customerbam.ipv6.rima-tde.net. [2a02:9130:80a6:db2c:2677:3ff:fecf:2660])
        by smtp.gmail.com with ESMTPSA id ay32-20020a05600c1e2000b0041ae995b926sm3736399wmb.3.2024.04.24.08.23.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2024 08:23:23 -0700 (PDT)
Date: Wed, 24 Apr 2024 23:23:19 +0800
From: joeyli <jlee@suse.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Chun-Yi Lee <joeyli.kernel@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Manish Mandlik <mmandlik@google.com>,
	Archie Pusaka <apusaka@chromium.org>,
	Miao-chen Chou <mcchou@chromium.org>, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_sync: Using hci_cmd_sync_submit when
 removing Adv Monitor
Message-ID: <20240424152319.GD26307@linux-l9pv.suse>
References: <20240424135903.24169-1-jlee@suse.com>
 <0391b306-1368-47ea-9602-26ff6df48921@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0391b306-1368-47ea-9602-26ff6df48921@molgen.mpg.de>
User-Agent: Mutt/1.11.4 (2019-03-13)

Hi Paul,

Thanks for your review. I will follow your suggestion to update
my v2 patch. 

Joey Lee

On Wed, Apr 24, 2024 at 04:13:09PM +0200, Paul Menzel wrote:
> Dear Chun-Yi,
> 
> 
> Thank you for your patch.
> 
> Am 24.04.24 um 15:59 schrieb Lee, Chun-Yi:
> > From: Chun-Yi Lee <jlee@suse.com>
> 
> Please use imperative mood in the commit message summary:
> 
> Use hci_cmd_sync_submit() when removing Adv Monitor
> 
> > Since the d883a4669a1de be introduced in v6.4, bluetooth daemon
> > got the following failed message of MGMT_OP_REMOVE_ADV_MONITOR
> > command when controller is power-off:
> 
> Maybe:
> 
> Since commit d883a4669a1de, present since Linux v6.4, the daemon bluetoothd
> logs the failure below, if the command MGMT_OP_REMOVE_ADV_MONITOR is sent
> when the controller is powered off.
> 
> > bluetoothd[20976]:
> > src/adapter.c:reset_adv_monitors_complete() Failed to reset Adv
> > Monitors: Failed>
> 
> Please make this one line and indent it with four spaces.
> 
> > Normally this situation is happened when the bluetoothd deamon
> 
> 1.  happen*s*
> 2.  d*ae*mon
> 
> > be started manually after system booting. Which means that
> 
> is started
> 
> > bluetoothd received MGMT_EV_INDEX_ADDED event after kernel
> 
> receive*s*
> 
> > runs hci_power_off().
> > 
> > Base on doc/mgmt-api.txt, the MGMT_OP_REMOVE_ADV_MONITOR command
> 
> Base*d*
> 
> > can be used when the controller is not powered. This patch changes
> 
> “This patch …” is redundant. Use: Change the code …
> 
> > the code in remove_adv_monitor() to use hci_cmd_sync_submit()
> > instead of hci_cmd_sync_queue().
> 
> Please document the test setup.
> 
> > Fixes: d883a4669a1de ("Bluetooth: hci_sync: Only allow hci_cmd_sync_queue if running")
> > Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > Cc: Manish Mandlik <mmandlik@google.com>
> > Cc: Archie Pusaka <apusaka@chromium.org>
> > Cc: Miao-chen Chou <mcchou@chromium.org>
> > Signed-off-by: Chun-Yi Lee <jlee@suse.com>
> > ---
> >   net/bluetooth/mgmt.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index 32ed6e9245a3..21962969411d 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -5475,7 +5475,7 @@ static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
> >   		goto unlock;
> >   	}
> > -	err = hci_cmd_sync_queue(hdev, mgmt_remove_adv_monitor_sync, cmd,
> > +	err = hci_cmd_sync_submit(hdev, mgmt_remove_adv_monitor_sync, cmd,
> >   				 mgmt_remove_adv_monitor_complete);
> >   	if (err) {
> 
> 
> Kind regards,
> 
> Paul

