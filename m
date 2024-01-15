Return-Path: <linux-kernel+bounces-25998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDFA82D990
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19EB828204C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3523317548;
	Mon, 15 Jan 2024 13:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7BXAm1Z"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F60171CE;
	Mon, 15 Jan 2024 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-337abfd6151so354466f8f.1;
        Mon, 15 Jan 2024 05:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705324169; x=1705928969; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqciNHiwX5Xpe9HUhoDTBRkSyWdUM5unYCkQrW8mDZo=;
        b=T7BXAm1ZKQM4MlPZ5I41/fslMSZjcmVPyKJrnpA4IZV4ieG3GWzR++3wQNm3/KxC++
         XriUX68TqPhis+B/03djNGPtGeRA14O2AvAvsTumAbEskwjkhlMAzUJViKMaafTOpmq7
         ua5v99bFtt7ZYqeAH4s5Yq+mNv4auTqL1BIcg0xsTfVTrEvb/tbn8J6Vdt+mS71bkUci
         ocEEwhW5CcANXn3UW5zMxzcGaok4VTfo+4TzkKP64MEOLVoiEakOOUugAo2F0++zIw/X
         t2xZucBmgAjCKUc9OOKCerArHlg8HqYDGWLtJfTKhQsCGJo8rlQkVLDnmhEF4qBr23Ij
         Q45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705324169; x=1705928969;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xqciNHiwX5Xpe9HUhoDTBRkSyWdUM5unYCkQrW8mDZo=;
        b=e+pg1Q6U96CFpcEkn58HZPqCkYm6ScRrpoyzaaXfoRdU/1k86pgK//CogaSTpueFCd
         r6ySxwBklM+gSzERMUvL/z4Uc8QoUqKSx2ge7Y2ZT2Qig+nG6bNS6x9kBsgx/2zd7W8E
         ZA7xs9hzxU9G1Q3lg3DIKliN33Gn42NOv4Xe6GuvSel25uvewGsF/kFyYYnDkZvDlw5R
         uJvm5GuREx6dZz1AuMFKaZkpmDCNaKMKpGRPKPz3pFpkOJvMmaEzmE10bEqm6Es1za90
         ZjRjsjK442Jinps6b043FskR9z33rsgKlxuta1UW7xihkZ155b48zqNIUMB28yHjhG07
         +UgQ==
X-Gm-Message-State: AOJu0Yw0Oj8KdalRRQ0GuQ8Ykzd42SC/nfaufegSOJCdejsXOTspQ6PR
	pZRzbrbXgotZoot28C1qDiw=
X-Google-Smtp-Source: AGHT+IE3Hcks9ZuOLGbttyuv2aHArfvLfRvJchXNZtRx7ewfjtOLGEBT8LxfluFLjDM8Gk5c+eFnvQ==
X-Received: by 2002:a5d:420a:0:b0:337:9015:ab4b with SMTP id n10-20020a5d420a000000b003379015ab4bmr3610104wrq.108.1705324169004;
        Mon, 15 Jan 2024 05:09:29 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id d16-20020adf9c90000000b003366c058509sm11850615wre.23.2024.01.15.05.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 05:09:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jan 2024 14:09:28 +0100
Message-Id: <CYFAYRP5MWTZ.Q272WWLLE7MW@gmail.com>
Cc: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <ath11k@lists.infradead.org>
Subject: Re: [PATCH] wifi: ath11k: fix layout of scan_flags in struct
 scan_req_params
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Jeff Johnson" <quic_jjohnson@quicinc.com>, "Kalle Valo"
 <kvalo@kernel.org>
X-Mailer: aerc 0.15.2
References: <20231127180559.1696041-1-nico.escande@gmail.com>
 <bdcdbd06-e9bd-4a92-b27b-d94b2d8fb52d@quicinc.com>
 <CX9YPUDTAT1N.23DMRB5O9FEAO@gmail.com>
 <20c7a367-2243-4e13-b023-9999dc6c6790@quicinc.com>
 <CXC03GYAN4VN.2PQ88Q1S7IL6H@gmail.com>
In-Reply-To: <CXC03GYAN4VN.2PQ88Q1S7IL6H@gmail.com>

On Thu Nov 30, 2023 at 9:24 AM CET, Nicolas Escande wrote:
> On Tue Nov 28, 2023 at 1:57 AM CET, Jeff Johnson wrote:
> > On 11/27/2023 2:54 PM, Nicolas Escande wrote:
> [...]
> > > So either we should not use WMI_SCAN_XXX with scan_req_params.scan_fl=
ags ever
> > > and only use the bitfield to set scan parameters or if we use WMI_SCA=
N_XXX with
> > > scan_req_params.scan_flags they need to match the corresponding bitfi=
eld.
> >
> > IMO the correct thing to do is to remove the unions from that struct an=
d
> > only leave behind the bitfields and not use the WMI_SCAN_XXX masks
> > except when filling the firmware structure.
> >
> > But don't spin an update to your patches until Kalle has a chance to
> > give his opinion. I'm new to maintaining these drivers and Kalle may
> > have a different opinion on this.
> >
> > /jeff
>
> No problem, I'll wait for Kalle's input on this before doing anything.
> As soon as we decide which way is the right way, I'll work on this. I onl=
y care
> that this gets resolved.

Hi Kalle/Jeff,

Any new input on this so I can move forward on fixing this ?
Otherwise I think I'll end up going on with Jeff's proposal of only using t=
he
bitfield for intra driver representation & then converting the bitfields to
their corresponding WMI_SCAN_XXX when transmiting the req to the hw with wm=
i.

