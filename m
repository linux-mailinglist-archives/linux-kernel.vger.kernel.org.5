Return-Path: <linux-kernel+bounces-41123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA0583EC2D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 10:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80B30B21F77
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 09:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B601E874;
	Sat, 27 Jan 2024 09:00:35 +0000 (UTC)
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515F07F;
	Sat, 27 Jan 2024 09:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.239.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706346034; cv=none; b=dofGgdGrnEJ8+XiwE3YVd5AgC0QcU7pJ21olsrJSq/spaztgwwqCQJUhuDrMUVWndNCnKib1YaQzYW0li99tgv8sbciRYC5aUQNhZzY2y7AzsI1lBV17wf36PgAO+0pSe1dwB4hZ/gHNSLp0+Oh8TaSBfhYQrVxCtnbgpn4xQW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706346034; c=relaxed/simple;
	bh=MTcmCQpu8tFv5u/b7S3uCF52aneP6XDxxhzrgLd62ZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=js+mbm5MZTQH5MBBJB3ITuCwXi6vGf3uWzU2wOkPVYHves6Uh8+J6F0Th9MayKXOmclxyCEPBn9JJP0A1ubjG08bvd5ModQmNeovUshVbY+2Hi9krrmv1HW1sQXqOmfG1U7aItVgJD1d4bFZwUr454ScfM5eVJgcAsnkpaxnU+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.239.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 80F7E1015FF;
	Sat, 27 Jan 2024 09:00:28 +0000 (UTC)
Message-ID: <9a51083e-f22d-4bbf-8a16-441becfdf00a@enpas.org>
Date: Sat, 27 Jan 2024 18:00:25 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/7] HID: playstation: DS4: Parse minimal report 0x01
Content-Language: en-US
To: Roderick Colenbrander <thunderbird2k@gmail.com>
Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>,
 Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240115144538.12018-1-max@enpas.org>
 <20240115144538.12018-6-max@enpas.org>
 <CAEc3jaCYWpXX=YgeNzXJd0Pg4yn4WKqL=GBSAzaWNzo=3RSw1A@mail.gmail.com>
From: Max Staudt <max@enpas.org>
In-Reply-To: <CAEc3jaCYWpXX=YgeNzXJd0Pg4yn4WKqL=GBSAzaWNzo=3RSw1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/25/24 09:54, Roderick Colenbrander wrote:
> I would say let's turn this into a 'return 0'. The goto is not useful
> since there is no need for any common cleanup or some other common
> logic later.

Oops, that one slipped through the cracks.

Thank you, will do!


Max


