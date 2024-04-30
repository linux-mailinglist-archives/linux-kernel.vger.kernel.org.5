Return-Path: <linux-kernel+bounces-164036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFA08B7778
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F049A1F22C8B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F832172BA8;
	Tue, 30 Apr 2024 13:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="arbxL/P/"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0069171E64;
	Tue, 30 Apr 2024 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714484751; cv=none; b=MBEkNcdPtyr6pd5zHvKubrntIcSI9K8iZp7vELb836kPA4NlcLCESGYAs8eWIzyA9/5eb6vr1nNsO5KS5bMQMfTYuHjULJVQdzSRL74SDTH+k7R0V+Z8H2AxxTT7xNZ2Z1yGPBLjKBV8QUXdun+w5gESynv0f9cx4PIneFWrK+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714484751; c=relaxed/simple;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=YnC2q0VSWjldo77hvDOVOyCeqQ9a8MG1IMXdyyD+XbJUtSXC0imf41p5kkWUqvnLKWZID0PJzWAkgf8cYj3D8PIwv/UMoLQRiVANHW7yOxwwZVrMeHJcv76y1qj/Io2yAQIFylJ3+JcVQFThiLzfu83AkO275EbLgPAFDbLUmQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=arbxL/P/; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1714484746; x=1715089546; i=rwarsow@gmx.de;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=arbxL/P/2LBPMK9Os6x415aawKvW/PzE/MEO6yckZGzKQOXEJMzLXP1aRGfXbc/M
	 YgUmhQ00tZI3yrAT7bj6/IIQ6EirpzFQK/TSar25nWM/86QwiCwvSdxYDsLbEb0Up
	 tuMpQ9qGecJs6quRBUA5kEpSTUgoJv5x3zMomOCDYu/iZCUU8P/TapHkjpqL7dFNW
	 XsiKfTgUjtz5PbEolRBSUM8e+K7fcqT53NSdgEayuTpd6begMhGecE77wEmHkW28Y
	 GuNWiBG+K1Y67O73arO6kAbrn7dLpl/NFNkki23nFZthNZj4W9qWaCogMhbHYfFh4
	 ozXAC9qEL9kPoyMh1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.35.82]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtOGU-1swFGu0R1a-00tBhZ; Tue, 30
 Apr 2024 15:45:46 +0200
Message-ID: <e143067b-edad-4562-9b7b-95be662a8f63@gmx.de>
Date: Tue, 30 Apr 2024 15:45:45 +0200
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
Subject: Re: [PATCH 6.8 000/228] 6.8.9-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:FzGFpDCPsCJ7rsn2KuuaXLTqV3AFo5mq7pDQT2mCmfhyTSnZEej
 4q3UgHxkUCuROSA9U3c2OW47H00L8nVjj18YNZ2dKC3Bc2pzx5twbfIgVg/pZ6K8BbVJnnd
 /Sdq4yEIZxGozTch7PH6tLZZHyORjvujCu1vFJnkMSuErH/Rx4ZAtGNbdVnzCBZiXWh3ZJr
 AlNnkSB4+oqaox2W4ER0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LdHmpgobswk=;/u6wFfrl/vupy6pV+tD10zDawh9
 zoO4ZOK9zP2Xw4lbAZt72desnQI5wSZHTm4E54ksqBJaMGNzlPsKYVk17G0WWzRDQrkzqztuP
 xERB55ChXGetX8GiddKZoxEZgM7UJxenUoXRgeE+H6gbatl4v5giO4JnTWzw5OSPgyIljoBhl
 yiuLFplGy3w3/qp5XIYa1mCOk/3dvqmhySrHL9DhP/41W8njh7SQd9/aDSIV84Sq9xcM28VZc
 DXBYGtG5P4m7xCffbVC1UkZ7aS0VAfh8aAsnmq/fp2Dd96QgP/C8PUXTWkxWJ1aXOCxkaC9vv
 AIzRwL7i00ly9f0iFv0bDNCvt61fNFU9O/65NHqv0B8BaElhOK9Tirl21loIFcFKyMgh02kPk
 1bH7f9wm4gRbp/k67vEgQ4VZ1dSohrESC9iBmim6s+APlSM0mCu4mw8F9rg1bqFHcOBRfImf0
 UiiVodqFduQa/grPMpLDB8tucPqKhKqTQ5JxNRzH4xGQ2egA1xxLFk67pq0Im5XToDNGoThhc
 e+3MpFAckQbJB8WnGOG2mdHfhL/+6F8GEU7qy6M0pr8E2yuMeTxPTMUPHaava0laoVwutLIVi
 +/F9gEbTpZfghiZjLi0lg3g8Aso1gXNUJ5F4VaxoaeM2pogVH/5tCKa6YwJ+xRSNL2AGw+FGG
 r8j4QJ8Dq7U1I36SAGHpY1dL2dHoBVP5HAGKtLvoTt7WgJgtN3BKZ/OhZDLCE4Wvuve6ORaot
 HELAaZPg2466q8N1zpVbuqyvwVLOEhMGl3uFKCV+xwE3yWurCk2zpAugF9YtwHo31zvxBQvN+
 IUN4pcL6vVAFExdJkxgoki1+y7H/G6HczvI76gZ7ZSfbY=

Hi Greg

*no* regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


