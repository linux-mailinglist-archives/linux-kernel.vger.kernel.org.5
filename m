Return-Path: <linux-kernel+bounces-14930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD38D82249D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B322878BD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E29171D4;
	Tue,  2 Jan 2024 22:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaP6DsUn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD68F171BF;
	Tue,  2 Jan 2024 22:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-555aa7fd668so4189942a12.0;
        Tue, 02 Jan 2024 14:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704233639; x=1704838439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nNtKRKHLT7GbRif0IHQKXzEMZSVRXKy9jF4fRiR/VhE=;
        b=SaP6DsUnX1LOjT0yIHrbFmUGha0kBq/ZHP+ACS9ItNsrH8C7bxiLkM7vho1nFO3BtV
         lStjvErkAXMco3DvgKz+BhBjq5vWeYOK8c7XtH5UcOE6J79HLx7oNepHR9w45TP4rfwH
         cjCDgydCG3+oSuKzX+hq4Yw9mXF7kRwCoQOxMxVKu8jFzt49gxdSpS33xvg+JIEokbwO
         yEev1IyUTxn4lFs3irQLPVUl3v32b8UbX6sICQJbaRnZuRUmSImwvTmaEs4EUA1GvNJY
         7NAFjGQt3DKam9tMREkWA00ArsqHykIglbibVUboe+/t1m97BWmaGhyiIAM3MLpNo7nX
         dRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704233639; x=1704838439;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nNtKRKHLT7GbRif0IHQKXzEMZSVRXKy9jF4fRiR/VhE=;
        b=nWwuyCJpC3C+sQAxBBTG0yG/eTKw3oD7c0v/485dOW9Bsp0jRdex/2QABGQs/EUgma
         bWlYFWcdrfZroDXRRSnf7+VmtiZQu5s49eDctOzEejnZlR8Rsv1CU/Y2ws8lKqPN2ZvY
         9hd0DWz52Y11cWWlKaQYDFRzashaq201vyKL4IoxvGHcXvB1UTv0tw9e0YEqCG0QJD6a
         H0bixnvkcpas7lG88qu3IRU6BQINeVME3bmcNGyogc6McbqauN7foRIOtwEXIw0IOoPT
         Rq8JrH6VNx97ZkE5LJE7305VgTM6MXMBkAWZLMUyarAI+V5LleVhB1LvBwp38RxtX6yw
         mupw==
X-Gm-Message-State: AOJu0YzQF/aY+bYKHHyX3iDiZqD7SyyERFlOpn8YfXq2ScGevBn55oZM
	2ZGzT7MJl/M4izk/44NKEcM=
X-Google-Smtp-Source: AGHT+IEt2lfwKc8ud/gUjAY0071TQZcjd/zfGADvdh0gXWS/csgwq/BmpisH8laLc0/X9noGpGIzpg==
X-Received: by 2002:a17:906:74d3:b0:a27:ec73:7a89 with SMTP id z19-20020a17090674d300b00a27ec737a89mr1604424ejl.68.1704233638915;
        Tue, 02 Jan 2024 14:13:58 -0800 (PST)
Received: from [127.0.0.1] ([89.205.132.224])
        by smtp.gmail.com with ESMTPSA id l1-20020a170907914100b00a27741ca951sm4950747ejs.108.2024.01.02.14.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 14:13:58 -0800 (PST)
Date: Tue, 02 Jan 2024 23:13:58 +0100
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
In-Reply-To: <ZZRrk85SCDmo76NJ@pidgin.makrotopia.org>
References: <20240102074408.1049203-1-ericwouds@gmail.com> <ZZP9GR15ufDbjGAJ@shell.armlinux.org.uk> <92190426-3614-4774-9E9F-18F121622788@gmail.com> <74223164-ab50-4d6d-a4f4-561b0a70d396@gmail.com> <ZZRrk85SCDmo76NJ@pidgin.makrotopia.org>
Message-ID: <6666EB36-984E-4898-A41A-2D9713DE4DB0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

I believe the general idea is that phylink should be aware wether to use in=
band or outband negotiation in order to setup the hardware correctly=2E Spe=
aking of a situation where there is a PHY attached=2E

On January 2, 2024 9:01:23 PM GMT+01:00, Daniel Golle <daniel@makrotopia=
=2Eorg> wrote:
>On Tue, Jan 02, 2024 at 08:33:32PM +0100, Eric Woudstra wrote:
>> [=2E=2E=2E]
>>=20
>> So if phylink_mii_c22_pcs_decode_state() should not set the speed, then=
 it is not correctly set somewhere else=2E
>
>Yes, but the fix should go to pcs-mtk-lynxi=2Ec and you don't need to
>change phylink for it to work=2E
>This should be enough:
>https://patchwork=2Ekernel=2Eorg/project/netdevbpf/patch/091e466912f1333b=
b76d23e95dc6019c9b71645f=2E1699565880=2Egit=2Edaniel@makrotopia=2Eorg/
>

