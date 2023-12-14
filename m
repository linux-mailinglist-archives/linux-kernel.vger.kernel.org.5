Return-Path: <linux-kernel+bounces-176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FC5813D16
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6297A2836BC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB8E6720E;
	Thu, 14 Dec 2023 22:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzPXYpZ9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D7C671E8;
	Thu, 14 Dec 2023 22:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC013C433C7;
	Thu, 14 Dec 2023 22:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702592083;
	bh=VkYO4gSpPkcgoHfoSAk4eG5D22N+fu0QJulY8XPIfiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pzPXYpZ9mpmimQtq/lSM0iXgShNzjcjTKHytOruVvKTy/TJb7YSQowxiFNw7nYtpy
	 j9m2/hm5TIXE/OMLBI8sAm0nbr80Oowf1i1lmHzQ85DUvWPph0BfZv8P+805l4GjGO
	 pQPDc0yZER53NwvnmuTrXjWbGRGWEnUMcWYdmLto+UguXhTzpi7/p56JhXucn5KWu4
	 BkD4yBGGFlc7JX6yP772dAg5uWgjtxICUNtqhw/JZD6GiaCFepjbZXavSxA4uwWZEj
	 LyOw1fqdwVlKnfgXzvv2dTecXj6FBGvGwoMZOTAHyEEd+OQh2U95n9YmkIOFHwFueY
	 4+VjQt3VFPbZA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 70430403EF; Thu, 14 Dec 2023 19:14:40 -0300 (-03)
Date: Thu, 14 Dec 2023 19:14:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: kan.liang@linux.intel.com
Cc: irogers@google.com, namhyung@kernel.org, mark.rutland@arm.com,
	maz@kernel.org, marcan@marcan.st, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V4 2/2] perf top: Uniform the event name for the hybrid
 machine
Message-ID: <ZXt-UC-gkFPQofza@kernel.org>
References: <20231214144612.1092028-1-kan.liang@linux.intel.com>
 <20231214144612.1092028-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214144612.1092028-2-kan.liang@linux.intel.com>
X-Url: http://acmel.wordpress.com

Em Thu, Dec 14, 2023 at 06:46:12AM -0800, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> It's hard to distinguish the default cycles events among hybrid PMUs.
> For example,
> 
>  $perf top
> Available samples
> 385 cycles:P
> 903 cycles:P

Thanks, tested and applied both patches to perf-tools-next.


Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

