Return-Path: <linux-kernel+bounces-128124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A50895670
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F565281984
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9CC86256;
	Tue,  2 Apr 2024 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KO/QafPZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF715466B;
	Tue,  2 Apr 2024 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712067344; cv=none; b=tXeL2npwM6u34kO99UTJ28TMtPGGaSQEXjNg0UTlqiM/BXlNg+9GPnFUkAhm7LZSHbaKe9ZSlXUxwB41haOIZKS/WW1F+zj3kGPJV7X1RQFAFRTsON+XmEZsbSC7f+e9loK3xOMx/jw1XqUU08kg+KLpx1tB6ZqxTfltKRs1+cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712067344; c=relaxed/simple;
	bh=sbYazsKKN5kTZVYKq6GW0TgtIVkFiH103lUsX/dhj8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1XfySHqbJDZG0Ea4dLIzFUXVA8fwE2KgiWWeGqtvoXF8gTPUZD1FVOhKbC3pb9VX9Rl9p2AR8E0hfd+efCUpQ2gC2+pr2evTawep3n1i+iRi8FoCdVlkYhbO5r1hv/HrEp80tIsG5/GpiDX6zoZUpuKJXU53HUvMpt2uob0iG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KO/QafPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCC8C433C7;
	Tue,  2 Apr 2024 14:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712067343;
	bh=sbYazsKKN5kTZVYKq6GW0TgtIVkFiH103lUsX/dhj8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KO/QafPZLV8ZKkpPD5nBFGvdGyBoTJO86GJV6tfw+ukNGCFSPRp/mb+9mkl+9CBbW
	 XRngbBskgZKwRQr+KSg9xw9JgH5sDui2i5gbDDo60WjuCOqwbmuMonCS/7xdIh6XDb
	 Bi5z6ATb/hDSqAObgs9B09wQf4lecV2M0il7JuLI=
Date: Tue, 2 Apr 2024 10:15:39 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/3] media: i2c: Add imx283 camera sensor driver
Message-ID: <20240402-provocative-placid-mantis-7ce75c@lemur>
References: <20240402-kernel-name-extraversion-v1-0-57bb38de841b@ideasonboard.com>
 <d46380d7-e296-445b-a294-b0231ea45518@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d46380d7-e296-445b-a294-b0231ea45518@ideasonboard.com>

On Tue, Apr 02, 2024 at 02:01:19PM +0530, Umang Jain wrote:
> Hi all,
> 
> PLease ignore the series, I was testing/learning the b4 tool.
> 
> I did pass --offline-mode but it has sent the patches anyway :-//

Hm... I see why this would be confusing and I will try to fix this.

(the --offline-mode flag is to prevent b4 from querying lore.kernel.org, but
it should also bubble up to other functionality that calls remote services,
like b4 send).

-K

