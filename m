Return-Path: <linux-kernel+bounces-14362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA17821C18
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C98F1F22A04
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2838F9C4;
	Tue,  2 Jan 2024 12:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFT2wqWO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9332F9C3;
	Tue,  2 Jan 2024 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d9b5c4f332so1788848b3a.3;
        Tue, 02 Jan 2024 04:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704200135; x=1704804935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+6zV12XTifi7kUx3OOAHC6KwNMFaqKkolPFrVGczEkk=;
        b=SFT2wqWOkraaELTMR/aEthoiDuaxnHaZeK/zkcrRzQCRM1YsR7ErUW0IeR9fFQm3b/
         CW4jjOUNih9Rdi8NAF1688rmziCOxwhHJsvkazWZ+yJWEPN37p2aQT0CxJZM2z4NC0zx
         qHXeGIOSuhYjpzxUzF7qKK9Q/trsP6JzQ9tmAxVBcy9MZix5MfdvIKZyQU1ooza3mzeJ
         L+q5LE0pY/z52we7ucvcaQBv8xqouzmpGhkrr7IRwM5X8yKKj1XBuy69YxcrBD0JMrSr
         g+w/0DgRbSRfsaR0cE6YKDsQHDdABXYfXQ23BBJQZAJ07SGUVnYElyqpjctHj1jtfIxw
         3bxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704200135; x=1704804935;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+6zV12XTifi7kUx3OOAHC6KwNMFaqKkolPFrVGczEkk=;
        b=JnVSXNvxJAOw9RwSzhSCsD3hCe2wxixizzbxDac+/VLgYvCC0Z4x46IhSRQT9sBVP5
         p1+Y27uK7GnNNdFIsiA+zIp0YL5i4D+c9/+eWlGVXvG4ehrhLsJQvr5VVQkblF5E6HvG
         belykfbi+LJwyGPtDCUeBTvLZOyB9J1ZNbiM2I1m4X237GyKRIg2NbHLewyfiouZt7vN
         QnWAUqI1YluSAwpUPZO+/uZvGfJe03pI6WkzWyAV3TVVjCyhGx8XkJ76qo+SL83mf4Tf
         isyPYzjdyFZeB4yUMpymmrRuHyPVxRhIkYrXXRx4TZYALxuGjpaCdN0bzhY1VJs3mq02
         qTrQ==
X-Gm-Message-State: AOJu0YxHqwTbCSzagS486jNMB81Anl1Ge/WWQp3eYTlnj1pimdi42Q1D
	R6d67j69A++oe9JTRkVkI4k=
X-Google-Smtp-Source: AGHT+IFRCZojliga3N9ozWGn5Eayce7SFrQ/owylc0cKJuk3qq2nb7v1hWLetkyhKqOrD4ap5xRY6A==
X-Received: by 2002:a05:6a00:4505:b0:6d9:a0da:4fbc with SMTP id cw5-20020a056a00450500b006d9a0da4fbcmr7360079pfb.36.1704200134866;
        Tue, 02 Jan 2024 04:55:34 -0800 (PST)
Received: from [127.0.0.1] ([89.205.132.224])
        by smtp.gmail.com with ESMTPSA id w37-20020a631625000000b005cd8bf50c13sm20655512pgl.58.2024.01.02.04.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 04:55:34 -0800 (PST)
Date: Tue, 02 Jan 2024 13:55:33 +0100
From: Eric Woudstra <ericwouds@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Alexander Couzens <lynxis@fe80.eu>, Daniel Golle <daniel@makrotopia.org>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_RFC_net-next=5D_net=3A_pcs=3A_pcs-mtk-lyn?= =?US-ASCII?Q?xi_fix_mtk=5Fpcs=5Flynxi=5Fget=5Fstate=28=29_for_2500base-x?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZZP9GR15ufDbjGAJ@shell.armlinux.org.uk>
References: <20240102074408.1049203-1-ericwouds@gmail.com> <ZZP9GR15ufDbjGAJ@shell.armlinux.org.uk>
Message-ID: <92190426-3614-4774-9E9F-18F121622788@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

>Please describe your setup more fully=2E What is the link partner on this
>2500base-X link?

I use a BananaPi R3, with the oem-sfp2=2E5g-t module=2E It has the SFP qui=
rk that disables autoneg=2E I was trying Marek's rtl8221b patchset, but fou=
nd that even with unmodified code,  original net-next unmodified, I could g=
et link up, but no traffic is going through=2E

On the other side is a=2Erock5b with rtl8125b=2E

Only after applying this patch, it works and eth1 reports link up with 2=
=2E5Gbps instead of unknown speed=2E

If you need more debugging info, I can supply it at a later time=2E


On January 2, 2024 1:10:01 PM GMT+01:00, "Russell King (Oracle)" <linux@ar=
mlinux=2Eorg=2Euk> wrote:
>On Tue, Jan 02, 2024 at 08:44:08AM +0100, Eric Woudstra wrote:
>> From: Daniel Golle <daniel@makrotopia=2Eorg>
>>=20
>> Need to fix mtk_pcs_lynxi_get_state() in order for the pcs to function
>> correctly when the interface is set to 2500base-x, even when
>> PHYLINK_PCS_NEG_INBAND_DISABLED is set=2E
>
>Please describe your setup more fully=2E What is the link partner on this
>2500base-X link?
>
>In PHYLINK_PCS_NEG_INBAND_DISABLED mode, this means that phylink is
>operating in inband mode, but Autoneg is clear in the advertisement
>mask, meaning Autoneg is disabled and we are using a "fixed" setting=2E
>state->speed and state->duplex should already be initialised=2E
>
>> When the pcs is set to 2500base-x, the register values are not compatib=
le
>> with phylink_mii_c22_pcs_decode_state()=2E It results in parameters suc=
h as
>> speed unknown and such=2E Then the mac/pcs are setup incorrectly and do=
 not
>> function=2E
>
>Since Autoneg is clear, phylink_mii_c22_pcs_decode_state() won't
>change state->speed and state->duplex, which should already be
>correctly set=2E
>

