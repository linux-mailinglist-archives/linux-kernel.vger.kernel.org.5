Return-Path: <linux-kernel+bounces-15736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D62E82310A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9937F28653E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27B11B29A;
	Wed,  3 Jan 2024 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urkX9sn6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CAA1B28D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 16:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0062CC433C8;
	Wed,  3 Jan 2024 16:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704298211;
	bh=Qm5P5u+FGecrVhqqMzdz+iw7vI+vn9BKZtbrWre6wCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=urkX9sn6kUz8bFdy0uh4ZMGqrx343la0Iy5KW453zsqqkDwdfwvKTAbPdZt8ZTbSP
	 ZJ1+L05ehitzySMJy3rCt4jcEiaPvXsbiKIdVZHOIYSjO2tuIIFun9uFbKXyjLjqWZ
	 VFFTmWS91KkaBlWfE5AE7N2OWb0mAUnk/o5yByi5WNcKDYkypnwQasFy0rRqtNILFQ
	 Tr7Haw4ehu6NDRs+9cMXnexKzQP1Brp7jiBsy7LQfn8N1tc6L2rz4DK3O+XNrzx1KQ
	 OBB+IqflzE8V6rfxPat3FvY6P5LK1WdJ78pi7DjgEdezPuVihc6T58hvh1FHuAIeoL
	 zVb8sNJcHKHeg==
Date: Wed, 3 Jan 2024 09:10:08 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Jim.Lin" <jim.chihjung.lin@gmail.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jim.lin@siliconmotion.com, cj.chen@siliconmotion.com,
	david.yeh@siliconmotion.com, hardaway.tseng@sk.com
Subject: Re: [PATCH] nvme-pci: disable write zeroes for SK Hynix BC901
Message-ID: <ZZWG4OraobaeYZkp@kbusch-mbp.dhcp.thefacebook.com>
References: <20231128025737.53026-1-jim.lin@siliconmotion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128025737.53026-1-jim.lin@siliconmotion.com>

On Tue, Nov 28, 2023 at 10:57:37AM +0800, Jim.Lin wrote:
> SK Hynix BC901 drive write zero will cause Chromebook takes more than 20 mins to switch to developer mode
> "disable write zeroes" can fix this issue and Sk Hynix has been verified.
> 
> Signed-off-by: Jim.Lin <jim.lin@siliconmotion.com>

Thanks, applied to nvme-6.8.

