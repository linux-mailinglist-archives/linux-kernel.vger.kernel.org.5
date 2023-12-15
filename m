Return-Path: <linux-kernel+bounces-325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A084C813F66
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B11B283EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD2CA34;
	Fri, 15 Dec 2023 01:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUdsPdk3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AB720E0;
	Fri, 15 Dec 2023 01:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-425baafa3c3so1409771cf.0;
        Thu, 14 Dec 2023 17:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702604791; x=1703209591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dVWHvDHZz3AvJMZltvNUlCGBm1+VXWDUHdZCGNSWeV4=;
        b=iUdsPdk3tlUeE+LQ9ha/na4pcCIjp8iDDa4szqTS2AFOJS21llIosh+t2RajE9DvX/
         Cwhl3yOTAdzodPgk8rPW7qlZWYUpzysxlLCmI8UBPtvW46oBtjQUORsXcDjkGhZoNVie
         9Et5lXCx5LgLhXbThIskD01eNtU3OYuRR8Cr6ZhBnxudkpcyqvS+DtPAc/oSi7NckKXJ
         7SRAFJXOOfU8op11BfiFJ6n6qber3JGVq88eAUEpQvdx8c0eF1Xzbruv1BTCg05khT8V
         SchPUAFxZgpiBUMHkf1197hcVDAoLrSYtvbMxErcvFTr70bgUgc0WYDVFtGW8ONg5KK3
         s4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702604791; x=1703209591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVWHvDHZz3AvJMZltvNUlCGBm1+VXWDUHdZCGNSWeV4=;
        b=ox/SLj4RLV9nZ6knZCSrJngsCfQNkltHMR316H8PgvMXyK9Px+6ilmTdXrf13YPN3Z
         OP8TbQF8iOe56V6m98ktrZrJD2hFGDdFbdzGvPJTAz1KYnYWn0C1eBWuXf436K7JIX3U
         7M+4ZTNCm3BY/ats4NWiQbo/EQzjEgufth6aS+d+pCS8SqoCYL7FA7zwmFEwf/iaYO6f
         QXX8SEnvgK2IC3DTq5QNpUvHJ8L3tSRdrOCKSDJKBDBIrWfsm57VdriUnkM2e9zxDL8F
         4h+Bqf7vNEwuborplp3DN8JqoqCSmw8jUsZE02OinlSDpZJruZiZgSbM5nTFS7ImIfBE
         ZRMw==
X-Gm-Message-State: AOJu0Yxi4EUC3mB178rFeM/D6SW3S8kYARXftxNfIMsNmoo4SaLRc85a
	QBFxv1/MPz3k+GOuXiscfs3P2Nrn7goJGQ==
X-Google-Smtp-Source: AGHT+IGuWqtIDX/gQoLrm4a1Y3PUAD7mxodkVbztEA+x0E/VQdQrJnxhZjSGkZYHCzPIRgoBu2dNKw==
X-Received: by 2002:a05:622a:28e:b0:425:a84d:bccc with SMTP id z14-20020a05622a028e00b00425a84dbcccmr14695740qtw.137.1702604791271;
        Thu, 14 Dec 2023 17:46:31 -0800 (PST)
Received: from localhost ([2607:fea8:529e:7800::a768])
        by smtp.gmail.com with ESMTPSA id c12-20020ac86e8c000000b004255183b1a4sm6209114qtv.64.2023.12.14.17.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 17:46:30 -0800 (PST)
Date: Thu, 14 Dec 2023 20:46:27 -0500
From: Richard Acayan <mailingradian@gmail.com>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm670: fix USB DP/DM HS PHY
 interrupts
Message-ID: <ZXuv8zgm4kl3fwZV@radian>
References: <20231214074319.11023-1-johan+linaro@kernel.org>
 <20231214074319.11023-2-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214074319.11023-2-johan+linaro@kernel.org>

On Thu, Dec 14, 2023 at 08:43:17AM +0100, Johan Hovold wrote:
> The USB DP/DM HS PHY interrupts need to be provided by the PDC interrupt
> controller in order to be able to wake the system up from low-power
> states and to be able to detect disconnect events, which requires
> triggering on falling edges.
>
> A recent commit updated the trigger type but failed to change the
> interrupt provider as required. This leads to the current Linux driver
> failing to probe instead of printing an error during suspend and USB
> wakeup not working as intended.
>
> Fixes: de3b3de30999 ("arm64: dts: qcom: sdm670: fix USB wakeup interrupt types")
> Fixes: 07c8ded6e373 ("arm64: dts: qcom: add sdm670 and pixel 3a device trees")
> Cc: stable@vger.kernel.org      # 6.2
> Cc: Richard Acayan <mailingradian@gmail.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Tested-by: Richard Acayan <mailingradian@gmail.com>

On a Pixel 3a, plugging in a USB cable doesn't wake up the device
(presumably because there is no wakeup-source property) but this gets
USB working again on linux-next.

