Return-Path: <linux-kernel+bounces-87160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A56AE86D070
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55EE71F2341F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7456F6CC0D;
	Thu, 29 Feb 2024 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhshOMrs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1326CBF0;
	Thu, 29 Feb 2024 17:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227367; cv=none; b=ZxRKDzSObjuRJ7HMvKABxmFS9KmDsu/+IE/WydvVRxevnIh1JFNEQSXvjORHtHfRoDCI1NziJbW5TUzMcI3CxxZDBXbN9EQgua6iTkVjn0LgnqTk8Q6cqxZsSNmq1patJQnEf12Rs9vFzSJIeeurGgzbE+dz0V9vd5FgO/IJFEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227367; c=relaxed/simple;
	bh=yyqZG85T18TQP8MsfNm4Di81wpJ8qtJqUxC8H8S0suQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=psqkW2uOCPciH2mEYP3svUeUCgqn6/atKx8I1WTPEm5ghbMmPmDK2YK3D5zlryrp3l6H80qPuWx8pCq4bCK0vxBw9ZWuziKGP/RBqaOJ2tZ/qFzyixjerUTG/BhqepKzKWNRPmFQMdmgxu1n1JaROf+64f00KPlVm9nsboaW/wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhshOMrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE8CC43390;
	Thu, 29 Feb 2024 17:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709227367;
	bh=yyqZG85T18TQP8MsfNm4Di81wpJ8qtJqUxC8H8S0suQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IhshOMrsNVYqzYZh9W2peOb1LTys/ugpeqXND7C9Q7EENpo8v8IQzgTZ4jdoDznk+
	 YF1zgOOFNvbDZVJvhujhr/WEFgienq0Ay74Yh0SqRtYqVQf7G0nc9/vtQpPHUOyVDz
	 kbTWrSVhWOQSr4yzC2Jx67Bq/B03usgNnpQui6/RGvuUE/56wPMjKqrDBhfB+ve4x6
	 AjzhriCaRzMPCIPFijGB0llXm4z44Ao+DpcQy/yAoqCAL0KR5T9e8DiPjye/VC6al3
	 XshPUARJ2rXu+X9PUQesHgNeX6Guy72mdgHNpE5BnDO74Uw7Twy5dwXhV/pV5MDdJi
	 qwWYOql2uWLYQ==
From: Lee Jones <lee@kernel.org>
To: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20240223203010.881065-1-andriy.shevchenko@linux.intel.com>
References: <20240223203010.881065-1-andriy.shevchenko@linux.intel.com>
Subject: Re: (subset) [PATCH v2 1/1] leds: expresswire: Don't use "proxy"
 headers
Message-Id: <170922736619.1614411.13819632437202296097.b4-ty@kernel.org>
Date: Thu, 29 Feb 2024 17:22:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Fri, 23 Feb 2024 22:30:00 +0200, Andy Shevchenko wrote:
> Update header inclusions to follow IWYU (Include What You Use)
> principle.
> 
> 

Applied, thanks!

[1/1] leds: expresswire: Don't use "proxy" headers
      commit: 8471d8737e3b4915ba0802985427364cd286ca5b

--
Lee Jones [李琼斯]


