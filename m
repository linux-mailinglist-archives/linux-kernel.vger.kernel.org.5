Return-Path: <linux-kernel+bounces-27233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4892B82EC81
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D393B283648
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75765134C6;
	Tue, 16 Jan 2024 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzVsly4o"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A761F134AD;
	Tue, 16 Jan 2024 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-58962bf3f89so1288487a12.0;
        Tue, 16 Jan 2024 02:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705399522; x=1706004322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gK8XCEg8PjR2WLHbcaqzG/kF7LkZPky9tvtMV+e2/74=;
        b=CzVsly4oUmeIH97x0vN0gN7yuz6IePvhLtpCPjjik/jjJY1ntRiBe3bBCvqTjHmcPg
         DFsJTtULoYgxiC16BDeVUvQGRbM9yWoaOUtUsqkwQ5IpBzoFn5TWVYSV15/yUEyadZBz
         AHf2UJJt0XOn+ViNn7RWTA/7PKRErIejpw+ejUPuc29bpx5LqCjqjGuDrPUvWizEb/xJ
         ZRaqe6uRORfSB3mZBQH6ixUKmfl1HtjmFbQ4kisxqpQ9G6T6++F08Awjz9/WmqOcfj+W
         KdFNMSlzckT8XVJBnDka4jgOy4Dg1gUwiDopLRBrFHFY/mF+q+kA9LlkiW0iDxzgMQ9q
         YS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705399522; x=1706004322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gK8XCEg8PjR2WLHbcaqzG/kF7LkZPky9tvtMV+e2/74=;
        b=VoWiIE/xrs4bm9EnrE5yb1kepHcFHktIT4Q0dC4Si4rrS2J7f0x8zbIuyjGCRL8dmg
         bcm4oD8mONFYSEjKfaYFL2fAXRqQm8yt//9USMIoVCg3jDPUrdLMO2YYvsy63olFwzZt
         9tgUsoRIZsC22NQVgbU4x3e8CHTdTHMaLCway2T0MT+gEDA0zwj3doePYxqDSvO5ARG5
         sogWKDSn4D3+liYzHm4SsITGNqjJUri5wqucMLIqgXSR9tzvtQtVlzbim8BXWX185oVZ
         n14NdALoKQ0rZ7GrIfXthT1ftH5ei2/hZ2MoTJs6M06DGAejJlEZwjjRKgAQRo9C194t
         6pkA==
X-Gm-Message-State: AOJu0YzVhGJ3LYVgMfbqiGGZcrEo8hWgHe+liSi7ouVlXmVLuhi87C9O
	pVWSmLRqKsIJ+RRxZzQmPM0qa/Hh4hFqwEDLmI8=
X-Google-Smtp-Source: AGHT+IF4ymp/p+7TFDADsct4+54sD0EvnPWvTuV4cyjWSS1OOSbO+LWGXaNZt2L3QMpJzn6B7PlQnCGq3B5zvpZFzOc=
X-Received: by 2002:a05:6a21:6da2:b0:19a:49c8:b9e6 with SMTP id
 wl34-20020a056a216da200b0019a49c8b9e6mr14684200pzb.0.1705399522040; Tue, 16
 Jan 2024 02:05:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220113857.1127598-1-kshitiz.varshney@nxp.com> <DB6PR04MB319097FF0EB342BA7B17E4D78F732@DB6PR04MB3190.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR04MB319097FF0EB342BA7B17E4D78F732@DB6PR04MB3190.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 16 Jan 2024 07:05:10 -0300
Message-ID: <CAOMZO5DYT6Ea7nSKe8pPdWH4gS=d39mPRSw6=yCaPXS=XW674w@mail.gmail.com>
Subject: Re: [PATCH v1] imx_v6_v7_defconfig: Enable sm3, sm4, polyval, xctr
 cipher test support
To: Kshitiz Varshney <kshitiz.varshney@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Varun Sethi <V.Sethi@nxp.com>, 
	Gaurav Jain <gaurav.jain@nxp.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, 
	Sahil Malhotra <sahil.malhotra@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>, 
	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>, Rahul Kumar Yadav <rahulkumar.yadav@nxp.com>, 
	Nikhil Singla <nikhil.singla@nxp.com>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 6:59=E2=80=AFAM Kshitiz Varshney
<kshitiz.varshney@nxp.com> wrote:
>
> Hi Herbert,
>
> Gentle Reminder.
> Please help to merge the patch.

This patch goes to Shawn's tree, not Herbert's.

We are currently in the merge window, so this change will likely be
applied after 6.8-rc1 is out.

