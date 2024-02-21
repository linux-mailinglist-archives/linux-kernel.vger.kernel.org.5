Return-Path: <linux-kernel+bounces-75026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E249685E1DF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40501C2448E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24A73A1A2;
	Wed, 21 Feb 2024 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Uo9b62mG"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6C68062F
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530590; cv=none; b=LiuHU3lqxQH+R69xLjkdxVGfqDU9ImySv4lXkrvsX7CqqM8qkzPhp6VzJZP28w/cR/WKiFhJJWmu3NEkVQLHzc6odZai2ESKNjzXPoattWFvBC96SvNUsHiWOYvqvffjVVqN7ALUNG3GRdA7LiIIQZfhw31fXYri91wyFAkc2B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530590; c=relaxed/simple;
	bh=OrAXqg8G4bMev0Hn4tGa3WDTsAxqPNXZWs/8AjY+XdU=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=gyljwWsNO7x3O7M2Ar+u0MkuoBcYOP1QBGgmDLTFug0pJ5XJdyJwXjtByom86rTklRGTcatAStm1DLrTVBuSqLDhvVpdbzYe4Y7QPeLUqpMFZ2iDDoeB+Kw2TmZ5/VK4i/3K5xpOJRs8o1o7YDMIBiC8A8hygoEGbLXkfrCoR4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Uo9b62mG; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C2E853F636
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1708530578;
	bh=WGNYfSNQTh19goOzHyiLxZdYWOcX+I0Fp1z5zFe70r8=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=Uo9b62mGurlXLnDmdU9f5uhkdHP6G8pjyKRAg29iDJpj/claPFfk6vlc+Wu63Y3Ld
	 tzCDXkuTVji9mJWstV/loGlhJkD9Pok0fpUzFD43HorrvJnHcoht+orwLHTgOU8L5j
	 SShUwhw2xi8CupfAciAWxAGa13/mXRa0LV8Rt4ilLQoZLnAKirCIIE4prubBgHPsrE
	 NYYogsRv+ec2AekX8qPt7X304YyaLWv+rorweDfeyC4Zze42RogrRjH+XkLkfpTAin
	 91pGCBTh/EaPM7eEXbS4SVIT/YSxFZn+gQt2PP67Rpsa74tosDWX1PZRR4Gk2nb/IO
	 QDD/yo+POGiAA==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-299c5a61099so2161040a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708530577; x=1709135377;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WGNYfSNQTh19goOzHyiLxZdYWOcX+I0Fp1z5zFe70r8=;
        b=fAmq2uJgqyA+dX3IIKHihOk78SUh8fGXMpJzb8h2bztMI6oMMHX5PNJtBP6uxZYWml
         CCLjscXS3XTumdRKaVXIbTB8VXbshNZrCEMEYG88D+DjSavt7850p7fiZGS6jqcLuZ9D
         kSRnTwLoOFkv52BVem+WkNQj5qXsO9IOxEVauTdpGrFh2WHzpHFeN/G0Nw9jBmK+LfgW
         Q/TXdg9OvN1ZAmRq1Dm+Q52/SbdnaJg+Csx9Kqmvu4YT5ulMheYhoYPf7TXVi1xzzRqA
         nqKQtkcBbcuqjVgBw9mZAWB1wQVmnKgYpFz2mmP1gpJNlgalCnBxJxXaCECTzhMmdQLz
         bndQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvG4/gJAAGUHd284jpCQoPBQKNwKb/wV1EKOtZ6Ht6q2XMPi1FadWZq4GpHts4E/zRilebskVp9qI4636xquZ8crjwFM7ulCBcD+9K
X-Gm-Message-State: AOJu0YzU+lqFf5cWd6mBouoeXHrnWLd3WN9XAi7Z7Xr43zAvkUIuWqrP
	+LKsz/9E7ahF5wxXgKIVs5SnTtCEu5iujbhMvMD9ohzZr+meKqEM2kK471CyE4wPNnxHSk1mKvR
	1AxWpTX0OEPCfcd3xZPiMBQ3azQXyhVj3APfRMR5PYl3avXufJjn0ce4BeW51QEqvlUCkSXi8qI
	1tpg==
X-Received: by 2002:a17:90a:3482:b0:299:3990:4e11 with SMTP id p2-20020a17090a348200b0029939904e11mr13049868pjb.34.1708530577457;
        Wed, 21 Feb 2024 07:49:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKsZ7CC/ov1NYWAU3H+jSsNO7zKzi0int6CRZ3wTWthcM19jkflIkqy/TgGvLmivXMt/b9mA==
X-Received: by 2002:a17:90a:3482:b0:299:3990:4e11 with SMTP id p2-20020a17090a348200b0029939904e11mr13049857pjb.34.1708530577133;
        Wed, 21 Feb 2024 07:49:37 -0800 (PST)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id si11-20020a17090b528b00b00296d9c4d5f0sm1978109pjb.10.2024.02.21.07.49.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Feb 2024 07:49:36 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 436895FF14; Wed, 21 Feb 2024 07:49:36 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 3C3689FAAA;
	Wed, 21 Feb 2024 07:49:36 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
cc: andy@greyhouse.net, davem@davemloft.net, edumazet@google.com,
    kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, rajesh.sivaramasubramaniom@oracle.com,
    rama.nichanamatlu@oracle.com, manjunath.b.patil@oracle.com
Subject: Re: [PATCH net-next v6] bonding: rate-limit bonding driver inspect messages
In-reply-to: <20240221082752.4660-1-praveen.kannoju@oracle.com>
References: <20240221082752.4660-1-praveen.kannoju@oracle.com>
Comments: In-reply-to Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
   message dated "Wed, 21 Feb 2024 13:57:52 +0530."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32545.1708530576.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Feb 2024 07:49:36 -0800
Message-ID: <32546.1708530576@famine>

Praveen Kumar Kannoju <praveen.kannoju@oracle.com> wrote:

>Through the routine bond_mii_monitor(), bonding driver inspects and commi=
ts
>the slave state changes. During the times when slave state change and
>failure in aqcuiring rtnl lock happen at the same time, the routine
>bond_mii_monitor() reschedules itself to come around after 1 msec to comm=
it
>the new state.
>
>During this, it executes the routine bond_miimon_inspect() to re-inspect
>the state chane and prints the corresponding slave state on to the consol=
e.
>Hence we do see a message at every 1 msec till the rtnl lock is acquired
>and state chage is committed.
>
>This patch doesn't change how bond functions. It only simply limits this
>kind of log flood.
>
>Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>

Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>


>---
>v6: =

>  - Minor space additions addressed. =

>v5: https://lore.kernel.org/all/20240221050809.4372-1-praveen.kannoju@ora=
cle.com/
>  - Redundant indentation addressed.
>v4: https://lore.kernel.org/all/20240220050437.5623-1-praveen.kannoju@ora=
cle.com/
>  - Rectification in the patch subject and versioning details.
>v3: https://lore.kernel.org/lkml/20240219133721.4567-1-praveen.kannoju@or=
acle.com/
>  - Commit message is modified to provide summary of the issue, because o=
f
>    which rate-limiting the bonding driver messages is needed.
>v2: https://lore.kernel.org/lkml/20240215172554.4211-1-praveen.kannoju@or=
acle.com/
>  - Use exising net_ratelimit() instead of introducing new rate-limit
>    parameter.
>v1: https://lore.kernel.org/lkml/20240214044245.33170-1-praveen.kannoju@o=
racle.com/
>---
> drivers/net/bonding/bond_main.c | 18 ++++++++++--------
> 1 file changed, 10 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 4e0600c..51fdb79 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -2609,7 +2609,7 @@ static int bond_miimon_inspect(struct bonding *bond=
)
> 			bond_propose_link_state(slave, BOND_LINK_FAIL);
> 			commit++;
> 			slave->delay =3D bond->params.downdelay;
>-			if (slave->delay) {
>+			if (slave->delay && net_ratelimit()) {
> 				slave_info(bond->dev, slave->dev, "link status down for %sinterface,=
 disabling it in %d ms\n",
> 					   (BOND_MODE(bond) =3D=3D
> 					    BOND_MODE_ACTIVEBACKUP) ?
>@@ -2623,9 +2623,10 @@ static int bond_miimon_inspect(struct bonding *bon=
d)
> 				/* recovered before downdelay expired */
> 				bond_propose_link_state(slave, BOND_LINK_UP);
> 				slave->last_link_up =3D jiffies;
>-				slave_info(bond->dev, slave->dev, "link status up again after %d ms\=
n",
>-					   (bond->params.downdelay - slave->delay) *
>-					   bond->params.miimon);
>+				if (net_ratelimit())
>+					slave_info(bond->dev, slave->dev, "link status up again after %d ms=
\n",
>+						   (bond->params.downdelay - slave->delay) *
>+						   bond->params.miimon);
> 				commit++;
> 				continue;
> 			}
>@@ -2647,7 +2648,7 @@ static int bond_miimon_inspect(struct bonding *bond=
)
> 			commit++;
> 			slave->delay =3D bond->params.updelay;
> =

>-			if (slave->delay) {
>+			if (slave->delay && net_ratelimit()) {
> 				slave_info(bond->dev, slave->dev, "link status up, enabling it in %d=
 ms\n",
> 					   ignore_updelay ? 0 :
> 					   bond->params.updelay *
>@@ -2657,9 +2658,10 @@ static int bond_miimon_inspect(struct bonding *bon=
d)
> 		case BOND_LINK_BACK:
> 			if (!link_state) {
> 				bond_propose_link_state(slave, BOND_LINK_DOWN);
>-				slave_info(bond->dev, slave->dev, "link status down again after %d m=
s\n",
>-					   (bond->params.updelay - slave->delay) *
>-					   bond->params.miimon);
>+				if (net_ratelimit())
>+					slave_info(bond->dev, slave->dev, "link status down again after %d =
ms\n",
>+						   (bond->params.updelay - slave->delay) *
>+						   bond->params.miimon);
> 				commit++;
> 				continue;
> 			}
>-- =

>1.8.3.1
>
>

