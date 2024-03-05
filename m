Return-Path: <linux-kernel+bounces-92036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8EE871A0C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF461C20B94
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BB253816;
	Tue,  5 Mar 2024 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEH+IJAC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0C34CB58;
	Tue,  5 Mar 2024 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709632553; cv=none; b=SXHFzjRCS6T+AQYQJse55JBjLtWJUkRAm9tCfyl3b56Yx9RsFdVcqGmX5jk8Juu9GAk1xtaSon3BcN7Y9Hu1NsbWVt/Pvk7O6nGL/csu2ZALBUSHryMlQR+iNNYQot6b4cprYQwqSjCZnr9de4J5QZJ3mCVdiQdwHuCfHnlZEsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709632553; c=relaxed/simple;
	bh=8QOCvvqcYYOknPwZ2hdAD2zEI/W+yJ2bHi3Ct5K96gU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wv1vXQ3donnUOojbJv51gTrg7D7Bk6rtiQwoYV1Mb82WDjfOMDpspTMMB+6Cd8IlD1YFHJ0rqTR7WbJYSwpPMSdDfriPX34o7UdACdERfY/F6zbMbey26eOiR/+1cnic1+kA7O0BGbbhlGo2aiqB/VnJ2VgPMYQqGO8CvfP770I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEH+IJAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3974C43390;
	Tue,  5 Mar 2024 09:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709632553;
	bh=8QOCvvqcYYOknPwZ2hdAD2zEI/W+yJ2bHi3Ct5K96gU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kEH+IJACYn7z7DdwcwODN4NKj3yQmt6a/JZfj754KcZrTan9QrpMQ/f06GVAJ/FLo
	 SpgE7nZUJ+7krHc3UiQNWPawnViX7tB+IM7NG2n52etDZHwodZORyKhR2Xg86C5MfQ
	 68PVOetllV8yyRS6WxLxbTP2AjwOnnWM1gOmcHnpi+2XsnaFZC6JWuluIZOJVI5Md+
	 +/oX7iCneGzD7HUftqAUtJfKAHIrJZjYmj3QU71rJCbUHNzIyOPZ2w4lp9qDLC8aDD
	 CwB20r8L737xkraVaDEQxHCfQHy1d7lMQ8LoGl0o5ZuQR1s+YwqQ3HDB3Bgc00ugH9
	 OoeJdIf9oR4DQ==
Message-ID: <c0287c24-90b3-4f2e-b00d-7bd213ad1272@kernel.org>
Date: Tue, 5 Mar 2024 11:55:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memory: omap-gpmc: fixup wrongly hierarchy of the
 sub-devices
Content-Language: en-US
To: Brock Zheng <yzheng@techyauld.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, Tony Lindgren <tony@atomide.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <6fftq2zlkpaf7xptyff6ky63cinr76ziyvdbm5jhj2apubr5vf@l4gvbdax3l2e>
 <f45b3195-38a9-4c49-b873-01e5a0b275a3@kernel.org>
 <20240301133809.0d26865e@aktux>
 <f59c9450-2784-46fa-afc9-4f194055cb24@kernel.org>
 <laqqencookmgwesfaetd5xw5wfmjdffmjvyjitapfehmu7zy5y@k7gsdexf3jcv>
 <beacb55c-951b-4177-83ab-94fda44cd2b7@kernel.org>
 <yxefg4ie4vxblxvr272jvzncxvj2t6xjfuisvmkt2jk663xgsu@o2ogbyepmg3z>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <yxefg4ie4vxblxvr272jvzncxvj2t6xjfuisvmkt2jk663xgsu@o2ogbyepmg3z>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 03/03/2024 10:18, Brock Zheng wrote:
> On TI-AM335x，FPGA under GPMC local-bus can not work on 6.x kernel.
> 
> GPMC <--> FPGA  <--> sub-devices....
> 
> I found that the platform sub-devices are in wrongly organized
> hierarchy.  The grandchildren are now under the GPMC device directly,
> not under it's father(FPGA).
> 
> Signed-off-by: Brock.Zheng <yzheng@techyauld.com>

Acked-by: Roger Quadros <rogerq@kernel.org>

