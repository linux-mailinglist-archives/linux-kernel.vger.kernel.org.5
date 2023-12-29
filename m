Return-Path: <linux-kernel+bounces-13000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB2E81FE3C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070CE2823F1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 08:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6D779D8;
	Fri, 29 Dec 2023 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aSVsw0cm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F039C7487;
	Fri, 29 Dec 2023 08:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C3FC433C7;
	Fri, 29 Dec 2023 08:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703839582;
	bh=d8KU5/kbX3Hw7buAnGYL8ZIdwzXpGB1sQb+GhG/aISc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aSVsw0cm4jXx0LOz1pmiWqmxVEHcwT75rQTtPXfx72BjhxcPapLUuJCxu9CKMvDXv
	 OAA2membqS+VDNOLivjJ5Rt+6ZJAUCQbtQGJN1fS6Ldr/VuxHilKkNgU6E28GA3Nr+
	 Y75SMQ5d62/tIPnMcWRaoHaG2IKlTFGfHjc86xsQ=
Date: Fri, 29 Dec 2023 08:46:19 +0000
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Di Shen <cindygm567@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Di Shen <di.shen@unisoc.com>,
	daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	xuewen.yan@unisoc.com, zhanglyra@gmail.com, orsonzhai@gmail.com
Subject: Re: [PATCH] thermal: core: export the governor register related API
Message-ID: <2023122922-stature-overlying-c63d@gregkh>
References: <20231228103921.23839-1-di.shen@unisoc.com>
 <CAJZ5v0jYX8QJjFzOTSWFf7PnBP+twm3Ww+9MVqwAsJrPx1fycQ@mail.gmail.com>
 <CAHYJL4p9ocr1FsM_Oc-p-H=NzfVuU3=8NYBwSV8oi+_vNuVUPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHYJL4p9ocr1FsM_Oc-p-H=NzfVuU3=8NYBwSV8oi+_vNuVUPg@mail.gmail.com>

On Fri, Dec 29, 2023 at 12:30:10PM +0800, Di Shen wrote:
> Hi Rafael,
> 
> On Fri, Dec 29, 2023 at 4:24 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Dec 28, 2023 at 11:39 AM Di Shen <di.shen@unisoc.com> wrote:
> > >
> > > To enable users to register their own thermal governor,
> >
> > Why would anyone want to do that?
> >
> 
> On Android systems, due to GKI restrictions, vendors cannot modify the
> kernel, and
> vendor-specific changes must be loaded as modules, so export this symbol so that
> vendors can load their own specific governor.

Why not get the needed changes merged upstream properly instead?  That's
why Android does not allow you to change the core kernel, they want you
to work upstream first.

Random symbol exports are not allowed without a user for obvious reasons
(and you don't want us to take these patches either.)

thanks,

greg k-h

