Return-Path: <linux-kernel+bounces-4086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1222F8177CC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5C0828422F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59071498AB;
	Mon, 18 Dec 2023 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfMt/8N8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEBD6FB6;
	Mon, 18 Dec 2023 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-202ffc46e15so1001485fac.1;
        Mon, 18 Dec 2023 08:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702917944; x=1703522744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kZBaEcaOfw2v5PuhZIuGx5Nh4ffB6hmj27S27SIqM0U=;
        b=RfMt/8N8ISkeYyAid+dJCGNfMapEDGNvi+ZVGVye764Ay7DC+frAaEtcTHbx12jC/I
         n21pQ+MSCkCS36s4Ko2rJL/nVRipfirxGD4Sw+BbjERSecvyhyH61e4C4dYfcrx8AISG
         WyXxi6n6xNU4RCHPdRZQjHy3CAE4JrFmYzaiXW0oJktp1P0SGt2x+AbNVct+RssstMSh
         Xu10SeYTdBZJENrh6cDWNxUDO3VNGxHAYPrdPFmcb6HSrc1gp6cFasZ05CSZXC+B3wYS
         Wu/DE0yCt741nCd8MjU/f+XUExPJZhir9MNMdJsTtGiFS5osT6XkVW9PPPPp6gn0SE4+
         R1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702917944; x=1703522744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZBaEcaOfw2v5PuhZIuGx5Nh4ffB6hmj27S27SIqM0U=;
        b=Sz+t4hxtp5bC3coaHEGmmJRa1Rv9XDCAkyjoVkpq9BQtUN81tUepltsOop77AX3KJH
         O0A3bNxEme+YwdHsSN+AtKPRkRnkP/B9DRvgEPzawqThHhWtLDM1rnDpqTR/fX92qmGs
         vq5XjdJNwhhH+2ww09m4rs5+pyvewFVmCrUupRsHrkmyfBFvNGomI1kiFuRVkKkwEVR+
         Hgblw/eMRB9iqc5XOL7JMwqhfArI7+dXTMWeJWN9tY3DoeF+uT38bCgif6CIkkG72hio
         keBPSyo4VRnuZoAs6Eqn29E8GATj6TeAun+qTQZG2bFaupoI0dhp2iEWtKgLBOB5umHR
         4KBQ==
X-Gm-Message-State: AOJu0YzYss05Ux+psfL0GgohGAjz13iW3oUTZa+dL/EVarR1WTjsJkks
	9lJ7cioguxFHHcVxxI14YEw=
X-Google-Smtp-Source: AGHT+IFkZbgrLltWRQmcuK47ZhmM/ou2am8/YsufUxSo8ukorCyhrXDR/PsCGIaVxxajzK5+c2aEDg==
X-Received: by 2002:a05:6871:890a:b0:203:9e4a:d9c0 with SMTP id ti10-20020a056871890a00b002039e4ad9c0mr1007193oab.31.1702917944490;
        Mon, 18 Dec 2023 08:45:44 -0800 (PST)
Received: from localhost ([2607:fea8:52a3:d200::325c])
        by smtp.gmail.com with ESMTPSA id c12-20020ac86e8c000000b004255183b1a4sm9374825qtv.64.2023.12.18.08.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 08:45:43 -0800 (PST)
From: Richard Acayan <mailingradian@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hardik Gajjar <hgajjar@de.adit-jv.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH] usb: gadget: u_ether: Re-attach netif device to mirror detachment
Date: Mon, 18 Dec 2023 11:45:33 -0500
Message-ID: <20231218164532.411125-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 6.7-rc1, there was a netif_device_detach call added to the
gether_disconnect function. This clears the __LINK_STATE_PRESENT bit of
the netif device and suppresses pings (ICMP messages) and TCP connection
requests from the connected host. If userspace temporarily disconnects
the gadget, such as by temporarily removing configuration in the gadget
configfs interface, network activity should continue to be processed
when the gadget is re-connected. Mirror the netif_device_detach call
with a netif_device_attach call in gether_connect to fix re-connecting
gadgets.

Link: https://gitlab.com/postmarketOS/pmaports/-/tree/6002e51b7090aeeb42947e0ca7ec22278d7227d0/main/postmarketos-base-ui/rootfs-usr-lib-NetworkManager-dispatcher.d-50-tethering.sh
Fixes: f49449fbc21e ("usb: gadget: u_ether: Replace netif_stop_queue with netif_device_detach")
Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 drivers/usb/gadget/function/u_ether.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 9d1c40c152d8..3c5a6f6ac341 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -1163,6 +1163,8 @@ struct net_device *gether_connect(struct gether *link)
 		if (netif_running(dev->net))
 			eth_start(dev, GFP_ATOMIC);
 
+		netif_device_attach(dev->net);
+
 	/* on error, disable any endpoints  */
 	} else {
 		(void) usb_ep_disable(link->out_ep);
-- 
2.43.0


