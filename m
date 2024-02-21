Return-Path: <linux-kernel+bounces-74682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2F185D7AB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151FE1C20E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BD44DA09;
	Wed, 21 Feb 2024 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="VD03rScy"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760554D5BF;
	Wed, 21 Feb 2024 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708517164; cv=none; b=KuwFr2IPYw1LxH3BTVgDMZCo0JGLPdSOBp9R9876QdXATMry9UhDTcMugdTrxJ1+2IUsdKr2D/xNn2SFIpCOkYy8bC/yr1HCft/hEMT6vq/oeC2fbTYVhtl261IMttc04VChcCzpgjiEzTToaZg18uQd9mDTY2pNr4Z1F01g0eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708517164; c=relaxed/simple;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=lIeNuzZcNNTgbEOst9yDkeZ8DFUTzMTUmvVy7ZQ/DCf4dODauiY+8h/c3qEwtzc7gIqIbHU8RyTbNAOkEk2tIOBoq5R9l8M2IywNSPMrtH+2xQDLKn47C+wx/iWk5Y9aC9M6iD2gbdQRXNbxxO4Pgt3H9i4qcVq8NCzRYjScQiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=VD03rScy; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708517160; x=1709121960; i=rwarsow@gmx.de;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
	b=VD03rScywyrnRYRSETMyas+9ftIe1rqjNECJ0BpQ4iL+B4B+LTmBsikonrmgEstO
	 btNoFq55Vkp+ys4hBwAIeaaw5s0qsv8GYdaISkX6NPMZvzVzfYLq6EYXYfMNlFnLM
	 HzLvtxcfo1+TqLMQd90xIgl4kSKXW4GU1j1/Ewo7zLAhx+D5bwHhiuYPFUCVTZVTx
	 B0ehKeQ/K5Afz892/kUDpXU0UCpII5w5mJcnKxo/he21LR5RHCahDidzNDSe6Eaoh
	 eXKD8dI02Ahz474vv0oJ52IhwJbZqq3jghvve/UYHQ9qo3Yl61NM4AtkUtOzSw81X
	 XRsFla6jCOTC1mVGeg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.35.10]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK0X-1qlU7K3hD7-00rJxN; Wed, 21
 Feb 2024 13:05:59 +0100
Message-ID: <b4cf6d40-ddbf-40a1-9e1d-80bc68858986@gmx.de>
Date: Wed, 21 Feb 2024 13:05:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.7 000/309] 6.7.6-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1F41U6LtYvwF+XCim1XPIMsr9/chDsvloTSec0wckoh6WWUxYYX
 2bSmA/T4StRppr/z9ZDW6xgzlSy7kT07PCQn0R40AvAYCFfKpNXX+lk8A3dMjNZlgI4JsaB
 XKI0p6XaSa7supTJIGttqsU2g3wfFF+cB9yYN/Ys9OD6h1qLjaLmOl7j5SQeA+Vdb2eE4uO
 EfHc8wFn4HDcmrXNLykCw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+kuus7Yn9ec=;UrbhiPRpZnP88PR0gyQn6VbrMvA
 x3HgIwuo9FounUVty0xqTaSD7UE/cl+0XSGLDdz8PZ/khzC8M4YrJkMcqRSUNHOzTOwsckcM+
 sKleT+zHK1cM7oe5JpZZWBmHgXc/Iz4UBaRmOlOdiQH2NZZNlLzldXdOM/lnh3uDrAdrq8ByM
 T0iQNo01F6so6Fb0X7hS5P1VQ6ssJIg8vO59mxWSSB4TpaP1jjYlJypeSV+a4YSC5mz3y1hPo
 jViCFNgd+C3u3FLjVax2tP+U2mTuxuWS3FfqKerGrC6VnnFE+Ssp7zBBJdbNWQ/zYCabpG6G0
 v2mZZiWsGoIWzSiMxFMoJiERBmb3YMhW4LUwHSVDl7o5rnjSHldvcUIZZPsUZAuSO71SmfiHs
 cJtrfC+gUKL7caWTEXSGehrk0WeCQLcipFqUTUEtM3KIGjmC8+/cFYTB34MwiA0ohkwUCioXa
 LImgVaKgiNaPcDLnxVLdN4kZ/Uu2uh1030ZGhP9tgmU7O2uCHHYGo5roN2BgA3thoL37Y9ZzQ
 Wlii6ckHy+aVHKZBHdloL4bZxOG1aGA9ljyIH+K8zfDlnpiPf7v5GIFuQbtwTGYtgTiRxKi8r
 KXCnBrBCs1HhHL21c5lcIYWcqrz8B+iTKn/iKwGhf6cjIdlijRH63ecMgFN5a9u53OQX42KWs
 FFgRJWUEPi73kjK17GKI7UdMFxdAW07C3Y3dt0IITxRWm7jDCNLIbs6qQhqzsIkSdjnsv72+E
 aRsJV59SexHMf1cpH56+DGDk8nePHJMDkYn8HvaY1luw0ZV330ZJJmlfmsk+GwGkC9/C+Y+3S
 6f19UTw/V25ZSw3ntz3SVMaCxH+Bgn5FlFCZanPn9JG2U=

Hi Greg

*no* regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


