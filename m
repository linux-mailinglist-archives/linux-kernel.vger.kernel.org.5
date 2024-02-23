Return-Path: <linux-kernel+bounces-78582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D61D861554
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1EEB1F229BA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE90481ACA;
	Fri, 23 Feb 2024 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SfN63mRx"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2801735EF1
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701365; cv=none; b=Z+/MVlhjerrydCpGLT0blASP0BssNvT/KMnNdBXrGHIc5WhIPAOjsoC/AD4KIIahSngbp9AVmvd0FJqoiAEw39OR4FViVMpf3X84fO0j3ILi3GCNEPi3SxLwHyYUig+evUzfHvD2AhbvLovTY9Ee9+TIokrwf4IteNplxqgQQSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701365; c=relaxed/simple;
	bh=Tk/7C/0YTR27e29H6Er4j09VZqvCFC28wPLrfFKewTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPtvnPQM0E2VAcMbAUxvwGpAOq2xgyOdkOSmJg94wQe8RXfU10uq/vXoYtEkWJTxS5EtDwnq+O8G+emu3xhaFxP5jPMN5IQ30vK+1Ub0pqv9oxOOM/qcrhNrIM+ZiA8N1f03YKepNN6cxvoPgJP4GPQ52fAn9bkP5Sfvcn8DZnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SfN63mRx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YmkF93rUPXfYFm5d0ZhuGv0+jM5ZzHqDtVrC0OiLTZ8=; b=SfN63mRxL3ZB9NisRf+U7x12zR
	CQxIPOjk1Z8MfbWDSD9PZ2osjRYdy6n3cYVIX5CqdfnvtdkzXfOqI6C5zcvIU+E9etL4/nGTOM31g
	QyhfXzm1l56dHyuMvwd9xRI7Vesw7a9nvPWZz7DQIium6KuHiiDQSsR6MM3k6vxAv1gMs1OQEoJx7
	Ev85FXWDp7VLu30JrsxUhf4Mm0g7aMmdPlS438Q7qEuK5bh6eCC+G1VI58TC/KDLrMkeVLhxzccB9
	T44eDwNFssM6TxLqGpIzk/aV102XKnVoALwKMwR19bjHNwqRaoSHbfrzNyckI1XXPDRfkNnXeyBp5
	fiGmsZVQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdXH7-00000009vxA-3Opx;
	Fri, 23 Feb 2024 15:15:59 +0000
Date: Fri, 23 Feb 2024 07:15:45 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Mukesh Ojha <quic_mojha@quicinc.com>, russ.weight@linux.dev,
	rafael@kernel.org, linux-kernel@vger.kernel.org,
	cocci@systeme.lip6.fr
Subject: Re: [PATCH vRFC 3/8] treewide: rename firmware_request_platform()
Message-ID: <Zdi2odoYPBWywOXn@bombadil.infradead.org>
References: <20240222180033.23775-1-quic_mojha@quicinc.com>
 <20240222180033.23775-4-quic_mojha@quicinc.com>
 <2024022347-ribcage-clench-37c4@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022347-ribcage-clench-37c4@gregkh>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Feb 23, 2024 at 07:21:31AM +0100, Greg KH wrote:
> On Thu, Feb 22, 2024 at 11:30:28PM +0530, Mukesh Ojha wrote:
> > Rename firmware_request_platform() to request_firmware_platform()
> > to be more concrete and align with the name of other request
> > firmware family functions.
> 
> Sorry, but no, it should be "noun_verb" for public functions.

News to me, do we have this documented somewhere?

> Yes, we mess this up a lot, but keeping the namespace this way works out
> better for global symbols, so "firmware_*" is best please.

We should certainly stick to *one* pattern, for the better, and it
occurs to me we could further review this with a coccinelle python
script for public functions, checking the first two elements of a public
function for noun and verb.

  Luis

