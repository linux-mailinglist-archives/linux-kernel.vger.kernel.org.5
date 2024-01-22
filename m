Return-Path: <linux-kernel+bounces-34159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8427E8374B7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66361C26A3C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B9647F4D;
	Mon, 22 Jan 2024 20:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXaqZLOe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F872CA8;
	Mon, 22 Jan 2024 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956993; cv=none; b=IR0e++46TcznhwWLQsHINE7wdFxw9Pucs1jWszd1ILR6sXmi3C2ubeYIwdSUaCnBzJMs92fhrWxjCNUfzjm8m6uPLAlof02zRDm7ILuO5NKbfQdhYpdB7g0adUo5vbrEpBVyVrQifKGV+pdkpQDGKtyXg0mqUTAyXFM31oUywPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956993; c=relaxed/simple;
	bh=dPyR1cD91P/4YTX71Vd3J842ddnSfDF8JMywbnzsy2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kkxik5I0xGkyWwzrm2RxS/g1jXQ6cxQcH8c/i+FR0pYcIMLobe3kzWizD9xmbzktjwGoyrHPLmkgJtAlPKTXP2M54Xl15tSLNN6zLd77uicygT5sJ+ll6ko7zRvISxXjuYh9ZXEURKyF658BrKyhUpzBuadOfn8lpoUsdALjwhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXaqZLOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180ECC433C7;
	Mon, 22 Jan 2024 20:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705956992;
	bh=dPyR1cD91P/4YTX71Vd3J842ddnSfDF8JMywbnzsy2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pXaqZLOeYkyUTzMJvz1OJv+zN9IZgBtSJVNrOmA8oqY9cnE0eSYRiJnD38PlVmwOe
	 EJvQmQ+jqm4afanYkFYr1t7Z5C4tepp1UvLA1ta3y7topcHrfe65bR1IwVDq4cpbZe
	 3hbAYShtI83DSzCkZYrqI1S/78mXDgdGooepc9lel5KJTldBo3Nm7IlehlijEAJHMw
	 St9/a535g9TGNilvgn+fCgoA8QsvrP5PwFjJ9PrY5Bw8DfIqF1v8oSSjK7yw2nK5Yu
	 c2RBEWS2ekAiA6EX4XiWttF+97bEn0Omce3DExu1yfbb60w6j2hzTzaHL7VzBiFbaH
	 GmL+3cI7YhB+Q==
Date: Mon, 22 Jan 2024 12:56:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, wg@grandegger.com,
 conor+dt@kernel.org, davem@davemloft.net, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, edumazet@google.com, pabeni@redhat.com,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Peng Fan
 <peng.fan@nxp.com>
Subject: Re: [PATCH] dt-bindings: can: fsl,flexcan: add i.MX95 compatible
 string
Message-ID: <20240122125631.4c54eba1@kernel.org>
In-Reply-To: <20240122-skilled-wimp-4bc1769bf235-mkl@pengutronix.de>
References: <20240122091738.2078746-1-peng.fan@oss.nxp.com>
	<20240122-skilled-wimp-4bc1769bf235-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 11:26:25 +0100 Marc Kleine-Budde wrote:
> > Add i.MX95 flexcan which is compatible i.MX93 flexcan
> > 
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>  
> 
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Hm, you don't apply CAN DTB patches?

