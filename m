Return-Path: <linux-kernel+bounces-146792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 597888A6AFF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2DF1C21777
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB30774437;
	Tue, 16 Apr 2024 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aWZ2HYuu"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ABE3D57E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270775; cv=none; b=Hr6xkaeCbI6EqfTK6iAFg2d0TzNCiqG31WVcn9NPmoD2m4R7EptpZ0LrBf6HtEH+QHZ1A1PSXo7U9qr/8uCt245mVI0Fvm/jZMSNHUEztDaJ3zdPBhgK6MmoYF2ACLZ8mHvvlvDNS0bzKXMJdkyyPTXQD5YMgA7+yPSziZNscNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270775; c=relaxed/simple;
	bh=WcNPnB4HdNSky7dJK2nRp1QylqwakQWWVq5Y9GzydZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUDZGnx4l1iUzKGL6uKnwoqY6C7H7pBruA6BGB/F264PmRmHyvBIp415uiCecxuoMh8LACRKOdVMLSS0fA3fZNEnmkSGLjyjSIq3EuORUxQnVgjroQ7YmlzWW3m2+MdGr6wZaZB3tGNJw6EFmkeO1YJTW9sG2QBzPApDPAF83JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aWZ2HYuu; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso4308202276.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713270773; x=1713875573; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M3gjlcT6yiF6TVvBdoS3jyFscagYLua1Wg9Qh4m5zmE=;
        b=aWZ2HYuuo9tRCH3lJt+1c8eGxdq9O2uMEnUS8VDM4lh+X4OpE0pc5DrGptyQ/SL0aU
         ey+I21mT5EXhsKKf13Tp/RF2dfSVyAMu4ZPqm/GDbm3zlkMkj/A2EovMzZYLSyQPiPPn
         k0YIP4xqQQBxK82/GXhDcSry4EOvVEnBR4VUXIeXr20hrauMgXbjqt7Lz8grwuy0O/Iy
         +Mb1cHLB7JgPnLDyogNZ3dfDw0msSfktakw49umGlchARC/GpvEAkhnkPquiCoXO6D6S
         QBJ8a8+jwSMNxM98OAxW7PZOfiKr/mbuitTqHKeMCaF/EVEp+oYvCobwExVEmaQZPKbW
         DjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713270773; x=1713875573;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3gjlcT6yiF6TVvBdoS3jyFscagYLua1Wg9Qh4m5zmE=;
        b=wjY39WtyvE0kYQFfCFVWkTfjRA4Emga2feyAFWOFT0WHTjV4pyv2B/HChAKk2rMDcz
         CqEo6wWCWhtoOidKTdIluQx/5vH3cvvxfQjhDAFNFIgMGr8l7+0rUEq106kn5EfzIXxr
         kLkyfSceZuOqByJgAs12EADrkPD+WLovWi7ViFsOw2pOfyB1VGMOWtmTxJMRdwo+Z0M1
         Bavd00xMJRzLtQtFBK4V4Gkf/oxyNLC5+Huj+sDP10N39oo0I8SU/mkfcp8AYpSL/+/Z
         zsRcV4wxezu818U+JSHdXaYIXn5w4eR+fhE7XMwUFj3Ii5VA0y0MEvtfschTy+oi6MvO
         R8/g==
X-Forwarded-Encrypted: i=1; AJvYcCXCbOZOiMIqV/L6F6yH9UqujfTeTQb/QlpKBPo0wWBTUKawAgf5AZFFqpslp+MFKrF9QH6GOcuACgRQWG937XAam3Tu9kfO+4vfKAF8
X-Gm-Message-State: AOJu0Yw7vqeWRUmqdzPgCeXJd0jyLaZqnRwl+1KPCz5w/Ncbq5K9Xgb2
	J80OMKsTJO/IZE7AcIo2KDTdLQuisFVcsDSgODiaiuJWhxvlr71gjzss4kmI53kBOFSp2bWd2PS
	sQln5oVkp/+LDgXNhZp/12fCC3qMyJPLpCP5ozQ==
X-Google-Smtp-Source: AGHT+IGXlRfeqmm+IcBo6jjagOdUCrT6bL4oGcafhUe0dWmfuVxrbx09Qjtn1cGnmNW53WyMGOZGUD2n/kFqx+9/OUs=
X-Received: by 2002:a25:ced3:0:b0:dcc:4b44:336c with SMTP id
 x202-20020a25ced3000000b00dcc4b44336cmr12963929ybe.53.1713270772932; Tue, 16
 Apr 2024 05:32:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416105059.1167-1-quic_vdadhani@quicinc.com>
In-Reply-To: <20240416105059.1167-1-quic_vdadhani@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 16 Apr 2024 15:32:42 +0300
Message-ID: <CAA8EJprzdhDvmZdVXdHEJHpNA_Pj3=77v=y41EajFVe8LmAOnQ@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: qcom: qcm6490-rb3: Enable gpi-dma and qup node
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Apr 2024 at 13:51, Viken Dadhaniya <quic_vdadhani@quicinc.com> wrote:
>
> Enable gpi-dma0, gpi-dma1 and qupv3_id_1 nodes for
> busses usecase on RB3 platform.
>
> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

