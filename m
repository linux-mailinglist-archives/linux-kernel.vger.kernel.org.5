Return-Path: <linux-kernel+bounces-65822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9247C855272
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1578D283BB8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD26312D76E;
	Wed, 14 Feb 2024 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="UtTO+Kua"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD24260DE5
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 18:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936149; cv=none; b=Cp3OquSgwguw/KQlBx/2i9MH2e1dZ3fmql9h/siaMCztHViWRw4xm2Vju1WfxiZGSa6J8smYfHmhkpOczCty/S+QcqTUF19vc5LqjwTIcT43/DuuxZv0wiGxbQ/+23wVFDml8RPWStJB+NYNqzglebb5xwE/9lVeVvWgcHClGt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936149; c=relaxed/simple;
	bh=gMOqJQ9jGX8BrI2e7uwdbBZnOvPjV2iMIvw9st1KTZ0=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=ecDiHgQhk/rnq+CRHuWf3JdeElM3aKJHykdKYiLcL4AO/Qy0dRtcbgcStjg58w8PooM5Y5bxBDTmmX6QPnXvPWm2OZxmSM9145nMplDZjDUO8ui0pQs3SkIgn4M8d5eR28UCpsc/VQNhAUw5ePbnCnmr4nCIb1Sf0LWMyPlFFfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=UtTO+Kua; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0A07440EDA
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 18:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1707935679;
	bh=rfIT5YDOblrqYOSLL2etqM8BAAl7iVzBIumCF/p5be0=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=UtTO+KuaNd+Yi8BYWx0I9LVy2gDkUqk/jGfwf+qoeaqCKOG9eKlJgaOOwd9DcDRjr
	 KkwTxT7y5eahDArtDfcrHRJqZVZr/4AR7lp3GBHgNz7Lcz6n6oT+J6P9Jz5stdspHW
	 gSL9Ip0wS2Nv3VUqjSUxGoK0EwzPGk6m13lV/H2Kn/GQITWrz7Q5zpawwKJH74d+bd
	 j5Zc1EdJ96XrVRpM6ECwGrJWqkjJzTn2vtafECoPzuElIFMSbZ7/uuid9nxx3YH6EW
	 M40MKzGp1muqYBMn0GXvbGuiTvPc8Cs2xCqB7wXhiVCbIXM64XxF4PswWIDtBX4wII
	 Br14Bg2p3sB/g==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-298f00bf688so78248a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:34:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707935676; x=1708540476;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rfIT5YDOblrqYOSLL2etqM8BAAl7iVzBIumCF/p5be0=;
        b=luuFUxp8FNIYoBzwwczxFyO6u/Ex5mMVz1h1dvYeh6cBMZF1FATiMjhr3z0YQwPlKg
         DCBavqpe0tzlAdxZsG3vqwjBSFE4rhM3zDN/9QgJQAf5cCF1RnYpZkTduOrvnZdPjo1u
         H7lB0Lgr3Vj798UQtdKUh5/eu1X98CH/EpUqS8Wih0LR4QDMkdlsps6KM5umWOhmO4rj
         WMgsY64N66G0tKLGDQOOLRPaLH/FDdS1IRhlAPEc/1jUObycbTMTF2LHI/6LnKQtjiSU
         SlRa3EVYac8sG67fEdbfo+jxPfeX61uVjXiarFiCluUQhjNkYs5Ow29wQ9p8z+O+XxJD
         7jwg==
X-Forwarded-Encrypted: i=1; AJvYcCXVv0yIuyO76+hJMzcxOgG2NIfkIuKelpkydcOctPS8dLGsyeGFR8tKgvWo/EiVn6WLpOjI/9Oqfb2UM4dYhhzUWktPKGIySbVQcPOs
X-Gm-Message-State: AOJu0YzUB/KyyhW1s643pdvXqtaTOkIlTxGR1HR+UFWfkzhN2rzFgsTP
	gfdTMdvdVi22Wsbf84IXO+DIkhekg83AqrS/hq7FVYdj1g6NvaYPOTEKv8T0NKNnegRACdWiPth
	tbLWQowSnK+HQtPmnvmvXneTBGd5oCNDLSWpD3H46PufjrWAh8KpuprKHv2USUT+lmNxHQhjroV
	hipA==
X-Received: by 2002:a17:90a:f28c:b0:295:b440:9751 with SMTP id fs12-20020a17090af28c00b00295b4409751mr3141590pjb.44.1707935676673;
        Wed, 14 Feb 2024 10:34:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0kxGLNO4idnxDh27qUqCYdrXNhWksfjkjNRjMIy63fnj8xY/UmqTFfDa6JYsjMsag+Sr5xg==
X-Received: by 2002:a17:90a:f28c:b0:295:b440:9751 with SMTP id fs12-20020a17090af28c00b00295b4409751mr3141569pjb.44.1707935676328;
        Wed, 14 Feb 2024 10:34:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUw+vjOlHmH9Np0YVJ3KKLC2ZCiH7M4AKGvKnlQWicZzu1Zb9tZwQtaDT1eBAVvGZqcSMUYEb4ARwCqM6fumVp4X5+9u5uq5X3LF2MDbY0UYS7LGCbazKpa7F90/rxaOF7LypHu+kIqwrG07iTkAdUEUhQ7qposWNOB/WhdQNBhB0Gk4VVvXGTrzdOtwN7BBo8CuGc38EXX46L0jxcHgXqIGIq+HB+LNYQb2rrYfu6NW2yrwNNYDKLWkb6aLml4i8pgE4TEB4AFobU8Yt3GKfDLz/W5SWqWDN1zsVcyBMt/jBY7eFQnVUe3bxG2e2Iji3MVdKDrCL7/ZfUl83D2gg+oOwepPWCTlfBBt2kbJx9XDKYXg2F9
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id h13-20020a17090adb8d00b0029082d10fc4sm1783790pjv.39.2024.02.14.10.34.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Feb 2024 10:34:35 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 61E1F5FFF6; Wed, 14 Feb 2024 10:34:35 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 546909FAAA;
	Wed, 14 Feb 2024 10:34:35 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
cc: andy@greyhouse.net, davem@davemloft.net, edumazet@google.com,
    kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, rajesh.sivaramasubramaniom@oracle.com,
    rama.nichanamatlu@oracle.com, manjunath.b.patil@oracle.com
Subject: Re: [PATCH RFC] bonding: rate-limit bonding driver inspect messages
In-reply-to: <20240214044245.33170-1-praveen.kannoju@oracle.com>
References: <20240214044245.33170-1-praveen.kannoju@oracle.com>
Comments: In-reply-to Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
   message dated "Wed, 14 Feb 2024 10:12:45 +0530."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7712.1707935675.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Feb 2024 10:34:35 -0800
Message-ID: <7713.1707935675@famine>

Praveen Kumar Kannoju <praveen.kannoju@oracle.com> wrote:

>Rate limit bond driver log messages, to prevent a log flood in a run-away
>situation, e.g couldn't get rtnl lock. Message flood leads to instability
>of system and loss of other crucial messages.
>
>Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
>---
> drivers/net/bonding/bond_main.c | 34 +++++++++++++++++++---------------
> include/net/bonding.h           | 11 +++++++++++
> 2 files changed, 30 insertions(+), 15 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 4e0600c..32098dd 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -2610,12 +2610,13 @@ static int bond_miimon_inspect(struct bonding *bo=
nd)
> 			commit++;
> 			slave->delay =3D bond->params.downdelay;
> 			if (slave->delay) {
>-				slave_info(bond->dev, slave->dev, "link status down for %sinterface,=
 disabling it in %d ms\n",
>-					   (BOND_MODE(bond) =3D=3D
>-					    BOND_MODE_ACTIVEBACKUP) ?
>-					    (bond_is_active_slave(slave) ?
>+				bond_info_rl(bond->dev, slave->dev,
>+					     "link status down for %sinterface, disabling it in %d ms\n",
>+					     (BOND_MODE(bond) =3D=3D
>+					     BOND_MODE_ACTIVEBACKUP) ?
>+					     (bond_is_active_slave(slave) ?
> 					     "active " : "backup ") : "",
>-					   bond->params.downdelay * bond->params.miimon);
>+					     bond->params.downdelay * bond->params.miimon);

	Why not use net_info_ratelimited() or net_ratelimit()?  The rest
of the bonding messages that are rate limited are almost all gated by
the net rate limiter.

	-J

> 			}
> 			fallthrough;
> 		case BOND_LINK_FAIL:
>@@ -2623,9 +2624,10 @@ static int bond_miimon_inspect(struct bonding *bon=
d)
> 				/* recovered before downdelay expired */
> 				bond_propose_link_state(slave, BOND_LINK_UP);
> 				slave->last_link_up =3D jiffies;
>-				slave_info(bond->dev, slave->dev, "link status up again after %d ms\=
n",
>-					   (bond->params.downdelay - slave->delay) *
>-					   bond->params.miimon);
>+				bond_info_rl(bond->dev, slave->dev,
>+					     "link status up again after %d ms\n",
>+					     (bond->params.downdelay - slave->delay) *
>+					     bond->params.miimon);
> 				commit++;
> 				continue;
> 			}
>@@ -2648,18 +2650,20 @@ static int bond_miimon_inspect(struct bonding *bo=
nd)
> 			slave->delay =3D bond->params.updelay;
> =

> 			if (slave->delay) {
>-				slave_info(bond->dev, slave->dev, "link status up, enabling it in %d=
 ms\n",
>-					   ignore_updelay ? 0 :
>-					   bond->params.updelay *
>-					   bond->params.miimon);
>+				bond_info_rl(bond->dev, slave->dev,
>+					     "link status up, enabling it in %d ms\n",
>+					     ignore_updelay ? 0 :
>+					     bond->params.updelay *
>+					     bond->params.miimon);
> 			}
> 			fallthrough;
> 		case BOND_LINK_BACK:
> 			if (!link_state) {
> 				bond_propose_link_state(slave, BOND_LINK_DOWN);
>-				slave_info(bond->dev, slave->dev, "link status down again after %d m=
s\n",
>-					   (bond->params.updelay - slave->delay) *
>-					   bond->params.miimon);
>+				bond_info_rl(bond->dev, slave->dev,
>+					     "link status down again after %d ms\n",
>+					     (bond->params.updelay - slave->delay) *
>+					     bond->params.miimon);
> 				commit++;
> 				continue;
> 			}
>diff --git a/include/net/bonding.h b/include/net/bonding.h
>index 5b8b1b6..ebdfaf0 100644
>--- a/include/net/bonding.h
>+++ b/include/net/bonding.h
>@@ -39,8 +39,19 @@
> #define __long_aligned __attribute__((aligned((sizeof(long)))))
> #endif
> =

>+DEFINE_RATELIMIT_STATE(bond_rs, DEFAULT_RATELIMIT_INTERVAL,
>+		       DEFAULT_RATELIMIT_BURST);
>+
>+#define bond_ratelimited_function(function, ...)	\
>+do {							\
>+	if (__ratelimit(&bond_rs))		\
>+		function(__VA_ARGS__);			\
>+} while (0)
>+
> #define slave_info(bond_dev, slave_dev, fmt, ...) \
> 	netdev_info(bond_dev, "(slave %s): " fmt, (slave_dev)->name, ##__VA_ARG=
S__)
>+#define bond_info_rl(bond_dev, slave_dev, fmt, ...) \
>+	bond_ratelimited_function(slave_info, fmt, ##__VA_ARGS__)
> #define slave_warn(bond_dev, slave_dev, fmt, ...) \
> 	netdev_warn(bond_dev, "(slave %s): " fmt, (slave_dev)->name, ##__VA_ARG=
S__)
> #define slave_dbg(bond_dev, slave_dev, fmt, ...) \
>-- =

>1.8.3.1
>
>

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

