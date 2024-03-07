Return-Path: <linux-kernel+bounces-95293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7642C874BD9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C571C216A9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF6E1292F8;
	Thu,  7 Mar 2024 10:02:43 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CC01292D0;
	Thu,  7 Mar 2024 10:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805762; cv=none; b=gHKbAver9rHQhBYLiMxFF+sDHTCHuJ99khOtQ51gvpL2cJgGMrl2hz5Wehue7R7ZvHk6/Dv4g0vdp49XF+OQLCFQPHAuCH7+S9VMu/EGpUGTcWE3b9PP2rZffjUj2lpVjJFGlEmKEh+6nQUZP/RZdyh+LEbg0rQkdPAo9kwuj54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805762; c=relaxed/simple;
	bh=4NC0Qo2hrLn888EeCIdL7zEtwPJPyxkaKIZ100gYQJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E51/QossCFvEWTSVlUwVFvlIr137sT0Y+KX9qsUcBUss8SHgGWrNdHIzj0c+k6VOLFXEw2IWzGYp/mlmexMGwWXGxdwKNATkF0QbYdDi/9MyOhBLnAAED6wDgePYY7vjvKJ7Rio/LGMxjTEk+aUMLcEAfL7PQPOveWlZwjOnXVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c01:4970:b7c4:f23e:200b:4ae6])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 229227E014B;
	Thu,  7 Mar 2024 18:02:26 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: dmitry.baryshkov@linaro.org
Cc: amadeus@jmu.edu.cn,
	andersson@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	konrad.dybcio@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: ipq6018: add 1.2GHz CPU Frequency
Date: Thu,  7 Mar 2024 18:02:21 +0800
Message-Id: <20240307100221.709254-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAA8EJpp++=NLZVv7we3Cwz+G7vL9xFoXqHgsMyQZ8tgdNHKcyQ@mail.gmail.com>
References: <CAA8EJpp++=NLZVv7we3Cwz+G7vL9xFoXqHgsMyQZ8tgdNHKcyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGB9NVktKGR8dTEpLQkwdTVUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0pBT0JMS0EZTBhPQR1JSB5BSUtLGUFPGh5NWVdZFhoPEhUdFF
	lBWU9LSFVKSktDSEhVSktLVUtZBg++
X-HM-Tid: 0a8e185d38ca03a2kunm229227e014b
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OiI6ATo*TDMVPDksLT8hKh4J
	Tk0KFC5VSlVKTEtCQ0tOTE9NQktDVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0pBT0JMS0EZTBhPQR1JSB5BSUtLGUFPGh5NWVdZCAFZQUpMQ0I3Bg++

Hi, Dmitry
> So... Do you consider this SoC to be IPQ6018 or IPQ6000?

According to the chip silk screen, this is ipq6000. In addition, I have
never seen a board with the SoC chip silk screen printed as ipq6018.

> And anyway, this should be explained in the commit message. Otherwise
> anybody reading the commit will have the same questions as I do.

Sorry, I will explain this in more detail.

Thanks,
Chukun

-- 
2.25.1


