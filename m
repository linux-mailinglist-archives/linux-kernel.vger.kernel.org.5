Return-Path: <linux-kernel+bounces-14393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7F3821C72
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41731F228F7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E697AFBE7;
	Tue,  2 Jan 2024 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCyy2/ST"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12ECDF63;
	Tue,  2 Jan 2024 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5534dcfdd61so16006082a12.0;
        Tue, 02 Jan 2024 05:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704201374; x=1704806174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ymg1RUEbhaahilNTpT76VrpoWo6TTp5cRA3gjAaiXis=;
        b=DCyy2/STQPFP5336+P1FTgcizPJocVBrFMoUWlwpEKyo5IDYQBw7yyd+5CIlPU0pUe
         9AmgS3vvxfavOtd3gV0jI+asrwtHbaJ1ffgspx0tnzH6WQTtkVx289/1IcYMq8HsWP7b
         bVXYMXAiuHiDLz9SYwS9KePLlI6QH+lYEyGBbBi1OMLnEGwv+D7SeMYBmfy+JPW6Y+yL
         4UnrfmEDa4X7Kkyq1imrHZnx/DAS3PoDJAc4wzz7+BCRrK8BpmPjDpOeUKTvzLbvn4SA
         9hWLvasaR64qgQF+tI1DedjHnzvqMbZOGhcV84hWzWB4AwHoWyX9KOxarE+x7PSkQbP/
         Zcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704201374; x=1704806174;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ymg1RUEbhaahilNTpT76VrpoWo6TTp5cRA3gjAaiXis=;
        b=P/UhkvPA/7OFuAuj9pDCmyr67E60EpRG1t98bSKJoOn5zxVDCr5/cfNU6wC3SwentX
         5azMJc52Agd8dKPqXdcX56sh4F7u6aXPJ1VZxQoFGXOtQbxRRU6+qR1K3tx0CVWCqDso
         gQ3URKSNAqrSCfQ4Ij1o/jwYM1Gqtxv48RGKrnBzkto5JplaJ1RspOjq78atrBNztRrv
         BKnInSyg90AD9OKJkUY0qAYWouXHBB4HDf3UWmc4DUM6BQdjag9qyWoVW46r+ve6/kyb
         6JfpQ3Qf8lP2VatXx6D3JkmKNBUR+UGzTxYLhxRmivysosOBvCTjp2vSmO3+CH2ALcGO
         b00Q==
X-Gm-Message-State: AOJu0YwPDTglbUzOaeAjMPPwu5bHxYGSba53zt8a250L5SRLIAj+Wjjw
	S4LIzujNLz3p6OkSESvscNA=
X-Google-Smtp-Source: AGHT+IG6FQg0SPLjELmusCQ1pxaKN/Jc2EfCRw64reeXapXoPt86R09+3G6WZl7C8LMxW86E2RUbhQ==
X-Received: by 2002:a05:6402:268b:b0:554:c9af:a66e with SMTP id w11-20020a056402268b00b00554c9afa66emr13601900edd.9.1704201373893;
        Tue, 02 Jan 2024 05:16:13 -0800 (PST)
Received: from [127.0.0.1] ([89.205.132.224])
        by smtp.gmail.com with ESMTPSA id g20-20020a056402091400b005551b2f66f0sm9627874edz.43.2024.01.02.05.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 05:16:13 -0800 (PST)
Date: Tue, 02 Jan 2024 14:16:14 +0100
From: Eric Woudstra <ericwouds@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_RFC_net-next=5D_ne?= =?US-ASCII?Q?t=3A_phylink=3A_add_quirk_for_d?= =?US-ASCII?Q?isabling_in-band-status_for_mediatek_pcs_at_2500base-x?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZZQDWzYlxAKl0JxI@shell.armlinux.org.uk>
References: <20240102074326.1049179-1-ericwouds@gmail.com> <ZZQDWzYlxAKl0JxI@shell.armlinux.org.uk>
Message-ID: <A660847B-FEFF-4AE1-809B-F0A6EBE2A52C@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Since using compatible is not an option and in and 2500base-x is hardware d=
ependant, then I was thinking this would be useful=2E

bool pcs->ops->supports_inband(interface)

I'll be happy to invest some time in this, but I'll need to know which way=
 to go, before I invest more time in something that would not be accepted=
=2E

