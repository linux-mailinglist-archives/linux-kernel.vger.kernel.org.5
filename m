Return-Path: <linux-kernel+bounces-15289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0D08229C3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262121C230E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D730218624;
	Wed,  3 Jan 2024 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHTbpHjv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2E9182B9;
	Wed,  3 Jan 2024 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55676f1faa9so1780607a12.0;
        Wed, 03 Jan 2024 00:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704271866; x=1704876666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XiqjQ4CtsdHzeZ/6fpkEoYxayaW7/f/QwsswQ02BtUY=;
        b=QHTbpHjv+Cw0zzcEmh87ZdwKKKK4xZKOOPqunMP8nY07GPih+Pwyy+1vi9nRCk89Z4
         ++mqwurighPZGOBt0Cdzvv+bkrLdFGPRlNSinov/LChUTJyz+w55cuJm/251VIpTq+DC
         wbwKNdJjvaPIo0DdUsWt0hPp1HKqY/gikjcr93vHInEjIgI1kMgZW9CHxPtqoKBp/YDk
         CzBsdsmr+HlbtVWfgLk9OoerTmsB81Sv1iDijBeXGZCGKziOn7lPTdNgx6BC9tABwj8F
         RDsPJh+RSwKgzXr0ihU6jUkuOcEF4PdjuErMSJMuj4WFSLNIW9ZdEhrGaR9uQ3jDodJg
         JlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704271866; x=1704876666;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XiqjQ4CtsdHzeZ/6fpkEoYxayaW7/f/QwsswQ02BtUY=;
        b=pOX3I2Kn0L0M3wdUvCUZ3/Wi4LreOot8BEypL7EuvFoJJ+4he2QM4tm7i/D/7YWLVX
         rv9hG6WCiooO/D0tDzM8ZF59hLtWhSrJtBySXl9GiyUGM3QUmAQOkrmJLljzIDSPZu88
         cLeBFnAPbywzlJACg7vMnzajyhMLka5Rbo68to1vlsR/hjrvObjOwytmMacQAgPlV5XD
         OA4Ho8o7QMWQJlRbWgZhQuqcRT6fDjEUOBoY3y+LI9rrQKo5Yi0jy0ukz+TlwkeytXOW
         fo5ygk5tdfGAZHEp1JW7XlOSB3+yhTY24WC51vaKWpDf2R24jnf/6Y3dulezhSD208Kl
         Tvxw==
X-Gm-Message-State: AOJu0YwafJRaA+x+6dYN4glP8ftzHWtjSAwP9etROcg01wH1jKuZCnXZ
	9j4lZa9uwpCIULJJME7Q68s=
X-Google-Smtp-Source: AGHT+IGNYJlgqX4aL4rwFT6qPkLkPCNzu0T6qFd3mLQ/9Gm/aUXTDoxlbkwKVyX8g/IDS0wJ8Nwjrg==
X-Received: by 2002:aa7:d795:0:b0:552:3044:1df9 with SMTP id s21-20020aa7d795000000b0055230441df9mr10602167edq.67.1704271865117;
        Wed, 03 Jan 2024 00:51:05 -0800 (PST)
Received: from [127.0.0.1] ([89.205.132.224])
        by smtp.gmail.com with ESMTPSA id o18-20020aa7dd52000000b00555a0fa2211sm7690447edw.31.2024.01.03.00.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 00:51:04 -0800 (PST)
Date: Wed, 03 Jan 2024 09:51:06 +0100
From: Eric Woudstra <ericwouds@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
CC: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Alexander Couzens <lynxis@fe80.eu>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_RFC_net-next=5D_net=3A_pcs=3A_pcs-mtk-lyn?= =?US-ASCII?Q?xi_fix_mtk=5Fpcs=5Flynxi=5Fget=5Fstate=28=29_for_2500base-x?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZZSX_oNUIQr6R9FU@pidgin.makrotopia.org>
References: <20240102074408.1049203-1-ericwouds@gmail.com> <ZZP9GR15ufDbjGAJ@shell.armlinux.org.uk> <92190426-3614-4774-9E9F-18F121622788@gmail.com> <74223164-ab50-4d6d-a4f4-561b0a70d396@gmail.com> <ZZRrk85SCDmo76NJ@pidgin.makrotopia.org> <6666EB36-984E-4898-A41A-2D9713DE4DB0@gmail.com> <ZZSX_oNUIQr6R9FU@pidgin.makrotopia.org>
Message-ID: <654EAEA9-052C-43C6-AA8E-16A30721A916@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

>Surely, having phylink take care whether SGMII_SPEED_DUPLEX_AN should be
>set would be even nicer=2E
>
>I believe that source of confusion here is simply that
>
>in-band-status !=3D SGMII_SPEED_DUPLEX_AN
>
>We *do* have in-band-status even without having SGMII_SPEED_DUPLEX_AN set
>with 2500Base-X link mode (as in: link being up or down and link, duplex
>and speed is fixed anyway for 2500Base-X)=2E


All clear, and even with autoneg disabled, one way or another, we now
have a non-functional 2500base-x=2E Cannot manipulate anything in
userland to get the connection functional=2E We need a fix in kernel=2E

