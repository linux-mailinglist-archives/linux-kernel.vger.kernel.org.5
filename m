Return-Path: <linux-kernel+bounces-14345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79362821BA8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E23A1F229A8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22561FC08;
	Tue,  2 Jan 2024 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvdeHMIc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08692FBEB;
	Tue,  2 Jan 2024 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55569b59f81so5038530a12.1;
        Tue, 02 Jan 2024 04:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704198681; x=1704803481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IHPc3b2HWDj64ive1dxruS27O95C6egAy0HbP5aoRrw=;
        b=DvdeHMIc4wrZkr7gWFy6/OQkuTGVtI9nKIAPbNdbqCKp4MD1ENgmy4rMd9oxonKkxt
         tUxTbZ87Gj45sYV2VGKi+4zkAQjxgk+VkPLgS53/xqGh4ihtPnPO9y2MWiW22dlL55xo
         Ad+CKttGp4qygdpqHk+uFwtz0puizCMXHfDz9NKFYOP8g6W4u/P3nGaIW4cfj1xZNNTI
         mfu8Nr+HDpyfo26MI9bmakYBmm9UOx0EKVsIV06SIbtEn5xsfFfkJPOtoSYXCFP1Oak3
         rEmCc3IKm8FOqtsUpQzmuXcaGIwEtwDD4MDTaRmsJwSYhjrh+K7gbyNUzEchmmxT++en
         IrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704198681; x=1704803481;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IHPc3b2HWDj64ive1dxruS27O95C6egAy0HbP5aoRrw=;
        b=aCnmdQEk28vtb8Y9oPd9SwfWDOw2VFRlA7XoUuzlmApKD9EiMM2Uu990cqizoYpjxj
         nKSDfLUdczSOmoSDyDlKa96BOCKiyhGg/yQ545GExsMaVT3aeY7cwe6E7ks76pbX5A0T
         GyGkJNIBK7ya1fMNYugTp6L95LOcy9xOJfW1j4tHI5EkJ1cCHHkBNkDHwL0X1YdRuxbJ
         n7SgOHTIarkpgVf56Ys37ImS3NNRIC6cAMyyysy2We26pp5z03NPnjUc03K21f0eDc8L
         7DvFP8ZZSb+Gkfg+qJ3ULWdEs0HHqZzCIko92LbdoGcGUWXyg8jWqSWhuquy1FXa/2d5
         OkBQ==
X-Gm-Message-State: AOJu0YyWHRxdWOS2ei1zde9YwvHxP/bxdIuUoc9FkNToBcTQxS1iEV6j
	aSEFc7+ZwCeE3qSsd79dS7Y=
X-Google-Smtp-Source: AGHT+IE5nNxiH4N4H3XYyngTXfeHYH+ZvpvSr+ySRPH/c+vEoh8xCXMubbqgN3AcbmawlQeXuAC8Xg==
X-Received: by 2002:a50:d01a:0:b0:555:485:4e32 with SMTP id j26-20020a50d01a000000b0055504854e32mr7006623edf.10.1704198681288;
        Tue, 02 Jan 2024 04:31:21 -0800 (PST)
Received: from [127.0.0.1] ([89.205.132.224])
        by smtp.gmail.com with ESMTPSA id dg24-20020a0564021d1800b00552cf686df3sm16033923edb.52.2024.01.02.04.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 04:31:20 -0800 (PST)
Date: Tue, 02 Jan 2024 13:31:21 +0100
From: Eric Woudstra <ericwouds@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
CC: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_RFC_net-next=5D_ne?= =?US-ASCII?Q?t=3A_phylink=3A_add_quirk_for_d?= =?US-ASCII?Q?isabling_in-band-status_for_mediatek_pcs_at_2500base-x?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZZPq8iMAv3eR9Gfk@pidgin.makrotopia.org>
References: <20240102074326.1049179-1-ericwouds@gmail.com> <ZZPq8iMAv3eR9Gfk@pidgin.makrotopia.org>
Message-ID: <D80A9D3C-6A86-4004-B575-46A980D8BA3B@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sorry,  I'm on Android for now and have trouble find a suitable cli=C3=ABnt=
=2E This should have no http=2E


Anyway, I see now, I had another version which I should have send:


+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (phylink_major_no_inband(pl, state->interfa=
ce) && (!!pl->phydev)) {
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pl->cur_link_a=
n_mode =3D=3D MLO_AN_INBAND)
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pl->cur_link_an_mode =3D MLO_AN_PHY;
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* restore mode if it wa=
s changed before */
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pl->cur_link_an_mode =3D=
 pl->cfg_link_an_mode;



To prevent it from toggling all the time=2E So I do need to spend some mor=
e
attention to this part, cause this also may not be 100% ok, if changing=C2=
=A0
phylink core would be done=2E




The reason I do it in phylink, because of changing to MLO_AN_PHY when
there is a PHY attached=2E mtk_eth_soc would not=2E Be aware of PHY attach=
ed=2E

So that's why I've opened the rfc=2E

See which way to go with this in an acceptable way, preferably using MLO_A=
N_PHY=2E


